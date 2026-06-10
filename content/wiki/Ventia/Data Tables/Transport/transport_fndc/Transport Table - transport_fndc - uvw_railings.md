---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_fndc
table-name: uvw_railings
full-name: transport_dev.transport_fndc.uvw_railings
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-fndc]
---

# Transport Table - transport_fndc - uvw_railings

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_railings` |
| Full name | `transport_dev.transport_fndc.uvw_railings` |
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
| Refresh/freshness | Created: 2026-06-01T23:06:13.073Z; Last altered: 2026-06-01T23:06:13.073Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
SELECT
    road_id AS road_name,
    CAST(start_m AS INT) AS start_m,
    CAST(end_m AS INT) AS end_m,
    start_name,
    end_name,
    CAST(railing_id AS INT) AS railing_id,
    CAST(length_m AS INT) AS length_m,
    CAST(length_adjust_m AS INT) AS length_adjust_m,
    CAST(len_adjust_rsn AS INT) AS len_adjust_rsn,
    CAST(northing AS DECIMAL(14, 4)) AS northing,
    CAST(easting AS DECIMAL(14, 4)) AS easting,
    CAST(northing_end AS DECIMAL(14, 4)) AS northing_end,
    CAST(easting_end AS DECIMAL(14, 4)) AS easting_end,
    CAST(gps_date AS TIMESTAMP) AS gps_date,
    gps_by,
    gps_method_id,
    CAST(offset_kerb AS DECIMAL(10, 2)) AS offset_kerb,
    CAST(offset AS DECIMAL(10, 2)) AS offset,
    CAST(offset_lhs AS DECIMAL(10, 2)) AS offset_lhs,
    CAST(offset_kerb_end AS DECIMAL(10, 2)) AS offset_kerb_end,
    CAST(offset_end AS DECIMAL(10, 2)) AS offset_end,
    CAST(offset_lhs_end AS DECIMAL(10, 2)) AS offset_lhs_end,
    side,
    railing_type,
    CAST(install_date AS TIMESTAMP) AS install_date,
    CAST(age AS INT) AS age,
    CAST(ground_height AS DECIMAL(10, 2)) AS ground_height,
    CAST(railing_width AS DECIMAL(10, 2)) AS railing_width,
    railing_make,
    shape,
    railing_colour,
    railing_material,
    railing_attach,
    rail_start_style,
    rail_end_style,
    safe_height,
    railing_ground_fix,
    railing_purpose,
    loc_house1_no,
    loc_house2_no,
    other_road_id AS other_road_name,
    other_side,
    CAST(other_start_m AS INT) AS other_start_m,
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
    risk_date,
    asset_owner,
    CAST(post_count AS INT) AS post_count,
    post_material,
    post_condition,
    CAST(bridge_id AS INT) AS bridge_id,
    CAST(retaining_wall_id AS INT) AS retaining_wall_id,
    paint_system,
    standard_rc,
    use_default_rc,
    CAST(original_cost AS DECIMAL(10, 2)) AS original_cost,
    CAST(rc_value AS DECIMAL(14, 4)) AS rc_value,
    CAST(drc_value AS DECIMAL(14, 4)) AS drc_value,
    CAST(annual_drc_value AS DECIMAL(14, 4)) AS annual_drc_value,
    CAST(valuation_date AS TIMESTAMP) AS valuation_date,
    notes,
    post_notes,
    as_tip_note,
    collect_name,
    CAST(collect_date AS TIMESTAMP) AS collect_date,
    work_origin_id,
    work_category,
    CAST(added_on AS TIMESTAMP) AS added_on,
    added_by,
    CAST(chgd_on AS TIMESTAMP) AS chgd_on,
    chgd_by
FROM
    staged_dev.stg_api_amds_fndc_test.railings
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `road_name` | `string` | Yes |  |
| `start_m` | `int` | Yes |  |
| `end_m` | `int` | Yes |  |
| `start_name` | `string` | Yes |  |
| `end_name` | `string` | Yes |  |
| `railing_id` | `int` | Yes |  |
| `length_m` | `int` | Yes |  |
| `length_adjust_m` | `int` | Yes |  |
| `len_adjust_rsn` | `int` | Yes |  |
| `northing` | `decimal(14,4)` | Yes |  |
| `easting` | `decimal(14,4)` | Yes |  |
| `northing_end` | `decimal(14,4)` | Yes |  |
| `easting_end` | `decimal(14,4)` | Yes |  |
| `gps_date` | `timestamp` | Yes |  |
| `gps_by` | `string` | Yes |  |
| `gps_method_id` | `string` | Yes |  |
| `offset_kerb` | `decimal(10,2)` | Yes |  |
| `offset` | `decimal(10,2)` | Yes |  |
| `offset_lhs` | `decimal(10,2)` | Yes |  |
| `offset_kerb_end` | `decimal(10,2)` | Yes |  |
| `offset_end` | `decimal(10,2)` | Yes |  |
| `offset_lhs_end` | `decimal(10,2)` | Yes |  |
| `side` | `string` | Yes |  |
| `railing_type` | `string` | Yes |  |
| `install_date` | `timestamp` | Yes |  |
| `age` | `int` | Yes |  |
| `ground_height` | `decimal(10,2)` | Yes |  |
| `railing_width` | `decimal(10,2)` | Yes |  |
| `railing_make` | `string` | Yes |  |
| `shape` | `string` | Yes |  |
| `railing_colour` | `string` | Yes |  |
| `railing_material` | `string` | Yes |  |
| `railing_attach` | `string` | Yes |  |
| `rail_start_style` | `string` | Yes |  |
| `rail_end_style` | `string` | Yes |  |
| `safe_height` | `string` | Yes |  |
| `railing_ground_fix` | `string` | Yes |  |
| `railing_purpose` | `string` | Yes |  |
| `loc_house1_no` | `string` | Yes |  |
| `loc_house2_no` | `string` | Yes |  |
| `other_road_name` | `string` | Yes |  |
| `other_side` | `string` | Yes |  |
| `other_start_m` | `int` | Yes |  |
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
| `risk_date` | `string` | Yes |  |
| `asset_owner` | `string` | Yes |  |
| `post_count` | `int` | Yes |  |
| `post_material` | `string` | Yes |  |
| `post_condition` | `string` | Yes |  |
| `bridge_id` | `int` | Yes |  |
| `retaining_wall_id` | `int` | Yes |  |
| `paint_system` | `string` | Yes |  |
| `standard_rc` | `string` | Yes |  |
| `use_default_rc` | `string` | Yes |  |
| `original_cost` | `decimal(10,2)` | Yes |  |
| `rc_value` | `decimal(14,4)` | Yes |  |
| `drc_value` | `decimal(14,4)` | Yes |  |
| `annual_drc_value` | `decimal(14,4)` | Yes |  |
| `valuation_date` | `timestamp` | Yes |  |
| `notes` | `string` | Yes |  |
| `post_notes` | `string` | Yes |  |
| `as_tip_note` | `string` | Yes |  |
| `collect_name` | `string` | Yes |  |
| `collect_date` | `timestamp` | Yes |  |
| `work_origin_id` | `string` | Yes |  |
| `work_category` | `string` | Yes |  |
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
