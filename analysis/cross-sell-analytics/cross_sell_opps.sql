-- ============================================================
-- WINNING BIDS / CROSS-SELL DASHBOARD TABLES
-- ============================================================
-- Suggested dashboard layout:
--   TOP SCORECARDS
--     - Total opportunity rows
--     - High / medium confidence rows
--     - Estimated jobs per year
--     - Asset exposure
--
--   MAIN TAB: Cross-sell opportunities
--     Source table:
--       winning_bids_peer_contracts_comparison_asset_type
--     Best visuals:
--       - Ranked table by opportunity_signal_score
--       - Bar chart by target_contract
--       - Heatmap: target_contract x activity_scope
--     Main filters:
--       target_contract, asset_type, activity_scope, opportunity_confidence
--
--   DETAIL TAB: Why is this cross-sellable?
--     Source tables:
--       winning_bids_peer_contracts_comparison_asset_type
--       winning_bids_peer_contracts_comparison_asset_type_details
--     Best visuals:
--       - Peer contracts doing the work
--       - Raw activity examples
--       - Asset type and target asset count
--
--   BENCHMARK TAB: Under-serviced contracts
--     Source table:
--       winning_bids_under_serviced_contracts
--     Best visuals:
--       - Scatter: asset_count vs jobs_per_asset_per_year
--       - Table sorted by pct_of_benchmark ascending
--       - Scorecard: count of RED / AMBER rows
--
--   SERVICE LINE TAB: Executive summary
--     Source table:
--       winning_bids_service_line_summary
--     Best visuals:
--       - Bar chart by estimated_total_jobs_per_year
--       - Table of target_contracts and asset_types in one cell
--       - Scorecard: target_contract_count by service line
--
-- Plain meaning:
--   These tables do not prove revenue or margin.
--   They show operational scope gaps using Asset Vision evidence:
--   "we manage the asset, peers do this work, but this contract
--   does not show recent jobs for that activity."
-- ============================================================

CREATE OR REPLACE TEMP VIEW vw_cross_sell_job_activity_standardised AS
SELECT
    J.source_context,
    J.job_id,
    J.asset_id,
    J.due_date,
    J.completed_date,
    J.hazard_defect_code,
    J.activity_category_name AS raw_activity_category_name,
    J.activity_name          AS raw_activity_name,
    COALESCE(
        ACT.standardised_activity_category_name,
        J.activity_category_name,
        'Unmapped'
    ) AS activity_category_name,
    COALESCE(
        ACT.standardised_activity_name,
        J.activity_name,
        'Unmapped'
    ) AS activity_name,
    COALESCE(
        ACT.standardised_activity_category_name,
        J.activity_category_name,
        'Unmapped'
    ) AS standardised_activity_category_name,
    COALESCE(
        ACT.standardised_activity_name,
        J.activity_name,
        'Unmapped'
    ) AS standardised_activity_name,
    COALESCE(
        ACT.standardised_activity_name,
        J.activity_name,
        'Unmapped'
    ) AS standardised_activity_scope,
    CASE
        WHEN ACT.raw_activity_category_name IS NOT NULL
        THEN 1
        ELSE 0
    END AS has_activity_mapping,
    J.intervention_code,
    J.estimated_quantity,
    J.priority,
    J.activity_type,
    J.compliant,
    J.remaining_quantity,
    J.actual_quantity,
    J.inspection_type_name,
    J.estimated_length,
    J.estimated_width,
    J.estimated_depth
