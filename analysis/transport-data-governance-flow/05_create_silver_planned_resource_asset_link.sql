CREATE OR REPLACE VIEW transport_dev.integ_transport_assets.vw_silver_transport_planned_resource_asset_link AS
WITH PLANNED_RESOURCE_ASSET_LINK_RAW AS (
    SELECT
        PLAN.source_context,
        PLAN.planned_resource_item_id,
        PLAN.source_table,
        PLAN.source_table_id,
        PLAN.source_table_id AS asset_id,
        PLAN.planned_resource_type_name,
        PLAN.company_rate_name,
        PLAN.resource_code,
        PLAN.resource_name,
        PLAN.resource_type,
        PLAN.start_date,
        PLAN.end_date,
        PLAN.planned_hours,
        PLAN.planned_minutes,
        PLAN.planned_quantity,
        PLAN.planned_cost,
        1 AS has_direct_asset_link,
        0 AS has_job_asset_link,
        0 AS has_inspection_asset_link,
        0 AS has_capitalwork_asset_link
    FROM transport_dev.integ_transport_assets.vw_bronze_transport_planned_resource_item_base PLAN
    WHERE PLAN.source_table IN ('asset', 'vasset')
        AND PLAN.source_table_id IS NOT NULL

    UNION ALL

    SELECT
        PLAN.source_context,
        PLAN.planned_resource_item_id,
        PLAN.source_table,
        PLAN.source_table_id,
        JOB_LINK.asset_id,
        PLAN.planned_resource_type_name,
        PLAN.company_rate_name,
        PLAN.resource_code,
        PLAN.resource_name,
        PLAN.resource_type,
        PLAN.start_date,
        PLAN.end_date,
        PLAN.planned_hours,
        PLAN.planned_minutes,
        PLAN.planned_quantity,
        PLAN.planned_cost,
        0 AS has_direct_asset_link,
        1 AS has_job_asset_link,
        0 AS has_inspection_asset_link,
        0 AS has_capitalwork_asset_link
    FROM transport_dev.integ_transport_assets.vw_bronze_transport_planned_resource_item_base PLAN
    INNER JOIN transport_dev.integ_transport_assets.vw_silver_transport_job_asset_link JOB_LINK
        ON PLAN.source_context = JOB_LINK.source_context
        AND PLAN.source_table_id = JOB_LINK.job_id
    WHERE PLAN.source_table IN ('job', 'vjob')
        AND PLAN.source_table_id IS NOT NULL

    UNION ALL

    SELECT
        PLAN.source_context,
        PLAN.planned_resource_item_id,
        PLAN.source_table,
        PLAN.source_table_id,
        INSPECTION_LINK.asset_id,
        PLAN.planned_resource_type_name,
        PLAN.company_rate_name,
        PLAN.resource_code,
        PLAN.resource_name,
        PLAN.resource_type,
        PLAN.start_date,
        PLAN.end_date,
        PLAN.planned_hours,
        PLAN.planned_minutes,
        PLAN.planned_quantity,
        PLAN.planned_cost,
        0 AS has_direct_asset_link,
        0 AS has_job_asset_link,
        1 AS has_inspection_asset_link,
        0 AS has_capitalwork_asset_link
    FROM transport_dev.integ_transport_assets.vw_bronze_transport_planned_resource_item_base PLAN
    INNER JOIN transport_dev.integ_transport_assets.vw_silver_transport_inspection_asset_link INSPECTION_LINK
        ON PLAN.source_context = INSPECTION_LINK.source_context
        AND PLAN.source_table_id = INSPECTION_LINK.inspection_id
    WHERE PLAN.source_table IN ('inspection', 'vinspection')
        AND PLAN.source_table_id IS NOT NULL

    UNION ALL

    SELECT
        PLAN.source_context,
        PLAN.planned_resource_item_id,
        PLAN.source_table,
        PLAN.source_table_id,
        CAPITALWORK.asset_id,
        PLAN.planned_resource_type_name,
        PLAN.company_rate_name,
        PLAN.resource_code,
        PLAN.resource_name,
        PLAN.resource_type,
        PLAN.start_date,
        PLAN.end_date,
        PLAN.planned_hours,
        PLAN.planned_minutes,
        PLAN.planned_quantity,
        PLAN.planned_cost,
        0 AS has_direct_asset_link,
        0 AS has_job_asset_link,
        0 AS has_inspection_asset_link,
        1 AS has_capitalwork_asset_link
    FROM transport_dev.integ_transport_assets.vw_bronze_transport_planned_resource_item_base PLAN
    INNER JOIN transport_dev.integ_transport_assets.vw_bronze_transport_capitalwork_base CAPITALWORK
        ON PLAN.source_context = CAPITALWORK.source_context
        AND PLAN.source_table_id = CAPITALWORK.capitalwork_id
    WHERE PLAN.source_table IN ('capitalwork', 'vcapitalwork')
        AND PLAN.source_table_id IS NOT NULL
        AND CAPITALWORK.asset_id IS NOT NULL
)
SELECT
    source_context,
    planned_resource_item_id,
    source_table,
    source_table_id,
    asset_id,
    planned_resource_type_name,
    company_rate_name,
    resource_code,
    resource_name,
    resource_type,
    start_date,
    end_date,
    planned_hours,
    planned_minutes,
    planned_quantity,
    planned_cost,
    MAX(has_direct_asset_link)      AS has_direct_asset_link,
    MAX(has_job_asset_link)         AS has_job_asset_link,
    MAX(has_inspection_asset_link)  AS has_inspection_asset_link,
    MAX(has_capitalwork_asset_link) AS has_capitalwork_asset_link
FROM PLANNED_RESOURCE_ASSET_LINK_RAW
GROUP BY
    source_context,
    planned_resource_item_id,
    source_table,
    source_table_id,
    asset_id,
    planned_resource_type_name,
    company_rate_name,
    resource_code,
    resource_name,
    resource_type,
    start_date,
    end_date,
    planned_hours,
    planned_minutes,
    planned_quantity,
    planned_cost
;

