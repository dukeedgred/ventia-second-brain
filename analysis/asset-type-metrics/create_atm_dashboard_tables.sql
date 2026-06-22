-- Databricks SQL
-- SQL-first refresh for the asset-type dashboard tables.
--
-- This is the practical dashboard version of the workflow. It assumes the
-- detail-grain table already exists:
--   transport_dev.integ_transport_assets.atm_asset_type_metrics_detail
--
-- If you need to rebuild the detail table from raw Asset Vision sources, use
-- analysis/asset-type-metrics/output/asset_type_metrics_queries.sql as the
-- source aggregate SQL, then apply the mapping in
-- transport_dev.integ_transport_assets.asset_vision_asset_type_category_map.

CREATE SCHEMA IF NOT EXISTS transport_dev.integ_transport_assets;

USE CATALOG transport_dev;
USE SCHEMA integ_transport_assets;

-- 1. Standardised asset-type summary.
-- Grain: one row per standardised asset type.
CREATE OR REPLACE TABLE transport_dev.integ_transport_assets.atm_asset_type_metrics_summary
USING DELTA
AS
WITH detail AS (
  SELECT *
  FROM transport_dev.integ_transport_assets.atm_asset_type_metrics_detail
),
grouped AS (
  SELECT
    MAX(run_generated_at_utc) AS run_generated_at_utc,
    standardised_asset_type_name,
    MAX(asset_category) AS asset_category,
    MAX(asset_subcategory) AS asset_subcategory,
    SUM(asset_count) AS asset_count,
    COUNT(DISTINCT raw_asset_type) AS raw_asset_type_count,
    COUNT(DISTINCT source_label) AS source_label_count,
    COUNT(DISTINCT contract) AS contract_count,
    concat_ws('; ', sort_array(collect_set(raw_asset_type))) AS raw_asset_types,
    concat_ws('; ', sort_array(collect_set(source_label))) AS source_labels,
    concat_ws('; ', sort_array(collect_set(contract))) AS contracts,
    concat_ws('; ', sort_array(collect_set(mapping_method))) AS mapping_methods,
    concat_ws('; ', sort_array(collect_set(NULLIF(manual_review_notes, '')))) AS manual_review_notes,
    SUM(assets_with_classification) AS assets_with_classification,
    COUNT(DISTINCT NULLIF(classification_examples, '')) AS distinct_classifications,
    concat_ws('; ', sort_array(collect_set(NULLIF(classification_examples, '')))) AS classification_examples,
    concat_ws('; ', sort_array(collect_set(NULLIF(spatial_type_examples, '')))) AS spatial_type_examples,
    SUM(assets_with_condition) AS assets_with_condition,
    SUM(assets_with_criticality) AS assets_with_criticality,
    SUM(assets_with_risk) AS assets_with_risk,
    SUM(assets_with_chainage) AS assets_with_chainage,
    ROUND(SUM(chainage_length_km_proxy), 3) AS chainage_length_km_proxy,
    SUM(assets_with_parent_asset) AS assets_with_parent_asset,
    SUM(assets_with_stage) AS assets_with_stage,
    SUM(assets_with_construction_date) AS assets_with_construction_date,
    SUM(assets_with_construction_cost) AS assets_with_construction_cost,
    SUM(assets_with_useful_life) AS assets_with_useful_life,
    SUM(assets_with_condition_date) AS assets_with_condition_date,
    SUM(assets_with_location_row) AS assets_with_location_row,
    SUM(assets_with_wkt) AS assets_with_wkt,
    SUM(assets_with_valid_au_coord) AS assets_with_valid_au_coord,
    SUM(location_rows) AS location_rows,
    concat_ws('; ', sort_array(collect_set(NULLIF(wkt_geometry_types, '')))) AS wkt_geometry_types,
    SUM(attribute_rows) AS attribute_rows,
    COUNT(DISTINCT NULLIF(attribute_name_examples, '')) AS distinct_attribute_names,
    SUM(assets_with_attributes) AS assets_with_attributes,
    concat_ws('; ', sort_array(collect_set(NULLIF(attribute_name_examples, '')))) AS attribute_name_examples,
    SUM(job_count) AS job_count,
    SUM(assets_with_job) AS assets_with_job,
    SUM(completed_job_count) AS completed_job_count,
    SUM(overdue_open_job_count) AS overdue_open_job_count,
    SUM(inspection_count) AS inspection_count,
    SUM(assets_with_inspection) AS assets_with_inspection,
    SUM(completed_inspection_count) AS completed_inspection_count,
    SUM(overdue_open_inspection_count) AS overdue_open_inspection_count,
    SUM(capitalwork_count) AS capitalwork_count,
    SUM(assets_with_capitalwork) AS assets_with_capitalwork,
    SUM(completed_capitalwork_count) AS completed_capitalwork_count,
    SUM(asset_photo_count) AS asset_photo_count,
    SUM(assets_with_asset_photo) AS assets_with_asset_photo,
    SUM(job_photo_count) AS job_photo_count,
    SUM(assets_with_job_photo) AS assets_with_job_photo
  FROM detail
  GROUP BY standardised_asset_type_name
)
SELECT
  run_generated_at_utc,
  standardised_asset_type_name,
  asset_category,
  asset_subcategory,
  asset_count,
  raw_asset_type_count,
  source_label_count,
  contract_count,
  raw_asset_types,
  source_labels,
  contracts,
  mapping_methods,
  manual_review_notes,
  assets_with_classification,
  distinct_classifications,
  classification_examples,
  spatial_type_examples,
  assets_with_condition,
  ROUND(100.0 * assets_with_condition / NULLIF(asset_count, 0), 1) AS condition_coverage_pct,
  assets_with_criticality,
  ROUND(100.0 * assets_with_criticality / NULLIF(asset_count, 0), 1) AS criticality_coverage_pct,
  assets_with_risk,
  ROUND(100.0 * assets_with_risk / NULLIF(asset_count, 0), 1) AS risk_coverage_pct,
  assets_with_chainage,
  ROUND(100.0 * assets_with_chainage / NULLIF(asset_count, 0), 1) AS chainage_coverage_pct,
  chainage_length_km_proxy,
  assets_with_parent_asset,
  ROUND(100.0 * assets_with_parent_asset / NULLIF(asset_count, 0), 1) AS parent_asset_coverage_pct,
  assets_with_stage,
  ROUND(100.0 * assets_with_stage / NULLIF(asset_count, 0), 1) AS stage_coverage_pct,
  assets_with_construction_date,
  ROUND(100.0 * assets_with_construction_date / NULLIF(asset_count, 0), 1) AS construction_date_coverage_pct,
  assets_with_construction_cost,
  ROUND(100.0 * assets_with_construction_cost / NULLIF(asset_count, 0), 1) AS construction_cost_coverage_pct,
  assets_with_useful_life,
  ROUND(100.0 * assets_with_useful_life / NULLIF(asset_count, 0), 1) AS useful_life_coverage_pct,
  assets_with_condition_date,
  ROUND(100.0 * assets_with_condition_date / NULLIF(asset_count, 0), 1) AS condition_date_coverage_pct,
  assets_with_location_row,
  ROUND(100.0 * assets_with_location_row / NULLIF(asset_count, 0), 1) AS location_row_coverage_pct,
  assets_with_wkt,
  ROUND(100.0 * assets_with_wkt / NULLIF(asset_count, 0), 1) AS wkt_coverage_pct,
  assets_with_valid_au_coord,
  ROUND(100.0 * assets_with_valid_au_coord / NULLIF(asset_count, 0), 1) AS valid_au_coord_coverage_pct,
  location_rows,
  wkt_geometry_types,
  attribute_rows,
  distinct_attribute_names,
  assets_with_attributes,
  ROUND(100.0 * assets_with_attributes / NULLIF(asset_count, 0), 1) AS custom_attribute_coverage_pct,
  attribute_name_examples,
  job_count,
  assets_with_job,
  ROUND(100.0 * assets_with_job / NULLIF(asset_count, 0), 1) AS job_coverage_pct,
  ROUND(job_count / NULLIF(asset_count, 0), 3) AS jobs_per_asset,
  completed_job_count,
  overdue_open_job_count,
  inspection_count,
  assets_with_inspection,
  ROUND(100.0 * assets_with_inspection / NULLIF(asset_count, 0), 1) AS inspection_coverage_pct,
  ROUND(inspection_count / NULLIF(asset_count, 0), 3) AS inspections_per_asset,
  completed_inspection_count,
  overdue_open_inspection_count,
  capitalwork_count,
  assets_with_capitalwork,
  ROUND(100.0 * assets_with_capitalwork / NULLIF(asset_count, 0), 1) AS capitalwork_coverage_pct,
  completed_capitalwork_count,
  asset_photo_count,
  assets_with_asset_photo,
  ROUND(100.0 * assets_with_asset_photo / NULLIF(asset_count, 0), 1) AS asset_photo_coverage_pct,
  job_photo_count,
  assets_with_job_photo,
  ROUND(100.0 * assets_with_job_photo / NULLIF(asset_count, 0), 1) AS job_photo_asset_coverage_pct,
  asset_photo_count + job_photo_count AS total_photo_count
