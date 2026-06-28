CREATE OR REPLACE VIEW transport_dev.integ_transport_assets.vw_silver_transport_photo_asset_link AS
WITH PHOTO_ASSET_LINK_RAW AS (
    SELECT
        PHOTO.source_context,
        PHOTO.photo_id,
        PHOTO.source_table,
        PHOTO.source_table_id,
        PHOTO.source_table_id AS asset_id,
        PHOTO.created_date,
        1 AS has_direct_asset_link,
        0 AS has_job_asset_link,
        0 AS has_inspection_asset_link,
        0 AS has_capitalwork_asset_link
    FROM transport_dev.integ_transport_assets.vw_bronze_transport_photo_base PHOTO
    WHERE PHOTO.source_table IN ('asset', 'vasset')
        AND PHOTO.source_table_id IS NOT NULL

    UNION ALL

    SELECT
        PHOTO.source_context,
        PHOTO.photo_id,
        PHOTO.source_table,
        PHOTO.source_table_id,
        JOB_LINK.asset_id,
        PHOTO.created_date,
        0 AS has_direct_asset_link,
        1 AS has_job_asset_link,
        0 AS has_inspection_asset_link,
        0 AS has_capitalwork_asset_link
    FROM transport_dev.integ_transport_assets.vw_bronze_transport_photo_base PHOTO
    INNER JOIN transport_dev.integ_transport_assets.vw_silver_transport_job_asset_link JOB_LINK
        ON PHOTO.source_context = JOB_LINK.source_context
        AND PHOTO.source_table_id = JOB_LINK.job_id
    WHERE PHOTO.source_table IN ('job', 'vjob')
        AND PHOTO.source_table_id IS NOT NULL

    UNION ALL

    SELECT
        PHOTO.source_context,
        PHOTO.photo_id,
        PHOTO.source_table,
        PHOTO.source_table_id,
        INSPECTION_LINK.asset_id,
        PHOTO.created_date,
        0 AS has_direct_asset_link,
        0 AS has_job_asset_link,
        1 AS has_inspection_asset_link,
        0 AS has_capitalwork_asset_link
    FROM transport_dev.integ_transport_assets.vw_bronze_transport_photo_base PHOTO
    INNER JOIN transport_dev.integ_transport_assets.vw_silver_transport_inspection_asset_link INSPECTION_LINK
        ON PHOTO.source_context = INSPECTION_LINK.source_context
        AND PHOTO.source_table_id = INSPECTION_LINK.inspection_id
    WHERE PHOTO.source_table IN ('inspection', 'vinspection')
        AND PHOTO.source_table_id IS NOT NULL

    UNION ALL

    SELECT
        PHOTO.source_context,
        PHOTO.photo_id,
        PHOTO.source_table,
        PHOTO.source_table_id,
        CAPITALWORK.asset_id,
        PHOTO.created_date,
        0 AS has_direct_asset_link,
        0 AS has_job_asset_link,
        0 AS has_inspection_asset_link,
        1 AS has_capitalwork_asset_link
    FROM transport_dev.integ_transport_assets.vw_bronze_transport_photo_base PHOTO
    INNER JOIN transport_dev.integ_transport_assets.vw_bronze_transport_capitalwork_base CAPITALWORK
        ON PHOTO.source_context = CAPITALWORK.source_context
        AND PHOTO.source_table_id = CAPITALWORK.capitalwork_id
    WHERE PHOTO.source_table IN ('capitalwork', 'vcapitalwork')
        AND PHOTO.source_table_id IS NOT NULL
        AND CAPITALWORK.asset_id IS NOT NULL
)
SELECT
    source_context,
    photo_id,
    source_table,
    source_table_id,
    asset_id,
    created_date,
    MAX(has_direct_asset_link)      AS has_direct_asset_link,
    MAX(has_job_asset_link)         AS has_job_asset_link,
    MAX(has_inspection_asset_link)  AS has_inspection_asset_link,
    MAX(has_capitalwork_asset_link) AS has_capitalwork_asset_link
FROM PHOTO_ASSET_LINK_RAW
GROUP BY
    source_context,
    photo_id,
    source_table,
    source_table_id,
    asset_id,
    created_date
;

