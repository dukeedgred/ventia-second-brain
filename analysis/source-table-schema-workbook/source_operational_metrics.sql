-- Source-only Asset Vision operational metric query.
-- Excludes transport_*, reporting, curated, and derived/view tables.
-- Output grain: source schema + source Contract + metric row.
-- Rates are percentages. Proxy metrics are clearly marked in metric_name/notes.

WITH source_asset AS (
  SELECT 'asset_vision_ven_gen7' AS source_schema, 'ext_mssql_asset_vision_ven_gen7' AS source_catalog,
         CAST(ID AS BIGINT) AS asset_id,
         COALESCE(NULLIF(TRIM(CAST(Contract AS STRING)), ''), 'asset_vision_ven_gen7') AS contract,
         COALESCE(NULLIF(TRIM(CAST(AssetType AS STRING)), ''), 'Unspecified asset type') AS asset_type,
         COALESCE(NULLIF(TRIM(CAST(Classification AS STRING)), ''), 'Unclassified') AS asset_category,
         COALESCE(NULLIF(TRIM(CAST(AssetCondition AS STRING)), ''), 'Not supplied') AS asset_condition,
         COALESCE(NULLIF(TRIM(CAST(AssetRisk AS STRING)), ''), 'Not supplied') AS asset_risk,
         COALESCE(NULLIF(TRIM(CAST(AssetCriticality AS STRING)), ''), 'Not supplied') AS asset_criticality
  FROM ext_mssql_asset_vision_ven_gen7.dbo.asset
  WHERE COALESCE(Deleted, false) = false
  UNION ALL
  SELECT 'asset_vision_ven_rms', 'ext_mssql_asset_vision_ven_rms',
         CAST(ID AS BIGINT),
         COALESCE(NULLIF(TRIM(CAST(Contract AS STRING)), ''), 'asset_vision_ven_rms'),
         COALESCE(NULLIF(TRIM(CAST(AssetType AS STRING)), ''), 'Unspecified asset type'),
         COALESCE(NULLIF(TRIM(CAST(Classification AS STRING)), ''), 'Unclassified'),
         COALESCE(NULLIF(TRIM(CAST(AssetCondition AS STRING)), ''), 'Not supplied'),
         COALESCE(NULLIF(TRIM(CAST(AssetRisk AS STRING)), ''), 'Not supplied'),
         COALESCE(NULLIF(TRIM(CAST(AssetCriticality AS STRING)), ''), 'Not supplied')
  FROM ext_mssql_asset_vision_ven_rms.dbo.asset
  WHERE COALESCE(Deleted, false) = false
  UNION ALL
  SELECT 'asset_vision_ven_rms_new', 'ext_mssql_asset_vision_ven_rms_new',
         CAST(ID AS BIGINT),
         COALESCE(NULLIF(TRIM(CAST(Contract AS STRING)), ''), 'asset_vision_ven_rms_new'),
         COALESCE(NULLIF(TRIM(CAST(AssetType AS STRING)), ''), 'Unspecified asset type'),
         COALESCE(NULLIF(TRIM(CAST(Classification AS STRING)), ''), 'Unclassified'),
         COALESCE(NULLIF(TRIM(CAST(AssetCondition AS STRING)), ''), 'Not supplied'),
         COALESCE(NULLIF(TRIM(CAST(AssetRisk AS STRING)), ''), 'Not supplied'),
         COALESCE(NULLIF(TRIM(CAST(AssetCriticality AS STRING)), ''), 'Not supplied')
  FROM ext_mssql_asset_vision_ven_rms_new.dbo.asset
  WHERE COALESCE(Deleted, false) = false
  UNION ALL
  SELECT 'asset_vision_ven_vicroads', 'ext_mssql_asset_vision_ven_vicroads',
         CAST(ID AS BIGINT),
         COALESCE(NULLIF(TRIM(CAST(Contract AS STRING)), ''), 'asset_vision_ven_vicroads'),
         COALESCE(NULLIF(TRIM(CAST(AssetType AS STRING)), ''), 'Unspecified asset type'),
         COALESCE(NULLIF(TRIM(CAST(Classification AS STRING)), ''), 'Unclassified'),
         COALESCE(NULLIF(TRIM(CAST(AssetCondition AS STRING)), ''), 'Not supplied'),
         COALESCE(NULLIF(TRIM(CAST(AssetRisk AS STRING)), ''), 'Not supplied'),
         COALESCE(NULLIF(TRIM(CAST(AssetCriticality AS STRING)), ''), 'Not supplied')
  FROM ext_mssql_asset_vision_ven_vicroads.dbo.asset
  WHERE COALESCE(Deleted, false) = false
  UNION ALL
  SELECT 'asset_vision_vns_gen7', 'ext_mssql_asset_vision_vns_gen7',
         CAST(ID AS BIGINT),
         COALESCE(NULLIF(TRIM(CAST(Contract AS STRING)), ''), 'asset_vision_vns_gen7'),
         COALESCE(NULLIF(TRIM(CAST(AssetType AS STRING)), ''), 'Unspecified asset type'),
         COALESCE(NULLIF(TRIM(CAST(Classification AS STRING)), ''), 'Unclassified'),
         COALESCE(NULLIF(TRIM(CAST(AssetCondition AS STRING)), ''), 'Not supplied'),
         COALESCE(NULLIF(TRIM(CAST(AssetRisk AS STRING)), ''), 'Not supplied'),
         COALESCE(NULLIF(TRIM(CAST(AssetCriticality AS STRING)), ''), 'Not supplied')
  FROM ext_mssql_asset_vision_vns_gen7.dbo.asset
  WHERE COALESCE(Deleted, false) = false
  UNION ALL
  SELECT 'asset_vision_vnz_gen7', 'ext_mssql_asset_vision_vnz_gen7',
         CAST(ID AS BIGINT),
         COALESCE(NULLIF(TRIM(CAST(Contract AS STRING)), ''), 'asset_vision_vnz_gen7'),
         COALESCE(NULLIF(TRIM(CAST(AssetType AS STRING)), ''), 'Unspecified asset type'),
         COALESCE(NULLIF(TRIM(CAST(Classification AS STRING)), ''), 'Unclassified'),
         COALESCE(NULLIF(TRIM(CAST(AssetCondition AS STRING)), ''), 'Not supplied'),
         COALESCE(NULLIF(TRIM(CAST(AssetRisk AS STRING)), ''), 'Not supplied'),
         COALESCE(NULLIF(TRIM(CAST(AssetCriticality AS STRING)), ''), 'Not supplied')
  FROM ext_mssql_asset_vision_vnz_gen7.dbo.asset
  WHERE COALESCE(Deleted, false) = false
  UNION ALL
  SELECT 'asset_vision_vsm_gen7', 'ext_mssql_asset_vision_vsm_gen7',
         CAST(ID AS BIGINT),
         COALESCE(NULLIF(TRIM(CAST(Contract AS STRING)), ''), 'asset_vision_vsm_gen7'),
         COALESCE(NULLIF(TRIM(CAST(AssetType AS STRING)), ''), 'Unspecified asset type'),
         COALESCE(NULLIF(TRIM(CAST(Classification AS STRING)), ''), 'Unclassified'),
         COALESCE(NULLIF(TRIM(CAST(AssetCondition AS STRING)), ''), 'Not supplied'),
         COALESCE(NULLIF(TRIM(CAST(AssetRisk AS STRING)), ''), 'Not supplied'),
         COALESCE(NULLIF(TRIM(CAST(AssetCriticality AS STRING)), ''), 'Not supplied')
  FROM ext_mssql_asset_vision_vsm_gen7.dbo.asset
  WHERE COALESCE(Deleted, false) = false
),
source_asset_location AS (
  SELECT 'asset_vision_ven_gen7' AS source_schema, CAST(AssetID AS BIGINT) AS asset_id
  FROM ext_mssql_asset_vision_ven_gen7.dbo.assetlocation
  WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_ven_rms', CAST(AssetID AS BIGINT)
  FROM ext_mssql_asset_vision_ven_rms.dbo.assetlocation
  WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_ven_rms_new', CAST(AssetID AS BIGINT)
  FROM ext_mssql_asset_vision_ven_rms_new.dbo.assetlocation
  WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_ven_vicroads', CAST(AssetID AS BIGINT)
  FROM ext_mssql_asset_vision_ven_vicroads.dbo.assetlocation
  WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_vns_gen7', CAST(AssetID AS BIGINT)
  FROM ext_mssql_asset_vision_vns_gen7.dbo.assetlocation
  WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_vnz_gen7', CAST(AssetID AS BIGINT)
  FROM ext_mssql_asset_vision_vnz_gen7.dbo.assetlocation
  WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_vsm_gen7', CAST(AssetID AS BIGINT)
  FROM ext_mssql_asset_vision_vsm_gen7.dbo.assetlocation
  WHERE COALESCE(Deleted, false) = false
),
source_job AS (
  SELECT 'asset_vision_ven_gen7' AS source_schema,
         CAST(ID AS BIGINT) AS job_id,
         CAST(AssetID AS BIGINT) AS asset_id,
         COALESCE(NULLIF(TRIM(CAST(Contract AS STRING)), ''), 'asset_vision_ven_gen7') AS contract,
         CAST(CreatedDate AS TIMESTAMP) AS created_date,
         CAST(DueDate AS TIMESTAMP) AS due_date,
         CAST(CompletedDate AS TIMESTAMP) AS completed_date
  FROM ext_mssql_asset_vision_ven_gen7.dbo.job
  WHERE COALESCE(Deleted, false) = false
  UNION ALL
  SELECT 'asset_vision_ven_rms', CAST(ID AS BIGINT), CAST(AssetID AS BIGINT),
         COALESCE(NULLIF(TRIM(CAST(Contract AS STRING)), ''), 'asset_vision_ven_rms'),
         CAST(CreatedDate AS TIMESTAMP), CAST(DueDate AS TIMESTAMP), CAST(CompletedDate AS TIMESTAMP)
  FROM ext_mssql_asset_vision_ven_rms.dbo.job
  WHERE COALESCE(Deleted, false) = false
  UNION ALL
  SELECT 'asset_vision_ven_rms_new', CAST(ID AS BIGINT), CAST(AssetID AS BIGINT),
         COALESCE(NULLIF(TRIM(CAST(Contract AS STRING)), ''), 'asset_vision_ven_rms_new'),
         CAST(CreatedDate AS TIMESTAMP), CAST(DueDate AS TIMESTAMP), CAST(CompletedDate AS TIMESTAMP)
  FROM ext_mssql_asset_vision_ven_rms_new.dbo.job
  WHERE COALESCE(Deleted, false) = false
  UNION ALL
  SELECT 'asset_vision_ven_vicroads', CAST(ID AS BIGINT), CAST(AssetID AS BIGINT),
         COALESCE(NULLIF(TRIM(CAST(Contract AS STRING)), ''), 'asset_vision_ven_vicroads'),
         CAST(CreatedDate AS TIMESTAMP), CAST(DueDate AS TIMESTAMP), CAST(CompletedDate AS TIMESTAMP)
  FROM ext_mssql_asset_vision_ven_vicroads.dbo.job
  WHERE COALESCE(Deleted, false) = false
  UNION ALL
  SELECT 'asset_vision_vns_gen7', CAST(ID AS BIGINT), CAST(AssetID AS BIGINT),
         COALESCE(NULLIF(TRIM(CAST(Contract AS STRING)), ''), 'asset_vision_vns_gen7'),
         CAST(CreatedDate AS TIMESTAMP), CAST(DueDate AS TIMESTAMP), CAST(CompletedDate AS TIMESTAMP)
  FROM ext_mssql_asset_vision_vns_gen7.dbo.job
  WHERE COALESCE(Deleted, false) = false
  UNION ALL
  SELECT 'asset_vision_vnz_gen7', CAST(ID AS BIGINT), CAST(AssetID AS BIGINT),
         COALESCE(NULLIF(TRIM(CAST(Contract AS STRING)), ''), 'asset_vision_vnz_gen7'),
         CAST(CreatedDate AS TIMESTAMP), CAST(DueDate AS TIMESTAMP), CAST(CompletedDate AS TIMESTAMP)
  FROM ext_mssql_asset_vision_vnz_gen7.dbo.job
  WHERE COALESCE(Deleted, false) = false
  UNION ALL
  SELECT 'asset_vision_vsm_gen7', CAST(ID AS BIGINT), CAST(AssetID AS BIGINT),
         COALESCE(NULLIF(TRIM(CAST(Contract AS STRING)), ''), 'asset_vision_vsm_gen7'),
         CAST(CreatedDate AS TIMESTAMP), CAST(DueDate AS TIMESTAMP), CAST(CompletedDate AS TIMESTAMP)
  FROM ext_mssql_asset_vision_vsm_gen7.dbo.job
  WHERE COALESCE(Deleted, false) = false
),
source_job_asset AS (
  SELECT 'asset_vision_ven_gen7' AS source_schema, CAST(JobID AS BIGINT) AS job_id, CAST(AssetID AS BIGINT) AS asset_id
  FROM ext_mssql_asset_vision_ven_gen7.dbo.jobasset
  WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_ven_rms', CAST(JobID AS BIGINT), CAST(AssetID AS BIGINT)
  FROM ext_mssql_asset_vision_ven_rms.dbo.jobasset
  WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_ven_rms_new', CAST(JobID AS BIGINT), CAST(AssetID AS BIGINT)
  FROM ext_mssql_asset_vision_ven_rms_new.dbo.jobasset
  WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_ven_vicroads', CAST(JobID AS BIGINT), CAST(AssetID AS BIGINT)
  FROM ext_mssql_asset_vision_ven_vicroads.dbo.jobasset
  WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_vns_gen7', CAST(JobID AS BIGINT), CAST(AssetID AS BIGINT)
  FROM ext_mssql_asset_vision_vns_gen7.dbo.jobasset
  WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_vnz_gen7', CAST(JobID AS BIGINT), CAST(AssetID AS BIGINT)
  FROM ext_mssql_asset_vision_vnz_gen7.dbo.jobasset
  WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_vsm_gen7', CAST(JobID AS BIGINT), CAST(AssetID AS BIGINT)
  FROM ext_mssql_asset_vision_vsm_gen7.dbo.jobasset
  WHERE COALESCE(Deleted, false) = false
),
job_asset_link AS (
  SELECT source_schema, contract, asset_id, job_id
  FROM source_job
  WHERE asset_id IS NOT NULL
  UNION
  SELECT ja.source_schema, COALESCE(j.contract, ja.source_schema) AS contract, ja.asset_id, ja.job_id
  FROM source_job_asset ja
  LEFT JOIN source_job j
    ON j.source_schema = ja.source_schema
   AND j.job_id = ja.job_id
  WHERE ja.asset_id IS NOT NULL
),
source_inspection AS (
  SELECT 'asset_vision_ven_gen7' AS source_schema,
         CAST(ID AS BIGINT) AS inspection_id,
         CAST(AssetID AS BIGINT) AS asset_id,
         COALESCE(NULLIF(TRIM(CAST(Contract AS STRING)), ''), 'asset_vision_ven_gen7') AS contract,
         CAST(ScheduledDate AS TIMESTAMP) AS scheduled_date,
         CAST(ScheduledDateTo AS TIMESTAMP) AS scheduled_date_to,
         CAST(CompletedDate AS TIMESTAMP) AS completed_date
  FROM ext_mssql_asset_vision_ven_gen7.dbo.inspection
  WHERE COALESCE(Deleted, false) = false
  UNION ALL
  SELECT 'asset_vision_ven_rms', CAST(ID AS BIGINT), CAST(AssetID AS BIGINT),
         COALESCE(NULLIF(TRIM(CAST(Contract AS STRING)), ''), 'asset_vision_ven_rms'),
         CAST(ScheduledDate AS TIMESTAMP), CAST(ScheduledDateTo AS TIMESTAMP), CAST(CompletedDate AS TIMESTAMP)
  FROM ext_mssql_asset_vision_ven_rms.dbo.inspection
  WHERE COALESCE(Deleted, false) = false
  UNION ALL
  SELECT 'asset_vision_ven_rms_new', CAST(ID AS BIGINT), CAST(AssetID AS BIGINT),
         COALESCE(NULLIF(TRIM(CAST(Contract AS STRING)), ''), 'asset_vision_ven_rms_new'),
         CAST(ScheduledDate AS TIMESTAMP), CAST(ScheduledDateTo AS TIMESTAMP), CAST(CompletedDate AS TIMESTAMP)
  FROM ext_mssql_asset_vision_ven_rms_new.dbo.inspection
  WHERE COALESCE(Deleted, false) = false
  UNION ALL
  SELECT 'asset_vision_ven_vicroads', CAST(ID AS BIGINT), CAST(AssetID AS BIGINT),
         COALESCE(NULLIF(TRIM(CAST(Contract AS STRING)), ''), 'asset_vision_ven_vicroads'),
         CAST(ScheduledDate AS TIMESTAMP), CAST(ScheduledDateTo AS TIMESTAMP), CAST(CompletedDate AS TIMESTAMP)
  FROM ext_mssql_asset_vision_ven_vicroads.dbo.inspection
  WHERE COALESCE(Deleted, false) = false
  UNION ALL
  SELECT 'asset_vision_vns_gen7', CAST(ID AS BIGINT), CAST(AssetID AS BIGINT),
         COALESCE(NULLIF(TRIM(CAST(Contract AS STRING)), ''), 'asset_vision_vns_gen7'),
         CAST(ScheduledDate AS TIMESTAMP), CAST(ScheduledDateTo AS TIMESTAMP), CAST(CompletedDate AS TIMESTAMP)
  FROM ext_mssql_asset_vision_vns_gen7.dbo.inspection
  WHERE COALESCE(Deleted, false) = false
  UNION ALL
  SELECT 'asset_vision_vnz_gen7', CAST(ID AS BIGINT), CAST(AssetID AS BIGINT),
         COALESCE(NULLIF(TRIM(CAST(Contract AS STRING)), ''), 'asset_vision_vnz_gen7'),
         CAST(ScheduledDate AS TIMESTAMP), CAST(ScheduledDateTo AS TIMESTAMP), CAST(CompletedDate AS TIMESTAMP)
  FROM ext_mssql_asset_vision_vnz_gen7.dbo.inspection
  WHERE COALESCE(Deleted, false) = false
  UNION ALL
  SELECT 'asset_vision_vsm_gen7', CAST(ID AS BIGINT), CAST(AssetID AS BIGINT),
         COALESCE(NULLIF(TRIM(CAST(Contract AS STRING)), ''), 'asset_vision_vsm_gen7'),
         CAST(ScheduledDate AS TIMESTAMP), CAST(ScheduledDateTo AS TIMESTAMP), CAST(CompletedDate AS TIMESTAMP)
  FROM ext_mssql_asset_vision_vsm_gen7.dbo.inspection
  WHERE COALESCE(Deleted, false) = false
),
source_photo AS (
  SELECT 'asset_vision_ven_gen7' AS source_schema, LOWER(TRIM(CAST(SourceTable AS STRING))) AS source_table, CAST(SourceTableID AS BIGINT) AS source_table_id
  FROM ext_mssql_asset_vision_ven_gen7.dbo.photo
  WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_ven_rms', LOWER(TRIM(CAST(SourceTable AS STRING))), CAST(SourceTableID AS BIGINT)
  FROM ext_mssql_asset_vision_ven_rms.dbo.photo
  WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_ven_rms_new', LOWER(TRIM(CAST(SourceTable AS STRING))), CAST(SourceTableID AS BIGINT)
  FROM ext_mssql_asset_vision_ven_rms_new.dbo.photo
  WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_ven_vicroads', LOWER(TRIM(CAST(SourceTable AS STRING))), CAST(SourceTableID AS BIGINT)
  FROM ext_mssql_asset_vision_ven_vicroads.dbo.photo
  WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_vns_gen7', LOWER(TRIM(CAST(SourceTable AS STRING))), CAST(SourceTableID AS BIGINT)
  FROM ext_mssql_asset_vision_vns_gen7.dbo.photo
  WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_vnz_gen7', LOWER(TRIM(CAST(SourceTable AS STRING))), CAST(SourceTableID AS BIGINT)
  FROM ext_mssql_asset_vision_vnz_gen7.dbo.photo
  WHERE COALESCE(Deleted, false) = false
  UNION ALL SELECT 'asset_vision_vsm_gen7', LOWER(TRIM(CAST(SourceTable AS STRING))), CAST(SourceTableID AS BIGINT)
  FROM ext_mssql_asset_vision_vsm_gen7.dbo.photo
  WHERE COALESCE(Deleted, false) = false
),
source_capital_work AS (
  SELECT 'asset_vision_ven_gen7' AS source_schema,
         COALESCE(NULLIF(TRIM(CAST(Contract AS STRING)), ''), 'asset_vision_ven_gen7') AS contract,
         CAST(ID AS BIGINT) AS capital_work_id,
         CAST(PlannedFinish AS TIMESTAMP) AS planned_finish,
         CAST(ActualFinish AS TIMESTAMP) AS actual_finish
  FROM ext_mssql_asset_vision_ven_gen7.dbo.capitalwork
  WHERE COALESCE(Deleted, false) = false
  UNION ALL
  SELECT 'asset_vision_ven_rms', COALESCE(NULLIF(TRIM(CAST(Contract AS STRING)), ''), 'asset_vision_ven_rms'), CAST(ID AS BIGINT), CAST(PlannedFinish AS TIMESTAMP), CAST(ActualFinish AS TIMESTAMP)
  FROM ext_mssql_asset_vision_ven_rms.dbo.capitalwork
  WHERE COALESCE(Deleted, false) = false
  UNION ALL
  SELECT 'asset_vision_ven_rms_new', COALESCE(NULLIF(TRIM(CAST(Contract AS STRING)), ''), 'asset_vision_ven_rms_new'), CAST(ID AS BIGINT), CAST(PlannedFinish AS TIMESTAMP), CAST(ActualFinish AS TIMESTAMP)
  FROM ext_mssql_asset_vision_ven_rms_new.dbo.capitalwork
  WHERE COALESCE(Deleted, false) = false
  UNION ALL
  SELECT 'asset_vision_ven_vicroads', COALESCE(NULLIF(TRIM(CAST(Contract AS STRING)), ''), 'asset_vision_ven_vicroads'), CAST(ID AS BIGINT), CAST(PlannedFinish AS TIMESTAMP), CAST(ActualFinish AS TIMESTAMP)
  FROM ext_mssql_asset_vision_ven_vicroads.dbo.capitalwork
  WHERE COALESCE(Deleted, false) = false
  UNION ALL
  SELECT 'asset_vision_vns_gen7', COALESCE(NULLIF(TRIM(CAST(Contract AS STRING)), ''), 'asset_vision_vns_gen7'), CAST(ID AS BIGINT), CAST(PlannedFinish AS TIMESTAMP), CAST(ActualFinish AS TIMESTAMP)
  FROM ext_mssql_asset_vision_vns_gen7.dbo.capitalwork
  WHERE COALESCE(Deleted, false) = false
  UNION ALL
  SELECT 'asset_vision_vnz_gen7', COALESCE(NULLIF(TRIM(CAST(Contract AS STRING)), ''), 'asset_vision_vnz_gen7'), CAST(ID AS BIGINT), CAST(PlannedFinish AS TIMESTAMP), CAST(ActualFinish AS TIMESTAMP)
  FROM ext_mssql_asset_vision_vnz_gen7.dbo.capitalwork
  WHERE COALESCE(Deleted, false) = false
  UNION ALL
  SELECT 'asset_vision_vsm_gen7', COALESCE(NULLIF(TRIM(CAST(Contract AS STRING)), ''), 'asset_vision_vsm_gen7'), CAST(ID AS BIGINT), CAST(PlannedFinish AS TIMESTAMP), CAST(ActualFinish AS TIMESTAMP)
  FROM ext_mssql_asset_vision_vsm_gen7.dbo.capitalwork
  WHERE COALESCE(Deleted, false) = false
),
source_capital_work_task AS (
  SELECT cw.source_schema,
         cw.contract,
         CAST(t.ID AS BIGINT) AS task_id,
         CAST(t.PlannedFinish AS TIMESTAMP) AS planned_finish,
         CAST(t.ActualFinish AS TIMESTAMP) AS actual_finish
  FROM ext_mssql_asset_vision_ven_gen7.dbo.capitalworktask t
  LEFT JOIN source_capital_work cw
    ON cw.source_schema = 'asset_vision_ven_gen7'
   AND cw.capital_work_id = CAST(t.CapitalWorkID AS BIGINT)
  WHERE COALESCE(t.Deleted, false) = false
  UNION ALL
  SELECT cw.source_schema, cw.contract, CAST(t.ID AS BIGINT), CAST(t.PlannedFinish AS TIMESTAMP), CAST(t.ActualFinish AS TIMESTAMP)
  FROM ext_mssql_asset_vision_ven_rms.dbo.capitalworktask t
  LEFT JOIN source_capital_work cw ON cw.source_schema = 'asset_vision_ven_rms' AND cw.capital_work_id = CAST(t.CapitalWorkID AS BIGINT)
  WHERE COALESCE(t.Deleted, false) = false
  UNION ALL
  SELECT cw.source_schema, cw.contract, CAST(t.ID AS BIGINT), CAST(t.PlannedFinish AS TIMESTAMP), CAST(t.ActualFinish AS TIMESTAMP)
  FROM ext_mssql_asset_vision_ven_rms_new.dbo.capitalworktask t
  LEFT JOIN source_capital_work cw ON cw.source_schema = 'asset_vision_ven_rms_new' AND cw.capital_work_id = CAST(t.CapitalWorkID AS BIGINT)
  WHERE COALESCE(t.Deleted, false) = false
  UNION ALL
  SELECT cw.source_schema, cw.contract, CAST(t.ID AS BIGINT), CAST(t.PlannedFinish AS TIMESTAMP), CAST(t.ActualFinish AS TIMESTAMP)
  FROM ext_mssql_asset_vision_ven_vicroads.dbo.capitalworktask t
  LEFT JOIN source_capital_work cw ON cw.source_schema = 'asset_vision_ven_vicroads' AND cw.capital_work_id = CAST(t.CapitalWorkID AS BIGINT)
  WHERE COALESCE(t.Deleted, false) = false
  UNION ALL
  SELECT cw.source_schema, cw.contract, CAST(t.ID AS BIGINT), CAST(t.PlannedFinish AS TIMESTAMP), CAST(t.ActualFinish AS TIMESTAMP)
  FROM ext_mssql_asset_vision_vns_gen7.dbo.capitalworktask t
  LEFT JOIN source_capital_work cw ON cw.source_schema = 'asset_vision_vns_gen7' AND cw.capital_work_id = CAST(t.CapitalWorkID AS BIGINT)
  WHERE COALESCE(t.Deleted, false) = false
  UNION ALL
  SELECT cw.source_schema, cw.contract, CAST(t.ID AS BIGINT), CAST(t.PlannedFinish AS TIMESTAMP), CAST(t.ActualFinish AS TIMESTAMP)
  FROM ext_mssql_asset_vision_vnz_gen7.dbo.capitalworktask t
  LEFT JOIN source_capital_work cw ON cw.source_schema = 'asset_vision_vnz_gen7' AND cw.capital_work_id = CAST(t.CapitalWorkID AS BIGINT)
  WHERE COALESCE(t.Deleted, false) = false
  UNION ALL
  SELECT cw.source_schema, cw.contract, CAST(t.ID AS BIGINT), CAST(t.PlannedFinish AS TIMESTAMP), CAST(t.ActualFinish AS TIMESTAMP)
  FROM ext_mssql_asset_vision_vsm_gen7.dbo.capitalworktask t
  LEFT JOIN source_capital_work cw ON cw.source_schema = 'asset_vision_vsm_gen7' AND cw.capital_work_id = CAST(t.CapitalWorkID AS BIGINT)
  WHERE COALESCE(t.Deleted, false) = false
),
job_by_asset AS (
  SELECT source_schema, contract, asset_id, COUNT(DISTINCT job_id) AS job_count
  FROM job_asset_link
  WHERE asset_id IS NOT NULL
  GROUP BY source_schema, contract, asset_id
),
asset_location_flag AS (
  SELECT source_schema, asset_id, COUNT(*) AS location_record_count
  FROM source_asset_location
  WHERE asset_id IS NOT NULL
  GROUP BY source_schema, asset_id
),
job_photo_flag AS (
  SELECT source_schema, source_table_id AS job_id, COUNT(*) AS photo_count
  FROM source_photo
  WHERE source_table = 'job'
  GROUP BY source_schema, source_table_id
),
asset_photo_flag AS (
  SELECT source_schema, source_table_id AS asset_id, COUNT(*) AS photo_count
  FROM source_photo
  WHERE source_table = 'asset'
  GROUP BY source_schema, source_table_id
),
metric_rows AS (
  SELECT source_schema, contract,
         'jobs' AS metric_group,
         'overdue_job_rate' AS metric_name,
         'open jobs past DueDate' AS metric_definition,
         CAST(NULL AS STRING) AS detail_dimension,
         SUM(CASE WHEN due_date IS NOT NULL AND completed_date IS NULL AND due_date < CURRENT_TIMESTAMP() THEN 1 ELSE 0 END) AS numerator,
         SUM(CASE WHEN due_date IS NOT NULL THEN 1 ELSE 0 END) AS denominator,
         ROUND(100 * TRY_DIVIDE(
           SUM(CASE WHEN due_date IS NOT NULL AND completed_date IS NULL AND due_date < CURRENT_TIMESTAMP() THEN 1 ELSE 0 END),
           SUM(CASE WHEN due_date IS NOT NULL THEN 1 ELSE 0 END)
         ), 2) AS metric_rate_pct,
         CAST(NULL AS DOUBLE) AS metric_value,
         'DueDate and CompletedDate proxy from source job table.' AS notes
  FROM source_job
  GROUP BY source_schema, contract

  UNION ALL
  SELECT source_schema, contract, 'inspections', 'overdue_inspection_rate',
         'open inspections past ScheduledDateTo/ScheduledDate',
         NULL,
         SUM(CASE WHEN COALESCE(scheduled_date_to, scheduled_date) IS NOT NULL
                   AND completed_date IS NULL
                   AND COALESCE(scheduled_date_to, scheduled_date) < CURRENT_TIMESTAMP() THEN 1 ELSE 0 END),
         SUM(CASE WHEN COALESCE(scheduled_date_to, scheduled_date) IS NOT NULL THEN 1 ELSE 0 END),
         ROUND(100 * TRY_DIVIDE(
           SUM(CASE WHEN COALESCE(scheduled_date_to, scheduled_date) IS NOT NULL
                     AND completed_date IS NULL
                     AND COALESCE(scheduled_date_to, scheduled_date) < CURRENT_TIMESTAMP() THEN 1 ELSE 0 END),
           SUM(CASE WHEN COALESCE(scheduled_date_to, scheduled_date) IS NOT NULL THEN 1 ELSE 0 END)
         ), 2),
         NULL,
         'Inspection due proxy uses ScheduledDateTo, falling back to ScheduledDate.'
  FROM source_inspection
  GROUP BY source_schema, contract

  UNION ALL
  SELECT source_schema, contract, 'jobs', 'job_completion_rate',
         'jobs with CompletedDate',
         NULL,
         SUM(CASE WHEN completed_date IS NOT NULL THEN 1 ELSE 0 END),
         COUNT(*),
         ROUND(100 * TRY_DIVIDE(SUM(CASE WHEN completed_date IS NOT NULL THEN 1 ELSE 0 END), COUNT(*)), 2),
         NULL,
         'Completion is based on non-null CompletedDate.'
  FROM source_job
  GROUP BY source_schema, contract

  UNION ALL
  SELECT source_schema, contract, 'inspections', 'inspection_completion_rate',
         'inspections with CompletedDate',
         NULL,
         SUM(CASE WHEN completed_date IS NOT NULL THEN 1 ELSE 0 END),
         COUNT(*),
         ROUND(100 * TRY_DIVIDE(SUM(CASE WHEN completed_date IS NOT NULL THEN 1 ELSE 0 END), COUNT(*)), 2),
         NULL,
         'Completion is based on non-null CompletedDate.'
  FROM source_inspection
  GROUP BY source_schema, contract

  UNION ALL
  SELECT source_schema, contract, 'jobs', 'job_sla_breach_proxy_rate',
         'jobs completed late or still open past DueDate',
         NULL,
         SUM(CASE WHEN due_date IS NOT NULL
                   AND (
                     (completed_date IS NOT NULL AND completed_date > due_date)
                     OR (completed_date IS NULL AND due_date < CURRENT_TIMESTAMP())
                   ) THEN 1 ELSE 0 END),
         SUM(CASE WHEN due_date IS NOT NULL THEN 1 ELSE 0 END),
         ROUND(100 * TRY_DIVIDE(
           SUM(CASE WHEN due_date IS NOT NULL
                     AND (
                       (completed_date IS NOT NULL AND completed_date > due_date)
                       OR (completed_date IS NULL AND due_date < CURRENT_TIMESTAMP())
                     ) THEN 1 ELSE 0 END),
           SUM(CASE WHEN due_date IS NOT NULL THEN 1 ELSE 0 END)
         ), 2),
         NULL,
         'Proxy only: true SLA rules may vary by contract/severity and are not encoded here.'
  FROM source_job
  GROUP BY source_schema, contract

  UNION ALL
  SELECT source_schema, contract, 'inspections', 'inspection_sla_breach_proxy_rate',
         'inspections completed late or still open past ScheduledDateTo/ScheduledDate',
         NULL,
         SUM(CASE WHEN COALESCE(scheduled_date_to, scheduled_date) IS NOT NULL
                   AND (
                     (completed_date IS NOT NULL AND completed_date > COALESCE(scheduled_date_to, scheduled_date))
                     OR (completed_date IS NULL AND COALESCE(scheduled_date_to, scheduled_date) < CURRENT_TIMESTAMP())
                   ) THEN 1 ELSE 0 END),
         SUM(CASE WHEN COALESCE(scheduled_date_to, scheduled_date) IS NOT NULL THEN 1 ELSE 0 END),
         ROUND(100 * TRY_DIVIDE(
           SUM(CASE WHEN COALESCE(scheduled_date_to, scheduled_date) IS NOT NULL
                     AND (
                       (completed_date IS NOT NULL AND completed_date > COALESCE(scheduled_date_to, scheduled_date))
                       OR (completed_date IS NULL AND COALESCE(scheduled_date_to, scheduled_date) < CURRENT_TIMESTAMP())
                     ) THEN 1 ELSE 0 END),
           SUM(CASE WHEN COALESCE(scheduled_date_to, scheduled_date) IS NOT NULL THEN 1 ELSE 0 END)
         ), 2),
         NULL,
         'Proxy only: uses scheduled inspection dates, not contract-specific KPI definitions.'
  FROM source_inspection
  GROUP BY source_schema, contract

  UNION ALL
  SELECT source_schema, contract, 'jobs', 'repeat_jobs_per_asset_rate',
         'assets with two or more linked jobs',
         NULL,
         SUM(CASE WHEN job_count >= 2 THEN 1 ELSE 0 END),
         COUNT(*),
         ROUND(100 * TRY_DIVIDE(SUM(CASE WHEN job_count >= 2 THEN 1 ELSE 0 END), COUNT(*)), 2),
         ROUND(AVG(job_count), 2),
         'metric_value is average linked jobs per asset; link uses job.AssetID and jobasset.AssetID.'
  FROM job_by_asset
  GROUP BY source_schema, contract

  UNION ALL
  SELECT source_schema, contract, 'assets', 'condition_profile',
         'asset count by AssetCondition',
         CONCAT('AssetCondition=', asset_condition),
         COUNT(*),
         SUM(COUNT(*)) OVER (PARTITION BY source_schema, contract),
         ROUND(100 * TRY_DIVIDE(COUNT(*), SUM(COUNT(*)) OVER (PARTITION BY source_schema, contract)), 2),
         NULL,
         'Distribution row. Not supplied means the source field was null/blank.'
  FROM source_asset
  GROUP BY source_schema, contract, asset_condition

  UNION ALL
  SELECT source_schema, contract, 'assets', 'risk_profile',
         'asset count by AssetRisk',
         CONCAT('AssetRisk=', asset_risk),
         COUNT(*),
         SUM(COUNT(*)) OVER (PARTITION BY source_schema, contract),
         ROUND(100 * TRY_DIVIDE(COUNT(*), SUM(COUNT(*)) OVER (PARTITION BY source_schema, contract)), 2),
         NULL,
         'Distribution row. Not supplied means the source field was null/blank.'
  FROM source_asset
  GROUP BY source_schema, contract, asset_risk

  UNION ALL
  SELECT j.source_schema, j.contract, 'evidence', 'job_evidence_coverage_rate',
         'jobs with at least one linked photo',
         NULL,
         SUM(CASE WHEN p.photo_count > 0 THEN 1 ELSE 0 END),
         COUNT(*),
         ROUND(100 * TRY_DIVIDE(SUM(CASE WHEN p.photo_count > 0 THEN 1 ELSE 0 END), COUNT(*)), 2),
         NULL,
         'Photo link uses photo.SourceTable = job and SourceTableID = job.ID.'
  FROM source_job j
  LEFT JOIN job_photo_flag p
    ON p.source_schema = j.source_schema
   AND p.job_id = j.job_id
  GROUP BY j.source_schema, j.contract

  UNION ALL
  SELECT a.source_schema, a.contract, 'evidence', 'asset_evidence_coverage_rate',
         'assets with at least one linked photo',
         NULL,
         SUM(CASE WHEN p.photo_count > 0 THEN 1 ELSE 0 END),
         COUNT(*),
         ROUND(100 * TRY_DIVIDE(SUM(CASE WHEN p.photo_count > 0 THEN 1 ELSE 0 END), COUNT(*)), 2),
         NULL,
         'Photo link uses photo.SourceTable = asset and SourceTableID = asset.ID.'
  FROM source_asset a
  LEFT JOIN asset_photo_flag p
    ON p.source_schema = a.source_schema
   AND p.asset_id = a.asset_id
  GROUP BY a.source_schema, a.contract

  UNION ALL
  SELECT source_schema, contract, 'capital_works', 'capital_work_slippage_rate',
         'capital works late against PlannedFinish',
         NULL,
         SUM(CASE WHEN planned_finish IS NOT NULL
                   AND (
                     (actual_finish IS NOT NULL AND actual_finish > planned_finish)
                     OR (actual_finish IS NULL AND planned_finish < CURRENT_TIMESTAMP())
                   ) THEN 1 ELSE 0 END),
         SUM(CASE WHEN planned_finish IS NOT NULL THEN 1 ELSE 0 END),
         ROUND(100 * TRY_DIVIDE(
           SUM(CASE WHEN planned_finish IS NOT NULL
                     AND (
                       (actual_finish IS NOT NULL AND actual_finish > planned_finish)
                       OR (actual_finish IS NULL AND planned_finish < CURRENT_TIMESTAMP())
                     ) THEN 1 ELSE 0 END),
           SUM(CASE WHEN planned_finish IS NOT NULL THEN 1 ELSE 0 END)
         ), 2),
         ROUND(AVG(CASE WHEN planned_finish IS NOT NULL
                         AND (
                           (actual_finish IS NOT NULL AND actual_finish > planned_finish)
                           OR (actual_finish IS NULL AND planned_finish < CURRENT_TIMESTAMP())
                         )
                        THEN DATEDIFF(COALESCE(actual_finish, CURRENT_TIMESTAMP()), planned_finish)
                   END), 2),
         'metric_value is average days late for slipped capital works.'
  FROM source_capital_work
  GROUP BY source_schema, contract

  UNION ALL
  SELECT source_schema, contract, 'capital_works', 'capital_work_task_slippage_rate',
         'capital work tasks late against PlannedFinish',
         NULL,
         SUM(CASE WHEN planned_finish IS NOT NULL
                   AND (
                     (actual_finish IS NOT NULL AND actual_finish > planned_finish)
                     OR (actual_finish IS NULL AND planned_finish < CURRENT_TIMESTAMP())
                   ) THEN 1 ELSE 0 END),
         SUM(CASE WHEN planned_finish IS NOT NULL THEN 1 ELSE 0 END),
         ROUND(100 * TRY_DIVIDE(
           SUM(CASE WHEN planned_finish IS NOT NULL
                     AND (
                       (actual_finish IS NOT NULL AND actual_finish > planned_finish)
                       OR (actual_finish IS NULL AND planned_finish < CURRENT_TIMESTAMP())
                     ) THEN 1 ELSE 0 END),
           SUM(CASE WHEN planned_finish IS NOT NULL THEN 1 ELSE 0 END)
         ), 2),
         ROUND(AVG(CASE WHEN planned_finish IS NOT NULL
                         AND (
                           (actual_finish IS NOT NULL AND actual_finish > planned_finish)
                           OR (actual_finish IS NULL AND planned_finish < CURRENT_TIMESTAMP())
                         )
                        THEN DATEDIFF(COALESCE(actual_finish, CURRENT_TIMESTAMP()), planned_finish)
                   END), 2),
         'metric_value is average days late for slipped capital work tasks.'
  FROM source_capital_work_task
  WHERE source_schema IS NOT NULL
  GROUP BY source_schema, contract

  UNION ALL
  SELECT a.source_schema, a.contract, 'assets', 'missing_location_rate',
         'assets without a non-deleted assetlocation record',
         NULL,
         SUM(CASE WHEN COALESCE(l.location_record_count, 0) = 0 THEN 1 ELSE 0 END),
         COUNT(*),
         ROUND(100 * TRY_DIVIDE(SUM(CASE WHEN COALESCE(l.location_record_count, 0) = 0 THEN 1 ELSE 0 END), COUNT(*)), 2),
         NULL,
         'Missing location uses source assetlocation table, not derived WKT views.'
  FROM source_asset a
  LEFT JOIN asset_location_flag l
    ON l.source_schema = a.source_schema
   AND l.asset_id = a.asset_id
  GROUP BY a.source_schema, a.contract
)
SELECT
  source_schema,
  contract,
  metric_group,
  metric_name,
  metric_definition,
  detail_dimension,
  CAST(numerator AS BIGINT) AS numerator,
  CAST(denominator AS BIGINT) AS denominator,
  metric_rate_pct,
  metric_value,
  notes
FROM metric_rows
ORDER BY source_schema, contract, metric_group, metric_name, detail_dimension;
