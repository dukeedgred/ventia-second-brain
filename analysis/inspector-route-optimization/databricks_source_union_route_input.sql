-- Databricks notebook source
-- MAGIC %md
-- MAGIC # Transport Asset Vision Route Input Union
-- MAGIC
-- MAGIC This notebook creates a source-table based union for route optimisation.
-- MAGIC It uses Asset Vision source `vjob` tables directly, not the curated
-- MAGIC `transport_dev.transport_*` views.
-- MAGIC
-- MAGIC Run this first, then run `databricks_contract_route_optimisation.py` with
-- MAGIC `source_table = route_input` if it is in the same notebook/session.
-- MAGIC If the Python optimiser is in a separate notebook/job, use the persisted
-- MAGIC `route_input_table` instead, for example
-- MAGIC `source_table = transport_dev.integ_transport_assets.route_input`.

-- COMMAND ----------

CREATE WIDGET TEXT output_table DEFAULT "transport_dev.integ_transport_assets.asset_vision_route_source_union";
CREATE WIDGET TEXT route_input_table DEFAULT "transport_dev.integ_transport_assets.route_input";
CREATE WIDGET TEXT due_days DEFAULT "60";
CREATE WIDGET TEXT include_completed DEFAULT "false";
CREATE WIDGET TEXT exclude_inspection_id_filter DEFAULT "";
CREATE WIDGET TEXT exclude_job_id_filter DEFAULT "";

-- COMMAND ----------

