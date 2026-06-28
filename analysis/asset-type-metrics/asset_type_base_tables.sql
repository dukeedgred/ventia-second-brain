-- Bronze source-union base tables for asset-type metrics.
-- No rollups in this file.

CREATE OR REPLACE TABLE transport_dev.integ_transport_assets.vw_bronze_transport_asset_base AS
SELECT
    'asset_vision_ven_gen7'             AS source_context,
    'ext_mssql_asset_vision_ven_gen7'   AS source_catalog,
    'RAMC / BAC / PoB / TSRC group'     AS source_label,
    CAST(id AS STRING)                  AS asset_id,
    COALESCE(
        NULLIF(
            TRIM(
                CAST(contract AS STRING)
            ),
            ''
        ),
        'asset_vision_ven_gen7'
    ) AS contract,
    COALESCE(
        NULLIF(
            TRIM(
                CAST(assettype AS STRING)
            ),
            ''
        ),
        'Unspecified asset type'
    ) AS raw_asset_type,
    NULLIF(
        TRIM(
            CAST(classification AS STRING)
        ),
        ''
    ) AS classification,
    NULLIF(
        TRIM(
            CAST(spatialtype AS STRING)
        ),
        ''
    ) AS spatial_type,
    NULLIF(
        TRIM(
            CAST(assetcondition AS STRING)
        ),
        ''
    ) AS asset_condition,
    NULLIF(
        TRIM(
            CAST(assetcriticality AS STRING)
        ),
        ''
    ) AS asset_criticality,
    NULLIF(
        TRIM(
            CAST(assetrisk AS STRING)
        ),
        ''
    ) AS asset_risk,
    CAST(chainagefrom AS DOUBLE)        AS chainage_from,
    CAST(chainageto AS DOUBLE)          AS chainage_to,
    CAST(parentassetid AS STRING)       AS parent_asset_id,
    NULLIF(
        TRIM(
            CAST(stage AS STRING)
        ),
        ''
    ) AS stage,
    CAST(constructiondate AS TIMESTAMP) AS construction_date,
    CAST(constructioncost AS DOUBLE)    AS construction_cost,
    CAST(usefullife AS DOUBLE)          AS useful_life,
    CAST(conditiondate AS TIMESTAMP)    AS condition_date
FROM ext_mssql_asset_vision_ven_gen7.dbo.asset
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_ven_rms'              AS source_context,
    'ext_mssql_asset_vision_ven_rms'    AS source_catalog,
    'RMS'                               AS source_label,
    CAST(id AS STRING)                  AS asset_id,
    COALESCE(
        NULLIF(
            TRIM(
                CAST(contract AS STRING)
            ),
            ''
        ),
        'asset_vision_ven_rms'
    ) AS contract,
    COALESCE(
        NULLIF(
            TRIM(
                CAST(assettype AS STRING)
            ),
            ''
        ),
        'Unspecified asset type'
    ) AS raw_asset_type,
    NULLIF(
        TRIM(
            CAST(classification AS STRING)
        ),
        ''
    ) AS classification,
    NULLIF(
        TRIM(
            CAST(spatialtype AS STRING)
        ),
        ''
    ) AS spatial_type,
    NULLIF(
        TRIM(
            CAST(assetcondition AS STRING)
        ),
        ''
    ) AS asset_condition,
    NULLIF(
        TRIM(
            CAST(assetcriticality AS STRING)
        ),
        ''
    ) AS asset_criticality,
    NULLIF(
        TRIM(
            CAST(assetrisk AS STRING)
        ),
        ''
    ) AS asset_risk,
    CAST(chainagefrom AS DOUBLE)        AS chainage_from,
    CAST(chainageto AS DOUBLE)          AS chainage_to,
    CAST(parentassetid AS STRING)       AS parent_asset_id,
    NULLIF(
        TRIM(
            CAST(stage AS STRING)
        ),
        ''
    ) AS stage,
    CAST(constructiondate AS TIMESTAMP) AS construction_date,
    CAST(constructioncost AS DOUBLE)    AS construction_cost,
    CAST(usefullife AS DOUBLE)          AS useful_life,
    CAST(conditiondate AS TIMESTAMP)    AS condition_date
FROM ext_mssql_asset_vision_ven_rms.dbo.asset
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_ven_rms_new'          AS source_context,
    'ext_mssql_asset_vision_ven_rms_new' AS source_catalog,
    'RMS new'                           AS source_label,
    CAST(id AS STRING)                  AS asset_id,
    COALESCE(
        NULLIF(
            TRIM(
                CAST(contract AS STRING)
            ),
            ''
        ),
        'asset_vision_ven_rms_new'
    ) AS contract,
    COALESCE(
        NULLIF(
            TRIM(
                CAST(assettype AS STRING)
            ),
            ''
        ),
        'Unspecified asset type'
    ) AS raw_asset_type,
    NULLIF(
        TRIM(
            CAST(classification AS STRING)
        ),
        ''
    ) AS classification,
    NULLIF(
        TRIM(
            CAST(spatialtype AS STRING)
        ),
        ''
    ) AS spatial_type,
    NULLIF(
        TRIM(
            CAST(assetcondition AS STRING)
        ),
        ''
    ) AS asset_condition,
    NULLIF(
        TRIM(
            CAST(assetcriticality AS STRING)
        ),
        ''
    ) AS asset_criticality,
    NULLIF(
        TRIM(
            CAST(assetrisk AS STRING)
        ),
        ''
    ) AS asset_risk,
    CAST(chainagefrom AS DOUBLE)        AS chainage_from,
    CAST(chainageto AS DOUBLE)          AS chainage_to,
    CAST(parentassetid AS STRING)       AS parent_asset_id,
    NULLIF(
        TRIM(
            CAST(stage AS STRING)
        ),
        ''
    ) AS stage,
    CAST(constructiondate AS TIMESTAMP) AS construction_date,
    CAST(constructioncost AS DOUBLE)    AS construction_cost,
    CAST(usefullife AS DOUBLE)          AS useful_life,
    CAST(conditiondate AS TIMESTAMP)    AS condition_date
FROM ext_mssql_asset_vision_ven_rms_new.dbo.asset
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_ven_vicroads'         AS source_context,
    'ext_mssql_asset_vision_ven_vicroads' AS source_catalog,
    'VicRoads'                          AS source_label,
    CAST(id AS STRING)                  AS asset_id,
    COALESCE(
        NULLIF(
            TRIM(
                CAST(contract AS STRING)
            ),
            ''
        ),
        'asset_vision_ven_vicroads'
    ) AS contract,
    COALESCE(
        NULLIF(
            TRIM(
                CAST(assettype AS STRING)
            ),
            ''
        ),
        'Unspecified asset type'
    ) AS raw_asset_type,
    NULLIF(
        TRIM(
            CAST(classification AS STRING)
        ),
        ''
    ) AS classification,
    NULLIF(
        TRIM(
            CAST(spatialtype AS STRING)
        ),
        ''
    ) AS spatial_type,
    NULLIF(
        TRIM(
            CAST(assetcondition AS STRING)
        ),
        ''
    ) AS asset_condition,
    NULLIF(
        TRIM(
            CAST(assetcriticality AS STRING)
        ),
        ''
    ) AS asset_criticality,
    NULLIF(
        TRIM(
            CAST(assetrisk AS STRING)
        ),
        ''
    ) AS asset_risk,
    CAST(chainagefrom AS DOUBLE)        AS chainage_from,
    CAST(chainageto AS DOUBLE)          AS chainage_to,
    CAST(parentassetid AS STRING)       AS parent_asset_id,
    NULLIF(
        TRIM(
            CAST(stage AS STRING)
        ),
        ''
    ) AS stage,
    CAST(constructiondate AS TIMESTAMP) AS construction_date,
    CAST(constructioncost AS DOUBLE)    AS construction_cost,
    CAST(usefullife AS DOUBLE)          AS useful_life,
    CAST(conditiondate AS TIMESTAMP)    AS condition_date
FROM ext_mssql_asset_vision_ven_vicroads.dbo.asset
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_vns_gen7'             AS source_context,
    'ext_mssql_asset_vision_vns_gen7'   AS source_catalog,
    'VNS'                               AS source_label,
    CAST(id AS STRING)                  AS asset_id,
    COALESCE(
        NULLIF(
            TRIM(
                CAST(contract AS STRING)
            ),
            ''
        ),
        'asset_vision_vns_gen7'
    ) AS contract,
    COALESCE(
        NULLIF(
            TRIM(
                CAST(assettype AS STRING)
            ),
            ''
        ),
        'Unspecified asset type'
    ) AS raw_asset_type,
    NULLIF(
        TRIM(
            CAST(classification AS STRING)
        ),
        ''
    ) AS classification,
    NULLIF(
        TRIM(
            CAST(spatialtype AS STRING)
        ),
        ''
    ) AS spatial_type,
    NULLIF(
        TRIM(
            CAST(assetcondition AS STRING)
        ),
        ''
    ) AS asset_condition,
    NULLIF(
        TRIM(
            CAST(assetcriticality AS STRING)
        ),
        ''
    ) AS asset_criticality,
    NULLIF(
        TRIM(
            CAST(assetrisk AS STRING)
        ),
        ''
    ) AS asset_risk,
    CAST(chainagefrom AS DOUBLE)        AS chainage_from,
    CAST(chainageto AS DOUBLE)          AS chainage_to,
    CAST(parentassetid AS STRING)       AS parent_asset_id,
    NULLIF(
        TRIM(
            CAST(stage AS STRING)
        ),
        ''
    ) AS stage,
    CAST(constructiondate AS TIMESTAMP) AS construction_date,
    CAST(constructioncost AS DOUBLE)    AS construction_cost,
    CAST(usefullife AS DOUBLE)          AS useful_life,
    CAST(conditiondate AS TIMESTAMP)    AS condition_date
FROM ext_mssql_asset_vision_vns_gen7.dbo.asset
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_vnz_gen7'             AS source_context,
    'ext_mssql_asset_vision_vnz_gen7'   AS source_catalog,
    'VNZ'                               AS source_label,
    CAST(id AS STRING)                  AS asset_id,
    COALESCE(
        NULLIF(
            TRIM(
                CAST(contract AS STRING)
            ),
            ''
        ),
        'asset_vision_vnz_gen7'
    ) AS contract,
    COALESCE(
        NULLIF(
            TRIM(
                CAST(assettype AS STRING)
            ),
            ''
        ),
        'Unspecified asset type'
    ) AS raw_asset_type,
    NULLIF(
        TRIM(
            CAST(classification AS STRING)
        ),
        ''
    ) AS classification,
    NULLIF(
        TRIM(
            CAST(spatialtype AS STRING)
        ),
        ''
    ) AS spatial_type,
    NULLIF(
        TRIM(
            CAST(assetcondition AS STRING)
        ),
        ''
    ) AS asset_condition,
    NULLIF(
        TRIM(
            CAST(assetcriticality AS STRING)
        ),
        ''
    ) AS asset_criticality,
    NULLIF(
        TRIM(
            CAST(assetrisk AS STRING)
        ),
        ''
    ) AS asset_risk,
    CAST(chainagefrom AS DOUBLE)        AS chainage_from,
    CAST(chainageto AS DOUBLE)          AS chainage_to,
    CAST(parentassetid AS STRING)       AS parent_asset_id,
    NULLIF(
        TRIM(
            CAST(stage AS STRING)
        ),
        ''
    ) AS stage,
    CAST(constructiondate AS TIMESTAMP) AS construction_date,
    CAST(constructioncost AS DOUBLE)    AS construction_cost,
    CAST(usefullife AS DOUBLE)          AS useful_life,
    CAST(conditiondate AS TIMESTAMP)    AS condition_date
FROM ext_mssql_asset_vision_vnz_gen7.dbo.asset
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_vsm_gen7'             AS source_context,
    'ext_mssql_asset_vision_vsm_gen7'   AS source_catalog,
    'VentureSmart'                      AS source_label,
    CAST(id AS STRING)                  AS asset_id,
    COALESCE(
        NULLIF(
            TRIM(
                CAST(contract AS STRING)
            ),
            ''
        ),
        'asset_vision_vsm_gen7'
    ) AS contract,
    COALESCE(
        NULLIF(
            TRIM(
                CAST(assettype AS STRING)
            ),
            ''
        ),
        'Unspecified asset type'
    ) AS raw_asset_type,
    NULLIF(
        TRIM(
            CAST(classification AS STRING)
        ),
        ''
    ) AS classification,
    NULLIF(
        TRIM(
            CAST(spatialtype AS STRING)
        ),
        ''
    ) AS spatial_type,
    NULLIF(
        TRIM(
            CAST(assetcondition AS STRING)
        ),
        ''
    ) AS asset_condition,
    NULLIF(
        TRIM(
            CAST(assetcriticality AS STRING)
        ),
        ''
    ) AS asset_criticality,
    NULLIF(
        TRIM(
            CAST(assetrisk AS STRING)
        ),
        ''
    ) AS asset_risk,
    CAST(chainagefrom AS DOUBLE)        AS chainage_from,
    CAST(chainageto AS DOUBLE)          AS chainage_to,
    CAST(parentassetid AS STRING)       AS parent_asset_id,
    NULLIF(
        TRIM(
            CAST(stage AS STRING)
        ),
        ''
    ) AS stage,
    CAST(constructiondate AS TIMESTAMP) AS construction_date,
    CAST(constructioncost AS DOUBLE)    AS construction_cost,
    CAST(usefullife AS DOUBLE)          AS useful_life,
    CAST(conditiondate AS TIMESTAMP)    AS condition_date
FROM ext_mssql_asset_vision_vsm_gen7.dbo.asset
WHERE COALESCE(deleted, FALSE) = FALSE
;


CREATE OR REPLACE TABLE transport_dev.integ_transport_assets.vw_bronze_transport_asset_location_base AS
SELECT
    'asset_vision_ven_gen7'             AS source_context,
    CAST(assetid AS STRING)             AS asset_id,
    CASE
        WHEN wkt IS NOT NULL
            AND TRIM(CAST(wkt AS STRING)) <> ''
        THEN 1
        ELSE 0
    END AS has_wkt,
    wkt,
    direction,
    CASE
        WHEN (
            CAST(
                regexp_extract(
                    wkt,
                    '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)',
                    1
                ) AS DOUBLE
            ) BETWEEN 112 AND 154
            AND CAST(
                regexp_extract(
                    wkt,
                    '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)',
                    2
                ) AS DOUBLE
            ) BETWEEN -44 AND -10
        )
        OR (
            CAST(
                regexp_extract(
                    wkt,
                    '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)',
                    1
                ) AS DOUBLE
            ) BETWEEN 166 AND 179.5
            AND CAST(
                regexp_extract(
                    wkt,
                    '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)',
                    2
                ) AS DOUBLE
            ) BETWEEN -48 AND -34
        )
        THEN 1
        ELSE 0
    END AS has_valid_au_nz_coord
FROM ext_mssql_asset_vision_ven_gen7.dbo.vassetlocation
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_ven_rms'              AS source_context,
    CAST(assetid AS STRING)             AS asset_id,
    CASE
        WHEN wkt IS NOT NULL
            AND TRIM(CAST(wkt AS STRING)) <> ''
        THEN 1
        ELSE 0
    END AS has_wkt,
    wkt,
    direction,
    CASE
        WHEN (
            CAST(
                regexp_extract(
                    wkt,
                    '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)',
                    1
                ) AS DOUBLE
            ) BETWEEN 112 AND 154
            AND CAST(
                regexp_extract(
                    wkt,
                    '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)',
                    2
                ) AS DOUBLE
            ) BETWEEN -44 AND -10
        )
        OR (
            CAST(
                regexp_extract(
                    wkt,
                    '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)',
                    1
                ) AS DOUBLE
            ) BETWEEN 166 AND 179.5
            AND CAST(
                regexp_extract(
                    wkt,
                    '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)',
                    2
                ) AS DOUBLE
            ) BETWEEN -48 AND -34
        )
        THEN 1
        ELSE 0
    END AS has_valid_au_nz_coord
