-- ============================================================
-- TABLE DRAIN INSPECTION ANALYTICS
-- ============================================================
-- Asset type : Table Drain (standardised_asset_type_name = 'Table Drain')
-- Source     : transport_dev.integ_transport_assets.*
-- Date       : 2026-06-29
-- Contracts  : Brisbane Airport, RAMC Gen 2, WRU, IRW, PWA
-- Sources    : RAMC / BAC / PoB / TSRC group + VicRoads
-- ============================================================
-- HOW TO USE
--   Each query is self-contained — paste and run individually
--   in a Databricks SQL cell or notebook.
-- ============================================================
-- INDEX
--   STEP 0 : Discovery — confirm exact asset type name
--   Q1     : Avg inspection frequency per asset by contract & year
--   Q2     : Scheduled vs completed rate (quarterly) [note: drain caveat]
--   Q3     : Inspection latency — scheduled → completed gap
--   Q4     : Inspection type mix by contract
--   Q5     : Monthly inspection volume trend
--   Q6     : Condition vs inspection frequency (reframed)
--   Q7     : Inspection staleness — recency buckets by contract
--   Q8     : Inspection-to-job trigger rate
--   Q9     : Seasonal inspection pattern (monthly heat map)
--   Q10    : Job type triggered by inspection
--   Q11    : Inter-inspection gap (actual cycle time per asset)
--   Q12    : Asset age vs inspection frequency
--   Q13    : Photo evidence rate by contract
--   Q14    : Asset criticality vs inspection frequency
-- ============================================================


-- ============================================================
-- STEP 0: Discovery — confirm exact asset type name
-- Run this first. Use the returned name in all queries below.
-- ============================================================

SELECT
    standardised_asset_type_name,
    COUNT(DISTINCT asset_id)           AS asset_count,
    COUNT(DISTINCT source_context)     AS source_contexts,
    COUNT(DISTINCT standardised_contract_name) AS contracts
FROM transport_dev.integ_transport_assets.vw_silver_transport_asset_with_category
WHERE LOWER(standardised_asset_type_name) LIKE '%table%drain%'
   OR LOWER(standardised_asset_type_name) LIKE '%drain%table%'
GROUP BY standardised_asset_type_name
ORDER BY asset_count DESC;


-- ============================================================
-- Q1: Average inspection frequency per asset by contract & year
-- ============================================================
-- Why: Anchor query — establishes the "what" before asking "why"
-- Viz: Heatmap (rows = contract, columns = year, cell = avg frequency)
--      Grouped bar chart as alternative
-- ============================================================

WITH TABLE_DRAIN_ASSETS AS (
    SELECT DISTINCT source_context, asset_id, standardised_contract_name
    FROM transport_dev.integ_transport_assets.vw_silver_transport_asset_with_category
    WHERE standardised_asset_type_name = 'Table Drain'
      AND standardised_contract_name IS NOT NULL
),
INSP AS (
    SELECT IL.source_context, IL.inspection_id, IL.asset_id,
           I.scheduled_date, I.completed_date, I.inspection_type_name,
           I.job_id
    FROM transport_dev.integ_transport_assets.vw_silver_transport_inspection_asset_link IL
    INNER JOIN transport_dev.integ_transport_assets.vw_bronze_transport_inspection_base I
        ON IL.source_context = I.source_context
       AND IL.inspection_id  = I.inspection_id
),
PER_ASSET_YEAR AS (
    SELECT
        A.standardised_contract_name,
        A.asset_id,
        YEAR(I.completed_date)               AS yr,
        COUNT(DISTINCT I.inspection_id)      AS n
    FROM TABLE_DRAIN_ASSETS A
    INNER JOIN INSP I
        ON A.source_context = I.source_context
       AND A.asset_id       = I.asset_id
    WHERE I.completed_date IS NOT NULL
      AND YEAR(I.completed_date) BETWEEN 2021 AND 2025
    GROUP BY A.standardised_contract_name, A.asset_id, YEAR(I.completed_date)
)
SELECT
    standardised_contract_name,
    yr,
    COUNT(DISTINCT asset_id)                          AS assets_inspected,
    ROUND(AVG(n), 2)                                  AS avg_inspections_per_asset,
    ROUND(PERCENTILE_APPROX(n, 0.5), 1)               AS median_inspections_per_asset,
    MIN(n)                                            AS min_inspections,
    MAX(n)                                            AS max_inspections
FROM PER_ASSET_YEAR
GROUP BY standardised_contract_name, yr
ORDER BY standardised_contract_name, yr;


