CREATE OR REPLACE VIEW transport_dev.integ_transport_assets.vw_silver_transport_job_asset_link AS
WITH JOB_ASSET_LINK_RAW AS (
    SELECT
        source_context,
        job_id,
        asset_id,
        1 AS has_direct_job_asset_link,
        0 AS has_jobasset_table_link
    FROM transport_dev.integ_transport_assets.vw_bronze_transport_job_base
    WHERE job_id IS NOT NULL
        AND asset_id IS NOT NULL

    UNION ALL

    SELECT
        source_context,
        job_id,
        asset_id,
        0 AS has_direct_job_asset_link,
        1 AS has_jobasset_table_link
    FROM transport_dev.integ_transport_assets.vw_bronze_transport_jobasset_base
    WHERE job_id IS NOT NULL
        AND asset_id IS NOT NULL
)
SELECT
    source_context,
    job_id,
    asset_id,
    MAX(has_direct_job_asset_link) AS has_direct_job_asset_link,
    MAX(has_jobasset_table_link)   AS has_jobasset_table_link
FROM JOB_ASSET_LINK_RAW
GROUP BY
    source_context,
    job_id,
    asset_id
;