FROM ext_mssql_asset_vision_ven_rms.dbo.vassetlocation
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_ven_rms_new'          AS source_context,
    CAST(assetid AS STRING)             AS asset_id,
    CASE
        WHEN wkt IS NOT NULL
            AND TRIM(CAST(wkt AS STRING)) <> ''
        THEN 1
        ELSE 0
    END AS has_wkt,
    wkt,
    direction,
    CASE
        WHEN (
            CAST(
                regexp_extract(
                    wkt,
                    '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)',
                    1
                ) AS DOUBLE
            ) BETWEEN 112 AND 154
            AND CAST(
                regexp_extract(
                    wkt,
                    '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)',
                    2
                ) AS DOUBLE
            ) BETWEEN -44 AND -10
        )
        OR (
            CAST(
                regexp_extract(
                    wkt,
                    '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)',
                    1
                ) AS DOUBLE
            ) BETWEEN 166 AND 179.5
            AND CAST(
                regexp_extract(
                    wkt,
                    '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)',
                    2
                ) AS DOUBLE
            ) BETWEEN -48 AND -34
        )
        THEN 1
        ELSE 0
    END AS has_valid_au_nz_coord
FROM ext_mssql_asset_vision_ven_rms_new.dbo.vassetlocation
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_ven_vicroads'         AS source_context,
    CAST(assetid AS STRING)             AS asset_id,
    CASE
        WHEN wkt IS NOT NULL
            AND TRIM(CAST(wkt AS STRING)) <> ''
        THEN 1
        ELSE 0
    END AS has_wkt,
    wkt,
    direction,
    CASE
        WHEN (
            CAST(
                regexp_extract(
                    wkt,
                    '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)',
                    1
                ) AS DOUBLE
            ) BETWEEN 112 AND 154
            AND CAST(
                regexp_extract(
                    wkt,
                    '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)',
                    2
                ) AS DOUBLE
            ) BETWEEN -44 AND -10
        )
        OR (
            CAST(
                regexp_extract(
                    wkt,
                    '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)',
                    1
                ) AS DOUBLE
            ) BETWEEN 166 AND 179.5
            AND CAST(
                regexp_extract(
                    wkt,
                    '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)',
                    2
                ) AS DOUBLE
            ) BETWEEN -48 AND -34
        )
        THEN 1
        ELSE 0
    END AS has_valid_au_nz_coord
FROM ext_mssql_asset_vision_ven_vicroads.dbo.vassetlocation
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_vns_gen7'             AS source_context,
    CAST(assetid AS STRING)             AS asset_id,
    CASE
        WHEN wkt IS NOT NULL
            AND TRIM(CAST(wkt AS STRING)) <> ''
        THEN 1
        ELSE 0
    END AS has_wkt,
    wkt,
    direction,
    CASE
        WHEN (
            CAST(
                regexp_extract(
                    wkt,
                    '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)',
                    1
                ) AS DOUBLE
            ) BETWEEN 112 AND 154
            AND CAST(
                regexp_extract(
                    wkt,
                    '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)',
                    2
                ) AS DOUBLE
            ) BETWEEN -44 AND -10
        )
        OR (
            CAST(
                regexp_extract(
                    wkt,
                    '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)',
                    1
                ) AS DOUBLE
            ) BETWEEN 166 AND 179.5
            AND CAST(
                regexp_extract(
                    wkt,
                    '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)',
                    2
                ) AS DOUBLE
            ) BETWEEN -48 AND -34
        )
        THEN 1
        ELSE 0
    END AS has_valid_au_nz_coord
FROM ext_mssql_asset_vision_vns_gen7.dbo.vassetlocation
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_vnz_gen7'             AS source_context,
    CAST(assetid AS STRING)             AS asset_id,
    CASE
        WHEN wkt IS NOT NULL
            AND TRIM(CAST(wkt AS STRING)) <> ''
        THEN 1
        ELSE 0
    END AS has_wkt,
    wkt,
    direction,
    CASE
        WHEN (
            CAST(
                regexp_extract(
                    wkt,
                    '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)',
                    1
                ) AS DOUBLE
            ) BETWEEN 112 AND 154
            AND CAST(
                regexp_extract(
                    wkt,
                    '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)',
                    2
                ) AS DOUBLE
            ) BETWEEN -44 AND -10
        )
        OR (
            CAST(
                regexp_extract(
                    wkt,
                    '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)',
                    1
                ) AS DOUBLE
            ) BETWEEN 166 AND 179.5
            AND CAST(
                regexp_extract(
                    wkt,
                    '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)',
                    2
                ) AS DOUBLE
            ) BETWEEN -48 AND -34
        )
        THEN 1
        ELSE 0
    END AS has_valid_au_nz_coord
FROM ext_mssql_asset_vision_vnz_gen7.dbo.vassetlocation
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_vsm_gen7'             AS source_context,
    CAST(assetid AS STRING)             AS asset_id,
    CASE
        WHEN wkt IS NOT NULL
            AND TRIM(CAST(wkt AS STRING)) <> ''
        THEN 1
        ELSE 0
    END AS has_wkt,
    wkt,
    direction,
    CASE
        WHEN (
            CAST(
                regexp_extract(
                    wkt,
                    '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)',
                    1
                ) AS DOUBLE
            ) BETWEEN 112 AND 154
            AND CAST(
                regexp_extract(
                    wkt,
                    '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)',
                    2
                ) AS DOUBLE
            ) BETWEEN -44 AND -10
        )
        OR (
            CAST(
                regexp_extract(
                    wkt,
                    '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)',
                    1
                ) AS DOUBLE
            ) BETWEEN 166 AND 179.5
            AND CAST(
                regexp_extract(
                    wkt,
                    '(-?\\d+(?:\\.\\d+)?)\\s+(-?\\d+(?:\\.\\d+)?)',
                    2
                ) AS DOUBLE
            ) BETWEEN -48 AND -34
        )
        THEN 1
        ELSE 0
    END AS has_valid_au_nz_coord
FROM ext_mssql_asset_vision_vsm_gen7.dbo.vassetlocation
WHERE COALESCE(deleted, FALSE) = FALSE
;


CREATE OR REPLACE TABLE transport_dev.integ_transport_assets.vw_bronze_transport_asset_attribute_base AS
SELECT
    'asset_vision_ven_gen7'             AS source_context,
    CAST(assetid AS STRING)             AS asset_id,
    NULLIF(
        TRIM(
            CAST(name AS STRING)
        ),
        ''
    ) AS attribute_name,
    NULLIF(
        TRIM(
            CAST(value AS STRING)
        ),
        ''
    ) AS attribute_value
FROM ext_mssql_asset_vision_ven_gen7.dbo.assetattribute
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_ven_rms'              AS source_context,
    CAST(assetid AS STRING)             AS asset_id,
    NULLIF(
        TRIM(
            CAST(name AS STRING)
        ),
        ''
    ) AS attribute_name,
    NULLIF(
        TRIM(
            CAST(value AS STRING)
        ),
        ''
    ) AS attribute_value
FROM ext_mssql_asset_vision_ven_rms.dbo.assetattribute
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_ven_rms_new'          AS source_context,
    CAST(assetid AS STRING)             AS asset_id,
    NULLIF(
        TRIM(
            CAST(name AS STRING)
        ),
        ''
    ) AS attribute_name,
    NULLIF(
        TRIM(
            CAST(value AS STRING)
        ),
        ''
    ) AS attribute_value
FROM ext_mssql_asset_vision_ven_rms_new.dbo.assetattribute
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_ven_vicroads'         AS source_context,
    CAST(assetid AS STRING)             AS asset_id,
    NULLIF(
        TRIM(
            CAST(name AS STRING)
        ),
        ''
    ) AS attribute_name,
    NULLIF(
        TRIM(
            CAST(value AS STRING)
        ),
        ''
    ) AS attribute_value
FROM ext_mssql_asset_vision_ven_vicroads.dbo.assetattribute
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_vns_gen7'             AS source_context,
    CAST(assetid AS STRING)             AS asset_id,
    NULLIF(
        TRIM(
            CAST(name AS STRING)
        ),
        ''
    ) AS attribute_name,
    NULLIF(
        TRIM(
            CAST(value AS STRING)
        ),
        ''
    ) AS attribute_value
FROM ext_mssql_asset_vision_vns_gen7.dbo.assetattribute
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_vnz_gen7'             AS source_context,
    CAST(assetid AS STRING)             AS asset_id,
    NULLIF(
        TRIM(
            CAST(name AS STRING)
        ),
        ''
    ) AS attribute_name,
    NULLIF(
        TRIM(
            CAST(value AS STRING)
        ),
        ''
    ) AS attribute_value
FROM ext_mssql_asset_vision_vnz_gen7.dbo.assetattribute
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_vsm_gen7'             AS source_context,
    CAST(assetid AS STRING)             AS asset_id,
    NULLIF(
        TRIM(
            CAST(name AS STRING)
        ),
        ''
    ) AS attribute_name,
    NULLIF(
        TRIM(
            CAST(value AS STRING)
        ),
        ''
    ) AS attribute_value
FROM ext_mssql_asset_vision_vsm_gen7.dbo.assetattribute
WHERE COALESCE(deleted, FALSE) = FALSE
;


CREATE OR REPLACE TABLE transport_dev.integ_transport_assets.vw_bronze_transport_job_base AS
SELECT
    'asset_vision_ven_gen7'             AS source_context,
    CAST(id AS STRING)                  AS job_id,
    CAST(assetid AS STRING)             AS asset_id,
    CAST(duedate AS TIMESTAMP)          AS due_date,
    CAST(completeddate AS TIMESTAMP)    AS completed_date,
    NULLIF(
        TRIM(
            CAST(hazarddefectcode AS STRING)
        ),
        ''
    ) AS hazard_defect_code,
    NULLIF(
        TRIM(
            CAST(activitycategoryname AS STRING)
        ),
        ''
    ) AS activity_category_name,
    NULLIF(
        TRIM(
            CAST(activityname AS STRING)
        ),
        ''
    ) AS activity_name,
    NULLIF(
        TRIM(
            CAST(interventioncode AS STRING)
        ),
        ''
    ) AS intervention_code,
    CAST(estimatedquantity AS DOUBLE)   AS estimated_quantity,
    NULLIF(
        TRIM(
            CAST(priority AS STRING)
        ),
        ''
    ) AS priority,
    NULLIF(
        TRIM(
            CAST(activitytype AS STRING)
        ),
        ''
    ) AS activity_type,
    NULLIF(
        TRIM(
            CAST(compliant AS STRING)
        ),
        ''
    ) AS compliant,
    CAST(remainingquantity AS DOUBLE)   AS remaining_quantity,
    CAST(actualquantity AS DOUBLE)      AS actual_quantity,
    NULLIF(
        TRIM(
            CAST(inspectiontypename AS STRING)
        ),
        ''
    ) AS inspection_type_name,
    CAST(estimatedlength AS DOUBLE)     AS estimated_length,
    CAST(estimatedwidth AS DOUBLE)      AS estimated_width,
    CAST(estimateddepth AS DOUBLE)      AS estimated_depth
FROM ext_mssql_asset_vision_ven_gen7.dbo.job
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_ven_rms'              AS source_context,
    CAST(id AS STRING)                  AS job_id,
    CAST(assetid AS STRING)             AS asset_id,
    CAST(duedate AS TIMESTAMP)          AS due_date,
    CAST(completeddate AS TIMESTAMP)    AS completed_date,
    NULLIF(
        TRIM(
            CAST(hazarddefectcode AS STRING)
        ),
        ''
    ) AS hazard_defect_code,
    NULLIF(
        TRIM(
            CAST(activitycategoryname AS STRING)
        ),
        ''
    ) AS activity_category_name,
    NULLIF(
        TRIM(
            CAST(activityname AS STRING)
        ),
        ''
    ) AS activity_name,
    NULLIF(
        TRIM(
            CAST(interventioncode AS STRING)
        ),
        ''
    ) AS intervention_code,
    CAST(estimatedquantity AS DOUBLE)   AS estimated_quantity,
    NULLIF(
        TRIM(
            CAST(priority AS STRING)
        ),
        ''
    ) AS priority,
    NULLIF(
        TRIM(
            CAST(activitytype AS STRING)
        ),
        ''
    ) AS activity_type,
    NULLIF(
        TRIM(
            CAST(compliant AS STRING)
        ),
        ''
    ) AS compliant,
    CAST(remainingquantity AS DOUBLE)   AS remaining_quantity,
    CAST(actualquantity AS DOUBLE)      AS actual_quantity,
    NULLIF(
        TRIM(
            CAST(inspectiontypename AS STRING)
        ),
        ''
    ) AS inspection_type_name,
    CAST(estimatedlength AS DOUBLE)     AS estimated_length,
    CAST(estimatedwidth AS DOUBLE)      AS estimated_width,
    CAST(estimateddepth AS DOUBLE)      AS estimated_depth
FROM ext_mssql_asset_vision_ven_rms.dbo.job
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_ven_rms_new'          AS source_context,
    CAST(id AS STRING)                  AS job_id,
    CAST(assetid AS STRING)             AS asset_id,
    CAST(duedate AS TIMESTAMP)          AS due_date,
    CAST(completeddate AS TIMESTAMP)    AS completed_date,
    NULLIF(
        TRIM(
            CAST(hazarddefectcode AS STRING)
        ),
        ''
    ) AS hazard_defect_code,
    NULLIF(
        TRIM(
            CAST(activitycategoryname AS STRING)
        ),
        ''
    ) AS activity_category_name,
    NULLIF(
        TRIM(
            CAST(activityname AS STRING)
        ),
        ''
    ) AS activity_name,
    NULLIF(
        TRIM(
            CAST(interventioncode AS STRING)
        ),
        ''
    ) AS intervention_code,
    CAST(estimatedquantity AS DOUBLE)   AS estimated_quantity,
    NULLIF(
        TRIM(
            CAST(priority AS STRING)
        ),
        ''
    ) AS priority,
    NULLIF(
        TRIM(
            CAST(activitytype AS STRING)
        ),
        ''
    ) AS activity_type,
    NULLIF(
        TRIM(
            CAST(compliant AS STRING)
        ),
        ''
    ) AS compliant,
    CAST(remainingquantity AS DOUBLE)   AS remaining_quantity,
    CAST(actualquantity AS DOUBLE)      AS actual_quantity,
    NULLIF(
        TRIM(
            CAST(inspectiontypename AS STRING)
        ),
        ''
    ) AS inspection_type_name,
    CAST(estimatedlength AS DOUBLE)     AS estimated_length,
    CAST(estimatedwidth AS DOUBLE)      AS estimated_width,
    CAST(estimateddepth AS DOUBLE)      AS estimated_depth