-- ============================================================
-- Q2: Scheduled vs completed rate by contract (quarterly)
-- ============================================================
-- Why: Checks whether contracts deliver what they plan
-- Caveat: Table drain inspections are often logged at job completion
--   (same-day record), not pre-scheduled. The "same_day_pct" column
--   flags how many completions have no meaningful scheduling lead time.
--   Treat these as reactive rather than planned inspections.
-- Viz: Dual-axis bar+line per contract (bars = scheduled/completed
--      volumes, line = completion %)
-- ============================================================

WITH TABLE_DRAIN_ASSETS AS (
    SELECT DISTINCT source_context, asset_id, standardised_contract_name
    FROM transport_dev.integ_transport_assets.vw_silver_transport_asset_with_category
    WHERE standardised_asset_type_name = 'Table Drain'
      AND standardised_contract_name IS NOT NULL
),
INSP AS (
    SELECT IL.source_context, IL.inspection_id, IL.asset_id,
           I.scheduled_date, I.completed_date, I.inspection_type_name,
           I.job_id
    FROM transport_dev.integ_transport_assets.vw_silver_transport_inspection_asset_link IL
    INNER JOIN transport_dev.integ_transport_assets.vw_bronze_transport_inspection_base I
        ON IL.source_context = I.source_context
       AND IL.inspection_id  = I.inspection_id
)
SELECT
    A.standardised_contract_name,
    DATE_TRUNC('QUARTER', I.scheduled_date)                AS quarter,
    COUNT(DISTINCT I.inspection_id)                        AS total_scheduled,
    COUNT(DISTINCT CASE WHEN I.completed_date IS NOT NULL
                        THEN I.inspection_id END)          AS total_completed,
    ROUND(
        100.0 * COUNT(DISTINCT CASE WHEN I.completed_date IS NOT NULL
                                    THEN I.inspection_id END)
        / NULLIF(COUNT(DISTINCT I.inspection_id), 0), 1
    )                                                      AS completion_pct,
    -- Flag same-day completions (reactive / job-triggered records)
    ROUND(
        100.0 * COUNT(DISTINCT CASE
            WHEN I.completed_date IS NOT NULL
             AND DATEDIFF(I.completed_date, I.scheduled_date) = 0
            THEN I.inspection_id END)
        / NULLIF(COUNT(DISTINCT I.inspection_id), 0), 1
    )                                                      AS same_day_completion_pct
FROM TABLE_DRAIN_ASSETS A
INNER JOIN INSP I
    ON A.source_context = I.source_context
   AND A.asset_id       = I.asset_id
WHERE I.scheduled_date IS NOT NULL
  AND I.scheduled_date BETWEEN '2022-01-01' AND current_date()
GROUP BY A.standardised_contract_name, DATE_TRUNC('QUARTER', I.scheduled_date)
ORDER BY A.standardised_contract_name, quarter;


-- ============================================================
-- Q3: Inspection latency — scheduled to completed gap
-- ============================================================
-- Why: Shows whether contracts are completing on time, early, or late
-- Note: Negative delta = completed before scheduled date (early / reactive)
-- Viz: Horizontal box-whisker per contract sorted by avg_days_delta DESC
--      Lollipop chart showing avg + p90 works well as a simpler alternative
-- ============================================================

WITH TABLE_DRAIN_ASSETS AS (
    SELECT DISTINCT source_context, asset_id, standardised_contract_name
    FROM transport_dev.integ_transport_assets.vw_silver_transport_asset_with_category
    WHERE standardised_asset_type_name = 'Table Drain'
      AND standardised_contract_name IS NOT NULL
),
INSP AS (
    SELECT IL.source_context, IL.inspection_id, IL.asset_id,
           I.scheduled_date, I.completed_date, I.inspection_type_name,
           I.job_id
    FROM transport_dev.integ_transport_assets.vw_silver_transport_inspection_asset_link IL
    INNER JOIN transport_dev.integ_transport_assets.vw_bronze_transport_inspection_base I
        ON IL.source_context = I.source_context
       AND IL.inspection_id  = I.inspection_id
)
SELECT
    A.standardised_contract_name,
    COUNT(DISTINCT I.inspection_id)                                         AS n,
    ROUND(AVG(DATEDIFF(I.completed_date, I.scheduled_date)), 1)             AS avg_days_delta,
    ROUND(PERCENTILE_APPROX(DATEDIFF(I.completed_date, I.scheduled_date), 0.25), 0) AS p25_days_delta,
    ROUND(PERCENTILE_APPROX(DATEDIFF(I.completed_date, I.scheduled_date), 0.5), 0)  AS median_days_delta,
    ROUND(PERCENTILE_APPROX(DATEDIFF(I.completed_date, I.scheduled_date), 0.75), 0) AS p75_days_delta,
    ROUND(PERCENTILE_APPROX(DATEDIFF(I.completed_date, I.scheduled_date), 0.9), 0)  AS p90_days_delta,
    SUM(CASE WHEN I.completed_date <= I.scheduled_date THEN 1 ELSE 0 END)   AS on_time_or_early,
    SUM(CASE WHEN I.completed_date  > I.scheduled_date THEN 1 ELSE 0 END)   AS late
