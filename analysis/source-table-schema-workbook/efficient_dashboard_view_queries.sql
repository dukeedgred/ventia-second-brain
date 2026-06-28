-- Efficient Databricks SQL for the transport asset dashboard.
--
-- Replace `your_catalog.your_schema` with the writable schema you now have.
-- Run Section 1 after source refresh. Build dashboard visuals from Section 2 tables.
--
-- Why this is faster than the original dashboard queries:
-- 1. The seven source UNION ALL blocks are materialised once.
-- 2. WKT lon/lat regex extraction is materialised once.
-- 3. Asset/job/inspection/photo summaries are pre-aggregated once.
-- 4. Dashboard widgets read compact prepared tables instead of repeating source scans.

-- =============================================================================
-- Section 1. Medallion tables
-- =============================================================================

CREATE OR REPLACE TABLE your_catalog.your_schema.silver_transport_asset AS
WITH raw_assets AS (
  SELECT 'RAMC / BAC / PoB / TSRC group' AS source_label, Contract, AssetType, ID, AssetCondition, AssetRisk, AssetCriticality, ChainageFrom, ChainageTo
  FROM ext_mssql_asset_vision_ven_gen7.dbo.asset
  WHERE COALESCE(Deleted, false) = false

  UNION ALL
  SELECT 'RMS', Contract, AssetType, ID, AssetCondition, AssetRisk, AssetCriticality, ChainageFrom, ChainageTo
  FROM ext_mssql_asset_vision_ven_rms.dbo.asset
  WHERE COALESCE(Deleted, false) = false

  UNION ALL
  SELECT 'RMS new', Contract, AssetType, ID, AssetCondition, AssetRisk, AssetCriticality, ChainageFrom, ChainageTo
  FROM ext_mssql_asset_vision_ven_rms_new.dbo.asset
  WHERE COALESCE(Deleted, false) = false

  UNION ALL
  SELECT 'VicRoads', Contract, AssetType, ID, AssetCondition, AssetRisk, AssetCriticality, ChainageFrom, ChainageTo
  FROM ext_mssql_asset_vision_ven_vicroads.dbo.asset
  WHERE COALESCE(Deleted, false) = false

  UNION ALL
  SELECT 'VNS', Contract, AssetType, ID, AssetCondition, AssetRisk, AssetCriticality, ChainageFrom, ChainageTo
  FROM ext_mssql_asset_vision_vns_gen7.dbo.asset
  WHERE COALESCE(Deleted, false) = false

  UNION ALL
  SELECT 'VNZ', Contract, AssetType, ID, AssetCondition, AssetRisk, AssetCriticality, ChainageFrom, ChainageTo
  FROM ext_mssql_asset_vision_vnz_gen7.dbo.asset
  WHERE COALESCE(Deleted, false) = false

  UNION ALL
  SELECT 'VentureSmart', Contract, AssetType, ID, AssetCondition, AssetRisk, AssetCriticality, ChainageFrom, ChainageTo
  FROM ext_mssql_asset_vision_vsm_gen7.dbo.asset
  WHERE COALESCE(Deleted, false) = false
),
normalised AS (
  SELECT
    source_label,
    COALESCE(NULLIF(TRIM(CAST(Contract AS STRING)), ''), 'Unknown') AS contract,
    COALESCE(NULLIF(TRIM(CAST(AssetType AS STRING)), ''), 'Unspecified') AS asset_type,
    CAST(ID AS BIGINT) AS asset_id_bigint,
    CAST(ID AS STRING) AS asset_id,
    COALESCE(NULLIF(TRIM(CAST(AssetCondition AS STRING)), ''), 'Not supplied') AS asset_condition,
    COALESCE(NULLIF(TRIM(CAST(AssetRisk AS STRING)), ''), 'Not supplied') AS asset_risk,
    COALESCE(NULLIF(TRIM(CAST(AssetCriticality AS STRING)), ''), 'Not supplied') AS criticality_raw,
    LOWER(TRIM(CAST(AssetCriticality AS STRING))) AS criticality_lc,
    TRY_CAST(ChainageFrom AS DOUBLE) AS chainage_from,
    TRY_CAST(ChainageTo AS DOUBLE) AS chainage_to
  FROM raw_assets
)
SELECT
  source_label,
  contract,
  asset_type,
  asset_id_bigint,
  asset_id,
  asset_condition,
  asset_risk,
  criticality_raw,
  chainage_from,
  chainage_to,
  CASE
    WHEN chainage_from IS NOT NULL
      AND chainage_to IS NOT NULL
      AND ABS(chainage_to - chainage_from) > 0
      AND ABS(chainage_to - chainage_from) < 1000000
    THEN ROUND(ABS(chainage_to - chainage_from) / 1000.0, 3)
    ELSE NULL
  END AS chainage_length_km_proxy,
  CASE
    WHEN criticality_raw = 'Not supplied' THEN 'Not supplied'
    WHEN criticality_lc RLIKE '^(n/?a|na|n[.]?a[.]?|none|null|not applicable|unknown)$' THEN 'Not supplied'
    WHEN criticality_lc RLIKE 'non[- ]?critical|not critical' THEN 'Low'
    WHEN criticality_lc RLIKE '(^|[^a-z])critical([^a-z]|$)' THEN 'Critical'
    WHEN criticality_lc RLIKE 'very[ -]?high|extreme|severe' THEN 'Very High'
    WHEN criticality_lc RLIKE '(^|[^a-z])high([^a-z]|$)' THEN 'High'
    WHEN criticality_lc RLIKE 'medium|moderate|(^|[^a-z])med([^a-z]|$)' THEN 'Medium'
    WHEN criticality_lc RLIKE 'very[ -]?low' THEN 'Very Low'
    WHEN criticality_lc RLIKE 'negligible|negligable|insignificant' THEN 'Negligible'
    WHEN criticality_lc RLIKE '(^|[^a-z])low([^a-z]|$)|minor' THEN 'Low'
    ELSE 'Other'
  END AS criticality_standardised,
  CASE
    WHEN criticality_raw = 'Not supplied' THEN NULL
    WHEN criticality_lc RLIKE '^(n/?a|na|n[.]?a[.]?|none|null|not applicable|unknown)$' THEN NULL
    WHEN criticality_lc RLIKE 'non[- ]?critical|not critical' THEN 2
    WHEN criticality_lc RLIKE '(^|[^a-z])critical([^a-z]|$)' THEN 6
    WHEN criticality_lc RLIKE 'very[ -]?high|extreme|severe' THEN 5
    WHEN criticality_lc RLIKE '(^|[^a-z])high([^a-z]|$)' THEN 4
    WHEN criticality_lc RLIKE 'medium|moderate|(^|[^a-z])med([^a-z]|$)' THEN 3
    WHEN criticality_lc RLIKE 'very[ -]?low' THEN 1
    WHEN criticality_lc RLIKE 'negligible|negligable|insignificant' THEN 0
    WHEN criticality_lc RLIKE '(^|[^a-z])low([^a-z]|$)|minor' THEN 2
    ELSE NULL
  END AS criticality_rank
FROM normalised;