FROM ext_mssql_asset_vision_ven_rms_new.dbo.job
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_ven_vicroads'         AS source_context,
    CAST(id AS STRING)                  AS job_id,
    CAST(assetid AS STRING)             AS asset_id,
    CAST(duedate AS TIMESTAMP)          AS due_date,
    CAST(completeddate AS TIMESTAMP)    AS completed_date,
    NULLIF(
        TRIM(
            CAST(hazarddefectcode AS STRING)
        ),
        ''
    ) AS hazard_defect_code,
    NULLIF(
        TRIM(
            CAST(activitycategoryname AS STRING)
        ),
        ''
    ) AS activity_category_name,
    NULLIF(
        TRIM(
            CAST(activityname AS STRING)
        ),
        ''
    ) AS activity_name,
    NULLIF(
        TRIM(
            CAST(interventioncode AS STRING)
        ),
        ''
    ) AS intervention_code,
    CAST(estimatedquantity AS DOUBLE)   AS estimated_quantity,
    NULLIF(
        TRIM(
            CAST(priority AS STRING)
        ),
        ''
    ) AS priority,
    NULLIF(
        TRIM(
            CAST(activitytype AS STRING)
        ),
        ''
    ) AS activity_type,
    NULLIF(
        TRIM(
            CAST(compliant AS STRING)
        ),
        ''
    ) AS compliant,
    CAST(remainingquantity AS DOUBLE)   AS remaining_quantity,
    CAST(actualquantity AS DOUBLE)      AS actual_quantity,
    NULLIF(
        TRIM(
            CAST(inspectiontypename AS STRING)
        ),
        ''
    ) AS inspection_type_name,
    CAST(estimatedlength AS DOUBLE)     AS estimated_length,
    CAST(estimatedwidth AS DOUBLE)      AS estimated_width,
    CAST(estimateddepth AS DOUBLE)      AS estimated_depth
FROM ext_mssql_asset_vision_ven_vicroads.dbo.job
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_vns_gen7'             AS source_context,
    CAST(id AS STRING)                  AS job_id,
    CAST(assetid AS STRING)             AS asset_id,
    CAST(duedate AS TIMESTAMP)          AS due_date,
    CAST(completeddate AS TIMESTAMP)    AS completed_date,
    NULLIF(
        TRIM(
            CAST(hazarddefectcode AS STRING)
        ),
        ''
    ) AS hazard_defect_code,
    NULLIF(
        TRIM(
            CAST(activitycategoryname AS STRING)
        ),
        ''
    ) AS activity_category_name,
    NULLIF(
        TRIM(
            CAST(activityname AS STRING)
        ),
        ''
    ) AS activity_name,
    NULLIF(
        TRIM(
            CAST(interventioncode AS STRING)
        ),
        ''
    ) AS intervention_code,
    CAST(estimatedquantity AS DOUBLE)   AS estimated_quantity,
    NULLIF(
        TRIM(
            CAST(priority AS STRING)
        ),
        ''
    ) AS priority,
    NULLIF(
        TRIM(
            CAST(activitytype AS STRING)
        ),
        ''
    ) AS activity_type,
    NULLIF(
        TRIM(
            CAST(compliant AS STRING)
        ),
        ''
    ) AS compliant,
    CAST(remainingquantity AS DOUBLE)   AS remaining_quantity,
    CAST(actualquantity AS DOUBLE)      AS actual_quantity,
    NULLIF(
        TRIM(
            CAST(inspectiontypename AS STRING)
        ),
        ''
    ) AS inspection_type_name,
    CAST(estimatedlength AS DOUBLE)     AS estimated_length,
    CAST(estimatedwidth AS DOUBLE)      AS estimated_width,
    CAST(estimateddepth AS DOUBLE)      AS estimated_depth
FROM ext_mssql_asset_vision_vns_gen7.dbo.job
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_vnz_gen7'             AS source_context,
    CAST(id AS STRING)                  AS job_id,
    CAST(assetid AS STRING)             AS asset_id,
    CAST(duedate AS TIMESTAMP)          AS due_date,
    CAST(completeddate AS TIMESTAMP)    AS completed_date,
    NULLIF(
        TRIM(
            CAST(hazarddefectcode AS STRING)
        ),
        ''
    ) AS hazard_defect_code,
    NULLIF(
        TRIM(
            CAST(activitycategoryname AS STRING)
        ),
        ''
    ) AS activity_category_name,
    NULLIF(
        TRIM(
            CAST(activityname AS STRING)
        ),
        ''
    ) AS activity_name,
    NULLIF(
        TRIM(
            CAST(interventioncode AS STRING)
        ),
        ''
    ) AS intervention_code,
    CAST(estimatedquantity AS DOUBLE)   AS estimated_quantity,
    NULLIF(
        TRIM(
            CAST(priority AS STRING)
        ),
        ''
    ) AS priority,
    NULLIF(
        TRIM(
            CAST(activitytype AS STRING)
        ),
        ''
    ) AS activity_type,
    NULLIF(
        TRIM(
            CAST(compliant AS STRING)
        ),
        ''
    ) AS compliant,
    CAST(remainingquantity AS DOUBLE)   AS remaining_quantity,
    CAST(actualquantity AS DOUBLE)      AS actual_quantity,
    NULLIF(
        TRIM(
            CAST(inspectiontypename AS STRING)
        ),
        ''
    ) AS inspection_type_name,
    CAST(estimatedlength AS DOUBLE)     AS estimated_length,
    CAST(estimatedwidth AS DOUBLE)      AS estimated_width,
    CAST(estimateddepth AS DOUBLE)      AS estimated_depth
FROM ext_mssql_asset_vision_vnz_gen7.dbo.job
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_vsm_gen7'             AS source_context,
    CAST(id AS STRING)                  AS job_id,
    CAST(assetid AS STRING)             AS asset_id,
    CAST(duedate AS TIMESTAMP)          AS due_date,
    CAST(completeddate AS TIMESTAMP)    AS completed_date,
    NULLIF(
        TRIM(
            CAST(hazarddefectcode AS STRING)
        ),
        ''
    ) AS hazard_defect_code,
    NULLIF(
        TRIM(
            CAST(activitycategoryname AS STRING)
        ),
        ''
    ) AS activity_category_name,
    NULLIF(
        TRIM(
            CAST(activityname AS STRING)
        ),
        ''
    ) AS activity_name,
    NULLIF(
        TRIM(
            CAST(interventioncode AS STRING)
        ),
        ''
    ) AS intervention_code,
    CAST(estimatedquantity AS DOUBLE)   AS estimated_quantity,
    NULLIF(
        TRIM(
            CAST(priority AS STRING)
        ),
        ''
    ) AS priority,
    NULLIF(
        TRIM(
            CAST(activitytype AS STRING)
        ),
        ''
    ) AS activity_type,
    NULLIF(
        TRIM(
            CAST(compliant AS STRING)
        ),
        ''
    ) AS compliant,
    CAST(remainingquantity AS DOUBLE)   AS remaining_quantity,
    CAST(actualquantity AS DOUBLE)      AS actual_quantity,
    NULLIF(
        TRIM(
            CAST(inspectiontypename AS STRING)
        ),
        ''
    ) AS inspection_type_name,
    CAST(estimatedlength AS DOUBLE)     AS estimated_length,
    CAST(estimatedwidth AS DOUBLE)      AS estimated_width,
    CAST(estimateddepth AS DOUBLE)      AS estimated_depth
FROM ext_mssql_asset_vision_vsm_gen7.dbo.job
WHERE COALESCE(deleted, FALSE) = FALSE
;


CREATE OR REPLACE TABLE transport_dev.integ_transport_assets.vw_bronze_transport_jobasset_base AS
SELECT
    'asset_vision_ven_gen7'             AS source_context,
    CAST(jobid AS STRING)               AS job_id,
    CAST(assetid AS STRING)             AS asset_id,
    NULLIF(
        TRIM(
            CAST(direction AS STRING)
        ),
        ''
    ) AS direction,
    CAST(chainagefrom AS DOUBLE)        AS chainage_from,
    CAST(chainageto AS DOUBLE)          AS chainage_to
FROM ext_mssql_asset_vision_ven_gen7.dbo.jobasset
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_ven_rms'              AS source_context,
    CAST(jobid AS STRING)               AS job_id,
    CAST(assetid AS STRING)             AS asset_id,
    NULLIF(
        TRIM(
            CAST(direction AS STRING)
        ),
        ''
    ) AS direction,
    CAST(chainagefrom AS DOUBLE)        AS chainage_from,
    CAST(chainageto AS DOUBLE)          AS chainage_to
FROM ext_mssql_asset_vision_ven_rms.dbo.jobasset
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_ven_rms_new'          AS source_context,
    CAST(jobid AS STRING)               AS job_id,
    CAST(assetid AS STRING)             AS asset_id,
    NULLIF(
        TRIM(
            CAST(direction AS STRING)
        ),
        ''
    ) AS direction,
    CAST(chainagefrom AS DOUBLE)        AS chainage_from,
    CAST(chainageto AS DOUBLE)          AS chainage_to
FROM ext_mssql_asset_vision_ven_rms_new.dbo.jobasset
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_ven_vicroads'         AS source_context,
    CAST(jobid AS STRING)               AS job_id,
    CAST(assetid AS STRING)             AS asset_id,
    NULLIF(
        TRIM(
            CAST(direction AS STRING)
        ),
        ''
    ) AS direction,
    CAST(chainagefrom AS DOUBLE)        AS chainage_from,
    CAST(chainageto AS DOUBLE)          AS chainage_to
FROM ext_mssql_asset_vision_ven_vicroads.dbo.jobasset
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_vns_gen7'             AS source_context,
    CAST(jobid AS STRING)               AS job_id,
    CAST(assetid AS STRING)             AS asset_id,
    NULLIF(
        TRIM(
            CAST(direction AS STRING)
        ),
        ''
    ) AS direction,
    CAST(chainagefrom AS DOUBLE)        AS chainage_from,
    CAST(chainageto AS DOUBLE)          AS chainage_to
FROM ext_mssql_asset_vision_vns_gen7.dbo.jobasset
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_vnz_gen7'             AS source_context,
    CAST(jobid AS STRING)               AS job_id,
    CAST(assetid AS STRING)             AS asset_id,
    NULLIF(
        TRIM(
            CAST(direction AS STRING)
        ),
        ''
    ) AS direction,
    CAST(chainagefrom AS DOUBLE)        AS chainage_from,
    CAST(chainageto AS DOUBLE)          AS chainage_to
FROM ext_mssql_asset_vision_vnz_gen7.dbo.jobasset
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_vsm_gen7'             AS source_context,
    CAST(jobid AS STRING)               AS job_id,
    CAST(assetid AS STRING)             AS asset_id,
    NULLIF(
        TRIM(
            CAST(direction AS STRING)
        ),
        ''
    ) AS direction,
    CAST(chainagefrom AS DOUBLE)        AS chainage_from,
    CAST(chainageto AS DOUBLE)          AS chainage_to
FROM ext_mssql_asset_vision_vsm_gen7.dbo.jobasset
WHERE COALESCE(deleted, FALSE) = FALSE
;


CREATE OR REPLACE TABLE transport_dev.integ_transport_assets.vw_bronze_transport_inspection_base AS
SELECT
    'asset_vision_ven_gen7'             AS source_context,
    CAST(id AS STRING)                  AS inspection_id,
    CAST(assetid AS STRING)             AS asset_id,
    CAST(jobid AS STRING)               AS job_id,
    CAST(capitalworkid AS STRING)       AS capitalwork_id,
    NULLIF(
        TRIM(
            CAST(inspectiontypename AS STRING)
        ),
        ''
    ) AS inspection_type_name,
    NULLIF(
        TRIM(
            CAST(classification AS STRING)
        ),
        ''
    ) AS classification,
    NULLIF(
        TRIM(
            CAST(direction AS STRING)
        ),
        ''
    ) AS direction,
    CAST(chainagefrom AS DOUBLE)        AS chainage_from,
    CAST(chainageto AS DOUBLE)          AS chainage_to,
    CAST(createddate AS TIMESTAMP)      AS created_date,
    CAST(scheduleddate AS TIMESTAMP)    AS scheduled_date,
    CAST(scheduleddateto AS TIMESTAMP)  AS scheduled_date_to,
    CAST(completeddate AS TIMESTAMP)    AS completed_date
FROM ext_mssql_asset_vision_ven_gen7.dbo.inspection
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_ven_rms'              AS source_context,
    CAST(id AS STRING)                  AS inspection_id,
    CAST(assetid AS STRING)             AS asset_id,
    CAST(jobid AS STRING)               AS job_id,
    CAST(capitalworkid AS STRING)       AS capitalwork_id,
    NULLIF(
        TRIM(
            CAST(inspectiontypename AS STRING)
        ),
        ''
    ) AS inspection_type_name,
    NULLIF(
        TRIM(
            CAST(classification AS STRING)
        ),
        ''
    ) AS classification,
    NULLIF(
        TRIM(
            CAST(direction AS STRING)
        ),
        ''
    ) AS direction,
    CAST(chainagefrom AS DOUBLE)        AS chainage_from,
    CAST(chainageto AS DOUBLE)          AS chainage_to,
    CAST(createddate AS TIMESTAMP)      AS created_date,
    CAST(scheduleddate AS TIMESTAMP)    AS scheduled_date,
    CAST(scheduleddateto AS TIMESTAMP)  AS scheduled_date_to,
    CAST(completeddate AS TIMESTAMP)    AS completed_date
FROM ext_mssql_asset_vision_ven_rms.dbo.inspection
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_ven_rms_new'          AS source_context,
    CAST(id AS STRING)                  AS inspection_id,
    CAST(assetid AS STRING)             AS asset_id,
    CAST(jobid AS STRING)               AS job_id,
    CAST(capitalworkid AS STRING)       AS capitalwork_id,
    NULLIF(
        TRIM(
            CAST(inspectiontypename AS STRING)
        ),
        ''
    ) AS inspection_type_name,
    NULLIF(
        TRIM(
            CAST(classification AS STRING)
        ),
        ''
    ) AS classification,
    NULLIF(
        TRIM(
            CAST(direction AS STRING)
        ),
        ''
    ) AS direction,
    CAST(chainagefrom AS DOUBLE)        AS chainage_from,
    CAST(chainageto AS DOUBLE)          AS chainage_to,
    CAST(createddate AS TIMESTAMP)      AS created_date,
    CAST(scheduleddate AS TIMESTAMP)    AS scheduled_date,
    CAST(scheduleddateto AS TIMESTAMP)  AS scheduled_date_to,
    CAST(completeddate AS TIMESTAMP)    AS completed_date
FROM ext_mssql_asset_vision_ven_rms_new.dbo.inspection
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_ven_vicroads'         AS source_context,
    CAST(id AS STRING)                  AS inspection_id,
    CAST(assetid AS STRING)             AS asset_id,
    CAST(jobid AS STRING)               AS job_id,
    CAST(capitalworkid AS STRING)       AS capitalwork_id,
    NULLIF(
        TRIM(
            CAST(inspectiontypename AS STRING)
        ),
        ''
    ) AS inspection_type_name,
    NULLIF(
        TRIM(
            CAST(classification AS STRING)
        ),
        ''
    ) AS classification,
    NULLIF(
        TRIM(
            CAST(direction AS STRING)
        ),
        ''
    ) AS direction,
    CAST(chainagefrom AS DOUBLE)        AS chainage_from,
    CAST(chainageto AS DOUBLE)          AS chainage_to,
    CAST(createddate AS TIMESTAMP)      AS created_date,
    CAST(scheduleddate AS TIMESTAMP)    AS scheduled_date,
    CAST(scheduleddateto AS TIMESTAMP)  AS scheduled_date_to,
    CAST(completeddate AS TIMESTAMP)    AS completed_date
FROM ext_mssql_asset_vision_ven_vicroads.dbo.inspection
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_vns_gen7'             AS source_context,
    CAST(id AS STRING)                  AS inspection_id,
    CAST(assetid AS STRING)             AS asset_id,
    CAST(jobid AS STRING)               AS job_id,
    CAST(capitalworkid AS STRING)       AS capitalwork_id,
    NULLIF(
        TRIM(
            CAST(inspectiontypename AS STRING)
        ),
        ''
    ) AS inspection_type_name,
    NULLIF(
        TRIM(
            CAST(classification AS STRING)
        ),
        ''
    ) AS classification,
    NULLIF(
        TRIM(
            CAST(direction AS STRING)
        ),
        ''
    ) AS direction,
    CAST(chainagefrom AS DOUBLE)        AS chainage_from,
    CAST(chainageto AS DOUBLE)          AS chainage_to,
    CAST(createddate AS TIMESTAMP)      AS created_date,
    CAST(scheduleddate AS TIMESTAMP)    AS scheduled_date,
    CAST(scheduleddateto AS TIMESTAMP)  AS scheduled_date_to,
    CAST(completeddate AS TIMESTAMP)    AS completed_date
