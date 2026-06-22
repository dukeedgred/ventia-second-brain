-- Databricks SQL
-- Recreate transport_dev.integ_transport_assets.atm_asset_type_metrics_detail
-- directly from the active Asset Vision source catalogues.
--
-- Prerequisite:
--   Run analysis/deterioration-analysis/create_asset_type_category_map.sql first
--   so transport_dev.integ_transport_assets.asset_vision_asset_type_category_map
--   exists.
--
-- Grain:
--   one row per source context + contract + raw Asset Vision asset type.
--
-- Note:
--   ext_mssql_asset_vision_ven_rms_old is intentionally excluded because it was
--   not visible during the validated run.

CREATE SCHEMA IF NOT EXISTS transport_dev.integ_transport_assets;

CREATE OR REPLACE TABLE transport_dev.integ_transport_assets.atm_asset_type_metrics_detail
USING DELTA
AS
WITH asset_base AS (
  SELECT 'asset_vision_ven_gen7' AS source_context, 'ext_mssql_asset_vision_ven_gen7' AS source_catalog, 'RAMC / BAC / PoB / TSRC group' AS source_label, CAST(ID AS STRING) AS asset_id, COALESCE(NULLIF(TRIM(CAST(Contract AS STRING)), ''), 'asset_vision_ven_gen7') AS contract, COALESCE(NULLIF(TRIM(CAST(AssetType AS STRING)), ''), 'Unspecified asset type') AS raw_asset_type, NULLIF(TRIM(CAST(Classification AS STRING)), '') AS classification, NULLIF(TRIM(CAST(SpatialType AS STRING)), '') AS spatial_type, NULLIF(TRIM(CAST(AssetCondition AS STRING)), '') AS asset_condition, NULLIF(TRIM(CAST(AssetCriticality AS STRING)), '') AS asset_criticality, NULLIF(TRIM(CAST(AssetRisk AS STRING)), '') AS asset_risk, CAST(ChainageFrom AS DOUBLE) AS chainage_from, CAST(ChainageTo AS DOUBLE) AS chainage_to, CAST(ParentAssetID AS STRING) AS parent_asset_id, NULLIF(TRIM(CAST(Stage AS STRING)), '') AS stage, CAST(ConstructionDate AS TIMESTAMP) AS construction_date, CAST(ConstructionCost AS DOUBLE) AS construction_cost, CAST(UsefulLife AS DOUBLE) AS useful_life, CAST(ConditionDate AS TIMESTAMP) AS condition_date FROM `ext_mssql_asset_vision_ven_gen7`.dbo.asset WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_ven_rms', 'ext_mssql_asset_vision_ven_rms', 'RMS', CAST(ID AS STRING), COALESCE(NULLIF(TRIM(CAST(Contract AS STRING)), ''), 'asset_vision_ven_rms'), COALESCE(NULLIF(TRIM(CAST(AssetType AS STRING)), ''), 'Unspecified asset type'), NULLIF(TRIM(CAST(Classification AS STRING)), ''), NULLIF(TRIM(CAST(SpatialType AS STRING)), ''), NULLIF(TRIM(CAST(AssetCondition AS STRING)), ''), NULLIF(TRIM(CAST(AssetCriticality AS STRING)), ''), NULLIF(TRIM(CAST(AssetRisk AS STRING)), ''), CAST(ChainageFrom AS DOUBLE), CAST(ChainageTo AS DOUBLE), CAST(ParentAssetID AS STRING), NULLIF(TRIM(CAST(Stage AS STRING)), ''), CAST(ConstructionDate AS TIMESTAMP), CAST(ConstructionCost AS DOUBLE), CAST(UsefulLife AS DOUBLE), CAST(ConditionDate AS TIMESTAMP) FROM `ext_mssql_asset_vision_ven_rms`.dbo.asset WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_ven_rms_new', 'ext_mssql_asset_vision_ven_rms_new', 'RMS new', CAST(ID AS STRING), COALESCE(NULLIF(TRIM(CAST(Contract AS STRING)), ''), 'asset_vision_ven_rms_new'), COALESCE(NULLIF(TRIM(CAST(AssetType AS STRING)), ''), 'Unspecified asset type'), NULLIF(TRIM(CAST(Classification AS STRING)), ''), NULLIF(TRIM(CAST(SpatialType AS STRING)), ''), NULLIF(TRIM(CAST(AssetCondition AS STRING)), ''), NULLIF(TRIM(CAST(AssetCriticality AS STRING)), ''), NULLIF(TRIM(CAST(AssetRisk AS STRING)), ''), CAST(ChainageFrom AS DOUBLE), CAST(ChainageTo AS DOUBLE), CAST(ParentAssetID AS STRING), NULLIF(TRIM(CAST(Stage AS STRING)), ''), CAST(ConstructionDate AS TIMESTAMP), CAST(ConstructionCost AS DOUBLE), CAST(UsefulLife AS DOUBLE), CAST(ConditionDate AS TIMESTAMP) FROM `ext_mssql_asset_vision_ven_rms_new`.dbo.asset WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_ven_vicroads', 'ext_mssql_asset_vision_ven_vicroads', 'VicRoads', CAST(ID AS STRING), COALESCE(NULLIF(TRIM(CAST(Contract AS STRING)), ''), 'asset_vision_ven_vicroads'), COALESCE(NULLIF(TRIM(CAST(AssetType AS STRING)), ''), 'Unspecified asset type'), NULLIF(TRIM(CAST(Classification AS STRING)), ''), NULLIF(TRIM(CAST(SpatialType AS STRING)), ''), NULLIF(TRIM(CAST(AssetCondition AS STRING)), ''), NULLIF(TRIM(CAST(AssetCriticality AS STRING)), ''), NULLIF(TRIM(CAST(AssetRisk AS STRING)), ''), CAST(ChainageFrom AS DOUBLE), CAST(ChainageTo AS DOUBLE), CAST(ParentAssetID AS STRING), NULLIF(TRIM(CAST(Stage AS STRING)), ''), CAST(ConstructionDate AS TIMESTAMP), CAST(ConstructionCost AS DOUBLE), CAST(UsefulLife AS DOUBLE), CAST(ConditionDate AS TIMESTAMP) FROM `ext_mssql_asset_vision_ven_vicroads`.dbo.asset WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_vns_gen7', 'ext_mssql_asset_vision_vns_gen7', 'VNS', CAST(ID AS STRING), COALESCE(NULLIF(TRIM(CAST(Contract AS STRING)), ''), 'asset_vision_vns_gen7'), COALESCE(NULLIF(TRIM(CAST(AssetType AS STRING)), ''), 'Unspecified asset type'), NULLIF(TRIM(CAST(Classification AS STRING)), ''), NULLIF(TRIM(CAST(SpatialType AS STRING)), ''), NULLIF(TRIM(CAST(AssetCondition AS STRING)), ''), NULLIF(TRIM(CAST(AssetCriticality AS STRING)), ''), NULLIF(TRIM(CAST(AssetRisk AS STRING)), ''), CAST(ChainageFrom AS DOUBLE), CAST(ChainageTo AS DOUBLE), CAST(ParentAssetID AS STRING), NULLIF(TRIM(CAST(Stage AS STRING)), ''), CAST(ConstructionDate AS TIMESTAMP), CAST(ConstructionCost AS DOUBLE), CAST(UsefulLife AS DOUBLE), CAST(ConditionDate AS TIMESTAMP) FROM `ext_mssql_asset_vision_vns_gen7`.dbo.asset WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_vnz_gen7', 'ext_mssql_asset_vision_vnz_gen7', 'VNZ', CAST(ID AS STRING), COALESCE(NULLIF(TRIM(CAST(Contract AS STRING)), ''), 'asset_vision_vnz_gen7'), COALESCE(NULLIF(TRIM(CAST(AssetType AS STRING)), ''), 'Unspecified asset type'), NULLIF(TRIM(CAST(Classification AS STRING)), ''), NULLIF(TRIM(CAST(SpatialType AS STRING)), ''), NULLIF(TRIM(CAST(AssetCondition AS STRING)), ''), NULLIF(TRIM(CAST(AssetCriticality AS STRING)), ''), NULLIF(TRIM(CAST(AssetRisk AS STRING)), ''), CAST(ChainageFrom AS DOUBLE), CAST(ChainageTo AS DOUBLE), CAST(ParentAssetID AS STRING), NULLIF(TRIM(CAST(Stage AS STRING)), ''), CAST(ConstructionDate AS TIMESTAMP), CAST(ConstructionCost AS DOUBLE), CAST(UsefulLife AS DOUBLE), CAST(ConditionDate AS TIMESTAMP) FROM `ext_mssql_asset_vision_vnz_gen7`.dbo.asset WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_vsm_gen7', 'ext_mssql_asset_vision_vsm_gen7', 'VentureSmart', CAST(ID AS STRING), COALESCE(NULLIF(TRIM(CAST(Contract AS STRING)), ''), 'asset_vision_vsm_gen7'), COALESCE(NULLIF(TRIM(CAST(AssetType AS STRING)), ''), 'Unspecified asset type'), NULLIF(TRIM(CAST(Classification AS STRING)), ''), NULLIF(TRIM(CAST(SpatialType AS STRING)), ''), NULLIF(TRIM(CAST(AssetCondition AS STRING)), ''), NULLIF(TRIM(CAST(AssetCriticality AS STRING)), ''), NULLIF(TRIM(CAST(AssetRisk AS STRING)), ''), CAST(ChainageFrom AS DOUBLE), CAST(ChainageTo AS DOUBLE), CAST(ParentAssetID AS STRING), NULLIF(TRIM(CAST(Stage AS STRING)), ''), CAST(ConstructionDate AS TIMESTAMP), CAST(ConstructionCost AS DOUBLE), CAST(UsefulLife AS DOUBLE), CAST(ConditionDate AS TIMESTAMP) FROM `ext_mssql_asset_vision_vsm_gen7`.dbo.asset WHERE COALESCE(Deleted, false) = false
),
loc_by_asset AS (
  SELECT 'asset_vision_ven_gen7' AS source_context, CAST(AssetID AS STRING) AS asset_id, COUNT(*) AS location_rows, MAX(CASE WHEN WKT IS NOT NULL AND TRIM(CAST(WKT AS STRING)) <> '' THEN 1 ELSE 0 END) AS has_wkt, MAX(CASE WHEN CAST(regexp_extract(WKT, '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)', 1) AS DOUBLE) BETWEEN 112 AND 180 AND CAST(regexp_extract(WKT, '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)', 2) AS DOUBLE) BETWEEN -48 AND -9 THEN 1 ELSE 0 END) AS has_valid_au_coord, concat_ws('; ', sort_array(collect_set(NULLIF(upper(regexp_extract(TRIM(CAST(WKT AS STRING)), '^([A-Za-z]+)', 1)), '')))) AS wkt_geometry_types FROM `ext_mssql_asset_vision_ven_gen7`.dbo.vassetlocation WHERE COALESCE(Deleted, false) = false GROUP BY CAST(AssetID AS STRING)
  UNION ALL SELECT 'asset_vision_ven_rms', CAST(AssetID AS STRING), COUNT(*), MAX(CASE WHEN WKT IS NOT NULL AND TRIM(CAST(WKT AS STRING)) <> '' THEN 1 ELSE 0 END), MAX(CASE WHEN CAST(regexp_extract(WKT, '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)', 1) AS DOUBLE) BETWEEN 112 AND 180 AND CAST(regexp_extract(WKT, '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)', 2) AS DOUBLE) BETWEEN -48 AND -9 THEN 1 ELSE 0 END), concat_ws('; ', sort_array(collect_set(NULLIF(upper(regexp_extract(TRIM(CAST(WKT AS STRING)), '^([A-Za-z]+)', 1)), '')))) FROM `ext_mssql_asset_vision_ven_rms`.dbo.vassetlocation WHERE COALESCE(Deleted, false) = false GROUP BY CAST(AssetID AS STRING)
  UNION ALL SELECT 'asset_vision_ven_rms_new', CAST(AssetID AS STRING), COUNT(*), MAX(CASE WHEN WKT IS NOT NULL AND TRIM(CAST(WKT AS STRING)) <> '' THEN 1 ELSE 0 END), MAX(CASE WHEN CAST(regexp_extract(WKT, '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)', 1) AS DOUBLE) BETWEEN 112 AND 180 AND CAST(regexp_extract(WKT, '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)', 2) AS DOUBLE) BETWEEN -48 AND -9 THEN 1 ELSE 0 END), concat_ws('; ', sort_array(collect_set(NULLIF(upper(regexp_extract(TRIM(CAST(WKT AS STRING)), '^([A-Za-z]+)', 1)), '')))) FROM `ext_mssql_asset_vision_ven_rms_new`.dbo.vassetlocation WHERE COALESCE(Deleted, false) = false GROUP BY CAST(AssetID AS STRING)
  UNION ALL SELECT 'asset_vision_ven_vicroads', CAST(AssetID AS STRING), COUNT(*), MAX(CASE WHEN WKT IS NOT NULL AND TRIM(CAST(WKT AS STRING)) <> '' THEN 1 ELSE 0 END), MAX(CASE WHEN CAST(regexp_extract(WKT, '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)', 1) AS DOUBLE) BETWEEN 112 AND 180 AND CAST(regexp_extract(WKT, '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)', 2) AS DOUBLE) BETWEEN -48 AND -9 THEN 1 ELSE 0 END), concat_ws('; ', sort_array(collect_set(NULLIF(upper(regexp_extract(TRIM(CAST(WKT AS STRING)), '^([A-Za-z]+)', 1)), '')))) FROM `ext_mssql_asset_vision_ven_vicroads`.dbo.vassetlocation WHERE COALESCE(Deleted, false) = false GROUP BY CAST(AssetID AS STRING)
  UNION ALL SELECT 'asset_vision_vns_gen7', CAST(AssetID AS STRING), COUNT(*), MAX(CASE WHEN WKT IS NOT NULL AND TRIM(CAST(WKT AS STRING)) <> '' THEN 1 ELSE 0 END), MAX(CASE WHEN CAST(regexp_extract(WKT, '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)', 1) AS DOUBLE) BETWEEN 112 AND 180 AND CAST(regexp_extract(WKT, '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)', 2) AS DOUBLE) BETWEEN -48 AND -9 THEN 1 ELSE 0 END), concat_ws('; ', sort_array(collect_set(NULLIF(upper(regexp_extract(TRIM(CAST(WKT AS STRING)), '^([A-Za-z]+)', 1)), '')))) FROM `ext_mssql_asset_vision_vns_gen7`.dbo.vassetlocation WHERE COALESCE(Deleted, false) = false GROUP BY CAST(AssetID AS STRING)
  UNION ALL SELECT 'asset_vision_vnz_gen7', CAST(AssetID AS STRING), COUNT(*), MAX(CASE WHEN WKT IS NOT NULL AND TRIM(CAST(WKT AS STRING)) <> '' THEN 1 ELSE 0 END), MAX(CASE WHEN CAST(regexp_extract(WKT, '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)', 1) AS DOUBLE) BETWEEN 112 AND 180 AND CAST(regexp_extract(WKT, '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)', 2) AS DOUBLE) BETWEEN -48 AND -9 THEN 1 ELSE 0 END), concat_ws('; ', sort_array(collect_set(NULLIF(upper(regexp_extract(TRIM(CAST(WKT AS STRING)), '^([A-Za-z]+)', 1)), '')))) FROM `ext_mssql_asset_vision_vnz_gen7`.dbo.vassetlocation WHERE COALESCE(Deleted, false) = false GROUP BY CAST(AssetID AS STRING)
  UNION ALL SELECT 'asset_vision_vsm_gen7', CAST(AssetID AS STRING), COUNT(*), MAX(CASE WHEN WKT IS NOT NULL AND TRIM(CAST(WKT AS STRING)) <> '' THEN 1 ELSE 0 END), MAX(CASE WHEN CAST(regexp_extract(WKT, '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)', 1) AS DOUBLE) BETWEEN 112 AND 180 AND CAST(regexp_extract(WKT, '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)', 2) AS DOUBLE) BETWEEN -48 AND -9 THEN 1 ELSE 0 END), concat_ws('; ', sort_array(collect_set(NULLIF(upper(regexp_extract(TRIM(CAST(WKT AS STRING)), '^([A-Za-z]+)', 1)), '')))) FROM `ext_mssql_asset_vision_vsm_gen7`.dbo.vassetlocation WHERE COALESCE(Deleted, false) = false GROUP BY CAST(AssetID AS STRING)
),
assetattribute AS (
  SELECT 'asset_vision_ven_gen7' AS source_context, CAST(AssetID AS STRING) AS asset_id, NULLIF(TRIM(CAST(Name AS STRING)), '') AS attribute_name FROM `ext_mssql_asset_vision_ven_gen7`.dbo.assetattribute WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_ven_rms', CAST(AssetID AS STRING), NULLIF(TRIM(CAST(Name AS STRING)), '') FROM `ext_mssql_asset_vision_ven_rms`.dbo.assetattribute WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_ven_rms_new', CAST(AssetID AS STRING), NULLIF(TRIM(CAST(Name AS STRING)), '') FROM `ext_mssql_asset_vision_ven_rms_new`.dbo.assetattribute WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_ven_vicroads', CAST(AssetID AS STRING), NULLIF(TRIM(CAST(Name AS STRING)), '') FROM `ext_mssql_asset_vision_ven_vicroads`.dbo.assetattribute WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_vns_gen7', CAST(AssetID AS STRING), NULLIF(TRIM(CAST(Name AS STRING)), '') FROM `ext_mssql_asset_vision_vns_gen7`.dbo.assetattribute WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_vnz_gen7', CAST(AssetID AS STRING), NULLIF(TRIM(CAST(Name AS STRING)), '') FROM `ext_mssql_asset_vision_vnz_gen7`.dbo.assetattribute WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_vsm_gen7', CAST(AssetID AS STRING), NULLIF(TRIM(CAST(Name AS STRING)), '') FROM `ext_mssql_asset_vision_vsm_gen7`.dbo.assetattribute WHERE COALESCE(Deleted, false) = false
),
job_base AS (
  SELECT 'asset_vision_ven_gen7' AS source_context, CAST(ID AS STRING) AS job_id, CAST(AssetID AS STRING) AS asset_id, CAST(DueDate AS TIMESTAMP) AS due_date, CAST(CompletedDate AS TIMESTAMP) AS completed_date, NULLIF(TRIM(CAST(HazardDefectCode AS STRING)), '') AS hazard_defect_code, NULLIF(TRIM(CAST(ActivityCategoryName AS STRING)), '') AS activity_category_name, NULLIF(TRIM(CAST(ActivityName AS STRING)), '') AS activity_name, NULLIF(TRIM(CAST(InterventionCode AS STRING)), '') AS intervention_code, CAST(EstimatedQuantity AS DOUBLE) AS estimated_quantity, NULLIF(TRIM(CAST(Priority AS STRING)), '') AS priority, NULLIF(TRIM(CAST(ActivityType AS STRING)), '') AS activity_type, NULLIF(TRIM(CAST(Compliant AS STRING)), '') AS compliant, CAST(RemainingQuantity AS DOUBLE) AS remaining_quantity, CAST(ActualQuantity AS DOUBLE) AS actual_quantity, NULLIF(TRIM(CAST(InspectionTypeName AS STRING)), '') AS inspection_type_name, CAST(EstimatedLength AS DOUBLE) AS estimated_length, CAST(EstimatedWidth AS DOUBLE) AS estimated_width, CAST(EstimatedDepth AS DOUBLE) AS estimated_depth FROM `ext_mssql_asset_vision_ven_gen7`.dbo.job WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_ven_rms', CAST(ID AS STRING), CAST(AssetID AS STRING), CAST(DueDate AS TIMESTAMP), CAST(CompletedDate AS TIMESTAMP), NULLIF(TRIM(CAST(HazardDefectCode AS STRING)), ''), NULLIF(TRIM(CAST(ActivityCategoryName AS STRING)), ''), NULLIF(TRIM(CAST(ActivityName AS STRING)), ''), NULLIF(TRIM(CAST(InterventionCode AS STRING)), ''), CAST(EstimatedQuantity AS DOUBLE), NULLIF(TRIM(CAST(Priority AS STRING)), ''), NULLIF(TRIM(CAST(ActivityType AS STRING)), ''), NULLIF(TRIM(CAST(Compliant AS STRING)), ''), CAST(RemainingQuantity AS DOUBLE), CAST(ActualQuantity AS DOUBLE), NULLIF(TRIM(CAST(InspectionTypeName AS STRING)), ''), CAST(EstimatedLength AS DOUBLE), CAST(EstimatedWidth AS DOUBLE), CAST(EstimatedDepth AS DOUBLE) FROM `ext_mssql_asset_vision_ven_rms`.dbo.job WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_ven_rms_new', CAST(ID AS STRING), CAST(AssetID AS STRING), CAST(DueDate AS TIMESTAMP), CAST(CompletedDate AS TIMESTAMP), NULLIF(TRIM(CAST(HazardDefectCode AS STRING)), ''), NULLIF(TRIM(CAST(ActivityCategoryName AS STRING)), ''), NULLIF(TRIM(CAST(ActivityName AS STRING)), ''), NULLIF(TRIM(CAST(InterventionCode AS STRING)), ''), CAST(EstimatedQuantity AS DOUBLE), NULLIF(TRIM(CAST(Priority AS STRING)), ''), NULLIF(TRIM(CAST(ActivityType AS STRING)), ''), NULLIF(TRIM(CAST(Compliant AS STRING)), ''), CAST(RemainingQuantity AS DOUBLE), CAST(ActualQuantity AS DOUBLE), NULLIF(TRIM(CAST(InspectionTypeName AS STRING)), ''), CAST(EstimatedLength AS DOUBLE), CAST(EstimatedWidth AS DOUBLE), CAST(EstimatedDepth AS DOUBLE) FROM `ext_mssql_asset_vision_ven_rms_new`.dbo.job WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_ven_vicroads', CAST(ID AS STRING), CAST(AssetID AS STRING), CAST(DueDate AS TIMESTAMP), CAST(CompletedDate AS TIMESTAMP), NULLIF(TRIM(CAST(HazardDefectCode AS STRING)), ''), NULLIF(TRIM(CAST(ActivityCategoryName AS STRING)), ''), NULLIF(TRIM(CAST(ActivityName AS STRING)), ''), NULLIF(TRIM(CAST(InterventionCode AS STRING)), ''), CAST(EstimatedQuantity AS DOUBLE), NULLIF(TRIM(CAST(Priority AS STRING)), ''), NULLIF(TRIM(CAST(ActivityType AS STRING)), ''), NULLIF(TRIM(CAST(Compliant AS STRING)), ''), CAST(RemainingQuantity AS DOUBLE), CAST(ActualQuantity AS DOUBLE), NULLIF(TRIM(CAST(InspectionTypeName AS STRING)), ''), CAST(EstimatedLength AS DOUBLE), CAST(EstimatedWidth AS DOUBLE), CAST(EstimatedDepth AS DOUBLE) FROM `ext_mssql_asset_vision_ven_vicroads`.dbo.job WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_vns_gen7', CAST(ID AS STRING), CAST(AssetID AS STRING), CAST(DueDate AS TIMESTAMP), CAST(CompletedDate AS TIMESTAMP), NULLIF(TRIM(CAST(HazardDefectCode AS STRING)), ''), NULLIF(TRIM(CAST(ActivityCategoryName AS STRING)), ''), NULLIF(TRIM(CAST(ActivityName AS STRING)), ''), NULLIF(TRIM(CAST(InterventionCode AS STRING)), ''), CAST(EstimatedQuantity AS DOUBLE), NULLIF(TRIM(CAST(Priority AS STRING)), ''), NULLIF(TRIM(CAST(ActivityType AS STRING)), ''), NULLIF(TRIM(CAST(Compliant AS STRING)), ''), CAST(RemainingQuantity AS DOUBLE), CAST(ActualQuantity AS DOUBLE), NULLIF(TRIM(CAST(InspectionTypeName AS STRING)), ''), CAST(EstimatedLength AS DOUBLE), CAST(EstimatedWidth AS DOUBLE), CAST(EstimatedDepth AS DOUBLE) FROM `ext_mssql_asset_vision_vns_gen7`.dbo.job WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_vnz_gen7', CAST(ID AS STRING), CAST(AssetID AS STRING), CAST(DueDate AS TIMESTAMP), CAST(CompletedDate AS TIMESTAMP), NULLIF(TRIM(CAST(HazardDefectCode AS STRING)), ''), NULLIF(TRIM(CAST(ActivityCategoryName AS STRING)), ''), NULLIF(TRIM(CAST(ActivityName AS STRING)), ''), NULLIF(TRIM(CAST(InterventionCode AS STRING)), ''), CAST(EstimatedQuantity AS DOUBLE), NULLIF(TRIM(CAST(Priority AS STRING)), ''), NULLIF(TRIM(CAST(ActivityType AS STRING)), ''), NULLIF(TRIM(CAST(Compliant AS STRING)), ''), CAST(RemainingQuantity AS DOUBLE), CAST(ActualQuantity AS DOUBLE), NULLIF(TRIM(CAST(InspectionTypeName AS STRING)), ''), CAST(EstimatedLength AS DOUBLE), CAST(EstimatedWidth AS DOUBLE), CAST(EstimatedDepth AS DOUBLE) FROM `ext_mssql_asset_vision_vnz_gen7`.dbo.job WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_vsm_gen7', CAST(ID AS STRING), CAST(AssetID AS STRING), CAST(DueDate AS TIMESTAMP), CAST(CompletedDate AS TIMESTAMP), NULLIF(TRIM(CAST(HazardDefectCode AS STRING)), ''), NULLIF(TRIM(CAST(ActivityCategoryName AS STRING)), ''), NULLIF(TRIM(CAST(ActivityName AS STRING)), ''), NULLIF(TRIM(CAST(InterventionCode AS STRING)), ''), CAST(EstimatedQuantity AS DOUBLE), NULLIF(TRIM(CAST(Priority AS STRING)), ''), NULLIF(TRIM(CAST(ActivityType AS STRING)), ''), NULLIF(TRIM(CAST(Compliant AS STRING)), ''), CAST(RemainingQuantity AS DOUBLE), CAST(ActualQuantity AS DOUBLE), NULLIF(TRIM(CAST(InspectionTypeName AS STRING)), ''), CAST(EstimatedLength AS DOUBLE), CAST(EstimatedWidth AS DOUBLE), CAST(EstimatedDepth AS DOUBLE) FROM `ext_mssql_asset_vision_vsm_gen7`.dbo.job WHERE COALESCE(Deleted, false) = false
),
jobasset_base AS (
  SELECT 'asset_vision_ven_gen7' AS source_context, CAST(JobID AS STRING) AS job_id, CAST(AssetID AS STRING) AS asset_id FROM `ext_mssql_asset_vision_ven_gen7`.dbo.jobasset WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_ven_rms', CAST(JobID AS STRING), CAST(AssetID AS STRING) FROM `ext_mssql_asset_vision_ven_rms`.dbo.jobasset WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_ven_rms_new', CAST(JobID AS STRING), CAST(AssetID AS STRING) FROM `ext_mssql_asset_vision_ven_rms_new`.dbo.jobasset WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_ven_vicroads', CAST(JobID AS STRING), CAST(AssetID AS STRING) FROM `ext_mssql_asset_vision_ven_vicroads`.dbo.jobasset WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_vns_gen7', CAST(JobID AS STRING), CAST(AssetID AS STRING) FROM `ext_mssql_asset_vision_vns_gen7`.dbo.jobasset WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_vnz_gen7', CAST(JobID AS STRING), CAST(AssetID AS STRING) FROM `ext_mssql_asset_vision_vnz_gen7`.dbo.jobasset WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_vsm_gen7', CAST(JobID AS STRING), CAST(AssetID AS STRING) FROM `ext_mssql_asset_vision_vsm_gen7`.dbo.jobasset WHERE COALESCE(Deleted, false) = false
),
job_link AS (
  SELECT source_context, job_id, asset_id, due_date, completed_date, hazard_defect_code, activity_category_name, activity_name, intervention_code, estimated_quantity, priority, activity_type, compliant, remaining_quantity, actual_quantity, inspection_type_name, estimated_length, estimated_width, estimated_depth FROM job_base WHERE asset_id IS NOT NULL
  UNION
  SELECT ja.source_context, ja.job_id, ja.asset_id, j.due_date, j.completed_date, j.hazard_defect_code, j.activity_category_name, j.activity_name, j.intervention_code, j.estimated_quantity, j.priority, j.activity_type, j.compliant, j.remaining_quantity, j.actual_quantity, j.inspection_type_name, j.estimated_length, j.estimated_width, j.estimated_depth
  FROM jobasset_base ja
  LEFT JOIN job_base j ON j.source_context = ja.source_context AND j.job_id = ja.job_id
  WHERE ja.asset_id IS NOT NULL
),
inspection_base AS (
  SELECT 'asset_vision_ven_gen7' AS source_context, CAST(ID AS STRING) AS inspection_id, CAST(AssetID AS STRING) AS asset_id, CAST(COALESCE(ScheduledDateTo, ScheduledDate) AS TIMESTAMP) AS due_date, CAST(CompletedDate AS TIMESTAMP) AS completed_date FROM `ext_mssql_asset_vision_ven_gen7`.dbo.inspection WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_ven_rms', CAST(ID AS STRING), CAST(AssetID AS STRING), CAST(COALESCE(ScheduledDateTo, ScheduledDate) AS TIMESTAMP), CAST(CompletedDate AS TIMESTAMP) FROM `ext_mssql_asset_vision_ven_rms`.dbo.inspection WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_ven_rms_new', CAST(ID AS STRING), CAST(AssetID AS STRING), CAST(COALESCE(ScheduledDateTo, ScheduledDate) AS TIMESTAMP), CAST(CompletedDate AS TIMESTAMP) FROM `ext_mssql_asset_vision_ven_rms_new`.dbo.inspection WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_ven_vicroads', CAST(ID AS STRING), CAST(AssetID AS STRING), CAST(COALESCE(ScheduledDateTo, ScheduledDate) AS TIMESTAMP), CAST(CompletedDate AS TIMESTAMP) FROM `ext_mssql_asset_vision_ven_vicroads`.dbo.inspection WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_vns_gen7', CAST(ID AS STRING), CAST(AssetID AS STRING), CAST(COALESCE(ScheduledDateTo, ScheduledDate) AS TIMESTAMP), CAST(CompletedDate AS TIMESTAMP) FROM `ext_mssql_asset_vision_vns_gen7`.dbo.inspection WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_vnz_gen7', CAST(ID AS STRING), CAST(AssetID AS STRING), CAST(COALESCE(ScheduledDateTo, ScheduledDate) AS TIMESTAMP), CAST(CompletedDate AS TIMESTAMP) FROM `ext_mssql_asset_vision_vnz_gen7`.dbo.inspection WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_vsm_gen7', CAST(ID AS STRING), CAST(AssetID AS STRING), CAST(COALESCE(ScheduledDateTo, ScheduledDate) AS TIMESTAMP), CAST(CompletedDate AS TIMESTAMP) FROM `ext_mssql_asset_vision_vsm_gen7`.dbo.inspection WHERE COALESCE(Deleted, false) = false
),
capitalwork_base AS (
  SELECT 'asset_vision_ven_gen7' AS source_context, CAST(ID AS STRING) AS capitalwork_id, CAST(AssetID AS STRING) AS asset_id, CAST(ActualFinish AS TIMESTAMP) AS actual_finish FROM `ext_mssql_asset_vision_ven_gen7`.dbo.capitalwork WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_ven_rms', CAST(ID AS STRING), CAST(AssetID AS STRING), CAST(ActualFinish AS TIMESTAMP) FROM `ext_mssql_asset_vision_ven_rms`.dbo.capitalwork WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_ven_rms_new', CAST(ID AS STRING), CAST(AssetID AS STRING), CAST(ActualFinish AS TIMESTAMP) FROM `ext_mssql_asset_vision_ven_rms_new`.dbo.capitalwork WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_ven_vicroads', CAST(ID AS STRING), CAST(AssetID AS STRING), CAST(ActualFinish AS TIMESTAMP) FROM `ext_mssql_asset_vision_ven_vicroads`.dbo.capitalwork WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_vns_gen7', CAST(ID AS STRING), CAST(AssetID AS STRING), CAST(ActualFinish AS TIMESTAMP) FROM `ext_mssql_asset_vision_vns_gen7`.dbo.capitalwork WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_vnz_gen7', CAST(ID AS STRING), CAST(AssetID AS STRING), CAST(ActualFinish AS TIMESTAMP) FROM `ext_mssql_asset_vision_vnz_gen7`.dbo.capitalwork WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_vsm_gen7', CAST(ID AS STRING), CAST(AssetID AS STRING), CAST(ActualFinish AS TIMESTAMP) FROM `ext_mssql_asset_vision_vsm_gen7`.dbo.capitalwork WHERE COALESCE(Deleted, false) = false
),
photo_base AS (
  SELECT 'asset_vision_ven_gen7' AS source_context, CAST(ID AS STRING) AS photo_id, lower(TRIM(CAST(SourceTable AS STRING))) AS source_table, CAST(SourceTableID AS STRING) AS source_table_id FROM `ext_mssql_asset_vision_ven_gen7`.dbo.photo WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_ven_rms', CAST(ID AS STRING), lower(TRIM(CAST(SourceTable AS STRING))), CAST(SourceTableID AS STRING) FROM `ext_mssql_asset_vision_ven_rms`.dbo.photo WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_ven_rms_new', CAST(ID AS STRING), lower(TRIM(CAST(SourceTable AS STRING))), CAST(SourceTableID AS STRING) FROM `ext_mssql_asset_vision_ven_rms_new`.dbo.photo WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_ven_vicroads', CAST(ID AS STRING), lower(TRIM(CAST(SourceTable AS STRING))), CAST(SourceTableID AS STRING) FROM `ext_mssql_asset_vision_ven_vicroads`.dbo.photo WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_vns_gen7', CAST(ID AS STRING), lower(TRIM(CAST(SourceTable AS STRING))), CAST(SourceTableID AS STRING) FROM `ext_mssql_asset_vision_vns_gen7`.dbo.photo WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_vnz_gen7', CAST(ID AS STRING), lower(TRIM(CAST(SourceTable AS STRING))), CAST(SourceTableID AS STRING) FROM `ext_mssql_asset_vision_vnz_gen7`.dbo.photo WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_vsm_gen7', CAST(ID AS STRING), lower(TRIM(CAST(SourceTable AS STRING))), CAST(SourceTableID AS STRING) FROM `ext_mssql_asset_vision_vsm_gen7`.dbo.photo WHERE COALESCE(Deleted, false) = false
),
asset_rollup AS (
  SELECT
    source_context, source_catalog, source_label, contract, raw_asset_type,
    COUNT(DISTINCT asset_id) AS asset_count,
    SUM(CASE WHEN classification IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_classification,
    COUNT(DISTINCT classification) AS distinct_classifications,
    concat_ws('; ', sort_array(collect_set(classification))) AS classification_examples,
    concat_ws('; ', sort_array(collect_set(spatial_type))) AS spatial_type_examples,
    SUM(CASE WHEN asset_condition IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_condition,
    SUM(CASE WHEN asset_criticality IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_criticality,
    SUM(CASE WHEN asset_risk IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_risk,
    SUM(CASE WHEN chainage_from IS NOT NULL OR chainage_to IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_chainage,
    SUM(CASE WHEN chainage_from IS NOT NULL AND chainage_to IS NOT NULL AND chainage_to > chainage_from THEN chainage_to - chainage_from ELSE 0 END) / 1000.0 AS chainage_length_km_proxy,
    SUM(CASE WHEN parent_asset_id IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_parent_asset,
    SUM(CASE WHEN stage IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_stage,
    SUM(CASE WHEN construction_date IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_construction_date,
    SUM(CASE WHEN construction_cost IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_construction_cost,
    SUM(CASE WHEN useful_life IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_useful_life,
    SUM(CASE WHEN condition_date IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_condition_date
  FROM asset_base
  GROUP BY source_context, source_catalog, source_label, contract, raw_asset_type
),
location_rollup AS (
  SELECT
    a.source_context, a.contract, a.raw_asset_type,
    SUM(CASE WHEN COALESCE(l.location_rows, 0) > 0 THEN 1 ELSE 0 END) AS assets_with_location_row,
    SUM(CASE WHEN COALESCE(l.has_wkt, 0) > 0 THEN 1 ELSE 0 END) AS assets_with_wkt,
    SUM(CASE WHEN COALESCE(l.has_valid_au_coord, 0) > 0 THEN 1 ELSE 0 END) AS assets_with_valid_au_coord,
    SUM(COALESCE(l.location_rows, 0)) AS location_rows,
    concat_ws('; ', sort_array(collect_set(NULLIF(l.wkt_geometry_types, '')))) AS wkt_geometry_types
  FROM asset_base a
  LEFT JOIN loc_by_asset l ON l.source_context = a.source_context AND l.asset_id = a.asset_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
attribute_rollup AS (
  SELECT
    a.source_context, a.contract, a.raw_asset_type,
    COUNT(aa.attribute_name) AS attribute_rows,
    COUNT(DISTINCT aa.attribute_name) AS distinct_attribute_names,
    COUNT(DISTINCT CASE WHEN aa.attribute_name IS NOT NULL THEN a.asset_id END) AS assets_with_attributes,
    concat_ws('; ', sort_array(collect_set(aa.attribute_name))) AS attribute_name_examples
  FROM asset_base a
  LEFT JOIN assetattribute aa ON aa.source_context = a.source_context AND aa.asset_id = a.asset_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
job_asset_slice AS (
  SELECT DISTINCT
    a.source_context, a.contract, a.raw_asset_type, a.asset_id, jl.job_id
  FROM asset_base a
  LEFT JOIN job_link jl ON jl.source_context = a.source_context AND jl.asset_id = a.asset_id
  WHERE jl.job_id IS NOT NULL
),
job_detail_slice AS (
  SELECT DISTINCT
    a.source_context, a.contract, a.raw_asset_type,
    jl.job_id, jl.due_date, jl.completed_date,
    jl.hazard_defect_code, jl.activity_category_name, jl.activity_name, jl.intervention_code,
    jl.estimated_quantity, jl.priority, jl.activity_type, jl.compliant,
    jl.remaining_quantity, jl.actual_quantity, jl.inspection_type_name,
    jl.estimated_length, jl.estimated_width, jl.estimated_depth
  FROM asset_base a
  LEFT JOIN job_link jl ON jl.source_context = a.source_context AND jl.asset_id = a.asset_id
  WHERE jl.job_id IS NOT NULL
),
job_asset_rollup AS (
  SELECT
    source_context, contract, raw_asset_type,
    COUNT(DISTINCT asset_id) AS assets_with_job
  FROM job_asset_slice
  GROUP BY source_context, contract, raw_asset_type
),
job_detail_rollup AS (
  SELECT
    source_context, contract, raw_asset_type,
    COUNT(DISTINCT job_id) AS job_count,
    COUNT(DISTINCT CASE WHEN completed_date IS NOT NULL THEN job_id END) AS completed_job_count,
    COUNT(DISTINCT CASE WHEN completed_date IS NULL AND due_date < current_timestamp() THEN job_id END) AS overdue_open_job_count,
    concat_ws('; ', sort_array(collect_set(hazard_defect_code))) AS job_hazard_defect_codes,
    concat_ws('; ', sort_array(collect_set(activity_category_name))) AS job_activity_category_names,
    concat_ws('; ', sort_array(collect_set(activity_name))) AS job_activity_names,
    concat_ws('; ', sort_array(collect_set(intervention_code))) AS job_intervention_codes,
    concat_ws('; ', sort_array(collect_set(priority))) AS job_priorities,
    concat_ws('; ', sort_array(collect_set(activity_type))) AS job_activity_types,
    concat_ws('; ', sort_array(collect_set(compliant))) AS job_compliance_values,
    concat_ws('; ', sort_array(collect_set(inspection_type_name))) AS job_inspection_type_names,
    COUNT(DISTINCT CASE WHEN estimated_quantity IS NOT NULL THEN job_id END) AS jobs_with_estimated_quantity,
    ROUND(SUM(estimated_quantity), 3) AS job_estimated_quantity_total,
    COUNT(DISTINCT CASE WHEN actual_quantity IS NOT NULL THEN job_id END) AS jobs_with_actual_quantity,
    ROUND(SUM(actual_quantity), 3) AS job_actual_quantity_total,
    COUNT(DISTINCT CASE WHEN remaining_quantity IS NOT NULL THEN job_id END) AS jobs_with_remaining_quantity,
    ROUND(SUM(remaining_quantity), 3) AS job_remaining_quantity_total,
    COUNT(DISTINCT CASE WHEN estimated_length IS NOT NULL THEN job_id END) AS jobs_with_estimated_length,
    ROUND(SUM(estimated_length), 3) AS job_estimated_length_total,
    COUNT(DISTINCT CASE WHEN estimated_width IS NOT NULL THEN job_id END) AS jobs_with_estimated_width,
    ROUND(AVG(estimated_width), 3) AS job_estimated_width_avg,
    COUNT(DISTINCT CASE WHEN estimated_depth IS NOT NULL THEN job_id END) AS jobs_with_estimated_depth,
    ROUND(AVG(estimated_depth), 3) AS job_estimated_depth_avg
  FROM job_detail_slice
  GROUP BY source_context, contract, raw_asset_type
),
job_rollup AS (
  SELECT
    b.source_context, b.contract, b.raw_asset_type,
    COALESCE(jd.job_count, 0) AS job_count,
    COALESCE(ja.assets_with_job, 0) AS assets_with_job,
    COALESCE(jd.completed_job_count, 0) AS completed_job_count,
    COALESCE(jd.overdue_open_job_count, 0) AS overdue_open_job_count,
    jd.job_hazard_defect_codes,
    jd.job_activity_category_names,
    jd.job_activity_names,
    jd.job_intervention_codes,
    jd.job_priorities,
    jd.job_activity_types,
    jd.job_compliance_values,
    jd.job_inspection_type_names,
    COALESCE(jd.jobs_with_estimated_quantity, 0) AS jobs_with_estimated_quantity,
    COALESCE(jd.job_estimated_quantity_total, 0.0) AS job_estimated_quantity_total,
    COALESCE(jd.jobs_with_actual_quantity, 0) AS jobs_with_actual_quantity,
    COALESCE(jd.job_actual_quantity_total, 0.0) AS job_actual_quantity_total,
    COALESCE(jd.jobs_with_remaining_quantity, 0) AS jobs_with_remaining_quantity,
    COALESCE(jd.job_remaining_quantity_total, 0.0) AS job_remaining_quantity_total,
    COALESCE(jd.jobs_with_estimated_length, 0) AS jobs_with_estimated_length,
    COALESCE(jd.job_estimated_length_total, 0.0) AS job_estimated_length_total,
    COALESCE(jd.jobs_with_estimated_width, 0) AS jobs_with_estimated_width,
    jd.job_estimated_width_avg,
    COALESCE(jd.jobs_with_estimated_depth, 0) AS jobs_with_estimated_depth,
    jd.job_estimated_depth_avg
  FROM (SELECT DISTINCT source_context, contract, raw_asset_type FROM asset_base) b
  LEFT JOIN job_detail_rollup jd USING (source_context, contract, raw_asset_type)
  LEFT JOIN job_asset_rollup ja USING (source_context, contract, raw_asset_type)
),
inspection_rollup AS (
  SELECT
    a.source_context, a.contract, a.raw_asset_type,
    COUNT(DISTINCT i.inspection_id) AS inspection_count,
    COUNT(DISTINCT CASE WHEN i.inspection_id IS NOT NULL THEN a.asset_id END) AS assets_with_inspection,
    COUNT(DISTINCT CASE WHEN i.completed_date IS NOT NULL THEN i.inspection_id END) AS completed_inspection_count,
    COUNT(DISTINCT CASE WHEN i.completed_date IS NULL AND i.due_date < current_timestamp() THEN i.inspection_id END) AS overdue_open_inspection_count
  FROM asset_base a
  LEFT JOIN inspection_base i ON i.source_context = a.source_context AND i.asset_id = a.asset_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
capitalwork_rollup AS (
  SELECT
    a.source_context, a.contract, a.raw_asset_type,
    COUNT(DISTINCT c.capitalwork_id) AS capitalwork_count,
    COUNT(DISTINCT CASE WHEN c.capitalwork_id IS NOT NULL THEN a.asset_id END) AS assets_with_capitalwork,
    COUNT(DISTINCT CASE WHEN c.actual_finish IS NOT NULL THEN c.capitalwork_id END) AS completed_capitalwork_count
  FROM asset_base a
  LEFT JOIN capitalwork_base c ON c.source_context = a.source_context AND c.asset_id = a.asset_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
asset_photo_rollup AS (
  SELECT
    a.source_context, a.contract, a.raw_asset_type,
    COUNT(DISTINCT p.photo_id) AS asset_photo_count,
    COUNT(DISTINCT CASE WHEN p.photo_id IS NOT NULL THEN a.asset_id END) AS assets_with_asset_photo
  FROM asset_base a
  LEFT JOIN photo_base p ON p.source_context = a.source_context AND p.source_table = 'asset' AND p.source_table_id = a.asset_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
job_photo_rollup AS (
  SELECT
    a.source_context, a.contract, a.raw_asset_type,
    COUNT(DISTINCT p.photo_id) AS job_photo_count,
    COUNT(DISTINCT CASE WHEN p.photo_id IS NOT NULL THEN a.asset_id END) AS assets_with_job_photo
  FROM asset_base a
  LEFT JOIN job_link jl ON jl.source_context = a.source_context AND jl.asset_id = a.asset_id
  LEFT JOIN photo_base p ON p.source_context = a.source_context AND p.source_table = 'job' AND p.source_table_id = jl.job_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
source_aggregate AS (
  SELECT
    ar.*,
    lr.assets_with_location_row, lr.assets_with_wkt, lr.assets_with_valid_au_coord, lr.location_rows, lr.wkt_geometry_types,
    atr.attribute_rows, atr.distinct_attribute_names, atr.assets_with_attributes, atr.attribute_name_examples,
    jr.job_count, jr.assets_with_job, jr.completed_job_count, jr.overdue_open_job_count,
    jr.job_hazard_defect_codes, jr.job_activity_category_names, jr.job_activity_names,
    jr.job_intervention_codes, jr.job_priorities, jr.job_activity_types,
    jr.job_compliance_values, jr.job_inspection_type_names,
    jr.jobs_with_estimated_quantity, jr.job_estimated_quantity_total,
    jr.jobs_with_actual_quantity, jr.job_actual_quantity_total,
    jr.jobs_with_remaining_quantity, jr.job_remaining_quantity_total,
    jr.jobs_with_estimated_length, jr.job_estimated_length_total,
    jr.jobs_with_estimated_width, jr.job_estimated_width_avg,
    jr.jobs_with_estimated_depth, jr.job_estimated_depth_avg,
    ir.inspection_count, ir.assets_with_inspection, ir.completed_inspection_count, ir.overdue_open_inspection_count,
    cr.capitalwork_count, cr.assets_with_capitalwork, cr.completed_capitalwork_count,
    apr.asset_photo_count, apr.assets_with_asset_photo,
    jpr.job_photo_count, jpr.assets_with_job_photo
  FROM asset_rollup ar
  LEFT JOIN location_rollup lr USING (source_context, contract, raw_asset_type)
  LEFT JOIN attribute_rollup atr USING (source_context, contract, raw_asset_type)
  LEFT JOIN job_rollup jr USING (source_context, contract, raw_asset_type)
  LEFT JOIN inspection_rollup ir USING (source_context, contract, raw_asset_type)
  LEFT JOIN capitalwork_rollup cr USING (source_context, contract, raw_asset_type)
  LEFT JOIN asset_photo_rollup apr USING (source_context, contract, raw_asset_type)
  LEFT JOIN job_photo_rollup jpr USING (source_context, contract, raw_asset_type)
),
mapped AS (
  SELECT
    s.*,
    COALESCE(m.standardised_asset_type_name, s.raw_asset_type) AS standardised_asset_type_name,
    COALESCE(m.asset_category, 'Other / Unclassified') AS asset_category,
    COALESCE(m.asset_subcategory, 'Other / Unclassified') AS asset_subcategory,
    COALESCE(m.mapping_method, 'auto_source_asset_type_other_v1') AS mapping_method,
    COALESCE(m.manual_review_notes, CASE WHEN m.asset_type IS NULL THEN 'Fallback row for live source AssetType not yet manually classified.' ELSE '' END) AS manual_review_notes
  FROM source_aggregate s
  LEFT JOIN transport_dev.integ_transport_assets.asset_vision_asset_type_category_map m
    ON lower(trim(m.asset_type)) = lower(trim(s.raw_asset_type))
)
SELECT
  CAST(current_timestamp() AS STRING) AS run_generated_at_utc,
  source_context,
  source_catalog,
  source_label,
  contract,
  raw_asset_type,
  standardised_asset_type_name,
  asset_category,
  asset_subcategory,
  mapping_method,
  manual_review_notes,
  'asset; assetattribute; capitalwork; inspection; job; jobasset; photo; vassetlocation' AS available_tables,
  asset_count,
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
  ROUND(chainage_length_km_proxy, 3) AS chainage_length_km_proxy,
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
  COALESCE(assets_with_location_row, 0) AS assets_with_location_row,
  ROUND(100.0 * COALESCE(assets_with_location_row, 0) / NULLIF(asset_count, 0), 1) AS location_row_coverage_pct,
  COALESCE(assets_with_wkt, 0) AS assets_with_wkt,
  ROUND(100.0 * COALESCE(assets_with_wkt, 0) / NULLIF(asset_count, 0), 1) AS wkt_coverage_pct,
  COALESCE(assets_with_valid_au_coord, 0) AS assets_with_valid_au_coord,
  ROUND(100.0 * COALESCE(assets_with_valid_au_coord, 0) / NULLIF(asset_count, 0), 1) AS valid_au_coord_coverage_pct,
  COALESCE(location_rows, 0) AS location_rows,
  wkt_geometry_types,
  COALESCE(attribute_rows, 0) AS attribute_rows,
  COALESCE(distinct_attribute_names, 0) AS distinct_attribute_names,
  COALESCE(assets_with_attributes, 0) AS assets_with_attributes,
  ROUND(100.0 * COALESCE(assets_with_attributes, 0) / NULLIF(asset_count, 0), 1) AS custom_attribute_coverage_pct,
  attribute_name_examples,
  COALESCE(job_count, 0) AS job_count,
  COALESCE(assets_with_job, 0) AS assets_with_job,
  ROUND(100.0 * COALESCE(assets_with_job, 0) / NULLIF(asset_count, 0), 1) AS job_coverage_pct,
  ROUND(COALESCE(job_count, 0) / NULLIF(asset_count, 0), 3) AS jobs_per_asset,
  COALESCE(completed_job_count, 0) AS completed_job_count,
  COALESCE(overdue_open_job_count, 0) AS overdue_open_job_count,
  job_hazard_defect_codes,
  job_activity_category_names,
  job_activity_names,
  job_intervention_codes,
  job_priorities,
  job_activity_types,
  job_compliance_values,
  job_inspection_type_names,
  COALESCE(jobs_with_estimated_quantity, 0) AS jobs_with_estimated_quantity,
  COALESCE(job_estimated_quantity_total, 0.0) AS job_estimated_quantity_total,
  COALESCE(jobs_with_actual_quantity, 0) AS jobs_with_actual_quantity,
  COALESCE(job_actual_quantity_total, 0.0) AS job_actual_quantity_total,
  COALESCE(jobs_with_remaining_quantity, 0) AS jobs_with_remaining_quantity,
  COALESCE(job_remaining_quantity_total, 0.0) AS job_remaining_quantity_total,
  COALESCE(jobs_with_estimated_length, 0) AS jobs_with_estimated_length,
  COALESCE(job_estimated_length_total, 0.0) AS job_estimated_length_total,
  COALESCE(jobs_with_estimated_width, 0) AS jobs_with_estimated_width,
  job_estimated_width_avg,
  COALESCE(jobs_with_estimated_depth, 0) AS jobs_with_estimated_depth,
  job_estimated_depth_avg,
  COALESCE(inspection_count, 0) AS inspection_count,
  COALESCE(assets_with_inspection, 0) AS assets_with_inspection,
  ROUND(100.0 * COALESCE(assets_with_inspection, 0) / NULLIF(asset_count, 0), 1) AS inspection_coverage_pct,
  ROUND(COALESCE(inspection_count, 0) / NULLIF(asset_count, 0), 3) AS inspections_per_asset,
  COALESCE(completed_inspection_count, 0) AS completed_inspection_count,
  COALESCE(overdue_open_inspection_count, 0) AS overdue_open_inspection_count,
  COALESCE(capitalwork_count, 0) AS capitalwork_count,
  COALESCE(assets_with_capitalwork, 0) AS assets_with_capitalwork,
  ROUND(100.0 * COALESCE(assets_with_capitalwork, 0) / NULLIF(asset_count, 0), 1) AS capitalwork_coverage_pct,
  COALESCE(completed_capitalwork_count, 0) AS completed_capitalwork_count,
  COALESCE(asset_photo_count, 0) AS asset_photo_count,
  COALESCE(assets_with_asset_photo, 0) AS assets_with_asset_photo,
  ROUND(100.0 * COALESCE(assets_with_asset_photo, 0) / NULLIF(asset_count, 0), 1) AS asset_photo_coverage_pct,
  COALESCE(job_photo_count, 0) AS job_photo_count,
  COALESCE(assets_with_job_photo, 0) AS assets_with_job_photo,
  ROUND(100.0 * COALESCE(assets_with_job_photo, 0) / NULLIF(asset_count, 0), 1) AS job_photo_asset_coverage_pct,
  COALESCE(asset_photo_count, 0) + COALESCE(job_photo_count, 0) AS total_photo_count
FROM mapped;

SELECT COUNT(*) AS detail_row_count
FROM transport_dev.integ_transport_assets.atm_asset_type_metrics_detail;
