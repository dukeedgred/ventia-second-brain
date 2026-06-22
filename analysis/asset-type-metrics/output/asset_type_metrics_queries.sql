

-- asset_vision_ven_gen7

WITH asset_base AS (
  SELECT
    'asset_vision_ven_gen7' AS source_context,
    CAST(ID AS STRING) AS asset_id,
    COALESCE(NULLIF(TRIM(CAST(Contract AS STRING)), ''), 'asset_vision_ven_gen7') AS contract,
    COALESCE(NULLIF(TRIM(CAST(AssetType AS STRING)), ''), 'Unspecified asset type') AS raw_asset_type,
    NULLIF(TRIM(CAST(Classification AS STRING)), '') AS classification,
    NULLIF(TRIM(CAST(SpatialType AS STRING)), '') AS spatial_type,
    NULLIF(TRIM(CAST(AssetCondition AS STRING)), '') AS asset_condition,
    NULLIF(TRIM(CAST(AssetCriticality AS STRING)), '') AS asset_criticality,
    NULLIF(TRIM(CAST(AssetRisk AS STRING)), '') AS asset_risk,
    CAST(ChainageFrom AS DOUBLE) AS chainage_from,
    CAST(ChainageTo AS DOUBLE) AS chainage_to,
    CAST(ParentAssetID AS STRING) AS parent_asset_id,
    NULLIF(TRIM(CAST(Stage AS STRING)), '') AS stage,
    CAST(ConstructionDate AS TIMESTAMP) AS construction_date,
    CAST(ConstructionCost AS DOUBLE) AS construction_cost,
    CAST(UsefulLife AS DOUBLE) AS useful_life,
    CAST(ConditionDate AS TIMESTAMP) AS condition_date
  FROM `ext_mssql_asset_vision_ven_gen7`.dbo.asset
  WHERE COALESCE(Deleted, false) = false
),
loc_by_asset AS (
  
SELECT
  CAST(AssetID AS STRING) AS asset_id,
  COUNT(*) AS location_rows,
  MAX(CASE WHEN WKT IS NOT NULL AND TRIM(CAST(WKT AS STRING)) <> '' THEN 1 ELSE 0 END) AS has_wkt,
  MAX(CASE
    WHEN CAST(regexp_extract(WKT, '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)', 1) AS DOUBLE) BETWEEN 112 AND 180
     AND CAST(regexp_extract(WKT, '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)', 2) AS DOUBLE) BETWEEN -48 AND -9
    THEN 1 ELSE 0 END) AS has_valid_au_coord,
  concat_ws('; ', sort_array(collect_set(NULLIF(upper(regexp_extract(TRIM(CAST(WKT AS STRING)), '^([A-Za-z]+)', 1)), '')))) AS wkt_geometry_types
FROM `ext_mssql_asset_vision_ven_gen7`.dbo.vassetlocation
WHERE COALESCE(Deleted, false) = false
GROUP BY CAST(AssetID AS STRING)

),
assetattribute AS (
  
SELECT
  CAST(AssetID AS STRING) AS asset_id,
  NULLIF(TRIM(CAST(Name AS STRING)), '') AS attribute_name,
  NULLIF(TRIM(CAST(Value AS STRING)), '') AS attribute_value
FROM `ext_mssql_asset_vision_ven_gen7`.dbo.assetattribute
WHERE COALESCE(Deleted, false) = false

),
job_base AS (
  
SELECT
  CAST(ID AS STRING) AS job_id,
  CAST(AssetID AS STRING) AS asset_id,
  CAST(DueDate AS TIMESTAMP) AS due_date,
  CAST(CompletedDate AS TIMESTAMP) AS completed_date
FROM `ext_mssql_asset_vision_ven_gen7`.dbo.job
WHERE COALESCE(Deleted, false) = false

),
jobasset_base AS (
  
SELECT
  CAST(JobID AS STRING) AS job_id,
  CAST(AssetID AS STRING) AS asset_id
FROM `ext_mssql_asset_vision_ven_gen7`.dbo.jobasset
WHERE COALESCE(Deleted, false) = false

),
job_link AS (
  SELECT job_id, asset_id, due_date, completed_date
  FROM job_base
  WHERE asset_id IS NOT NULL
  UNION
  SELECT ja.job_id, ja.asset_id, j.due_date, j.completed_date
  FROM jobasset_base ja
  LEFT JOIN job_base j
    ON j.job_id = ja.job_id
  WHERE ja.asset_id IS NOT NULL
),
inspection_base AS (
  
SELECT
  CAST(ID AS STRING) AS inspection_id,
  CAST(AssetID AS STRING) AS asset_id,
  CAST(COALESCE(ScheduledDateTo, ScheduledDate) AS TIMESTAMP) AS due_date,
  CAST(CompletedDate AS TIMESTAMP) AS completed_date
FROM `ext_mssql_asset_vision_ven_gen7`.dbo.inspection
WHERE COALESCE(Deleted, false) = false

),
capitalwork_base AS (
  
SELECT
  CAST(ID AS STRING) AS capitalwork_id,
  CAST(AssetID AS STRING) AS asset_id,
  CAST(PlannedStart AS TIMESTAMP) AS planned_start,
  CAST(ActualFinish AS TIMESTAMP) AS actual_finish
FROM `ext_mssql_asset_vision_ven_gen7`.dbo.capitalwork
WHERE COALESCE(Deleted, false) = false

),
photo_base AS (
  
SELECT
  CAST(ID AS STRING) AS photo_id,
  lower(TRIM(CAST(SourceTable AS STRING))) AS source_table,
  CAST(SourceTableID AS STRING) AS source_table_id
FROM `ext_mssql_asset_vision_ven_gen7`.dbo.photo
WHERE COALESCE(Deleted, false) = false

),
asset_rollup AS (
  SELECT
    source_context,
    contract,
    raw_asset_type,
    COUNT(DISTINCT asset_id) AS asset_count,
    SUM(CASE WHEN classification IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_classification,
    COUNT(DISTINCT classification) AS distinct_classifications,
    concat_ws('; ', sort_array(collect_set(classification))) AS classification_examples,
    concat_ws('; ', sort_array(collect_set(spatial_type))) AS spatial_type_examples,
    SUM(CASE WHEN asset_condition IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_condition,
    SUM(CASE WHEN asset_criticality IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_criticality,
    SUM(CASE WHEN asset_risk IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_risk,
    SUM(CASE WHEN chainage_from IS NOT NULL OR chainage_to IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_chainage,
    SUM(CASE WHEN parent_asset_id IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_parent_asset,
    SUM(CASE WHEN stage IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_stage,
    SUM(CASE WHEN construction_date IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_construction_date,
    SUM(CASE WHEN construction_cost IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_construction_cost,
    SUM(CASE WHEN useful_life IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_useful_life,
    SUM(CASE WHEN condition_date IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_condition_date,
    ROUND(SUM(CASE
      WHEN chainage_from IS NOT NULL
       AND chainage_to IS NOT NULL
       AND ABS(chainage_to - chainage_from) > 0
       AND ABS(chainage_to - chainage_from) < 1000000
      THEN ABS(chainage_to - chainage_from) / 1000.0 ELSE 0 END), 3) AS chainage_length_km_proxy
  FROM asset_base
  GROUP BY source_context, contract, raw_asset_type
),
location_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    SUM(CASE WHEN COALESCE(l.location_rows, 0) > 0 THEN 1 ELSE 0 END) AS assets_with_location_row,
    SUM(CASE WHEN COALESCE(l.has_wkt, 0) > 0 THEN 1 ELSE 0 END) AS assets_with_wkt,
    SUM(CASE WHEN COALESCE(l.has_valid_au_coord, 0) > 0 THEN 1 ELSE 0 END) AS assets_with_valid_au_coord,
    SUM(COALESCE(l.location_rows, 0)) AS location_rows,
    concat_ws('; ', sort_array(collect_set(l.wkt_geometry_types))) AS wkt_geometry_types
  FROM asset_base a
  LEFT JOIN loc_by_asset l
    ON l.asset_id = a.asset_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
attribute_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    COUNT(aa.attribute_name) AS attribute_rows,
    COUNT(DISTINCT aa.attribute_name) AS distinct_attribute_names,
    COUNT(DISTINCT CASE WHEN aa.attribute_name IS NOT NULL THEN a.asset_id END) AS assets_with_attributes,
    concat_ws('; ', sort_array(collect_set(aa.attribute_name))) AS attribute_name_examples
  FROM asset_base a
  LEFT JOIN assetattribute aa
    ON aa.asset_id = a.asset_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
job_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    COUNT(DISTINCT jl.job_id) AS job_count,
    COUNT(DISTINCT CASE WHEN jl.job_id IS NOT NULL THEN a.asset_id END) AS assets_with_job,
    COUNT(DISTINCT CASE WHEN jl.completed_date IS NOT NULL THEN jl.job_id END) AS completed_job_count,
    COUNT(DISTINCT CASE WHEN jl.completed_date IS NULL AND jl.due_date < current_timestamp() THEN jl.job_id END) AS overdue_open_job_count
  FROM asset_base a
  LEFT JOIN job_link jl
    ON jl.asset_id = a.asset_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
inspection_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    COUNT(DISTINCT i.inspection_id) AS inspection_count,
    COUNT(DISTINCT CASE WHEN i.inspection_id IS NOT NULL THEN a.asset_id END) AS assets_with_inspection,
    COUNT(DISTINCT CASE WHEN i.completed_date IS NOT NULL THEN i.inspection_id END) AS completed_inspection_count,
    COUNT(DISTINCT CASE WHEN i.completed_date IS NULL AND i.due_date < current_timestamp() THEN i.inspection_id END) AS overdue_open_inspection_count
  FROM asset_base a
  LEFT JOIN inspection_base i
    ON i.asset_id = a.asset_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
capitalwork_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    COUNT(DISTINCT c.capitalwork_id) AS capitalwork_count,
    COUNT(DISTINCT CASE WHEN c.capitalwork_id IS NOT NULL THEN a.asset_id END) AS assets_with_capitalwork,
    COUNT(DISTINCT CASE WHEN c.actual_finish IS NOT NULL THEN c.capitalwork_id END) AS completed_capitalwork_count
  FROM asset_base a
  LEFT JOIN capitalwork_base c
    ON c.asset_id = a.asset_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
asset_photo_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    COUNT(DISTINCT p.photo_id) AS asset_photo_count,
    COUNT(DISTINCT CASE WHEN p.photo_id IS NOT NULL THEN a.asset_id END) AS assets_with_asset_photo
  FROM asset_base a
  LEFT JOIN photo_base p
    ON p.source_table = 'asset'
   AND p.source_table_id = a.asset_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
job_photo_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    COUNT(DISTINCT p.photo_id) AS job_photo_count,
    COUNT(DISTINCT CASE WHEN p.photo_id IS NOT NULL THEN a.asset_id END) AS assets_with_job_photo
  FROM asset_base a
  LEFT JOIN job_link jl
    ON jl.asset_id = a.asset_id
  LEFT JOIN photo_base p
    ON p.source_table = 'job'
   AND p.source_table_id = jl.job_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
)
SELECT
  ar.*,
  lr.assets_with_location_row,
  lr.assets_with_wkt,
  lr.assets_with_valid_au_coord,
  lr.location_rows,
  lr.wkt_geometry_types,
  atr.attribute_rows,
  atr.distinct_attribute_names,
  atr.assets_with_attributes,
  atr.attribute_name_examples,
  jr.job_count,
  jr.assets_with_job,
  jr.completed_job_count,
  jr.overdue_open_job_count,
  ir.inspection_count,
  ir.assets_with_inspection,
  ir.completed_inspection_count,
  ir.overdue_open_inspection_count,
  cr.capitalwork_count,
  cr.assets_with_capitalwork,
  cr.completed_capitalwork_count,
  apr.asset_photo_count,
  apr.assets_with_asset_photo,
  jpr.job_photo_count,
  jpr.assets_with_job_photo
FROM asset_rollup ar
LEFT JOIN location_rollup lr USING (source_context, contract, raw_asset_type)
LEFT JOIN attribute_rollup atr USING (source_context, contract, raw_asset_type)
LEFT JOIN job_rollup jr USING (source_context, contract, raw_asset_type)
LEFT JOIN inspection_rollup ir USING (source_context, contract, raw_asset_type)
LEFT JOIN capitalwork_rollup cr USING (source_context, contract, raw_asset_type)
LEFT JOIN asset_photo_rollup apr USING (source_context, contract, raw_asset_type)
LEFT JOIN job_photo_rollup jpr USING (source_context, contract, raw_asset_type)
ORDER BY ar.contract, ar.raw_asset_type


-- asset_vision_ven_rms

WITH asset_base AS (
  SELECT
    'asset_vision_ven_rms' AS source_context,
    CAST(ID AS STRING) AS asset_id,
    COALESCE(NULLIF(TRIM(CAST(Contract AS STRING)), ''), 'asset_vision_ven_rms') AS contract,
    COALESCE(NULLIF(TRIM(CAST(AssetType AS STRING)), ''), 'Unspecified asset type') AS raw_asset_type,
    NULLIF(TRIM(CAST(Classification AS STRING)), '') AS classification,
    NULLIF(TRIM(CAST(SpatialType AS STRING)), '') AS spatial_type,
    NULLIF(TRIM(CAST(AssetCondition AS STRING)), '') AS asset_condition,
    NULLIF(TRIM(CAST(AssetCriticality AS STRING)), '') AS asset_criticality,
    NULLIF(TRIM(CAST(AssetRisk AS STRING)), '') AS asset_risk,
    CAST(ChainageFrom AS DOUBLE) AS chainage_from,
    CAST(ChainageTo AS DOUBLE) AS chainage_to,
    CAST(ParentAssetID AS STRING) AS parent_asset_id,
    NULLIF(TRIM(CAST(Stage AS STRING)), '') AS stage,
    CAST(ConstructionDate AS TIMESTAMP) AS construction_date,
    CAST(ConstructionCost AS DOUBLE) AS construction_cost,
    CAST(UsefulLife AS DOUBLE) AS useful_life,
    CAST(ConditionDate AS TIMESTAMP) AS condition_date
  FROM `ext_mssql_asset_vision_ven_rms`.dbo.asset
  WHERE COALESCE(Deleted, false) = false
),
loc_by_asset AS (
  
SELECT
  CAST(AssetID AS STRING) AS asset_id,
  COUNT(*) AS location_rows,
  MAX(CASE WHEN WKT IS NOT NULL AND TRIM(CAST(WKT AS STRING)) <> '' THEN 1 ELSE 0 END) AS has_wkt,
  MAX(CASE
    WHEN CAST(regexp_extract(WKT, '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)', 1) AS DOUBLE) BETWEEN 112 AND 180
     AND CAST(regexp_extract(WKT, '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)', 2) AS DOUBLE) BETWEEN -48 AND -9
    THEN 1 ELSE 0 END) AS has_valid_au_coord,
  concat_ws('; ', sort_array(collect_set(NULLIF(upper(regexp_extract(TRIM(CAST(WKT AS STRING)), '^([A-Za-z]+)', 1)), '')))) AS wkt_geometry_types
FROM `ext_mssql_asset_vision_ven_rms`.dbo.vassetlocation
WHERE COALESCE(Deleted, false) = false
GROUP BY CAST(AssetID AS STRING)

),
assetattribute AS (
  
SELECT
  CAST(AssetID AS STRING) AS asset_id,
  NULLIF(TRIM(CAST(Name AS STRING)), '') AS attribute_name,
  NULLIF(TRIM(CAST(Value AS STRING)), '') AS attribute_value
FROM `ext_mssql_asset_vision_ven_rms`.dbo.assetattribute
WHERE COALESCE(Deleted, false) = false

),
job_base AS (
  
SELECT
  CAST(ID AS STRING) AS job_id,
  CAST(AssetID AS STRING) AS asset_id,
  CAST(DueDate AS TIMESTAMP) AS due_date,
  CAST(CompletedDate AS TIMESTAMP) AS completed_date
FROM `ext_mssql_asset_vision_ven_rms`.dbo.job
WHERE COALESCE(Deleted, false) = false

),
jobasset_base AS (
  
SELECT
  CAST(JobID AS STRING) AS job_id,
  CAST(AssetID AS STRING) AS asset_id
FROM `ext_mssql_asset_vision_ven_rms`.dbo.jobasset
WHERE COALESCE(Deleted, false) = false

),
job_link AS (
  SELECT job_id, asset_id, due_date, completed_date
  FROM job_base
  WHERE asset_id IS NOT NULL
  UNION
  SELECT ja.job_id, ja.asset_id, j.due_date, j.completed_date
  FROM jobasset_base ja
  LEFT JOIN job_base j
    ON j.job_id = ja.job_id
  WHERE ja.asset_id IS NOT NULL
),
inspection_base AS (
  
SELECT
  CAST(ID AS STRING) AS inspection_id,
  CAST(AssetID AS STRING) AS asset_id,
  CAST(COALESCE(ScheduledDateTo, ScheduledDate) AS TIMESTAMP) AS due_date,
  CAST(CompletedDate AS TIMESTAMP) AS completed_date
FROM `ext_mssql_asset_vision_ven_rms`.dbo.inspection
WHERE COALESCE(Deleted, false) = false

),
capitalwork_base AS (
  
SELECT
  CAST(ID AS STRING) AS capitalwork_id,
  CAST(AssetID AS STRING) AS asset_id,
  CAST(PlannedStart AS TIMESTAMP) AS planned_start,
  CAST(ActualFinish AS TIMESTAMP) AS actual_finish
FROM `ext_mssql_asset_vision_ven_rms`.dbo.capitalwork
WHERE COALESCE(Deleted, false) = false

),
photo_base AS (
  
SELECT
  CAST(ID AS STRING) AS photo_id,
  lower(TRIM(CAST(SourceTable AS STRING))) AS source_table,
  CAST(SourceTableID AS STRING) AS source_table_id
FROM `ext_mssql_asset_vision_ven_rms`.dbo.photo
WHERE COALESCE(Deleted, false) = false

),
asset_rollup AS (
  SELECT
    source_context,
    contract,
    raw_asset_type,
    COUNT(DISTINCT asset_id) AS asset_count,
    SUM(CASE WHEN classification IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_classification,
    COUNT(DISTINCT classification) AS distinct_classifications,
    concat_ws('; ', sort_array(collect_set(classification))) AS classification_examples,
    concat_ws('; ', sort_array(collect_set(spatial_type))) AS spatial_type_examples,
    SUM(CASE WHEN asset_condition IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_condition,
    SUM(CASE WHEN asset_criticality IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_criticality,
    SUM(CASE WHEN asset_risk IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_risk,
    SUM(CASE WHEN chainage_from IS NOT NULL OR chainage_to IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_chainage,
    SUM(CASE WHEN parent_asset_id IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_parent_asset,
    SUM(CASE WHEN stage IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_stage,
    SUM(CASE WHEN construction_date IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_construction_date,
    SUM(CASE WHEN construction_cost IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_construction_cost,
    SUM(CASE WHEN useful_life IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_useful_life,
    SUM(CASE WHEN condition_date IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_condition_date,
    ROUND(SUM(CASE
      WHEN chainage_from IS NOT NULL
       AND chainage_to IS NOT NULL
       AND ABS(chainage_to - chainage_from) > 0
       AND ABS(chainage_to - chainage_from) < 1000000
      THEN ABS(chainage_to - chainage_from) / 1000.0 ELSE 0 END), 3) AS chainage_length_km_proxy
  FROM asset_base
  GROUP BY source_context, contract, raw_asset_type
),
location_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    SUM(CASE WHEN COALESCE(l.location_rows, 0) > 0 THEN 1 ELSE 0 END) AS assets_with_location_row,
    SUM(CASE WHEN COALESCE(l.has_wkt, 0) > 0 THEN 1 ELSE 0 END) AS assets_with_wkt,
    SUM(CASE WHEN COALESCE(l.has_valid_au_coord, 0) > 0 THEN 1 ELSE 0 END) AS assets_with_valid_au_coord,
    SUM(COALESCE(l.location_rows, 0)) AS location_rows,
    concat_ws('; ', sort_array(collect_set(l.wkt_geometry_types))) AS wkt_geometry_types
  FROM asset_base a
  LEFT JOIN loc_by_asset l
    ON l.asset_id = a.asset_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
attribute_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    COUNT(aa.attribute_name) AS attribute_rows,
    COUNT(DISTINCT aa.attribute_name) AS distinct_attribute_names,
    COUNT(DISTINCT CASE WHEN aa.attribute_name IS NOT NULL THEN a.asset_id END) AS assets_with_attributes,
    concat_ws('; ', sort_array(collect_set(aa.attribute_name))) AS attribute_name_examples
  FROM asset_base a
  LEFT JOIN assetattribute aa
    ON aa.asset_id = a.asset_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
job_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    COUNT(DISTINCT jl.job_id) AS job_count,
    COUNT(DISTINCT CASE WHEN jl.job_id IS NOT NULL THEN a.asset_id END) AS assets_with_job,
    COUNT(DISTINCT CASE WHEN jl.completed_date IS NOT NULL THEN jl.job_id END) AS completed_job_count,
    COUNT(DISTINCT CASE WHEN jl.completed_date IS NULL AND jl.due_date < current_timestamp() THEN jl.job_id END) AS overdue_open_job_count
  FROM asset_base a
  LEFT JOIN job_link jl
    ON jl.asset_id = a.asset_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
inspection_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    COUNT(DISTINCT i.inspection_id) AS inspection_count,
    COUNT(DISTINCT CASE WHEN i.inspection_id IS NOT NULL THEN a.asset_id END) AS assets_with_inspection,
    COUNT(DISTINCT CASE WHEN i.completed_date IS NOT NULL THEN i.inspection_id END) AS completed_inspection_count,
    COUNT(DISTINCT CASE WHEN i.completed_date IS NULL AND i.due_date < current_timestamp() THEN i.inspection_id END) AS overdue_open_inspection_count
  FROM asset_base a
  LEFT JOIN inspection_base i
    ON i.asset_id = a.asset_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
capitalwork_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    COUNT(DISTINCT c.capitalwork_id) AS capitalwork_count,
    COUNT(DISTINCT CASE WHEN c.capitalwork_id IS NOT NULL THEN a.asset_id END) AS assets_with_capitalwork,
    COUNT(DISTINCT CASE WHEN c.actual_finish IS NOT NULL THEN c.capitalwork_id END) AS completed_capitalwork_count
  FROM asset_base a
  LEFT JOIN capitalwork_base c
    ON c.asset_id = a.asset_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
asset_photo_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    COUNT(DISTINCT p.photo_id) AS asset_photo_count,
    COUNT(DISTINCT CASE WHEN p.photo_id IS NOT NULL THEN a.asset_id END) AS assets_with_asset_photo
  FROM asset_base a
  LEFT JOIN photo_base p
    ON p.source_table = 'asset'
   AND p.source_table_id = a.asset_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
job_photo_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    COUNT(DISTINCT p.photo_id) AS job_photo_count,
    COUNT(DISTINCT CASE WHEN p.photo_id IS NOT NULL THEN a.asset_id END) AS assets_with_job_photo
  FROM asset_base a
  LEFT JOIN job_link jl
    ON jl.asset_id = a.asset_id
  LEFT JOIN photo_base p
    ON p.source_table = 'job'
   AND p.source_table_id = jl.job_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
)
SELECT
  ar.*,
  lr.assets_with_location_row,
  lr.assets_with_wkt,
  lr.assets_with_valid_au_coord,
  lr.location_rows,
  lr.wkt_geometry_types,
  atr.attribute_rows,
  atr.distinct_attribute_names,
  atr.assets_with_attributes,
  atr.attribute_name_examples,
  jr.job_count,
  jr.assets_with_job,
  jr.completed_job_count,
  jr.overdue_open_job_count,
  ir.inspection_count,
  ir.assets_with_inspection,
  ir.completed_inspection_count,
  ir.overdue_open_inspection_count,
  cr.capitalwork_count,
  cr.assets_with_capitalwork,
  cr.completed_capitalwork_count,
  apr.asset_photo_count,
  apr.assets_with_asset_photo,
  jpr.job_photo_count,
  jpr.assets_with_job_photo
FROM asset_rollup ar
LEFT JOIN location_rollup lr USING (source_context, contract, raw_asset_type)
LEFT JOIN attribute_rollup atr USING (source_context, contract, raw_asset_type)
LEFT JOIN job_rollup jr USING (source_context, contract, raw_asset_type)
LEFT JOIN inspection_rollup ir USING (source_context, contract, raw_asset_type)
LEFT JOIN capitalwork_rollup cr USING (source_context, contract, raw_asset_type)
LEFT JOIN asset_photo_rollup apr USING (source_context, contract, raw_asset_type)
LEFT JOIN job_photo_rollup jpr USING (source_context, contract, raw_asset_type)
ORDER BY ar.contract, ar.raw_asset_type


-- asset_vision_ven_rms_new

WITH asset_base AS (
  SELECT
    'asset_vision_ven_rms_new' AS source_context,
    CAST(ID AS STRING) AS asset_id,
    COALESCE(NULLIF(TRIM(CAST(Contract AS STRING)), ''), 'asset_vision_ven_rms_new') AS contract,
    COALESCE(NULLIF(TRIM(CAST(AssetType AS STRING)), ''), 'Unspecified asset type') AS raw_asset_type,
    NULLIF(TRIM(CAST(Classification AS STRING)), '') AS classification,
    NULLIF(TRIM(CAST(SpatialType AS STRING)), '') AS spatial_type,
    NULLIF(TRIM(CAST(AssetCondition AS STRING)), '') AS asset_condition,
    NULLIF(TRIM(CAST(AssetCriticality AS STRING)), '') AS asset_criticality,
    NULLIF(TRIM(CAST(AssetRisk AS STRING)), '') AS asset_risk,
    CAST(ChainageFrom AS DOUBLE) AS chainage_from,
    CAST(ChainageTo AS DOUBLE) AS chainage_to,
    CAST(ParentAssetID AS STRING) AS parent_asset_id,
    NULLIF(TRIM(CAST(Stage AS STRING)), '') AS stage,
    CAST(ConstructionDate AS TIMESTAMP) AS construction_date,
    CAST(ConstructionCost AS DOUBLE) AS construction_cost,
    CAST(UsefulLife AS DOUBLE) AS useful_life,
    CAST(ConditionDate AS TIMESTAMP) AS condition_date
  FROM `ext_mssql_asset_vision_ven_rms_new`.dbo.asset
  WHERE COALESCE(Deleted, false) = false
),
loc_by_asset AS (
  
SELECT
  CAST(AssetID AS STRING) AS asset_id,
  COUNT(*) AS location_rows,
  MAX(CASE WHEN WKT IS NOT NULL AND TRIM(CAST(WKT AS STRING)) <> '' THEN 1 ELSE 0 END) AS has_wkt,
  MAX(CASE
    WHEN CAST(regexp_extract(WKT, '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)', 1) AS DOUBLE) BETWEEN 112 AND 180
     AND CAST(regexp_extract(WKT, '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)', 2) AS DOUBLE) BETWEEN -48 AND -9
    THEN 1 ELSE 0 END) AS has_valid_au_coord,
  concat_ws('; ', sort_array(collect_set(NULLIF(upper(regexp_extract(TRIM(CAST(WKT AS STRING)), '^([A-Za-z]+)', 1)), '')))) AS wkt_geometry_types
FROM `ext_mssql_asset_vision_ven_rms_new`.dbo.vassetlocation
WHERE COALESCE(Deleted, false) = false
GROUP BY CAST(AssetID AS STRING)

),
assetattribute AS (
  
SELECT
  CAST(AssetID AS STRING) AS asset_id,
  NULLIF(TRIM(CAST(Name AS STRING)), '') AS attribute_name,
  NULLIF(TRIM(CAST(Value AS STRING)), '') AS attribute_value
FROM `ext_mssql_asset_vision_ven_rms_new`.dbo.assetattribute
WHERE COALESCE(Deleted, false) = false

),
job_base AS (
  
SELECT
  CAST(ID AS STRING) AS job_id,
  CAST(AssetID AS STRING) AS asset_id,
  CAST(DueDate AS TIMESTAMP) AS due_date,
  CAST(CompletedDate AS TIMESTAMP) AS completed_date
FROM `ext_mssql_asset_vision_ven_rms_new`.dbo.job
WHERE COALESCE(Deleted, false) = false

),
jobasset_base AS (
  
SELECT
  CAST(JobID AS STRING) AS job_id,
  CAST(AssetID AS STRING) AS asset_id
FROM `ext_mssql_asset_vision_ven_rms_new`.dbo.jobasset
WHERE COALESCE(Deleted, false) = false

),
job_link AS (
  SELECT job_id, asset_id, due_date, completed_date
  FROM job_base
  WHERE asset_id IS NOT NULL
  UNION
  SELECT ja.job_id, ja.asset_id, j.due_date, j.completed_date
  FROM jobasset_base ja
  LEFT JOIN job_base j
    ON j.job_id = ja.job_id
  WHERE ja.asset_id IS NOT NULL
),
inspection_base AS (
  
SELECT
  CAST(ID AS STRING) AS inspection_id,
  CAST(AssetID AS STRING) AS asset_id,
  CAST(COALESCE(ScheduledDateTo, ScheduledDate) AS TIMESTAMP) AS due_date,
  CAST(CompletedDate AS TIMESTAMP) AS completed_date
FROM `ext_mssql_asset_vision_ven_rms_new`.dbo.inspection
WHERE COALESCE(Deleted, false) = false

),
capitalwork_base AS (
  
SELECT
  CAST(ID AS STRING) AS capitalwork_id,
  CAST(AssetID AS STRING) AS asset_id,
  CAST(PlannedStart AS TIMESTAMP) AS planned_start,
  CAST(ActualFinish AS TIMESTAMP) AS actual_finish
FROM `ext_mssql_asset_vision_ven_rms_new`.dbo.capitalwork
WHERE COALESCE(Deleted, false) = false

),
photo_base AS (
  
SELECT
  CAST(ID AS STRING) AS photo_id,
  lower(TRIM(CAST(SourceTable AS STRING))) AS source_table,
  CAST(SourceTableID AS STRING) AS source_table_id
FROM `ext_mssql_asset_vision_ven_rms_new`.dbo.photo
WHERE COALESCE(Deleted, false) = false

),
asset_rollup AS (
  SELECT
    source_context,
    contract,
    raw_asset_type,
    COUNT(DISTINCT asset_id) AS asset_count,
    SUM(CASE WHEN classification IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_classification,
    COUNT(DISTINCT classification) AS distinct_classifications,
    concat_ws('; ', sort_array(collect_set(classification))) AS classification_examples,
    concat_ws('; ', sort_array(collect_set(spatial_type))) AS spatial_type_examples,
    SUM(CASE WHEN asset_condition IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_condition,
    SUM(CASE WHEN asset_criticality IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_criticality,
    SUM(CASE WHEN asset_risk IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_risk,
    SUM(CASE WHEN chainage_from IS NOT NULL OR chainage_to IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_chainage,
    SUM(CASE WHEN parent_asset_id IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_parent_asset,
    SUM(CASE WHEN stage IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_stage,
    SUM(CASE WHEN construction_date IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_construction_date,
    SUM(CASE WHEN construction_cost IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_construction_cost,
    SUM(CASE WHEN useful_life IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_useful_life,
    SUM(CASE WHEN condition_date IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_condition_date,
    ROUND(SUM(CASE
      WHEN chainage_from IS NOT NULL
       AND chainage_to IS NOT NULL
       AND ABS(chainage_to - chainage_from) > 0
       AND ABS(chainage_to - chainage_from) < 1000000
      THEN ABS(chainage_to - chainage_from) / 1000.0 ELSE 0 END), 3) AS chainage_length_km_proxy
  FROM asset_base
  GROUP BY source_context, contract, raw_asset_type
),
location_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    SUM(CASE WHEN COALESCE(l.location_rows, 0) > 0 THEN 1 ELSE 0 END) AS assets_with_location_row,
    SUM(CASE WHEN COALESCE(l.has_wkt, 0) > 0 THEN 1 ELSE 0 END) AS assets_with_wkt,
    SUM(CASE WHEN COALESCE(l.has_valid_au_coord, 0) > 0 THEN 1 ELSE 0 END) AS assets_with_valid_au_coord,
    SUM(COALESCE(l.location_rows, 0)) AS location_rows,
    concat_ws('; ', sort_array(collect_set(l.wkt_geometry_types))) AS wkt_geometry_types
  FROM asset_base a
  LEFT JOIN loc_by_asset l
    ON l.asset_id = a.asset_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
attribute_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    COUNT(aa.attribute_name) AS attribute_rows,
    COUNT(DISTINCT aa.attribute_name) AS distinct_attribute_names,
    COUNT(DISTINCT CASE WHEN aa.attribute_name IS NOT NULL THEN a.asset_id END) AS assets_with_attributes,
    concat_ws('; ', sort_array(collect_set(aa.attribute_name))) AS attribute_name_examples
  FROM asset_base a
  LEFT JOIN assetattribute aa
    ON aa.asset_id = a.asset_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
job_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    COUNT(DISTINCT jl.job_id) AS job_count,
    COUNT(DISTINCT CASE WHEN jl.job_id IS NOT NULL THEN a.asset_id END) AS assets_with_job,
    COUNT(DISTINCT CASE WHEN jl.completed_date IS NOT NULL THEN jl.job_id END) AS completed_job_count,
    COUNT(DISTINCT CASE WHEN jl.completed_date IS NULL AND jl.due_date < current_timestamp() THEN jl.job_id END) AS overdue_open_job_count
  FROM asset_base a
  LEFT JOIN job_link jl
    ON jl.asset_id = a.asset_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
inspection_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    COUNT(DISTINCT i.inspection_id) AS inspection_count,
    COUNT(DISTINCT CASE WHEN i.inspection_id IS NOT NULL THEN a.asset_id END) AS assets_with_inspection,
    COUNT(DISTINCT CASE WHEN i.completed_date IS NOT NULL THEN i.inspection_id END) AS completed_inspection_count,
    COUNT(DISTINCT CASE WHEN i.completed_date IS NULL AND i.due_date < current_timestamp() THEN i.inspection_id END) AS overdue_open_inspection_count
  FROM asset_base a
  LEFT JOIN inspection_base i
    ON i.asset_id = a.asset_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
capitalwork_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    COUNT(DISTINCT c.capitalwork_id) AS capitalwork_count,
    COUNT(DISTINCT CASE WHEN c.capitalwork_id IS NOT NULL THEN a.asset_id END) AS assets_with_capitalwork,
    COUNT(DISTINCT CASE WHEN c.actual_finish IS NOT NULL THEN c.capitalwork_id END) AS completed_capitalwork_count
  FROM asset_base a
  LEFT JOIN capitalwork_base c
    ON c.asset_id = a.asset_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
asset_photo_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    COUNT(DISTINCT p.photo_id) AS asset_photo_count,
    COUNT(DISTINCT CASE WHEN p.photo_id IS NOT NULL THEN a.asset_id END) AS assets_with_asset_photo
  FROM asset_base a
  LEFT JOIN photo_base p
    ON p.source_table = 'asset'
   AND p.source_table_id = a.asset_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
job_photo_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    COUNT(DISTINCT p.photo_id) AS job_photo_count,
    COUNT(DISTINCT CASE WHEN p.photo_id IS NOT NULL THEN a.asset_id END) AS assets_with_job_photo
  FROM asset_base a
  LEFT JOIN job_link jl
    ON jl.asset_id = a.asset_id
  LEFT JOIN photo_base p
    ON p.source_table = 'job'
   AND p.source_table_id = jl.job_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
)
SELECT
  ar.*,
  lr.assets_with_location_row,
  lr.assets_with_wkt,
  lr.assets_with_valid_au_coord,
  lr.location_rows,
  lr.wkt_geometry_types,
  atr.attribute_rows,
  atr.distinct_attribute_names,
  atr.assets_with_attributes,
  atr.attribute_name_examples,
  jr.job_count,
  jr.assets_with_job,
  jr.completed_job_count,
  jr.overdue_open_job_count,
  ir.inspection_count,
  ir.assets_with_inspection,
  ir.completed_inspection_count,
  ir.overdue_open_inspection_count,
  cr.capitalwork_count,
  cr.assets_with_capitalwork,
  cr.completed_capitalwork_count,
  apr.asset_photo_count,
  apr.assets_with_asset_photo,
  jpr.job_photo_count,
  jpr.assets_with_job_photo
FROM asset_rollup ar
LEFT JOIN location_rollup lr USING (source_context, contract, raw_asset_type)
LEFT JOIN attribute_rollup atr USING (source_context, contract, raw_asset_type)
LEFT JOIN job_rollup jr USING (source_context, contract, raw_asset_type)
LEFT JOIN inspection_rollup ir USING (source_context, contract, raw_asset_type)
LEFT JOIN capitalwork_rollup cr USING (source_context, contract, raw_asset_type)
LEFT JOIN asset_photo_rollup apr USING (source_context, contract, raw_asset_type)
LEFT JOIN job_photo_rollup jpr USING (source_context, contract, raw_asset_type)
ORDER BY ar.contract, ar.raw_asset_type


-- asset_vision_ven_vicroads

WITH asset_base AS (
  SELECT
    'asset_vision_ven_vicroads' AS source_context,
    CAST(ID AS STRING) AS asset_id,
    COALESCE(NULLIF(TRIM(CAST(Contract AS STRING)), ''), 'asset_vision_ven_vicroads') AS contract,
    COALESCE(NULLIF(TRIM(CAST(AssetType AS STRING)), ''), 'Unspecified asset type') AS raw_asset_type,
    NULLIF(TRIM(CAST(Classification AS STRING)), '') AS classification,
    NULLIF(TRIM(CAST(SpatialType AS STRING)), '') AS spatial_type,
    NULLIF(TRIM(CAST(AssetCondition AS STRING)), '') AS asset_condition,
    NULLIF(TRIM(CAST(AssetCriticality AS STRING)), '') AS asset_criticality,
    NULLIF(TRIM(CAST(AssetRisk AS STRING)), '') AS asset_risk,
    CAST(ChainageFrom AS DOUBLE) AS chainage_from,
    CAST(ChainageTo AS DOUBLE) AS chainage_to,
    CAST(ParentAssetID AS STRING) AS parent_asset_id,
    NULLIF(TRIM(CAST(Stage AS STRING)), '') AS stage,
    CAST(ConstructionDate AS TIMESTAMP) AS construction_date,
    CAST(ConstructionCost AS DOUBLE) AS construction_cost,
    CAST(UsefulLife AS DOUBLE) AS useful_life,
    CAST(ConditionDate AS TIMESTAMP) AS condition_date
  FROM `ext_mssql_asset_vision_ven_vicroads`.dbo.asset
  WHERE COALESCE(Deleted, false) = false
),
loc_by_asset AS (
  
SELECT
  CAST(AssetID AS STRING) AS asset_id,
  COUNT(*) AS location_rows,
  MAX(CASE WHEN WKT IS NOT NULL AND TRIM(CAST(WKT AS STRING)) <> '' THEN 1 ELSE 0 END) AS has_wkt,
  MAX(CASE
    WHEN CAST(regexp_extract(WKT, '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)', 1) AS DOUBLE) BETWEEN 112 AND 180
     AND CAST(regexp_extract(WKT, '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)', 2) AS DOUBLE) BETWEEN -48 AND -9
    THEN 1 ELSE 0 END) AS has_valid_au_coord,
  concat_ws('; ', sort_array(collect_set(NULLIF(upper(regexp_extract(TRIM(CAST(WKT AS STRING)), '^([A-Za-z]+)', 1)), '')))) AS wkt_geometry_types
FROM `ext_mssql_asset_vision_ven_vicroads`.dbo.vassetlocation
WHERE COALESCE(Deleted, false) = false
GROUP BY CAST(AssetID AS STRING)

),
assetattribute AS (
  
SELECT
  CAST(AssetID AS STRING) AS asset_id,
  NULLIF(TRIM(CAST(Name AS STRING)), '') AS attribute_name,
  NULLIF(TRIM(CAST(Value AS STRING)), '') AS attribute_value
FROM `ext_mssql_asset_vision_ven_vicroads`.dbo.assetattribute
WHERE COALESCE(Deleted, false) = false

),
job_base AS (
  
SELECT
  CAST(ID AS STRING) AS job_id,
  CAST(AssetID AS STRING) AS asset_id,
  CAST(DueDate AS TIMESTAMP) AS due_date,
  CAST(CompletedDate AS TIMESTAMP) AS completed_date
FROM `ext_mssql_asset_vision_ven_vicroads`.dbo.job
WHERE COALESCE(Deleted, false) = false

),
jobasset_base AS (
  
SELECT
  CAST(JobID AS STRING) AS job_id,
  CAST(AssetID AS STRING) AS asset_id
FROM `ext_mssql_asset_vision_ven_vicroads`.dbo.jobasset
WHERE COALESCE(Deleted, false) = false

),
job_link AS (
  SELECT job_id, asset_id, due_date, completed_date
  FROM job_base
  WHERE asset_id IS NOT NULL
  UNION
  SELECT ja.job_id, ja.asset_id, j.due_date, j.completed_date
  FROM jobasset_base ja
  LEFT JOIN job_base j
    ON j.job_id = ja.job_id
  WHERE ja.asset_id IS NOT NULL
),
inspection_base AS (
  
SELECT
  CAST(ID AS STRING) AS inspection_id,
  CAST(AssetID AS STRING) AS asset_id,
  CAST(COALESCE(ScheduledDateTo, ScheduledDate) AS TIMESTAMP) AS due_date,
  CAST(CompletedDate AS TIMESTAMP) AS completed_date
FROM `ext_mssql_asset_vision_ven_vicroads`.dbo.inspection
WHERE COALESCE(Deleted, false) = false

),
capitalwork_base AS (
  
SELECT
  CAST(ID AS STRING) AS capitalwork_id,
  CAST(AssetID AS STRING) AS asset_id,
  CAST(PlannedStart AS TIMESTAMP) AS planned_start,
  CAST(ActualFinish AS TIMESTAMP) AS actual_finish
FROM `ext_mssql_asset_vision_ven_vicroads`.dbo.capitalwork
WHERE COALESCE(Deleted, false) = false

),
photo_base AS (
  
SELECT
  CAST(ID AS STRING) AS photo_id,
  lower(TRIM(CAST(SourceTable AS STRING))) AS source_table,
  CAST(SourceTableID AS STRING) AS source_table_id
FROM `ext_mssql_asset_vision_ven_vicroads`.dbo.photo
WHERE COALESCE(Deleted, false) = false

),
asset_rollup AS (
  SELECT
    source_context,
    contract,
    raw_asset_type,
    COUNT(DISTINCT asset_id) AS asset_count,
    SUM(CASE WHEN classification IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_classification,
    COUNT(DISTINCT classification) AS distinct_classifications,
    concat_ws('; ', sort_array(collect_set(classification))) AS classification_examples,
    concat_ws('; ', sort_array(collect_set(spatial_type))) AS spatial_type_examples,
    SUM(CASE WHEN asset_condition IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_condition,
    SUM(CASE WHEN asset_criticality IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_criticality,
    SUM(CASE WHEN asset_risk IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_risk,
    SUM(CASE WHEN chainage_from IS NOT NULL OR chainage_to IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_chainage,
    SUM(CASE WHEN parent_asset_id IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_parent_asset,
    SUM(CASE WHEN stage IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_stage,
    SUM(CASE WHEN construction_date IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_construction_date,
    SUM(CASE WHEN construction_cost IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_construction_cost,
    SUM(CASE WHEN useful_life IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_useful_life,
    SUM(CASE WHEN condition_date IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_condition_date,
    ROUND(SUM(CASE
      WHEN chainage_from IS NOT NULL
       AND chainage_to IS NOT NULL
       AND ABS(chainage_to - chainage_from) > 0
       AND ABS(chainage_to - chainage_from) < 1000000
      THEN ABS(chainage_to - chainage_from) / 1000.0 ELSE 0 END), 3) AS chainage_length_km_proxy
  FROM asset_base
  GROUP BY source_context, contract, raw_asset_type
),
location_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    SUM(CASE WHEN COALESCE(l.location_rows, 0) > 0 THEN 1 ELSE 0 END) AS assets_with_location_row,
    SUM(CASE WHEN COALESCE(l.has_wkt, 0) > 0 THEN 1 ELSE 0 END) AS assets_with_wkt,
    SUM(CASE WHEN COALESCE(l.has_valid_au_coord, 0) > 0 THEN 1 ELSE 0 END) AS assets_with_valid_au_coord,
    SUM(COALESCE(l.location_rows, 0)) AS location_rows,
    concat_ws('; ', sort_array(collect_set(l.wkt_geometry_types))) AS wkt_geometry_types
  FROM asset_base a
  LEFT JOIN loc_by_asset l
    ON l.asset_id = a.asset_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
attribute_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    COUNT(aa.attribute_name) AS attribute_rows,
    COUNT(DISTINCT aa.attribute_name) AS distinct_attribute_names,
    COUNT(DISTINCT CASE WHEN aa.attribute_name IS NOT NULL THEN a.asset_id END) AS assets_with_attributes,
    concat_ws('; ', sort_array(collect_set(aa.attribute_name))) AS attribute_name_examples
  FROM asset_base a
  LEFT JOIN assetattribute aa
    ON aa.asset_id = a.asset_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
job_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    COUNT(DISTINCT jl.job_id) AS job_count,
    COUNT(DISTINCT CASE WHEN jl.job_id IS NOT NULL THEN a.asset_id END) AS assets_with_job,
    COUNT(DISTINCT CASE WHEN jl.completed_date IS NOT NULL THEN jl.job_id END) AS completed_job_count,
    COUNT(DISTINCT CASE WHEN jl.completed_date IS NULL AND jl.due_date < current_timestamp() THEN jl.job_id END) AS overdue_open_job_count
  FROM asset_base a
  LEFT JOIN job_link jl
    ON jl.asset_id = a.asset_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
inspection_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    COUNT(DISTINCT i.inspection_id) AS inspection_count,
    COUNT(DISTINCT CASE WHEN i.inspection_id IS NOT NULL THEN a.asset_id END) AS assets_with_inspection,
    COUNT(DISTINCT CASE WHEN i.completed_date IS NOT NULL THEN i.inspection_id END) AS completed_inspection_count,
    COUNT(DISTINCT CASE WHEN i.completed_date IS NULL AND i.due_date < current_timestamp() THEN i.inspection_id END) AS overdue_open_inspection_count
  FROM asset_base a
  LEFT JOIN inspection_base i
    ON i.asset_id = a.asset_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
capitalwork_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    COUNT(DISTINCT c.capitalwork_id) AS capitalwork_count,
    COUNT(DISTINCT CASE WHEN c.capitalwork_id IS NOT NULL THEN a.asset_id END) AS assets_with_capitalwork,
    COUNT(DISTINCT CASE WHEN c.actual_finish IS NOT NULL THEN c.capitalwork_id END) AS completed_capitalwork_count
  FROM asset_base a
  LEFT JOIN capitalwork_base c
    ON c.asset_id = a.asset_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
asset_photo_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    COUNT(DISTINCT p.photo_id) AS asset_photo_count,
    COUNT(DISTINCT CASE WHEN p.photo_id IS NOT NULL THEN a.asset_id END) AS assets_with_asset_photo
  FROM asset_base a
  LEFT JOIN photo_base p
    ON p.source_table = 'asset'
   AND p.source_table_id = a.asset_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
job_photo_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    COUNT(DISTINCT p.photo_id) AS job_photo_count,
    COUNT(DISTINCT CASE WHEN p.photo_id IS NOT NULL THEN a.asset_id END) AS assets_with_job_photo
  FROM asset_base a
  LEFT JOIN job_link jl
    ON jl.asset_id = a.asset_id
  LEFT JOIN photo_base p
    ON p.source_table = 'job'
   AND p.source_table_id = jl.job_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
)
SELECT
  ar.*,
  lr.assets_with_location_row,
  lr.assets_with_wkt,
  lr.assets_with_valid_au_coord,
  lr.location_rows,
  lr.wkt_geometry_types,
  atr.attribute_rows,
  atr.distinct_attribute_names,
  atr.assets_with_attributes,
  atr.attribute_name_examples,
  jr.job_count,
  jr.assets_with_job,
  jr.completed_job_count,
  jr.overdue_open_job_count,
  ir.inspection_count,
  ir.assets_with_inspection,
  ir.completed_inspection_count,
  ir.overdue_open_inspection_count,
  cr.capitalwork_count,
  cr.assets_with_capitalwork,
  cr.completed_capitalwork_count,
  apr.asset_photo_count,
  apr.assets_with_asset_photo,
  jpr.job_photo_count,
  jpr.assets_with_job_photo
FROM asset_rollup ar
LEFT JOIN location_rollup lr USING (source_context, contract, raw_asset_type)
LEFT JOIN attribute_rollup atr USING (source_context, contract, raw_asset_type)
LEFT JOIN job_rollup jr USING (source_context, contract, raw_asset_type)
LEFT JOIN inspection_rollup ir USING (source_context, contract, raw_asset_type)
LEFT JOIN capitalwork_rollup cr USING (source_context, contract, raw_asset_type)
LEFT JOIN asset_photo_rollup apr USING (source_context, contract, raw_asset_type)
LEFT JOIN job_photo_rollup jpr USING (source_context, contract, raw_asset_type)
ORDER BY ar.contract, ar.raw_asset_type


-- asset_vision_vns_gen7

WITH asset_base AS (
  SELECT
    'asset_vision_vns_gen7' AS source_context,
    CAST(ID AS STRING) AS asset_id,
    COALESCE(NULLIF(TRIM(CAST(Contract AS STRING)), ''), 'asset_vision_vns_gen7') AS contract,
    COALESCE(NULLIF(TRIM(CAST(AssetType AS STRING)), ''), 'Unspecified asset type') AS raw_asset_type,
    NULLIF(TRIM(CAST(Classification AS STRING)), '') AS classification,
    NULLIF(TRIM(CAST(SpatialType AS STRING)), '') AS spatial_type,
    NULLIF(TRIM(CAST(AssetCondition AS STRING)), '') AS asset_condition,
    NULLIF(TRIM(CAST(AssetCriticality AS STRING)), '') AS asset_criticality,
    NULLIF(TRIM(CAST(AssetRisk AS STRING)), '') AS asset_risk,
    CAST(ChainageFrom AS DOUBLE) AS chainage_from,
    CAST(ChainageTo AS DOUBLE) AS chainage_to,
    CAST(ParentAssetID AS STRING) AS parent_asset_id,
    NULLIF(TRIM(CAST(Stage AS STRING)), '') AS stage,
    CAST(ConstructionDate AS TIMESTAMP) AS construction_date,
    CAST(ConstructionCost AS DOUBLE) AS construction_cost,
    CAST(UsefulLife AS DOUBLE) AS useful_life,
    CAST(ConditionDate AS TIMESTAMP) AS condition_date
  FROM `ext_mssql_asset_vision_vns_gen7`.dbo.asset
  WHERE COALESCE(Deleted, false) = false
),
loc_by_asset AS (
  
SELECT
  CAST(AssetID AS STRING) AS asset_id,
  COUNT(*) AS location_rows,
  MAX(CASE WHEN WKT IS NOT NULL AND TRIM(CAST(WKT AS STRING)) <> '' THEN 1 ELSE 0 END) AS has_wkt,
  MAX(CASE
    WHEN CAST(regexp_extract(WKT, '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)', 1) AS DOUBLE) BETWEEN 112 AND 180
     AND CAST(regexp_extract(WKT, '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)', 2) AS DOUBLE) BETWEEN -48 AND -9
    THEN 1 ELSE 0 END) AS has_valid_au_coord,
  concat_ws('; ', sort_array(collect_set(NULLIF(upper(regexp_extract(TRIM(CAST(WKT AS STRING)), '^([A-Za-z]+)', 1)), '')))) AS wkt_geometry_types
FROM `ext_mssql_asset_vision_vns_gen7`.dbo.vassetlocation
WHERE COALESCE(Deleted, false) = false
GROUP BY CAST(AssetID AS STRING)

),
assetattribute AS (
  
SELECT
  CAST(AssetID AS STRING) AS asset_id,
  NULLIF(TRIM(CAST(Name AS STRING)), '') AS attribute_name,
  NULLIF(TRIM(CAST(Value AS STRING)), '') AS attribute_value
FROM `ext_mssql_asset_vision_vns_gen7`.dbo.assetattribute
WHERE COALESCE(Deleted, false) = false

),
job_base AS (
  
SELECT
  CAST(ID AS STRING) AS job_id,
  CAST(AssetID AS STRING) AS asset_id,
  CAST(DueDate AS TIMESTAMP) AS due_date,
  CAST(CompletedDate AS TIMESTAMP) AS completed_date
FROM `ext_mssql_asset_vision_vns_gen7`.dbo.job
WHERE COALESCE(Deleted, false) = false

),
jobasset_base AS (
  
SELECT
  CAST(JobID AS STRING) AS job_id,
  CAST(AssetID AS STRING) AS asset_id
FROM `ext_mssql_asset_vision_vns_gen7`.dbo.jobasset
WHERE COALESCE(Deleted, false) = false

),
job_link AS (
  SELECT job_id, asset_id, due_date, completed_date
  FROM job_base
  WHERE asset_id IS NOT NULL
  UNION
  SELECT ja.job_id, ja.asset_id, j.due_date, j.completed_date
  FROM jobasset_base ja
  LEFT JOIN job_base j
    ON j.job_id = ja.job_id
  WHERE ja.asset_id IS NOT NULL
),
inspection_base AS (
  
SELECT
  CAST(ID AS STRING) AS inspection_id,
  CAST(AssetID AS STRING) AS asset_id,
  CAST(COALESCE(ScheduledDateTo, ScheduledDate) AS TIMESTAMP) AS due_date,
  CAST(CompletedDate AS TIMESTAMP) AS completed_date
FROM `ext_mssql_asset_vision_vns_gen7`.dbo.inspection
WHERE COALESCE(Deleted, false) = false

),
capitalwork_base AS (
  
SELECT
  CAST(ID AS STRING) AS capitalwork_id,
  CAST(AssetID AS STRING) AS asset_id,
  CAST(PlannedStart AS TIMESTAMP) AS planned_start,
  CAST(ActualFinish AS TIMESTAMP) AS actual_finish
FROM `ext_mssql_asset_vision_vns_gen7`.dbo.capitalwork
WHERE COALESCE(Deleted, false) = false

),
photo_base AS (
  
SELECT
  CAST(ID AS STRING) AS photo_id,
  lower(TRIM(CAST(SourceTable AS STRING))) AS source_table,
  CAST(SourceTableID AS STRING) AS source_table_id
FROM `ext_mssql_asset_vision_vns_gen7`.dbo.photo
WHERE COALESCE(Deleted, false) = false

),
asset_rollup AS (
  SELECT
    source_context,
    contract,
    raw_asset_type,
    COUNT(DISTINCT asset_id) AS asset_count,
    SUM(CASE WHEN classification IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_classification,
    COUNT(DISTINCT classification) AS distinct_classifications,
    concat_ws('; ', sort_array(collect_set(classification))) AS classification_examples,
    concat_ws('; ', sort_array(collect_set(spatial_type))) AS spatial_type_examples,
    SUM(CASE WHEN asset_condition IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_condition,
    SUM(CASE WHEN asset_criticality IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_criticality,
    SUM(CASE WHEN asset_risk IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_risk,
    SUM(CASE WHEN chainage_from IS NOT NULL OR chainage_to IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_chainage,
    SUM(CASE WHEN parent_asset_id IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_parent_asset,
    SUM(CASE WHEN stage IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_stage,
    SUM(CASE WHEN construction_date IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_construction_date,
    SUM(CASE WHEN construction_cost IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_construction_cost,
    SUM(CASE WHEN useful_life IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_useful_life,
    SUM(CASE WHEN condition_date IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_condition_date,
    ROUND(SUM(CASE
      WHEN chainage_from IS NOT NULL
       AND chainage_to IS NOT NULL
       AND ABS(chainage_to - chainage_from) > 0
       AND ABS(chainage_to - chainage_from) < 1000000
      THEN ABS(chainage_to - chainage_from) / 1000.0 ELSE 0 END), 3) AS chainage_length_km_proxy
  FROM asset_base
  GROUP BY source_context, contract, raw_asset_type
),
location_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    SUM(CASE WHEN COALESCE(l.location_rows, 0) > 0 THEN 1 ELSE 0 END) AS assets_with_location_row,
    SUM(CASE WHEN COALESCE(l.has_wkt, 0) > 0 THEN 1 ELSE 0 END) AS assets_with_wkt,
    SUM(CASE WHEN COALESCE(l.has_valid_au_coord, 0) > 0 THEN 1 ELSE 0 END) AS assets_with_valid_au_coord,
    SUM(COALESCE(l.location_rows, 0)) AS location_rows,
    concat_ws('; ', sort_array(collect_set(l.wkt_geometry_types))) AS wkt_geometry_types
  FROM asset_base a
  LEFT JOIN loc_by_asset l
    ON l.asset_id = a.asset_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
attribute_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    COUNT(aa.attribute_name) AS attribute_rows,
    COUNT(DISTINCT aa.attribute_name) AS distinct_attribute_names,
    COUNT(DISTINCT CASE WHEN aa.attribute_name IS NOT NULL THEN a.asset_id END) AS assets_with_attributes,
    concat_ws('; ', sort_array(collect_set(aa.attribute_name))) AS attribute_name_examples
  FROM asset_base a
  LEFT JOIN assetattribute aa
    ON aa.asset_id = a.asset_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
job_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    COUNT(DISTINCT jl.job_id) AS job_count,
    COUNT(DISTINCT CASE WHEN jl.job_id IS NOT NULL THEN a.asset_id END) AS assets_with_job,
    COUNT(DISTINCT CASE WHEN jl.completed_date IS NOT NULL THEN jl.job_id END) AS completed_job_count,
    COUNT(DISTINCT CASE WHEN jl.completed_date IS NULL AND jl.due_date < current_timestamp() THEN jl.job_id END) AS overdue_open_job_count
  FROM asset_base a
  LEFT JOIN job_link jl
    ON jl.asset_id = a.asset_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
inspection_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    COUNT(DISTINCT i.inspection_id) AS inspection_count,
    COUNT(DISTINCT CASE WHEN i.inspection_id IS NOT NULL THEN a.asset_id END) AS assets_with_inspection,
    COUNT(DISTINCT CASE WHEN i.completed_date IS NOT NULL THEN i.inspection_id END) AS completed_inspection_count,
    COUNT(DISTINCT CASE WHEN i.completed_date IS NULL AND i.due_date < current_timestamp() THEN i.inspection_id END) AS overdue_open_inspection_count
  FROM asset_base a
  LEFT JOIN inspection_base i
    ON i.asset_id = a.asset_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
capitalwork_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    COUNT(DISTINCT c.capitalwork_id) AS capitalwork_count,
    COUNT(DISTINCT CASE WHEN c.capitalwork_id IS NOT NULL THEN a.asset_id END) AS assets_with_capitalwork,
    COUNT(DISTINCT CASE WHEN c.actual_finish IS NOT NULL THEN c.capitalwork_id END) AS completed_capitalwork_count
  FROM asset_base a
  LEFT JOIN capitalwork_base c
    ON c.asset_id = a.asset_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
asset_photo_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    COUNT(DISTINCT p.photo_id) AS asset_photo_count,
    COUNT(DISTINCT CASE WHEN p.photo_id IS NOT NULL THEN a.asset_id END) AS assets_with_asset_photo
  FROM asset_base a
  LEFT JOIN photo_base p
    ON p.source_table = 'asset'
   AND p.source_table_id = a.asset_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
job_photo_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    COUNT(DISTINCT p.photo_id) AS job_photo_count,
    COUNT(DISTINCT CASE WHEN p.photo_id IS NOT NULL THEN a.asset_id END) AS assets_with_job_photo
  FROM asset_base a
  LEFT JOIN job_link jl
    ON jl.asset_id = a.asset_id
  LEFT JOIN photo_base p
    ON p.source_table = 'job'
   AND p.source_table_id = jl.job_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
)
SELECT
  ar.*,
  lr.assets_with_location_row,
  lr.assets_with_wkt,
  lr.assets_with_valid_au_coord,
  lr.location_rows,
  lr.wkt_geometry_types,
  atr.attribute_rows,
  atr.distinct_attribute_names,
  atr.assets_with_attributes,
  atr.attribute_name_examples,
  jr.job_count,
  jr.assets_with_job,
  jr.completed_job_count,
  jr.overdue_open_job_count,
  ir.inspection_count,
  ir.assets_with_inspection,
  ir.completed_inspection_count,
  ir.overdue_open_inspection_count,
  cr.capitalwork_count,
  cr.assets_with_capitalwork,
  cr.completed_capitalwork_count,
  apr.asset_photo_count,
  apr.assets_with_asset_photo,
  jpr.job_photo_count,
  jpr.assets_with_job_photo
FROM asset_rollup ar
LEFT JOIN location_rollup lr USING (source_context, contract, raw_asset_type)
LEFT JOIN attribute_rollup atr USING (source_context, contract, raw_asset_type)
LEFT JOIN job_rollup jr USING (source_context, contract, raw_asset_type)
LEFT JOIN inspection_rollup ir USING (source_context, contract, raw_asset_type)
LEFT JOIN capitalwork_rollup cr USING (source_context, contract, raw_asset_type)
LEFT JOIN asset_photo_rollup apr USING (source_context, contract, raw_asset_type)
LEFT JOIN job_photo_rollup jpr USING (source_context, contract, raw_asset_type)
ORDER BY ar.contract, ar.raw_asset_type


-- asset_vision_vnz_gen7

WITH asset_base AS (
  SELECT
    'asset_vision_vnz_gen7' AS source_context,
    CAST(ID AS STRING) AS asset_id,
    COALESCE(NULLIF(TRIM(CAST(Contract AS STRING)), ''), 'asset_vision_vnz_gen7') AS contract,
    COALESCE(NULLIF(TRIM(CAST(AssetType AS STRING)), ''), 'Unspecified asset type') AS raw_asset_type,
    NULLIF(TRIM(CAST(Classification AS STRING)), '') AS classification,
    NULLIF(TRIM(CAST(SpatialType AS STRING)), '') AS spatial_type,
    NULLIF(TRIM(CAST(AssetCondition AS STRING)), '') AS asset_condition,
    NULLIF(TRIM(CAST(AssetCriticality AS STRING)), '') AS asset_criticality,
    NULLIF(TRIM(CAST(AssetRisk AS STRING)), '') AS asset_risk,
    CAST(ChainageFrom AS DOUBLE) AS chainage_from,
    CAST(ChainageTo AS DOUBLE) AS chainage_to,
    CAST(ParentAssetID AS STRING) AS parent_asset_id,
    NULLIF(TRIM(CAST(Stage AS STRING)), '') AS stage,
    CAST(ConstructionDate AS TIMESTAMP) AS construction_date,
    CAST(ConstructionCost AS DOUBLE) AS construction_cost,
    CAST(UsefulLife AS DOUBLE) AS useful_life,
    CAST(ConditionDate AS TIMESTAMP) AS condition_date
  FROM `ext_mssql_asset_vision_vnz_gen7`.dbo.asset
  WHERE COALESCE(Deleted, false) = false
),
loc_by_asset AS (
  
SELECT
  CAST(AssetID AS STRING) AS asset_id,
  COUNT(*) AS location_rows,
  MAX(CASE WHEN WKT IS NOT NULL AND TRIM(CAST(WKT AS STRING)) <> '' THEN 1 ELSE 0 END) AS has_wkt,
  MAX(CASE
    WHEN CAST(regexp_extract(WKT, '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)', 1) AS DOUBLE) BETWEEN 112 AND 180
     AND CAST(regexp_extract(WKT, '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)', 2) AS DOUBLE) BETWEEN -48 AND -9
    THEN 1 ELSE 0 END) AS has_valid_au_coord,
  concat_ws('; ', sort_array(collect_set(NULLIF(upper(regexp_extract(TRIM(CAST(WKT AS STRING)), '^([A-Za-z]+)', 1)), '')))) AS wkt_geometry_types
FROM `ext_mssql_asset_vision_vnz_gen7`.dbo.vassetlocation
WHERE COALESCE(Deleted, false) = false
GROUP BY CAST(AssetID AS STRING)

),
assetattribute AS (
  
SELECT
  CAST(AssetID AS STRING) AS asset_id,
  NULLIF(TRIM(CAST(Name AS STRING)), '') AS attribute_name,
  NULLIF(TRIM(CAST(Value AS STRING)), '') AS attribute_value
FROM `ext_mssql_asset_vision_vnz_gen7`.dbo.assetattribute
WHERE COALESCE(Deleted, false) = false

),
job_base AS (
  
SELECT
  CAST(ID AS STRING) AS job_id,
  CAST(AssetID AS STRING) AS asset_id,
  CAST(DueDate AS TIMESTAMP) AS due_date,
  CAST(CompletedDate AS TIMESTAMP) AS completed_date
FROM `ext_mssql_asset_vision_vnz_gen7`.dbo.job
WHERE COALESCE(Deleted, false) = false

),
jobasset_base AS (
  
SELECT
  CAST(JobID AS STRING) AS job_id,
  CAST(AssetID AS STRING) AS asset_id
FROM `ext_mssql_asset_vision_vnz_gen7`.dbo.jobasset
WHERE COALESCE(Deleted, false) = false

),
job_link AS (
  SELECT job_id, asset_id, due_date, completed_date
  FROM job_base
  WHERE asset_id IS NOT NULL
  UNION
  SELECT ja.job_id, ja.asset_id, j.due_date, j.completed_date
  FROM jobasset_base ja
  LEFT JOIN job_base j
    ON j.job_id = ja.job_id
  WHERE ja.asset_id IS NOT NULL
),
inspection_base AS (
  
SELECT
  CAST(ID AS STRING) AS inspection_id,
  CAST(AssetID AS STRING) AS asset_id,
  CAST(COALESCE(ScheduledDateTo, ScheduledDate) AS TIMESTAMP) AS due_date,
  CAST(CompletedDate AS TIMESTAMP) AS completed_date
FROM `ext_mssql_asset_vision_vnz_gen7`.dbo.inspection
WHERE COALESCE(Deleted, false) = false

),
capitalwork_base AS (
  
SELECT
  CAST(ID AS STRING) AS capitalwork_id,
  CAST(AssetID AS STRING) AS asset_id,
  CAST(PlannedStart AS TIMESTAMP) AS planned_start,
  CAST(ActualFinish AS TIMESTAMP) AS actual_finish
FROM `ext_mssql_asset_vision_vnz_gen7`.dbo.capitalwork
WHERE COALESCE(Deleted, false) = false

),
photo_base AS (
  
SELECT
  CAST(ID AS STRING) AS photo_id,
  lower(TRIM(CAST(SourceTable AS STRING))) AS source_table,
  CAST(SourceTableID AS STRING) AS source_table_id
FROM `ext_mssql_asset_vision_vnz_gen7`.dbo.photo
WHERE COALESCE(Deleted, false) = false

),
asset_rollup AS (
  SELECT
    source_context,
    contract,
    raw_asset_type,
    COUNT(DISTINCT asset_id) AS asset_count,
    SUM(CASE WHEN classification IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_classification,
    COUNT(DISTINCT classification) AS distinct_classifications,
    concat_ws('; ', sort_array(collect_set(classification))) AS classification_examples,
    concat_ws('; ', sort_array(collect_set(spatial_type))) AS spatial_type_examples,
    SUM(CASE WHEN asset_condition IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_condition,
    SUM(CASE WHEN asset_criticality IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_criticality,
    SUM(CASE WHEN asset_risk IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_risk,
    SUM(CASE WHEN chainage_from IS NOT NULL OR chainage_to IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_chainage,
    SUM(CASE WHEN parent_asset_id IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_parent_asset,
    SUM(CASE WHEN stage IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_stage,
    SUM(CASE WHEN construction_date IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_construction_date,
    SUM(CASE WHEN construction_cost IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_construction_cost,
    SUM(CASE WHEN useful_life IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_useful_life,
    SUM(CASE WHEN condition_date IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_condition_date,
    ROUND(SUM(CASE
      WHEN chainage_from IS NOT NULL
       AND chainage_to IS NOT NULL
       AND ABS(chainage_to - chainage_from) > 0
       AND ABS(chainage_to - chainage_from) < 1000000
      THEN ABS(chainage_to - chainage_from) / 1000.0 ELSE 0 END), 3) AS chainage_length_km_proxy
  FROM asset_base
  GROUP BY source_context, contract, raw_asset_type
),
location_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    SUM(CASE WHEN COALESCE(l.location_rows, 0) > 0 THEN 1 ELSE 0 END) AS assets_with_location_row,
    SUM(CASE WHEN COALESCE(l.has_wkt, 0) > 0 THEN 1 ELSE 0 END) AS assets_with_wkt,
    SUM(CASE WHEN COALESCE(l.has_valid_au_coord, 0) > 0 THEN 1 ELSE 0 END) AS assets_with_valid_au_coord,
    SUM(COALESCE(l.location_rows, 0)) AS location_rows,
    concat_ws('; ', sort_array(collect_set(l.wkt_geometry_types))) AS wkt_geometry_types
  FROM asset_base a
  LEFT JOIN loc_by_asset l
    ON l.asset_id = a.asset_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
attribute_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    COUNT(aa.attribute_name) AS attribute_rows,
    COUNT(DISTINCT aa.attribute_name) AS distinct_attribute_names,
    COUNT(DISTINCT CASE WHEN aa.attribute_name IS NOT NULL THEN a.asset_id END) AS assets_with_attributes,
    concat_ws('; ', sort_array(collect_set(aa.attribute_name))) AS attribute_name_examples
  FROM asset_base a
  LEFT JOIN assetattribute aa
    ON aa.asset_id = a.asset_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
job_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    COUNT(DISTINCT jl.job_id) AS job_count,
    COUNT(DISTINCT CASE WHEN jl.job_id IS NOT NULL THEN a.asset_id END) AS assets_with_job,
    COUNT(DISTINCT CASE WHEN jl.completed_date IS NOT NULL THEN jl.job_id END) AS completed_job_count,
    COUNT(DISTINCT CASE WHEN jl.completed_date IS NULL AND jl.due_date < current_timestamp() THEN jl.job_id END) AS overdue_open_job_count
  FROM asset_base a
  LEFT JOIN job_link jl
    ON jl.asset_id = a.asset_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
inspection_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    COUNT(DISTINCT i.inspection_id) AS inspection_count,
    COUNT(DISTINCT CASE WHEN i.inspection_id IS NOT NULL THEN a.asset_id END) AS assets_with_inspection,
    COUNT(DISTINCT CASE WHEN i.completed_date IS NOT NULL THEN i.inspection_id END) AS completed_inspection_count,
    COUNT(DISTINCT CASE WHEN i.completed_date IS NULL AND i.due_date < current_timestamp() THEN i.inspection_id END) AS overdue_open_inspection_count
  FROM asset_base a
  LEFT JOIN inspection_base i
    ON i.asset_id = a.asset_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
capitalwork_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    COUNT(DISTINCT c.capitalwork_id) AS capitalwork_count,
    COUNT(DISTINCT CASE WHEN c.capitalwork_id IS NOT NULL THEN a.asset_id END) AS assets_with_capitalwork,
    COUNT(DISTINCT CASE WHEN c.actual_finish IS NOT NULL THEN c.capitalwork_id END) AS completed_capitalwork_count
  FROM asset_base a
  LEFT JOIN capitalwork_base c
    ON c.asset_id = a.asset_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
asset_photo_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    COUNT(DISTINCT p.photo_id) AS asset_photo_count,
    COUNT(DISTINCT CASE WHEN p.photo_id IS NOT NULL THEN a.asset_id END) AS assets_with_asset_photo
  FROM asset_base a
  LEFT JOIN photo_base p
    ON p.source_table = 'asset'
   AND p.source_table_id = a.asset_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
job_photo_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    COUNT(DISTINCT p.photo_id) AS job_photo_count,
    COUNT(DISTINCT CASE WHEN p.photo_id IS NOT NULL THEN a.asset_id END) AS assets_with_job_photo
  FROM asset_base a
  LEFT JOIN job_link jl
    ON jl.asset_id = a.asset_id
  LEFT JOIN photo_base p
    ON p.source_table = 'job'
   AND p.source_table_id = jl.job_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
)
SELECT
  ar.*,
  lr.assets_with_location_row,
  lr.assets_with_wkt,
  lr.assets_with_valid_au_coord,
  lr.location_rows,
  lr.wkt_geometry_types,
  atr.attribute_rows,
  atr.distinct_attribute_names,
  atr.assets_with_attributes,
  atr.attribute_name_examples,
  jr.job_count,
  jr.assets_with_job,
  jr.completed_job_count,
  jr.overdue_open_job_count,
  ir.inspection_count,
  ir.assets_with_inspection,
  ir.completed_inspection_count,
  ir.overdue_open_inspection_count,
  cr.capitalwork_count,
  cr.assets_with_capitalwork,
  cr.completed_capitalwork_count,
  apr.asset_photo_count,
  apr.assets_with_asset_photo,
  jpr.job_photo_count,
  jpr.assets_with_job_photo
FROM asset_rollup ar
LEFT JOIN location_rollup lr USING (source_context, contract, raw_asset_type)
LEFT JOIN attribute_rollup atr USING (source_context, contract, raw_asset_type)
LEFT JOIN job_rollup jr USING (source_context, contract, raw_asset_type)
LEFT JOIN inspection_rollup ir USING (source_context, contract, raw_asset_type)
LEFT JOIN capitalwork_rollup cr USING (source_context, contract, raw_asset_type)
LEFT JOIN asset_photo_rollup apr USING (source_context, contract, raw_asset_type)
LEFT JOIN job_photo_rollup jpr USING (source_context, contract, raw_asset_type)
ORDER BY ar.contract, ar.raw_asset_type


-- asset_vision_vsm_gen7

WITH asset_base AS (
  SELECT
    'asset_vision_vsm_gen7' AS source_context,
    CAST(ID AS STRING) AS asset_id,
    COALESCE(NULLIF(TRIM(CAST(Contract AS STRING)), ''), 'asset_vision_vsm_gen7') AS contract,
    COALESCE(NULLIF(TRIM(CAST(AssetType AS STRING)), ''), 'Unspecified asset type') AS raw_asset_type,
    NULLIF(TRIM(CAST(Classification AS STRING)), '') AS classification,
    NULLIF(TRIM(CAST(SpatialType AS STRING)), '') AS spatial_type,
    NULLIF(TRIM(CAST(AssetCondition AS STRING)), '') AS asset_condition,
    NULLIF(TRIM(CAST(AssetCriticality AS STRING)), '') AS asset_criticality,
    NULLIF(TRIM(CAST(AssetRisk AS STRING)), '') AS asset_risk,
    CAST(ChainageFrom AS DOUBLE) AS chainage_from,
    CAST(ChainageTo AS DOUBLE) AS chainage_to,
    CAST(ParentAssetID AS STRING) AS parent_asset_id,
    NULLIF(TRIM(CAST(Stage AS STRING)), '') AS stage,
    CAST(ConstructionDate AS TIMESTAMP) AS construction_date,
    CAST(ConstructionCost AS DOUBLE) AS construction_cost,
    CAST(UsefulLife AS DOUBLE) AS useful_life,
    CAST(ConditionDate AS TIMESTAMP) AS condition_date
  FROM `ext_mssql_asset_vision_vsm_gen7`.dbo.asset
  WHERE COALESCE(Deleted, false) = false
),
loc_by_asset AS (
  
SELECT
  CAST(AssetID AS STRING) AS asset_id,
  COUNT(*) AS location_rows,
  MAX(CASE WHEN WKT IS NOT NULL AND TRIM(CAST(WKT AS STRING)) <> '' THEN 1 ELSE 0 END) AS has_wkt,
  MAX(CASE
    WHEN CAST(regexp_extract(WKT, '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)', 1) AS DOUBLE) BETWEEN 112 AND 180
     AND CAST(regexp_extract(WKT, '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)', 2) AS DOUBLE) BETWEEN -48 AND -9
    THEN 1 ELSE 0 END) AS has_valid_au_coord,
  concat_ws('; ', sort_array(collect_set(NULLIF(upper(regexp_extract(TRIM(CAST(WKT AS STRING)), '^([A-Za-z]+)', 1)), '')))) AS wkt_geometry_types
FROM `ext_mssql_asset_vision_vsm_gen7`.dbo.vassetlocation
WHERE COALESCE(Deleted, false) = false
GROUP BY CAST(AssetID AS STRING)

),
assetattribute AS (
  
SELECT
  CAST(AssetID AS STRING) AS asset_id,
  NULLIF(TRIM(CAST(Name AS STRING)), '') AS attribute_name,
  NULLIF(TRIM(CAST(Value AS STRING)), '') AS attribute_value
FROM `ext_mssql_asset_vision_vsm_gen7`.dbo.assetattribute
WHERE COALESCE(Deleted, false) = false

),
job_base AS (
  
SELECT
  CAST(ID AS STRING) AS job_id,
  CAST(AssetID AS STRING) AS asset_id,
  CAST(DueDate AS TIMESTAMP) AS due_date,
  CAST(CompletedDate AS TIMESTAMP) AS completed_date
FROM `ext_mssql_asset_vision_vsm_gen7`.dbo.job
WHERE COALESCE(Deleted, false) = false

),
jobasset_base AS (
  
SELECT
  CAST(JobID AS STRING) AS job_id,
  CAST(AssetID AS STRING) AS asset_id
FROM `ext_mssql_asset_vision_vsm_gen7`.dbo.jobasset
WHERE COALESCE(Deleted, false) = false

),
job_link AS (
  SELECT job_id, asset_id, due_date, completed_date
  FROM job_base
  WHERE asset_id IS NOT NULL
  UNION
  SELECT ja.job_id, ja.asset_id, j.due_date, j.completed_date
  FROM jobasset_base ja
  LEFT JOIN job_base j
    ON j.job_id = ja.job_id
  WHERE ja.asset_id IS NOT NULL
),
inspection_base AS (
  
SELECT
  CAST(ID AS STRING) AS inspection_id,
  CAST(AssetID AS STRING) AS asset_id,
  CAST(COALESCE(ScheduledDateTo, ScheduledDate) AS TIMESTAMP) AS due_date,
  CAST(CompletedDate AS TIMESTAMP) AS completed_date
FROM `ext_mssql_asset_vision_vsm_gen7`.dbo.inspection
WHERE COALESCE(Deleted, false) = false

),
capitalwork_base AS (
  
SELECT
  CAST(ID AS STRING) AS capitalwork_id,
  CAST(AssetID AS STRING) AS asset_id,
  CAST(PlannedStart AS TIMESTAMP) AS planned_start,
  CAST(ActualFinish AS TIMESTAMP) AS actual_finish
FROM `ext_mssql_asset_vision_vsm_gen7`.dbo.capitalwork
WHERE COALESCE(Deleted, false) = false

),
photo_base AS (
  
SELECT
  CAST(ID AS STRING) AS photo_id,
  lower(TRIM(CAST(SourceTable AS STRING))) AS source_table,
  CAST(SourceTableID AS STRING) AS source_table_id
FROM `ext_mssql_asset_vision_vsm_gen7`.dbo.photo
WHERE COALESCE(Deleted, false) = false

),
asset_rollup AS (
  SELECT
    source_context,
    contract,
    raw_asset_type,
    COUNT(DISTINCT asset_id) AS asset_count,
    SUM(CASE WHEN classification IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_classification,
    COUNT(DISTINCT classification) AS distinct_classifications,
    concat_ws('; ', sort_array(collect_set(classification))) AS classification_examples,
    concat_ws('; ', sort_array(collect_set(spatial_type))) AS spatial_type_examples,
    SUM(CASE WHEN asset_condition IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_condition,
    SUM(CASE WHEN asset_criticality IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_criticality,
    SUM(CASE WHEN asset_risk IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_risk,
    SUM(CASE WHEN chainage_from IS NOT NULL OR chainage_to IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_chainage,
    SUM(CASE WHEN parent_asset_id IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_parent_asset,
    SUM(CASE WHEN stage IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_stage,
    SUM(CASE WHEN construction_date IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_construction_date,
    SUM(CASE WHEN construction_cost IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_construction_cost,
    SUM(CASE WHEN useful_life IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_useful_life,
    SUM(CASE WHEN condition_date IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_condition_date,
    ROUND(SUM(CASE
      WHEN chainage_from IS NOT NULL
       AND chainage_to IS NOT NULL
       AND ABS(chainage_to - chainage_from) > 0
       AND ABS(chainage_to - chainage_from) < 1000000
      THEN ABS(chainage_to - chainage_from) / 1000.0 ELSE 0 END), 3) AS chainage_length_km_proxy
  FROM asset_base
  GROUP BY source_context, contract, raw_asset_type
),
location_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    SUM(CASE WHEN COALESCE(l.location_rows, 0) > 0 THEN 1 ELSE 0 END) AS assets_with_location_row,
    SUM(CASE WHEN COALESCE(l.has_wkt, 0) > 0 THEN 1 ELSE 0 END) AS assets_with_wkt,
    SUM(CASE WHEN COALESCE(l.has_valid_au_coord, 0) > 0 THEN 1 ELSE 0 END) AS assets_with_valid_au_coord,
    SUM(COALESCE(l.location_rows, 0)) AS location_rows,
    concat_ws('; ', sort_array(collect_set(l.wkt_geometry_types))) AS wkt_geometry_types
  FROM asset_base a
  LEFT JOIN loc_by_asset l
    ON l.asset_id = a.asset_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
attribute_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    COUNT(aa.attribute_name) AS attribute_rows,
    COUNT(DISTINCT aa.attribute_name) AS distinct_attribute_names,
    COUNT(DISTINCT CASE WHEN aa.attribute_name IS NOT NULL THEN a.asset_id END) AS assets_with_attributes,
    concat_ws('; ', sort_array(collect_set(aa.attribute_name))) AS attribute_name_examples
  FROM asset_base a
  LEFT JOIN assetattribute aa
    ON aa.asset_id = a.asset_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
job_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    COUNT(DISTINCT jl.job_id) AS job_count,
    COUNT(DISTINCT CASE WHEN jl.job_id IS NOT NULL THEN a.asset_id END) AS assets_with_job,
    COUNT(DISTINCT CASE WHEN jl.completed_date IS NOT NULL THEN jl.job_id END) AS completed_job_count,
    COUNT(DISTINCT CASE WHEN jl.completed_date IS NULL AND jl.due_date < current_timestamp() THEN jl.job_id END) AS overdue_open_job_count
  FROM asset_base a
  LEFT JOIN job_link jl
    ON jl.asset_id = a.asset_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
inspection_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    COUNT(DISTINCT i.inspection_id) AS inspection_count,
    COUNT(DISTINCT CASE WHEN i.inspection_id IS NOT NULL THEN a.asset_id END) AS assets_with_inspection,
    COUNT(DISTINCT CASE WHEN i.completed_date IS NOT NULL THEN i.inspection_id END) AS completed_inspection_count,
    COUNT(DISTINCT CASE WHEN i.completed_date IS NULL AND i.due_date < current_timestamp() THEN i.inspection_id END) AS overdue_open_inspection_count
  FROM asset_base a
  LEFT JOIN inspection_base i
    ON i.asset_id = a.asset_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
capitalwork_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    COUNT(DISTINCT c.capitalwork_id) AS capitalwork_count,
    COUNT(DISTINCT CASE WHEN c.capitalwork_id IS NOT NULL THEN a.asset_id END) AS assets_with_capitalwork,
    COUNT(DISTINCT CASE WHEN c.actual_finish IS NOT NULL THEN c.capitalwork_id END) AS completed_capitalwork_count
  FROM asset_base a
  LEFT JOIN capitalwork_base c
    ON c.asset_id = a.asset_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
asset_photo_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    COUNT(DISTINCT p.photo_id) AS asset_photo_count,
    COUNT(DISTINCT CASE WHEN p.photo_id IS NOT NULL THEN a.asset_id END) AS assets_with_asset_photo
  FROM asset_base a
  LEFT JOIN photo_base p
    ON p.source_table = 'asset'
   AND p.source_table_id = a.asset_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
job_photo_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    COUNT(DISTINCT p.photo_id) AS job_photo_count,
    COUNT(DISTINCT CASE WHEN p.photo_id IS NOT NULL THEN a.asset_id END) AS assets_with_job_photo
  FROM asset_base a
  LEFT JOIN job_link jl
    ON jl.asset_id = a.asset_id
  LEFT JOIN photo_base p
    ON p.source_table = 'job'
   AND p.source_table_id = jl.job_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
)
SELECT
  ar.*,
  lr.assets_with_location_row,
  lr.assets_with_wkt,
  lr.assets_with_valid_au_coord,
  lr.location_rows,
  lr.wkt_geometry_types,
  atr.attribute_rows,
  atr.distinct_attribute_names,
  atr.assets_with_attributes,
  atr.attribute_name_examples,
  jr.job_count,
  jr.assets_with_job,
  jr.completed_job_count,
  jr.overdue_open_job_count,
  ir.inspection_count,
  ir.assets_with_inspection,
  ir.completed_inspection_count,
  ir.overdue_open_inspection_count,
  cr.capitalwork_count,
  cr.assets_with_capitalwork,
  cr.completed_capitalwork_count,
  apr.asset_photo_count,
  apr.assets_with_asset_photo,
  jpr.job_photo_count,
  jpr.assets_with_job_photo
FROM asset_rollup ar
LEFT JOIN location_rollup lr USING (source_context, contract, raw_asset_type)
LEFT JOIN attribute_rollup atr USING (source_context, contract, raw_asset_type)
LEFT JOIN job_rollup jr USING (source_context, contract, raw_asset_type)
LEFT JOIN inspection_rollup ir USING (source_context, contract, raw_asset_type)
LEFT JOIN capitalwork_rollup cr USING (source_context, contract, raw_asset_type)
LEFT JOIN asset_photo_rollup apr USING (source_context, contract, raw_asset_type)
LEFT JOIN job_photo_rollup jpr USING (source_context, contract, raw_asset_type)
ORDER BY ar.contract, ar.raw_asset_type