CREATE OR REPLACE TABLE your_catalog.your_schema.silver_transport_asset_location AS
WITH raw_locations AS (
  SELECT 'RAMC / BAC / PoB / TSRC group' AS source_label, AssetID, WKT
  FROM ext_mssql_asset_vision_ven_gen7.dbo.vassetlocation
  WHERE COALESCE(Deleted, false) = false

  UNION ALL
  SELECT 'RMS', AssetID, WKT
  FROM ext_mssql_asset_vision_ven_rms.dbo.vassetlocation
  WHERE COALESCE(Deleted, false) = false

  UNION ALL
  SELECT 'RMS new', AssetID, WKT
  FROM ext_mssql_asset_vision_ven_rms_new.dbo.vassetlocation
  WHERE COALESCE(Deleted, false) = false

  UNION ALL
  SELECT 'VicRoads', AssetID, WKT
  FROM ext_mssql_asset_vision_ven_vicroads.dbo.vassetlocation
  WHERE COALESCE(Deleted, false) = false

  UNION ALL
  SELECT 'VNS', AssetID, WKT
  FROM ext_mssql_asset_vision_vns_gen7.dbo.vassetlocation
  WHERE COALESCE(Deleted, false) = false

  UNION ALL
  SELECT 'VNZ', AssetID, WKT
  FROM ext_mssql_asset_vision_vnz_gen7.dbo.vassetlocation
  WHERE COALESCE(Deleted, false) = false

  UNION ALL
  SELECT 'VentureSmart', AssetID, WKT
  FROM ext_mssql_asset_vision_vsm_gen7.dbo.vassetlocation
  WHERE COALESCE(Deleted, false) = false
),
parsed AS (
  SELECT
    source_label,
    CAST(AssetID AS BIGINT) AS asset_id_bigint,
    CAST(AssetID AS STRING) AS asset_id,
    WKT,
    CAST(regexp_extract(WKT, '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)', 1) AS DOUBLE) AS lon,
    CAST(regexp_extract(WKT, '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)', 2) AS DOUBLE) AS lat
  FROM raw_locations
)
SELECT
  source_label,
  asset_id_bigint,
  asset_id,
  WKT,
  lon,
  lat,
  CASE WHEN lon BETWEEN 112 AND 180 AND lat BETWEEN -48 AND -9 THEN true ELSE false END AS has_valid_au_coord
FROM parsed;


CREATE OR REPLACE TABLE your_catalog.your_schema.silver_transport_asset_geo_point AS
SELECT
  source_label,
  asset_id_bigint,
  asset_id,
  WKT,
  lon,
  lat,
  has_valid_au_coord
FROM (
  SELECT
    *,
    ROW_NUMBER() OVER (
      PARTITION BY source_label, asset_id_bigint
      ORDER BY has_valid_au_coord DESC, WKT
    ) AS rn
  FROM your_catalog.your_schema.silver_transport_asset_location
)
WHERE rn = 1;


CREATE OR REPLACE TABLE your_catalog.your_schema.silver_transport_asset_location_presence AS
SELECT DISTINCT source_label, asset_id_bigint
FROM (
  SELECT 'RAMC / BAC / PoB / TSRC group' AS source_label, CAST(AssetID AS BIGINT) AS asset_id_bigint
  FROM ext_mssql_asset_vision_ven_gen7.dbo.assetlocation
  WHERE COALESCE(Deleted, false) = false

  UNION ALL
  SELECT 'RMS', CAST(AssetID AS BIGINT)
  FROM ext_mssql_asset_vision_ven_rms.dbo.assetlocation
  WHERE COALESCE(Deleted, false) = false

  UNION ALL
  SELECT 'RMS new', CAST(AssetID AS BIGINT)
  FROM ext_mssql_asset_vision_ven_rms_new.dbo.assetlocation
  WHERE COALESCE(Deleted, false) = false

  UNION ALL
  SELECT 'VicRoads', CAST(AssetID AS BIGINT)
  FROM ext_mssql_asset_vision_ven_vicroads.dbo.assetlocation
  WHERE COALESCE(Deleted, false) = false

  UNION ALL
  SELECT 'VNS', CAST(AssetID AS BIGINT)
  FROM ext_mssql_asset_vision_vns_gen7.dbo.assetlocation
  WHERE COALESCE(Deleted, false) = false

  UNION ALL
  SELECT 'VNZ', CAST(AssetID AS BIGINT)
  FROM ext_mssql_asset_vision_vnz_gen7.dbo.assetlocation
  WHERE COALESCE(Deleted, false) = false

  UNION ALL
  SELECT 'VentureSmart', CAST(AssetID AS BIGINT)
  FROM ext_mssql_asset_vision_vsm_gen7.dbo.assetlocation
  WHERE COALESCE(Deleted, false) = false
)
WHERE asset_id_bigint IS NOT NULL;


CREATE OR REPLACE TABLE your_catalog.your_schema.bronze_transport_job AS
SELECT * FROM (
  SELECT 'RAMC / BAC / PoB / TSRC group' AS source_label, Contract, ID, AssetID, DueDate, CompletedDate
  FROM ext_mssql_asset_vision_ven_gen7.dbo.job
  WHERE COALESCE(Deleted, false) = false

  UNION ALL
  SELECT 'RMS', Contract, ID, AssetID, DueDate, CompletedDate
  FROM ext_mssql_asset_vision_ven_rms.dbo.job
  WHERE COALESCE(Deleted, false) = false

  UNION ALL
  SELECT 'RMS new', Contract, ID, AssetID, DueDate, CompletedDate
  FROM ext_mssql_asset_vision_ven_rms_new.dbo.job
  WHERE COALESCE(Deleted, false) = false

  UNION ALL
  SELECT 'VicRoads', Contract, ID, AssetID, DueDate, CompletedDate
  FROM ext_mssql_asset_vision_ven_vicroads.dbo.job
  WHERE COALESCE(Deleted, false) = false

  UNION ALL
  SELECT 'VNS', Contract, ID, AssetID, DueDate, CompletedDate
  FROM ext_mssql_asset_vision_vns_gen7.dbo.job
  WHERE COALESCE(Deleted, false) = false

  UNION ALL
  SELECT 'VNZ', Contract, ID, AssetID, DueDate, CompletedDate
  FROM ext_mssql_asset_vision_vnz_gen7.dbo.job
  WHERE COALESCE(Deleted, false) = false

  UNION ALL
  SELECT 'VentureSmart', Contract, ID, AssetID, DueDate, CompletedDate
  FROM ext_mssql_asset_vision_vsm_gen7.dbo.job
  WHERE COALESCE(Deleted, false) = false
) j
WHERE AssetID IS NOT NULL;


CREATE OR REPLACE TABLE your_catalog.your_schema.silver_transport_job AS
SELECT
  source_label,
  COALESCE(NULLIF(TRIM(CAST(Contract AS STRING)), ''), 'Unknown') AS job_contract,
  CAST(ID AS BIGINT) AS job_id_bigint,
  CAST(ID AS STRING) AS job_id,
  CAST(AssetID AS BIGINT) AS asset_id_bigint,
  CAST(AssetID AS STRING) AS asset_id,
  CAST(DueDate AS TIMESTAMP) AS due_date,
  CAST(CompletedDate AS TIMESTAMP) AS completed_date,
  CASE WHEN CompletedDate IS NOT NULL THEN true ELSE false END AS completed_job_flag,
  CASE WHEN CompletedDate IS NULL THEN true ELSE false END AS open_job_flag,
  CASE
    WHEN DueDate IS NOT NULL
      AND CompletedDate IS NULL
      AND CAST(DueDate AS TIMESTAMP) < CURRENT_TIMESTAMP()
    THEN true ELSE false
  END AS overdue_job_flag,
  CASE
    WHEN DueDate IS NOT NULL
      AND (
        (CompletedDate IS NOT NULL AND CAST(CompletedDate AS TIMESTAMP) > CAST(DueDate AS TIMESTAMP))
        OR (CompletedDate IS NULL AND CAST(DueDate AS TIMESTAMP) < CURRENT_TIMESTAMP())
      )
    THEN true ELSE false
  END AS job_sla_breach_proxy_flag,
  CASE
    WHEN DueDate IS NOT NULL
      AND CompletedDate IS NULL
      AND CAST(DueDate AS TIMESTAMP) < CURRENT_TIMESTAMP()
    THEN DATEDIFF(CURRENT_DATE(), CAST(DueDate AS DATE))
    ELSE 0
  END AS days_overdue
