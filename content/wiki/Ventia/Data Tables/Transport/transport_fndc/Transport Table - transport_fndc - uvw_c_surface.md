---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_fndc
table-name: uvw_c_surface
full-name: transport_dev.transport_fndc.uvw_c_surface
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-fndc]
---

# Transport Table - transport_fndc - uvw_c_surface

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_c_surface` |
| Full name | `transport_dev.transport_fndc.uvw_c_surface` |
| Catalog | `transport_dev` |
| Schema | `transport_fndc` |
| Contract/schema | `transport_fndc` |
| Table type | VIEW |
| Column count | 79 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2026-06-03T01:40:58.317Z; Last altered: 2026-06-03T01:40:58.317Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
SELECT
    CAST(c_surface_id AS INT) AS c_surface_id,
    road_id AS road_name,
    CAST(start_m AS INT) AS start_m,
    CAST(end_m AS INT) AS end_m,
    CAST(length_m AS INT) AS length_m,
    start_name,
    end_name,
    CAST(northing AS DECIMAL(14, 4)) AS northing,
    CAST(easting AS DECIMAL(14, 4)) AS easting,
    CAST(northing_end AS DECIMAL(14, 4)) AS northing_end,
    CAST(easting_end AS DECIMAL(14, 4)) AS easting_end,
    CAST(gps_date AS TIMESTAMP) AS gps_date,
    gps_by,
    gps_method_id,
    CAST(surface_date AS TIMESTAMP) AS surface_date,
    CAST(removed_date AS TIMESTAMP) AS removed_date,
    CAST(age AS INT) AS age,
    CAST(surf_width AS DECIMAL(5, 2)) AS surf_width,
    full_width_flag,
    CAST(surf_offset AS DECIMAL(5, 2)) AS surf_offset,
    CAST(design_life AS INT) AS design_life,
    CAST(design_expiry AS INT) AS design_expiry,
    CAST(default_life AS INT) AS default_life,
    CAST(default_expiry AS INT) AS default_expiry,
    CAST(mod_default_life AS INT) AS mod_default_life,
    CAST(mod_default_expiry AS INT) AS mod_default_expiry,
    surf_material,
    surf_function,
    CAST(surf_depth AS INT) AS surf_depth,
    use_calc_depth,
    CAST(chip_size AS INT) AS chip_size,
    CAST(chip_2nd_size AS INT) AS chip_2nd_size,
    pave_source,
    surf_binder,
    CAST(flux AS INT) AS flux,
    CAST(cutter AS INT) AS cutter,
    cutter_type,
    CAST(adhesion AS DECIMAL(5, 2)) AS adhesion,
    surf_adhesion,
    CAST(additive AS DECIMAL(5, 2)) AS additive,
    surf_additive,
    polymer_type,
    CAST(polymer_mod_pcnt AS INT) AS polymer_mod_pcnt,
    CAST(elastic_recovery AS INT) AS elastic_recovery,
    CAST(softening_point AS INT) AS softening_point,
    CAST(rate AS DECIMAL(5, 2)) AS rate,
    CAST(sealed_area AS INT) AS sealed_area,
    sealed_area_ok,
    lane_coverage,
    contract_number,
    organisation,
    surf_spec,
    CAST(polished_stone AS INT) AS polished_stone,
    CAST(average_dim AS DECIMAL(5, 2)) AS average_dim,
    recycling,
    CAST(pct_recycled AS INT) AS pct_recycled,
    CAST(surf_recycled_cpnt AS INT) AS surf_recycled_cpnt,
    surf_reason,
    fw_treatment,
    work_origin_id,
    CAST(ru_life AS INT) AS ru_life,
    rul_reset,
    condition_wt,
    condition,
    CAST(condition_date AS TIMESTAMP) AS condition_date,
    asset_owner,
    standard_rc,
    use_default_rc,
    CAST(original_cost AS DECIMAL(10, 2)) AS original_cost,
    CAST(rc_value AS DECIMAL(14, 4)) AS rc_value,
    CAST(drc_value AS DECIMAL(14, 4)) AS drc_value,
    CAST(annual_drc_value AS DECIMAL(14, 4)) AS annual_drc_value,
    CAST(valuation_date AS TIMESTAMP) AS valuation_date,
    notes,
    activity,
    CAST(added_on AS TIMESTAMP) AS added_on,
    added_by,
    CAST(chgd_on AS TIMESTAMP) AS chgd_on,
    chgd_by
FROM
    staged_dev.stg_api_amds_fndc_test.c_surface
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `c_surface_id` | `int` | Yes |  |
| `road_name` | `string` | Yes |  |
| `start_m` | `int` | Yes |  |
| `end_m` | `int` | Yes |  |
| `length_m` | `int` | Yes |  |
| `start_name` | `string` | Yes |  |
| `end_name` | `string` | Yes |  |
| `northing` | `decimal(14,4)` | Yes |  |
| `easting` | `decimal(14,4)` | Yes |  |
| `northing_end` | `decimal(14,4)` | Yes |  |
| `easting_end` | `decimal(14,4)` | Yes |  |
| `gps_date` | `timestamp` | Yes |  |
| `gps_by` | `string` | Yes |  |
| `gps_method_id` | `string` | Yes |  |
| `surface_date` | `timestamp` | Yes |  |
| `removed_date` | `timestamp` | Yes |  |
| `age` | `int` | Yes |  |
| `surf_width` | `decimal(5,2)` | Yes |  |
| `full_width_flag` | `string` | Yes |  |
| `surf_offset` | `decimal(5,2)` | Yes |  |
| `design_life` | `int` | Yes |  |
| `design_expiry` | `int` | Yes |  |
| `default_life` | `int` | Yes |  |
| `default_expiry` | `int` | Yes |  |
| `mod_default_life` | `int` | Yes |  |
| `mod_default_expiry` | `int` | Yes |  |
| `surf_material` | `string` | Yes |  |
| `surf_function` | `string` | Yes |  |
| `surf_depth` | `int` | Yes |  |
| `use_calc_depth` | `string` | Yes |  |
| `chip_size` | `int` | Yes |  |
| `chip_2nd_size` | `int` | Yes |  |
| `pave_source` | `string` | Yes |  |
| `surf_binder` | `string` | Yes |  |
| `flux` | `int` | Yes |  |
| `cutter` | `int` | Yes |  |
| `cutter_type` | `string` | Yes |  |
| `adhesion` | `decimal(5,2)` | Yes |  |
| `surf_adhesion` | `string` | Yes |  |
| `additive` | `decimal(5,2)` | Yes |  |
| `surf_additive` | `string` | Yes |  |
| `polymer_type` | `string` | Yes |  |
| `polymer_mod_pcnt` | `int` | Yes |  |
| `elastic_recovery` | `int` | Yes |  |
| `softening_point` | `int` | Yes |  |
| `rate` | `decimal(5,2)` | Yes |  |
| `sealed_area` | `int` | Yes |  |
| `sealed_area_ok` | `string` | Yes |  |
| `lane_coverage` | `string` | Yes |  |
| `contract_number` | `string` | Yes |  |
| `organisation` | `string` | Yes |  |
| `surf_spec` | `string` | Yes |  |
| `polished_stone` | `int` | Yes |  |
| `average_dim` | `decimal(5,2)` | Yes |  |
| `recycling` | `string` | Yes |  |
| `pct_recycled` | `int` | Yes |  |
| `surf_recycled_cpnt` | `int` | Yes |  |
| `surf_reason` | `string` | Yes |  |
| `fw_treatment` | `string` | Yes |  |
| `work_origin_id` | `string` | Yes |  |
| `ru_life` | `int` | Yes |  |
| `rul_reset` | `string` | Yes |  |
| `condition_wt` | `string` | Yes |  |
| `condition` | `string` | Yes |  |
| `condition_date` | `timestamp` | Yes |  |
| `asset_owner` | `string` | Yes |  |
| `standard_rc` | `string` | Yes |  |
| `use_default_rc` | `string` | Yes |  |
| `original_cost` | `decimal(10,2)` | Yes |  |
| `rc_value` | `decimal(14,4)` | Yes |  |
| `drc_value` | `decimal(14,4)` | Yes |  |
| `annual_drc_value` | `decimal(14,4)` | Yes |  |
| `valuation_date` | `timestamp` | Yes |  |
| `notes` | `string` | Yes |  |
| `activity` | `string` | Yes |  |
| `added_on` | `timestamp` | Yes |  |
| `added_by` | `string` | Yes |  |
| `chgd_on` | `timestamp` | Yes |  |
| `chgd_by` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_fndc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
