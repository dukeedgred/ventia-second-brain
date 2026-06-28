CREATE OR REPLACE VIEW transport_dev.integ_transport_assets.vw_silver_transport_asset_with_category AS
SELECT
    A.source_context,
    A.source_catalog,
    A.source_label,
    A.contract AS raw_contract_name,
    CASE
        WHEN CONTRACT_MAP.raw_contract_name IS NOT NULL
        THEN CONTRACT_MAP.standardised_contract_name
        ELSE A.contract
    END AS standardised_contract_name,
    A.asset_id,
    A.raw_asset_type,
    COALESCE(
        CATEGORY_MAP.standardised_asset_type_name,
        A.raw_asset_type
    ) AS standardised_asset_type_name,
    COALESCE(
        CATEGORY_MAP.asset_category,
        'Other / Unclassified'
    ) AS asset_category,
    A.classification,
    A.spatial_type,
    A.asset_condition,
    A.asset_criticality,
    A.asset_risk,
    A.chainage_from,
    A.chainage_to,
    A.parent_asset_id,
    A.stage,
    A.construction_date,
    A.construction_cost,
    A.useful_life,
    A.condition_date,
    CASE
        WHEN CATEGORY_MAP.asset_category IS NOT NULL
        THEN 1
        ELSE 0
    END AS has_classified_asset_category,
    CASE
        WHEN A.raw_asset_type <> 'Unspecified asset type'
        THEN 1
        ELSE 0
    END AS has_raw_asset_type,
    CASE
        WHEN A.classification IS NOT NULL
        THEN 1
        ELSE 0
    END AS has_classification,
    CASE
        WHEN A.spatial_type IS NOT NULL
        THEN 1
        ELSE 0
    END AS has_spatial_type,
    CASE
        WHEN A.asset_condition IS NOT NULL
        THEN 1
        ELSE 0
    END AS has_asset_condition,
    CASE
        WHEN A.asset_criticality IS NOT NULL
        THEN 1
        ELSE 0
    END AS has_asset_criticality,
    CASE
        WHEN A.asset_risk IS NOT NULL
        THEN 1
        ELSE 0
    END AS has_asset_risk,
    CASE
        WHEN A.chainage_from IS NOT NULL
            OR A.chainage_to IS NOT NULL
        THEN 1
        ELSE 0
    END AS has_chainage,
    CASE
        WHEN A.construction_date IS NOT NULL
        THEN 1
        ELSE 0
    END AS has_construction_date,
    CASE
        WHEN A.construction_cost IS NOT NULL
        THEN 1
        ELSE 0
    END AS has_construction_cost,
    CASE
        WHEN A.useful_life IS NOT NULL
        THEN 1
        ELSE 0
    END AS has_useful_life,
    CASE
        WHEN A.condition_date IS NOT NULL
        THEN 1
        ELSE 0
    END AS has_condition_date
FROM transport_dev.integ_transport_assets.vw_bronze_transport_asset_base A
LEFT JOIN transport_dev.integ_transport_assets.map_transport_contract_group CONTRACT_MAP
    ON LOWER(TRIM(A.contract)) = LOWER(TRIM(CONTRACT_MAP.raw_contract_name))
LEFT JOIN transport_dev.integ_transport_assets.asset_vision_asset_type_category_map CATEGORY_MAP
    ON LOWER(TRIM(A.raw_asset_type)) = LOWER(TRIM(CATEGORY_MAP.asset_type))
;