FROM your_catalog.your_schema.bronze_transport_job;


CREATE OR REPLACE TABLE your_catalog.your_schema.bronze_transport_inspection AS
SELECT * FROM (
  SELECT 'RAMC / BAC / PoB / TSRC group' AS source_label, ID, AssetID, ScheduledDate, ScheduledDateTo, CompletedDate
  FROM ext_mssql_asset_vision_ven_gen7.dbo.inspection
  WHERE COALESCE(Deleted, false) = false

  UNION ALL
  SELECT 'RMS', ID, AssetID, ScheduledDate, ScheduledDateTo, CompletedDate
  FROM ext_mssql_asset_vision_ven_rms.dbo.inspection
  WHERE COALESCE(Deleted, false) = false

  UNION ALL
  SELECT 'RMS new', ID, AssetID, ScheduledDate, ScheduledDateTo, CompletedDate
  FROM ext_mssql_asset_vision_ven_rms_new.dbo.inspection
  WHERE COALESCE(Deleted, false) = false

  UNION ALL
  SELECT 'VicRoads', ID, AssetID, ScheduledDate, ScheduledDateTo, CompletedDate
  FROM ext_mssql_asset_vision_ven_vicroads.dbo.inspection
  WHERE COALESCE(Deleted, false) = false

  UNION ALL
  SELECT 'VNS', ID, AssetID, ScheduledDate, ScheduledDateTo, CompletedDate
  FROM ext_mssql_asset_vision_vns_gen7.dbo.inspection
  WHERE COALESCE(Deleted, false) = false

  UNION ALL
  SELECT 'VNZ', ID, AssetID, ScheduledDate, ScheduledDateTo, CompletedDate
  FROM ext_mssql_asset_vision_vnz_gen7.dbo.inspection
  WHERE COALESCE(Deleted, false) = false

  UNION ALL
  SELECT 'VentureSmart', ID, AssetID, ScheduledDate, ScheduledDateTo, CompletedDate
  FROM ext_mssql_asset_vision_vsm_gen7.dbo.inspection
  WHERE COALESCE(Deleted, false) = false
) i
WHERE AssetID IS NOT NULL;


CREATE OR REPLACE TABLE your_catalog.your_schema.silver_transport_inspection AS
SELECT
  source_label,
  CAST(ID AS BIGINT) AS inspection_id_bigint,
  CAST(ID AS STRING) AS inspection_id,
  CAST(AssetID AS BIGINT) AS asset_id_bigint,
  CAST(AssetID AS STRING) AS asset_id,
  CAST(ScheduledDate AS TIMESTAMP) AS scheduled_date,
  CAST(ScheduledDateTo AS TIMESTAMP) AS scheduled_date_to,
  COALESCE(CAST(ScheduledDateTo AS TIMESTAMP), CAST(ScheduledDate AS TIMESTAMP)) AS inspection_due_date,
  CAST(CompletedDate AS TIMESTAMP) AS completed_date,
  CASE WHEN CompletedDate IS NOT NULL THEN true ELSE false END AS completed_inspection_flag,
  CASE
    WHEN COALESCE(ScheduledDateTo, ScheduledDate) IS NOT NULL
      AND CompletedDate IS NULL
      AND COALESCE(CAST(ScheduledDateTo AS TIMESTAMP), CAST(ScheduledDate AS TIMESTAMP)) < CURRENT_TIMESTAMP()
    THEN true ELSE false
  END AS overdue_inspection_flag,
  CASE
    WHEN COALESCE(ScheduledDateTo, ScheduledDate) IS NOT NULL
      AND (
        (CompletedDate IS NOT NULL AND CAST(CompletedDate AS TIMESTAMP) > COALESCE(CAST(ScheduledDateTo AS TIMESTAMP), CAST(ScheduledDate AS TIMESTAMP)))
        OR (CompletedDate IS NULL AND COALESCE(CAST(ScheduledDateTo AS TIMESTAMP), CAST(ScheduledDate AS TIMESTAMP)) < CURRENT_TIMESTAMP())
      )
    THEN true ELSE false
  END AS inspection_sla_breach_proxy_flag
FROM your_catalog.your_schema.bronze_transport_inspection;


CREATE OR REPLACE TABLE your_catalog.your_schema.silver_transport_asset_photo_coverage AS
SELECT
  source_label,
  source_table_id_bigint AS asset_id_bigint,
  COUNT(*) AS asset_photo_count
FROM (
  SELECT 'RAMC / BAC / PoB / TSRC group' AS source_label, LOWER(TRIM(CAST(SourceTable AS STRING))) AS source_table, TRY_CAST(SourceTableID AS BIGINT) AS source_table_id_bigint
  FROM ext_mssql_asset_vision_ven_gen7.dbo.photo
  WHERE COALESCE(Deleted, false) = false

  UNION ALL
  SELECT 'RMS', LOWER(TRIM(CAST(SourceTable AS STRING))), TRY_CAST(SourceTableID AS BIGINT)
  FROM ext_mssql_asset_vision_ven_rms.dbo.photo
  WHERE COALESCE(Deleted, false) = false

  UNION ALL
  SELECT 'RMS new', LOWER(TRIM(CAST(SourceTable AS STRING))), TRY_CAST(SourceTableID AS BIGINT)
  FROM ext_mssql_asset_vision_ven_rms_new.dbo.photo
  WHERE COALESCE(Deleted, false) = false

  UNION ALL
  SELECT 'VicRoads', LOWER(TRIM(CAST(SourceTable AS STRING))), TRY_CAST(SourceTableID AS BIGINT)
  FROM ext_mssql_asset_vision_ven_vicroads.dbo.photo
  WHERE COALESCE(Deleted, false) = false

  UNION ALL
  SELECT 'VNS', LOWER(TRIM(CAST(SourceTable AS STRING))), TRY_CAST(SourceTableID AS BIGINT)
  FROM ext_mssql_asset_vision_vns_gen7.dbo.photo
  WHERE COALESCE(Deleted, false) = false

  UNION ALL
  SELECT 'VNZ', LOWER(TRIM(CAST(SourceTable AS STRING))), TRY_CAST(SourceTableID AS BIGINT)
  FROM ext_mssql_asset_vision_vnz_gen7.dbo.photo
  WHERE COALESCE(Deleted, false) = false

  UNION ALL
  SELECT 'VentureSmart', LOWER(TRIM(CAST(SourceTable AS STRING))), TRY_CAST(SourceTableID AS BIGINT)
  FROM ext_mssql_asset_vision_vsm_gen7.dbo.photo
  WHERE COALESCE(Deleted, false) = false
)
WHERE source_table = 'asset'
  AND source_table_id_bigint IS NOT NULL
GROUP BY source_label, source_table_id_bigint;


CREATE OR REPLACE TABLE your_catalog.your_schema.silver_transport_job_by_asset AS
SELECT
  source_label,
  asset_id_bigint,
  COUNT(*) AS job_count,
  SUM(CASE WHEN completed_job_flag THEN 1 ELSE 0 END) AS completed_job_count,
  SUM(CASE WHEN open_job_flag THEN 1 ELSE 0 END) AS open_job_count,
  SUM(CASE WHEN overdue_job_flag THEN 1 ELSE 0 END) AS overdue_job_count,
  SUM(CASE WHEN job_sla_breach_proxy_flag THEN 1 ELSE 0 END) AS job_sla_breach_proxy_count,
  SUM(days_overdue) AS total_overdue_days