FROM TABLE_DRAIN_ASSETS A
INNER JOIN INSP I
    ON A.source_context = I.source_context
   AND A.asset_id       = I.asset_id
WHERE I.scheduled_date IS NOT NULL
  AND I.completed_date IS NOT NULL
GROUP BY A.standardised_contract_name
ORDER BY avg_days_delta DESC;


-- ============================================================
-- Q4: Inspection type mix by contract
-- ============================================================
-- Why: Frequency differences may be driven by inspection *type*, not volume
--      A contract doing mostly event-driven inspections will have naturally
--      different frequency than one doing routine scheduled inspections
-- Viz: 100% stacked bar (contract on x-axis, type as colour segments)
-- ============================================================

WITH TABLE_DRAIN_ASSETS AS (
    SELECT DISTINCT source_context, asset_id, standardised_contract_name
    FROM transport_dev.integ_transport_assets.vw_silver_transport_asset_with_category
    WHERE standardised_asset_type_name = 'Table Drain'
      AND standardised_contract_name IS NOT NULL
),
INSP AS (
    SELECT IL.source_context, IL.inspection_id, IL.asset_id,
           I.scheduled_date, I.completed_date, I.inspection_type_name,
           I.job_id
    FROM transport_dev.integ_transport_assets.vw_silver_transport_inspection_asset_link IL
    INNER JOIN transport_dev.integ_transport_assets.vw_bronze_transport_inspection_base I
        ON IL.source_context = I.source_context
       AND IL.inspection_id  = I.inspection_id
)
SELECT
    A.standardised_contract_name,
    COALESCE(I.inspection_type_name, 'Unknown')                AS inspection_type,
    COUNT(DISTINCT I.inspection_id)                            AS n,
    ROUND(
        100.0 * COUNT(DISTINCT I.inspection_id)
        / SUM(COUNT(DISTINCT I.inspection_id))
              OVER (PARTITION BY A.standardised_contract_name), 1
    )                                                          AS pct_of_contract_total
FROM TABLE_DRAIN_ASSETS A
INNER JOIN INSP I
    ON A.source_context = I.source_context
   AND A.asset_id       = I.asset_id
GROUP BY
    A.standardised_contract_name,
    COALESCE(I.inspection_type_name, 'Unknown')
ORDER BY A.standardised_contract_name, n DESC;


-- ============================================================
-- Q5: Monthly inspection volume trend by contract
-- ============================================================
-- Why: Reveals seasonality, post-storm surges, and contract
--      start/end cliff edges
-- Viz: Multi-line chart (one line per contract, x = month, y = count)
-- ============================================================

WITH TABLE_DRAIN_ASSETS AS (
    SELECT DISTINCT source_context, asset_id, standardised_contract_name
    FROM transport_dev.integ_transport_assets.vw_silver_transport_asset_with_category
    WHERE standardised_asset_type_name = 'Table Drain'
      AND standardised_contract_name IS NOT NULL
),
INSP AS (
    SELECT IL.source_context, IL.inspection_id, IL.asset_id,
           I.scheduled_date, I.completed_date, I.inspection_type_name,
           I.job_id
    FROM transport_dev.integ_transport_assets.vw_silver_transport_inspection_asset_link IL
    INNER JOIN transport_dev.integ_transport_assets.vw_bronze_transport_inspection_base I
        ON IL.source_context = I.source_context
       AND IL.inspection_id  = I.inspection_id
)
SELECT
    A.standardised_contract_name,
    DATE_TRUNC('MONTH', I.completed_date)   AS completed_month,
    COUNT(DISTINCT I.inspection_id)         AS inspections_completed
FROM TABLE_DRAIN_ASSETS A
INNER JOIN INSP I
    ON A.source_context = I.source_context
   AND A.asset_id       = I.asset_id
WHERE I.completed_date BETWEEN '2022-01-01' AND current_date()
GROUP BY A.standardised_contract_name, DATE_TRUNC('MONTH', I.completed_date)
ORDER BY A.standardised_contract_name, completed_month;


-- ============================================================
-- Q6: Asset condition vs inspection frequency (reframed)
-- ============================================================
-- Why: Asks "do contracts with lower inspection frequency have worse
--      average condition?" rather than implying causation.
--      62% condition coverage — results are directional, not definitive.
-- Viz: Scatter plot (x = avg_inspections_per_year, y = avg_condition_score,
--      one point per contract). Annotate each point with contract name.
-- ============================================================