FROM ext_mssql_asset_vision_vns_gen7.dbo.inspection
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_vnz_gen7'             AS source_context,
    CAST(id AS STRING)                  AS inspection_id,
    CAST(assetid AS STRING)             AS asset_id,
    CAST(jobid AS STRING)               AS job_id,
    CAST(capitalworkid AS STRING)       AS capitalwork_id,
    NULLIF(
        TRIM(
            CAST(inspectiontypename AS STRING)
        ),
        ''
    ) AS inspection_type_name,
    NULLIF(
        TRIM(
            CAST(classification AS STRING)
        ),
        ''
    ) AS classification,
    NULLIF(
        TRIM(
            CAST(direction AS STRING)
        ),
        ''
    ) AS direction,
    CAST(chainagefrom AS DOUBLE)        AS chainage_from,
    CAST(chainageto AS DOUBLE)          AS chainage_to,
    CAST(createddate AS TIMESTAMP)      AS created_date,
    CAST(scheduleddate AS TIMESTAMP)    AS scheduled_date,
    CAST(scheduleddateto AS TIMESTAMP)  AS scheduled_date_to,
    CAST(completeddate AS TIMESTAMP)    AS completed_date
FROM ext_mssql_asset_vision_vnz_gen7.dbo.inspection
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_vsm_gen7'             AS source_context,
    CAST(id AS STRING)                  AS inspection_id,
    CAST(assetid AS STRING)             AS asset_id,
    CAST(jobid AS STRING)               AS job_id,
    CAST(capitalworkid AS STRING)       AS capitalwork_id,
    NULLIF(
        TRIM(
            CAST(inspectiontypename AS STRING)
        ),
        ''
    ) AS inspection_type_name,
    NULLIF(
        TRIM(
            CAST(classification AS STRING)
        ),
        ''
    ) AS classification,
    NULLIF(
        TRIM(
            CAST(direction AS STRING)
        ),
        ''
    ) AS direction,
    CAST(chainagefrom AS DOUBLE)        AS chainage_from,
    CAST(chainageto AS DOUBLE)          AS chainage_to,
    CAST(createddate AS TIMESTAMP)      AS created_date,
    CAST(scheduleddate AS TIMESTAMP)    AS scheduled_date,
    CAST(scheduleddateto AS TIMESTAMP)  AS scheduled_date_to,
    CAST(completeddate AS TIMESTAMP)    AS completed_date
FROM ext_mssql_asset_vision_vsm_gen7.dbo.inspection
WHERE COALESCE(deleted, FALSE) = FALSE
;


CREATE OR REPLACE TABLE transport_dev.integ_transport_assets.vw_bronze_transport_capitalwork_base AS
SELECT
    'asset_vision_ven_gen7'             AS source_context,
    CAST(id AS STRING)                  AS capitalwork_id,
    CAST(assetid AS STRING)             AS asset_id,
    NULLIF(
        TRIM(
            CAST(name AS STRING)
        ),
        ''
    ) AS capitalwork_name,
    NULLIF(
        TRIM(
            CAST(contract AS STRING)
        ),
        ''
    ) AS contract,
    NULLIF(
        TRIM(
            CAST(direction AS STRING)
        ),
        ''
    ) AS direction,
    CAST(chainagefrom AS DOUBLE)        AS chainage_from,
    CAST(chainageto AS DOUBLE)          AS chainage_to,
    CAST(plannedstart AS TIMESTAMP)     AS planned_start,
    CAST(actualfinish AS TIMESTAMP)     AS actual_finish
FROM ext_mssql_asset_vision_ven_gen7.dbo.capitalwork
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_ven_rms'              AS source_context,
    CAST(id AS STRING)                  AS capitalwork_id,
    CAST(assetid AS STRING)             AS asset_id,
    NULLIF(
        TRIM(
            CAST(name AS STRING)
        ),
        ''
    ) AS capitalwork_name,
    NULLIF(
        TRIM(
            CAST(contract AS STRING)
        ),
        ''
    ) AS contract,
    NULLIF(
        TRIM(
            CAST(direction AS STRING)
        ),
        ''
    ) AS direction,
    CAST(chainagefrom AS DOUBLE)        AS chainage_from,
    CAST(chainageto AS DOUBLE)          AS chainage_to,
    CAST(plannedstart AS TIMESTAMP)     AS planned_start,
    CAST(actualfinish AS TIMESTAMP)     AS actual_finish
FROM ext_mssql_asset_vision_ven_rms.dbo.capitalwork
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_ven_rms_new'          AS source_context,
    CAST(id AS STRING)                  AS capitalwork_id,
    CAST(assetid AS STRING)             AS asset_id,
    NULLIF(
        TRIM(
            CAST(name AS STRING)
        ),
        ''
    ) AS capitalwork_name,
    NULLIF(
        TRIM(
            CAST(contract AS STRING)
        ),
        ''
    ) AS contract,
    NULLIF(
        TRIM(
            CAST(direction AS STRING)
        ),
        ''
    ) AS direction,
    CAST(chainagefrom AS DOUBLE)        AS chainage_from,
    CAST(chainageto AS DOUBLE)          AS chainage_to,
    CAST(plannedstart AS TIMESTAMP)     AS planned_start,
    CAST(actualfinish AS TIMESTAMP)     AS actual_finish
FROM ext_mssql_asset_vision_ven_rms_new.dbo.capitalwork
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_ven_vicroads'         AS source_context,
    CAST(id AS STRING)                  AS capitalwork_id,
    CAST(assetid AS STRING)             AS asset_id,
    NULLIF(
        TRIM(
            CAST(name AS STRING)
        ),
        ''
    ) AS capitalwork_name,
    NULLIF(
        TRIM(
            CAST(contract AS STRING)
        ),
        ''
    ) AS contract,
    NULLIF(
        TRIM(
            CAST(direction AS STRING)
        ),
        ''
    ) AS direction,
    CAST(chainagefrom AS DOUBLE)        AS chainage_from,
    CAST(chainageto AS DOUBLE)          AS chainage_to,
    CAST(plannedstart AS TIMESTAMP)     AS planned_start,
    CAST(actualfinish AS TIMESTAMP)     AS actual_finish
FROM ext_mssql_asset_vision_ven_vicroads.dbo.capitalwork
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_vns_gen7'             AS source_context,
    CAST(id AS STRING)                  AS capitalwork_id,
    CAST(assetid AS STRING)             AS asset_id,
    NULLIF(
        TRIM(
            CAST(name AS STRING)
        ),
        ''
    ) AS capitalwork_name,
    NULLIF(
        TRIM(
            CAST(contract AS STRING)
        ),
        ''
    ) AS contract,
    NULLIF(
        TRIM(
            CAST(direction AS STRING)
        ),
        ''
    ) AS direction,
    CAST(chainagefrom AS DOUBLE)        AS chainage_from,
    CAST(chainageto AS DOUBLE)          AS chainage_to,
    CAST(plannedstart AS TIMESTAMP)     AS planned_start,
    CAST(actualfinish AS TIMESTAMP)     AS actual_finish
FROM ext_mssql_asset_vision_vns_gen7.dbo.capitalwork
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_vnz_gen7'             AS source_context,
    CAST(id AS STRING)                  AS capitalwork_id,
    CAST(assetid AS STRING)             AS asset_id,
    NULLIF(
        TRIM(
            CAST(name AS STRING)
        ),
        ''
    ) AS capitalwork_name,
    NULLIF(
        TRIM(
            CAST(contract AS STRING)
        ),
        ''
    ) AS contract,
    NULLIF(
        TRIM(
            CAST(direction AS STRING)
        ),
        ''
    ) AS direction,
    CAST(chainagefrom AS DOUBLE)        AS chainage_from,
    CAST(chainageto AS DOUBLE)          AS chainage_to,
    CAST(plannedstart AS TIMESTAMP)     AS planned_start,
    CAST(actualfinish AS TIMESTAMP)     AS actual_finish
FROM ext_mssql_asset_vision_vnz_gen7.dbo.capitalwork
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_vsm_gen7'             AS source_context,
    CAST(id AS STRING)                  AS capitalwork_id,
    CAST(assetid AS STRING)             AS asset_id,
    NULLIF(
        TRIM(
            CAST(name AS STRING)
        ),
        ''
    ) AS capitalwork_name,
    NULLIF(
        TRIM(
            CAST(contract AS STRING)
        ),
        ''
    ) AS contract,
    NULLIF(
        TRIM(
            CAST(direction AS STRING)
        ),
        ''
    ) AS direction,
    CAST(chainagefrom AS DOUBLE)        AS chainage_from,
    CAST(chainageto AS DOUBLE)          AS chainage_to,
    CAST(plannedstart AS TIMESTAMP)     AS planned_start,
    CAST(actualfinish AS TIMESTAMP)     AS actual_finish
FROM ext_mssql_asset_vision_vsm_gen7.dbo.capitalwork
WHERE COALESCE(deleted, FALSE) = FALSE
;


CREATE OR REPLACE TABLE transport_dev.integ_transport_assets.vw_bronze_transport_photo_base AS
SELECT
    'asset_vision_ven_gen7'             AS source_context,
    CAST(id AS STRING)                  AS photo_id,
    NULLIF(
        LOWER(
            TRIM(
                CAST(sourcetable AS STRING)
            )
        ),
        ''
    ) AS source_table,
    CAST(sourcetableid AS STRING)       AS source_table_id,
    NULLIF(
        TRIM(
            CAST(stage AS STRING)
        ),
        ''
    ) AS stage,
    CAST(createddate AS TIMESTAMP)      AS created_date
FROM ext_mssql_asset_vision_ven_gen7.dbo.photo
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_ven_rms'              AS source_context,
    CAST(id AS STRING)                  AS photo_id,
    NULLIF(
        LOWER(
            TRIM(
                CAST(sourcetable AS STRING)
            )
        ),
        ''
    ) AS source_table,
    CAST(sourcetableid AS STRING)       AS source_table_id,
    NULLIF(
        TRIM(
            CAST(stage AS STRING)
        ),
        ''
    ) AS stage,
    CAST(createddate AS TIMESTAMP)      AS created_date
FROM ext_mssql_asset_vision_ven_rms.dbo.photo
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_ven_rms_new'          AS source_context,
    CAST(id AS STRING)                  AS photo_id,
    NULLIF(
        LOWER(
            TRIM(
                CAST(sourcetable AS STRING)
            )
        ),
        ''
    ) AS source_table,
    CAST(sourcetableid AS STRING)       AS source_table_id,
    NULLIF(
        TRIM(
            CAST(stage AS STRING)
        ),
        ''
    ) AS stage,
    CAST(createddate AS TIMESTAMP)      AS created_date
FROM ext_mssql_asset_vision_ven_rms_new.dbo.photo
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_ven_vicroads'         AS source_context,
    CAST(id AS STRING)                  AS photo_id,
    NULLIF(
        LOWER(
            TRIM(
                CAST(sourcetable AS STRING)
            )
        ),
        ''
    ) AS source_table,
    CAST(sourcetableid AS STRING)       AS source_table_id,
    NULLIF(
        TRIM(
            CAST(stage AS STRING)
        ),
        ''
    ) AS stage,
    CAST(createddate AS TIMESTAMP)      AS created_date
FROM ext_mssql_asset_vision_ven_vicroads.dbo.photo
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_vns_gen7'             AS source_context,
    CAST(id AS STRING)                  AS photo_id,
    NULLIF(
        LOWER(
            TRIM(
                CAST(sourcetable AS STRING)
            )
        ),
        ''
    ) AS source_table,
    CAST(sourcetableid AS STRING)       AS source_table_id,
    NULLIF(
        TRIM(
            CAST(stage AS STRING)
        ),
        ''
    ) AS stage,
    CAST(createddate AS TIMESTAMP)      AS created_date
FROM ext_mssql_asset_vision_vns_gen7.dbo.photo
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_vnz_gen7'             AS source_context,
    CAST(id AS STRING)                  AS photo_id,
    NULLIF(
        LOWER(
            TRIM(
                CAST(sourcetable AS STRING)
            )
        ),
        ''
    ) AS source_table,
    CAST(sourcetableid AS STRING)       AS source_table_id,
    NULLIF(
        TRIM(
            CAST(stage AS STRING)
        ),
        ''
    ) AS stage,
    CAST(createddate AS TIMESTAMP)      AS created_date
FROM ext_mssql_asset_vision_vnz_gen7.dbo.photo
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_vsm_gen7'             AS source_context,
    CAST(id AS STRING)                  AS photo_id,
    NULLIF(
        LOWER(
            TRIM(
                CAST(sourcetable AS STRING)
            )
        ),
        ''
    ) AS source_table,
    CAST(sourcetableid AS STRING)       AS source_table_id,
    NULLIF(
        TRIM(
            CAST(stage AS STRING)
        ),
        ''
    ) AS stage,
    CAST(createddate AS TIMESTAMP)      AS created_date
FROM ext_mssql_asset_vision_vsm_gen7.dbo.photo
WHERE COALESCE(deleted, FALSE) = FALSE
;


CREATE OR REPLACE TABLE transport_dev.integ_transport_assets.vw_bronze_transport_resource_base AS
SELECT
    'asset_vision_ven_gen7'             AS source_context,
    CAST(id AS STRING)                  AS resource_id,
    NULLIF(
        TRIM(
            CAST(code AS STRING)
        ),
        ''
    ) AS resource_code,
    NULLIF(
        TRIM(
            CAST(name AS STRING)
        ),
        ''
    ) AS resource_name,
    COALESCE(
        NULLIF(
            TRIM(
                CAST(contract AS STRING)
            ),
            ''
        ),
        'asset_vision_ven_gen7'
    ) AS contract,
    NULLIF(
        TRIM(
            CAST(resourcetype AS STRING)
        ),
        ''
    ) AS resource_type,
    NULLIF(
        TRIM(
            CAST(resourcegroup AS STRING)
        ),
        ''
    ) AS resource_group,
    CAST(parentresourceid AS STRING)    AS parent_resource_id,
    NULLIF(
        TRIM(
            CAST(parentresourcecode AS STRING)
        ),
        ''
    ) AS parent_resource_code,
    NULLIF(
        TRIM(
            CAST(parentresourcename AS STRING)
        ),
        ''
    ) AS parent_resource_name,
    NULLIF(
        TRIM(
            CAST(parentresourcetypename AS STRING)
        ),
        ''
    ) AS parent_resource_type_name,
    NULLIF(
        TRIM(
            CAST(stage AS STRING)
        ),
        ''
    ) AS stage,
    CAST(cost AS DOUBLE)                AS resource_cost,
    CAST(quantity AS DOUBLE)            AS resource_quantity,
    NULLIF(
        TRIM(
            CAST(unit AS STRING)
        ),
        ''
    ) AS resource_unit