FROM your_catalog.your_schema.silver_transport_job
GROUP BY source_label, asset_id_bigint;


CREATE OR REPLACE TABLE your_catalog.your_schema.silver_transport_inspection_by_asset AS
SELECT
  source_label,
  asset_id_bigint,
  COUNT(*) AS inspection_count,
  SUM(CASE WHEN completed_inspection_flag THEN 1 ELSE 0 END) AS completed_inspection_count,
  SUM(CASE WHEN overdue_inspection_flag THEN 1 ELSE 0 END) AS overdue_inspection_count,
  SUM(CASE WHEN inspection_sla_breach_proxy_flag THEN 1 ELSE 0 END) AS inspection_sla_breach_proxy_count
FROM your_catalog.your_schema.silver_transport_inspection
GROUP BY source_label, asset_id_bigint;


-- =============================================================================
-- Section 2. Dashboard output tables
-- =============================================================================

-- Query 1 replacement:
-- Asset-level drilldown table with job, inspection, risk, criticality, evidence,
-- repeat-job, and missing-location flags.
-- Includes mapped asset type/category fields for dashboard filtering.
CREATE OR REPLACE TABLE your_catalog.your_schema.gold_transport_asset_operational_detail AS
SELECT
  a.source_label,
  a.contract,
  a.asset_type AS raw_asset_type,
  COALESCE(m.standardised_asset_type_name, a.asset_type) AS asset_type,
  COALESCE(m.standardised_asset_type_name, a.asset_type) AS standardised_asset_type_name,
  COALESCE(m.asset_subcategory, 'Other / Unclassified') AS asset_subcategory,
  COALESCE(m.asset_category, 'Other / Unclassified') AS asset_category,
  COALESCE(m.mapping_method, 'missing_mapping_table_match') AS asset_type_mapping_method,
  a.asset_id,
  a.asset_condition,
  a.asset_risk,
  a.criticality_raw,
  a.criticality_standardised,
  COALESCE(j.job_count, 0) AS job_count,
  COALESCE(j.completed_job_count, 0) AS completed_job_count,
  COALESCE(j.open_job_count, 0) AS open_job_count,
  COALESCE(j.overdue_job_count, 0) AS overdue_job_count,
  COALESCE(j.job_sla_breach_proxy_count, 0) AS job_sla_breach_proxy_count,
  COALESCE(j.total_overdue_days, 0) AS total_overdue_days,
  COALESCE(i.inspection_count, 0) AS inspection_count,
  COALESCE(i.completed_inspection_count, 0) AS completed_inspection_count,
  COALESCE(i.overdue_inspection_count, 0) AS overdue_inspection_count,
  COALESCE(i.inspection_sla_breach_proxy_count, 0) AS inspection_sla_breach_proxy_count,
  CASE WHEN lp.asset_id_bigint IS NULL THEN true ELSE false END AS missing_location_flag,
  CASE WHEN COALESCE(p.asset_photo_count, 0) > 0 THEN true ELSE false END AS has_asset_photo_flag,
  CASE WHEN COALESCE(j.job_count, 0) >= 2 THEN true ELSE false END AS repeat_job_asset_flag
FROM your_catalog.your_schema.silver_transport_asset a
LEFT JOIN transport_dev.integ_transport_assets.asset_vision_asset_type_category_map m
  ON LOWER(TRIM(a.asset_type)) = LOWER(TRIM(m.asset_type))
LEFT JOIN your_catalog.your_schema.silver_transport_job_by_asset j
  ON j.source_label = a.source_label
 AND j.asset_id_bigint = a.asset_id_bigint
LEFT JOIN your_catalog.your_schema.silver_transport_inspection_by_asset i
  ON i.source_label = a.source_label
 AND i.asset_id_bigint = a.asset_id_bigint
LEFT JOIN your_catalog.your_schema.silver_transport_asset_location_presence lp
  ON lp.source_label = a.source_label
 AND lp.asset_id_bigint = a.asset_id_bigint
LEFT JOIN your_catalog.your_schema.silver_transport_asset_photo_coverage p
  ON p.source_label = a.source_label
 AND p.asset_id_bigint = a.asset_id_bigint;


-- Query 2 replacement:
-- Map-ready asset table. This is one row per asset using the best available
-- Australian lon/lat row from vassetlocation.
-- Includes mapped asset type/category fields for dashboard filtering.
CREATE OR REPLACE TABLE your_catalog.your_schema.gold_transport_asset_map AS
SELECT
  a.source_label,
  a.contract,
  a.asset_type AS raw_asset_type,
  COALESCE(m.standardised_asset_type_name, a.asset_type) AS asset_type,
  COALESCE(m.standardised_asset_type_name, a.asset_type) AS standardised_asset_type_name,
  COALESCE(m.asset_subcategory, 'Other / Unclassified') AS asset_subcategory,
  COALESCE(m.asset_category, 'Other / Unclassified') AS asset_category,
  a.asset_id,
  a.criticality_raw,
  a.criticality_standardised,
  a.asset_risk,
  l.lon,
  l.lat
FROM your_catalog.your_schema.silver_transport_asset a
LEFT JOIN transport_dev.integ_transport_assets.asset_vision_asset_type_category_map m
  ON LOWER(TRIM(a.asset_type)) = LOWER(TRIM(m.asset_type))
INNER JOIN your_catalog.your_schema.silver_transport_asset_geo_point l
  ON l.source_label = a.source_label
 AND l.asset_id_bigint = a.asset_id_bigint
WHERE l.has_valid_au_coord = true;


-- Query 3 replacement:
-- Open-overdue job ageing table.
-- Final schema matches the original Query 3 output exactly.
CREATE OR REPLACE TABLE your_catalog.your_schema.gold_transport_overdue_job_ageing AS
SELECT
  j.source_label,
  COALESCE(a.contract, j.job_contract, 'Unknown') AS contract,
  COALESCE(a.asset_type, 'Unspecified') AS asset_type,
  j.days_overdue,
  CASE
    WHEN j.days_overdue <= 7 THEN '0-7 days'
    WHEN j.days_overdue <= 30 THEN '8-30 days'
    WHEN j.days_overdue <= 90 THEN '31-90 days'
    ELSE '90+ days'
  END AS age_bucket,
  CASE
    WHEN j.days_overdue <= 7 THEN 1
    WHEN j.days_overdue <= 30 THEN 2
    WHEN j.days_overdue <= 90 THEN 3
    ELSE 4
  END AS age_bucket_order
FROM your_catalog.your_schema.silver_transport_job j
LEFT JOIN your_catalog.your_schema.silver_transport_asset a
  ON a.source_label = j.source_label
 AND a.asset_id_bigint = j.asset_id_bigint
WHERE j.overdue_job_flag = true
  AND j.days_overdue >= 0;


-- Optional chart query for open-overdue ageing only.
SELECT
  source_label,
  contract,
  asset_type,
  age_bucket,
  age_bucket_order,
  COUNT(*) AS overdue_open_job_count,
  AVG(days_overdue) AS avg_days_overdue,
  MAX(days_overdue) AS max_days_overdue
FROM your_catalog.your_schema.gold_transport_overdue_job_ageing
GROUP BY source_label, contract, asset_type, age_bucket, age_bucket_order
ORDER BY source_label, contract, asset_type, age_bucket_order;


