WITH source_rows AS (
  SELECT 'ext_mssql_asset_vision_ven_gen7' AS catalog_name, 'timesheetitem' AS table_name,
         LOWER(CAST(SourceTable AS STRING)) AS source_table, CAST(SourceTableID AS BIGINT) AS source_table_id,
         CAST(Hours AS DOUBLE) AS hours, CAST(Minutes AS DOUBLE) AS minutes,
         CAST(Quantity AS DOUBLE) AS quantity, CAST(Cost AS DOUBLE) AS cost,
         CAST(ResourceType AS STRING) AS resource_type, COALESCE(Deleted, false) AS deleted
  FROM ext_mssql_asset_vision_ven_gen7.dbo.timesheetitem
  UNION ALL
  SELECT 'ext_mssql_asset_vision_ven_rms', 'timesheetitem',
         LOWER(CAST(SourceTable AS STRING)), CAST(SourceTableID AS BIGINT),
         CAST(Hours AS DOUBLE), CAST(Minutes AS DOUBLE), CAST(Quantity AS DOUBLE), CAST(Cost AS DOUBLE),
         CAST(ResourceType AS STRING), COALESCE(Deleted, false)
  FROM ext_mssql_asset_vision_ven_rms.dbo.timesheetitem
  UNION ALL
  SELECT 'ext_mssql_asset_vision_ven_vicroads', 'timesheetitem',
         LOWER(CAST(SourceTable AS STRING)), CAST(SourceTableID AS BIGINT),
         CAST(Hours AS DOUBLE), CAST(Minutes AS DOUBLE), CAST(Quantity AS DOUBLE), CAST(Cost AS DOUBLE),
         CAST(ResourceType AS STRING), COALESCE(Deleted, false)
  FROM ext_mssql_asset_vision_ven_vicroads.dbo.TimesheetItem
  UNION ALL
  SELECT 'ext_mssql_asset_vision_vns_gen7', 'timesheetitem',
         LOWER(CAST(SourceTable AS STRING)), CAST(SourceTableID AS BIGINT),
         CAST(Hours AS DOUBLE), CAST(Minutes AS DOUBLE), CAST(Quantity AS DOUBLE), CAST(Cost AS DOUBLE),
         CAST(ResourceType AS STRING), COALESCE(Deleted, false)
  FROM ext_mssql_asset_vision_vns_gen7.dbo.timesheetitem
  UNION ALL
  SELECT 'ext_mssql_asset_vision_vnz_gen7', 'timesheetitem',
         LOWER(CAST(SourceTable AS STRING)), CAST(SourceTableID AS BIGINT),
         CAST(Hours AS DOUBLE), CAST(Minutes AS DOUBLE), CAST(Quantity AS DOUBLE), CAST(Cost AS DOUBLE),
         CAST(ResourceType AS STRING), COALESCE(Deleted, false)
  FROM ext_mssql_asset_vision_vnz_gen7.dbo.timesheetitem
  UNION ALL
  SELECT 'ext_mssql_asset_vision_vsm_gen7', 'timesheetitem',
         LOWER(CAST(SourceTable AS STRING)), CAST(SourceTableID AS BIGINT),
         CAST(Hours AS DOUBLE), CAST(Minutes AS DOUBLE), CAST(Quantity AS DOUBLE), CAST(Cost AS DOUBLE),
         CAST(ResourceType AS STRING), COALESCE(Deleted, false)
  FROM ext_mssql_asset_vision_vsm_gen7.dbo.timesheetitem

  UNION ALL

  SELECT 'ext_mssql_asset_vision_ven_gen7', 'plannedresourceitem',
         LOWER(CAST(SourceTable AS STRING)), CAST(SourceTableID AS BIGINT),
         CAST(Hours AS DOUBLE), CAST(Minutes AS DOUBLE), CAST(Quantity AS DOUBLE), CAST(Cost AS DOUBLE),
         CAST(ResourceType AS STRING), COALESCE(Deleted, false)
  FROM ext_mssql_asset_vision_ven_gen7.dbo.plannedresourceitem
  UNION ALL
  SELECT 'ext_mssql_asset_vision_ven_rms', 'plannedresourceitem',
         LOWER(CAST(SourceTable AS STRING)), CAST(SourceTableID AS BIGINT),
         CAST(Hours AS DOUBLE), CAST(Minutes AS DOUBLE), CAST(Quantity AS DOUBLE), CAST(Cost AS DOUBLE),
         CAST(ResourceType AS STRING), COALESCE(Deleted, false)
  FROM ext_mssql_asset_vision_ven_rms.dbo.plannedresourceitem
  UNION ALL
  SELECT 'ext_mssql_asset_vision_ven_vicroads', 'plannedresourceitem',
         LOWER(CAST(SourceTable AS STRING)), CAST(SourceTableID AS BIGINT),
         CAST(Hours AS DOUBLE), CAST(Minutes AS DOUBLE), CAST(Quantity AS DOUBLE), CAST(Cost AS DOUBLE),
         CAST(ResourceType AS STRING), COALESCE(Deleted, false)
  FROM ext_mssql_asset_vision_ven_vicroads.dbo.PlannedResourceItem
  UNION ALL
  SELECT 'ext_mssql_asset_vision_vns_gen7', 'plannedresourceitem',
         LOWER(CAST(SourceTable AS STRING)), CAST(SourceTableID AS BIGINT),
         CAST(Hours AS DOUBLE), CAST(Minutes AS DOUBLE), CAST(Quantity AS DOUBLE), CAST(Cost AS DOUBLE),
         CAST(ResourceType AS STRING), COALESCE(Deleted, false)
  FROM ext_mssql_asset_vision_vns_gen7.dbo.plannedresourceitem
  UNION ALL
  SELECT 'ext_mssql_asset_vision_vnz_gen7', 'plannedresourceitem',
         LOWER(CAST(SourceTable AS STRING)), CAST(SourceTableID AS BIGINT),
         CAST(Hours AS DOUBLE), CAST(Minutes AS DOUBLE), CAST(Quantity AS DOUBLE), CAST(Cost AS DOUBLE),
         CAST(ResourceType AS STRING), COALESCE(Deleted, false)
  FROM ext_mssql_asset_vision_vnz_gen7.dbo.plannedresourceitem
  UNION ALL
  SELECT 'ext_mssql_asset_vision_vsm_gen7', 'plannedresourceitem',
         LOWER(CAST(SourceTable AS STRING)), CAST(SourceTableID AS BIGINT),
         CAST(Hours AS DOUBLE), CAST(Minutes AS DOUBLE), CAST(Quantity AS DOUBLE), CAST(Cost AS DOUBLE),
         CAST(ResourceType AS STRING), COALESCE(Deleted, false)
  FROM ext_mssql_asset_vision_vsm_gen7.dbo.plannedresourceitem
),
active_rows AS (
  SELECT *,
         COALESCE(hours, 0) + COALESCE(minutes, 0) / 60.0 AS duration_hours,
         CASE
           WHEN COALESCE(hours, 0) + COALESCE(minutes, 0) / 60.0 > 0
             THEN cost / (COALESCE(hours, 0) + COALESCE(minutes, 0) / 60.0)
           ELSE NULL
         END AS cost_per_hour
  FROM source_rows
  WHERE deleted = false
)
SELECT
  catalog_name,
  table_name,
  COUNT(*) AS row_count,
  COUNT_IF(source_table = 'job' AND source_table_id IS NOT NULL) AS job_linked_rows,
  COUNT(DISTINCT CASE WHEN source_table = 'job' THEN source_table_id END) AS distinct_job_ids,
  COUNT_IF(cost IS NOT NULL) AS rows_with_cost,
  COUNT_IF(cost IS NULL) AS rows_cost_null,
  COUNT_IF(cost = 0) AS rows_cost_zero,
  COUNT_IF(cost < 0) AS rows_cost_negative,
  COUNT_IF(cost > 0) AS rows_cost_positive,
  COUNT_IF(duration_hours > 0) AS rows_with_duration,
  COUNT_IF(cost > 0 AND duration_hours <= 0 AND COALESCE(quantity, 0) <= 0) AS positive_cost_without_duration_or_quantity,
  ROUND(SUM(cost), 2) AS total_cost,
  ROUND(AVG(cost), 2) AS avg_cost,
  ROUND(PERCENTILE_APPROX(cost, 0.5), 2) AS p50_cost,
  ROUND(PERCENTILE_APPROX(cost, 0.9), 2) AS p90_cost,
  ROUND(PERCENTILE_APPROX(cost, 0.99), 2) AS p99_cost,
  ROUND(MAX(cost), 2) AS max_cost,
  ROUND(PERCENTILE_APPROX(cost_per_hour, 0.5), 2) AS p50_cost_per_hour,
  ROUND(PERCENTILE_APPROX(cost_per_hour, 0.9), 2) AS p90_cost_per_hour,
  ROUND(PERCENTILE_APPROX(cost_per_hour, 0.99), 2) AS p99_cost_per_hour,
  ROUND(MAX(cost_per_hour), 2) AS max_cost_per_hour,
  COUNT_IF(minutes < 0 OR minutes >= 60) AS rows_minutes_outside_0_59
FROM active_rows
GROUP BY catalog_name, table_name
ORDER BY catalog_name, table_name;