CREATE OR REPLACE TEMP VIEW asset_vision_route_source_union AS
WITH source_jobs AS (
  SELECT
    'asset_vision_ven_gen7' AS source_context,
    'ext_mssql_asset_vision_ven_gen7' AS source_catalog,
    'RAMC / BAC / PoB / TSRC' AS documented_contract_context,
    CAST(ID AS BIGINT) AS job_id,
    CAST(Contract AS STRING) AS contract,
    CAST(Region AS STRING) AS region,
    CAST(AssetID AS BIGINT) AS asset_id,
    CAST(AssetCode AS STRING) AS asset_code,
    CAST(AssetName AS STRING) AS asset_name,
    CAST(Section AS STRING) AS section,
    CAST(ActivityType AS STRING) AS activity_type,
    CAST(ActivityName AS STRING) AS activity_name,
    CAST(InterventionName AS STRING) AS intervention_name,
    CAST(Priority AS STRING) AS priority_raw,
    CAST(InspectionID AS BIGINT) AS inspection_id,
    CAST(InspectionTypeName AS STRING) AS inspection_type_name,
    CAST(DueDate AS TIMESTAMP) AS due_ts,
    CAST(ScheduledStart AS TIMESTAMP) AS scheduled_start_ts,
    CAST(ScheduledEnd AS TIMESTAMP) AS scheduled_end_ts,
    CAST(CompletedDate AS TIMESTAMP) AS completed_ts,
    CAST(CompletedStatus AS STRING) AS completed_status,
    CAST(AssignedUser AS STRING) AS assigned_user,
    CAST(CurrentWorkflowItemName AS STRING) AS workflow_status,
    CAST(EstimatedDuration AS DOUBLE) AS estimated_duration_minutes,
    CAST(WKT AS STRING) AS wkt
  FROM ext_mssql_asset_vision_ven_gen7.dbo.vjob
  WHERE Deleted = false

  UNION ALL

  SELECT
    'asset_vision_ven_vicroads' AS source_context,
    'ext_mssql_asset_vision_ven_vicroads' AS source_catalog,
    'WRU' AS documented_contract_context,
    CAST(ID AS BIGINT) AS job_id,
    CAST(Contract AS STRING) AS contract,
    CAST(Region AS STRING) AS region,
    CAST(AssetID AS BIGINT) AS asset_id,
    CAST(AssetCode AS STRING) AS asset_code,
    CAST(AssetName AS STRING) AS asset_name,
    CAST(Section AS STRING) AS section,
    CAST(ActivityType AS STRING) AS activity_type,
    CAST(ActivityName AS STRING) AS activity_name,
    CAST(InterventionName AS STRING) AS intervention_name,
    CAST(Priority AS STRING) AS priority_raw,
    CAST(InspectionID AS BIGINT) AS inspection_id,
    CAST(InspectionTypeName AS STRING) AS inspection_type_name,
    CAST(DueDate AS TIMESTAMP) AS due_ts,
    CAST(ScheduledStart AS TIMESTAMP) AS scheduled_start_ts,
    CAST(ScheduledEnd AS TIMESTAMP) AS scheduled_end_ts,
    CAST(CompletedDate AS TIMESTAMP) AS completed_ts,
    CAST(CompletedStatus AS STRING) AS completed_status,
    CAST(AssignedUser AS STRING) AS assigned_user,
    CAST(CurrentWorkflowItemName AS STRING) AS workflow_status,
    CAST(EstimatedDuration AS DOUBLE) AS estimated_duration_minutes,
    CAST(WKT AS STRING) AS wkt
  FROM ext_mssql_asset_vision_ven_vicroads.dbo.vjob
  WHERE Deleted = false

  UNION ALL

  SELECT
    'asset_vision_vns_gen7' AS source_context,
    'ext_mssql_asset_vision_vns_gen7' AS source_catalog,
    'SHT / WHT' AS documented_contract_context,
    CAST(ID AS BIGINT) AS job_id,
    CAST(Contract AS STRING) AS contract,
    CAST(Region AS STRING) AS region,
    CAST(AssetID AS BIGINT) AS asset_id,
    CAST(AssetCode AS STRING) AS asset_code,
    CAST(AssetName AS STRING) AS asset_name,
    CAST(Section AS STRING) AS section,
    CAST(ActivityType AS STRING) AS activity_type,
    CAST(ActivityName AS STRING) AS activity_name,
    CAST(InterventionName AS STRING) AS intervention_name,
    CAST(Priority AS STRING) AS priority_raw,
    CAST(InspectionID AS BIGINT) AS inspection_id,
    CAST(InspectionTypeName AS STRING) AS inspection_type_name,
    CAST(DueDate AS TIMESTAMP) AS due_ts,
    CAST(ScheduledStart AS TIMESTAMP) AS scheduled_start_ts,
    CAST(ScheduledEnd AS TIMESTAMP) AS scheduled_end_ts,
    CAST(CompletedDate AS TIMESTAMP) AS completed_ts,
    CAST(CompletedStatus AS STRING) AS completed_status,
    CAST(AssignedUser AS STRING) AS assigned_user,
    CAST(CurrentWorkflowItemName AS STRING) AS workflow_status,
    CAST(EstimatedDuration AS DOUBLE) AS estimated_duration_minutes,
    CAST(WKT AS STRING) AS wkt
  FROM ext_mssql_asset_vision_vns_gen7.dbo.vjob
  WHERE Deleted = false

  UNION ALL

  SELECT
    'asset_vision_vnz_gen7' AS source_context,
    'ext_mssql_asset_vision_vnz_gen7' AS source_catalog,
    'Auckland West' AS documented_contract_context,
    CAST(ID AS BIGINT) AS job_id,
    CAST(Contract AS STRING) AS contract,
    CAST(Region AS STRING) AS region,
    CAST(AssetID AS BIGINT) AS asset_id,
    CAST(AssetCode AS STRING) AS asset_code,
    CAST(AssetName AS STRING) AS asset_name,
    CAST(Section AS STRING) AS section,
    CAST(ActivityType AS STRING) AS activity_type,
    CAST(ActivityName AS STRING) AS activity_name,
    CAST(InterventionName AS STRING) AS intervention_name,
    CAST(Priority AS STRING) AS priority_raw,
    CAST(InspectionID AS BIGINT) AS inspection_id,
    CAST(InspectionTypeName AS STRING) AS inspection_type_name,
    CAST(DueDate AS TIMESTAMP) AS due_ts,
    CAST(ScheduledStart AS TIMESTAMP) AS scheduled_start_ts,
    CAST(ScheduledEnd AS TIMESTAMP) AS scheduled_end_ts,
    CAST(CompletedDate AS TIMESTAMP) AS completed_ts,
    CAST(CompletedStatus AS STRING) AS completed_status,
    CAST(AssignedUser AS STRING) AS assigned_user,
    CAST(CurrentWorkflowItemName AS STRING) AS workflow_status,
    CAST(EstimatedDuration AS DOUBLE) AS estimated_duration_minutes,
    CAST(WKT AS STRING) AS wkt
  FROM ext_mssql_asset_vision_vnz_gen7.dbo.vjob
  WHERE Deleted = false

  UNION ALL

  SELECT
    'asset_vision_vsm_gen7' AS source_context,
    'ext_mssql_asset_vision_vsm_gen7' AS source_catalog,
    'VentureSmart' AS documented_contract_context,
    CAST(ID AS BIGINT) AS job_id,
    CAST(Contract AS STRING) AS contract,
    CAST(Region AS STRING) AS region,
    CAST(AssetID AS BIGINT) AS asset_id,
    CAST(AssetCode AS STRING) AS asset_code,
    CAST(AssetName AS STRING) AS asset_name,
    CAST(Section AS STRING) AS section,
    CAST(ActivityType AS STRING) AS activity_type,
    CAST(ActivityName AS STRING) AS activity_name,
    CAST(InterventionName AS STRING) AS intervention_name,
    CAST(Priority AS STRING) AS priority_raw,
    CAST(InspectionID AS BIGINT) AS inspection_id,
    CAST(InspectionTypeName AS STRING) AS inspection_type_name,
    CAST(DueDate AS TIMESTAMP) AS due_ts,
    CAST(ScheduledStart AS TIMESTAMP) AS scheduled_start_ts,
    CAST(ScheduledEnd AS TIMESTAMP) AS scheduled_end_ts,
    CAST(CompletedDate AS TIMESTAMP) AS completed_ts,
    CAST(CompletedStatus AS STRING) AS completed_status,
    CAST(AssignedUser AS STRING) AS assigned_user,
    CAST(CurrentWorkflowItemName AS STRING) AS workflow_status,
    CAST(EstimatedDuration AS DOUBLE) AS estimated_duration_minutes,
    CAST(WKT AS STRING) AS wkt
  FROM ext_mssql_asset_vision_vsm_gen7.dbo.vjob
  WHERE Deleted = false
),
normalised AS (
  SELECT
    *,
    TRY_CAST(REGEXP_EXTRACT(wkt, '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)', 2) AS DOUBLE) AS latitude,
    TRY_CAST(REGEXP_EXTRACT(wkt, '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)', 1) AS DOUBLE) AS longitude,
    COALESCE(TRY_CAST(REGEXP_EXTRACT(priority_raw, '(\\d+)', 1) AS INT), 3) AS priority
  FROM source_jobs
  WHERE wkt IS NOT NULL
)
SELECT
  source_context,
  source_catalog,
  documented_contract_context,
  contract,
  region,
  job_id,
  inspection_id,
  asset_id,
  asset_code,
  asset_name,
  section,
  activity_type,
  activity_name,
  intervention_name,
  inspection_type_name,
  priority_raw,
  priority,
  due_ts,
  scheduled_start_ts,
  scheduled_end_ts,
  completed_ts,
  completed_status,
  assigned_user,
  workflow_status,
  estimated_duration_minutes,
  latitude,
  longitude,
  wkt