-- Contract x standard asset type matrix.
-- Use this as the primary table for pivot tables, heatmaps, treemaps, and
-- contract comparison views. Asset counts are reliable for all asset types.
-- chainage_length_km_proxy is only meaningful for linear assets where
-- ChainageFrom/ChainageTo are populated and appear to be measured in metres.
CREATE OR REPLACE TABLE your_catalog.your_schema.gold_transport_contract_asset_footprint_matrix AS
SELECT
  a.source_label,
  a.contract,
  COALESCE(m.asset_category, 'Other / Unclassified') AS asset_category,
  COALESCE(m.asset_subcategory, 'Other / Unclassified') AS asset_subcategory,
  COALESCE(m.standardised_asset_type_name, a.asset_type) AS standardised_asset_type_name,
  COUNT(*) AS asset_count,
  COUNT(DISTINCT a.asset_type) AS raw_asset_type_count,
  ARRAY_JOIN(SLICE(SORT_ARRAY(COLLECT_SET(a.asset_type)), 1, 20), ', ') AS raw_asset_type_examples,
  SUM(CASE WHEN a.chainage_length_km_proxy IS NOT NULL THEN 1 ELSE 0 END) AS linear_asset_count,
  ROUND(SUM(COALESCE(a.chainage_length_km_proxy, 0)), 2) AS chainage_length_km_proxy,
  SUM(CASE WHEN gp.asset_id_bigint IS NOT NULL THEN 1 ELSE 0 END) AS geocoded_asset_count,
  SUM(CASE WHEN lp.asset_id_bigint IS NULL THEN 1 ELSE 0 END) AS missing_location_count,
  SUM(CASE WHEN a.asset_condition <> 'Not supplied' THEN 1 ELSE 0 END) AS condition_populated_count,
  SUM(CASE WHEN a.criticality_raw <> 'Not supplied' THEN 1 ELSE 0 END) AS criticality_populated_count,
  ROUND(AVG(a.criticality_rank), 2) AS avg_criticality_rank,
  SUM(CASE WHEN a.criticality_rank >= 4 THEN 1 ELSE 0 END) AS high_or_critical_asset_count,
  SUM(COALESCE(j.job_count, 0)) AS job_count,
  SUM(COALESCE(j.completed_job_count, 0)) AS completed_job_count,
  SUM(COALESCE(j.open_job_count, 0)) AS open_job_count,
  SUM(COALESCE(j.overdue_job_count, 0)) AS overdue_job_count,
  SUM(COALESCE(j.job_sla_breach_proxy_count, 0)) AS job_sla_breach_proxy_count,
  SUM(COALESCE(i.inspection_count, 0)) AS inspection_count,
  SUM(COALESCE(i.completed_inspection_count, 0)) AS completed_inspection_count,
  SUM(COALESCE(i.overdue_inspection_count, 0)) AS overdue_inspection_count,
  SUM(COALESCE(i.inspection_sla_breach_proxy_count, 0)) AS inspection_sla_breach_proxy_count,
  SUM(CASE WHEN COALESCE(j.job_count, 0) >= 2 THEN 1 ELSE 0 END) AS repeat_job_asset_count,
  SUM(CASE WHEN COALESCE(p.asset_photo_count, 0) > 0 THEN 1 ELSE 0 END) AS assets_with_photo_count,
  ROUND(SUM(COALESCE(j.job_count, 0)) / NULLIF(COUNT(*), 0), 2) AS jobs_per_asset,
  ROUND(SUM(COALESCE(i.inspection_count, 0)) / NULLIF(COUNT(*), 0), 2) AS inspections_per_asset,
  ROUND(
    SUM(COALESCE(j.job_count, 0)) / NULLIF(SUM(COALESCE(a.chainage_length_km_proxy, 0)), 0),
    2
  ) AS jobs_per_chainage_km_proxy
FROM your_catalog.your_schema.silver_transport_asset a
LEFT JOIN transport_dev.integ_transport_assets.asset_vision_asset_type_category_map m
  ON LOWER(TRIM(a.asset_type)) = LOWER(TRIM(m.asset_type))
LEFT JOIN your_catalog.your_schema.silver_transport_job_by_asset j
  ON j.source_label = a.source_label
 AND j.asset_id_bigint = a.asset_id_bigint
LEFT JOIN your_catalog.your_schema.silver_transport_inspection_by_asset i
  ON i.source_label = a.source_label
 AND i.asset_id_bigint = a.asset_id_bigint
LEFT JOIN your_catalog.your_schema.silver_transport_asset_location_presence lp
  ON lp.source_label = a.source_label
 AND lp.asset_id_bigint = a.asset_id_bigint
LEFT JOIN your_catalog.your_schema.silver_transport_asset_geo_point gp
  ON gp.source_label = a.source_label
 AND gp.asset_id_bigint = a.asset_id_bigint
 AND gp.has_valid_au_coord = true
LEFT JOIN your_catalog.your_schema.silver_transport_asset_photo_coverage p
  ON p.source_label = a.source_label
 AND p.asset_id_bigint = a.asset_id_bigint
GROUP BY
  a.source_label,
  a.contract,
  COALESCE(m.asset_category, 'Other / Unclassified'),
  COALESCE(m.asset_subcategory, 'Other / Unclassified'),
  COALESCE(m.standardised_asset_type_name, a.asset_type);


-- Contract x asset category pivot.
-- This is deliberately category-level rather than raw asset type-level because
-- raw AssetType values are too numerous and messy for a stable wide table.
CREATE OR REPLACE TABLE your_catalog.your_schema.gold_transport_contract_asset_category_pivot AS
SELECT
  source_label,
  contract,
  SUM(asset_count) AS total_asset_count,
  ROUND(SUM(chainage_length_km_proxy), 2) AS total_chainage_length_km_proxy,
  SUM(job_count) AS total_job_count,
  SUM(open_job_count) AS total_open_job_count,
  SUM(overdue_job_count) AS total_overdue_job_count,
  SUM(inspection_count) AS total_inspection_count,
  SUM(overdue_inspection_count) AS total_overdue_inspection_count,
  SUM(CASE WHEN asset_category = 'Pavement / Surfacing' THEN asset_count ELSE 0 END) AS pavement_asset_count,
  ROUND(SUM(CASE WHEN asset_category = 'Pavement / Surfacing' THEN chainage_length_km_proxy ELSE 0 END), 2) AS pavement_chainage_km_proxy,
  SUM(CASE WHEN asset_category = 'Drainage / Stormwater' THEN asset_count ELSE 0 END) AS drainage_asset_count,
  ROUND(SUM(CASE WHEN asset_category = 'Drainage / Stormwater' THEN chainage_length_km_proxy ELSE 0 END), 2) AS drainage_chainage_km_proxy,
  SUM(CASE WHEN asset_category = 'Structures / Bridges / Tunnels' THEN asset_count ELSE 0 END) AS structures_asset_count,
  SUM(CASE WHEN asset_category = 'Signs / Roadside Information' THEN asset_count ELSE 0 END) AS signs_asset_count,
  SUM(CASE WHEN asset_category = 'ITS / Traffic Control' THEN asset_count ELSE 0 END) AS its_asset_count,
  SUM(CASE WHEN asset_category = 'Lighting / Electrical / Mechanical' THEN asset_count ELSE 0 END) AS lighting_electrical_mechanical_asset_count,
  SUM(CASE WHEN asset_category = 'Barriers / Safety Devices' THEN asset_count ELSE 0 END) AS barriers_asset_count,
  SUM(CASE WHEN asset_category = 'Line Marking / Delineation' THEN asset_count ELSE 0 END) AS line_marking_asset_count,
  ROUND(SUM(CASE WHEN asset_category = 'Line Marking / Delineation' THEN chainage_length_km_proxy ELSE 0 END), 2) AS line_marking_chainage_km_proxy,
  SUM(CASE WHEN asset_category = 'Footpath / Pedestrian / Access' THEN asset_count ELSE 0 END) AS pedestrian_access_asset_count,
  ROUND(SUM(CASE WHEN asset_category = 'Footpath / Pedestrian / Access' THEN chainage_length_km_proxy ELSE 0 END), 2) AS pedestrian_access_chainage_km_proxy,
  SUM(CASE WHEN asset_category = 'Vegetation / Landscaping' THEN asset_count ELSE 0 END) AS vegetation_landscaping_asset_count,
  SUM(CASE WHEN asset_category = 'Facilities / Buildings' THEN asset_count ELSE 0 END) AS facilities_buildings_asset_count,
  SUM(CASE WHEN asset_category = 'Road Network / Geometry' THEN asset_count ELSE 0 END) AS road_network_geometry_asset_count,
  ROUND(SUM(CASE WHEN asset_category = 'Road Network / Geometry' THEN chainage_length_km_proxy ELSE 0 END), 2) AS road_network_geometry_chainage_km_proxy,
  SUM(CASE WHEN asset_category = 'Earthworks / Geotechnical' THEN asset_count ELSE 0 END) AS earthworks_geotechnical_asset_count,
  SUM(CASE WHEN asset_category = 'Other / Unclassified' THEN asset_count ELSE 0 END) AS other_unclassified_asset_count