FROM transport_dev.integ_transport_assets.vw_bronze_transport_job_base J
LEFT JOIN (
    SELECT
        raw_activity_category_name,
        raw_activity_name,
        MAX(standardised_activity_category_name) AS standardised_activity_category_name,
        MAX(standardised_activity_name)          AS standardised_activity_name
    FROM transport_dev.integ_transport_assets.asset_vision_activity_group_map
    GROUP BY
        raw_activity_category_name,
        raw_activity_name
) ACT
    ON LOWER(TRIM(REGEXP_REPLACE(COALESCE(J.activity_category_name, '[null]'), '\\s+', ' ')))
     = LOWER(TRIM(REGEXP_REPLACE(COALESCE(ACT.raw_activity_category_name, '[null]'), '\\s+', ' ')))
   AND LOWER(TRIM(REGEXP_REPLACE(COALESCE(J.activity_name, '[null]'), '\\s+', ' ')))
     = LOWER(TRIM(REGEXP_REPLACE(COALESCE(ACT.raw_activity_name, '[null]'), '\\s+', ' ')))
;


-- ============================================================
-- Winning bids: by asset type and service
-- ============================================================
-- Table:
--   winning_bids_peer_contracts_comparison_asset_type
--
-- What each row means:
--   One potential cross-sell opportunity:
--     target_contract owns/manages asset_type,
--     peer contracts do activity_scope on that same asset_type,
--     target_contract does not show recent jobs for that activity.
--
-- Use this as:
--   1. Main dashboard table
--      Sort by opportunity_signal_score DESC.
--
--   2. Scorecards
--      COUNT(*)                                                AS opportunity_count
--      SUM(CASE WHEN opportunity_confidence = 'High' THEN 1 END) AS high_confidence_count
--      SUM(estimated_target_jobs_per_year)                     AS estimated_jobs_per_year
--      SUM(target_asset_count)                                 AS asset_exposure
--
--   3. Charts
--      Bar chart:
--        x = target_contract
--        y = SUM(opportunity_signal_score)
--
--      Heatmap:
--        rows    = target_contract
--        columns = activity_scope
--        value   = peer_contracts_doing_it
--
--      Bubble chart:
--        x = target_asset_count
--        y = peer_contracts_doing_it
--        size = estimated_target_jobs_per_year
--        colour = opportunity_confidence
--
-- Key caveat:
--   This is a sales signal, not proof the contract should be doing
--   the work. Validate contract scope before pitching.
-- ============================================================