WITH TABLE_DRAIN_ASSETS AS (
    SELECT DISTINCT
        source_context, asset_id, standardised_contract_name, asset_condition
    FROM transport_dev.integ_transport_assets.vw_silver_transport_asset_with_category
    WHERE standardised_asset_type_name = 'Table Drain'
      AND standardised_contract_name IS NOT NULL
),
INSP AS (
    SELECT IL.source_context, IL.inspection_id, IL.asset_id,
           I.scheduled_date, I.completed_date, I.inspection_type_name,
           I.job_id
    FROM transport_dev.integ_transport_assets.vw_silver_transport_inspection_asset_link IL
    INNER JOIN transport_dev.integ_transport_assets.vw_bronze_transport_inspection_base I
        ON IL.source_context = I.source_context
       AND IL.inspection_id  = I.inspection_id
),
ASSET_INSPECTIONS AS (
    SELECT
        A.source_context, A.asset_id, A.standardised_contract_name, A.asset_condition,
        COUNT(DISTINCT I.inspection_id)      AS total_inspections,
        MIN(I.completed_date)                AS first_inspection,
        MAX(I.completed_date)                AS last_inspection,
        DATEDIFF(MAX(I.completed_date), MIN(I.completed_date)) / 365.25 AS years_observed
    FROM TABLE_DRAIN_ASSETS A
    LEFT JOIN INSP I
        ON A.source_context = I.source_context
       AND A.asset_id       = I.asset_id
      AND I.completed_date IS NOT NULL
    WHERE A.asset_condition IS NOT NULL
    GROUP BY A.source_context, A.asset_id, A.standardised_contract_name, A.asset_condition
)
SELECT
    standardised_contract_name,
    asset_condition,
    COUNT(DISTINCT asset_id)                                             AS asset_count,
    ROUND(AVG(total_inspections), 2)                                     AS avg_total_inspections,
    ROUND(AVG(CASE WHEN years_observed > 0
                   THEN total_inspections / years_observed END), 2)     AS avg_inspections_per_year,
    ROUND(PERCENTILE_APPROX(total_inspections, 0.5), 1)                  AS median_total_inspections
FROM ASSET_INSPECTIONS
GROUP BY standardised_contract_name, asset_condition
ORDER BY standardised_contract_name, asset_condition;


-- ============================================================
-- Q7: Inspection staleness — recency buckets by contract
-- ============================================================
-- Why: Flags operational risk — drains not inspected recently may be
--      blocked, causing flooding. Immediately actionable.
-- Viz: 100% stacked horizontal bar (contract per row, colour = recency
--      bucket from green/recent to red/never)
-- ============================================================

WITH TABLE_DRAIN_ASSETS AS (
    SELECT DISTINCT source_context, asset_id, standardised_contract_name
    FROM transport_dev.integ_transport_assets.vw_silver_transport_asset_with_category
    WHERE standardised_asset_type_name = 'Table Drain'
      AND standardised_contract_name IS NOT NULL
),
INSP AS (
    SELECT IL.source_context, IL.inspection_id, IL.asset_id,
           I.scheduled_date, I.completed_date, I.inspection_type_name,
           I.job_id
    FROM transport_dev.integ_transport_assets.vw_silver_transport_inspection_asset_link IL
    INNER JOIN transport_dev.integ_transport_assets.vw_bronze_transport_inspection_base I
        ON IL.source_context = I.source_context
       AND IL.inspection_id  = I.inspection_id
),
LAST_INSP AS (
    SELECT
        A.source_context, A.asset_id, A.standardised_contract_name,
        MAX(I.completed_date) AS last_date
    FROM TABLE_DRAIN_ASSETS A
    LEFT JOIN INSP I
        ON A.source_context = I.source_context
       AND A.asset_id       = I.asset_id
      AND I.completed_date IS NOT NULL
    GROUP BY A.source_context, A.asset_id, A.standardised_contract_name
)
SELECT
    standardised_contract_name,
    COUNT(DISTINCT asset_id)                                                        AS total_assets,
    SUM(CASE WHEN last_date IS NULL THEN 1 ELSE 0 END)                              AS never_inspected,
    SUM(CASE WHEN DATEDIFF(current_date(), last_date) <= 90  THEN 1 ELSE 0 END)     AS within_90d,
    SUM(CASE WHEN DATEDIFF(current_date(), last_date) BETWEEN 91  AND 180
             THEN 1 ELSE 0 END)                                                     AS d91_to_180,
    SUM(CASE WHEN DATEDIFF(current_date(), last_date) BETWEEN 181 AND 365
             THEN 1 ELSE 0 END)                                                     AS d181_to_365,
    SUM(CASE WHEN DATEDIFF(current_date(), last_date) > 365  THEN 1 ELSE 0 END)     AS over_365d,
    ROUND(AVG(CASE WHEN last_date IS NOT NULL
                   THEN DATEDIFF(current_date(), last_date) END), 0)                AS avg_days_since_last_inspection
