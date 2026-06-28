CREATE OR REPLACE VIEW transport_dev.integ_transport_assets.vw_gold_transport_contract_kpi_monthly_timeseries AS
WITH ASSET_DIM AS (
    SELECT DISTINCT
        source_context,
        source_label,
        raw_contract_name,
        standardised_contract_name,
        asset_id
    FROM transport_dev.integ_transport_assets.vw_silver_transport_asset_with_category
    WHERE standardised_contract_name IS NOT NULL
),
JOB_CONTRACT AS (
    SELECT DISTINCT
        JOB.source_context,
        ASSET.source_label,
        ASSET.raw_contract_name,
        ASSET.standardised_contract_name,
        JOB.job_id,
        JOB.due_date,
        JOB.completed_date,
        JOB.hazard_defect_code,
        JOB.activity_category_name,
        JOB.activity_name,
        JOB.activity_type,
        JOB.intervention_code,
        JOB.priority,
        JOB.compliant
    FROM transport_dev.integ_transport_assets.vw_bronze_transport_job_base JOB
    INNER JOIN transport_dev.integ_transport_assets.vw_silver_transport_job_asset_link JOB_LINK
        ON JOB.source_context = JOB_LINK.source_context
        AND JOB.job_id = JOB_LINK.job_id
    INNER JOIN ASSET_DIM ASSET
        ON JOB_LINK.source_context = ASSET.source_context
        AND JOB_LINK.asset_id = ASSET.asset_id
),
INSPECTION_CONTRACT AS (
    SELECT DISTINCT
        INSPECTION.source_context,
        ASSET.source_label,
        ASSET.raw_contract_name,
        ASSET.standardised_contract_name,
        INSPECTION.inspection_id,
        INSPECTION.scheduled_date,
        INSPECTION.scheduled_date_to,
        INSPECTION.completed_date,
        INSPECTION.inspection_type_name
    FROM transport_dev.integ_transport_assets.vw_bronze_transport_inspection_base INSPECTION
    INNER JOIN transport_dev.integ_transport_assets.vw_silver_transport_inspection_asset_link INSPECTION_LINK
        ON INSPECTION.source_context = INSPECTION_LINK.source_context
        AND INSPECTION.inspection_id = INSPECTION_LINK.inspection_id
    INNER JOIN ASSET_DIM ASSET
        ON INSPECTION_LINK.source_context = ASSET.source_context
        AND INSPECTION_LINK.asset_id = ASSET.asset_id
),
CAPITALWORK_CONTRACT AS (
    SELECT DISTINCT
        CAPITALWORK.source_context,
        ASSET.source_label,
        ASSET.raw_contract_name,
        ASSET.standardised_contract_name,
        CAPITALWORK.capitalwork_id,
        CAPITALWORK.planned_start,
        CAPITALWORK.actual_finish
    FROM transport_dev.integ_transport_assets.vw_bronze_transport_capitalwork_base CAPITALWORK
    INNER JOIN ASSET_DIM ASSET
        ON CAPITALWORK.source_context = ASSET.source_context
        AND CAPITALWORK.asset_id = ASSET.asset_id
),
PHOTO_CONTRACT AS (
    SELECT DISTINCT
        PHOTO.source_context,
        ASSET.source_label,
        ASSET.raw_contract_name,
        ASSET.standardised_contract_name,
        PHOTO.photo_id,
        PHOTO.created_date
    FROM transport_dev.integ_transport_assets.vw_silver_transport_photo_asset_link PHOTO
    INNER JOIN ASSET_DIM ASSET
        ON PHOTO.source_context = ASSET.source_context
        AND PHOTO.asset_id = ASSET.asset_id
),
PLANNED_RESOURCE_CONTRACT AS (
    SELECT DISTINCT
        PLAN.source_context,
        ASSET.source_label,
        ASSET.raw_contract_name,
        ASSET.standardised_contract_name,
        PLAN.planned_resource_item_id,
        PLAN.start_date,
        PLAN.planned_hours,
        PLAN.planned_minutes,
        PLAN.planned_quantity,
        PLAN.planned_cost
    FROM transport_dev.integ_transport_assets.vw_silver_transport_planned_resource_asset_link PLAN
    INNER JOIN ASSET_DIM ASSET
        ON PLAN.source_context = ASSET.source_context
        AND PLAN.asset_id = ASSET.asset_id
),
TIMESHEET_CONTRACT AS (
    SELECT DISTINCT
        TIMESHEET.source_context,
        ASSET.source_label,
        ASSET.raw_contract_name,
        ASSET.standardised_contract_name,
        TIMESHEET.timesheet_item_id,
        TIMESHEET.start_date,
        TIMESHEET.actual_hours,
        TIMESHEET.actual_minutes,
        TIMESHEET.actual_quantity,
        TIMESHEET.actual_cost
    FROM transport_dev.integ_transport_assets.vw_silver_transport_timesheet_asset_link TIMESHEET
    INNER JOIN ASSET_DIM ASSET
        ON TIMESHEET.source_context = ASSET.source_context
        AND TIMESHEET.asset_id = ASSET.asset_id
),
MONTHLY_KPI_ROWS AS (
    SELECT
        source_context,
        source_label,
        raw_contract_name,
        standardised_contract_name,
        DATE_TRUNC('MONTH', due_date) AS metric_month,
        'Job' AS kpi_area,
        'Jobs due' AS kpi_name,
        COUNT(DISTINCT CONCAT(source_context, '|', job_id)) AS record_count,
        CAST(NULL AS DOUBLE) AS value_sum,
        CAST(NULL AS STRING) AS value_unit
    FROM JOB_CONTRACT
    WHERE due_date IS NOT NULL
    GROUP BY
        source_context,
        source_label,
        raw_contract_name,
        standardised_contract_name,
        DATE_TRUNC('MONTH', due_date)

    UNION ALL

    SELECT
        source_context,
        source_label,
        raw_contract_name,
        standardised_contract_name,
        DATE_TRUNC('MONTH', completed_date) AS metric_month,
        'Job' AS kpi_area,
        'Jobs completed' AS kpi_name,
        COUNT(DISTINCT CONCAT(source_context, '|', job_id)) AS record_count,
        CAST(NULL AS DOUBLE) AS value_sum,
        CAST(NULL AS STRING) AS value_unit
    FROM JOB_CONTRACT
    WHERE completed_date IS NOT NULL
    GROUP BY
        source_context,
        source_label,
        raw_contract_name,
        standardised_contract_name,
        DATE_TRUNC('MONTH', completed_date)

    UNION ALL

    SELECT
        source_context,
        source_label,
        raw_contract_name,
        standardised_contract_name,
        DATE_TRUNC('MONTH', due_date) AS metric_month,
        'Job' AS kpi_area,
        'Open overdue jobs by due month' AS kpi_name,
        COUNT(DISTINCT CONCAT(source_context, '|', job_id)) AS record_count,
        CAST(NULL AS DOUBLE) AS value_sum,
        CAST(NULL AS STRING) AS value_unit
    FROM JOB_CONTRACT
    WHERE due_date IS NOT NULL
        AND completed_date IS NULL
        AND due_date < CURRENT_TIMESTAMP()
    GROUP BY
        source_context,
        source_label,
        raw_contract_name,
        standardised_contract_name,
        DATE_TRUNC('MONTH', due_date)

    UNION ALL

    SELECT
        source_context,
        source_label,
        raw_contract_name,
        standardised_contract_name,
        DATE_TRUNC('MONTH', due_date) AS metric_month,
        'Job' AS kpi_area,
        'Jobs due with hazard defect code' AS kpi_name,
        COUNT(DISTINCT CONCAT(source_context, '|', job_id)) AS record_count,
        CAST(NULL AS DOUBLE) AS value_sum,
        CAST(NULL AS STRING) AS value_unit
    FROM JOB_CONTRACT
    WHERE due_date IS NOT NULL
        AND hazard_defect_code IS NOT NULL
    GROUP BY
        source_context,
        source_label,
        raw_contract_name,
        standardised_contract_name,
        DATE_TRUNC('MONTH', due_date)

    UNION ALL

    SELECT
        source_context,
        source_label,
        raw_contract_name,
        standardised_contract_name,
        DATE_TRUNC('MONTH', scheduled_date) AS metric_month,
        'Inspection' AS kpi_area,
        'Inspections scheduled' AS kpi_name,
        COUNT(DISTINCT CONCAT(source_context, '|', inspection_id)) AS record_count,
        CAST(NULL AS DOUBLE) AS value_sum,
        CAST(NULL AS STRING) AS value_unit
    FROM INSPECTION_CONTRACT
    WHERE scheduled_date IS NOT NULL
    GROUP BY
        source_context,
        source_label,
        raw_contract_name,
        standardised_contract_name,
        DATE_TRUNC('MONTH', scheduled_date)

    UNION ALL

    SELECT
        source_context,
        source_label,
        raw_contract_name,
        standardised_contract_name,
        DATE_TRUNC('MONTH', completed_date) AS metric_month,
        'Inspection' AS kpi_area,
        'Inspections completed' AS kpi_name,
        COUNT(DISTINCT CONCAT(source_context, '|', inspection_id)) AS record_count,
        CAST(NULL AS DOUBLE) AS value_sum,
        CAST(NULL AS STRING) AS value_unit
    FROM INSPECTION_CONTRACT
    WHERE completed_date IS NOT NULL
    GROUP BY
        source_context,
        source_label,
        raw_contract_name,
        standardised_contract_name,
        DATE_TRUNC('MONTH', completed_date)

    UNION ALL

    SELECT
        source_context,
        source_label,
        raw_contract_name,
        standardised_contract_name,
        DATE_TRUNC('MONTH', planned_start) AS metric_month,
        'Capital work' AS kpi_area,
        'Capital works planned start' AS kpi_name,
        COUNT(DISTINCT CONCAT(source_context, '|', capitalwork_id)) AS record_count,
        CAST(NULL AS DOUBLE) AS value_sum,
        CAST(NULL AS STRING) AS value_unit
    FROM CAPITALWORK_CONTRACT
    WHERE planned_start IS NOT NULL
    GROUP BY
        source_context,
        source_label,
        raw_contract_name,
        standardised_contract_name,
        DATE_TRUNC('MONTH', planned_start)

    UNION ALL

    SELECT
        source_context,
        source_label,
        raw_contract_name,
        standardised_contract_name,
        DATE_TRUNC('MONTH', actual_finish) AS metric_month,
        'Capital work' AS kpi_area,
        'Capital works completed' AS kpi_name,
        COUNT(DISTINCT CONCAT(source_context, '|', capitalwork_id)) AS record_count,
        CAST(NULL AS DOUBLE) AS value_sum,
        CAST(NULL AS STRING) AS value_unit
    FROM CAPITALWORK_CONTRACT
    WHERE actual_finish IS NOT NULL
    GROUP BY
        source_context,
        source_label,
        raw_contract_name,
        standardised_contract_name,
        DATE_TRUNC('MONTH', actual_finish)

    UNION ALL

    SELECT
        source_context,
        source_label,
        raw_contract_name,
        standardised_contract_name,
        DATE_TRUNC('MONTH', created_date) AS metric_month,
        'Photo' AS kpi_area,
        'Photos captured' AS kpi_name,
        COUNT(DISTINCT CONCAT(source_context, '|', photo_id)) AS record_count,
        CAST(NULL AS DOUBLE) AS value_sum,
        CAST(NULL AS STRING) AS value_unit
    FROM PHOTO_CONTRACT
    WHERE created_date IS NOT NULL
    GROUP BY
        source_context,
        source_label,
        raw_contract_name,
        standardised_contract_name,
        DATE_TRUNC('MONTH', created_date)

    UNION ALL

    SELECT
        source_context,
        source_label,
        raw_contract_name,
        standardised_contract_name,
        DATE_TRUNC('MONTH', start_date) AS metric_month,
        'Planned resource' AS kpi_area,
        'Planned resource hours' AS kpi_name,
        COUNT(DISTINCT CONCAT(source_context, '|', planned_resource_item_id)) AS record_count,
        SUM(COALESCE(planned_hours, 0) + COALESCE(planned_minutes, 0) / 60.0) AS value_sum,
        'hours' AS value_unit
    FROM PLANNED_RESOURCE_CONTRACT
    WHERE start_date IS NOT NULL
        AND (
            planned_hours IS NOT NULL
            OR planned_minutes IS NOT NULL
        )
    GROUP BY
        source_context,
        source_label,
        raw_contract_name,
        standardised_contract_name,
        DATE_TRUNC('MONTH', start_date)

    UNION ALL

    SELECT
        source_context,
        source_label,
        raw_contract_name,
        standardised_contract_name,
        DATE_TRUNC('MONTH', start_date) AS metric_month,
        'Planned resource' AS kpi_area,
        'Planned resource quantity' AS kpi_name,
        COUNT(DISTINCT CONCAT(source_context, '|', planned_resource_item_id)) AS record_count,
        SUM(planned_quantity) AS value_sum,
        'quantity' AS value_unit
    FROM PLANNED_RESOURCE_CONTRACT
    WHERE start_date IS NOT NULL
        AND planned_quantity IS NOT NULL
    GROUP BY
        source_context,
        source_label,
        raw_contract_name,
        standardised_contract_name,
        DATE_TRUNC('MONTH', start_date)

    UNION ALL

    SELECT
        source_context,
        source_label,
        raw_contract_name,
        standardised_contract_name,
        DATE_TRUNC('MONTH', start_date) AS metric_month,
        'Planned resource' AS kpi_area,
        'Planned resource cost' AS kpi_name,
        COUNT(DISTINCT CONCAT(source_context, '|', planned_resource_item_id)) AS record_count,
        SUM(planned_cost) AS value_sum,
        'cost' AS value_unit
    FROM PLANNED_RESOURCE_CONTRACT
    WHERE start_date IS NOT NULL
        AND planned_cost IS NOT NULL
    GROUP BY
        source_context,
        source_label,
        raw_contract_name,
        standardised_contract_name,
        DATE_TRUNC('MONTH', start_date)

    UNION ALL

    SELECT
        source_context,
        source_label,
        raw_contract_name,
        standardised_contract_name,
        DATE_TRUNC('MONTH', start_date) AS metric_month,
        'Actual timesheet' AS kpi_area,
        'Actual timesheet hours' AS kpi_name,
        COUNT(DISTINCT CONCAT(source_context, '|', timesheet_item_id)) AS record_count,
        SUM(COALESCE(actual_hours, 0) + COALESCE(actual_minutes, 0) / 60.0) AS value_sum,
        'hours' AS value_unit
    FROM TIMESHEET_CONTRACT
    WHERE start_date IS NOT NULL
        AND (
            actual_hours IS NOT NULL
            OR actual_minutes IS NOT NULL
        )
    GROUP BY
        source_context,
        source_label,
        raw_contract_name,
        standardised_contract_name,
        DATE_TRUNC('MONTH', start_date)

    UNION ALL

    SELECT
        source_context,
        source_label,
        raw_contract_name,
        standardised_contract_name,
        DATE_TRUNC('MONTH', start_date) AS metric_month,
        'Actual timesheet' AS kpi_area,
        'Actual timesheet quantity' AS kpi_name,
        COUNT(DISTINCT CONCAT(source_context, '|', timesheet_item_id)) AS record_count,
        SUM(actual_quantity) AS value_sum,
        'quantity' AS value_unit
    FROM TIMESHEET_CONTRACT
    WHERE start_date IS NOT NULL
        AND actual_quantity IS NOT NULL
    GROUP BY
        source_context,
        source_label,
        raw_contract_name,
        standardised_contract_name,
        DATE_TRUNC('MONTH', start_date)

    UNION ALL

    SELECT
        source_context,
        source_label,
        raw_contract_name,
        standardised_contract_name,
        DATE_TRUNC('MONTH', start_date) AS metric_month,
        'Actual timesheet' AS kpi_area,
        'Actual timesheet cost' AS kpi_name,
        COUNT(DISTINCT CONCAT(source_context, '|', timesheet_item_id)) AS record_count,
        SUM(actual_cost) AS value_sum,
        'cost' AS value_unit
    FROM TIMESHEET_CONTRACT
    WHERE start_date IS NOT NULL
        AND actual_cost IS NOT NULL
    GROUP BY
        source_context,
        source_label,
        raw_contract_name,
        standardised_contract_name,
        DATE_TRUNC('MONTH', start_date)
)
SELECT
    source_context,
    source_label,
    raw_contract_name,
    standardised_contract_name,
    metric_month,
    kpi_area,
    kpi_name,
    record_count,
    value_sum,
    value_unit
FROM MONTHLY_KPI_ROWS
;