FROM grouped;

-- 2. Source/contract breakdown.
-- Grain: standardised asset type + source context + contract.
CREATE OR REPLACE TABLE transport_dev.integ_transport_assets.atm_asset_type_source_contract_breakdown
USING DELTA
AS
SELECT
  MAX(run_generated_at_utc) AS run_generated_at_utc,
  standardised_asset_type_name,
  MAX(asset_category) AS asset_category,
  MAX(asset_subcategory) AS asset_subcategory,
  source_label,
  source_context,
  source_catalog,
  contract,
  SUM(asset_count) AS asset_count,
  COUNT(DISTINCT raw_asset_type) AS raw_asset_type_count,
  concat_ws('; ', sort_array(collect_set(raw_asset_type))) AS raw_asset_types
FROM transport_dev.integ_transport_assets.atm_asset_type_metrics_detail
GROUP BY
  standardised_asset_type_name,
  source_label,
  source_context,
  source_catalog,
  contract;

-- 3. Raw-to-standardised mapping audit.
CREATE OR REPLACE TABLE transport_dev.integ_transport_assets.atm_asset_type_mapping
USING DELTA
AS
SELECT DISTINCT
  MAX(run_generated_at_utc) OVER () AS run_generated_at_utc,
  raw_asset_type,
  standardised_asset_type_name,
  asset_category,
  asset_subcategory,
  mapping_method,
  manual_review_notes
