-- Databricks SQL
-- Compact one-run Asset Vision data-needs completeness query.
--
-- This version avoids SQL variables and dynamic execution because some
-- Databricks SQL endpoints parse variable assignment as Spark config syntax.
-- It scans each mapped source table once into row JSON, then uses metadata and
-- av_need_columns to calculate column availability and populated-row counts.
--
-- Prerequisite: transport_dev.integ_transport_assets.contract_group_map exists
-- and contains standardised_contract_name/raw_contract_name contract mappings.

CREATE OR REPLACE TEMP VIEW av_catalogs AS
SELECT * FROM VALUES
  ('asset_vision_ven_gen7', 'ext_mssql_asset_vision_ven_gen7', 'RAMC / BAC / PoB / TSRC group'),
  ('asset_vision_ven_rms', 'ext_mssql_asset_vision_ven_rms', 'RMS'),
  ('asset_vision_ven_rms_new', 'ext_mssql_asset_vision_ven_rms_new', 'RMS new'),
  ('asset_vision_ven_vicroads', 'ext_mssql_asset_vision_ven_vicroads', 'VicRoads / WRU'),
  ('asset_vision_vns_gen7', 'ext_mssql_asset_vision_vns_gen7', 'VNS / SHT-WHT'),
  ('asset_vision_vnz_gen7', 'ext_mssql_asset_vision_vnz_gen7', 'VNZ / Auckland West'),
  ('asset_vision_vsm_gen7', 'ext_mssql_asset_vision_vsm_gen7', 'VentureSmart')
AS t(source_context, source_catalog, source_label);

CREATE OR REPLACE TEMP VIEW av_data_needs AS
SELECT * FROM VALUES
  ('access'),
  ('backlog_delivery'),
  ('capital_works'),
  ('classification'),
  ('condition'),
  ('criticality'),
  ('data_freshness'),
  ('demand_proxy'),
  ('inspection_compliance'),
  ('inventory'),
  ('network'),
  ('performance_asset'),
  ('performance_finance'),
  ('performance_service'),
  ('quantity_productivity'),
  ('resilience_proxy'),
  ('resource_time'),
  ('risk'),
  ('spatial_coverage'),
  ('traffic_lane_access_proxy'),
  ('utilisation_proxy'),
  ('work_orders'),
  ('works_costs')
AS t(data_need);

CREATE OR REPLACE TEMP VIEW av_selected_contracts AS
SELECT DISTINCT
  standardised_contract_name,
  raw_contract_name
FROM transport_dev.integ_transport_assets.contract_group_map
WHERE standardised_contract_name IS NOT NULL
  AND raw_contract_name IS NOT NULL
  AND TRIM(raw_contract_name) <> '';

