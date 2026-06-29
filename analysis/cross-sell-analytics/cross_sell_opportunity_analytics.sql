-- ============================================================
-- CROSS-SELL OPPORTUNITY ANALYTICS
-- "If Contract A does it, why isn't Contract B?"
-- ============================================================
-- Purpose  : Identify service scope gaps across Ventia contracts
--            to surface bid expansion and cross-sell opportunities
-- Date     : 2026-06-29
-- ============================================================
--
-- HOW TO USE
--   HIGH-LEVEL queries (H1–H4) power the overview dashboard.
--   DRILL-DOWN queries (D1–D5) activate when a user clicks an
--   opportunity row. Replace the placeholder strings marked with
--   [TARGET] and [ACTIVITY] to filter to a specific opportunity.
--   CREATIVE queries (C1–C3) add strategic context.
--
-- ============================================================
-- TABLE USAGE GUIDE
-- ============================================================
--
--  vw_silver_transport_asset_with_category
--    → Asset dimension. Use to establish WHAT ASSETS each contract
--      manages (asset_category, standardised_asset_type_name,
--      asset_condition, asset_criticality). This is the left spine
--      of every opportunity gap query — it tells you "this contract
--      HAS these assets, so these services COULD apply."
--    → Key cols: standardised_contract_name, asset_category,
--                standardised_asset_type_name, asset_id,
--                asset_condition, asset_criticality, source_context
--
--  vw_bronze_transport_job_base
--    → Job facts. Use to establish WHAT WORK IS BEING DONE and at
--      what cost/volume. The activity_category_name + activity_name
--      columns define the service scope. estimated_cost approximates
--      opportunity value per job.
--    → Key cols: job_id, source_context, activity_category_name,
--                activity_name, activity_type, completed_date,
--                due_date, compliant, priority, hazard_defect_code
--
--  vw_silver_transport_job_asset_link
--    → Bridge table. Always join jobs to assets through this.
--      Handles many-to-many (one job on multiple assets, one asset
--      with multiple jobs). Without this, job counts are inflated.
--    → Key cols: source_context, job_id, asset_id
--
--  vw_bronze_transport_inspection_base
--    → Inspection facts. Use to find where inspections exist WITHOUT
--      corresponding maintenance jobs — a specific gap pattern that
--      signals under-scoped contracts (inspect-only, no fix mandate).
--    → Key cols: inspection_id, source_context, asset_id,
--                inspection_type_name, scheduled_date, completed_date,
--                job_id (null when inspection did not trigger a job)
--
--  vw_silver_transport_inspection_asset_link
--    → Bridge table for inspections. Same role as job_asset_link.
--    → Key cols: source_context, inspection_id, asset_id
--
--  vw_silver_transport_timesheet_asset_link
--    → Actual labor. Use for OPPORTUNITY SIZING — this is the most
--      accurate cost signal (what Ventia actually spent doing this
--      activity). Extrapolate peer actuals to estimate revenue in
--      the gap contract.
--    → Key cols: source_context, asset_id, actual_hours,
--                actual_minutes, actual_cost, start_date, resource_type
--
--  vw_silver_transport_planned_resource_asset_link
--    → Planned labor and cost. Use as a forward-looking complement
--      to timesheet actuals. Planned cost = what the contract
--      expects to spend, actuals = what was delivered.
--    → Key cols: source_context, asset_id, planned_cost,
--                planned_hours, planned_minutes, start_date
--
--  vw_bronze_transport_capitalwork_base
--    → Capital works. Use to find contracts where assets are
--      deteriorating (low capital works) vs peers actively
--      investing. Gap in capital works = potential renewals pitch.
--    → Key cols: source_context, capitalwork_id, asset_id,
--                planned_start, actual_finish
--
-- ============================================================
-- INDEX
--   HIGH-LEVEL (dashboard overview)
--     H1 : Activity gap matrix — what each contract is missing vs peers
--     H2 : Opportunity score leaderboard — rank contracts by gap size
--     H3 : Portfolio similarity — match contracts to their best peer
--     H4 : Job intensity benchmark — under-serviced vs benchmark rate
--
--   DRILL-DOWN (activated on row click, parameterised by [TARGET])
--     D1 : Gap evidence — which peers do it & how much?
--     D2 : Opportunity sizing — estimated jobs & cost in gap
--     D3 : Asset risk profile — condition & criticality of gap assets
--     D4 : Inspect-without-maintain gap — inspect scope with no fix mandate
--     D5 : Capital works uplift — renewal/capital opportunity vs peers
--
--   CREATIVE / STRATEGIC
--     C1 : Activity breadth index — contracts with narrow scope (most to sell)
--     C2 : Specialist service penetration — high-value services not deployed
--     C3 : Client cross-pollination — what Ventia does for one govt client
--          that a comparable client doesn't yet have
-- ============================================================


-- ============================================================
-- SHARED FOUNDATION CTEs
-- These are reused across multiple queries below.
-- In Databricks, paste them before any query that references them.
-- ============================================================

-- FOUNDATION A: What assets does each contract manage?
-- (asset_category level — broad enough for cross-contract comparison)

-- WITH CONTRACT_ASSET_PRESENCE AS (
--     SELECT
--         source_context,
--         standardised_contract_name,
--         asset_category,
--         COUNT(DISTINCT asset_id) AS asset_count
--     FROM transport_dev.integ_transport_assets.vw_silver_transport_asset_with_category
--     WHERE standardised_contract_name IS NOT NULL
--       AND asset_category IS NOT NULL
--       AND asset_category != 'Other / Unclassified'
--     GROUP BY source_context, standardised_contract_name, asset_category
-- ),

-- FOUNDATION B: What (asset_category × activity_category) is each contract executing?
-- (job must be completed in last 3 years to count as "in scope")

-- WITH CONTRACT_ACTIVITY_SCOPE AS (
--     SELECT DISTINCT
--         A.source_context,
--         A.standardised_contract_name,
--         A.asset_category,
--         J.activity_category_name
--     FROM transport_dev.integ_transport_assets.vw_silver_transport_asset_with_category A
--     INNER JOIN transport_dev.integ_transport_assets.vw_silver_transport_job_asset_link JL
--         ON A.source_context = JL.source_context AND A.asset_id = JL.asset_id
--     INNER JOIN transport_dev.integ_transport_assets.vw_bronze_transport_job_base J
--         ON JL.source_context = J.source_context AND JL.job_id = J.job_id
--     WHERE A.standardised_contract_name IS NOT NULL
--       AND A.asset_category IS NOT NULL
--       AND J.activity_category_name IS NOT NULL
--       AND J.completed_date >= DATE_ADD(current_date(), -1095)  -- last 3 years
-- )