FROM transport_dev.integ_transport_assets.atm_asset_type_metrics_detail;

-- 4. Metric dictionary for dashboard tooltips.
CREATE OR REPLACE TABLE transport_dev.integ_transport_assets.atm_metric_dictionary
USING DELTA
AS
WITH run AS (
  SELECT MAX(run_generated_at_utc) AS run_generated_at_utc
  FROM transport_dev.integ_transport_assets.atm_asset_type_metrics_detail
),
metrics AS (
  SELECT * FROM VALUES
    (1, 'standardised_asset_type', 'Standardised asset type', 'asset.AssetType plus manual mapping table', 'Manual mapping by raw AssetType.', 'Use mapping audit table for taxonomy review.'),
    (2, 'asset_count', 'Asset count', 'asset.ID', 'COUNT DISTINCT non-deleted assets.', 'Base denominator for asset-type rates.'),
    (3, 'source_contract_coverage', 'Source / contract coverage', 'asset.Contract and source catalog label', 'Distinct source contexts and contracts where the asset type is present.', 'Blank contract values are replaced upstream by source context.'),
    (4, 'classification_coverage', 'Classification coverage', 'asset.Classification', 'Assets with non-empty classification / asset count.', 'Source-populated, not the same as the standardised taxonomy.'),
    (5, 'spatial_type_values', 'Spatial type values', 'asset.SpatialType', 'Distinct non-empty source spatial type values.', 'WKT geometry can differ from source SpatialType.'),
    (6, 'wkt_coverage', 'WKT coverage', 'vassetlocation.WKT', 'Assets with at least one non-empty WKT / asset count.', 'WKT availability varies by source and asset type.'),
    (7, 'valid_au_coord_coverage', 'Valid AU coordinate coverage', 'vassetlocation.WKT', 'Assets where first WKT coordinate is within approximate Australia bounds / asset count.', 'Proxy validation only, not a full geometry validation.'),
    (8, 'chainage_coverage', 'Chainage coverage', 'asset.ChainageFrom, asset.ChainageTo', 'Assets with either chainage value / asset count.', 'Linear reference meaning varies by contract.'),
    (9, 'chainage_length_km_proxy', 'Chainage length km proxy', 'asset.ChainageFrom, asset.ChainageTo', 'SUM positive ChainageTo - ChainageFrom divided by 1000.', 'Proxy only; unit assumptions need contract validation.'),
    (10, 'condition_coverage', 'Condition coverage', 'asset.AssetCondition', 'Assets with non-empty condition / asset count.', 'Condition vocabularies are not normalised here.'),
    (11, 'criticality_coverage', 'Criticality coverage', 'asset.AssetCriticality', 'Assets with non-empty criticality / asset count.', 'Source-populated and not necessarily contract-standard.'),
    (12, 'risk_coverage', 'Risk coverage', 'asset.AssetRisk', 'Assets with non-empty risk / asset count.', 'Risk scoring semantics are not normalised here.'),
    (13, 'custom_attribute_coverage', 'Custom attribute coverage', 'assetattribute.AssetID', 'Assets with at least one non-deleted custom attribute / asset count.', 'Attribute names and meanings vary by asset type.'),
    (14, 'distinct_attribute_names', 'Distinct custom attribute names', 'assetattribute.Name', 'Distinct custom attribute names observed by asset type.', 'Useful for dashboard drill-through and schema discovery.'),
    (15, 'job_coverage', 'Job coverage', 'job.AssetID and jobasset.AssetID', 'Assets linked to at least one job / asset count.', 'Relationship proxy, not an SLA metric.'),
    (16, 'jobs_per_asset', 'Jobs per asset', 'job and jobasset', 'Job count / asset count.', 'Can be skewed by source work-order history depth.'),
    (17, 'inspection_coverage', 'Inspection coverage', 'inspection.AssetID', 'Assets linked to at least one inspection / asset count.', 'Inspection schedule completeness is not validated here.'),
    (18, 'inspections_per_asset', 'Inspections per asset', 'inspection.AssetID', 'Inspection count / asset count.', 'Historical depth varies by source.'),
    (19, 'capitalwork_coverage', 'Capital-work coverage', 'capitalwork.AssetID', 'Assets linked to at least one capital work / asset count.', 'Capital work semantics vary by source.'),
    (20, 'photo_evidence', 'Photo evidence', 'photo.SourceTable, photo.SourceTableID', 'Asset photos plus job photos linked back to assets.', 'Counts direct asset photos and job evidence photos.')
  AS t(metric_order, metric_id, metric_name, source_columns, formula, caveat)
)
SELECT
  run.run_generated_at_utc,
  metrics.metric_order,
  metrics.metric_id,
  metrics.metric_name,
  metrics.source_columns,
  metrics.formula,
  metrics.caveat
