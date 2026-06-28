CREATE OR REPLACE VIEW transport_dev.integ_transport_assets.vw_silver_transport_inspection_asset_link AS
WITH INSPECTION_ASSET_LINK_RAW AS (
    SELECT
        source_context,
        inspection_id,
        asset_id,
        1 AS has_direct_inspection_asset_link,
        0 AS has_job_asset_link,
        0 AS has_capitalwork_asset_link
    FROM transport_dev.integ_transport_assets.vw_bronze_transport_inspection_base
    WHERE inspection_id IS NOT NULL
        AND asset_id IS NOT NULL

    UNION ALL

    SELECT
        INSPECTION.source_context,
        INSPECTION.inspection_id,
        JOB_LINK.asset_id,
        0 AS has_direct_inspection_asset_link,
        1 AS has_job_asset_link,
        0 AS has_capitalwork_asset_link
    FROM transport_dev.integ_transport_assets.vw_bronze_transport_inspection_base INSPECTION
    INNER JOIN transport_dev.integ_transport_assets.vw_silver_transport_job_asset_link JOB_LINK
        ON INSPECTION.source_context = JOB_LINK.source_context
        AND INSPECTION.job_id = JOB_LINK.job_id
    WHERE INSPECTION.inspection_id IS NOT NULL
        AND INSPECTION.job_id IS NOT NULL

    UNION ALL

    SELECT
        INSPECTION.source_context,
        INSPECTION.inspection_id,
        CAPITALWORK.asset_id,
        0 AS has_direct_inspection_asset_link,
        0 AS has_job_asset_link,
        1 AS has_capitalwork_asset_link
    FROM transport_dev.integ_transport_assets.vw_bronze_transport_inspection_base INSPECTION
    INNER JOIN transport_dev.integ_transport_assets.vw_bronze_transport_capitalwork_base CAPITALWORK
        ON INSPECTION.source_context = CAPITALWORK.source_context
        AND INSPECTION.capitalwork_id = CAPITALWORK.capitalwork_id
    WHERE INSPECTION.inspection_id IS NOT NULL
        AND INSPECTION.capitalwork_id IS NOT NULL
        AND CAPITALWORK.asset_id IS NOT NULL
)
SELECT
    source_context,
    inspection_id,
    asset_id,
    MAX(has_direct_inspection_asset_link) AS has_direct_inspection_asset_link,
    MAX(has_job_asset_link)               AS has_job_asset_link,
    MAX(has_capitalwork_asset_link)       AS has_capitalwork_asset_link
FROM INSPECTION_ASSET_LINK_RAW
GROUP BY
    source_context,
    inspection_id,
    asset_id
;