CREATE OR REPLACE TEMP VIEW av_need_columns AS
SELECT * FROM VALUES
  ('backlog_delivery', 'vjob', 'CompletedDate'),
  ('backlog_delivery', 'vjob', 'CompletedStatus'),
  ('backlog_delivery', 'vjob', 'CreatedDate'),
  ('backlog_delivery', 'vjob', 'CurrentWorkflowItemName'),
  ('backlog_delivery', 'vjob', 'DueDate'),
  ('backlog_delivery', 'vjob', 'Priority'),
  ('backlog_delivery', 'vjob', 'RemainingQuantity'),

  ('capital_works', 'vcapitalwork', 'ActualFinish'),
  ('capital_works', 'vcapitalwork', 'ActualStart'),
  ('capital_works', 'vcapitalwork', 'AssetID'),
  ('capital_works', 'vcapitalwork', 'CapitalWorkType'),
  ('capital_works', 'vcapitalwork', 'Description'),
  ('capital_works', 'vcapitalwork', 'ID'),
  ('capital_works', 'vcapitalwork', 'Name'),
  ('capital_works', 'vcapitalwork', 'PlannedFinish'),
  ('capital_works', 'vcapitalwork', 'PlannedStart'),
  ('capital_works', 'vcapitalwork', 'WKT'),
  ('capital_works', 'vcapitalworktask', 'ActualCost'),
  ('capital_works', 'vcapitalworktask', 'EstimatedCost'),
  ('capital_works', 'vcapitalworktask', 'WKT'),

  ('classification', 'asset', 'Classification'),
  ('classification', 'assetclassification', 'Classification'),
  ('classification', 'vinspection', 'Classification'),
  ('classification', 'vjob', 'Classification'),

  ('condition', 'asset', 'AssetCondition'),
  ('condition', 'asset', 'AssetConditionModel'),
  ('condition', 'asset', 'ConditionDate'),
  ('condition', 'vinspection', 'CurrentStatus'),
  ('condition', 'vinspection', 'InspectionTypeName'),

  ('criticality', 'asset', 'AssetCriticality'),

  ('data_freshness', 'asset', 'ConditionDate'),
  ('data_freshness', 'timesheetitem', 'EndDate'),
  ('data_freshness', 'timesheetitem', 'StartDate'),
  ('data_freshness', 'vcapitalwork', 'ActualFinish'),
  ('data_freshness', 'vcapitalwork', 'PlannedStart'),
  ('data_freshness', 'vinspection', 'CompletedDate'),
  ('data_freshness', 'vinspection', 'ScheduledDate'),
  ('data_freshness', 'vjob', 'CompletedDate'),
  ('data_freshness', 'vjob', 'CreatedDate'),
  ('data_freshness', 'vjob', 'DueDate'),

  ('demand_proxy', 'vinspection', 'ScheduledDate'),
  ('demand_proxy', 'vinspection', 'ScheduledDateFrom'),
  ('demand_proxy', 'vinspection', 'ScheduledDateTo'),
  ('demand_proxy', 'vjob', 'ActivityCategoryName'),
  ('demand_proxy', 'vjob', 'CreatedDate'),
  ('demand_proxy', 'vjob', 'DueDate'),
  ('demand_proxy', 'vjob', 'EstimatedQuantity'),
  ('demand_proxy', 'vjob', 'Priority'),

  ('inspection_compliance', 'vinspection', 'AssetID'),
  ('inspection_compliance', 'vinspection', 'Category'),
  ('inspection_compliance', 'vinspection', 'CompletedDate'),
  ('inspection_compliance', 'vinspection', 'CurrentStatus'),
  ('inspection_compliance', 'vinspection', 'ID'),
  ('inspection_compliance', 'vinspection', 'InspectionTypeName'),
  ('inspection_compliance', 'vinspection', 'JobID'),
  ('inspection_compliance', 'vinspection', 'ScheduledDate'),
  ('inspection_compliance', 'vinspection', 'ScheduledDateFrom'),
  ('inspection_compliance', 'vinspection', 'ScheduledDateTo'),
  ('inspection_compliance', 'vjob', 'Compliant'),

  ('inventory', 'asset', 'AssetType'),
  ('inventory', 'asset', 'Code'),
  ('inventory', 'asset', 'Contract'),
  ('inventory', 'asset', 'ID'),
  ('inventory', 'asset', 'Name'),
  ('inventory', 'asset', 'ParentAssetCode'),
  ('inventory', 'asset', 'ParentAssetID'),
  ('inventory', 'asset', 'ParentAssetName'),
  ('inventory', 'asset', 'Stage'),
  ('inventory', 'assetattribute', 'Name'),
  ('inventory', 'assetattribute', 'Value'),

  ('network', 'asset', 'AssetType'),
  ('network', 'asset', 'ChainageFrom'),
  ('network', 'asset', 'ChainageTo'),
  ('network', 'asset', 'Code'),
  ('network', 'asset', 'Contract'),
  ('network', 'asset', 'Direction'),
  ('network', 'asset', 'Name'),
  ('network', 'vassetlocation', 'WKT'),

  ('performance_asset', 'asset', 'AssetCondition'),
  ('performance_asset', 'asset', 'AssetConditionModel'),
  ('performance_asset', 'asset', 'AssetRisk'),
  ('performance_asset', 'asset', 'ConditionDate'),
  ('performance_asset', 'asset', 'ConstructionCost'),
  ('performance_asset', 'asset', 'ConstructionDate'),
  ('performance_asset', 'asset', 'UsefulLife'),

  ('performance_finance', 'plannedresourceitem', 'Cost'),
  ('performance_finance', 'timesheetitem', 'Cost'),
  ('performance_finance', 'vcapitalworktask', 'ActualCost'),
  ('performance_finance', 'vcapitalworktask', 'EstimatedCost'),
  ('performance_finance', 'vjob', 'EstimatedCost'),

  ('performance_service', 'vinspection', 'CompletedDate'),
  ('performance_service', 'vinspection', 'CurrentStatus'),
  ('performance_service', 'vjob', 'CompletedDate'),
  ('performance_service', 'vjob', 'CompletedStatus'),
  ('performance_service', 'vjob', 'Compliant'),
  ('performance_service', 'vjob', 'DueDate'),

  ('quantity_productivity', 'vjob', 'ActualQuantity'),
  ('quantity_productivity', 'vjob', 'EstimatedDepth'),
  ('quantity_productivity', 'vjob', 'EstimatedLength'),
  ('quantity_productivity', 'vjob', 'EstimatedQuantity'),
  ('quantity_productivity', 'vjob', 'EstimatedWidth'),
  ('quantity_productivity', 'vjob', 'RemainingQuantity'),
  ('quantity_productivity', 'vjob', 'Unit'),

  ('resilience_proxy', 'vjob', 'CompletedDate'),
  ('resilience_proxy', 'vjob', 'CompletedStatus'),
  ('resilience_proxy', 'vjob', 'DueDate'),
  ('resilience_proxy', 'vjob', 'MadeSafe'),
  ('resilience_proxy', 'vjob', 'MadeSafeDateUTC'),

  ('resource_time', 'timesheetitem', 'EndDate'),
  ('resource_time', 'timesheetitem', 'Hours'),
  ('resource_time', 'timesheetitem', 'Minutes'),
  ('resource_time', 'timesheetitem', 'Quantity'),
  ('resource_time', 'timesheetitem', 'ResourceName'),
  ('resource_time', 'timesheetitem', 'ResourceType'),
  ('resource_time', 'timesheetitem', 'StartDate'),

  ('risk', 'asset', 'AssetRisk'),
  ('risk', 'vjob', 'Compliant'),
  ('risk', 'vjob', 'HazardCode'),
  ('risk', 'vjob', 'HazardDefectCode'),
  ('risk', 'vjob', 'MadeSafe'),
  ('risk', 'vjob', 'Priority'),

  ('spatial_coverage', 'vassetlocation', 'WKT'),
  ('spatial_coverage', 'vcapitalwork', 'WKT'),
  ('spatial_coverage', 'vcapitalworktask', 'WKT'),
  ('spatial_coverage', 'vinspection', 'WKT'),
  ('spatial_coverage', 'vjob', 'WKT'),

  -- Keep lane-access separate from generic access: it is a traffic/lane access
  -- proxy documented for VicRoads / WRU, not a broad access-to-asset measure.
  ('traffic_lane_access_proxy', 'laneaccess', 'Closure Type'),
  ('traffic_lane_access_proxy', 'laneaccess', 'Is Speed Reduction Applied'),
  ('traffic_lane_access_proxy', 'laneaccess', 'Lane Access Type'),
  ('traffic_lane_access_proxy', 'laneaccess', 'Number of Lane Closed'),
  ('traffic_lane_access_proxy', 'laneaccess', 'Record ID'),
  ('traffic_lane_access_proxy', 'laneaccess', 'Traffic Management Required'),

  ('utilisation_proxy', 'plannedresourceitem', 'Hours'),
  ('utilisation_proxy', 'plannedresourceitem', 'Minutes'),
  ('utilisation_proxy', 'plannedresourceitem', 'Quantity'),
  ('utilisation_proxy', 'plannedresourceitem', 'ResourceType'),
  ('utilisation_proxy', 'timesheetitem', 'Hours'),
  ('utilisation_proxy', 'timesheetitem', 'Quantity'),
  ('utilisation_proxy', 'timesheetitem', 'ResourceType'),

  ('work_orders', 'vjob', 'ActivityCategoryName'),
  ('work_orders', 'vjob', 'ActivityName'),
  ('work_orders', 'vjob', 'AssetCode'),
  ('work_orders', 'vjob', 'AssetID'),
  ('work_orders', 'vjob', 'AssetName'),
  ('work_orders', 'vjob', 'AssignedUser'),
  ('work_orders', 'vjob', 'CompletedDate'),
  ('work_orders', 'vjob', 'CompletedStatus'),
  ('work_orders', 'vjob', 'CompletedUser'),
  ('work_orders', 'vjob', 'CreatedDate'),
  ('work_orders', 'vjob', 'CRMID'),
  ('work_orders', 'vjob', 'CurrentWorkflowItemName'),
  ('work_orders', 'vjob', 'DueDate'),
  ('work_orders', 'vjob', 'ExternalID'),
  ('work_orders', 'vjob', 'ID'),
  ('work_orders', 'vjob', 'InterventionCode'),
  ('work_orders', 'vjob', 'InterventionName'),
  ('work_orders', 'vjob', 'ScheduledEnd'),
  ('work_orders', 'vjob', 'ScheduledStart'),

  ('works_costs', 'plannedresourceitem', 'Cost'),
  ('works_costs', 'timesheetitem', 'Cost'),
  ('works_costs', 'vcapitalwork', 'ActualFinish'),
  ('works_costs', 'vcapitalwork', 'CapitalWorkType'),
  ('works_costs', 'vcapitalwork', 'PlannedStart'),
  ('works_costs', 'vcapitalworktask', 'ActualCost'),
  ('works_costs', 'vcapitalworktask', 'ActualQuantity'),
  ('works_costs', 'vcapitalworktask', 'CapitalWorkID'),
  ('works_costs', 'vcapitalworktask', 'EstimatedCost'),
  ('works_costs', 'vcapitalworktask', 'EstimatedQuantity'),
  ('works_costs', 'vjob', 'ActivityName'),
  ('works_costs', 'vjob', 'ActualQuantity'),
  ('works_costs', 'vjob', 'EstimatedCost'),
  ('works_costs', 'vjob', 'EstimatedQuantity'),
  ('works_costs', 'vjob', 'InterventionName')