-- ============================================================
-- H1: Activity Gap Matrix
-- ============================================================
-- What it shows: For every (contract, asset_category) combination,
--   which activity categories are being done by peer contracts but
--   NOT by this contract? Each row is one cross-sell opportunity.
-- Dashboard use: Heatmap — rows = target contract, columns =
--   activity category, cell colour = # of peers doing it.
--   Grey = already doing it. Colour intensity = opportunity strength.
-- Filter controls: Asset category picker, min peer threshold slider.
-- ============================================================

WITH CONTRACT_ASSET_PRESENCE AS (
    SELECT
        source_context,
        standardised_contract_name,
        asset_category,
        COUNT(DISTINCT asset_id) AS asset_count
    FROM transport_dev.integ_transport_assets.vw_silver_transport_asset_with_category
    WHERE standardised_contract_name IS NOT NULL
      AND asset_category IS NOT NULL
      AND asset_category != 'Other / Unclassified'
    GROUP BY source_context, standardised_contract_name, asset_category
),
CONTRACT_ACTIVITY_SCOPE AS (
    SELECT DISTINCT
        A.source_context,
        A.standardised_contract_name,
        A.asset_category,
        J.activity_category_name
    FROM transport_dev.integ_transport_assets.vw_silver_transport_asset_with_category A
    INNER JOIN transport_dev.integ_transport_assets.vw_silver_transport_job_asset_link JL
        ON A.source_context = JL.source_context AND A.asset_id = JL.asset_id
    INNER JOIN transport_dev.integ_transport_assets.vw_bronze_transport_job_base J
        ON JL.source_context = J.source_context AND JL.job_id = J.job_id
    WHERE A.standardised_contract_name IS NOT NULL
      AND A.asset_category IS NOT NULL
      AND J.activity_category_name IS NOT NULL
      AND J.completed_date >= DATE_ADD(current_date(), -1095)
),
-- All activity categories ever observed on each asset category (the universe of possible scope)
UNIVERSE AS (
    SELECT DISTINCT asset_category, activity_category_name
    FROM CONTRACT_ACTIVITY_SCOPE
),
-- Peer contracts doing each (asset_category × activity_category) — excludes the target itself
PEER_EVIDENCE AS (
    SELECT
        CAP.standardised_contract_name  AS target_contract,
        CAP.asset_category,
        U.activity_category_name,
        CAP.asset_count                 AS target_asset_count,
        COUNT(DISTINCT CAS.standardised_contract_name) AS peer_contracts_doing_it
    FROM CONTRACT_ASSET_PRESENCE CAP
    INNER JOIN UNIVERSE U
        ON CAP.asset_category = U.asset_category
    INNER JOIN CONTRACT_ACTIVITY_SCOPE CAS
        ON CAS.asset_category          = U.asset_category
       AND CAS.activity_category_name  = U.activity_category_name
       AND CAS.standardised_contract_name != CAP.standardised_contract_name
    -- Anti-join: exclude combinations this contract already performs
    LEFT JOIN CONTRACT_ACTIVITY_SCOPE SELF
        ON SELF.standardised_contract_name = CAP.standardised_contract_name
       AND SELF.asset_category             = U.asset_category
       AND SELF.activity_category_name     = U.activity_category_name
    WHERE SELF.standardised_contract_name IS NULL  -- gap confirmed
    GROUP BY
        CAP.standardised_contract_name,
        CAP.asset_category,
        U.activity_category_name,
        CAP.asset_count
)
SELECT
    target_contract,
    asset_category,
    activity_category_name,
    target_asset_count,
    peer_contracts_doing_it,
    -- Opportunity signal: more peers + more assets = stronger signal
    ROUND(CAST(peer_contracts_doing_it AS DOUBLE) * LOG(target_asset_count + 1), 2) AS opportunity_signal_score
FROM PEER_EVIDENCE
WHERE peer_contracts_doing_it >= 2  -- at least 2 peers validate this is real scope
ORDER BY opportunity_signal_score DESC, target_contract, asset_category;


-- ============================================================
-- H2: Contract Opportunity Score Leaderboard
-- ============================================================
-- What it shows: Ranks each contract by total cross-sell opportunity,
--   weighted by (peer validation × asset count). Top = most to sell.
-- Dashboard use: Bar chart or ranked table as the entry point.
--   Clicking a row drills to H1 filtered to that contract.
-- ============================================================