FROM metrics
CROSS JOIN run;

-- 5. Refresh/run status.
CREATE OR REPLACE TABLE transport_dev.integ_transport_assets.atm_run_status
USING DELTA
AS
WITH source_contexts AS (
  SELECT * FROM VALUES
    ('asset_vision_ven_gen7', 'ext_mssql_asset_vision_ven_gen7', 'RAMC / BAC / PoB / TSRC group'),
    ('asset_vision_ven_rms', 'ext_mssql_asset_vision_ven_rms', 'RMS'),
    ('asset_vision_ven_rms_new', 'ext_mssql_asset_vision_ven_rms_new', 'RMS new'),
    ('asset_vision_ven_rms_old', 'ext_mssql_asset_vision_ven_rms_old', 'RMS old'),
    ('asset_vision_ven_vicroads', 'ext_mssql_asset_vision_ven_vicroads', 'VicRoads'),
    ('asset_vision_vns_gen7', 'ext_mssql_asset_vision_vns_gen7', 'VNS'),
    ('asset_vision_vnz_gen7', 'ext_mssql_asset_vision_vnz_gen7', 'VNZ'),
    ('asset_vision_vsm_gen7', 'ext_mssql_asset_vision_vsm_gen7', 'VentureSmart')
  AS t(source_context, source_catalog, source_label)
),
loaded AS (
  SELECT
    source_context,
    MAX(run_generated_at_utc) AS run_generated_at_utc,
    COUNT(*) AS aggregate_row_count,
    SUM(asset_count) AS asset_count,
    MAX(available_tables) AS available_tables
  FROM transport_dev.integ_transport_assets.atm_asset_type_metrics_detail
  GROUP BY source_context
)
SELECT
  COALESCE(l.run_generated_at_utc, MAX(l.run_generated_at_utc) OVER ()) AS run_generated_at_utc,
  s.source_context,
  s.source_catalog,
  s.source_label,
  CASE WHEN l.source_context IS NULL THEN 'skipped' ELSE 'loaded' END AS status,
  COALESCE(l.aggregate_row_count, 0) AS aggregate_row_count,
  COALESCE(l.asset_count, 0) AS asset_count,
  COALESCE(l.available_tables, '') AS available_tables,
  CASE
    WHEN l.source_context IS NULL
      THEN 'No detail rows returned or source catalog was not visible during refresh.'
    ELSE ''
  END AS message
FROM source_contexts s
LEFT JOIN loaded l
  ON l.source_context = s.source_context;

-- 6. Quick validation counts.
SELECT 'atm_asset_type_metrics_summary' AS table_name, COUNT(*) AS row_count
FROM transport_dev.integ_transport_assets.atm_asset_type_metrics_summary
UNION ALL
SELECT 'atm_asset_type_metrics_detail', COUNT(*)
FROM transport_dev.integ_transport_assets.atm_asset_type_metrics_detail
UNION ALL
SELECT 'atm_asset_type_source_contract_breakdown', COUNT(*)
FROM transport_dev.integ_transport_assets.atm_asset_type_source_contract_breakdown
UNION ALL
SELECT 'atm_asset_type_mapping', COUNT(*)
FROM transport_dev.integ_transport_assets.atm_asset_type_mapping
UNION ALL
SELECT 'atm_metric_dictionary', COUNT(*)
FROM transport_dev.integ_transport_assets.atm_metric_dictionary
UNION ALL
SELECT 'atm_run_status', COUNT(*)
FROM transport_dev.integ_transport_assets.atm_run_status;
