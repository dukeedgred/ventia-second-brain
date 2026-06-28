CREATE OR REPLACE VIEW transport_dev.integ_transport_assets.vw_silver_transport_asset_data_availability_detail AS
WITH LOCATION_BY_ASSET AS (
    SELECT
        source_context,
        asset_id,
        MAX(has_wkt)               AS has_wkt,
        MAX(has_valid_au_nz_coord) AS has_valid_au_nz_coord
    FROM transport_dev.integ_transport_assets.vw_bronze_transport_asset_location_base
    GROUP BY
        source_context,
        asset_id
),
ATTRIBUTE_BY_ASSET AS (
    SELECT
        source_context,
        asset_id,
        MAX(
            CASE
                WHEN attribute_name IS NOT NULL
                    AND attribute_value IS NOT NULL
                THEN 1
                ELSE 0
            END
        ) AS has_attribute
    FROM transport_dev.integ_transport_assets.vw_bronze_transport_asset_attribute_base
    GROUP BY
        source_context,
        asset_id
),
JOB_BY_ASSET AS (
    SELECT
        JOB_LINK.source_context,
        JOB_LINK.asset_id,
        MAX(1) AS has_job,
        MAX(
            CASE
                WHEN JOB.completed_date IS NOT NULL
                THEN 1
                ELSE 0
            END
        ) AS has_completed_job,
        MAX(
            CASE
                WHEN JOB.due_date IS NOT NULL
                    AND JOB.completed_date IS NULL
                    AND JOB.due_date < CURRENT_TIMESTAMP()
                THEN 1
                ELSE 0
            END
        ) AS has_overdue_job,
        MAX(
            CASE
                WHEN JOB.hazard_defect_code IS NOT NULL
                THEN 1
                ELSE 0
            END
        ) AS has_hazard_defect_code,
        MAX(
            CASE
                WHEN JOB.activity_category_name IS NOT NULL
                    OR JOB.activity_name IS NOT NULL
                    OR JOB.activity_type IS NOT NULL
                THEN 1
                ELSE 0
            END
        ) AS has_activity_detail,
        MAX(
            CASE
                WHEN JOB.intervention_code IS NOT NULL
                THEN 1
                ELSE 0
            END
        ) AS has_intervention_code,
        MAX(
            CASE
                WHEN JOB.priority IS NOT NULL
                THEN 1
                ELSE 0
            END
        ) AS has_priority,
        MAX(
            CASE
                WHEN JOB.compliant IS NOT NULL
                THEN 1
                ELSE 0
            END
        ) AS has_compliance,
        MAX(
            CASE
                WHEN JOB.estimated_quantity IS NOT NULL
                    OR JOB.remaining_quantity IS NOT NULL
                    OR JOB.actual_quantity IS NOT NULL
                THEN 1
                ELSE 0
            END
        ) AS has_job_quantity,
        MAX(
            CASE
                WHEN JOB.estimated_length IS NOT NULL
                    OR JOB.estimated_width IS NOT NULL
                    OR JOB.estimated_depth IS NOT NULL
                THEN 1
                ELSE 0
            END
        ) AS has_job_dimensions
    FROM transport_dev.integ_transport_assets.vw_silver_transport_job_asset_link JOB_LINK
    LEFT JOIN transport_dev.integ_transport_assets.vw_bronze_transport_job_base JOB
        ON JOB_LINK.source_context = JOB.source_context
        AND JOB_LINK.job_id = JOB.job_id
    GROUP BY
        JOB_LINK.source_context,
        JOB_LINK.asset_id
),
INSPECTION_BY_ASSET AS (
    SELECT
        INSPECTION_LINK.source_context,
        INSPECTION_LINK.asset_id,
        MAX(1) AS has_inspection,
        MAX(
            CASE
                WHEN INSPECTION.completed_date IS NOT NULL
                THEN 1
                ELSE 0
            END
        ) AS has_completed_inspection,
        MAX(
            CASE
                WHEN INSPECTION.inspection_type_name IS NOT NULL
                THEN 1
                ELSE 0
            END
        ) AS has_inspection_type,
        MAX(
            CASE
                WHEN INSPECTION.scheduled_date IS NOT NULL
                    OR INSPECTION.scheduled_date_to IS NOT NULL
                THEN 1
                ELSE 0
            END
        ) AS has_inspection_schedule
    FROM transport_dev.integ_transport_assets.vw_silver_transport_inspection_asset_link INSPECTION_LINK
    LEFT JOIN transport_dev.integ_transport_assets.vw_bronze_transport_inspection_base INSPECTION
        ON INSPECTION_LINK.source_context = INSPECTION.source_context
        AND INSPECTION_LINK.inspection_id = INSPECTION.inspection_id
    GROUP BY
        INSPECTION_LINK.source_context,
        INSPECTION_LINK.asset_id
),
CAPITALWORK_BY_ASSET AS (
    SELECT
        source_context,
        asset_id,
        MAX(1) AS has_capitalwork,
        MAX(
            CASE
                WHEN capitalwork_name IS NOT NULL
                THEN 1
                ELSE 0
            END
        ) AS has_capitalwork_name,
        MAX(
            CASE
                WHEN planned_start IS NOT NULL
                THEN 1
                ELSE 0
            END
        ) AS has_capitalwork_planned_start,
        MAX(
            CASE
                WHEN actual_finish IS NOT NULL
                THEN 1
                ELSE 0
            END
        ) AS has_completed_capitalwork
    FROM transport_dev.integ_transport_assets.vw_bronze_transport_capitalwork_base
    WHERE asset_id IS NOT NULL
    GROUP BY
        source_context,
        asset_id
),
PHOTO_BY_ASSET AS (
    SELECT
        source_context,
        asset_id,
        MAX(1) AS has_photo
    FROM transport_dev.integ_transport_assets.vw_silver_transport_photo_asset_link
    GROUP BY
        source_context,
        asset_id
),
PLANNED_RESOURCE_BY_ASSET AS (
    SELECT
        source_context,
        asset_id,
        MAX(1) AS has_planned_resource,
        MAX(
            CASE
                WHEN planned_hours IS NOT NULL
                    OR planned_minutes IS NOT NULL
                THEN 1
                ELSE 0
            END
        ) AS has_planned_resource_time,
        MAX(
            CASE
                WHEN planned_quantity IS NOT NULL
                THEN 1
                ELSE 0
            END
        ) AS has_planned_resource_quantity,
        MAX(
            CASE
                WHEN planned_cost IS NOT NULL
                THEN 1
                ELSE 0
            END
        ) AS has_planned_resource_cost
    FROM transport_dev.integ_transport_assets.vw_silver_transport_planned_resource_asset_link
    GROUP BY
        source_context,
        asset_id
),
TIMESHEET_BY_ASSET AS (
    SELECT
        source_context,
        asset_id,
        MAX(1) AS has_actual_timesheet,
        MAX(
            CASE
                WHEN actual_hours IS NOT NULL
                    OR actual_minutes IS NOT NULL
                THEN 1
                ELSE 0
            END
        ) AS has_actual_timesheet_time,
        MAX(
            CASE
                WHEN actual_quantity IS NOT NULL
                THEN 1
                ELSE 0
            END
        ) AS has_actual_timesheet_quantity,
        MAX(
            CASE
                WHEN actual_cost IS NOT NULL
                THEN 1
                ELSE 0
            END
        ) AS has_actual_timesheet_cost
    FROM transport_dev.integ_transport_assets.vw_silver_transport_timesheet_asset_link
    GROUP BY
        source_context,
        asset_id
)
SELECT
    ASSET.source_context,
    ASSET.source_catalog,
    ASSET.source_label,
    ASSET.raw_contract_name,
    ASSET.standardised_contract_name,
    ASSET.asset_category,
    ASSET.standardised_asset_type_name,
    ASSET.raw_asset_type,
    ASSET.asset_id,
    ASSET.has_classified_asset_category,
    ASSET.has_raw_asset_type,
    ASSET.has_classification,
    ASSET.has_spatial_type,
    ASSET.has_asset_condition,
    ASSET.has_asset_criticality,
    ASSET.has_asset_risk,
    ASSET.has_chainage,
    ASSET.has_construction_date,
    ASSET.has_construction_cost,
    ASSET.has_useful_life,
    ASSET.has_condition_date,
    COALESCE(LOCATION.has_wkt, 0)                         AS has_wkt,
    COALESCE(LOCATION.has_valid_au_nz_coord, 0)           AS has_valid_au_nz_coord,
    COALESCE(ATTRIBUTE.has_attribute, 0)                  AS has_attribute,
    COALESCE(JOB.has_job, 0)                              AS has_job,
    COALESCE(JOB.has_completed_job, 0)                    AS has_completed_job,
    COALESCE(JOB.has_overdue_job, 0)                      AS has_overdue_job,
    COALESCE(JOB.has_hazard_defect_code, 0)               AS has_hazard_defect_code,
    COALESCE(JOB.has_activity_detail, 0)                  AS has_activity_detail,
    COALESCE(JOB.has_intervention_code, 0)                AS has_intervention_code,
    COALESCE(JOB.has_priority, 0)                         AS has_priority,
    COALESCE(JOB.has_compliance, 0)                       AS has_compliance,
    COALESCE(JOB.has_job_quantity, 0)                     AS has_job_quantity,
    COALESCE(JOB.has_job_dimensions, 0)                   AS has_job_dimensions,
    COALESCE(INSPECTION.has_inspection, 0)                AS has_inspection,
    COALESCE(INSPECTION.has_completed_inspection, 0)      AS has_completed_inspection,
    COALESCE(INSPECTION.has_inspection_type, 0)           AS has_inspection_type,
    COALESCE(INSPECTION.has_inspection_schedule, 0)       AS has_inspection_schedule,
    COALESCE(CAPITALWORK.has_capitalwork, 0)              AS has_capitalwork,
    COALESCE(CAPITALWORK.has_capitalwork_name, 0)         AS has_capitalwork_name,
    COALESCE(CAPITALWORK.has_capitalwork_planned_start, 0) AS has_capitalwork_planned_start,
    COALESCE(CAPITALWORK.has_completed_capitalwork, 0)    AS has_completed_capitalwork,
    COALESCE(PHOTO.has_photo, 0)                          AS has_photo,
    COALESCE(PLANNED_RESOURCE.has_planned_resource, 0)    AS has_planned_resource,
    COALESCE(PLANNED_RESOURCE.has_planned_resource_time, 0) AS has_planned_resource_time,
    COALESCE(PLANNED_RESOURCE.has_planned_resource_quantity, 0) AS has_planned_resource_quantity,
    COALESCE(PLANNED_RESOURCE.has_planned_resource_cost, 0) AS has_planned_resource_cost,
    COALESCE(TIMESHEET.has_actual_timesheet, 0)           AS has_actual_timesheet,
    COALESCE(TIMESHEET.has_actual_timesheet_time, 0)      AS has_actual_timesheet_time,
    COALESCE(TIMESHEET.has_actual_timesheet_quantity, 0)  AS has_actual_timesheet_quantity,
    COALESCE(TIMESHEET.has_actual_timesheet_cost, 0)      AS has_actual_timesheet_cost