FROM LAST_INSP
GROUP BY standardised_contract_name
ORDER BY avg_days_since_last_inspection DESC NULLS LAST;


-- ============================================================
-- Q8: Inspection-to-job trigger rate by contract
-- ============================================================
-- Why: A low rate may mean inspections are perfunctory (no defects
--      found or not being linked). A very high rate may mean the
--      asset class is systematically deteriorating.
-- Viz: Horizontal bar chart sorted high-to-low, dashed line at average
-- ============================================================

WITH TABLE_DRAIN_ASSETS AS (
    SELECT DISTINCT source_context, asset_id, standardised_contract_name
    FROM transport_dev.integ_transport_assets.vw_silver_transport_asset_with_category
    WHERE standardised_asset_type_name = 'Table Drain'
      AND standardised_contract_name IS NOT NULL
),
INSP AS (
    SELECT IL.source_context, IL.inspection_id, IL.asset_id,
           I.scheduled_date, I.completed_date, I.inspection_type_name,
           I.job_id
    FROM transport_dev.integ_transport_assets.vw_silver_transport_inspection_asset_link IL
    INNER JOIN transport_dev.integ_transport_assets.vw_bronze_transport_inspection_base I
        ON IL.source_context = I.source_context
       AND IL.inspection_id  = I.inspection_id
)
SELECT
    A.standardised_contract_name,
    COUNT(DISTINCT I.inspection_id)                                             AS total_inspections,
    COUNT(DISTINCT CASE WHEN I.job_id IS NOT NULL THEN I.inspection_id END)     AS inspections_with_job,
    COUNT(DISTINCT CASE WHEN I.job_id IS NULL     THEN I.inspection_id END)     AS inspections_no_job,
    ROUND(
        100.0 * COUNT(DISTINCT CASE WHEN I.job_id IS NOT NULL THEN I.inspection_id END)
        / NULLIF(COUNT(DISTINCT I.inspection_id), 0), 1
    )                                                                           AS trigger_rate_pct
FROM TABLE_DRAIN_ASSETS A
INNER JOIN INSP I
    ON A.source_context = I.source_context
   AND A.asset_id       = I.asset_id
GROUP BY A.standardised_contract_name
ORDER BY trigger_rate_pct DESC;


-- ============================================================
-- Q9: Seasonal inspection pattern — monthly heat map
-- ============================================================
-- Why: Most likely explanation for frequency differences between contracts.
--      A winter-rain spike in one contract but flat pattern in another
--      signals reactive vs proactive maintenance philosophy, not
--      a compliance gap.
-- Viz: Heat map (rows = contract, columns = month 1-12,
--      cell colour = inspection count normalised per contract)
--      Radar/spider chart per contract as an alternative
-- ============================================================

WITH TABLE_DRAIN_ASSETS AS (
    SELECT DISTINCT source_context, asset_id, standardised_contract_name
    FROM transport_dev.integ_transport_assets.vw_silver_transport_asset_with_category
    WHERE standardised_asset_type_name = 'Table Drain'
      AND standardised_contract_name IS NOT NULL
),
INSP AS (
    SELECT IL.source_context, IL.inspection_id, IL.asset_id,
           I.scheduled_date, I.completed_date, I.inspection_type_name,
           I.job_id
    FROM transport_dev.integ_transport_assets.vw_silver_transport_inspection_asset_link IL
    INNER JOIN transport_dev.integ_transport_assets.vw_bronze_transport_inspection_base I
        ON IL.source_context = I.source_context
       AND IL.inspection_id  = I.inspection_id
)
SELECT
    A.standardised_contract_name,
    MONTH(I.completed_date)                   AS month_num,
    date_format(I.completed_date, 'MMM')      AS month_name,
    COUNT(DISTINCT I.inspection_id)           AS inspections,
    ROUND(
        100.0 * COUNT(DISTINCT I.inspection_id)
        / SUM(COUNT(DISTINCT I.inspection_id))
              OVER (PARTITION BY A.standardised_contract_name), 1
    )                                         AS pct_of_annual_total
FROM TABLE_DRAIN_ASSETS A
INNER JOIN INSP I
    ON A.source_context = I.source_context
   AND A.asset_id       = I.asset_id
WHERE I.completed_date IS NOT NULL
  AND YEAR(I.completed_date) BETWEEN 2022 AND 2025
GROUP BY
    A.standardised_contract_name,
    MONTH(I.completed_date),
    date_format(I.completed_date, 'MMM')
ORDER BY A.standardised_contract_name, month_num;


