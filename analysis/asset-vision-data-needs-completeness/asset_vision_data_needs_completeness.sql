-- Databricks SQL
-- Asset Vision data-needs availability and completeness checks.
--
-- How to run:
--   0. Create or refresh transport_dev.integ_transport_assets.contract_group_map.
--   1. Run the four CREATE TEMP VIEW statements.
--   2. Run the availability summary to confirm which mapped columns exist.
--   3. Run the generator query. Copy the single completeness_sql value it returns.
--   4. Run that generated SQL to calculate completeness by data_need.
--
-- Contract scope:
--   Completeness scans are filtered to raw_contract_name values in
--   transport_dev.integ_transport_assets.contract_group_map where
--   standardised_contract_name IS NOT NULL. The filter is applied to source
--   tables that expose a Contract column. Source tables without Contract are
--   still scanned because this SQL cannot safely infer their contract without a
--   table-specific join path.
--
-- Why this file exists:
--   A naive generator can accidentally concatenate multiple SELECT statements
--   with commas inside a single SELECT. This file generates one valid table-level
--   aggregate per physical source table and joins those aggregates with UNION ALL.
--   The completeness generator also emits quote-sensitive SQL fragments via
--   chr(39) and LENGTH(TRIM(...)) so string literals are not stripped.

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

-- Availability summary. This is schema-only and should run quickly.
WITH cols AS (
  SELECT
    table_catalog,
    table_schema,
    table_name,
    column_name,
    data_type,
    lower(table_catalog) AS table_catalog_lc,
    lower(table_schema) AS table_schema_lc,
    lower(table_name) AS table_name_lc,
    lower(column_name) AS column_name_lc
  FROM system.information_schema.columns
  WHERE lower(table_schema) = 'dbo'
),
column_checks AS (
  SELECT
    n.data_need,
    n.table_name AS expected_table,
    n.column_name AS expected_column,
    cat.source_context,
    cat.source_catalog,
    cat.source_label,
    c.column_name AS available_column_name,
    c.data_type
  FROM av_need_columns n
  CROSS JOIN av_catalogs cat
  LEFT JOIN cols c
    ON c.table_catalog_lc = lower(cat.source_catalog)
   AND c.table_schema_lc = 'dbo'
   AND c.table_name_lc = lower(n.table_name)
   AND c.column_name_lc = lower(n.column_name)
)
SELECT
  dn.data_need,
  CASE
    WHEN COUNT(cc.available_column_name) = 0 THEN 'not_available'
    WHEN COUNT(cc.available_column_name) < COUNT(cc.expected_column) THEN 'partially_available'
    ELSE 'available'
  END AS availability,
  COUNT(cc.expected_column) AS expected_catalog_table_columns,
  COUNT(cc.available_column_name) AS available_catalog_table_columns,
  COUNT(DISTINCT CASE WHEN cc.available_column_name IS NOT NULL THEN cc.source_catalog END) AS source_catalogs_with_matches,
  COUNT(DISTINCT CASE WHEN cc.available_column_name IS NOT NULL THEN concat(cc.expected_table, '.', cc.expected_column) END) AS matched_table_columns,
  concat_ws(', ', sort_array(collect_set(CASE WHEN cc.available_column_name IS NOT NULL THEN concat(cc.source_catalog, '.dbo.', cc.expected_table) END))) AS matched_source_tables,
  concat_ws(', ', sort_array(collect_set(CASE WHEN cc.available_column_name IS NOT NULL THEN concat(cc.expected_table, '.', cc.expected_column) END))) AS matched_columns
FROM av_data_needs dn
LEFT JOIN column_checks cc
  ON cc.data_need = dn.data_need
GROUP BY dn.data_need
ORDER BY dn.data_need;