FROM transport_dev.integ_transport_assets.vw_silver_transport_asset_with_category ASSET
LEFT JOIN LOCATION_BY_ASSET LOCATION
    ON ASSET.source_context = LOCATION.source_context
    AND ASSET.asset_id = LOCATION.asset_id
LEFT JOIN ATTRIBUTE_BY_ASSET ATTRIBUTE
    ON ASSET.source_context = ATTRIBUTE.source_context
    AND ASSET.asset_id = ATTRIBUTE.asset_id
LEFT JOIN JOB_BY_ASSET JOB
    ON ASSET.source_context = JOB.source_context
    AND ASSET.asset_id = JOB.asset_id
LEFT JOIN INSPECTION_BY_ASSET INSPECTION
    ON ASSET.source_context = INSPECTION.source_context
    AND ASSET.asset_id = INSPECTION.asset_id
LEFT JOIN CAPITALWORK_BY_ASSET CAPITALWORK
    ON ASSET.source_context = CAPITALWORK.source_context
    AND ASSET.asset_id = CAPITALWORK.asset_id
LEFT JOIN PHOTO_BY_ASSET PHOTO
    ON ASSET.source_context = PHOTO.source_context
    AND ASSET.asset_id = PHOTO.asset_id
LEFT JOIN PLANNED_RESOURCE_BY_ASSET PLANNED_RESOURCE
    ON ASSET.source_context = PLANNED_RESOURCE.source_context
    AND ASSET.asset_id = PLANNED_RESOURCE.asset_id
LEFT JOIN TIMESHEET_BY_ASSET TIMESHEET
    ON ASSET.source_context = TIMESHEET.source_context
    AND ASSET.asset_id = TIMESHEET.asset_id
;