FROM ext_mssql_asset_vision_ven_gen7.dbo.resource
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_ven_vicroads'         AS source_context,
    CAST(id AS STRING)                  AS resource_id,
    NULLIF(
        TRIM(
            CAST(code AS STRING)
        ),
        ''
    ) AS resource_code,
    NULLIF(
        TRIM(
            CAST(name AS STRING)
        ),
        ''
    ) AS resource_name,
    COALESCE(
        NULLIF(
            TRIM(
                CAST(contract AS STRING)
            ),
            ''
        ),
        'asset_vision_ven_vicroads'
    ) AS contract,
    NULLIF(
        TRIM(
            CAST(resourcetype AS STRING)
        ),
        ''
    ) AS resource_type,
    NULLIF(
        TRIM(
            CAST(resourcegroup AS STRING)
        ),
        ''
    ) AS resource_group,
    CAST(parentresourceid AS STRING)    AS parent_resource_id,
    NULLIF(
        TRIM(
            CAST(parentresourcecode AS STRING)
        ),
        ''
    ) AS parent_resource_code,
    NULLIF(
        TRIM(
            CAST(parentresourcename AS STRING)
        ),
        ''
    ) AS parent_resource_name,
    NULLIF(
        TRIM(
            CAST(parentresourcetypename AS STRING)
        ),
        ''
    ) AS parent_resource_type_name,
    NULLIF(
        TRIM(
            CAST(stage AS STRING)
        ),
        ''
    ) AS stage,
    CAST(cost AS DOUBLE)                AS resource_cost,
    CAST(quantity AS DOUBLE)            AS resource_quantity,
    NULLIF(
        TRIM(
            CAST(unit AS STRING)
        ),
        ''
    ) AS resource_unit
FROM ext_mssql_asset_vision_ven_vicroads.dbo.resource
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_vns_gen7'             AS source_context,
    CAST(id AS STRING)                  AS resource_id,
    NULLIF(
        TRIM(
            CAST(code AS STRING)
        ),
        ''
    ) AS resource_code,
    NULLIF(
        TRIM(
            CAST(name AS STRING)
        ),
        ''
    ) AS resource_name,
    COALESCE(
        NULLIF(
            TRIM(
                CAST(contract AS STRING)
            ),
            ''
        ),
        'asset_vision_vns_gen7'
    ) AS contract,
    NULLIF(
        TRIM(
            CAST(resourcetype AS STRING)
        ),
        ''
    ) AS resource_type,
    NULLIF(
        TRIM(
            CAST(resourcegroup AS STRING)
        ),
        ''
    ) AS resource_group,
    CAST(parentresourceid AS STRING)    AS parent_resource_id,
    NULLIF(
        TRIM(
            CAST(parentresourcecode AS STRING)
        ),
        ''
    ) AS parent_resource_code,
    NULLIF(
        TRIM(
            CAST(parentresourcename AS STRING)
        ),
        ''
    ) AS parent_resource_name,
    NULLIF(
        TRIM(
            CAST(parentresourcetypename AS STRING)
        ),
        ''
    ) AS parent_resource_type_name,
    NULLIF(
        TRIM(
            CAST(stage AS STRING)
        ),
        ''
    ) AS stage,
    CAST(cost AS DOUBLE)                AS resource_cost,
    CAST(quantity AS DOUBLE)            AS resource_quantity,
    NULLIF(
        TRIM(
            CAST(unit AS STRING)
        ),
        ''
    ) AS resource_unit
FROM ext_mssql_asset_vision_vns_gen7.dbo.resource
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_vnz_gen7'             AS source_context,
    CAST(id AS STRING)                  AS resource_id,
    NULLIF(
        TRIM(
            CAST(code AS STRING)
        ),
        ''
    ) AS resource_code,
    NULLIF(
        TRIM(
            CAST(name AS STRING)
        ),
        ''
    ) AS resource_name,
    COALESCE(
        NULLIF(
            TRIM(
                CAST(contract AS STRING)
            ),
            ''
        ),
        'asset_vision_vnz_gen7'
    ) AS contract,
    NULLIF(
        TRIM(
            CAST(resourcetype AS STRING)
        ),
        ''
    ) AS resource_type,
    NULLIF(
        TRIM(
            CAST(resourcegroup AS STRING)
        ),
        ''
    ) AS resource_group,
    CAST(parentresourceid AS STRING)    AS parent_resource_id,
    NULLIF(
        TRIM(
            CAST(parentresourcecode AS STRING)
        ),
        ''
    ) AS parent_resource_code,
    NULLIF(
        TRIM(
            CAST(parentresourcename AS STRING)
        ),
        ''
    ) AS parent_resource_name,
    NULLIF(
        TRIM(
            CAST(parentresourcetypename AS STRING)
        ),
        ''
    ) AS parent_resource_type_name,
    NULLIF(
        TRIM(
            CAST(stage AS STRING)
        ),
        ''
    ) AS stage,
    CAST(cost AS DOUBLE)                AS resource_cost,
    CAST(quantity AS DOUBLE)            AS resource_quantity,
    NULLIF(
        TRIM(
            CAST(unit AS STRING)
        ),
        ''
    ) AS resource_unit
FROM ext_mssql_asset_vision_vnz_gen7.dbo.resource
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_vsm_gen7'             AS source_context,
    CAST(id AS STRING)                  AS resource_id,
    NULLIF(
        TRIM(
            CAST(code AS STRING)
        ),
        ''
    ) AS resource_code,
    NULLIF(
        TRIM(
            CAST(name AS STRING)
        ),
        ''
    ) AS resource_name,
    COALESCE(
        NULLIF(
            TRIM(
                CAST(contract AS STRING)
            ),
            ''
        ),
        'asset_vision_vsm_gen7'
    ) AS contract,
    NULLIF(
        TRIM(
            CAST(resourcetype AS STRING)
        ),
        ''
    ) AS resource_type,
    NULLIF(
        TRIM(
            CAST(resourcegroup AS STRING)
        ),
        ''
    ) AS resource_group,
    CAST(parentresourceid AS STRING)    AS parent_resource_id,
    NULLIF(
        TRIM(
            CAST(parentresourcecode AS STRING)
        ),
        ''
    ) AS parent_resource_code,
    NULLIF(
        TRIM(
            CAST(parentresourcename AS STRING)
        ),
        ''
    ) AS parent_resource_name,
    NULLIF(
        TRIM(
            CAST(parentresourcetypename AS STRING)
        ),
        ''
    ) AS parent_resource_type_name,
    NULLIF(
        TRIM(
            CAST(stage AS STRING)
        ),
        ''
    ) AS stage,
    CAST(cost AS DOUBLE)                AS resource_cost,
    CAST(quantity AS DOUBLE)            AS resource_quantity,
    NULLIF(
        TRIM(
            CAST(unit AS STRING)
        ),
        ''
    ) AS resource_unit
FROM ext_mssql_asset_vision_vsm_gen7.dbo.resource
WHERE COALESCE(deleted, FALSE) = FALSE
;


CREATE OR REPLACE TABLE transport_dev.integ_transport_assets.vw_bronze_transport_planned_resource_item_base AS
SELECT
    'asset_vision_ven_gen7'             AS source_context,
    CAST(id AS STRING)                  AS planned_resource_item_id,
    CAST(plannedresourceid AS STRING)   AS planned_resource_id,
    NULLIF(
        LOWER(
            TRIM(
                CAST(sourcetable AS STRING)
            )
        ),
        ''
    ) AS source_table,
    CAST(sourcetableid AS STRING)       AS source_table_id,
    NULLIF(
        TRIM(
            CAST(plannedresourcetypename AS STRING)
        ),
        ''
    ) AS planned_resource_type_name,
    NULLIF(
        TRIM(
            CAST(companyratename AS STRING)
        ),
        ''
    ) AS company_rate_name,
    NULLIF(
        TRIM(
            CAST(companyratereference1 AS STRING)
        ),
        ''
    ) AS company_rate_reference_1,
    NULLIF(
        TRIM(
            CAST(companyratereference2 AS STRING)
        ),
        ''
    ) AS company_rate_reference_2,
    CAST(hours AS DOUBLE)               AS planned_hours,
    CAST(minutes AS DOUBLE)             AS planned_minutes,
    CAST(quantity AS DOUBLE)            AS planned_quantity,
    CAST(multiplier AS DOUBLE)          AS multiplier,
    CAST(cost AS DOUBLE)                AS planned_cost,
    NULLIF(
        TRIM(
            CAST(resourcecode AS STRING)
        ),
        ''
    ) AS resource_code,
    NULLIF(
        TRIM(
            CAST(resourcename AS STRING)
        ),
        ''
    ) AS resource_name,
    NULLIF(
        TRIM(
            CAST(resourcetype AS STRING)
        ),
        ''
    ) AS resource_type,
    CAST(startdate AS TIMESTAMP)        AS start_date,
    CAST(enddate AS TIMESTAMP)          AS end_date
FROM ext_mssql_asset_vision_ven_gen7.dbo.plannedresourceitem
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_ven_rms'              AS source_context,
    CAST(id AS STRING)                  AS planned_resource_item_id,
    CAST(plannedresourceid AS STRING)   AS planned_resource_id,
    NULLIF(
        LOWER(
            TRIM(
                CAST(sourcetable AS STRING)
            )
        ),
        ''
    ) AS source_table,
    CAST(sourcetableid AS STRING)       AS source_table_id,
    NULLIF(
        TRIM(
            CAST(plannedresourcetypename AS STRING)
        ),
        ''
    ) AS planned_resource_type_name,
    NULLIF(
        TRIM(
            CAST(companyratename AS STRING)
        ),
        ''
    ) AS company_rate_name,
    NULLIF(
        TRIM(
            CAST(companyratereference1 AS STRING)
        ),
        ''
    ) AS company_rate_reference_1,
    NULLIF(
        TRIM(
            CAST(companyratereference2 AS STRING)
        ),
        ''
    ) AS company_rate_reference_2,
    CAST(hours AS DOUBLE)               AS planned_hours,
    CAST(minutes AS DOUBLE)             AS planned_minutes,
    CAST(quantity AS DOUBLE)            AS planned_quantity,
    CAST(multiplier AS DOUBLE)          AS multiplier,
    CAST(cost AS DOUBLE)                AS planned_cost,
    NULLIF(
        TRIM(
            CAST(resourcecode AS STRING)
        ),
        ''
    ) AS resource_code,
    NULLIF(
        TRIM(
            CAST(resourcename AS STRING)
        ),
        ''
    ) AS resource_name,
    NULLIF(
        TRIM(
            CAST(resourcetype AS STRING)
        ),
        ''
    ) AS resource_type,
    CAST(startdate AS TIMESTAMP)        AS start_date,
    CAST(enddate AS TIMESTAMP)          AS end_date
FROM ext_mssql_asset_vision_ven_rms.dbo.plannedresourceitem
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_ven_rms_new'          AS source_context,
    CAST(id AS STRING)                  AS planned_resource_item_id,
    CAST(plannedresourceid AS STRING)   AS planned_resource_id,
    NULLIF(
        LOWER(
            TRIM(
                CAST(sourcetable AS STRING)
            )
        ),
        ''
    ) AS source_table,
    CAST(sourcetableid AS STRING)       AS source_table_id,
    NULLIF(
        TRIM(
            CAST(plannedresourcetypename AS STRING)
        ),
        ''
    ) AS planned_resource_type_name,
    NULLIF(
        TRIM(
            CAST(companyratename AS STRING)
        ),
        ''
    ) AS company_rate_name,
    NULLIF(
        TRIM(
            CAST(companyratereference1 AS STRING)
        ),
        ''
    ) AS company_rate_reference_1,
    NULLIF(
        TRIM(
            CAST(companyratereference2 AS STRING)
        ),
        ''
    ) AS company_rate_reference_2,
    CAST(hours AS DOUBLE)               AS planned_hours,
    CAST(minutes AS DOUBLE)             AS planned_minutes,
    CAST(quantity AS DOUBLE)            AS planned_quantity,
    CAST(multiplier AS DOUBLE)          AS multiplier,
    CAST(cost AS DOUBLE)                AS planned_cost,
    NULLIF(
        TRIM(
            CAST(resourcecode AS STRING)
        ),
        ''
    ) AS resource_code,
    NULLIF(
        TRIM(
            CAST(resourcename AS STRING)
        ),
        ''
    ) AS resource_name,
    NULLIF(
        TRIM(
            CAST(resourcetype AS STRING)
        ),
        ''
    ) AS resource_type,
    CAST(startdate AS TIMESTAMP)        AS start_date,
    CAST(enddate AS TIMESTAMP)          AS end_date
FROM ext_mssql_asset_vision_ven_rms_new.dbo.plannedresourceitem
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_ven_vicroads'         AS source_context,
    CAST(id AS STRING)                  AS planned_resource_item_id,
    CAST(plannedresourceid AS STRING)   AS planned_resource_id,
    NULLIF(
        LOWER(
            TRIM(
                CAST(sourcetable AS STRING)
            )
        ),
        ''
    ) AS source_table,
    CAST(sourcetableid AS STRING)       AS source_table_id,
    NULLIF(
        TRIM(
            CAST(plannedresourcetypename AS STRING)
        ),
        ''
    ) AS planned_resource_type_name,
    NULLIF(
        TRIM(
            CAST(companyratename AS STRING)
        ),
        ''
    ) AS company_rate_name,
    NULLIF(
        TRIM(
            CAST(companyratereference1 AS STRING)
        ),
        ''
    ) AS company_rate_reference_1,
    NULLIF(
        TRIM(
            CAST(companyratereference2 AS STRING)
        ),
        ''
    ) AS company_rate_reference_2,
    CAST(hours AS DOUBLE)               AS planned_hours,
    CAST(minutes AS DOUBLE)             AS planned_minutes,
    CAST(quantity AS DOUBLE)            AS planned_quantity,
    CAST(multiplier AS DOUBLE)          AS multiplier,
    CAST(cost AS DOUBLE)                AS planned_cost,
    NULLIF(
        TRIM(
            CAST(resourcecode AS STRING)
        ),
        ''
    ) AS resource_code,
    NULLIF(
        TRIM(
            CAST(resourcename AS STRING)
        ),
        ''
    ) AS resource_name,
    NULLIF(
        TRIM(
            CAST(resourcetype AS STRING)
        ),
        ''
    ) AS resource_type,
    CAST(startdate AS TIMESTAMP)        AS start_date,
    CAST(enddate AS TIMESTAMP)          AS end_date
FROM ext_mssql_asset_vision_ven_vicroads.dbo.plannedresourceitem
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_vns_gen7'             AS source_context,
    CAST(id AS STRING)                  AS planned_resource_item_id,
    CAST(plannedresourceid AS STRING)   AS planned_resource_id,
    NULLIF(
        LOWER(
            TRIM(
                CAST(sourcetable AS STRING)
            )
        ),
        ''
    ) AS source_table,
    CAST(sourcetableid AS STRING)       AS source_table_id,
    NULLIF(
        TRIM(
            CAST(plannedresourcetypename AS STRING)
        ),
        ''
    ) AS planned_resource_type_name,
    NULLIF(
        TRIM(
            CAST(companyratename AS STRING)
        ),
        ''
    ) AS company_rate_name,
    NULLIF(
        TRIM(
            CAST(companyratereference1 AS STRING)
        ),
        ''
    ) AS company_rate_reference_1,
    NULLIF(
        TRIM(
            CAST(companyratereference2 AS STRING)
        ),
        ''
    ) AS company_rate_reference_2,
    CAST(hours AS DOUBLE)               AS planned_hours,
    CAST(minutes AS DOUBLE)             AS planned_minutes,
    CAST(quantity AS DOUBLE)            AS planned_quantity,
    CAST(multiplier AS DOUBLE)          AS multiplier,
    CAST(cost AS DOUBLE)                AS planned_cost,
    NULLIF(
        TRIM(
            CAST(resourcecode AS STRING)
        ),
        ''
    ) AS resource_code,
    NULLIF(
        TRIM(
            CAST(resourcename AS STRING)
        ),
        ''
    ) AS resource_name,
    NULLIF(
        TRIM(
            CAST(resourcetype AS STRING)
        ),
        ''
    ) AS resource_type,
    CAST(startdate AS TIMESTAMP)        AS start_date,
    CAST(enddate AS TIMESTAMP)          AS end_date