AS t(data_need, table_name, column_name);

CREATE OR REPLACE TEMP VIEW av_need_column_relevance AS
WITH labelled AS (
  SELECT
    data_need,
    table_name,
    column_name,
    CASE
      WHEN table_name = 'assetattribute' THEN 'supporting'
      WHEN data_need = 'capital_works' AND column_name = 'WKT' THEN 'supporting'
      WHEN data_need = 'condition' AND table_name = 'vinspection' THEN 'supporting'
      WHEN data_need = 'demand_proxy' AND column_name IN ('ActivityCategoryName', 'EstimatedQuantity', 'Priority') THEN 'supporting'
      WHEN data_need = 'inspection_compliance' AND column_name IN ('AssetID', 'Category', 'ID', 'JobID') THEN 'supporting'
      WHEN data_need = 'inventory' AND column_name IN ('ParentAssetCode', 'ParentAssetID', 'ParentAssetName', 'Stage') THEN 'supporting'
      WHEN data_need = 'network' AND column_name = 'Name' THEN 'supporting'
      WHEN data_need = 'performance_asset' AND column_name IN ('AssetConditionModel', 'ConstructionCost', 'ConstructionDate') THEN 'supporting'
      WHEN data_need = 'quantity_productivity' AND column_name IN ('EstimatedDepth', 'EstimatedLength', 'EstimatedWidth', 'RemainingQuantity') THEN 'supporting'
      WHEN data_need = 'resource_time' AND column_name IN ('Quantity', 'ResourceName') THEN 'supporting'
      WHEN data_need = 'traffic_lane_access_proxy' AND column_name = 'Record ID' THEN 'supporting'
      WHEN data_need = 'work_orders' AND column_name IN ('AssetName', 'AssignedUser', 'CompletedUser', 'CRMID', 'ExternalID') THEN 'supporting'
      WHEN data_need = 'works_costs' AND column_name IN ('ActualFinish', 'CapitalWorkID', 'CapitalWorkType', 'PlannedStart') THEN 'supporting'
      ELSE 'core'
    END AS relevance_role
  FROM av_need_columns
)
SELECT
  data_need,
  table_name,
  column_name,
  relevance_role,
  CASE
    WHEN relevance_role = 'core' THEN 1.0
    WHEN relevance_role = 'supporting' THEN 0.25
    ELSE 0.0
  END AS relevance_weight
FROM labelled;

