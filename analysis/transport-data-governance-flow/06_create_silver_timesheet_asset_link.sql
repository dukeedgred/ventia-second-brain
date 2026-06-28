CREATE OR REPLACE VIEW transport_dev.integ_transport_assets.vw_silver_transport_timesheet_asset_link AS
WITH TIMESHEET_ASSET_LINK_RAW AS (
    SELECT
        TIMESHEET.source_context,
        TIMESHEET.timesheet_item_id,
        TIMESHEET.source_table,
        TIMESHEET.source_table_id,
        TIMESHEET.source_table_id AS asset_id,
        TIMESHEET.timesheet_type_name,
        TIMESHEET.company_rate_name,
        TIMESHEET.resource_code,
        TIMESHEET.resource_name,
        TIMESHEET.resource_type,
        TIMESHEET.start_date,
        TIMESHEET.end_date,
        TIMESHEET.actual_hours,
        TIMESHEET.actual_minutes,
        TIMESHEET.actual_quantity,
        TIMESHEET.actual_cost,
        1 AS has_direct_asset_link,
        0 AS has_job_asset_link,
        0 AS has_inspection_asset_link,
        0 AS has_capitalwork_asset_link
    FROM transport_dev.integ_transport_assets.vw_bronze_transport_timesheet_item_base TIMESHEET
    WHERE TIMESHEET.source_table IN ('asset', 'vasset')
        AND TIMESHEET.source_table_id IS NOT NULL

    UNION ALL

    SELECT
        TIMESHEET.source_context,
        TIMESHEET.timesheet_item_id,
        TIMESHEET.source_table,
        TIMESHEET.source_table_id,
        JOB_LINK.asset_id,
        TIMESHEET.timesheet_type_name,
        TIMESHEET.company_rate_name,
        TIMESHEET.resource_code,
        TIMESHEET.resource_name,
        TIMESHEET.resource_type,
        TIMESHEET.start_date,
        TIMESHEET.end_date,
        TIMESHEET.actual_hours,
        TIMESHEET.actual_minutes,
        TIMESHEET.actual_quantity,
        TIMESHEET.actual_cost,
        0 AS has_direct_asset_link,
        1 AS has_job_asset_link,
        0 AS has_inspection_asset_link,
        0 AS has_capitalwork_asset_link
    FROM transport_dev.integ_transport_assets.vw_bronze_transport_timesheet_item_base TIMESHEET
    INNER JOIN transport_dev.integ_transport_assets.vw_silver_transport_job_asset_link JOB_LINK
        ON TIMESHEET.source_context = JOB_LINK.source_context
        AND TIMESHEET.source_table_id = JOB_LINK.job_id
    WHERE TIMESHEET.source_table IN ('job', 'vjob')
        AND TIMESHEET.source_table_id IS NOT NULL

    UNION ALL

    SELECT
        TIMESHEET.source_context,
        TIMESHEET.timesheet_item_id,
        TIMESHEET.source_table,
        TIMESHEET.source_table_id,
        INSPECTION_LINK.asset_id,
        TIMESHEET.timesheet_type_name,
        TIMESHEET.company_rate_name,
        TIMESHEET.resource_code,
        TIMESHEET.resource_name,
        TIMESHEET.resource_type,
        TIMESHEET.start_date,
        TIMESHEET.end_date,
        TIMESHEET.actual_hours,
        TIMESHEET.actual_minutes,
        TIMESHEET.actual_quantity,
        TIMESHEET.actual_cost,
        0 AS has_direct_asset_link,
        0 AS has_job_asset_link,
        1 AS has_inspection_asset_link,
        0 AS has_capitalwork_asset_link
    FROM transport_dev.integ_transport_assets.vw_bronze_transport_timesheet_item_base TIMESHEET
    INNER JOIN transport_dev.integ_transport_assets.vw_silver_transport_inspection_asset_link INSPECTION_LINK
        ON TIMESHEET.source_context = INSPECTION_LINK.source_context
        AND TIMESHEET.source_table_id = INSPECTION_LINK.inspection_id
    WHERE TIMESHEET.source_table IN ('inspection', 'vinspection')
        AND TIMESHEET.source_table_id IS NOT NULL

    UNION ALL

    SELECT
        TIMESHEET.source_context,
        TIMESHEET.timesheet_item_id,
        TIMESHEET.source_table,
        TIMESHEET.source_table_id,
        CAPITALWORK.asset_id,
        TIMESHEET.timesheet_type_name,
        TIMESHEET.company_rate_name,
        TIMESHEET.resource_code,
        TIMESHEET.resource_name,
        TIMESHEET.resource_type,
        TIMESHEET.start_date,
        TIMESHEET.end_date,
        TIMESHEET.actual_hours,
        TIMESHEET.actual_minutes,
        TIMESHEET.actual_quantity,
        TIMESHEET.actual_cost,
        0 AS has_direct_asset_link,
        0 AS has_job_asset_link,
        0 AS has_inspection_asset_link,
        1 AS has_capitalwork_asset_link
    FROM transport_dev.integ_transport_assets.vw_bronze_transport_timesheet_item_base TIMESHEET
    INNER JOIN transport_dev.integ_transport_assets.vw_bronze_transport_capitalwork_base CAPITALWORK
        ON TIMESHEET.source_context = CAPITALWORK.source_context
        AND TIMESHEET.source_table_id = CAPITALWORK.capitalwork_id
    WHERE TIMESHEET.source_table IN ('capitalwork', 'vcapitalwork')
        AND TIMESHEET.source_table_id IS NOT NULL
        AND CAPITALWORK.asset_id IS NOT NULL
)
SELECT
    source_context,
    timesheet_item_id,
    source_table,
    source_table_id,
    asset_id,
    timesheet_type_name,
    company_rate_name,
    resource_code,
    resource_name,
    resource_type,
    start_date,
    end_date,
    actual_hours,
    actual_minutes,
    actual_quantity,
    actual_cost,
    MAX(has_direct_asset_link)      AS has_direct_asset_link,
    MAX(has_job_asset_link)         AS has_job_asset_link,
    MAX(has_inspection_asset_link)  AS has_inspection_asset_link,
    MAX(has_capitalwork_asset_link) AS has_capitalwork_asset_link
FROM TIMESHEET_ASSET_LINK_RAW
GROUP BY
    source_context,
    timesheet_item_id,
    source_table,
    source_table_id,
    asset_id,
    timesheet_type_name,
    company_rate_name,
    resource_code,
    resource_name,
    resource_type,
    start_date,
    end_date,
    actual_hours,
    actual_minutes,
    actual_quantity,
    actual_cost
;