FROM ext_mssql_asset_vision_vns_gen7.dbo.plannedresourceitem
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_vnz_gen7'             AS source_context,
    CAST(id AS STRING)                  AS planned_resource_item_id,
    CAST(plannedresourceid AS STRING)   AS planned_resource_id,
    NULLIF(
        LOWER(
            TRIM(
                CAST(sourcetable AS STRING)
            )
        ),
        ''
    ) AS source_table,
    CAST(sourcetableid AS STRING)       AS source_table_id,
    NULLIF(
        TRIM(
            CAST(plannedresourcetypename AS STRING)
        ),
        ''
    ) AS planned_resource_type_name,
    NULLIF(
        TRIM(
            CAST(companyratename AS STRING)
        ),
        ''
    ) AS company_rate_name,
    NULLIF(
        TRIM(
            CAST(companyratereference1 AS STRING)
        ),
        ''
    ) AS company_rate_reference_1,
    NULLIF(
        TRIM(
            CAST(companyratereference2 AS STRING)
        ),
        ''
    ) AS company_rate_reference_2,
    CAST(hours AS DOUBLE)               AS planned_hours,
    CAST(minutes AS DOUBLE)             AS planned_minutes,
    CAST(quantity AS DOUBLE)            AS planned_quantity,
    CAST(multiplier AS DOUBLE)          AS multiplier,
    CAST(cost AS DOUBLE)                AS planned_cost,
    NULLIF(
        TRIM(
            CAST(resourcecode AS STRING)
        ),
        ''
    ) AS resource_code,
    NULLIF(
        TRIM(
            CAST(resourcename AS STRING)
        ),
        ''
    ) AS resource_name,
    NULLIF(
        TRIM(
            CAST(resourcetype AS STRING)
        ),
        ''
    ) AS resource_type,
    CAST(startdate AS TIMESTAMP)        AS start_date,
    CAST(enddate AS TIMESTAMP)          AS end_date
FROM ext_mssql_asset_vision_vnz_gen7.dbo.plannedresourceitem
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_vsm_gen7'             AS source_context,
    CAST(id AS STRING)                  AS planned_resource_item_id,
    CAST(plannedresourceid AS STRING)   AS planned_resource_id,
    NULLIF(
        LOWER(
            TRIM(
                CAST(sourcetable AS STRING)
            )
        ),
        ''
    ) AS source_table,
    CAST(sourcetableid AS STRING)       AS source_table_id,
    NULLIF(
        TRIM(
            CAST(plannedresourcetypename AS STRING)
        ),
        ''
    ) AS planned_resource_type_name,
    NULLIF(
        TRIM(
            CAST(companyratename AS STRING)
        ),
        ''
    ) AS company_rate_name,
    NULLIF(
        TRIM(
            CAST(companyratereference1 AS STRING)
        ),
        ''
    ) AS company_rate_reference_1,
    NULLIF(
        TRIM(
            CAST(companyratereference2 AS STRING)
        ),
        ''
    ) AS company_rate_reference_2,
    CAST(hours AS DOUBLE)               AS planned_hours,
    CAST(minutes AS DOUBLE)             AS planned_minutes,
    CAST(quantity AS DOUBLE)            AS planned_quantity,
    CAST(multiplier AS DOUBLE)          AS multiplier,
    CAST(cost AS DOUBLE)                AS planned_cost,
    NULLIF(
        TRIM(
            CAST(resourcecode AS STRING)
        ),
        ''
    ) AS resource_code,
    NULLIF(
        TRIM(
            CAST(resourcename AS STRING)
        ),
        ''
    ) AS resource_name,
    NULLIF(
        TRIM(
            CAST(resourcetype AS STRING)
        ),
        ''
    ) AS resource_type,
    CAST(startdate AS TIMESTAMP)        AS start_date,
    CAST(enddate AS TIMESTAMP)          AS end_date
FROM ext_mssql_asset_vision_vsm_gen7.dbo.plannedresourceitem
WHERE COALESCE(deleted, FALSE) = FALSE
;


CREATE OR REPLACE TABLE transport_dev.integ_transport_assets.vw_bronze_transport_timesheet_item_base AS
SELECT
    'asset_vision_ven_gen7'             AS source_context,
    CAST(id AS STRING)                  AS timesheet_item_id,
    CAST(timesheetid AS STRING)         AS timesheet_id,
    NULLIF(
        LOWER(
            TRIM(
                CAST(sourcetable AS STRING)
            )
        ),
        ''
    ) AS source_table,
    CAST(sourcetableid AS STRING)       AS source_table_id,
    NULLIF(
        TRIM(
            CAST(timesheettypename AS STRING)
        ),
        ''
    ) AS timesheet_type_name,
    NULLIF(
        TRIM(
            CAST(companyratename AS STRING)
        ),
        ''
    ) AS company_rate_name,
    NULLIF(
        TRIM(
            CAST(companyratereference1 AS STRING)
        ),
        ''
    ) AS company_rate_reference_1,
    NULLIF(
        TRIM(
            CAST(companyratereference2 AS STRING)
        ),
        ''
    ) AS company_rate_reference_2,
    CAST(hours AS DOUBLE)               AS actual_hours,
    CAST(minutes AS DOUBLE)             AS actual_minutes,
    CAST(quantity AS DOUBLE)            AS actual_quantity,
    CAST(multiplier AS DOUBLE)          AS multiplier,
    CAST(cost AS DOUBLE)                AS actual_cost,
    NULLIF(
        TRIM(
            CAST(resourcecode AS STRING)
        ),
        ''
    ) AS resource_code,
    NULLIF(
        TRIM(
            CAST(resourcename AS STRING)
        ),
        ''
    ) AS resource_name,
    NULLIF(
        TRIM(
            CAST(resourcetype AS STRING)
        ),
        ''
    ) AS resource_type,
    CAST(startdate AS TIMESTAMP)        AS start_date,
    CAST(enddate AS TIMESTAMP)          AS end_date
FROM ext_mssql_asset_vision_ven_gen7.dbo.timesheetitem
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_ven_rms'              AS source_context,
    CAST(id AS STRING)                  AS timesheet_item_id,
    CAST(timesheetid AS STRING)         AS timesheet_id,
    NULLIF(
        LOWER(
            TRIM(
                CAST(sourcetable AS STRING)
            )
        ),
        ''
    ) AS source_table,
    CAST(sourcetableid AS STRING)       AS source_table_id,
    NULLIF(
        TRIM(
            CAST(timesheettypename AS STRING)
        ),
        ''
    ) AS timesheet_type_name,
    NULLIF(
        TRIM(
            CAST(companyratename AS STRING)
        ),
        ''
    ) AS company_rate_name,
    NULLIF(
        TRIM(
            CAST(companyratereference1 AS STRING)
        ),
        ''
    ) AS company_rate_reference_1,
    NULLIF(
        TRIM(
            CAST(companyratereference2 AS STRING)
        ),
        ''
    ) AS company_rate_reference_2,
    CAST(hours AS DOUBLE)               AS actual_hours,
    CAST(minutes AS DOUBLE)             AS actual_minutes,
    CAST(quantity AS DOUBLE)            AS actual_quantity,
    CAST(multiplier AS DOUBLE)          AS multiplier,
    CAST(cost AS DOUBLE)                AS actual_cost,
    NULLIF(
        TRIM(
            CAST(resourcecode AS STRING)
        ),
        ''
    ) AS resource_code,
    NULLIF(
        TRIM(
            CAST(resourcename AS STRING)
        ),
        ''
    ) AS resource_name,
    NULLIF(
        TRIM(
            CAST(resourcetype AS STRING)
        ),
        ''
    ) AS resource_type,
    CAST(startdate AS TIMESTAMP)        AS start_date,
    CAST(enddate AS TIMESTAMP)          AS end_date
FROM ext_mssql_asset_vision_ven_rms.dbo.timesheetitem
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_ven_rms_new'          AS source_context,
    CAST(id AS STRING)                  AS timesheet_item_id,
    CAST(timesheetid AS STRING)         AS timesheet_id,
    NULLIF(
        LOWER(
            TRIM(
                CAST(sourcetable AS STRING)
            )
        ),
        ''
    ) AS source_table,
    CAST(sourcetableid AS STRING)       AS source_table_id,
    NULLIF(
        TRIM(
            CAST(timesheettypename AS STRING)
        ),
        ''
    ) AS timesheet_type_name,
    NULLIF(
        TRIM(
            CAST(companyratename AS STRING)
        ),
        ''
    ) AS company_rate_name,
    NULLIF(
        TRIM(
            CAST(companyratereference1 AS STRING)
        ),
        ''
    ) AS company_rate_reference_1,
    NULLIF(
        TRIM(
            CAST(companyratereference2 AS STRING)
        ),
        ''
    ) AS company_rate_reference_2,
    CAST(hours AS DOUBLE)               AS actual_hours,
    CAST(minutes AS DOUBLE)             AS actual_minutes,
    CAST(quantity AS DOUBLE)            AS actual_quantity,
    CAST(multiplier AS DOUBLE)          AS multiplier,
    CAST(cost AS DOUBLE)                AS actual_cost,
    NULLIF(
        TRIM(
            CAST(resourcecode AS STRING)
        ),
        ''
    ) AS resource_code,
    NULLIF(
        TRIM(
            CAST(resourcename AS STRING)
        ),
        ''
    ) AS resource_name,
    NULLIF(
        TRIM(
            CAST(resourcetype AS STRING)
        ),
        ''
    ) AS resource_type,
    CAST(startdate AS TIMESTAMP)        AS start_date,
    CAST(enddate AS TIMESTAMP)          AS end_date
FROM ext_mssql_asset_vision_ven_rms_new.dbo.timesheetitem
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_ven_vicroads'         AS source_context,
    CAST(id AS STRING)                  AS timesheet_item_id,
    CAST(timesheetid AS STRING)         AS timesheet_id,
    NULLIF(
        LOWER(
            TRIM(
                CAST(sourcetable AS STRING)
            )
        ),
        ''
    ) AS source_table,
    CAST(sourcetableid AS STRING)       AS source_table_id,
    NULLIF(
        TRIM(
            CAST(timesheettypename AS STRING)
        ),
        ''
    ) AS timesheet_type_name,
    NULLIF(
        TRIM(
            CAST(companyratename AS STRING)
        ),
        ''
    ) AS company_rate_name,
    NULLIF(
        TRIM(
            CAST(companyratereference1 AS STRING)
        ),
        ''
    ) AS company_rate_reference_1,
    NULLIF(
        TRIM(
            CAST(companyratereference2 AS STRING)
        ),
        ''
    ) AS company_rate_reference_2,
    CAST(hours AS DOUBLE)               AS actual_hours,
    CAST(minutes AS DOUBLE)             AS actual_minutes,
    CAST(quantity AS DOUBLE)            AS actual_quantity,
    CAST(multiplier AS DOUBLE)          AS multiplier,
    CAST(cost AS DOUBLE)                AS actual_cost,
    NULLIF(
        TRIM(
            CAST(resourcecode AS STRING)
        ),
        ''
    ) AS resource_code,
    NULLIF(
        TRIM(
            CAST(resourcename AS STRING)
        ),
        ''
    ) AS resource_name,
    NULLIF(
        TRIM(
            CAST(resourcetype AS STRING)
        ),
        ''
    ) AS resource_type,
    CAST(startdate AS TIMESTAMP)        AS start_date,
    CAST(enddate AS TIMESTAMP)          AS end_date
FROM ext_mssql_asset_vision_ven_vicroads.dbo.timesheetitem
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_vns_gen7'             AS source_context,
    CAST(id AS STRING)                  AS timesheet_item_id,
    CAST(timesheetid AS STRING)         AS timesheet_id,
    NULLIF(
        LOWER(
            TRIM(
                CAST(sourcetable AS STRING)
            )
        ),
        ''
    ) AS source_table,
    CAST(sourcetableid AS STRING)       AS source_table_id,
    NULLIF(
        TRIM(
            CAST(timesheettypename AS STRING)
        ),
        ''
    ) AS timesheet_type_name,
    NULLIF(
        TRIM(
            CAST(companyratename AS STRING)
        ),
        ''
    ) AS company_rate_name,
    NULLIF(
        TRIM(
            CAST(companyratereference1 AS STRING)
        ),
        ''
    ) AS company_rate_reference_1,
    NULLIF(
        TRIM(
            CAST(companyratereference2 AS STRING)
        ),
        ''
    ) AS company_rate_reference_2,
    CAST(hours AS DOUBLE)               AS actual_hours,
    CAST(minutes AS DOUBLE)             AS actual_minutes,
    CAST(quantity AS DOUBLE)            AS actual_quantity,
    CAST(multiplier AS DOUBLE)          AS multiplier,
    CAST(cost AS DOUBLE)                AS actual_cost,
    NULLIF(
        TRIM(
            CAST(resourcecode AS STRING)
        ),
        ''
    ) AS resource_code,
    NULLIF(
        TRIM(
            CAST(resourcename AS STRING)
        ),
        ''
    ) AS resource_name,
    NULLIF(
        TRIM(
            CAST(resourcetype AS STRING)
        ),
        ''
    ) AS resource_type,
    CAST(startdate AS TIMESTAMP)        AS start_date,
    CAST(enddate AS TIMESTAMP)          AS end_date
FROM ext_mssql_asset_vision_vns_gen7.dbo.timesheetitem
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_vnz_gen7'             AS source_context,
    CAST(id AS STRING)                  AS timesheet_item_id,
    CAST(timesheetid AS STRING)         AS timesheet_id,
    NULLIF(
        LOWER(
            TRIM(
                CAST(sourcetable AS STRING)
            )
        ),
        ''
    ) AS source_table,
    CAST(sourcetableid AS STRING)       AS source_table_id,
    NULLIF(
        TRIM(
            CAST(timesheettypename AS STRING)
        ),
        ''
    ) AS timesheet_type_name,
    NULLIF(
        TRIM(
            CAST(companyratename AS STRING)
        ),
        ''
    ) AS company_rate_name,
    NULLIF(
        TRIM(
            CAST(companyratereference1 AS STRING)
        ),
        ''
    ) AS company_rate_reference_1,
    NULLIF(
        TRIM(
            CAST(companyratereference2 AS STRING)
        ),
        ''
    ) AS company_rate_reference_2,
    CAST(hours AS DOUBLE)               AS actual_hours,
    CAST(minutes AS DOUBLE)             AS actual_minutes,
    CAST(quantity AS DOUBLE)            AS actual_quantity,
    CAST(multiplier AS DOUBLE)          AS multiplier,
    CAST(cost AS DOUBLE)                AS actual_cost,
    NULLIF(
        TRIM(
            CAST(resourcecode AS STRING)
        ),
        ''
    ) AS resource_code,
    NULLIF(
        TRIM(
            CAST(resourcename AS STRING)
        ),
        ''
    ) AS resource_name,
    NULLIF(
        TRIM(
            CAST(resourcetype AS STRING)
        ),
        ''
    ) AS resource_type,
    CAST(startdate AS TIMESTAMP)        AS start_date,
    CAST(enddate AS TIMESTAMP)          AS end_date
FROM ext_mssql_asset_vision_vnz_gen7.dbo.timesheetitem
WHERE COALESCE(deleted, FALSE) = FALSE

UNION ALL