CREATE OR REPLACE TEMP VIEW av_data_need_examples AS
SELECT * FROM VALUES
  ('access', 'No reliable core Asset Vision access signal mapped yet.', 'not mapped'),
  ('backlog_delivery', 'Can we see backlog timing, status, and priority?', 'vjob.CreatedDate, vjob.DueDate, vjob.CompletedStatus, vjob.Priority'),
  ('capital_works', 'Can we identify planned/actual capital works and costs?', 'vcapitalwork.ID, vcapitalwork.PlannedStart, vcapitalwork.ActualFinish, vcapitalworktask.ActualCost'),
  ('classification', 'Can assets/jobs/inspections be classified?', 'asset.Classification'),
  ('condition', 'Can we see asset condition and when it was assessed?', 'asset.AssetCondition, asset.ConditionDate'),
  ('criticality', 'Can assets be prioritised by criticality?', 'asset.AssetCriticality'),
  ('data_freshness', 'Can we see when records were created, scheduled, completed, or conditioned?', 'vjob.CreatedDate, vjob.CompletedDate, asset.ConditionDate'),
  ('demand_proxy', 'Can scheduled/created work indicate demand?', 'vjob.CreatedDate, vjob.DueDate, vinspection.ScheduledDate'),
  ('inspection_compliance', 'Can we compare scheduled vs completed inspection status?', 'vinspection.ScheduledDate, vinspection.CompletedDate, vinspection.CurrentStatus, vjob.Compliant'),
  ('inventory', 'Can we identify the asset and its type?', 'asset.ID, asset.Code, asset.Name, asset.AssetType'),
  ('network', 'Can we locate the asset on the network?', 'asset.Code, asset.ChainageFrom, asset.ChainageTo, vassetlocation.WKT'),
  ('performance_asset', 'Can we assess condition, risk, and useful life?', 'asset.AssetCondition, asset.AssetRisk, asset.ConditionDate, asset.UsefulLife'),
  ('performance_finance', 'Can we see actual or estimated costs?', 'vjob.EstimatedCost, vcapitalworktask.ActualCost, plannedresourceitem.Cost'),
  ('performance_service', 'Can we assess completion/status against due dates?', 'vjob.DueDate, vjob.CompletedDate, vjob.CompletedStatus, vjob.Compliant'),
  ('quantity_productivity', 'Can we compare actual vs estimated quantities?', 'vjob.ActualQuantity, vjob.EstimatedQuantity, vjob.Unit'),
  ('resilience_proxy', 'Can we see made-safe and response timing?', 'vjob.MadeSafe, vjob.MadeSafeDateUTC, vjob.DueDate'),
  ('resource_time', 'Can we see resource time windows and hours?', 'timesheetitem.StartDate, timesheetitem.EndDate, timesheetitem.Hours, timesheetitem.ResourceType'),
  ('risk', 'Can we see hazard/risk and make-safe indicators?', 'asset.AssetRisk, vjob.HazardCode, vjob.HazardDefectCode, vjob.MadeSafe'),
  ('spatial_coverage', 'Can records be mapped spatially?', 'WKT'),
  ('traffic_lane_access_proxy', 'Can lane closure/access impact be identified?', 'laneaccess.Lane Access Type, laneaccess.Number of Lane Closed, laneaccess.Closure Type'),
  ('utilisation_proxy', 'Can resource usage be approximated?', 'timesheetitem.Hours, timesheetitem.Quantity, plannedresourceitem.ResourceType'),
  ('work_orders', 'Can work order identity, activity, status, and scheduling be tracked?', 'vjob.ID, vjob.ActivityName, vjob.CurrentWorkflowItemName, vjob.ScheduledStart'),
  ('works_costs', 'Can works be linked to quantities and costs?', 'vjob.ActualQuantity, vjob.EstimatedCost, vcapitalworktask.ActualCost')
AS t(data_need, example_signal, example_core_columns);