WITH CONTRACT_ASSET_PRESENCE AS (
    SELECT
        source_context,
        standardised_contract_name,
        asset_category,
        COUNT(DISTINCT asset_id) AS asset_count
    FROM transport_dev.integ_transport_assets.vw_silver_transport_asset_with_category
    WHERE standardised_contract_name IS NOT NULL
      AND asset_category IS NOT NULL
      AND asset_category != 'Other / Unclassified'
    GROUP BY source_context, standardised_contract_name, asset_category
),
CONTRACT_ACTIVITY_SCOPE AS (
    SELECT DISTINCT
        A.source_context,
        A.standardised_contract_name,
        A.asset_category,
        J.activity_category_name
    FROM transport_dev.integ_transport_assets.vw_silver_transport_asset_with_category A
    INNER JOIN transport_dev.integ_transport_assets.vw_silver_transport_job_asset_link JL
        ON A.source_context = JL.source_context AND A.asset_id = JL.asset_id
    INNER JOIN transport_dev.integ_transport_assets.vw_bronze_transport_job_base J
        ON JL.source_context = J.source_context AND JL.job_id = J.job_id
    WHERE A.standardised_contract_name IS NOT NULL
      AND A.asset_category IS NOT NULL
      AND J.activity_category_name IS NOT NULL
      AND J.completed_date >= DATE_ADD(current_date(), -1095)
),
UNIVERSE AS (
    SELECT DISTINCT asset_category, activity_category_name
    FROM CONTRACT_ACTIVITY_SCOPE
),
GAPS AS (
    SELECT
        CAP.standardised_contract_name  AS target_contract,
        CAP.asset_category,
        U.activity_category_name,
        CAP.asset_count,
        COUNT(DISTINCT CAS.standardised_contract_name) AS peers_doing_it
    FROM CONTRACT_ASSET_PRESENCE CAP
    INNER JOIN UNIVERSE U ON CAP.asset_category = U.asset_category
    INNER JOIN CONTRACT_ACTIVITY_SCOPE CAS
        ON CAS.asset_category = U.asset_category
       AND CAS.activity_category_name = U.activity_category_name
       AND CAS.standardised_contract_name != CAP.standardised_contract_name
    LEFT JOIN CONTRACT_ACTIVITY_SCOPE SELF
        ON SELF.standardised_contract_name = CAP.standardised_contract_name
       AND SELF.asset_category = U.asset_category
       AND SELF.activity_category_name = U.activity_category_name
    WHERE SELF.standardised_contract_name IS NULL
    GROUP BY CAP.standardised_contract_name, CAP.asset_category, U.activity_category_name, CAP.asset_count
    HAVING COUNT(DISTINCT CAS.standardised_contract_name) >= 2
)
SELECT
    target_contract,
    COUNT(DISTINCT CONCAT(asset_category, '|', activity_category_name)) AS total_gap_combinations,
    COUNT(DISTINCT asset_category)                                        AS asset_categories_with_gaps,
    SUM(asset_count)                                                      AS total_gap_asset_exposure,
    ROUND(SUM(CAST(peers_doing_it AS DOUBLE) * LOG(asset_count + 1)), 0) AS total_opportunity_score,
    -- Breakdown by gap confidence tier
    COUNT(DISTINCT CASE WHEN peers_doing_it >= 4 THEN CONCAT(asset_category, '|', activity_category_name) END) AS high_confidence_gaps,
    COUNT(DISTINCT CASE WHEN peers_doing_it  = 3 THEN CONCAT(asset_category, '|', activity_category_name) END) AS medium_confidence_gaps,
    COUNT(DISTINCT CASE WHEN peers_doing_it  = 2 THEN CONCAT(asset_category, '|', activity_category_name) END) AS low_confidence_gaps
FROM GAPS
GROUP BY target_contract
ORDER BY total_opportunity_score DESC;


-- ============================================================
-- H3: Portfolio Similarity — Peer Matching
-- ============================================================
-- What it shows: For each contract pair, what % of asset categories
--   do they share? High similarity = best peer benchmark.
--   Use to validate "if Contract A does it, Contract B should too"
--   claims — only valid if they manage similar assets.
-- Dashboard use: Similarity matrix (heatmap of contract × contract).
--   Filter to show only pairs with > 50% similarity.
--   Use the top-N similar peers in D1/D2 drill-downs.
-- ============================================================

WITH CONTRACT_CATEGORIES AS (
    SELECT DISTINCT
        standardised_contract_name,
        asset_category
    FROM transport_dev.integ_transport_assets.vw_silver_transport_asset_with_category
    WHERE standardised_contract_name IS NOT NULL
      AND asset_category IS NOT NULL
      AND asset_category != 'Other / Unclassified'
),
PAIRS AS (
    SELECT
        A.standardised_contract_name AS contract_a,
        B.standardised_contract_name AS contract_b,
        COUNT(DISTINCT CASE WHEN A.asset_category = B.asset_category
                            THEN A.asset_category END)  AS shared_categories,
        COUNT(DISTINCT A.asset_category)                AS a_total_categories,
        COUNT(DISTINCT B.asset_category)                AS b_total_categories
    FROM CONTRACT_CATEGORIES A
    CROSS JOIN CONTRACT_CATEGORIES B
    WHERE A.standardised_contract_name < B.standardised_contract_name  -- avoid duplicates
    GROUP BY A.standardised_contract_name, B.standardised_contract_name
)
SELECT
    contract_a,
    contract_b,
    shared_categories,
    a_total_categories,
    b_total_categories,
    -- Jaccard similarity: shared / union
    ROUND(
        100.0 * shared_categories
        / NULLIF(a_total_categories + b_total_categories - shared_categories, 0), 1
    )                                     AS jaccard_similarity_pct,
    -- Overlap from A's perspective: how much of A's portfolio exists in B?
    ROUND(100.0 * shared_categories / NULLIF(a_total_categories, 0), 1) AS a_coverage_in_b_pct,
    -- Overlap from B's perspective
    ROUND(100.0 * shared_categories / NULLIF(b_total_categories, 0), 1) AS b_coverage_in_a_pct
FROM PAIRS
WHERE shared_categories >= 3   -- at least 3 shared asset categories to be meaningful
ORDER BY jaccard_similarity_pct DESC;


-- ============================================================
-- H4: Job Intensity Benchmark — Under-Serviced Contracts
-- ============================================================
-- What it shows: Jobs per asset per year for each
--   (contract × asset_category × activity_category). Contracts
--   below 50% of the median benchmark are flagged as under-serviced.
-- Dashboard use: Table with RAG status (red = <50% of benchmark,
--   amber = 50-80%, green = at or above benchmark). Sort by the
--   contracts furthest below benchmark.
-- ============================================================

