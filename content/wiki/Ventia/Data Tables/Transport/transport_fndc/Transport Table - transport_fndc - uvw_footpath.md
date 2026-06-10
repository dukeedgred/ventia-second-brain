---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_fndc
table-name: uvw_footpath
full-name: transport_dev.transport_fndc.uvw_footpath
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-fndc]
---

# Transport Table - transport_fndc - uvw_footpath

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_footpath` |
| Full name | `transport_dev.transport_fndc.uvw_footpath` |
| Catalog | `transport_dev` |
| Schema | `transport_fndc` |
| Contract/schema | `transport_fndc` |
| Table type | VIEW |
| Column count | 74 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2026-06-01T23:07:17.907Z; Last altered: 2026-06-01T23:07:17.907Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
SELECT
    CAST(footpath_id AS INT) AS footpath_id,
    road_id AS road_name,
    CAST(start_m AS INT) AS start_m,
    start_desc,
    CAST(end_m AS INT) AS end_m,
    end_desc,
    side,
    CAST(offset_kerb AS DECIMAL(5, 2)) AS offset_kerb,
    CAST(offset AS DECIMAL(5, 2)) AS offset,
    CAST(offset_lhs AS DECIMAL(5, 2)) AS offset_lhs,
    CAST(offset_kerb_end AS DECIMAL(5, 2)) AS offset_kerb_end,
    CAST(offset_end AS DECIMAL(5, 2)) AS offset_end,
    CAST(offset_lhs_end AS DECIMAL(5, 2)) AS offset_lhs_end,
    footpath_position,
    CAST(northing AS DECIMAL(14, 4)) AS northing,
    CAST(easting AS DECIMAL(14, 4)) AS easting,
    CAST(northing_end AS DECIMAL(14, 4)) AS northing_end,
    CAST(easting_end AS DECIMAL(14, 4)) AS easting_end,
    CAST(gps_date AS TIMESTAMP) AS gps_date,
    gps_by,
    gps_method_id,
    local_name,
    CAST(length_m AS INT) AS length_m,
    CAST(length_adjust_m AS INT) AS length_adjust_m,
    len_adjust_rsn,
    CAST(width AS DECIMAL(5, 2)) AS width,
    CAST(area AS DECIMAL(10, 2)) AS area,
    footpath_surf_mat,
    CAST(overlay_depth AS INT) AS overlay_depth,
    CAST(chip_size AS INT) AS chip_size,
    surf_binder,
    pedestrian_use,
    scooter_use,
    bicycle_use,
    CAST(steps_length AS INT) AS steps_length,
    CAST(extra_area AS DECIMAL(10, 2)) AS extra_area,
    CAST(total_area AS DECIMAL(10, 2)) AS total_area,
    CAST(constructed AS TIMESTAMP) AS constructed,
    CAST(age AS INT) AS age,
    CAST(surface_date AS TIMESTAMP) AS surface_date,
    CAST(ru_life AS INT) AS ru_life,
    rul_reset,
    condition_wt,
    condition,
    CAST(condition_date AS TIMESTAMP) AS condition_date,
    likelihood_wt,
    risk_likelihood,
    consequence_wt,
    risk_consequence,
    risk,
    CAST(risk_date AS TIMESTAMP) AS risk_date,
    other_road_id,
    other_location,
    other_side,
    purpose,
    maintained_by,
    asset_owner,
    standard_rc,
    use_default_rc,
    CAST(original_cost AS DECIMAL(10, 2)) AS original_cost,
    CAST(rc_value AS DECIMAL(14, 4)) AS rc_value,
    CAST(drc_value AS DECIMAL(14, 4)) AS drc_value,
    CAST(annual_drc_value AS DECIMAL(14, 4)) AS annual_drc_value,
    CAST(valuation_date AS TIMESTAMP) AS valuation_date,
    notes,
    as_tip_note,
    CAST(bridge_id AS INT) AS bridge_id,
    collect_name,
    CAST(collect_date AS TIMESTAMP) AS collect_date,
    CAST(added_on AS TIMESTAMP) AS added_on,
    added_by,
    CAST(chgd_on AS TIMESTAMP) AS chgd_on,
    chgd_by,
    CAST(install_date AS TIMESTAMP) AS install_date
FROM
    staged_dev.stg_api_amds_fndc_test.footpath
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `footpath_id` | `int` | Yes |  |
| `road_name` | `string` | Yes |  |
| `start_m` | `int` | Yes |  |
| `start_desc` | `string` | Yes |  |
| `end_m` | `int` | Yes |  |
| `end_desc` | `string` | Yes |  |
| `side` | `string` | Yes |  |
| `offset_kerb` | `decimal(5,2)` | Yes |  |
| `offset` | `decimal(5,2)` | Yes |  |
| `offset_lhs` | `decimal(5,2)` | Yes |  |
| `offset_kerb_end` | `decimal(5,2)` | Yes |  |
| `offset_end` | `decimal(5,2)` | Yes |  |
| `offset_lhs_end` | `decimal(5,2)` | Yes |  |
| `footpath_position` | `string` | Yes |  |
| `northing` | `decimal(14,4)` | Yes |  |
| `easting` | `decimal(14,4)` | Yes |  |
| `northing_end` | `decimal(14,4)` | Yes |  |
| `easting_end` | `decimal(14,4)` | Yes |  |
| `gps_date` | `timestamp` | Yes |  |
| `gps_by` | `string` | Yes |  |
| `gps_method_id` | `string` | Yes |  |
| `local_name` | `string` | Yes |  |
| `length_m` | `int` | Yes |  |
| `length_adjust_m` | `int` | Yes |  |
| `len_adjust_rsn` | `string` | Yes |  |
| `width` | `decimal(5,2)` | Yes |  |
| `area` | `decimal(10,2)` | Yes |  |
| `footpath_surf_mat` | `string` | Yes |  |
| `overlay_depth` | `int` | Yes |  |
| `chip_size` | `int` | Yes |  |
| `surf_binder` | `string` | Yes |  |
| `pedestrian_use` | `string` | Yes |  |
| `scooter_use` | `string` | Yes |  |
| `bicycle_use` | `string` | Yes |  |
| `steps_length` | `int` | Yes |  |
| `extra_area` | `decimal(10,2)` | Yes |  |
| `total_area` | `decimal(10,2)` | Yes |  |
| `constructed` | `timestamp` | Yes |  |
| `age` | `int` | Yes |  |
| `surface_date` | `timestamp` | Yes |  |
| `ru_life` | `int` | Yes |  |
| `rul_reset` | `string` | Yes |  |
| `condition_wt` | `string` | Yes |  |
| `condition` | `string` | Yes |  |
| `condition_date` | `timestamp` | Yes |  |
| `likelihood_wt` | `string` | Yes |  |
| `risk_likelihood` | `string` | Yes |  |
| `consequence_wt` | `string` | Yes |  |
| `risk_consequence` | `string` | Yes |  |
| `risk` | `string` | Yes |  |
| `risk_date` | `timestamp` | Yes |  |
| `other_road_id` | `string` | Yes |  |
| `other_location` | `string` | Yes |  |
| `other_side` | `string` | Yes |  |
| `purpose` | `string` | Yes |  |
| `maintained_by` | `string` | Yes |  |
| `asset_owner` | `string` | Yes |  |
| `standard_rc` | `string` | Yes |  |
| `use_default_rc` | `string` | Yes |  |
| `original_cost` | `decimal(10,2)` | Yes |  |
| `rc_value` | `decimal(14,4)` | Yes |  |
| `drc_value` | `decimal(14,4)` | Yes |  |
| `annual_drc_value` | `decimal(14,4)` | Yes |  |
| `valuation_date` | `timestamp` | Yes |  |
| `notes` | `string` | Yes |  |
| `as_tip_note` | `string` | Yes |  |
| `bridge_id` | `int` | Yes |  |
| `collect_name` | `string` | Yes |  |
| `collect_date` | `timestamp` | Yes |  |
| `added_on` | `timestamp` | Yes |  |
| `added_by` | `string` | Yes |  |
| `chgd_on` | `timestamp` | Yes |  |
| `chgd_by` | `string` | Yes |  |
| `install_date` | `timestamp` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_fndc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