FROM your_catalog.your_schema.gold_transport_contract_asset_footprint_matrix
GROUP BY source_label, contract;


-- Visual 1: heatmap/table for contract x category footprint.
SELECT
  contract,
  asset_category,
  SUM(asset_count) AS asset_count,
  ROUND(SUM(chainage_length_km_proxy), 2) AS chainage_length_km_proxy,
  SUM(job_count) AS job_count,
  SUM(open_job_count) AS open_job_count,
  SUM(overdue_job_count) AS overdue_job_count,
  ROUND(SUM(job_count) / NULLIF(SUM(asset_count), 0), 2) AS jobs_per_asset,
  ROUND(SUM(job_count) / NULLIF(SUM(chainage_length_km_proxy), 0), 2) AS jobs_per_chainage_km_proxy
FROM your_catalog.your_schema.gold_transport_contract_asset_footprint_matrix
GROUP BY contract, asset_category
ORDER BY contract, asset_count DESC;


-- Visual 2: top maintained asset types by contract.
-- Good as a stacked bar, treemap, or table with conditional formatting.
SELECT
  contract,
  asset_category,
  standardised_asset_type_name,
  SUM(asset_count) AS asset_count,
  ROUND(SUM(chainage_length_km_proxy), 2) AS chainage_length_km_proxy,
  SUM(job_count) AS job_count,
  SUM(open_job_count) AS open_job_count,
  SUM(overdue_job_count) AS overdue_job_count,
  SUM(inspection_count) AS inspection_count,
  ROUND(SUM(job_count) / NULLIF(SUM(asset_count), 0), 2) AS jobs_per_asset
FROM your_catalog.your_schema.gold_transport_contract_asset_footprint_matrix
GROUP BY
  contract,
  asset_category,
  standardised_asset_type_name
ORDER BY
  contract,
  job_count DESC,
  asset_count DESC;


-- Visual 3: risk/maintenance pressure bubble chart.
-- x = asset_count, y = jobs_per_asset, bubble = overdue_job_count,
-- colour = asset_category, facet/filter = contract.
SELECT
  contract,
  asset_category,
  standardised_asset_type_name,
  SUM(asset_count) AS asset_count,
  SUM(job_count) AS job_count,
  SUM(overdue_job_count) AS overdue_job_count,
  ROUND(SUM(job_count) / NULLIF(SUM(asset_count), 0), 2) AS jobs_per_asset,
  ROUND(AVG(avg_criticality_rank), 2) AS avg_criticality_rank
FROM your_catalog.your_schema.gold_transport_contract_asset_footprint_matrix
GROUP BY
  contract,
  asset_category,
  standardised_asset_type_name
HAVING SUM(asset_count) >= 10
ORDER BY jobs_per_asset DESC, overdue_job_count DESC;


-- Optional maintenance commands after large refreshes:
-- OPTIMIZE your_catalog.your_schema.silver_transport_asset ZORDER BY (source_label, asset_id_bigint);
-- OPTIMIZE your_catalog.your_schema.silver_transport_job ZORDER BY (source_label, asset_id_bigint);
-- OPTIMIZE your_catalog.your_schema.gold_transport_asset_map ZORDER BY (source_label, contract, asset_type);
-- OPTIMIZE your_catalog.your_schema.gold_transport_asset_operational_detail ZORDER BY (source_label, contract, asset_type);
-- OPTIMIZE your_catalog.your_schema.gold_transport_contract_asset_footprint_matrix ZORDER BY (source_label, contract, asset_category);


-- =============================================================================
-- Section 3. QA for asset type -> subcategory/category mapping
-- =============================================================================

-- Run this section after creating:
-- transport_dev.integ_transport_assets.asset_vision_asset_type_category_map
--
-- The QA uses the same source asset tables as Section 1 and checks whether every
-- live source AssetType is covered by the manual mapping table.

CREATE OR REPLACE TEMP VIEW qa_transport_source_asset_types AS
WITH raw_assets AS (
  SELECT 'RAMC / BAC / PoB / TSRC group' AS source_label, AssetType, Classification, ID
  FROM ext_mssql_asset_vision_ven_gen7.dbo.asset
  WHERE COALESCE(Deleted, false) = false

  UNION ALL
  SELECT 'RMS', AssetType, Classification, ID
  FROM ext_mssql_asset_vision_ven_rms.dbo.asset
  WHERE COALESCE(Deleted, false) = false

  UNION ALL
  SELECT 'RMS new', AssetType, Classification, ID
  FROM ext_mssql_asset_vision_ven_rms_new.dbo.asset
  WHERE COALESCE(Deleted, false) = false

  UNION ALL
  SELECT 'VicRoads', AssetType, Classification, ID
  FROM ext_mssql_asset_vision_ven_vicroads.dbo.asset
  WHERE COALESCE(Deleted, false) = false

  UNION ALL
  SELECT 'VNS', AssetType, Classification, ID
  FROM ext_mssql_asset_vision_vns_gen7.dbo.asset
  WHERE COALESCE(Deleted, false) = false

  UNION ALL
  SELECT 'VNZ', AssetType, Classification, ID
  FROM ext_mssql_asset_vision_vnz_gen7.dbo.asset
  WHERE COALESCE(Deleted, false) = false

  UNION ALL
  SELECT 'VentureSmart', AssetType, Classification, ID
  FROM ext_mssql_asset_vision_vsm_gen7.dbo.asset
  WHERE COALESCE(Deleted, false) = false
),
normalised AS (
  SELECT
    source_label,
    COALESCE(NULLIF(TRIM(CAST(AssetType AS STRING)), ''), 'Unspecified') AS asset_type,
    COALESCE(NULLIF(TRIM(CAST(Classification AS STRING)), ''), 'Unclassified') AS source_classification,
    CAST(ID AS STRING) AS asset_id
  FROM raw_assets
)
SELECT
  asset_type,
  COUNT(DISTINCT CONCAT_WS('|', source_label, asset_id)) AS asset_count,
  COUNT(DISTINCT source_label) AS source_context_count,
  ARRAY_JOIN(SORT_ARRAY(COLLECT_SET(source_label)), ', ') AS source_contexts,
  COUNT(DISTINCT source_classification) AS source_classification_count,
  ARRAY_JOIN(SLICE(SORT_ARRAY(COLLECT_SET(source_classification)), 1, 10), ', ') AS source_classification_examples