CREATE OR REPLACE TABLE transport_dev.integ_transport_assets.winning_bids_peer_contracts_comparison_asset_type 
USING DELTA AS
WITH CONTRACT_ASSET_PRESENCE AS (
    SELECT
        standardised_contract_name,
        standardised_asset_type_name AS asset_type,
        COUNT(DISTINCT CONCAT(source_context, '|', asset_id)) AS target_asset_count
    FROM transport_dev.integ_transport_assets.vw_silver_transport_asset_with_category
    WHERE standardised_contract_name IS NOT NULL
        AND standardised_asset_type_name IS NOT NULL
        AND standardised_asset_type_name != 'Unspecified asset type'
    GROUP BY
        standardised_contract_name,
        standardised_asset_type_name
)
, CONTRACT_ACTIVITY_SCOPE AS (
    SELECT
        A.standardised_contract_name,
        A.standardised_asset_type_name AS asset_type,
        J.standardised_activity_scope  AS activity_scope,
        COUNT(DISTINCT CONCAT(J.source_context, '|', J.job_id)) AS job_count_3yr,
        COUNT(DISTINCT CONCAT(A.source_context, '|', A.asset_id)) AS assets_with_activity,
        MAX(J.completed_date) AS latest_completed_date,
        ARRAY_JOIN(
            SORT_ARRAY(
                COLLECT_SET(
                    CONCAT(
                        COALESCE(J.raw_activity_category_name, 'null'),
                        ' / ',
                        COALESCE(J.raw_activity_name, 'null')
                    )
                )
            ),
            ' | '
        ) AS raw_activity_examples
    FROM transport_dev.integ_transport_assets.vw_silver_transport_asset_with_category A
        INNER JOIN transport_dev.integ_transport_assets.vw_silver_transport_job_asset_link JL
            ON A.source_context = JL.source_context
            AND A.asset_id = JL.asset_id
        INNER JOIN vw_cross_sell_job_activity_standardised J
            ON JL.source_context = J.source_context
            AND JL.job_id = J.job_id
    WHERE A.standardised_contract_name IS NOT NULL
        AND A.standardised_asset_type_name IS NOT NULL
        AND J.standardised_activity_scope IS NOT NULL
        AND J.completed_date >= DATE_ADD(current_date(), -1095)
    GROUP BY
        A.standardised_contract_name,
        A.standardised_asset_type_name,
        J.standardised_activity_scope
)
, CROSS_SELL_GAPS AS (
    SELECT
        CAP.standardised_contract_name AS target_contract,
        CAP.asset_type,
        PEER.activity_scope,
        CAP.target_asset_count,
        COUNT(DISTINCT PEER.standardised_contract_name) AS peer_contracts_doing_it,
        ARRAY_JOIN(
            SORT_ARRAY(COLLECT_SET(PEER.standardised_contract_name)),
            ' | '
        ) AS peer_contracts,
        SUM(PEER.job_count_3yr) AS peer_job_count_3yr,
        ROUND(
            PERCENTILE_APPROX(
                PEER.job_count_3yr / NULLIF(PEER.assets_with_activity, 0) / 3.0,
                0.5
            ),
            3
        ) AS peer_median_jobs_per_asset_per_year,
        MAX(PEER.latest_completed_date) AS latest_peer_completed_date,
        ARRAY_JOIN(
            SORT_ARRAY(COLLECT_SET(PEER.raw_activity_examples)),
            ' | '
        ) AS raw_activity_examples
    FROM CONTRACT_ASSET_PRESENCE CAP
        INNER JOIN CONTRACT_ACTIVITY_SCOPE PEER
            ON PEER.asset_type = CAP.asset_type
            AND PEER.standardised_contract_name != CAP.standardised_contract_name
        LEFT JOIN CONTRACT_ACTIVITY_SCOPE SELF
            ON SELF.standardised_contract_name = CAP.standardised_contract_name
            AND SELF.asset_type = CAP.asset_type
            AND SELF.activity_scope = PEER.activity_scope
    WHERE SELF.standardised_contract_name IS NULL
    GROUP BY
        CAP.standardised_contract_name,
        CAP.asset_type,
        PEER.activity_scope,
        CAP.target_asset_count
)
SELECT
    target_contract,
    asset_type,
    activity_scope,
    raw_activity_examples,
    target_asset_count,
    peer_contracts_doing_it,
    peer_contracts,
    peer_job_count_3yr,
    peer_median_jobs_per_asset_per_year,
    ROUND(
        target_asset_count * peer_median_jobs_per_asset_per_year,
        1
    ) AS estimated_target_jobs_per_year,
    latest_peer_completed_date,
    CASE
        WHEN peer_contracts_doing_it >= 3
            AND target_asset_count >= 25
        THEN 'High'

        WHEN peer_contracts_doing_it >= 2
            AND target_asset_count >= 10
        THEN 'Medium'

        ELSE 'Low'
    END AS opportunity_confidence,
    CASE
        WHEN peer_contracts_doing_it >= 3
        THEN 'Multiple peer contracts already do this work on the same asset type.'

        WHEN peer_contracts_doing_it = 2
        THEN 'Two peer contracts already do this work on the same asset type.'

        ELSE 'Only one peer contract does this work, so treat it as a weak signal.'
    END AS cross_sell_reason,
    ROUND(
        peer_contracts_doing_it
        * LOG(target_asset_count + 1)
        * COALESCE(peer_median_jobs_per_asset_per_year, 0),
        2
    ) AS opportunity_signal_score,
    CURRENT_TIMESTAMP() AS created_ts
FROM CROSS_SELL_GAPS
WHERE peer_contracts_doing_it >= 2
ORDER BY opportunity_signal_score DESC
;