CREATE OR REPLACE TEMP VIEW av_data_need_example_columns AS
SELECT * FROM VALUES
  ('backlog_delivery', 1, 'vjob', 'CurrentWorkflowItemName', 1),
  ('backlog_delivery', 1, 'vjob', 'DueDate', 2),
  ('backlog_delivery', 1, 'vjob', 'CompletedStatus', 3),
  ('backlog_delivery', 1, 'vjob', 'Priority', 4),

  ('capital_works', 1, 'vcapitalwork', 'ID', 1),
  ('capital_works', 1, 'vcapitalwork', 'Name', 2),
  ('capital_works', 1, 'vcapitalwork', 'PlannedStart', 3),
  ('capital_works', 1, 'vcapitalwork', 'ActualFinish', 4),
  ('capital_works', 2, 'vcapitalworktask', 'CapitalWorkID', 1),
  ('capital_works', 2, 'vcapitalworktask', 'ActualCost', 2),
  ('capital_works', 2, 'vcapitalworktask', 'EstimatedCost', 3),

  ('classification', 1, 'asset', 'Classification', 1),
  ('condition', 1, 'asset', 'AssetCondition', 1),
  ('condition', 1, 'asset', 'ConditionDate', 2),
  ('criticality', 1, 'asset', 'AssetCriticality', 1),

  ('data_freshness', 1, 'vjob', 'CreatedDate', 1),
  ('data_freshness', 1, 'vjob', 'DueDate', 2),
  ('data_freshness', 1, 'vjob', 'CompletedDate', 3),

  ('demand_proxy', 1, 'vjob', 'CreatedDate', 1),
  ('demand_proxy', 1, 'vjob', 'DueDate', 2),
  ('demand_proxy', 1, 'vjob', 'ActivityCategoryName', 3),
  ('demand_proxy', 1, 'vjob', 'Priority', 4),

  ('inspection_compliance', 1, 'vinspection', 'ScheduledDate', 1),
  ('inspection_compliance', 1, 'vinspection', 'CompletedDate', 2),
  ('inspection_compliance', 1, 'vinspection', 'CurrentStatus', 3),
  ('inspection_compliance', 1, 'vinspection', 'InspectionTypeName', 4),
  ('inspection_compliance', 2, 'vjob', 'Compliant', 1),

  ('inventory', 1, 'asset', 'ID', 1),
  ('inventory', 1, 'asset', 'Code', 2),
  ('inventory', 1, 'asset', 'Name', 3),
  ('inventory', 1, 'asset', 'AssetType', 4),

  ('network', 1, 'asset', 'Code', 1),
  ('network', 1, 'asset', 'ChainageFrom', 2),
  ('network', 1, 'asset', 'ChainageTo', 3),
  ('network', 1, 'asset', 'Direction', 4),
  ('network', 2, 'vassetlocation', 'WKT', 1),

  ('performance_asset', 1, 'asset', 'AssetCondition', 1),
  ('performance_asset', 1, 'asset', 'AssetRisk', 2),
  ('performance_asset', 1, 'asset', 'ConditionDate', 3),
  ('performance_asset', 1, 'asset', 'UsefulLife', 4),

  ('performance_finance', 1, 'vcapitalworktask', 'ActualCost', 1),
  ('performance_finance', 1, 'vcapitalworktask', 'EstimatedCost', 2),
  ('performance_finance', 2, 'vjob', 'EstimatedCost', 1),
  ('performance_finance', 3, 'plannedresourceitem', 'Cost', 1),

  ('performance_service', 1, 'vjob', 'DueDate', 1),
  ('performance_service', 1, 'vjob', 'CompletedDate', 2),
  ('performance_service', 1, 'vjob', 'CompletedStatus', 3),
  ('performance_service', 1, 'vjob', 'Compliant', 4),

  ('quantity_productivity', 1, 'vjob', 'ActualQuantity', 1),
  ('quantity_productivity', 1, 'vjob', 'EstimatedQuantity', 2),
  ('quantity_productivity', 1, 'vjob', 'Unit', 3),

  ('resilience_proxy', 1, 'vjob', 'MadeSafe', 1),
  ('resilience_proxy', 1, 'vjob', 'MadeSafeDateUTC', 2),
  ('resilience_proxy', 1, 'vjob', 'DueDate', 3),

  ('resource_time', 1, 'timesheetitem', 'StartDate', 1),
  ('resource_time', 1, 'timesheetitem', 'EndDate', 2),
  ('resource_time', 1, 'timesheetitem', 'Hours', 3),
  ('resource_time', 1, 'timesheetitem', 'ResourceType', 4),

  ('risk', 1, 'vjob', 'HazardCode', 1),
  ('risk', 1, 'vjob', 'HazardDefectCode', 2),
  ('risk', 1, 'vjob', 'MadeSafe', 3),
  ('risk', 1, 'vjob', 'Priority', 4),
  ('risk', 2, 'asset', 'AssetRisk', 1),

  ('spatial_coverage', 1, 'vassetlocation', 'WKT', 1),
  ('spatial_coverage', 2, 'vjob', 'WKT', 1),
  ('spatial_coverage', 3, 'vinspection', 'WKT', 1),

  ('traffic_lane_access_proxy', 1, 'laneaccess', 'Lane Access Type', 1),
  ('traffic_lane_access_proxy', 1, 'laneaccess', 'Number of Lane Closed', 2),
  ('traffic_lane_access_proxy', 1, 'laneaccess', 'Closure Type', 3),

  ('utilisation_proxy', 1, 'timesheetitem', 'Hours', 1),
  ('utilisation_proxy', 1, 'timesheetitem', 'Quantity', 2),
  ('utilisation_proxy', 1, 'timesheetitem', 'ResourceType', 3),
  ('utilisation_proxy', 2, 'plannedresourceitem', 'Hours', 1),
  ('utilisation_proxy', 2, 'plannedresourceitem', 'Quantity', 2),
  ('utilisation_proxy', 2, 'plannedresourceitem', 'ResourceType', 3),

  ('work_orders', 1, 'vjob', 'ID', 1),
  ('work_orders', 1, 'vjob', 'ActivityName', 2),
  ('work_orders', 1, 'vjob', 'CurrentWorkflowItemName', 3),
  ('work_orders', 1, 'vjob', 'ScheduledStart', 4),

  ('works_costs', 1, 'vjob', 'ActivityName', 1),
  ('works_costs', 1, 'vjob', 'ActualQuantity', 2),
  ('works_costs', 1, 'vjob', 'EstimatedCost', 3),
  ('works_costs', 1, 'vjob', 'EstimatedQuantity', 4),
  ('works_costs', 2, 'vcapitalworktask', 'ActualCost', 1),
  ('works_costs', 2, 'vcapitalworktask', 'EstimatedCost', 2)
AS t(data_need, target_rank, table_name, column_name, column_order);