SELECT
    'asset_vision_vsm_gen7'             AS source_context,
    CAST(id AS STRING)                  AS timesheet_item_id,
    CAST(timesheetid AS STRING)         AS timesheet_id,
    NULLIF(
        LOWER(
            TRIM(
                CAST(sourcetable AS STRING)
            )
        ),
        ''
    ) AS source_table,
    CAST(sourcetableid AS STRING)       AS source_table_id,
    NULLIF(
        TRIM(
            CAST(timesheettypename AS STRING)
        ),
        ''
    ) AS timesheet_type_name,
    NULLIF(
        TRIM(
            CAST(companyratename AS STRING)
        ),
        ''
    ) AS company_rate_name,
    NULLIF(
        TRIM(
            CAST(companyratereference1 AS STRING)
        ),
        ''
    ) AS company_rate_reference_1,
    NULLIF(
        TRIM(
            CAST(companyratereference2 AS STRING)
        ),
        ''
    ) AS company_rate_reference_2,
    CAST(hours AS DOUBLE)               AS actual_hours,
    CAST(minutes AS DOUBLE)             AS actual_minutes,
    CAST(quantity AS DOUBLE)            AS actual_quantity,
    CAST(multiplier AS DOUBLE)          AS multiplier,
    CAST(cost AS DOUBLE)                AS actual_cost,
    NULLIF(
        TRIM(
            CAST(resourcecode AS STRING)
        ),
        ''
    ) AS resource_code,
    NULLIF(
        TRIM(
            CAST(resourcename AS STRING)
        ),
        ''
    ) AS resource_name,
    NULLIF(
        TRIM(
            CAST(resourcetype AS STRING)
        ),
        ''
    ) AS resource_type,
    CAST(startdate AS TIMESTAMP)        AS start_date,
    CAST(enddate AS TIMESTAMP)          AS end_date
FROM ext_mssql_asset_vision_vsm_gen7.dbo.timesheetitem
WHERE COALESCE(deleted, FALSE) = FALSE
;