WITH CONTRACT_JOB_RATE AS (
    SELECT
        A.standardised_contract_name,
        A.asset_category,
        J.activity_category_name,
        COUNT(DISTINCT A.asset_id)                                          AS asset_count,
        COUNT(DISTINCT CONCAT(J.source_context, '|', JL.job_id))            AS job_count,
        -- Annualised rate: jobs per asset per year over the last 3 years
        ROUND(
            COUNT(DISTINCT CONCAT(J.source_context, '|', JL.job_id))
            / NULLIF(COUNT(DISTINCT A.asset_id), 0)
            / 3.0, 3
        )                                                                   AS jobs_per_asset_per_year
    FROM transport_dev.integ_transport_assets.vw_silver_transport_asset_with_category A
    INNER JOIN transport_dev.integ_transport_assets.vw_silver_transport_job_asset_link JL
        ON A.source_context = JL.source_context AND A.asset_id = JL.asset_id
    INNER JOIN transport_dev.integ_transport_assets.vw_bronze_transport_job_base J
        ON JL.source_context = J.source_context AND JL.job_id = J.job_id
    WHERE A.standardised_contract_name IS NOT NULL
      AND A.asset_category IS NOT NULL
      AND J.activity_category_name IS NOT NULL
      AND J.completed_date >= DATE_ADD(current_date(), -1095)
    GROUP BY A.standardised_contract_name, A.asset_category, J.activity_category_name
),
WITH_BENCHMARK AS (
    SELECT *,
        ROUND(PERCENTILE_APPROX(jobs_per_asset_per_year, 0.5)
              OVER (PARTITION BY asset_category, activity_category_name), 3) AS benchmark_median,
        ROUND(PERCENTILE_APPROX(jobs_per_asset_per_year, 0.75)
              OVER (PARTITION BY asset_category, activity_category_name), 3) AS benchmark_p75,
        COUNT(*) OVER (PARTITION BY asset_category, activity_category_name) AS contracts_with_this_activity
    FROM CONTRACT_JOB_RATE
)
SELECT
    standardised_contract_name,
    asset_category,
    activity_category_name,
    asset_count,
    job_count,
    jobs_per_asset_per_year,
    benchmark_median,
    benchmark_p75,
    contracts_with_this_activity,
    ROUND(100.0 * jobs_per_asset_per_year / NULLIF(benchmark_median, 0), 1) AS pct_of_benchmark,
    CASE
        WHEN jobs_per_asset_per_year < benchmark_median * 0.5  THEN 'Under-serviced (RED)'
        WHEN jobs_per_asset_per_year < benchmark_median * 0.8  THEN 'Below benchmark (AMBER)'
        WHEN jobs_per_asset_per_year <= benchmark_median * 1.2 THEN 'At benchmark (GREEN)'
        ELSE 'Above benchmark'
    END                                                                      AS benchmark_status
FROM WITH_BENCHMARK
WHERE contracts_with_this_activity >= 3  -- benchmark is meaningful with 3+ peers
ORDER BY pct_of_benchmark ASC;  -- worst performers first


-- ============================================================
-- D1: Gap Detail with Peer Evidence
-- ============================================================
-- What it shows: For a specific gap (target contract + asset category
--   + activity category), lists WHICH peer contracts do it, how many
--   jobs they run, and the actual hours/cost they spend on it.
--   This is your pitch evidence: "Contract X is doing Y, here's proof."
-- Dashboard use: Detail panel triggered by clicking a gap row in H1.
--   Shows as a table with peer contract name, job volume, and cost.
-- Parameterise: Replace the three [TARGET] placeholders below.
-- ============================================================

-- Set these parameters before running:
-- [TARGET_CONTRACT]  = the contract you want to pitch to
-- [TARGET_CATEGORY]  = the asset_category of the gap
-- [TARGET_ACTIVITY]  = the activity_category_name of the gap

WITH GAP_PEERS AS (
    SELECT DISTINCT
        A.standardised_contract_name    AS peer_contract,
        A.asset_category,
        J.activity_category_name
    FROM transport_dev.integ_transport_assets.vw_silver_transport_asset_with_category A
    INNER JOIN transport_dev.integ_transport_assets.vw_silver_transport_job_asset_link JL
        ON A.source_context = JL.source_context AND A.asset_id = JL.asset_id
    INNER JOIN transport_dev.integ_transport_assets.vw_bronze_transport_job_base J
        ON JL.source_context = J.source_context AND JL.job_id = J.job_id
    WHERE A.asset_category         = '[TARGET_CATEGORY]'    -- e.g. 'Drainage / Stormwater'
      AND J.activity_category_name = '[TARGET_ACTIVITY]'    -- e.g. 'Cleaning and Clearing'
      AND A.standardised_contract_name != '[TARGET_CONTRACT]'
      AND J.completed_date >= DATE_ADD(current_date(), -1095)
),
TARGET_ASSETS AS (
    SELECT COUNT(DISTINCT asset_id) AS target_asset_count
    FROM transport_dev.integ_transport_assets.vw_silver_transport_asset_with_category
    WHERE standardised_contract_name = '[TARGET_CONTRACT]'
      AND asset_category = '[TARGET_CATEGORY]'
)
SELECT
    P.peer_contract,
    COUNT(DISTINCT CONCAT(J.source_context, '|', JL.job_id))              AS job_count_3yr,
    COUNT(DISTINCT A.asset_id)                                             AS peer_asset_count,
    ROUND(
        COUNT(DISTINCT CONCAT(J.source_context, '|', JL.job_id))
        / NULLIF(COUNT(DISTINCT A.asset_id), 0) / 3.0, 2
    )                                                                       AS jobs_per_asset_per_year,
    ROUND(SUM(COALESCE(TS.actual_hours, 0) + COALESCE(TS.actual_minutes, 0) / 60.0), 0) AS actual_hours_3yr,
    ROUND(SUM(COALESCE(TS.actual_cost, 0)), 0)                             AS actual_cost_3yr,
    -- Target potential: peer's rate × target asset count
    ROUND(
        COUNT(DISTINCT CONCAT(J.source_context, '|', JL.job_id))
        / NULLIF(COUNT(DISTINCT A.asset_id), 0)
        / 3.0
        * (SELECT target_asset_count FROM TARGET_ASSETS), 1
    )                                                                       AS est_jobs_for_target,
    (SELECT target_asset_count FROM TARGET_ASSETS)                         AS target_asset_count
FROM GAP_PEERS P
INNER JOIN transport_dev.integ_transport_assets.vw_silver_transport_asset_with_category A
    ON A.standardised_contract_name = P.peer_contract
   AND A.asset_category = P.asset_category
INNER JOIN transport_dev.integ_transport_assets.vw_silver_transport_job_asset_link JL
    ON A.source_context = JL.source_context AND A.asset_id = JL.asset_id
INNER JOIN transport_dev.integ_transport_assets.vw_bronze_transport_job_base J
    ON JL.source_context = J.source_context AND JL.job_id = J.job_id
   AND J.activity_category_name = '[TARGET_ACTIVITY]'
   AND J.completed_date >= DATE_ADD(current_date(), -1095)
LEFT JOIN transport_dev.integ_transport_assets.vw_silver_transport_timesheet_asset_link TS
    ON A.source_context = TS.source_context AND A.asset_id = TS.asset_id
   AND TS.start_date >= DATE_ADD(current_date(), -1095)