-- ============================================================
-- Q10: Job type triggered by inspection
-- ============================================================
-- Why: Cleaning jobs = routine maintenance working as intended.
--      Repair/replacement jobs = asset condition is deteriorating.
--      Ratio of these two signals the health of the drainage network
--      and the effectiveness of the inspection regime.
-- Viz: 100% stacked bar (contract on x-axis, job type as segments).
--      "No linked job" segment is itself a finding.
-- ============================================================

WITH TABLE_DRAIN_ASSETS AS (
    SELECT DISTINCT source_context, asset_id, standardised_contract_name
    FROM transport_dev.integ_transport_assets.vw_silver_transport_asset_with_category
    WHERE standardised_asset_type_name = 'Table Drain'
      AND standardised_contract_name IS NOT NULL
),
INSP AS (
    SELECT IL.source_context, IL.inspection_id, IL.asset_id,
           I.scheduled_date, I.completed_date, I.inspection_type_name,
           I.job_id
    FROM transport_dev.integ_transport_assets.vw_silver_transport_inspection_asset_link IL
    INNER JOIN transport_dev.integ_transport_assets.vw_bronze_transport_inspection_base I
        ON IL.source_context = I.source_context
       AND IL.inspection_id  = I.inspection_id
)
SELECT
    A.standardised_contract_name,
    COALESCE(J.activity_category_name, 'No linked job')   AS activity_category,
    COALESCE(J.activity_name,          'No linked job')   AS activity_name,
    COUNT(DISTINCT I.inspection_id)                       AS inspection_count,
    ROUND(
        100.0 * COUNT(DISTINCT I.inspection_id)
        / SUM(COUNT(DISTINCT I.inspection_id))
              OVER (PARTITION BY A.standardised_contract_name), 1
    )                                                     AS pct_of_contract_total
FROM TABLE_DRAIN_ASSETS A
INNER JOIN INSP I
    ON A.source_context = I.source_context
   AND A.asset_id       = I.asset_id
LEFT JOIN transport_dev.integ_transport_assets.vw_bronze_transport_job_base J
    ON I.source_context = J.source_context
   AND I.job_id         = J.job_id
WHERE I.completed_date IS NOT NULL
GROUP BY
    A.standardised_contract_name,
    COALESCE(J.activity_category_name, 'No linked job'),
    COALESCE(J.activity_name,          'No linked job')
ORDER BY A.standardised_contract_name, inspection_count DESC;


-- ============================================================
-- Q11: Inter-inspection gap — actual cycle time per asset
-- ============================================================
-- Why: Average frequency (Q1) masks what actually happens to individual
--      assets. This shows the real distribution of gaps between
--      consecutive inspections — some assets may be inspected every
--      3 months while others sit untouched for 2 years, even within
--      the same contract.
-- Viz: Box-whisker per contract showing p25/median/p75/p90 gap in days.
--      Add a reference line at contractual requirement if known.
-- ============================================================

WITH TABLE_DRAIN_ASSETS AS (
    SELECT DISTINCT source_context, asset_id, standardised_contract_name
    FROM transport_dev.integ_transport_assets.vw_silver_transport_asset_with_category
    WHERE standardised_asset_type_name = 'Table Drain'
      AND standardised_contract_name IS NOT NULL
),
INSP AS (
    SELECT IL.source_context, IL.inspection_id, IL.asset_id,
           I.scheduled_date, I.completed_date, I.inspection_type_name,
           I.job_id
    FROM transport_dev.integ_transport_assets.vw_silver_transport_inspection_asset_link IL
    INNER JOIN transport_dev.integ_transport_assets.vw_bronze_transport_inspection_base I
        ON IL.source_context = I.source_context
       AND IL.inspection_id  = I.inspection_id
),
ORDERED_INSPECTIONS AS (
    SELECT
        A.source_context,
        A.asset_id,
        A.standardised_contract_name,
        I.inspection_id,
        I.completed_date,
        LAG(I.completed_date) OVER (
            PARTITION BY A.source_context, A.asset_id
            ORDER BY I.completed_date
        ) AS prev_completed_date
    FROM TABLE_DRAIN_ASSETS A
    INNER JOIN INSP I
        ON A.source_context = I.source_context
       AND A.asset_id       = I.asset_id
    WHERE I.completed_date IS NOT NULL
),
GAPS AS (
    SELECT
        standardised_contract_name,
        DATEDIFF(completed_date, prev_completed_date) AS gap_days
    FROM ORDERED_INSPECTIONS
    WHERE prev_completed_date IS NOT NULL
      AND DATEDIFF(completed_date, prev_completed_date) > 0
)
SELECT
    standardised_contract_name,
    COUNT(*)                                           AS gap_intervals_measured,
    ROUND(AVG(gap_days), 0)                            AS avg_gap_days,
    ROUND(PERCENTILE_APPROX(gap_days, 0.25), 0)        AS p25_gap_days,
    ROUND(PERCENTILE_APPROX(gap_days, 0.5),  0)        AS median_gap_days,
    ROUND(PERCENTILE_APPROX(gap_days, 0.75), 0)        AS p75_gap_days,
    ROUND(PERCENTILE_APPROX(gap_days, 0.90), 0)        AS p90_gap_days,
    MIN(gap_days)                                      AS min_gap_days,
    MAX(gap_days)                                      AS max_gap_days