CREATE OR REPLACE VIEW transport_dev.integ_transport_assets.vw_transport_contract_asset_category_data_availability AS
WITH ASSET_WITH_CATEGORY AS (
    SELECT
        a.source_context,
        a.source_label,
        a.contract,
        a.asset_id,
        a.raw_asset_type,
        COALESCE(
            m.standardised_asset_type_name,
            a.raw_asset_type
        ) AS standardised_asset_type_name,
        COALESCE(
            m.asset_category,
            'Other / Unclassified'
        ) AS asset_category,
        CASE
            WHEN COALESCE(m.asset_category, 'Other / Unclassified') <> 'Other / Unclassified'
            THEN 1
            ELSE 0
        END AS has_classified_asset_category,
        CASE
            WHEN a.raw_asset_type <> 'Unspecified asset type'
            THEN 1
            ELSE 0
        END AS has_raw_asset_type,
        CASE
            WHEN a.classification IS NOT NULL
            THEN 1
            ELSE 0
        END AS has_classification,
        CASE
            WHEN a.spatial_type IS NOT NULL
            THEN 1
            ELSE 0
        END AS has_spatial_type,
        CASE
            WHEN a.asset_condition IS NOT NULL
            THEN 1
            ELSE 0
        END AS has_asset_condition,
        CASE
            WHEN a.asset_criticality IS NOT NULL
            THEN 1
            ELSE 0
        END AS has_asset_criticality,
        CASE
            WHEN a.asset_risk IS NOT NULL
            THEN 1
            ELSE 0
        END AS has_asset_risk,
        CASE
            WHEN a.chainage_from IS NOT NULL
                OR a.chainage_to IS NOT NULL
            THEN 1
            ELSE 0
        END AS has_chainage,
        CASE
            WHEN a.construction_date IS NOT NULL
            THEN 1
            ELSE 0
        END AS has_construction_date,
        CASE
            WHEN a.construction_cost IS NOT NULL
            THEN 1
            ELSE 0
        END AS has_construction_cost,
        CASE
            WHEN a.useful_life IS NOT NULL
            THEN 1
            ELSE 0
        END AS has_useful_life,
        CASE
            WHEN a.condition_date IS NOT NULL
            THEN 1
            ELSE 0
        END AS has_condition_date
    FROM transport_dev.integ_transport_assets.vw_bronze_transport_asset_base a
    LEFT JOIN transport_dev.integ_transport_assets.asset_vision_asset_type_category_map m
        ON LOWER(TRIM(a.raw_asset_type)) = LOWER(TRIM(m.asset_type))
),
LOCATION_BY_ASSET AS (
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
                THEN 1
                ELSE 0
            END
        ) AS has_attribute
    FROM transport_dev.integ_transport_assets.vw_bronze_transport_asset_attribute_base
    GROUP BY
        source_context,
        asset_id
),
JOB_ASSET_LINK AS (
    SELECT
        source_context,
        job_id,
        asset_id
    FROM transport_dev.integ_transport_assets.vw_bronze_transport_job_base
    WHERE asset_id IS NOT NULL

    UNION

    SELECT
        source_context,
        job_id,
        asset_id
    FROM transport_dev.integ_transport_assets.vw_bronze_transport_jobasset_base
    WHERE asset_id IS NOT NULL
),
JOB_BY_ASSET AS (
    SELECT
        jl.source_context,
        jl.asset_id,
        MAX(1) AS has_job,
        MAX(
            CASE
                WHEN j.completed_date IS NOT NULL
                THEN 1
                ELSE 0
            END
        ) AS has_completed_job,
        MAX(
            CASE
                WHEN j.hazard_defect_code IS NOT NULL
                THEN 1
                ELSE 0
            END
        ) AS has_hazard_defect_code,
        MAX(
            CASE
                WHEN j.activity_category_name IS NOT NULL
                    OR j.activity_name IS NOT NULL
                    OR j.activity_type IS NOT NULL
                THEN 1
                ELSE 0
            END
        ) AS has_activity_detail,
        MAX(
            CASE
                WHEN j.intervention_code IS NOT NULL
                THEN 1
                ELSE 0
            END
        ) AS has_intervention_code,
        MAX(
            CASE
                WHEN j.priority IS NOT NULL
                THEN 1
                ELSE 0
            END
        ) AS has_priority,
        MAX(
            CASE
                WHEN j.compliant IS NOT NULL
                THEN 1
                ELSE 0
            END
        ) AS has_compliance,
        MAX(
            CASE
                WHEN j.estimated_quantity IS NOT NULL
                    OR j.remaining_quantity IS NOT NULL
                    OR j.actual_quantity IS NOT NULL
                THEN 1
                ELSE 0
            END
        ) AS has_job_quantity,
        MAX(
            CASE
                WHEN j.estimated_length IS NOT NULL
                    OR j.estimated_width IS NOT NULL
                    OR j.estimated_depth IS NOT NULL
                THEN 1
                ELSE 0
            END
        ) AS has_job_dimensions
    FROM JOB_ASSET_LINK jl
    LEFT JOIN transport_dev.integ_transport_assets.vw_bronze_transport_job_base j
        ON jl.source_context = j.source_context
        AND jl.job_id = j.job_id
    GROUP BY
        jl.source_context,
        jl.asset_id
),
INSPECTION_BY_ASSET AS (
    SELECT
        source_context,
        asset_id,
        MAX(1) AS has_inspection,
        MAX(
            CASE
                WHEN completed_date IS NOT NULL
                THEN 1
                ELSE 0
            END
        ) AS has_completed_inspection,
        MAX(
            CASE
                WHEN inspection_type_name IS NOT NULL
                THEN 1
                ELSE 0
            END
        ) AS has_inspection_type,
        MAX(
            CASE
                WHEN scheduled_date IS NOT NULL
                    OR scheduled_date_to IS NOT NULL
                THEN 1
                ELSE 0
            END
        ) AS has_inspection_schedule
    FROM transport_dev.integ_transport_assets.vw_bronze_transport_inspection_base
    WHERE asset_id IS NOT NULL
    GROUP BY
        source_context,
        asset_id
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
PHOTO_ASSET_LINK AS (
    SELECT
        source_context,
        source_table_id AS asset_id
    FROM transport_dev.integ_transport_assets.vw_bronze_transport_photo_base
    WHERE source_table IN ('asset', 'vasset')
        AND source_table_id IS NOT NULL

    UNION

    SELECT
        p.source_context,
        jl.asset_id
    FROM transport_dev.integ_transport_assets.vw_bronze_transport_photo_base p
    INNER JOIN JOB_ASSET_LINK jl
        ON p.source_context = jl.source_context
        AND p.source_table_id = jl.job_id
    WHERE p.source_table IN ('job', 'vjob')
        AND p.source_table_id IS NOT NULL
),
PHOTO_BY_ASSET AS (
    SELECT
        source_context,
        asset_id,
        MAX(1) AS has_photo
    FROM PHOTO_ASSET_LINK
    GROUP BY
        source_context,
        asset_id
),
PLANNED_RESOURCE_ASSET_LINK AS (
    SELECT
        source_context,
        source_table_id AS asset_id,
        planned_hours,
        planned_minutes,
        planned_quantity,
        planned_cost
    FROM transport_dev.integ_transport_assets.vw_bronze_transport_planned_resource_item_base
    WHERE source_table IN ('asset', 'vasset')
        AND source_table_id IS NOT NULL

    UNION ALL

    SELECT
        pr.source_context,
        jl.asset_id,
        pr.planned_hours,
        pr.planned_minutes,
        pr.planned_quantity,
        pr.planned_cost
    FROM transport_dev.integ_transport_assets.vw_bronze_transport_planned_resource_item_base pr
    INNER JOIN JOB_ASSET_LINK jl
        ON pr.source_context = jl.source_context
        AND pr.source_table_id = jl.job_id
    WHERE pr.source_table IN ('job', 'vjob')
        AND pr.source_table_id IS NOT NULL

    UNION ALL

    SELECT
        pr.source_context,
        c.asset_id,
        pr.planned_hours,
        pr.planned_minutes,
        pr.planned_quantity,
        pr.planned_cost
    FROM transport_dev.integ_transport_assets.vw_bronze_transport_planned_resource_item_base pr
    INNER JOIN transport_dev.integ_transport_assets.vw_bronze_transport_capitalwork_base c
        ON pr.source_context = c.source_context
        AND pr.source_table_id = c.capitalwork_id
    WHERE pr.source_table IN ('capitalwork', 'vcapitalwork')
        AND pr.source_table_id IS NOT NULL
        AND c.asset_id IS NOT NULL

    UNION ALL

    SELECT
        pr.source_context,
        i.asset_id,
        pr.planned_hours,
        pr.planned_minutes,
        pr.planned_quantity,
        pr.planned_cost
    FROM transport_dev.integ_transport_assets.vw_bronze_transport_planned_resource_item_base pr
    INNER JOIN transport_dev.integ_transport_assets.vw_bronze_transport_inspection_base i
        ON pr.source_context = i.source_context
        AND pr.source_table_id = i.inspection_id
    WHERE pr.source_table IN ('inspection', 'vinspection')
        AND pr.source_table_id IS NOT NULL
        AND i.asset_id IS NOT NULL
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
    FROM PLANNED_RESOURCE_ASSET_LINK
    GROUP BY
        source_context,
        asset_id
),
TIMESHEET_ASSET_LINK AS (
    SELECT
        source_context,
        source_table_id AS asset_id,
        actual_hours,
        actual_minutes,
        actual_quantity,
        actual_cost
    FROM transport_dev.integ_transport_assets.vw_bronze_transport_timesheet_item_base
    WHERE source_table IN ('asset', 'vasset')
        AND source_table_id IS NOT NULL

    UNION ALL

    SELECT
        ts.source_context,
        jl.asset_id,
        ts.actual_hours,
        ts.actual_minutes,
        ts.actual_quantity,
        ts.actual_cost
    FROM transport_dev.integ_transport_assets.vw_bronze_transport_timesheet_item_base ts
    INNER JOIN JOB_ASSET_LINK jl
        ON ts.source_context = jl.source_context
        AND ts.source_table_id = jl.job_id
    WHERE ts.source_table IN ('job', 'vjob')
        AND ts.source_table_id IS NOT NULL

    UNION ALL

    SELECT
        ts.source_context,
        c.asset_id,
        ts.actual_hours,
        ts.actual_minutes,
        ts.actual_quantity,
        ts.actual_cost
    FROM transport_dev.integ_transport_assets.vw_bronze_transport_timesheet_item_base ts
    INNER JOIN transport_dev.integ_transport_assets.vw_bronze_transport_capitalwork_base c
        ON ts.source_context = c.source_context
        AND ts.source_table_id = c.capitalwork_id
    WHERE ts.source_table IN ('capitalwork', 'vcapitalwork')
        AND ts.source_table_id IS NOT NULL
        AND c.asset_id IS NOT NULL

    UNION ALL

    SELECT
        ts.source_context,
        i.asset_id,
        ts.actual_hours,
        ts.actual_minutes,
        ts.actual_quantity,
        ts.actual_cost
    FROM transport_dev.integ_transport_assets.vw_bronze_transport_timesheet_item_base ts
    INNER JOIN transport_dev.integ_transport_assets.vw_bronze_transport_inspection_base i
        ON ts.source_context = i.source_context
        AND ts.source_table_id = i.inspection_id
    WHERE ts.source_table IN ('inspection', 'vinspection')
        AND ts.source_table_id IS NOT NULL
        AND i.asset_id IS NOT NULL
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
    FROM TIMESHEET_ASSET_LINK
    GROUP BY
        source_context,
        asset_id
),
ASSET_AVAILABILITY AS (
    SELECT
        a.source_context,
        a.source_label,
        a.contract,
        a.asset_category,
        a.asset_id,
        a.has_classified_asset_category,
        a.has_raw_asset_type,
        a.has_classification,
        a.has_spatial_type,
        a.has_asset_condition,
        a.has_asset_criticality,
        a.has_asset_risk,
        a.has_chainage,
        a.has_construction_date,
        a.has_construction_cost,
        a.has_useful_life,
        a.has_condition_date,
        COALESCE(l.has_wkt, 0)                         AS has_wkt,
        COALESCE(l.has_valid_au_nz_coord, 0)           AS has_valid_au_nz_coord,
        COALESCE(aa.has_attribute, 0)                  AS has_attribute,
        COALESCE(j.has_job, 0)                         AS has_job,
        COALESCE(j.has_completed_job, 0)               AS has_completed_job,
        COALESCE(j.has_hazard_defect_code, 0)          AS has_hazard_defect_code,
        COALESCE(j.has_activity_detail, 0)             AS has_activity_detail,
        COALESCE(j.has_intervention_code, 0)           AS has_intervention_code,
        COALESCE(j.has_priority, 0)                    AS has_priority,
        COALESCE(j.has_compliance, 0)                  AS has_compliance,
        COALESCE(j.has_job_quantity, 0)                AS has_job_quantity,
        COALESCE(j.has_job_dimensions, 0)              AS has_job_dimensions,
        COALESCE(i.has_inspection, 0)                  AS has_inspection,
        COALESCE(i.has_completed_inspection, 0)        AS has_completed_inspection,
        COALESCE(i.has_inspection_type, 0)             AS has_inspection_type,
        COALESCE(i.has_inspection_schedule, 0)         AS has_inspection_schedule,
        COALESCE(c.has_capitalwork, 0)                 AS has_capitalwork,
        COALESCE(c.has_capitalwork_name, 0)            AS has_capitalwork_name,
        COALESCE(c.has_capitalwork_planned_start, 0)   AS has_capitalwork_planned_start,
        COALESCE(c.has_completed_capitalwork, 0)       AS has_completed_capitalwork,
        COALESCE(p.has_photo, 0)                       AS has_photo,
        COALESCE(pr.has_planned_resource, 0)           AS has_planned_resource,
        COALESCE(pr.has_planned_resource_time, 0)      AS has_planned_resource_time,
        COALESCE(pr.has_planned_resource_quantity, 0)  AS has_planned_resource_quantity,
        COALESCE(pr.has_planned_resource_cost, 0)      AS has_planned_resource_cost,
        COALESCE(ts.has_actual_timesheet, 0)           AS has_actual_timesheet,
        COALESCE(ts.has_actual_timesheet_time, 0)      AS has_actual_timesheet_time,
        COALESCE(ts.has_actual_timesheet_quantity, 0)  AS has_actual_timesheet_quantity,
        COALESCE(ts.has_actual_timesheet_cost, 0)      AS has_actual_timesheet_cost
    FROM ASSET_WITH_CATEGORY a
    LEFT JOIN LOCATION_BY_ASSET l
        ON a.source_context = l.source_context
        AND a.asset_id = l.asset_id
    LEFT JOIN ATTRIBUTE_BY_ASSET aa
        ON a.source_context = aa.source_context
        AND a.asset_id = aa.asset_id
    LEFT JOIN JOB_BY_ASSET j
        ON a.source_context = j.source_context
        AND a.asset_id = j.asset_id
    LEFT JOIN INSPECTION_BY_ASSET i
        ON a.source_context = i.source_context
        AND a.asset_id = i.asset_id
    LEFT JOIN CAPITALWORK_BY_ASSET c
        ON a.source_context = c.source_context
        AND a.asset_id = c.asset_id
    LEFT JOIN PHOTO_BY_ASSET p
        ON a.source_context = p.source_context
        AND a.asset_id = p.asset_id
    LEFT JOIN PLANNED_RESOURCE_BY_ASSET pr
        ON a.source_context = pr.source_context
        AND a.asset_id = pr.asset_id
    LEFT JOIN TIMESHEET_BY_ASSET ts
        ON a.source_context = ts.source_context
        AND a.asset_id = ts.asset_id
),
CATEGORY_ROLLUP AS (
    SELECT
        source_context,
        source_label,
        contract,
        asset_category,
        COUNT(*) AS asset_count,
        ROUND(100.0 * SUM(has_classified_asset_category) / COUNT(*), 1) AS pct_classified_asset_category,
        ROUND(100.0 * SUM(has_raw_asset_type) / COUNT(*), 1) AS pct_raw_asset_type_available,
        ROUND(100.0 * SUM(has_classification) / COUNT(*), 1) AS pct_source_classification_available,
        ROUND(100.0 * SUM(has_spatial_type) / COUNT(*), 1) AS pct_spatial_type_available,
        ROUND(100.0 * SUM(has_wkt) / COUNT(*), 1) AS pct_wkt_available,
        ROUND(100.0 * SUM(has_valid_au_nz_coord) / COUNT(*), 1) AS pct_valid_au_nz_coordinate,
        ROUND(100.0 * SUM(has_chainage) / COUNT(*), 1) AS pct_chainage_available,
        ROUND(100.0 * SUM(has_attribute) / COUNT(*), 1) AS pct_custom_attribute_available,
        ROUND(100.0 * SUM(has_asset_condition) / COUNT(*), 1) AS pct_condition_available,
        ROUND(100.0 * SUM(has_condition_date) / COUNT(*), 1) AS pct_condition_date_available,
        ROUND(100.0 * SUM(has_asset_criticality) / COUNT(*), 1) AS pct_criticality_available,
        ROUND(100.0 * SUM(has_asset_risk) / COUNT(*), 1) AS pct_risk_available,
        ROUND(100.0 * SUM(has_construction_date) / COUNT(*), 1) AS pct_construction_date_available,
        ROUND(100.0 * SUM(has_construction_cost) / COUNT(*), 1) AS pct_construction_cost_available,
        ROUND(100.0 * SUM(has_useful_life) / COUNT(*), 1) AS pct_useful_life_available,
        ROUND(100.0 * SUM(has_job) / COUNT(*), 1) AS pct_job_linked,
        ROUND(100.0 * SUM(has_completed_job) / COUNT(*), 1) AS pct_completed_job_available,
        ROUND(100.0 * SUM(has_hazard_defect_code) / COUNT(*), 1) AS pct_hazard_defect_code_available,
        ROUND(100.0 * SUM(has_activity_detail) / COUNT(*), 1) AS pct_activity_detail_available,
        ROUND(100.0 * SUM(has_intervention_code) / COUNT(*), 1) AS pct_intervention_code_available,
        ROUND(100.0 * SUM(has_priority) / COUNT(*), 1) AS pct_priority_available,
        ROUND(100.0 * SUM(has_compliance) / COUNT(*), 1) AS pct_compliance_available,
        ROUND(100.0 * SUM(has_job_quantity) / COUNT(*), 1) AS pct_job_quantity_available,
        ROUND(100.0 * SUM(has_job_dimensions) / COUNT(*), 1) AS pct_job_dimensions_available,
        ROUND(100.0 * SUM(has_inspection) / COUNT(*), 1) AS pct_inspection_linked,
        ROUND(100.0 * SUM(has_completed_inspection) / COUNT(*), 1) AS pct_completed_inspection_available,
        ROUND(100.0 * SUM(has_inspection_type) / COUNT(*), 1) AS pct_inspection_type_available,
        ROUND(100.0 * SUM(has_inspection_schedule) / COUNT(*), 1) AS pct_inspection_schedule_available,
        ROUND(100.0 * SUM(has_capitalwork) / COUNT(*), 1) AS pct_capitalwork_linked,
        ROUND(100.0 * SUM(has_capitalwork_name) / COUNT(*), 1) AS pct_capitalwork_name_available,
        ROUND(100.0 * SUM(has_capitalwork_planned_start) / COUNT(*), 1) AS pct_capitalwork_planned_start_available,
        ROUND(100.0 * SUM(has_completed_capitalwork) / COUNT(*), 1) AS pct_completed_capitalwork_available,
        ROUND(100.0 * SUM(has_photo) / COUNT(*), 1) AS pct_photo_linked,
        ROUND(100.0 * SUM(has_planned_resource) / COUNT(*), 1) AS pct_planned_resource_linked,
        ROUND(100.0 * SUM(has_planned_resource_time) / COUNT(*), 1) AS pct_planned_resource_time_available,
        ROUND(100.0 * SUM(has_planned_resource_quantity) / COUNT(*), 1) AS pct_planned_resource_quantity_available,
        ROUND(100.0 * SUM(has_planned_resource_cost) / COUNT(*), 1) AS pct_planned_resource_cost_available,
        ROUND(100.0 * SUM(has_actual_timesheet) / COUNT(*), 1) AS pct_actual_timesheet_linked,
        ROUND(100.0 * SUM(has_actual_timesheet_time) / COUNT(*), 1) AS pct_actual_timesheet_time_available,
        ROUND(100.0 * SUM(has_actual_timesheet_quantity) / COUNT(*), 1) AS pct_actual_timesheet_quantity_available,
        ROUND(100.0 * SUM(has_actual_timesheet_cost) / COUNT(*), 1) AS pct_actual_timesheet_cost_available
    FROM ASSET_AVAILABILITY
    GROUP BY
        source_context,
        source_label,
        contract,
        asset_category
),
METRIC_ROWS AS (
    SELECT
        source_context,
        source_label,
        contract,
        asset_category,
        asset_count,
        'Data quality' AS metric_classification,
        'Classified asset category' AS metric_name,
        pct_classified_asset_category AS metric_pct
    FROM CATEGORY_ROLLUP

    UNION ALL

    SELECT source_context, source_label, contract, asset_category, asset_count, 'Data quality', 'Raw asset type available', pct_raw_asset_type_available
    FROM CATEGORY_ROLLUP

    UNION ALL

    SELECT source_context, source_label, contract, asset_category, asset_count, 'Core asset data', 'Source classification available', pct_source_classification_available
    FROM CATEGORY_ROLLUP

    UNION ALL

    SELECT source_context, source_label, contract, asset_category, asset_count, 'Spatial data', 'Spatial type available', pct_spatial_type_available
    FROM CATEGORY_ROLLUP

    UNION ALL

    SELECT source_context, source_label, contract, asset_category, asset_count, 'Spatial data', 'WKT available', pct_wkt_available
    FROM CATEGORY_ROLLUP

    UNION ALL

    SELECT source_context, source_label, contract, asset_category, asset_count, 'Spatial data', 'Valid AU/NZ coordinate', pct_valid_au_nz_coordinate
    FROM CATEGORY_ROLLUP

    UNION ALL

    SELECT source_context, source_label, contract, asset_category, asset_count, 'Spatial data', 'Chainage available', pct_chainage_available
    FROM CATEGORY_ROLLUP

    UNION ALL

    SELECT source_context, source_label, contract, asset_category, asset_count, 'Custom attributes', 'Custom attribute available', pct_custom_attribute_available
    FROM CATEGORY_ROLLUP

    UNION ALL

    SELECT source_context, source_label, contract, asset_category, asset_count, 'Condition / risk', 'Condition available', pct_condition_available
    FROM CATEGORY_ROLLUP

    UNION ALL

    SELECT source_context, source_label, contract, asset_category, asset_count, 'Condition / risk', 'Condition date available', pct_condition_date_available
    FROM CATEGORY_ROLLUP

    UNION ALL

    SELECT source_context, source_label, contract, asset_category, asset_count, 'Condition / risk', 'Criticality available', pct_criticality_available
    FROM CATEGORY_ROLLUP

    UNION ALL

    SELECT source_context, source_label, contract, asset_category, asset_count, 'Condition / risk', 'Risk available', pct_risk_available
    FROM CATEGORY_ROLLUP

    UNION ALL

    SELECT source_context, source_label, contract, asset_category, asset_count, 'Lifecycle data', 'Construction date available', pct_construction_date_available
    FROM CATEGORY_ROLLUP

    UNION ALL

    SELECT source_context, source_label, contract, asset_category, asset_count, 'Lifecycle data', 'Construction cost available', pct_construction_cost_available
    FROM CATEGORY_ROLLUP

    UNION ALL

    SELECT source_context, source_label, contract, asset_category, asset_count, 'Lifecycle data', 'Useful life available', pct_useful_life_available
    FROM CATEGORY_ROLLUP

    UNION ALL

    SELECT source_context, source_label, contract, asset_category, asset_count, 'Work management', 'Job linked', pct_job_linked
    FROM CATEGORY_ROLLUP

    UNION ALL

    SELECT source_context, source_label, contract, asset_category, asset_count, 'Work management', 'Completed job available', pct_completed_job_available
    FROM CATEGORY_ROLLUP

    UNION ALL

    SELECT source_context, source_label, contract, asset_category, asset_count, 'Work management', 'Hazard/defect code available', pct_hazard_defect_code_available
    FROM CATEGORY_ROLLUP

    UNION ALL

    SELECT source_context, source_label, contract, asset_category, asset_count, 'Work management', 'Activity detail available', pct_activity_detail_available
    FROM CATEGORY_ROLLUP

    UNION ALL

    SELECT source_context, source_label, contract, asset_category, asset_count, 'Work management', 'Intervention code available', pct_intervention_code_available
    FROM CATEGORY_ROLLUP

    UNION ALL

    SELECT source_context, source_label, contract, asset_category, asset_count, 'Work management', 'Priority available', pct_priority_available
    FROM CATEGORY_ROLLUP

    UNION ALL

    SELECT source_context, source_label, contract, asset_category, asset_count, 'Work management', 'Compliance value available', pct_compliance_available
    FROM CATEGORY_ROLLUP

    UNION ALL

    SELECT source_context, source_label, contract, asset_category, asset_count, 'Work management', 'Job quantity available', pct_job_quantity_available
    FROM CATEGORY_ROLLUP

    UNION ALL

    SELECT source_context, source_label, contract, asset_category, asset_count, 'Work management', 'Job dimensions available', pct_job_dimensions_available
    FROM CATEGORY_ROLLUP

    UNION ALL

    SELECT source_context, source_label, contract, asset_category, asset_count, 'Inspection', 'Inspection linked', pct_inspection_linked
    FROM CATEGORY_ROLLUP

    UNION ALL

    SELECT source_context, source_label, contract, asset_category, asset_count, 'Inspection', 'Completed inspection available', pct_completed_inspection_available
    FROM CATEGORY_ROLLUP

    UNION ALL

    SELECT source_context, source_label, contract, asset_category, asset_count, 'Inspection', 'Inspection type available', pct_inspection_type_available
    FROM CATEGORY_ROLLUP

    UNION ALL

    SELECT source_context, source_label, contract, asset_category, asset_count, 'Inspection', 'Inspection schedule available', pct_inspection_schedule_available
    FROM CATEGORY_ROLLUP

    UNION ALL

    SELECT source_context, source_label, contract, asset_category, asset_count, 'Capital work', 'Capital work linked', pct_capitalwork_linked
    FROM CATEGORY_ROLLUP

    UNION ALL

    SELECT source_context, source_label, contract, asset_category, asset_count, 'Capital work', 'Capital work name available', pct_capitalwork_name_available
    FROM CATEGORY_ROLLUP

    UNION ALL

    SELECT source_context, source_label, contract, asset_category, asset_count, 'Capital work', 'Capital work planned start available', pct_capitalwork_planned_start_available
    FROM CATEGORY_ROLLUP

    UNION ALL

    SELECT source_context, source_label, contract, asset_category, asset_count, 'Capital work', 'Completed capital work available', pct_completed_capitalwork_available
    FROM CATEGORY_ROLLUP

    UNION ALL

    SELECT source_context, source_label, contract, asset_category, asset_count, 'Evidence', 'Photo linked', pct_photo_linked
    FROM CATEGORY_ROLLUP

    UNION ALL

    SELECT source_context, source_label, contract, asset_category, asset_count, 'Resource utilisation', 'Planned resource linked', pct_planned_resource_linked
    FROM CATEGORY_ROLLUP

    UNION ALL

    SELECT source_context, source_label, contract, asset_category, asset_count, 'Resource utilisation', 'Planned resource time available', pct_planned_resource_time_available
    FROM CATEGORY_ROLLUP

    UNION ALL

    SELECT
        source_context, source_label, contract, asset_category, asset_count,
        'Resource utilisation', 'Planned resource quantity available',
        pct_planned_resource_quantity_available
    FROM CATEGORY_ROLLUP

    UNION ALL

    SELECT source_context, source_label, contract, asset_category, asset_count, 'Resource utilisation', 'Planned resource cost available', pct_planned_resource_cost_available
    FROM CATEGORY_ROLLUP

    UNION ALL

    SELECT source_context, source_label, contract, asset_category, asset_count, 'Resource utilisation', 'Actual timesheet linked', pct_actual_timesheet_linked
    FROM CATEGORY_ROLLUP

    UNION ALL

    SELECT source_context, source_label, contract, asset_category, asset_count, 'Resource utilisation', 'Actual timesheet time available', pct_actual_timesheet_time_available
    FROM CATEGORY_ROLLUP

    UNION ALL

    SELECT
        source_context, source_label, contract, asset_category, asset_count,
        'Resource utilisation', 'Actual timesheet quantity available',
        pct_actual_timesheet_quantity_available
    FROM CATEGORY_ROLLUP

    UNION ALL

    SELECT source_context, source_label, contract, asset_category, asset_count, 'Resource utilisation', 'Actual timesheet cost available', pct_actual_timesheet_cost_available
    FROM CATEGORY_ROLLUP
)
SELECT
    source_context,
    source_label,
    contract,
    asset_category,
    asset_count,
    metric_classification,
    metric_name,
    metric_pct,
    CASE
        WHEN metric_pct >= 90 THEN 'High availability'
        WHEN metric_pct >= 70 THEN 'Moderate availability'
        WHEN metric_pct >= 30 THEN 'Low availability'
        WHEN metric_pct > 0 THEN 'Sparse availability'
        ELSE 'Unavailable'
    END AS data_quality_classification
FROM METRIC_ROWS
;