-- ============================================================
-- Winning bids: raw activity detail
-- ============================================================
-- Table:
--   winning_bids_peer_contracts_comparison_asset_type_details
--
-- What each row means:
--   For each contract + asset type + standardised activity, show the
--   raw Asset Vision activity category names that rolled into it.
--
-- Use this as:
--   1. Drill-down table below a clicked opportunity row
--      Filter by:
--        standardised_contract_name = selected peer or target contract
--        asset_type = selected asset type
--        activity_scope = selected activity
--
--   2. Data validation table
--      If activity_scope looks strange, use raw_activity_scope to see
--      the raw names that created it.
--
--   3. Tooltip / hover detail
--      Show raw_activity_scope when users hover over activity_scope.
--
-- Dashboard columns to show:
--   standardised_contract_name, asset_type, activity_scope,
--   raw_activity_scope
-- ============================================================

CREATE OR REPLACE TABLE transport_dev.integ_transport_assets.winning_bids_peer_contracts_comparison_asset_type_details AS
WITH CONTRACT_ASSET_PRESENCE AS (
    SELECT
            source_context,
            standardised_contract_name,
            standardised_asset_type_name    AS asset_type,
            COUNT(DISTINCT asset_id)        AS asset_count
    FROM transport_dev.integ_transport_assets.vw_silver_transport_asset_with_category
    WHERE standardised_contract_name IS NOT NULL
        AND standardised_asset_type_name IS NOT NULL
        AND standardised_asset_type_name != 'Unspecified asset type'
    GROUP BY ALL
)
, CONTRACT_ACTIVITY_SCOPE AS (
    SELECT
        A.source_context,
        A.standardised_contract_name,
        A.standardised_asset_type_name      AS asset_type,
        J.standardised_activity_scope       AS activity_scope,
        LISTAGG(DISTINCT raw_activity_category_name, ' | ') AS raw_activity_scope
    FROM transport_dev.integ_transport_assets.vw_silver_transport_asset_with_category A
        INNER JOIN transport_dev.integ_transport_assets.vw_silver_transport_job_asset_link JL
            USING (
                source_context,
                asset_id
            )
        INNER JOIN vw_cross_sell_job_activity_standardised J
            USING (
                source_context,
                job_id
            )
    WHERE A.standardised_contract_name IS NOT NULL
        AND A.standardised_asset_type_name IS NOT NULL
        AND J.standardised_activity_scope IS NOT NULL
        AND J.completed_date >= DATE_ADD(current_date(), -1095)
    GROUP BY ALL
)
SELECT activity_scope,
    standardised_contract_name,
    asset_type,
    raw_activity_scope
FROM CONTRACT_ACTIVITY_SCOPE
GROUP BY ALL
;



-- ============================================================
-- Job Intensity Benchmark — Under-Serviced Contracts
-- ============================================================
-- Table:
--   winning_bids_under_serviced_contracts
--
-- What each row means:
--   A contract is already doing the activity, but at a lower rate
--   than peer contracts for the same asset_type + activity_scope.
--
-- This is different from the main cross-sell table:
--   - Main cross-sell table = "not doing this activity recently"
--   - This table = "doing it, but much less than peers"
--
-- Use this as:
--   1. Benchmark table
--      Sort by pct_of_benchmark ASC.
--
--   2. Scorecards
--      COUNT(CASE WHEN benchmark_status LIKE 'Under-serviced%' THEN 1 END) AS red_count
--      COUNT(CASE WHEN benchmark_status LIKE 'Below benchmark%' THEN 1 END) AS amber_count
--
--   3. Charts
--      Scatter:
--        x = asset_count
--        y = jobs_per_asset_per_year
--        colour = benchmark_status
--
--      Bar chart:
--        x = standardised_contract_name
--        y = AVG(pct_of_benchmark)
--
-- Business question:
--   "Where are we already contracted to do this kind of work, but
--   the work rate looks low compared with similar contracts?"
-- ============================================================