FROM GAPS
GROUP BY standardised_contract_name
ORDER BY avg_gap_days;


-- ============================================================
-- Q12: Asset age vs inspection frequency
-- ============================================================
-- Why: Do newer assets get more attention (warranty/defect period)?
--      Or do older, degraded assets attract more inspections?
--      Understanding this helps explain whether inspection effort is
--      risk-based or driven by contract age/lifecycle.
-- Viz: Scatter plot (x = asset_age_years, y = inspections_per_year,
--      colour = contract). Add a trend line per contract.
-- ============================================================

WITH TABLE_DRAIN_ASSETS AS (
    SELECT DISTINCT
        source_context, asset_id, standardised_contract_name, construction_date
    FROM transport_dev.integ_transport_assets.vw_silver_transport_asset_with_category
    WHERE standardised_asset_type_name = 'Table Drain'
      AND standardised_contract_name IS NOT NULL
      AND construction_date IS NOT NULL
),
INSP AS (
    SELECT IL.source_context, IL.inspection_id, IL.asset_id,
           I.scheduled_date, I.completed_date, I.inspection_type_name,
           I.job_id
    FROM transport_dev.integ_transport_assets.vw_silver_transport_inspection_asset_link IL
    INNER JOIN transport_dev.integ_transport_assets.vw_bronze_transport_inspection_base I
        ON IL.source_context = I.source_context
       AND IL.inspection_id  = I.inspection_id
),
ASSET_STATS AS (
    SELECT
        A.source_context,
        A.asset_id,
        A.standardised_contract_name,
        ROUND(DATEDIFF(current_date(), A.construction_date) / 365.25, 1) AS asset_age_years,
        COUNT(DISTINCT I.inspection_id)                                   AS total_inspections,
        ROUND(
            COUNT(DISTINCT I.inspection_id)
            / NULLIF(DATEDIFF(current_date(), A.construction_date) / 365.25, 0), 2
        )                                                                 AS inspections_per_year
    FROM TABLE_DRAIN_ASSETS A
    LEFT JOIN INSP I
        ON A.source_context = I.source_context
       AND A.asset_id       = I.asset_id
      AND I.completed_date IS NOT NULL
    GROUP BY A.source_context, A.asset_id, A.standardised_contract_name, A.construction_date
)
SELECT
    standardised_contract_name,
    -- Age buckets for grouped analysis
    CASE
        WHEN asset_age_years < 2  THEN '0–2 yrs (new)'
        WHEN asset_age_years < 5  THEN '2–5 yrs'
        WHEN asset_age_years < 10 THEN '5–10 yrs'
        WHEN asset_age_years < 20 THEN '10–20 yrs'
        ELSE '20+ yrs (mature)'
    END                                                AS age_bucket,
    COUNT(DISTINCT asset_id)                           AS asset_count,
    ROUND(AVG(asset_age_years), 1)                     AS avg_age_years,
    ROUND(AVG(inspections_per_year), 2)                AS avg_inspections_per_year,
    ROUND(AVG(total_inspections), 1)                   AS avg_total_inspections
FROM ASSET_STATS
GROUP BY
    standardised_contract_name,
    CASE
        WHEN asset_age_years < 2  THEN '0–2 yrs (new)'
        WHEN asset_age_years < 5  THEN '2–5 yrs'
        WHEN asset_age_years < 10 THEN '5–10 yrs'
        WHEN asset_age_years < 20 THEN '10–20 yrs'
        ELSE '20+ yrs (mature)'
    END
ORDER BY standardised_contract_name, avg_age_years;


-- ============================================================
-- Q13: Photo evidence rate by contract
-- ============================================================
-- Why: Contracts with systematic photo capture have better audit
--      trails and typically more thorough inspection culture.
--      A low photo rate relative to inspections may indicate
--      inspections are being recorded without physical attendance.
-- Viz: Grouped bar chart (contract on x-axis, two bars per contract:
--      assets_with_photos vs assets_without_photos)
-- ============================================================

