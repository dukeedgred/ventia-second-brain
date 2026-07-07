WITH costing AS (
  SELECT
    Contract,
    AV_Database,
    CAST(MergedJobID AS BIGINT) AS job_id,
    CAST(ResourceCost AS DOUBLE) AS resource_cost,
    CAST(ResourceRate AS DOUBLE) AS resource_rate,
    CAST(TotalDurationInDecimal AS DOUBLE) AS duration_hours,
    CAST(Quantity AS DOUBLE) AS quantity,
    CAST(ResourceType AS STRING) AS resource_type,
    CAST(SAP_Record_Exists AS STRING) AS sap_record_exists
  FROM transport_dev.transport.utbl_job_costing_timesheets_all_contracts
)
SELECT
  Contract,
  AV_Database,
  COUNT(*) AS row_count,
  COUNT(DISTINCT job_id) AS distinct_job_ids,
  COUNT_IF(resource_cost IS NOT NULL) AS rows_with_resource_cost,
  COUNT_IF(resource_cost > 0) AS rows_positive_resource_cost,
  COUNT_IF(resource_cost = 0) AS rows_zero_resource_cost,
  COUNT_IF(resource_cost < 0) AS rows_negative_resource_cost,
  COUNT_IF(duration_hours > 0) AS rows_with_duration,
  COUNT_IF(resource_cost > 0 AND duration_hours <= 0 AND COALESCE(quantity, 0) <= 0) AS positive_cost_without_duration_or_quantity,
  COUNT_IF(UPPER(COALESCE(sap_record_exists, '')) IN ('Y', 'YES', 'TRUE', '1')) AS rows_with_sap_record,
  ROUND(SUM(resource_cost), 2) AS total_resource_cost,
  ROUND(AVG(resource_cost), 2) AS avg_resource_cost,
  ROUND(PERCENTILE_APPROX(resource_cost, 0.5), 2) AS p50_resource_cost,
  ROUND(PERCENTILE_APPROX(resource_cost, 0.9), 2) AS p90_resource_cost,
  ROUND(PERCENTILE_APPROX(resource_cost, 0.99), 2) AS p99_resource_cost,
  ROUND(MAX(resource_cost), 2) AS max_resource_cost,
  ROUND(PERCENTILE_APPROX(CASE WHEN duration_hours > 0 THEN resource_cost / duration_hours END, 0.5), 2) AS p50_cost_per_hour,
  ROUND(PERCENTILE_APPROX(CASE WHEN duration_hours > 0 THEN resource_cost / duration_hours END, 0.9), 2) AS p90_cost_per_hour,
  ROUND(PERCENTILE_APPROX(CASE WHEN duration_hours > 0 THEN resource_cost / duration_hours END, 0.99), 2) AS p99_cost_per_hour,
  ROUND(MAX(CASE WHEN duration_hours > 0 THEN resource_cost / duration_hours END), 2) AS max_cost_per_hour
FROM costing
GROUP BY Contract, AV_Database
ORDER BY Contract, AV_Database;