FROM normalised
WHERE latitude IS NOT NULL
  AND longitude IS NOT NULL
  AND (
    '${exclude_inspection_id_filter}' = ''
    OR inspection_id IS NULL
    OR NOT array_contains(
      split(regexp_replace('${exclude_inspection_id_filter}', '\\s+', ''), ','),
      CAST(inspection_id AS STRING)
    )
  )
  AND (
    '${exclude_job_id_filter}' = ''
    OR job_id IS NULL
    OR NOT array_contains(
      split(regexp_replace('${exclude_job_id_filter}', '\\s+', ''), ','),
      CAST(job_id AS STRING)
    )
  );

-- COMMAND ----------

CREATE OR REPLACE TABLE ${output_table} AS
SELECT *
FROM asset_vision_route_source_union;

-- COMMAND ----------

-- MAGIC %python
-- MAGIC from pyspark.sql import functions as F
-- MAGIC
-- MAGIC MAX_DROPDOWN_CHOICES = 1000
-- MAGIC
-- MAGIC def get_widget_value(name, default=""):
-- MAGIC     try:
-- MAGIC         return dbutils.widgets.get(name)
-- MAGIC     except Exception:
-- MAGIC         return default
-- MAGIC
-- MAGIC def recreate_dropdown(name, selected_value, choices):
-- MAGIC     unique_choices = []
-- MAGIC     seen = set()
-- MAGIC     for choice in [""] + ["" if choice is None else str(choice) for choice in choices]:
-- MAGIC         if choice not in seen:
-- MAGIC             unique_choices.append(choice)
-- MAGIC             seen.add(choice)
-- MAGIC
-- MAGIC     default_value = selected_value if selected_value in unique_choices else ""
-- MAGIC     try:
-- MAGIC         dbutils.widgets.remove(name)
-- MAGIC     except Exception:
-- MAGIC         pass
-- MAGIC     dbutils.widgets.dropdown(name, default_value, unique_choices)
-- MAGIC
-- MAGIC def collect_choices(df, column_name, limit=MAX_DROPDOWN_CHOICES):
-- MAGIC     return [
-- MAGIC         row["value"]
-- MAGIC         for row in (
-- MAGIC             df.select(F.col(column_name).cast("string").alias("value"))
-- MAGIC               .where(F.col("value").isNotNull())
-- MAGIC               .where(F.trim(F.col("value")) != "")
-- MAGIC               .distinct()
-- MAGIC               .orderBy("value")
-- MAGIC               .limit(limit)
-- MAGIC               .collect()
-- MAGIC         )
-- MAGIC     ]
-- MAGIC
-- MAGIC output_table = get_widget_value("output_table", "transport_dev.integ_transport_assets.asset_vision_route_source_union")
-- MAGIC selected_contract = get_widget_value("contract_filter", "")
-- MAGIC selected_inspection_id = get_widget_value("inspection_id_filter", "")
-- MAGIC selected_job_id = get_widget_value("job_id_filter", "")
-- MAGIC due_days = int(get_widget_value("due_days", "60") or "60")
-- MAGIC include_completed = get_widget_value("include_completed", "false").lower() == "true"
-- MAGIC
-- MAGIC source_df = spark.table(output_table)
-- MAGIC routeable_df = (
-- MAGIC     source_df
-- MAGIC     .where(F.col("due_ts").isNotNull())
-- MAGIC     .where(F.to_date(F.col("due_ts")) >= F.current_date())
-- MAGIC     .where(F.to_date(F.col("due_ts")) <= F.date_add(F.current_date(), due_days))
-- MAGIC )
-- MAGIC
-- MAGIC if not include_completed:
-- MAGIC     routeable_df = routeable_df.where(
-- MAGIC         F.col("completed_ts").isNull()
-- MAGIC         | ~F.lower(F.coalesce(F.col("completed_status"), F.lit(""))).contains("complete")
-- MAGIC     )
-- MAGIC
-- MAGIC contract_choices = collect_choices(routeable_df, "contract")
-- MAGIC recreate_dropdown("contract_filter", selected_contract, contract_choices)
-- MAGIC
-- MAGIC if selected_contract:
-- MAGIC     routeable_df = routeable_df.where(F.lower(F.col("contract").cast("string")).contains(selected_contract.lower()))
-- MAGIC
-- MAGIC inspection_choices = collect_choices(routeable_df, "inspection_id")
-- MAGIC job_choices = collect_choices(routeable_df, "job_id")
-- MAGIC recreate_dropdown("inspection_id_filter", selected_inspection_id, inspection_choices)
-- MAGIC recreate_dropdown("job_id_filter", selected_job_id, job_choices)
-- MAGIC
-- MAGIC print(
-- MAGIC     f"Dropdowns refreshed from {output_table}: "
-- MAGIC     f"{len(contract_choices)} contracts, "
-- MAGIC     f"{len(inspection_choices)} inspection ids, "
-- MAGIC     f"{len(job_choices)} job ids. "
-- MAGIC     "Pick a contract, then rerun this cell to narrow inspection/job choices."
-- MAGIC )