CREATE OR REPLACE TABLE transport_dev.integ_transport_assets.winning_bids_under_serviced_contracts AS 
WITH CONTRACT_JOB_RATE AS (
    SELECT
        A.standardised_contract_name,
        A.standardised_asset_type_name AS asset_type,
        J.standardised_activity_scope AS activity_scope,
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
        INNER JOIN vw_cross_sell_job_activity_standardised J
            ON JL.source_context = J.source_context AND JL.job_id = J.job_id
    WHERE A.standardised_contract_name IS NOT NULL
      AND A.standardised_asset_type_name IS NOT NULL
      AND J.standardised_activity_scope IS NOT NULL
      AND J.completed_date >= DATE_ADD(current_date(), -1095)
    GROUP BY A.standardised_contract_name, A.standardised_asset_type_name, J.standardised_activity_scope
),
WITH_BENCHMARK AS (
    SELECT *,
        ROUND(PERCENTILE_APPROX(jobs_per_asset_per_year, 0.5)
              OVER (PARTITION BY asset_type, activity_scope), 3) AS benchmark_median,
        ROUND(PERCENTILE_APPROX(jobs_per_asset_per_year, 0.75)
              OVER (PARTITION BY asset_type, activity_scope), 3) AS benchmark_p75,
        COUNT(*) OVER (PARTITION BY asset_type, activity_scope) AS contracts_with_this_activity
    FROM CONTRACT_JOB_RATE
)
SELECT
    standardised_contract_name,
    asset_type,
    activity_scope,
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
WHERE contracts_with_this_activity >= 3
ORDER BY pct_of_benchmark ASC
;

-- ============================================================
-- Service Line Summary
-- ============================================================
-- Table:
--   winning_bids_service_line_summary
--
-- What each row means:
--   One activity_scope rolled up across all cross-sell opportunities.
--   This answers which service lines have the broadest runway.
--
-- Use this as:
--   1. Executive scorecard / ranked list
--      Sort by estimated_total_jobs_per_year DESC.
--
--   2. Charts
--      Bar chart:
--        x = activity_scope
--        y = estimated_total_jobs_per_year
--
--      Matrix:
--        rows = activity_scope
--        values = target_contract_count, asset_type_count,
--                 total_target_asset_count
--
--   3. Narrative table
--      Show target_contracts and asset_types in single cells to explain
--      where the pitch could apply.
--
-- Business question:
--   "Which service lines are repeatable across multiple contracts,
--   rather than one-off opportunities?"
-- ============================================================

CREATE OR REPLACE TABLE transport_dev.integ_transport_assets.winning_bids_service_line_summary
USING DELTA AS
SELECT
    activity_scope,
    COUNT(DISTINCT target_contract) AS target_contract_count,
    COUNT(DISTINCT asset_type) AS asset_type_count,
    SUM(target_asset_count) AS total_target_asset_count,
    SUM(peer_job_count_3yr) AS total_peer_job_count_3yr,
    ROUND(SUM(estimated_target_jobs_per_year), 1) AS estimated_total_jobs_per_year,
    ROUND(AVG(peer_contracts_doing_it), 1) AS avg_peer_contracts_doing_it,
    ARRAY_JOIN(
        SORT_ARRAY(COLLECT_SET(target_contract)),
        ' | '
    ) AS target_contracts,
    ARRAY_JOIN(
        SORT_ARRAY(COLLECT_SET(asset_type)),
        ' | '
    ) AS asset_types,
    CASE
        WHEN COUNT(DISTINCT target_contract) >= 5
        THEN 'Broad service-line pitch across several contracts.'

        WHEN COUNT(DISTINCT target_contract) >= 3
        THEN 'Moderate service-line pitch; validate top target contracts.'

        ELSE 'Narrow pitch; use only as drill-down evidence.'
    END AS summary_reason,
    CURRENT_TIMESTAMP() AS created_ts
FROM transport_dev.integ_transport_assets.winning_bids_peer_contracts_comparison_asset_type
WHERE opportunity_confidence IN ('High', 'Medium')
GROUP BY ALL
ORDER BY
    estimated_total_jobs_per_year DESC,
    target_contract_count DESC
;

