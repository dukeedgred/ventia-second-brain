CREATE OR REPLACE VIEW transport_dev.integ_transport_assets.vw_gold_transport_governance_field_scope AS
WITH SCOPE_OBJECTS AS (
    SELECT
        object_layer,
        table_schema,
        table_name,
        governance_purpose
    FROM VALUES
        ('bronze', 'integ_transport_assets', 'vw_bronze_transport_asset_base', 'Raw Asset Vision asset register fields used for asset identity, contract, type, condition, criticality, risk, chainage, construction, and useful life.'),
        ('bronze', 'integ_transport_assets', 'vw_bronze_transport_asset_location_base', 'Raw Asset Vision asset location, WKT, direction, and coordinate-validity evidence.'),
        ('bronze', 'integ_transport_assets', 'vw_bronze_transport_asset_attribute_base', 'Raw custom attribute names and values by asset.'),
        ('bronze', 'integ_transport_assets', 'vw_bronze_transport_job_base', 'Raw job/work-order fields used for completion, overdue, hazard, activity, intervention, priority, compliance, quantity, and dimensions.'),
        ('bronze', 'integ_transport_assets', 'vw_bronze_transport_jobasset_base', 'Raw many-to-many job-to-asset bridge.'),
        ('bronze', 'integ_transport_assets', 'vw_bronze_transport_inspection_base', 'Raw inspection fields used for schedule, completion, type, classification, direction, chainage, and linked job/capital work.'),
        ('bronze', 'integ_transport_assets', 'vw_bronze_transport_capitalwork_base', 'Raw capital work fields used for asset-linked works, planned start, and actual finish.'),
        ('bronze', 'integ_transport_assets', 'vw_bronze_transport_photo_base', 'Raw photo evidence linked to Asset Vision source table IDs.'),
        ('bronze', 'integ_transport_assets', 'vw_bronze_transport_planned_resource_item_base', 'Raw planned labour/plant/material quantity, time, and cost fields.'),
        ('bronze', 'integ_transport_assets', 'vw_bronze_transport_timesheet_item_base', 'Raw actual labour/plant/material quantity, time, and cost fields.'),
        ('silver', 'integ_transport_assets', 'vw_silver_transport_asset_with_category', 'Contract standardisation and asset type to asset category mapping.'),
        ('silver', 'integ_transport_assets', 'vw_silver_transport_asset_data_availability_detail', 'One-row-per-asset data availability flags for governance and dashboard rollups.'),
        ('gold', 'integ_transport_assets', 'vw_gold_transport_contract_asset_category_data_availability', 'Contract and asset-category dashboard data completeness view.'),
        ('gold', 'integ_transport_assets', 'vw_gold_transport_contract_kpi_monthly_timeseries', 'Contract monthly KPI timeseries view for jobs, inspections, capital works, photos, planned resources, and timesheets.')
    AS SCOPE(object_layer, table_schema, table_name, governance_purpose)
)
SELECT
    SCOPE.object_layer,
    COLUMNS.table_catalog,
    COLUMNS.table_schema,
    COLUMNS.table_name,
    COLUMNS.ordinal_position,
    COLUMNS.column_name,
    COLUMNS.data_type,
    SCOPE.governance_purpose
FROM transport_dev.information_schema.columns COLUMNS
INNER JOIN SCOPE_OBJECTS SCOPE
    ON COLUMNS.table_schema = SCOPE.table_schema
    AND COLUMNS.table_name = SCOPE.table_name
ORDER BY
    CASE SCOPE.object_layer
        WHEN 'bronze' THEN 1
        WHEN 'silver' THEN 2
        WHEN 'gold' THEN 3
        ELSE 9
    END,
    COLUMNS.table_name,
    COLUMNS.ordinal_position
;