GROUP BY P.peer_contract
ORDER BY actual_cost_3yr DESC;


-- ============================================================
-- D2: Opportunity Sizing — Estimated Jobs & Cost
-- ============================================================
-- What it shows: For a target contract, takes the median peer job
--   rate and extrapolates it to the target's asset count to produce
--   an estimated annual job volume and cost opportunity.
--   Also shows the cost range (p25–p75) for sensitivity analysis.
-- Dashboard use: KPI cards — "Estimated X jobs/year, ~$Y/year".
--   Shown alongside D1 in the drill-down panel.
-- ============================================================

WITH PEER_RATES AS (
    SELECT
        A.asset_category,
        J.activity_category_name,
        A.standardised_contract_name,
        COUNT(DISTINCT CONCAT(J.source_context, '|', JL.job_id))
            / NULLIF(COUNT(DISTINCT A.asset_id), 0) / 3.0              AS jobs_per_asset_per_year,
        SUM(COALESCE(TS.actual_cost, 0))
            / NULLIF(COUNT(DISTINCT A.asset_id), 0) / 3.0              AS cost_per_asset_per_year,
        (SUM(COALESCE(TS.actual_hours, 0) + COALESCE(TS.actual_minutes, 0) / 60.0))
            / NULLIF(COUNT(DISTINCT A.asset_id), 0) / 3.0              AS hours_per_asset_per_year
    FROM transport_dev.integ_transport_assets.vw_silver_transport_asset_with_category A
    INNER JOIN transport_dev.integ_transport_assets.vw_silver_transport_job_asset_link JL
        ON A.source_context = JL.source_context AND A.asset_id = JL.asset_id
    INNER JOIN transport_dev.integ_transport_assets.vw_bronze_transport_job_base J
        ON JL.source_context = J.source_context AND JL.job_id = J.job_id
    LEFT JOIN transport_dev.integ_transport_assets.vw_silver_transport_timesheet_asset_link TS
        ON A.source_context = TS.source_context AND A.asset_id = TS.asset_id
       AND TS.start_date >= DATE_ADD(current_date(), -1095)
    WHERE A.standardised_contract_name != '[TARGET_CONTRACT]'
      AND A.asset_category = '[TARGET_CATEGORY]'
      AND J.activity_category_name = '[TARGET_ACTIVITY]'
      AND J.completed_date >= DATE_ADD(current_date(), -1095)
      AND A.standardised_contract_name IS NOT NULL
    GROUP BY A.asset_category, J.activity_category_name, A.standardised_contract_name
),
TARGET_ASSET_COUNT AS (
    SELECT COUNT(DISTINCT asset_id) AS n
    FROM transport_dev.integ_transport_assets.vw_silver_transport_asset_with_category
    WHERE standardised_contract_name = '[TARGET_CONTRACT]'
      AND asset_category = '[TARGET_CATEGORY]'
)
SELECT
    '[TARGET_CONTRACT]'                                                   AS target_contract,
    '[TARGET_CATEGORY]'                                                   AS asset_category,
    '[TARGET_ACTIVITY]'                                                   AS activity_category,
    (SELECT n FROM TARGET_ASSET_COUNT)                                    AS target_asset_count,
    COUNT(*)                                                              AS peer_contracts_sampled,
    -- Annual estimate using median peer rate
    ROUND(PERCENTILE_APPROX(jobs_per_asset_per_year, 0.5)
          * (SELECT n FROM TARGET_ASSET_COUNT), 0)                        AS est_annual_jobs_median,
    ROUND(PERCENTILE_APPROX(jobs_per_asset_per_year, 0.25)
          * (SELECT n FROM TARGET_ASSET_COUNT), 0)                        AS est_annual_jobs_low,
    ROUND(PERCENTILE_APPROX(jobs_per_asset_per_year, 0.75)
          * (SELECT n FROM TARGET_ASSET_COUNT), 0)                        AS est_annual_jobs_high,
    -- Cost estimate
    ROUND(PERCENTILE_APPROX(cost_per_asset_per_year, 0.5)
          * (SELECT n FROM TARGET_ASSET_COUNT), 0)                        AS est_annual_cost_median,
    ROUND(PERCENTILE_APPROX(cost_per_asset_per_year, 0.25)
          * (SELECT n FROM TARGET_ASSET_COUNT), 0)                        AS est_annual_cost_low,
    ROUND(PERCENTILE_APPROX(cost_per_asset_per_year, 0.75)
          * (SELECT n FROM TARGET_ASSET_COUNT), 0)                        AS est_annual_cost_high,
    -- Hours estimate
    ROUND(PERCENTILE_APPROX(hours_per_asset_per_year, 0.5)
          * (SELECT n FROM TARGET_ASSET_COUNT), 0)                        AS est_annual_hours_median
FROM PEER_RATES;


-- ============================================================
-- D3: Asset Risk Profile in the Gap
-- ============================================================
-- What it shows: For the gap assets in the target contract, shows
--   the condition and criticality distribution. Poor condition +
--   high criticality + no maintenance activity = strongest pitch.
--   "These are your most at-risk assets and nobody is maintaining them."
-- Dashboard use: Donut charts (condition, criticality) + a risk
--   summary KPI: "X assets are high-criticality with no maintenance."
-- ============================================================

SELECT
    A.standardised_contract_name,
    A.asset_category,
    A.standardised_asset_type_name,
    COALESCE(A.asset_condition,   'Not recorded')  AS asset_condition,
    COALESCE(A.asset_criticality, 'Not recorded')  AS asset_criticality,
    COUNT(DISTINCT A.asset_id)                     AS asset_count,
    -- Flag assets that have NEVER had a job in this activity category
    SUM(CASE WHEN JOB_CHECK.job_id IS NULL THEN 1 ELSE 0 END) AS assets_with_zero_activity_jobs,
    ROUND(
        100.0 * SUM(CASE WHEN JOB_CHECK.job_id IS NULL THEN 1 ELSE 0 END)
        / NULLIF(COUNT(DISTINCT A.asset_id), 0), 1
    )                                              AS pct_with_zero_activity_jobs