FROM normalised
GROUP BY asset_type;


-- QA 1: coverage summary. Unmapped source asset types should be zero.
SELECT
  COUNT(DISTINCT s.asset_type) AS source_asset_type_count,
  COUNT(DISTINCT m.asset_type) AS mapping_asset_type_count,
  COUNT(DISTINCT CASE WHEN m.asset_type IS NOT NULL THEN s.asset_type END) AS mapped_source_asset_type_count,
  COUNT(DISTINCT CASE WHEN m.asset_type IS NULL THEN s.asset_type END) AS unmapped_source_asset_type_count,
  SUM(s.asset_count) AS source_asset_count,
  SUM(CASE WHEN m.asset_type IS NOT NULL THEN s.asset_count ELSE 0 END) AS mapped_source_asset_count,
  ROUND(
    100.0 * SUM(CASE WHEN m.asset_type IS NOT NULL THEN s.asset_count ELSE 0 END) / SUM(s.asset_count),
    2
  ) AS mapped_source_asset_pct
FROM qa_transport_source_asset_types s
LEFT JOIN transport_dev.integ_transport_assets.asset_vision_asset_type_category_map m
  ON LOWER(TRIM(s.asset_type)) = LOWER(TRIM(m.asset_type));


-- QA 2: live source AssetType values missing from the mapping table.
SELECT
  s.asset_type,
  s.asset_count,
  s.source_context_count,
  s.source_contexts,
  s.source_classification_count,
  s.source_classification_examples
FROM qa_transport_source_asset_types s
LEFT JOIN transport_dev.integ_transport_assets.asset_vision_asset_type_category_map m
  ON LOWER(TRIM(s.asset_type)) = LOWER(TRIM(m.asset_type))
WHERE m.asset_type IS NULL
ORDER BY s.asset_count DESC, s.asset_type;


-- QA 3: mapping rows not currently observed in the Section 1 source asset set.
-- These are not necessarily wrong; they may come from another source extract or
-- a contractor schema not included in this dashboard file.
SELECT
  m.asset_type,
  m.standardised_asset_type_name,
  m.asset_subcategory,
  m.asset_category,
  m.mapping_method,
  m.updated_ts
FROM transport_dev.integ_transport_assets.asset_vision_asset_type_category_map m
LEFT JOIN qa_transport_source_asset_types s
  ON LOWER(TRIM(s.asset_type)) = LOWER(TRIM(m.asset_type))
WHERE s.asset_type IS NULL
ORDER BY m.asset_category, m.asset_subcategory, m.asset_type;


-- QA 4: duplicate or conflicting mappings. This should return no rows.
SELECT
  asset_type,
  COUNT(*) AS mapping_row_count,
  COUNT(DISTINCT standardised_asset_type_name) AS distinct_standardised_name_count,
  COUNT(DISTINCT asset_subcategory) AS distinct_subcategory_count,
  COUNT(DISTINCT asset_category) AS distinct_category_count,
  ARRAY_JOIN(SORT_ARRAY(COLLECT_SET(standardised_asset_type_name)), ', ') AS mapped_standardised_asset_type_names,
  ARRAY_JOIN(SORT_ARRAY(COLLECT_SET(asset_subcategory)), ', ') AS mapped_subcategories,
  ARRAY_JOIN(SORT_ARRAY(COLLECT_SET(asset_category)), ', ') AS mapped_categories
FROM transport_dev.integ_transport_assets.asset_vision_asset_type_category_map
GROUP BY asset_type
HAVING
  COUNT(*) > 1
  OR COUNT(DISTINCT standardised_asset_type_name) > 1
  OR COUNT(DISTINCT asset_subcategory) > 1
  OR COUNT(DISTINCT asset_category) > 1
ORDER BY asset_type;


-- QA 5: blank required fields. This should return no rows.
SELECT *
FROM transport_dev.integ_transport_assets.asset_vision_asset_type_category_map
WHERE asset_type IS NULL
   OR TRIM(asset_type) = ''
   OR standardised_asset_type_name IS NULL
   OR TRIM(standardised_asset_type_name) = ''
   OR asset_subcategory IS NULL
   OR TRIM(asset_subcategory) = ''
   OR asset_category IS NULL
   OR TRIM(asset_category) = '';


-- QA 6: each subcategory should roll up to exactly one category.
-- This should return no rows unless the hierarchy intentionally allows reuse.
SELECT
  asset_subcategory,
  COUNT(DISTINCT asset_category) AS distinct_category_count,
  ARRAY_JOIN(SORT_ARRAY(COLLECT_SET(asset_category)), ', ') AS categories
FROM transport_dev.integ_transport_assets.asset_vision_asset_type_category_map
GROUP BY asset_subcategory
HAVING COUNT(DISTINCT asset_category) > 1
ORDER BY asset_subcategory;


-- QA 7: distribution of mapped categories across live source assets.
SELECT
  m.asset_category,
  m.asset_subcategory,
  COUNT(DISTINCT s.asset_type) AS distinct_asset_type_count,
  SUM(s.asset_count) AS asset_count,
  ARRAY_JOIN(SLICE(SORT_ARRAY(COLLECT_SET(m.standardised_asset_type_name)), 1, 10), ', ') AS standardised_asset_type_examples,
  ARRAY_JOIN(SLICE(SORT_ARRAY(COLLECT_SET(s.source_contexts)), 1, 10), ', ') AS source_context_examples
FROM qa_transport_source_asset_types s
INNER JOIN transport_dev.integ_transport_assets.asset_vision_asset_type_category_map m
  ON LOWER(TRIM(s.asset_type)) = LOWER(TRIM(m.asset_type))
GROUP BY
  m.asset_category,
  m.asset_subcategory
ORDER BY
  asset_count DESC,
  m.asset_category,
  m.asset_subcategory;


-- QA 8: source Classification values behind each mapped category.
-- This helps detect if a mapped category is mixing very different source classes.
SELECT
  m.asset_category,
  m.asset_subcategory,
  s.source_classification_examples,
  COUNT(DISTINCT s.asset_type) AS distinct_asset_type_count,
  SUM(s.asset_count) AS asset_count,
  ARRAY_JOIN(SLICE(SORT_ARRAY(COLLECT_SET(m.standardised_asset_type_name)), 1, 10), ', ') AS standardised_asset_type_examples
FROM qa_transport_source_asset_types s
INNER JOIN transport_dev.integ_transport_assets.asset_vision_asset_type_category_map m
  ON LOWER(TRIM(s.asset_type)) = LOWER(TRIM(m.asset_type))
GROUP BY
  m.asset_category,
  m.asset_subcategory,
  s.source_classification_examples
ORDER BY
  m.asset_category,
  m.asset_subcategory,
  asset_count DESC;