-- Completeness SQL generator.
--
-- Copy the returned completeness_sql value and run it as a separate statement.
-- It only includes columns that exist in system.information_schema, so a missing
-- column will not break the generated completeness query.
WITH cols AS (
  SELECT
    table_catalog,
    table_schema,
    table_name,
    column_name,
    lower(table_catalog) AS table_catalog_lc,
    lower(table_schema) AS table_schema_lc,
    lower(table_name) AS table_name_lc,
    lower(column_name) AS column_name_lc
  FROM system.information_schema.columns
  WHERE lower(table_schema) = 'dbo'
),
deleted_tables AS (
  SELECT DISTINCT
    table_catalog_lc,
    table_schema_lc,
    table_name_lc
  FROM cols
  WHERE column_name_lc = 'deleted'
),
contract_tables AS (
  SELECT DISTINCT
    table_catalog_lc,
    table_schema_lc,
    table_name_lc
  FROM cols
  WHERE column_name_lc = 'contract'
),
available AS (
  SELECT
    n.data_need,
    n.table_name AS expected_table,
    n.column_name AS expected_column,
    c.table_catalog,
    c.table_schema,
    c.table_name,
    c.column_name,
    row_number() OVER (
      PARTITION BY c.table_catalog, c.table_schema, c.table_name
      ORDER BY n.data_need, n.table_name, n.column_name
    ) AS metric_ordinal
  FROM av_need_columns n
  JOIN av_catalogs cat
    ON true
  JOIN cols c
    ON c.table_catalog_lc = lower(cat.source_catalog)
   AND c.table_schema_lc = 'dbo'
   AND c.table_name_lc = lower(n.table_name)
   AND c.column_name_lc = lower(n.column_name)
),
column_sql AS (
  SELECT
    data_need,
    expected_table,
    expected_column,
    table_catalog,
    table_schema,
    table_name,
    column_name,
    metric_ordinal,
    concat(
      'SUM(CASE WHEN CAST(`',
      replace(column_name, '`', '``'),
      '` AS STRING) IS NOT NULL AND LENGTH(TRIM(CAST(`',
      replace(column_name, '`', '``'),
      '` AS STRING))) > 0 THEN 1 ELSE 0 END) AS c_',
      lpad(CAST(metric_ordinal AS STRING), 4, '0')
    ) AS aggregate_sql,
    concat(
      chr(39),
      replace(data_need, chr(39), concat(chr(39), chr(39))),
      chr(39),
      ', ',
      chr(39),
      replace(concat(table_catalog, '.', table_schema, '.', table_name), chr(39), concat(chr(39), chr(39))),
      chr(39),
      ', ',
      chr(39),
      replace(column_name, chr(39), concat(chr(39), chr(39))),
      chr(39),
      ', c_',
      lpad(CAST(metric_ordinal AS STRING), 4, '0')
    ) AS stack_sql
  FROM available
),
table_sql AS (
  SELECT
    cs.table_catalog,
    cs.table_schema,
    cs.table_name,
    concat(
      'SELECT data_need, source_table, column_name, total_rows, COALESCE(populated_rows, 0) AS populated_rows',
      '\nFROM (',
      '\n  SELECT',
      '\n    COUNT(*) AS total_rows,',
      '\n    ',
      concat_ws(
        ',\n    ',
        transform(
          array_sort(collect_list(named_struct('sort_key', cs.metric_ordinal, 'sql_text', cs.aggregate_sql))),
          x -> x.sql_text
        )
      ),
      '\n  FROM `',
      cs.table_catalog,
      '`.`',
      cs.table_schema,
      '`.`',
      cs.table_name,
      '`',
      CASE
        WHEN MAX(CASE WHEN d.table_name_lc IS NOT NULL THEN 1 ELSE 0 END) = 1
         AND MAX(CASE WHEN ct.table_name_lc IS NOT NULL THEN 1 ELSE 0 END) = 1
          THEN '\n  WHERE COALESCE(`Deleted`, false) = false\n    AND EXISTS (\n      SELECT 1\n      FROM av_selected_contracts sc\n      WHERE lower(trim(sc.raw_contract_name)) = lower(trim(CAST(`Contract` AS STRING)))\n    )'
        WHEN MAX(CASE WHEN d.table_name_lc IS NOT NULL THEN 1 ELSE 0 END) = 1
          THEN '\n  WHERE COALESCE(`Deleted`, false) = false'
        WHEN MAX(CASE WHEN ct.table_name_lc IS NOT NULL THEN 1 ELSE 0 END) = 1
          THEN '\n  WHERE EXISTS (\n      SELECT 1\n      FROM av_selected_contracts sc\n      WHERE lower(trim(sc.raw_contract_name)) = lower(trim(CAST(`Contract` AS STRING)))\n    )'
        ELSE ''
      END,
      '\n) agg',
      '\nLATERAL VIEW stack(',
      COUNT(*),
      ',\n    ',
      concat_ws(
        ',\n    ',
        transform(
          array_sort(collect_list(named_struct('sort_key', cs.metric_ordinal, 'sql_text', cs.stack_sql))),
          x -> x.sql_text
        )
      ),
      '\n) s AS data_need, source_table, column_name, populated_rows'
    ) AS table_select_sql
  FROM column_sql cs
  LEFT JOIN deleted_tables d
    ON d.table_catalog_lc = lower(cs.table_catalog)
   AND d.table_schema_lc = lower(cs.table_schema)
   AND d.table_name_lc = lower(cs.table_name)
  LEFT JOIN contract_tables ct
    ON ct.table_catalog_lc = lower(cs.table_catalog)
   AND ct.table_schema_lc = lower(cs.table_schema)
   AND ct.table_name_lc = lower(cs.table_name)
  GROUP BY
    cs.table_catalog,
    cs.table_schema,
    cs.table_name
)
SELECT concat(
  'WITH column_completeness AS (',
  '\n',
  concat_ws('\nUNION ALL\n', sort_array(collect_list(table_select_sql))),
  '\n), all_needs AS (',
  '\n  SELECT data_need FROM av_data_needs',
  '\n)',
  '\nSELECT',
  '\n  n.data_need,',
  '\n  CASE',
  '\n    WHEN COUNT(DISTINCT c.source_table) = 0 THEN ', chr(39), 'not_available', chr(39),
  '\n    WHEN COALESCE(SUM(c.total_rows), 0) = 0 THEN ', chr(39), 'available_no_rows', chr(39),
  '\n    ELSE ', chr(39), 'available', chr(39),
  '\n  END AS availability,',
  '\n  COUNT(DISTINCT c.source_table) AS matched_source_tables,',
  '\n  COUNT(DISTINCT concat(c.source_table, ', chr(39), '.', chr(39), ', c.column_name)) AS matched_table_columns,',
  '\n  concat_ws(', chr(39), ', ', chr(39), ', sort_array(collect_set(CASE WHEN c.source_table IS NOT NULL THEN concat(c.source_table, ', chr(39), '.', chr(39), ', c.column_name) END))) AS columns_used,',
  '\n  COALESCE(SUM(c.total_rows), 0) AS total_field_checks,',
  '\n  COALESCE(SUM(c.populated_rows), 0) AS populated_field_checks,',
  '\n  ROUND(100.0 * COALESCE(SUM(c.populated_rows), 0) / NULLIF(SUM(c.total_rows), 0), 2) AS weighted_completeness_pct,',
  '\n  ROUND(AVG(CASE WHEN c.total_rows > 0 THEN 100.0 * COALESCE(c.populated_rows, 0) / c.total_rows END), 2) AS avg_column_completeness_pct,',
  '\n  ROUND(MIN(CASE WHEN c.total_rows > 0 THEN 100.0 * COALESCE(c.populated_rows, 0) / c.total_rows END), 2) AS worst_column_completeness_pct',
  '\nFROM all_needs n',
  '\nLEFT JOIN column_completeness c',
  '\n  ON c.data_need = n.data_need',
  '\nGROUP BY n.data_need',
  '\nORDER BY n.data_need'
) AS completeness_sql
FROM table_sql;