WITH TABLE_DRAIN_ASSETS AS (
    SELECT DISTINCT source_context, asset_id, standardised_contract_name
    FROM transport_dev.integ_transport_assets.vw_silver_transport_asset_with_category
    WHERE standardised_asset_type_name = 'Table Drain'
      AND standardised_contract_name IS NOT NULL
),
PHOTOS AS (
    SELECT DISTINCT P.source_context, P.asset_id,
                    COUNT(DISTINCT P.photo_id) AS photo_count
    FROM transport_dev.integ_transport_assets.vw_silver_transport_photo_asset_link P
    GROUP BY P.source_context, P.asset_id
),
INSP_COUNT AS (
    SELECT IL.source_context, IL.asset_id,
           COUNT(DISTINCT IL.inspection_id) AS inspection_count
    FROM transport_dev.integ_transport_assets.vw_silver_transport_inspection_asset_link IL
    INNER JOIN transport_dev.integ_transport_assets.vw_bronze_transport_inspection_base I
        ON IL.source_context = I.source_context
       AND IL.inspection_id  = I.inspection_id
    WHERE I.completed_date IS NOT NULL
    GROUP BY IL.source_context, IL.asset_id
)
SELECT
    A.standardised_contract_name,
    COUNT(DISTINCT A.asset_id)                                              AS total_assets,
    COUNT(DISTINCT CASE WHEN P.photo_count IS NOT NULL THEN A.asset_id END) AS assets_with_photos,
    ROUND(
        100.0 * COUNT(DISTINCT CASE WHEN P.photo_count IS NOT NULL THEN A.asset_id END)
        / NULLIF(COUNT(DISTINCT A.asset_id), 0), 1
    )                                                                       AS photo_coverage_pct,
    ROUND(AVG(COALESCE(P.photo_count, 0)), 2)                               AS avg_photos_per_asset,
    ROUND(AVG(COALESCE(IC.inspection_count, 0)), 2)                         AS avg_inspections_per_asset,
    -- Photos per inspection as a data quality proxy
    ROUND(
        SUM(COALESCE(P.photo_count, 0))
        / NULLIF(SUM(COALESCE(IC.inspection_count, 0)), 0), 2
    )                                                                       AS photos_per_inspection
FROM TABLE_DRAIN_ASSETS A
LEFT JOIN PHOTOS P
    ON A.source_context = P.source_context AND A.asset_id = P.asset_id
LEFT JOIN INSP_COUNT IC
    ON A.source_context = IC.source_context AND A.asset_id = IC.asset_id
GROUP BY A.standardised_contract_name
ORDER BY photo_coverage_pct DESC;


-- ============================================================
-- Q14: Asset criticality vs inspection frequency
-- ============================================================
-- Why: Validates whether inspection effort is risk-based.
--      High-criticality drains should theoretically receive more
--      frequent inspections. If they don't, the contract's inspection
--      regime is not risk-prioritised.
-- Note: 60% criticality coverage for Table Drain — partial picture.
-- Viz: Grouped bar chart (criticality level on x-axis, bars per contract)
-- ============================================================

WITH TABLE_DRAIN_ASSETS AS (
    SELECT DISTINCT
        source_context, asset_id, standardised_contract_name, asset_criticality
    FROM transport_dev.integ_transport_assets.vw_silver_transport_asset_with_category
    WHERE standardised_asset_type_name = 'Table Drain'
      AND standardised_contract_name IS NOT NULL
      AND asset_criticality IS NOT NULL
),
INSP AS (
    SELECT IL.source_context, IL.inspection_id, IL.asset_id,
           I.completed_date
    FROM transport_dev.integ_transport_assets.vw_silver_transport_inspection_asset_link IL
    INNER JOIN transport_dev.integ_transport_assets.vw_bronze_transport_inspection_base I
        ON IL.source_context = I.source_context
       AND IL.inspection_id  = I.inspection_id
    WHERE I.completed_date IS NOT NULL
),
ASSET_INSP_COUNT AS (
    SELECT
        A.source_context, A.asset_id, A.standardised_contract_name, A.asset_criticality,
        COUNT(DISTINCT I.inspection_id) AS total_inspections
    FROM TABLE_DRAIN_ASSETS A
    LEFT JOIN INSP I
        ON A.source_context = I.source_context
       AND A.asset_id       = I.asset_id
    GROUP BY A.source_context, A.asset_id, A.standardised_contract_name, A.asset_criticality
)
SELECT
    standardised_contract_name,
    asset_criticality,
    COUNT(DISTINCT asset_id)                           AS asset_count,
    ROUND(AVG(total_inspections), 2)                   AS avg_total_inspections,
    ROUND(PERCENTILE_APPROX(total_inspections, 0.5), 1) AS median_total_inspections,
    SUM(CASE WHEN total_inspections = 0 THEN 1 ELSE 0 END) AS never_inspected_count
FROM ASSET_INSP_COUNT
GROUP BY standardised_contract_name, asset_criticality
ORDER BY standardised_contract_name, asset_criticality;