WITH source_tables AS (
  SELECT
    cat.source_catalog AS table_catalog,
    'dbo' AS table_schema,
    table_names.table_name,
    concat(cat.source_catalog, '.dbo.', table_names.table_name) AS source_table
  FROM av_catalogs cat
  CROSS JOIN (
    SELECT DISTINCT table_name
    FROM av_need_columns
    WHERE table_name <> 'laneaccess'
  ) table_names
  UNION ALL
  SELECT
    'ext_mssql_asset_vision_ven_vicroads' AS table_catalog,
    'dbo' AS table_schema,
    'laneaccess' AS table_name,
    'ext_mssql_asset_vision_ven_vicroads.dbo.laneaccess' AS source_table
),
source_table_flags AS (
  SELECT
    st.table_catalog,
    st.table_schema,
    st.table_name,
    st.source_table,
    MAX(CASE WHEN lower(c.column_name) = 'deleted' THEN 1 ELSE 0 END) AS has_deleted,
    MAX(CASE WHEN lower(c.column_name) = 'contract' THEN 1 ELSE 0 END) AS has_contract
  FROM source_tables st
  LEFT JOIN system.information_schema.columns c
    ON lower(c.table_catalog) = lower(st.table_catalog)
   AND lower(c.table_schema) = lower(st.table_schema)
   AND lower(c.table_name) = lower(st.table_name)
  GROUP BY
    st.table_catalog,
    st.table_schema,
    st.table_name,
    st.source_table
),
available_columns AS (
  SELECT
    m.data_need,
    f.source_table,
    f.table_name,
    m.column_name,
    m.relevance_role,
    m.relevance_weight
  FROM source_table_flags f
  JOIN av_need_column_relevance m
    ON m.table_name = f.table_name
  JOIN system.information_schema.columns c
    ON lower(c.table_catalog) = lower(f.table_catalog)
   AND lower(c.table_schema) = lower(f.table_schema)
   AND lower(c.table_name) = lower(f.table_name)
   AND lower(c.column_name) = lower(m.column_name)
),
raw_rows AS (
  SELECT 'ext_mssql_asset_vision_ven_gen7.dbo.asset' AS source_table,
         'asset' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_ven_gen7`.`dbo`.`asset`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_ven_rms.dbo.asset' AS source_table,
         'asset' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_ven_rms`.`dbo`.`asset`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_ven_rms_new.dbo.asset' AS source_table,
         'asset' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_ven_rms_new`.`dbo`.`asset`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_ven_vicroads.dbo.asset' AS source_table,
         'asset' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_ven_vicroads`.`dbo`.`asset`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_vns_gen7.dbo.asset' AS source_table,
         'asset' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_vns_gen7`.`dbo`.`asset`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_vnz_gen7.dbo.asset' AS source_table,
         'asset' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_vnz_gen7`.`dbo`.`asset`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_vsm_gen7.dbo.asset' AS source_table,
         'asset' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_vsm_gen7`.`dbo`.`asset`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_ven_gen7.dbo.assetattribute' AS source_table,
         'assetattribute' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_ven_gen7`.`dbo`.`assetattribute`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_ven_rms.dbo.assetattribute' AS source_table,
         'assetattribute' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_ven_rms`.`dbo`.`assetattribute`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_ven_rms_new.dbo.assetattribute' AS source_table,
         'assetattribute' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_ven_rms_new`.`dbo`.`assetattribute`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_ven_vicroads.dbo.assetattribute' AS source_table,
         'assetattribute' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_ven_vicroads`.`dbo`.`assetattribute`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_vns_gen7.dbo.assetattribute' AS source_table,
         'assetattribute' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_vns_gen7`.`dbo`.`assetattribute`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_vnz_gen7.dbo.assetattribute' AS source_table,
         'assetattribute' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_vnz_gen7`.`dbo`.`assetattribute`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_vsm_gen7.dbo.assetattribute' AS source_table,
         'assetattribute' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_vsm_gen7`.`dbo`.`assetattribute`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_ven_gen7.dbo.assetclassification' AS source_table,
         'assetclassification' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_ven_gen7`.`dbo`.`assetclassification`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_ven_rms.dbo.assetclassification' AS source_table,
         'assetclassification' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_ven_rms`.`dbo`.`assetclassification`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_ven_rms_new.dbo.assetclassification' AS source_table,
         'assetclassification' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_ven_rms_new`.`dbo`.`assetclassification`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_ven_vicroads.dbo.assetclassification' AS source_table,
         'assetclassification' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_ven_vicroads`.`dbo`.`assetclassification`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_vns_gen7.dbo.assetclassification' AS source_table,
         'assetclassification' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_vns_gen7`.`dbo`.`assetclassification`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_vnz_gen7.dbo.assetclassification' AS source_table,
         'assetclassification' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_vnz_gen7`.`dbo`.`assetclassification`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_vsm_gen7.dbo.assetclassification' AS source_table,
         'assetclassification' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_vsm_gen7`.`dbo`.`assetclassification`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_ven_vicroads.dbo.laneaccess' AS source_table,
         'laneaccess' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_ven_vicroads`.`dbo`.`laneaccess`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_ven_gen7.dbo.plannedresourceitem' AS source_table,
         'plannedresourceitem' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_ven_gen7`.`dbo`.`plannedresourceitem`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_ven_rms.dbo.plannedresourceitem' AS source_table,
         'plannedresourceitem' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_ven_rms`.`dbo`.`plannedresourceitem`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_ven_rms_new.dbo.plannedresourceitem' AS source_table,
         'plannedresourceitem' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_ven_rms_new`.`dbo`.`plannedresourceitem`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_ven_vicroads.dbo.plannedresourceitem' AS source_table,
         'plannedresourceitem' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_ven_vicroads`.`dbo`.`plannedresourceitem`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_vns_gen7.dbo.plannedresourceitem' AS source_table,
         'plannedresourceitem' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_vns_gen7`.`dbo`.`plannedresourceitem`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_vnz_gen7.dbo.plannedresourceitem' AS source_table,
         'plannedresourceitem' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_vnz_gen7`.`dbo`.`plannedresourceitem`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_vsm_gen7.dbo.plannedresourceitem' AS source_table,
         'plannedresourceitem' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_vsm_gen7`.`dbo`.`plannedresourceitem`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_ven_gen7.dbo.timesheetitem' AS source_table,
         'timesheetitem' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_ven_gen7`.`dbo`.`timesheetitem`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_ven_rms.dbo.timesheetitem' AS source_table,
         'timesheetitem' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_ven_rms`.`dbo`.`timesheetitem`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_ven_rms_new.dbo.timesheetitem' AS source_table,
         'timesheetitem' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_ven_rms_new`.`dbo`.`timesheetitem`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_ven_vicroads.dbo.timesheetitem' AS source_table,
         'timesheetitem' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_ven_vicroads`.`dbo`.`timesheetitem`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_vns_gen7.dbo.timesheetitem' AS source_table,
         'timesheetitem' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_vns_gen7`.`dbo`.`timesheetitem`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_vnz_gen7.dbo.timesheetitem' AS source_table,
         'timesheetitem' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_vnz_gen7`.`dbo`.`timesheetitem`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_vsm_gen7.dbo.timesheetitem' AS source_table,
         'timesheetitem' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_vsm_gen7`.`dbo`.`timesheetitem`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_ven_gen7.dbo.vassetlocation' AS source_table,
         'vassetlocation' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_ven_gen7`.`dbo`.`vassetlocation`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_ven_rms.dbo.vassetlocation' AS source_table,
         'vassetlocation' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_ven_rms`.`dbo`.`vassetlocation`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_ven_rms_new.dbo.vassetlocation' AS source_table,
         'vassetlocation' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_ven_rms_new`.`dbo`.`vassetlocation`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_ven_vicroads.dbo.vassetlocation' AS source_table,
         'vassetlocation' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_ven_vicroads`.`dbo`.`vassetlocation`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_vns_gen7.dbo.vassetlocation' AS source_table,
         'vassetlocation' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_vns_gen7`.`dbo`.`vassetlocation`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_vnz_gen7.dbo.vassetlocation' AS source_table,
         'vassetlocation' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_vnz_gen7`.`dbo`.`vassetlocation`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_vsm_gen7.dbo.vassetlocation' AS source_table,
         'vassetlocation' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_vsm_gen7`.`dbo`.`vassetlocation`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_ven_gen7.dbo.vcapitalwork' AS source_table,
         'vcapitalwork' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_ven_gen7`.`dbo`.`vcapitalwork`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_ven_rms.dbo.vcapitalwork' AS source_table,
         'vcapitalwork' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_ven_rms`.`dbo`.`vcapitalwork`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_ven_rms_new.dbo.vcapitalwork' AS source_table,
         'vcapitalwork' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_ven_rms_new`.`dbo`.`vcapitalwork`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_ven_vicroads.dbo.vcapitalwork' AS source_table,
         'vcapitalwork' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_ven_vicroads`.`dbo`.`vcapitalwork`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_vns_gen7.dbo.vcapitalwork' AS source_table,
         'vcapitalwork' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_vns_gen7`.`dbo`.`vcapitalwork`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_vnz_gen7.dbo.vcapitalwork' AS source_table,
         'vcapitalwork' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_vnz_gen7`.`dbo`.`vcapitalwork`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_vsm_gen7.dbo.vcapitalwork' AS source_table,
         'vcapitalwork' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_vsm_gen7`.`dbo`.`vcapitalwork`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_ven_gen7.dbo.vcapitalworktask' AS source_table,
         'vcapitalworktask' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_ven_gen7`.`dbo`.`vcapitalworktask`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_ven_rms.dbo.vcapitalworktask' AS source_table,
         'vcapitalworktask' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_ven_rms`.`dbo`.`vcapitalworktask`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_ven_rms_new.dbo.vcapitalworktask' AS source_table,
         'vcapitalworktask' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_ven_rms_new`.`dbo`.`vcapitalworktask`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_ven_vicroads.dbo.vcapitalworktask' AS source_table,
         'vcapitalworktask' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_ven_vicroads`.`dbo`.`vcapitalworktask`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_vns_gen7.dbo.vcapitalworktask' AS source_table,
         'vcapitalworktask' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_vns_gen7`.`dbo`.`vcapitalworktask`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_vnz_gen7.dbo.vcapitalworktask' AS source_table,
         'vcapitalworktask' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_vnz_gen7`.`dbo`.`vcapitalworktask`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_vsm_gen7.dbo.vcapitalworktask' AS source_table,
         'vcapitalworktask' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_vsm_gen7`.`dbo`.`vcapitalworktask`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_ven_gen7.dbo.vinspection' AS source_table,
         'vinspection' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_ven_gen7`.`dbo`.`vinspection`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_ven_rms.dbo.vinspection' AS source_table,
         'vinspection' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_ven_rms`.`dbo`.`vinspection`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_ven_rms_new.dbo.vinspection' AS source_table,
         'vinspection' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_ven_rms_new`.`dbo`.`vinspection`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_ven_vicroads.dbo.vinspection' AS source_table,
         'vinspection' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_ven_vicroads`.`dbo`.`vinspection`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_vns_gen7.dbo.vinspection' AS source_table,
         'vinspection' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_vns_gen7`.`dbo`.`vinspection`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_vnz_gen7.dbo.vinspection' AS source_table,
         'vinspection' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_vnz_gen7`.`dbo`.`vinspection`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_vsm_gen7.dbo.vinspection' AS source_table,
         'vinspection' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_vsm_gen7`.`dbo`.`vinspection`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_ven_gen7.dbo.vjob' AS source_table,
         'vjob' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_ven_gen7`.`dbo`.`vjob`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_ven_rms.dbo.vjob' AS source_table,
         'vjob' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_ven_rms`.`dbo`.`vjob`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_ven_rms_new.dbo.vjob' AS source_table,
         'vjob' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_ven_rms_new`.`dbo`.`vjob`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_ven_vicroads.dbo.vjob' AS source_table,
         'vjob' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_ven_vicroads`.`dbo`.`vjob`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_vns_gen7.dbo.vjob' AS source_table,
         'vjob' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_vns_gen7`.`dbo`.`vjob`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_vnz_gen7.dbo.vjob' AS source_table,
         'vjob' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_vnz_gen7`.`dbo`.`vjob`
  UNION ALL
  SELECT 'ext_mssql_asset_vision_vsm_gen7.dbo.vjob' AS source_table,
         'vjob' AS table_name,
         to_json(struct(*)) AS row_json
  FROM `ext_mssql_asset_vision_vsm_gen7`.`dbo`.`vjob`
),
filtered_rows AS (
  SELECT
    r.source_table,
    r.table_name,
    r.row_json
  FROM raw_rows r
  JOIN source_table_flags f
    ON f.source_table = r.source_table
   AND f.table_name = r.table_name
  WHERE (
      f.has_deleted = 0
      OR COALESCE(try_cast(element_at(from_json(r.row_json, 'MAP<STRING,STRING>'), 'Deleted') AS BOOLEAN), false) = false
    )
    AND (
      f.has_contract = 0
      OR lower(trim(element_at(from_json(r.row_json, 'MAP<STRING,STRING>'), 'Contract'))) IN (
        SELECT lower(trim(sc.raw_contract_name))
        FROM av_selected_contracts sc
      )
    )
),
column_completeness AS (
  SELECT
    ac.data_need,
    ac.source_table,
    ac.column_name,
    ac.relevance_role,
    ac.relevance_weight,
    COUNT(fr.row_json) AS total_rows,
    COALESCE(SUM(
      CASE
        WHEN LENGTH(TRIM(COALESCE(element_at(from_json(fr.row_json, 'MAP<STRING,STRING>'), ac.column_name), ''))) > 0
          THEN 1
        ELSE 0
      END
    ), 0) AS populated_rows
  FROM available_columns ac
  LEFT JOIN filtered_rows fr
    ON fr.source_table = ac.source_table
   AND fr.table_name = ac.table_name
  GROUP BY
    ac.data_need,
    ac.source_table,
    ac.column_name,
    ac.relevance_role,
    ac.relevance_weight
),
example_cells AS (
  SELECT
    ec.data_need,
    ec.target_rank,
    fr.source_table,
    fr.table_name,
    fr.row_json,
    ec.column_name,
    ec.column_order,
    TRIM(COALESCE(element_at(from_json(fr.row_json, 'MAP<STRING,STRING>'), ec.column_name), '')) AS column_value
  FROM av_data_need_example_columns ec
  JOIN filtered_rows fr
    ON fr.table_name = ec.table_name
),
example_populated_cells AS (
  SELECT
    data_need,
    target_rank,
    source_table,
    table_name,
    row_json,
    column_name,
    column_order,
    column_value
  FROM example_cells
  WHERE LENGTH(column_value) > 0
),
example_rows AS (
  SELECT
    data_need,
    source_table,
    table_name,
    row_json,
    MIN(target_rank) AS target_rank,
    COUNT(*) AS populated_example_columns,
    concat_ws(
      ', ',
      transform(
        array_sort(
          collect_list(
            named_struct(
              'column_order',
              column_order,
              'example_text',
              concat(column_name, '=', substr(column_value, 1, 120))
            )
          )
        ),
        x -> x.example_text
      )
    ) AS example_values
  FROM example_populated_cells
  GROUP BY
    data_need,
    source_table,
    table_name,
    row_json
),
ranked_examples AS (
  SELECT
    data_need,
    source_table,
    example_values,
    ROW_NUMBER() OVER (
      PARTITION BY data_need
      ORDER BY target_rank, populated_example_columns DESC, source_table
    ) AS example_rank
  FROM example_rows
),
all_needs AS (
  SELECT data_need FROM av_data_needs
)
SELECT
  n.data_need,
  COALESCE(ex.source_table, 'not mapped') AS example_source_table,
  COALESCE(ex.example_values, e.example_core_columns) AS example_values,
  CASE
    WHEN COUNT(DISTINCT CASE WHEN c.relevance_role = 'core' THEN c.source_table END) = 0 THEN 'not_available'
    WHEN COALESCE(SUM(CASE WHEN c.relevance_role = 'core' THEN c.total_rows ELSE 0 END), 0) = 0 THEN 'available_no_rows'
    ELSE 'available'
  END AS core_availability,
  COUNT(DISTINCT c.source_table) AS matched_source_tables,
  COUNT(DISTINCT concat(c.source_table, '.', c.column_name)) AS matched_table_columns,
  COUNT(DISTINCT CASE WHEN c.relevance_role = 'core' THEN concat(c.source_table, '.', c.column_name) END) AS core_matched_table_columns,
  COUNT(DISTINCT CASE WHEN c.relevance_role = 'supporting' THEN concat(c.source_table, '.', c.column_name) END) AS supporting_matched_table_columns,
  COALESCE(SUM(CASE WHEN c.relevance_role = 'core' THEN c.total_rows ELSE 0 END), 0) AS core_field_checks,
  COALESCE(SUM(CASE WHEN c.relevance_role = 'core' THEN c.populated_rows ELSE 0 END), 0) AS core_populated_field_checks,
  ROUND(
    100.0 * COALESCE(SUM(CASE WHEN c.relevance_role = 'core' THEN c.populated_rows ELSE 0 END), 0)
      / NULLIF(SUM(CASE WHEN c.relevance_role = 'core' THEN c.total_rows ELSE 0 END), 0),
    2
  ) AS core_weighted_completeness_pct,
  ROUND(
    100.0 * COALESCE(SUM(c.populated_rows * c.relevance_weight), 0)
      / NULLIF(SUM(c.total_rows * c.relevance_weight), 0),
    2
  ) AS relevance_weighted_completeness_pct,
  ROUND(MIN(CASE WHEN c.relevance_role = 'core' AND c.total_rows > 0 THEN 100.0 * COALESCE(c.populated_rows, 0) / c.total_rows END), 2) AS core_worst_column_completeness_pct
FROM all_needs n
LEFT JOIN av_data_need_examples e
  ON e.data_need = n.data_need
LEFT JOIN ranked_examples ex
  ON ex.data_need = n.data_need
 AND ex.example_rank = 1
LEFT JOIN column_completeness c
  ON c.data_need = n.data_need
GROUP BY
  n.data_need,
  COALESCE(ex.source_table, 'not mapped'),
  COALESCE(ex.example_values, e.example_core_columns)
ORDER BY n.data_need;
