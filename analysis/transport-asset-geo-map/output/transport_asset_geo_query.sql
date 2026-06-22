WITH unified_assets AS (

            SELECT
              'asset_vision_ven_gen7' AS source_context,
              'RAMC / BAC / PoB / TSRC group' AS source_label,
              COALESCE(NULLIF(TRIM(CAST(a.Contract AS STRING)), ''), 'asset_vision_ven_gen7') AS project,
              COALESCE(NULLIF(TRIM(CAST(a.AssetType AS STRING)), ''), 'Unspecified asset type') AS asset_type,
              COALESCE(NULLIF(TRIM(CAST(a.Classification AS STRING)), ''), 'Unclassified') AS classification,
              LOWER(COALESCE(NULLIF(TRIM(CAST(a.SpatialType AS STRING)), ''), 'unknown')) AS spatial_type,
              CAST(a.ID AS STRING) AS asset_id,
              CAST(regexp_extract(loc.WKT, '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)', 1) AS DOUBLE) AS lon,
              CAST(regexp_extract(loc.WKT, '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)', 2) AS DOUBLE) AS lat
            FROM ext_mssql_asset_vision_ven_gen7.dbo.asset a
            LEFT JOIN ext_mssql_asset_vision_ven_gen7.dbo.vassetlocation loc
              ON loc.AssetID = a.ID
             AND COALESCE(loc.Deleted, false) = false
            WHERE COALESCE(a.Deleted, false) = false
            
UNION ALL

            SELECT
              'asset_vision_ven_rms' AS source_context,
              'RMS' AS source_label,
              COALESCE(NULLIF(TRIM(CAST(a.Contract AS STRING)), ''), 'asset_vision_ven_rms') AS project,
              COALESCE(NULLIF(TRIM(CAST(a.AssetType AS STRING)), ''), 'Unspecified asset type') AS asset_type,
              COALESCE(NULLIF(TRIM(CAST(a.Classification AS STRING)), ''), 'Unclassified') AS classification,
              LOWER(COALESCE(NULLIF(TRIM(CAST(a.SpatialType AS STRING)), ''), 'unknown')) AS spatial_type,
              CAST(a.ID AS STRING) AS asset_id,
              CAST(regexp_extract(loc.WKT, '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)', 1) AS DOUBLE) AS lon,
              CAST(regexp_extract(loc.WKT, '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)', 2) AS DOUBLE) AS lat
            FROM ext_mssql_asset_vision_ven_rms.dbo.asset a
            LEFT JOIN ext_mssql_asset_vision_ven_rms.dbo.vassetlocation loc
              ON loc.AssetID = a.ID
             AND COALESCE(loc.Deleted, false) = false
            WHERE COALESCE(a.Deleted, false) = false
            
UNION ALL

            SELECT
              'asset_vision_ven_rms_new' AS source_context,
              'RMS new' AS source_label,
              COALESCE(NULLIF(TRIM(CAST(a.Contract AS STRING)), ''), 'asset_vision_ven_rms_new') AS project,
              COALESCE(NULLIF(TRIM(CAST(a.AssetType AS STRING)), ''), 'Unspecified asset type') AS asset_type,
              COALESCE(NULLIF(TRIM(CAST(a.Classification AS STRING)), ''), 'Unclassified') AS classification,
              LOWER(COALESCE(NULLIF(TRIM(CAST(a.SpatialType AS STRING)), ''), 'unknown')) AS spatial_type,
              CAST(a.ID AS STRING) AS asset_id,
              CAST(regexp_extract(loc.WKT, '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)', 1) AS DOUBLE) AS lon,
              CAST(regexp_extract(loc.WKT, '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)', 2) AS DOUBLE) AS lat
            FROM ext_mssql_asset_vision_ven_rms_new.dbo.asset a
            LEFT JOIN ext_mssql_asset_vision_ven_rms_new.dbo.vassetlocation loc
              ON loc.AssetID = a.ID
             AND COALESCE(loc.Deleted, false) = false
            WHERE COALESCE(a.Deleted, false) = false
            
UNION ALL

            SELECT
              'asset_vision_ven_vicroads' AS source_context,
              'VicRoads' AS source_label,
              COALESCE(NULLIF(TRIM(CAST(a.Contract AS STRING)), ''), 'asset_vision_ven_vicroads') AS project,
              COALESCE(NULLIF(TRIM(CAST(a.AssetType AS STRING)), ''), 'Unspecified asset type') AS asset_type,
              COALESCE(NULLIF(TRIM(CAST(a.Classification AS STRING)), ''), 'Unclassified') AS classification,
              LOWER(COALESCE(NULLIF(TRIM(CAST(a.SpatialType AS STRING)), ''), 'unknown')) AS spatial_type,
              CAST(a.ID AS STRING) AS asset_id,
              CAST(regexp_extract(loc.WKT, '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)', 1) AS DOUBLE) AS lon,
              CAST(regexp_extract(loc.WKT, '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)', 2) AS DOUBLE) AS lat
            FROM ext_mssql_asset_vision_ven_vicroads.dbo.asset a
            LEFT JOIN ext_mssql_asset_vision_ven_vicroads.dbo.vassetlocation loc
              ON loc.AssetID = a.ID
             AND COALESCE(loc.Deleted, false) = false
            WHERE COALESCE(a.Deleted, false) = false
            
UNION ALL

            SELECT
              'asset_vision_vns_gen7' AS source_context,
              'VNS' AS source_label,
              COALESCE(NULLIF(TRIM(CAST(a.Contract AS STRING)), ''), 'asset_vision_vns_gen7') AS project,
              COALESCE(NULLIF(TRIM(CAST(a.AssetType AS STRING)), ''), 'Unspecified asset type') AS asset_type,
              COALESCE(NULLIF(TRIM(CAST(a.Classification AS STRING)), ''), 'Unclassified') AS classification,
              LOWER(COALESCE(NULLIF(TRIM(CAST(a.SpatialType AS STRING)), ''), 'unknown')) AS spatial_type,
              CAST(a.ID AS STRING) AS asset_id,
              CAST(regexp_extract(loc.WKT, '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)', 1) AS DOUBLE) AS lon,
              CAST(regexp_extract(loc.WKT, '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)', 2) AS DOUBLE) AS lat
            FROM ext_mssql_asset_vision_vns_gen7.dbo.asset a
            LEFT JOIN ext_mssql_asset_vision_vns_gen7.dbo.vassetlocation loc
              ON loc.AssetID = a.ID
             AND COALESCE(loc.Deleted, false) = false
            WHERE COALESCE(a.Deleted, false) = false
            
UNION ALL

            SELECT
              'asset_vision_vnz_gen7' AS source_context,
              'VNZ' AS source_label,
              COALESCE(NULLIF(TRIM(CAST(a.Contract AS STRING)), ''), 'asset_vision_vnz_gen7') AS project,
              COALESCE(NULLIF(TRIM(CAST(a.AssetType AS STRING)), ''), 'Unspecified asset type') AS asset_type,
              COALESCE(NULLIF(TRIM(CAST(a.Classification AS STRING)), ''), 'Unclassified') AS classification,
              LOWER(COALESCE(NULLIF(TRIM(CAST(a.SpatialType AS STRING)), ''), 'unknown')) AS spatial_type,
              CAST(a.ID AS STRING) AS asset_id,
              CAST(regexp_extract(loc.WKT, '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)', 1) AS DOUBLE) AS lon,
              CAST(regexp_extract(loc.WKT, '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)', 2) AS DOUBLE) AS lat
            FROM ext_mssql_asset_vision_vnz_gen7.dbo.asset a
            LEFT JOIN ext_mssql_asset_vision_vnz_gen7.dbo.vassetlocation loc
              ON loc.AssetID = a.ID
             AND COALESCE(loc.Deleted, false) = false
            WHERE COALESCE(a.Deleted, false) = false
            
UNION ALL

            SELECT
              'asset_vision_vsm_gen7' AS source_context,
              'VentureSmart' AS source_label,
              COALESCE(NULLIF(TRIM(CAST(a.Contract AS STRING)), ''), 'asset_vision_vsm_gen7') AS project,
              COALESCE(NULLIF(TRIM(CAST(a.AssetType AS STRING)), ''), 'Unspecified asset type') AS asset_type,
              COALESCE(NULLIF(TRIM(CAST(a.Classification AS STRING)), ''), 'Unclassified') AS classification,
              LOWER(COALESCE(NULLIF(TRIM(CAST(a.SpatialType AS STRING)), ''), 'unknown')) AS spatial_type,
              CAST(a.ID AS STRING) AS asset_id,
              CAST(regexp_extract(loc.WKT, '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)', 1) AS DOUBLE) AS lon,
              CAST(regexp_extract(loc.WKT, '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)', 2) AS DOUBLE) AS lat
            FROM ext_mssql_asset_vision_vsm_gen7.dbo.asset a
            LEFT JOIN ext_mssql_asset_vision_vsm_gen7.dbo.vassetlocation loc
              ON loc.AssetID = a.ID
             AND COALESCE(loc.Deleted, false) = false
            WHERE COALESCE(a.Deleted, false) = false
            
),
valid_geo AS (
  SELECT
    source_context,
    source_label,
    project,
    asset_type,
    classification,
    spatial_type,
    asset_id,
    lon,
    lat
  FROM unified_assets
  WHERE lon BETWEEN 112 AND 180
    AND lat BETWEEN -48 AND -9
),
grid_agg AS (
  SELECT
    source_context,
    source_label,
    project,
    asset_type,
    ROUND(lat / 0.05) * 0.05 AS lat_grid,
    ROUND(lon / 0.05) * 0.05 AS lon_grid,
    COUNT(DISTINCT asset_id) AS asset_count,
    COUNT(*) AS location_rows,
    COUNT(DISTINCT classification) AS classification_count,
    MIN(classification) AS example_classification,
    SUM(CASE WHEN spatial_type = 'point' THEN 1 ELSE 0 END) AS point_assets,
    SUM(CASE WHEN spatial_type = 'line' THEN 1 ELSE 0 END) AS line_assets,
    SUM(CASE WHEN spatial_type = 'polygon' THEN 1 ELSE 0 END) AS polygon_assets
  FROM valid_geo
  GROUP BY source_context, source_label, project, asset_type, ROUND(lat / 0.05) * 0.05, ROUND(lon / 0.05) * 0.05
),
class_agg AS (
  SELECT
    source_context,
    source_label,
    project,
    asset_type,
    COUNT(DISTINCT asset_id) AS asset_count,
    COUNT(*) AS location_rows,
    COUNT(DISTINCT classification) AS classification_count,
    SUM(CASE WHEN lon IS NOT NULL AND lat IS NOT NULL THEN 1 ELSE 0 END) AS geocoded_rows
  FROM unified_assets
  GROUP BY source_context, source_label, project, asset_type
),
summary AS (
  SELECT
    source_context,
    source_label,
    COUNT(DISTINCT asset_id) AS source_assets,
    SUM(CASE WHEN lon BETWEEN 112 AND 180 AND lat BETWEEN -48 AND -9 THEN 1 ELSE 0 END) AS valid_geo_rows,
    COUNT(*) AS source_rows
  FROM unified_assets
  GROUP BY source_context, source_label
)
SELECT 'grid' AS result_set, to_json(named_struct(
  'source_context', source_context,
  'source_label', source_label,
  'project', project,
  'asset_type', asset_type,
  'lat', lat_grid,
  'lon', lon_grid,
  'asset_count', asset_count,
  'location_rows', location_rows,
  'classification_count', classification_count,
  'example_classification', example_classification,
  'point_assets', point_assets,
  'line_assets', line_assets,
  'polygon_assets', polygon_assets
)) AS payload
FROM grid_agg
UNION ALL
SELECT 'class' AS result_set, to_json(named_struct(
  'source_context', source_context,
  'source_label', source_label,
  'project', project,
  'asset_type', asset_type,
  'asset_count', asset_count,
  'location_rows', location_rows,
  'classification_count', classification_count,
  'geocoded_rows', geocoded_rows
)) AS payload
FROM class_agg
UNION ALL
SELECT 'summary' AS result_set, to_json(named_struct(
  'source_context', source_context,
  'source_label', source_label,
  'source_assets', source_assets,
  'valid_geo_rows', valid_geo_rows,
  'source_rows', source_rows
)) AS payload
FROM summary