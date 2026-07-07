SELECT
  'transport.utbl_job_costing_timesheets_all_contracts' AS table_name,
  Contract,
  AV_Database,
  COUNT(*) AS row_count,
  COUNT_IF(ResourceRate IS NOT NULL) AS rows_with_resource_rate,
  COUNT_IF(ResourceRate > 0) AS rows_positive_resource_rate,
  COUNT_IF(ResourceCost IS NOT NULL) AS rows_with_resource_cost,
  COUNT_IF(ResourceCost > 0) AS rows_positive_resource_cost,
  COUNT_IF(TotalDurationInDecimal > 0) AS rows_with_total_duration,
  COUNT_IF(TotalDurationInDecimal > 0 AND ResourceRate > 0) AS rows_can_calc_duration_x_rate,
  ROUND(PERCENTILE_APPROX(ResourceRate, 0.5), 2) AS p50_resource_rate,
  ROUND(PERCENTILE_APPROX(ResourceRate, 0.9), 2) AS p90_resource_rate,
  ROUND(PERCENTILE_APPROX(TotalDurationInDecimal * ResourceRate, 0.5), 2) AS p50_calc_cost,
  ROUND(PERCENTILE_APPROX(TotalDurationInDecimal * ResourceRate, 0.9), 2) AS p90_calc_cost
FROM transport_dev.transport.utbl_job_costing_timesheets_all_contracts
GROUP BY Contract, AV_Database

UNION ALL

SELECT
  'transport.utbl_timesheetitem_jobs_allcontract' AS table_name,
  CAST(NULL AS STRING) AS Contract,
  source_database_name AS AV_Database,
  COUNT(*) AS row_count,
  CAST(NULL AS BIGINT) AS rows_with_resource_rate,
  CAST(NULL AS BIGINT) AS rows_positive_resource_rate,
  COUNT_IF(Cost IS NOT NULL) AS rows_with_resource_cost,
  COUNT_IF(Cost > 0) AS rows_positive_resource_cost,
  COUNT_IF((COALESCE(Hours, 0) + COALESCE(Minutes, 0) / 60.0) > 0) AS rows_with_total_duration,
  CAST(NULL AS BIGINT) AS rows_can_calc_duration_x_rate,
  CAST(NULL AS DOUBLE) AS p50_resource_rate,
  CAST(NULL AS DOUBLE) AS p90_resource_rate,
  ROUND(PERCENTILE_APPROX(Cost, 0.5), 2) AS p50_calc_cost,
  ROUND(PERCENTILE_APPROX(Cost, 0.9), 2) AS p90_calc_cost
FROM transport_dev.transport.utbl_timesheetitem_jobs_allcontract
GROUP BY source_database_name
ORDER BY table_name, Contract, AV_Database;