FROM transport_dev.integ_transport_assets.vw_silver_transport_asset_with_category A
LEFT JOIN (
    -- Jobs of the gap activity type against these assets
    SELECT DISTINCT JL.source_context, JL.asset_id, JL.job_id
    FROM transport_dev.integ_transport_assets.vw_silver_transport_job_asset_link JL
    INNER JOIN transport_dev.integ_transport_assets.vw_bronze_transport_job_base J
        ON JL.source_context = J.source_context AND JL.job_id = J.job_id
    WHERE J.activity_category_name = '[TARGET_ACTIVITY]'
      AND J.completed_date >= DATE_ADD(current_date(), -1095)
) JOB_CHECK
    ON A.source_context = JOB_CHECK.source_context AND A.asset_id = JOB_CHECK.asset_id
WHERE A.standardised_contract_name = '[TARGET_CONTRACT]'
  AND A.asset_category = '[TARGET_CATEGORY]'
GROUP BY
    A.standardised_contract_name,
    A.asset_category,
    A.standardised_asset_type_name,
    COALESCE(A.asset_condition,   'Not recorded'),
    COALESCE(A.asset_criticality, 'Not recorded')
ORDER BY assets_with_zero_activity_jobs DESC;


-- ============================================================
-- D4: Inspect-Without-Maintain Gap
-- ============================================================
-- What it shows: Contracts that are performing inspections on an
--   asset category but have a very low rate of follow-up maintenance
--   jobs. This indicates an "inspect-only" scope — Ventia could pitch
--   expanding to the maintenance and repair mandate.
-- Dashboard use: Scatter plot — x = inspection rate, y = job trigger
--   rate. Contracts in the top-left quadrant (high inspection,
--   low jobs) are the pitch targets.
-- ============================================================

WITH INSP_RATE AS (
    SELECT
        A.standardised_contract_name,
        A.asset_category,
        COUNT(DISTINCT A.asset_id)                    AS asset_count,
        COUNT(DISTINCT IL.inspection_id)              AS total_inspections,
        ROUND(
            COUNT(DISTINCT IL.inspection_id)
            / NULLIF(COUNT(DISTINCT A.asset_id), 0) / 3.0, 2
        )                                             AS inspections_per_asset_per_year
    FROM transport_dev.integ_transport_assets.vw_silver_transport_asset_with_category A
    INNER JOIN transport_dev.integ_transport_assets.vw_silver_transport_inspection_asset_link IL
        ON A.source_context = IL.source_context AND A.asset_id = IL.asset_id
    INNER JOIN transport_dev.integ_transport_assets.vw_bronze_transport_inspection_base I
        ON IL.source_context = I.source_context AND IL.inspection_id = I.inspection_id
    WHERE A.standardised_contract_name IS NOT NULL
      AND A.asset_category IS NOT NULL
      AND I.completed_date >= DATE_ADD(current_date(), -1095)
    GROUP BY A.standardised_contract_name, A.asset_category
),
JOB_RATE AS (
    SELECT
        A.standardised_contract_name,
        A.asset_category,
        COUNT(DISTINCT CONCAT(JL.source_context, '|', JL.job_id)) AS total_jobs,
        ROUND(
            COUNT(DISTINCT CONCAT(JL.source_context, '|', JL.job_id))
            / NULLIF(COUNT(DISTINCT A.asset_id), 0) / 3.0, 2
        )                                                          AS jobs_per_asset_per_year
    FROM transport_dev.integ_transport_assets.vw_silver_transport_asset_with_category A
    INNER JOIN transport_dev.integ_transport_assets.vw_silver_transport_job_asset_link JL
        ON A.source_context = JL.source_context AND A.asset_id = JL.asset_id
    INNER JOIN transport_dev.integ_transport_assets.vw_bronze_transport_job_base J
        ON JL.source_context = J.source_context AND JL.job_id = J.job_id
    WHERE A.standardised_contract_name IS NOT NULL
      AND A.asset_category IS NOT NULL
      AND J.completed_date >= DATE_ADD(current_date(), -1095)
    GROUP BY A.standardised_contract_name, A.asset_category
),
-- Benchmark: median job-per-inspection ratio across all contracts with both
BENCHMARK AS (
    SELECT
        IR.asset_category,
        PERCENTILE_APPROX(COALESCE(JR.jobs_per_asset_per_year, 0)
            / NULLIF(IR.inspections_per_asset_per_year, 0), 0.5) AS median_job_per_insp_ratio
    FROM INSP_RATE IR
    LEFT JOIN JOB_RATE JR
        ON IR.standardised_contract_name = JR.standardised_contract_name
       AND IR.asset_category = JR.asset_category
    GROUP BY IR.asset_category
)
SELECT
    IR.standardised_contract_name,
    IR.asset_category,
    IR.asset_count,
    IR.total_inspections,
    IR.inspections_per_asset_per_year,
    COALESCE(JR.total_jobs, 0)                                    AS total_jobs,
    COALESCE(JR.jobs_per_asset_per_year, 0)                       AS jobs_per_asset_per_year,
    ROUND(COALESCE(JR.jobs_per_asset_per_year, 0)
          / NULLIF(IR.inspections_per_asset_per_year, 0), 3)      AS jobs_per_inspection,
    B.median_job_per_insp_ratio                                   AS benchmark_jobs_per_inspection,
    ROUND(
        100.0 * COALESCE(JR.jobs_per_asset_per_year, 0)
        / NULLIF(IR.inspections_per_asset_per_year, 0)
        / NULLIF(B.median_job_per_insp_ratio, 0), 1
    )                                                             AS pct_of_benchmark_conversion,
    -- Estimated additional jobs if brought to benchmark
    ROUND(
        (B.median_job_per_insp_ratio
         - COALESCE(JR.jobs_per_asset_per_year, 0) / NULLIF(IR.inspections_per_asset_per_year, 0))
        * IR.total_inspections, 0
    )                                                             AS est_additional_jobs_to_benchmark
FROM INSP_RATE IR
LEFT JOIN JOB_RATE JR
    ON IR.standardised_contract_name = JR.standardised_contract_name
   AND IR.asset_category = JR.asset_category
INNER JOIN BENCHMARK B ON IR.asset_category = B.asset_category
WHERE IR.inspections_per_asset_per_year > 0
  AND COALESCE(JR.jobs_per_asset_per_year, 0) / NULLIF(IR.inspections_per_asset_per_year, 0)
      < B.median_job_per_insp_ratio * 0.5  -- at least 50% below benchmark conversion