-- COMMAND ----------

CREATE OR REPLACE TEMP VIEW route_input AS
WITH route_candidates AS (
  SELECT
    contract AS contractor_id,
    to_date(due_ts) AS route_date,
    CAST(job_id AS STRING) AS stop_id,
    COALESCE(activity_name, intervention_name, inspection_type_name, asset_name, CONCAT('Job ', job_id)) AS stop_name,
    COALESCE(asset_name, section, asset_code) AS road_name,
    latitude,
    longitude,
    priority,
    COALESCE(estimated_duration_minutes, 25) AS service_minutes,
    due_ts,
    source_context,
    source_catalog,
    documented_contract_context,
    contract,
    job_id,
    inspection_id,
    completed_status,
    assigned_user,
    workflow_status,
    wkt
  FROM asset_vision_route_source_union
  WHERE ('${contract_filter}' = '' OR LOWER(contract) LIKE CONCAT('%', LOWER('${contract_filter}'), '%'))
    AND ('${inspection_id_filter}' = '' OR CAST(inspection_id AS STRING) = '${inspection_id_filter}')
    AND ('${job_id_filter}' = '' OR CAST(job_id AS STRING) = '${job_id_filter}')
    AND (
      '${exclude_inspection_id_filter}' = ''
      OR inspection_id IS NULL
      OR NOT array_contains(
        split(regexp_replace('${exclude_inspection_id_filter}', '\\s+', ''), ','),
        CAST(inspection_id AS STRING)
      )
    )
    AND (
      '${exclude_job_id_filter}' = ''
      OR job_id IS NULL
      OR NOT array_contains(
        split(regexp_replace('${exclude_job_id_filter}', '\\s+', ''), ','),
        CAST(job_id AS STRING)
      )
    )
    AND (
      '${include_completed}' = 'true'
      OR completed_ts IS NULL
      OR LOWER(COALESCE(completed_status, '')) NOT LIKE '%complete%'
    )
    AND (
      due_ts IS NOT NULL
      AND to_date(due_ts) >= current_date()
      AND to_date(due_ts) <= date_add(current_date(), COALESCE(TRY_CAST('${due_days}' AS INT), 60))
    )
),
site_depots AS (
  SELECT
    contractor_id,
    route_date,
    stop_id AS depot_stop_id,
    stop_name AS depot_stop_name,
    latitude AS depot_latitude,
    longitude AS depot_longitude
  FROM (
    SELECT
      *,
      ROW_NUMBER() OVER (
        PARTITION BY contractor_id, route_date
        ORDER BY due_ts, priority, stop_id
      ) AS depot_rank
    FROM route_candidates
  )
  WHERE depot_rank = 1
)
SELECT
  rc.contractor_id,
  rc.route_date,
  rc.stop_id,
  rc.stop_name,
  rc.road_name,
  rc.latitude,
  rc.longitude,
  rc.priority,
  rc.service_minutes,
  rc.due_ts,
  sd.depot_latitude,
  sd.depot_longitude,
  CONCAT('Site depot - ', sd.depot_stop_name) AS depot_name,
  sd.depot_stop_id,
  'earliest_due_site_in_route_group' AS depot_source,
  rc.source_context,
  rc.source_catalog,
  rc.documented_contract_context,
  rc.contract,
  rc.job_id,
  rc.inspection_id,
  rc.completed_status,
  rc.assigned_user,
  rc.workflow_status,
  rc.wkt
FROM route_candidates rc
INNER JOIN site_depots sd
  ON rc.contractor_id = sd.contractor_id
  AND rc.route_date = sd.route_date;

-- COMMAND ----------

CREATE OR REPLACE TABLE ${route_input_table} AS
SELECT *
FROM route_input;

-- COMMAND ----------

SELECT
  source_context,
  documented_contract_context,
  contract,
  COUNT(*) AS routeable_job_count,
  COUNT(DISTINCT inspection_id) AS inspection_count,
  MIN(due_ts) AS earliest_due_ts,
  MAX(due_ts) AS latest_due_ts
FROM asset_vision_route_source_union
GROUP BY source_context, documented_contract_context, contract
ORDER BY source_context, contract;

-- COMMAND ----------

SELECT *
FROM route_input
ORDER BY contractor_id, route_date, priority, due_ts, stop_id
LIMIT 200;