-- QA 9: keyword-based sense check. These are review candidates, not hard errors.
-- The manual mapping remains the source of truth.
WITH keyword_expectations AS (
  SELECT
    m.asset_type,
    m.standardised_asset_type_name,
    m.asset_subcategory,
    m.asset_category,
    CASE
      WHEN LOWER(m.asset_type) RLIKE 'linemark|line marking|marking|rrpm|dragon|zebra|40 patch|symbolic pavement'
        THEN 'Line Marking / Delineation'
      WHEN LOWER(m.asset_type) RLIKE 'culvert|drain|pit|gully|stormwater|storm water|pipe|inlet|penstock|valve|trash rack|water course|pump station|hydraulic treatment|pumping|rain garden'
        THEN 'Drainage / Stormwater'
      WHEN LOWER(m.asset_type) RLIKE 'sign|guidepost|school zone|vms|cms|flasher|message|speed limit|esls|islus'
        THEN 'Signs / Roadside Information'
      WHEN LOWER(m.asset_type) RLIKE 'traffic|tcs|cctv|camera|webcam|detector|detection|wim|rwis|bluetooth|beacon|tolling|signal|lane use'
        THEN 'ITS / Traffic Control'
      WHEN LOWER(m.asset_type) RLIKE 'barrier|guardrail|fence|fencing|cushion|terminal|railing|arrestor bed|safety ramp'
        THEN 'Barriers / Safety Devices'
      WHEN LOWER(m.asset_type) RLIKE 'bridge|tunnel|retaining wall|noise wall|gantr|structure'
        THEN 'Structures / Bridges / Tunnels'
      WHEN LOWER(m.asset_type) RLIKE 'pavement|surfacing|surface|roughness|carpark|parking|^road$|^roads$|unsealed'
        THEN 'Pavement / Surfacing'
      WHEN LOWER(m.asset_type) RLIKE 'slope|embankment'
        THEN 'Earthworks / Geotechnical'
      WHEN LOWER(m.asset_type) RLIKE 'kerb|channel|shoulder|berm'
        THEN 'Kerb / Channel / Road Edge'
      WHEN LOWER(m.asset_type) RLIKE 'footpath|pathway|cycleway|crossing|boat ramp|access point'
        THEN 'Footpath / Pedestrian / Access'
      WHEN LOWER(m.asset_type) RLIKE 'tree|landscap|grass'
        THEN 'Vegetation / Landscaping'
      WHEN LOWER(m.asset_type) RLIKE 'lighting|streetlight|electrical|switchboard|ups|generator|fire|hvac|ventilation|mechanical'
        THEN 'Lighting / Electrical / Mechanical'
      WHEN LOWER(m.asset_type) RLIKE 'air monitoring|water quality'
        THEN 'Environment / Monitoring'
      ELSE NULL
    END AS expected_category_from_keyword
  FROM transport_dev.integ_transport_assets.asset_vision_asset_type_category_map m
)
SELECT
  asset_type,
  standardised_asset_type_name,
  asset_subcategory,
  asset_category,
  expected_category_from_keyword
FROM keyword_expectations
WHERE expected_category_from_keyword IS NOT NULL
  AND asset_category <> expected_category_from_keyword
ORDER BY expected_category_from_keyword, asset_category, asset_type;


-- =============================================================================
-- Section 4. QA for AssetCriticality standardisation
-- =============================================================================
--
-- Run this section after Section 1 has created:
-- your_catalog.your_schema.silver_transport_asset
--
-- The main question is usually whether criticality is genuinely standardised or
-- whether the field is mostly blank / inconsistent across contractor schemas.

-- QA 1: criticality coverage by source.
-- Watch missing_criticality_pct and other_criticality_count.
SELECT
  source_label,
  COUNT(*) AS asset_count,
  SUM(CASE WHEN criticality_raw <> 'Not supplied' THEN 1 ELSE 0 END) AS populated_criticality_count,
  SUM(CASE WHEN criticality_raw = 'Not supplied' THEN 1 ELSE 0 END) AS missing_criticality_count,
  ROUND(
    100.0 * SUM(CASE WHEN criticality_raw = 'Not supplied' THEN 1 ELSE 0 END) / COUNT(*),
    2
  ) AS missing_criticality_pct,
  COUNT(DISTINCT criticality_raw) AS distinct_raw_criticality_count,
  SUM(CASE WHEN criticality_standardised = 'Other' THEN 1 ELSE 0 END) AS other_criticality_count
FROM your_catalog.your_schema.silver_transport_asset
GROUP BY source_label
ORDER BY missing_criticality_pct DESC, source_label;


-- QA 2: raw criticality values and their standardised output.
-- This shows the messy source values that are being grouped together.
SELECT
  criticality_raw,
  criticality_standardised,
  criticality_rank,
  COUNT(*) AS asset_count,
  COUNT(DISTINCT source_label) AS source_count,
  ARRAY_JOIN(SORT_ARRAY(COLLECT_SET(source_label)), ', ') AS source_examples,
  ARRAY_JOIN(SLICE(SORT_ARRAY(COLLECT_SET(asset_type)), 1, 15), ', ') AS asset_type_examples
FROM your_catalog.your_schema.silver_transport_asset
GROUP BY
  criticality_raw,
  criticality_standardised,
  criticality_rank
ORDER BY
  CASE WHEN criticality_standardised = 'Other' THEN 0 ELSE 1 END,
  asset_count DESC,
  criticality_raw;


-- QA 3: raw values that failed standardisation.
-- This should return no rows if the current rules cover all live values.
SELECT
  criticality_raw,
  COUNT(*) AS asset_count,
  COUNT(DISTINCT source_label) AS source_count,
  ARRAY_JOIN(SORT_ARRAY(COLLECT_SET(source_label)), ', ') AS source_examples,
  ARRAY_JOIN(SLICE(SORT_ARRAY(COLLECT_SET(asset_type)), 1, 20), ', ') AS asset_type_examples
FROM your_catalog.your_schema.silver_transport_asset
WHERE criticality_standardised = 'Other'
GROUP BY criticality_raw
ORDER BY asset_count DESC, criticality_raw;


-- QA 4: invalid standardised value / rank combinations.
-- This should return no rows.
SELECT
  criticality_raw,
  criticality_standardised,
  criticality_rank,
  COUNT(*) AS asset_count
FROM your_catalog.your_schema.silver_transport_asset
WHERE criticality_standardised NOT IN (
    'Critical',
    'Very High',
    'High',
    'Medium',
    'Low',
    'Very Low',
    'Negligible',
    'Not supplied',
    'Other'
  )
  OR (criticality_standardised = 'Critical' AND criticality_rank <> 6)
  OR (criticality_standardised = 'Very High' AND criticality_rank <> 5)
  OR (criticality_standardised = 'High' AND criticality_rank <> 4)
  OR (criticality_standardised = 'Medium' AND criticality_rank <> 3)
  OR (criticality_standardised = 'Low' AND criticality_rank <> 2)
  OR (criticality_standardised = 'Very Low' AND criticality_rank <> 1)
  OR (criticality_standardised = 'Negligible' AND criticality_rank <> 0)
  OR (criticality_standardised IN ('Not supplied', 'Other') AND criticality_rank IS NOT NULL)
GROUP BY
  criticality_raw,
  criticality_standardised,
  criticality_rank
ORDER BY asset_count DESC, criticality_raw;


-- QA 5: criticality distribution by standard asset category.
-- This helps sense-check whether the high-criticality assets are concentrated
-- in categories where that makes operational sense.
SELECT
  COALESCE(m.asset_category, 'Other / Unclassified') AS asset_category,
  a.criticality_standardised,
  a.criticality_rank,
  COUNT(*) AS asset_count,
  COUNT(DISTINCT a.asset_type) AS distinct_asset_type_count,
  ARRAY_JOIN(SLICE(SORT_ARRAY(COLLECT_SET(COALESCE(m.standardised_asset_type_name, a.asset_type))), 1, 15), ', ') AS asset_type_examples
FROM your_catalog.your_schema.silver_transport_asset a
LEFT JOIN transport_dev.integ_transport_assets.asset_vision_asset_type_category_map m
  ON LOWER(TRIM(a.asset_type)) = LOWER(TRIM(m.asset_type))
GROUP BY
  COALESCE(m.asset_category, 'Other / Unclassified'),
  a.criticality_standardised,
  a.criticality_rank
ORDER BY
  COALESCE(a.criticality_rank, -1) DESC,
  asset_count DESC,
  asset_category;