ORDER BY est_additional_jobs_to_benchmark DESC;


-- ============================================================
-- D5: Capital Works Uplift Opportunity
-- ============================================================
-- What it shows: Contracts managing asset categories where peers
--   are running capital works (renewals/upgrades) but this contract
--   has none — or far fewer. Poor condition assets with no capital
--   works = strong evidence for a renewal pitch.
-- Dashboard use: Bar chart showing capital works count per contract
--   per asset category, with benchmark overlay. Filter to gaps only.
-- ============================================================

WITH CW_BY_CONTRACT AS (
    SELECT
        A.standardised_contract_name,
        A.asset_category,
        COUNT(DISTINCT A.asset_id)                                    AS asset_count,
        COUNT(DISTINCT CONCAT(CW.source_context, '|', CW.capitalwork_id)) AS cw_count,
        ROUND(
            COUNT(DISTINCT CONCAT(CW.source_context, '|', CW.capitalwork_id))
            / NULLIF(COUNT(DISTINCT A.asset_id), 0), 3
        )                                                             AS cw_per_asset
    FROM transport_dev.integ_transport_assets.vw_silver_transport_asset_with_category A
    LEFT JOIN transport_dev.integ_transport_assets.vw_bronze_transport_capitalwork_base CW
        ON A.source_context = CW.source_context AND A.asset_id = CW.asset_id
       AND CW.planned_start >= DATE_ADD(current_date(), -1095)
    WHERE A.standardised_contract_name IS NOT NULL
      AND A.asset_category IS NOT NULL
    GROUP BY A.standardised_contract_name, A.asset_category
),
WITH_BENCHMARK AS (
    SELECT *,
        PERCENTILE_APPROX(cw_per_asset, 0.5)
            OVER (PARTITION BY asset_category) AS benchmark_median_cw_per_asset,
        COUNT(*) OVER (PARTITION BY asset_category) AS contracts_in_category
    FROM CW_BY_CONTRACT
)
SELECT
    standardised_contract_name,
    asset_category,
    asset_count,
    cw_count,
    cw_per_asset,
    benchmark_median_cw_per_asset,
    contracts_in_category,
    ROUND(100.0 * cw_per_asset / NULLIF(benchmark_median_cw_per_asset, 0), 1) AS pct_of_benchmark,
    -- Estimated capital works gap
    ROUND(
        (benchmark_median_cw_per_asset - cw_per_asset) * asset_count, 0
    )                                                                          AS est_additional_cw_to_benchmark,
    CASE
        WHEN cw_per_asset = 0 THEN 'No capital works (strong pitch)'
        WHEN cw_per_asset < benchmark_median_cw_per_asset * 0.5
             THEN 'Significantly under-invested'
        ELSE 'Below benchmark'
    END                                                                        AS opportunity_type
FROM WITH_BENCHMARK
WHERE cw_per_asset < benchmark_median_cw_per_asset * 0.8
  AND contracts_in_category >= 3
  AND benchmark_median_cw_per_asset > 0
ORDER BY est_additional_cw_to_benchmark DESC;


-- ============================================================
-- C1: Activity Breadth Index — Contracts with Narrow Scope
-- ============================================================
-- What it shows: How many distinct activity categories does each
--   contract perform vs how many exist across all contracts for
--   their asset categories? Low breadth = most room to expand.
--   These are the contracts where a single conversation could
--   unlock multiple new service lines.
-- Dashboard use: Bar chart — activity breadth % per contract,
--   sorted ascending (narrowest scope at top).
-- ============================================================

WITH ALL_ACTIVITIES_PER_ASSET_CATEGORY AS (
    SELECT DISTINCT
        A.asset_category,
        J.activity_category_name
    FROM transport_dev.integ_transport_assets.vw_silver_transport_asset_with_category A
    INNER JOIN transport_dev.integ_transport_assets.vw_silver_transport_job_asset_link JL
        ON A.source_context = JL.source_context AND A.asset_id = JL.asset_id
    INNER JOIN transport_dev.integ_transport_assets.vw_bronze_transport_job_base J
        ON JL.source_context = J.source_context AND JL.job_id = J.job_id
    WHERE A.standardised_contract_name IS NOT NULL
      AND A.asset_category IS NOT NULL
      AND J.activity_category_name IS NOT NULL
      AND J.completed_date >= DATE_ADD(current_date(), -1095)
),
-- Total possible activities per contract (sum across all their asset categories)
POSSIBLE_ACTIVITIES AS (
    SELECT
        A.standardised_contract_name,
        COUNT(DISTINCT CONCAT(A.asset_category, '|', U.activity_category_name)) AS possible_activities
    FROM (
        SELECT DISTINCT standardised_contract_name, asset_category
        FROM transport_dev.integ_transport_assets.vw_silver_transport_asset_with_category
        WHERE standardised_contract_name IS NOT NULL AND asset_category IS NOT NULL
    ) A
    INNER JOIN ALL_ACTIVITIES_PER_ASSET_CATEGORY U ON A.asset_category = U.asset_category
    GROUP BY A.standardised_contract_name
),
-- Activities each contract actually performs
ACTUAL_ACTIVITIES AS (
    SELECT
        A.standardised_contract_name,
        COUNT(DISTINCT CONCAT(A.asset_category, '|', J.activity_category_name)) AS actual_activities,
        COUNT(DISTINCT A.asset_category)                                          AS asset_categories
    FROM transport_dev.integ_transport_assets.vw_silver_transport_asset_with_category A
    INNER JOIN transport_dev.integ_transport_assets.vw_silver_transport_job_asset_link JL
        ON A.source_context = JL.source_context AND A.asset_id = JL.asset_id
    INNER JOIN transport_dev.integ_transport_assets.vw_bronze_transport_job_base J
        ON JL.source_context = J.source_context AND JL.job_id = J.job_id
    WHERE A.standardised_contract_name IS NOT NULL
      AND J.activity_category_name IS NOT NULL
      AND J.completed_date >= DATE_ADD(current_date(), -1095)
    GROUP BY A.standardised_contract_name
)
SELECT
    AA.standardised_contract_name,
    AA.asset_categories,
    AA.actual_activities,
    PA.possible_activities,
    PA.possible_activities - AA.actual_activities            AS activity_gaps,
    ROUND(100.0 * AA.actual_activities / NULLIF(PA.possible_activities, 0), 1) AS breadth_pct
FROM ACTUAL_ACTIVITIES AA
INNER JOIN POSSIBLE_ACTIVITIES PA ON AA.standardised_contract_name = PA.standardised_contract_name
ORDER BY breadth_pct ASC;  -- narrowest scope (most opportunity) first


-- ============================================================
-- C2: Specialist Service Penetration
-- ============================================================
-- What it shows: Which contracts are performing high-value,
--   specialist activity categories (structural, electrical,
--   geotechnical, ITS, environmental) vs only routine maintenance?
--   Contracts doing ONLY routine work are candidates for specialist
--   service upsell. This is a revenue-per-contract multiplier.
-- Dashboard use: Two-metric bar chart per contract — specialist
--   job % (y1) vs total job volume (y2). Bubble size = asset count.
-- Note: Update the specialist_categories list to match your
--   actual activity_category_name values in the data.
-- ============================================================

WITH JOB_CLASSIFIED AS (
    SELECT
        A.standardised_contract_name,
        A.asset_category,
        J.activity_category_name,
        CONCAT(JL.source_context, '|', JL.job_id) AS job_key,
        CASE
            WHEN LOWER(J.activity_category_name) LIKE '%structural%'
              OR LOWER(J.activity_category_name) LIKE '%geotechnical%'
              OR LOWER(J.activity_category_name) LIKE '%electrical%'
              OR LOWER(J.activity_category_name) LIKE '%its%'
              OR LOWER(J.activity_category_name) LIKE '%environment%'
              OR LOWER(J.activity_category_name) LIKE '%pavement%'
              OR LOWER(J.activity_category_name) LIKE '%rehabilitation%'
              OR LOWER(J.activity_category_name) LIKE '%capital%'
              OR LOWER(J.activity_category_name) LIKE '%renewal%'
            THEN 'Specialist'
            ELSE 'Routine'
        END AS job_class
    FROM transport_dev.integ_transport_assets.vw_silver_transport_asset_with_category A
    INNER JOIN transport_dev.integ_transport_assets.vw_silver_transport_job_asset_link JL
        ON A.source_context = JL.source_context AND A.asset_id = JL.asset_id
    INNER JOIN transport_dev.integ_transport_assets.vw_bronze_transport_job_base J
        ON JL.source_context = J.source_context AND JL.job_id = J.job_id
    WHERE A.standardised_contract_name IS NOT NULL
      AND J.activity_category_name IS NOT NULL
      AND J.completed_date >= DATE_ADD(current_date(), -1095)
)
SELECT
    standardised_contract_name,
    COUNT(DISTINCT job_key)                                                       AS total_jobs,
    COUNT(DISTINCT CASE WHEN job_class = 'Specialist' THEN job_key END)           AS specialist_jobs,
    COUNT(DISTINCT CASE WHEN job_class = 'Routine'    THEN job_key END)           AS routine_jobs,
    ROUND(
        100.0 * COUNT(DISTINCT CASE WHEN job_class = 'Specialist' THEN job_key END)
        / NULLIF(COUNT(DISTINCT job_key), 0), 1
    )                                                                             AS specialist_pct,
    COUNT(DISTINCT activity_category_name)                                        AS distinct_activity_categories,
    COUNT(DISTINCT CASE WHEN job_class = 'Specialist'
                        THEN activity_category_name END)                          AS distinct_specialist_categories
FROM JOB_CLASSIFIED
GROUP BY standardised_contract_name
ORDER BY specialist_pct ASC;  -- least specialist first (most to pitch)


-- ============================================================
-- C3: Client Cross-Pollination
-- ============================================================
-- What it shows: Groups contracts by client (source_label) and finds
--   asset categories + activities that Ventia delivers for one client
--   but not for a comparable client. This is the strategic version —
--   "We already do this for the government in NSW, why not VIC?"
--   Useful for exec-level pitch decks and tender strategy.
-- Dashboard use: Sankey diagram (client → activity category → gap
--   client) or a simple two-column table (we do this for X / not yet
--   for Y). Best filtered to a single source_label pair.
-- ============================================================

WITH CLIENT_ACTIVITY_SCOPE AS (
    SELECT DISTINCT
        A.source_label                  AS client,
        A.asset_category,
        J.activity_category_name
    FROM transport_dev.integ_transport_assets.vw_silver_transport_asset_with_category A
    INNER JOIN transport_dev.integ_transport_assets.vw_silver_transport_job_asset_link JL
        ON A.source_context = JL.source_context AND A.asset_id = JL.asset_id
    INNER JOIN transport_dev.integ_transport_assets.vw_bronze_transport_job_base J
        ON JL.source_context = J.source_context AND JL.job_id = J.job_id
    WHERE A.source_label IS NOT NULL
      AND A.asset_category IS NOT NULL
      AND J.activity_category_name IS NOT NULL
      AND J.completed_date >= DATE_ADD(current_date(), -1095)
),
CLIENT_ASSET_PRESENCE AS (
    SELECT DISTINCT source_label AS client, asset_category
    FROM transport_dev.integ_transport_assets.vw_silver_transport_asset_with_category
    WHERE source_label IS NOT NULL
      AND asset_category IS NOT NULL
)
SELECT
    CAP_TARGET.client                                AS target_client,
    CAS_PEER.client                                  AS peer_client_doing_it,
    CAP_TARGET.asset_category,
    CAS_PEER.activity_category_name,
    -- Does the target client have the asset?
    'Has asset, not in scope'                        AS gap_type
FROM CLIENT_ASSET_PRESENCE CAP_TARGET
-- Peer clients doing this activity on this asset category
INNER JOIN CLIENT_ACTIVITY_SCOPE CAS_PEER
    ON CAS_PEER.asset_category = CAP_TARGET.asset_category
   AND CAS_PEER.client != CAP_TARGET.client
-- Anti-join: target client is NOT doing this activity
LEFT JOIN CLIENT_ACTIVITY_SCOPE CAS_TARGET
    ON CAS_TARGET.client = CAP_TARGET.client
   AND CAS_TARGET.asset_category = CAP_TARGET.asset_category
   AND CAS_TARGET.activity_category_name = CAS_PEER.activity_category_name
WHERE CAS_TARGET.client IS NULL
ORDER BY target_client, asset_category, activity_category_name;
