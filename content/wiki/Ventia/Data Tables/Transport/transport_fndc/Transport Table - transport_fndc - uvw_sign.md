---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_fndc
table-name: uvw_sign
full-name: transport_dev.transport_fndc.uvw_sign
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-fndc]
---

# Transport Table - transport_fndc - uvw_sign

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_sign` |
| Full name | `transport_dev.transport_fndc.uvw_sign` |
| Catalog | `transport_dev` |
| Schema | `transport_fndc` |
| Contract/schema | `transport_fndc` |
| Table type | VIEW |
| Column count | 80 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2026-06-01T23:06:26.874Z; Last altered: 2026-06-01T23:06:26.874Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
SELECT
    road_id AS road_name,
    carrway_start_m,
    CAST(sign_id AS INT) AS sign_id,
    CAST(post_count AS INT) AS post_count,
    sign_group,
    sign_class,
    sign_type,
    CAST(location AS INT) AS location,
    side,
    CAST(offset_kerb AS DECIMAL(10, 2)) AS offset_kerb,
    CAST(offset AS DECIMAL(10, 2)) AS offset,
    CAST(offset_lhs AS DECIMAL(10, 2)) AS offset_lhs,
    sign_angle,
    CAST(quantity AS INT) AS quantity,
    indicating_dir,
    sign_owner,
    legend_note,
    legend2_note,
    legend_material,
    legend_colour,
    bground_material,
    bground_colour,
    sign_substrate,
    CAST(sign_width AS INT) AS sign_width,
    CAST(sign_height AS INT) AS sign_height,
    CAST(ground_height AS INT) AS ground_height,
    frame,
    CAST(install_date AS TIMESTAMP) AS install_date,
    in_contract_id,
    CAST(in_dispatch_id AS INT) AS in_dispatch_id,
    in_replace_reason,
    CAST(age AS INT) AS age,
    CAST(replace_date AS TIMESTAMP) AS replace_date,
    rep_contract_id,
    CAST(rep_dispatch_id AS INT) AS rep_dispatch_id,
    rep_replace_reason,
    other_road_id,
    other_cway_start_m,
    other_side,
    other_location,
    loc_house_no,
    loc_feature,
    CAST(loc_house1 AS INT) AS loc_house1,
    photo_ref,
    sign_number,
    batch_number,
    CAST(northing AS DECIMAL(14, 4)) AS northing,
    CAST(easting AS DECIMAL(14, 4)) AS easting,
    CAST(gps_date AS TIMESTAMP) AS gps_date,
    gps_by,
    gps_method_id,
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
    prior_id,
    standard_rc,
    use_default_rc,
    CAST(original_cost AS DECIMAL(10, 2)) AS original_cost,
    CAST(rc_value AS DECIMAL(14, 4)) AS rc_value,
    CAST(drc_value AS DECIMAL(14, 4)) AS drc_value,
    CAST(annual_drc_value AS DECIMAL(14, 4)) AS annual_drc_value,
    CAST(valuation_date AS TIMESTAMP) AS valuation_date,
    general_note,
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
    staged_dev.stg_api_amds_fndc_test.sign
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `road_name` | `string` | Yes |  |
| `carrway_start_m` | `string` | Yes |  |
| `sign_id` | `int` | Yes |  |
| `post_count` | `int` | Yes |  |
| `sign_group` | `string` | Yes |  |
| `sign_class` | `string` | Yes |  |
| `sign_type` | `string` | Yes |  |
| `location` | `int` | Yes |  |
| `side` | `string` | Yes |  |
| `offset_kerb` | `decimal(10,2)` | Yes |  |
| `offset` | `decimal(10,2)` | Yes |  |
| `offset_lhs` | `decimal(10,2)` | Yes |  |
| `sign_angle` | `string` | Yes |  |
| `quantity` | `int` | Yes |  |
| `indicating_dir` | `string` | Yes |  |
| `sign_owner` | `string` | Yes |  |
| `legend_note` | `string` | Yes |  |
| `legend2_note` | `string` | Yes |  |
| `legend_material` | `string` | Yes |  |
| `legend_colour` | `string` | Yes |  |
| `bground_material` | `string` | Yes |  |
| `bground_colour` | `string` | Yes |  |
| `sign_substrate` | `string` | Yes |  |
| `sign_width` | `int` | Yes |  |
| `sign_height` | `int` | Yes |  |
| `ground_height` | `int` | Yes |  |
| `frame` | `string` | Yes |  |
| `install_date` | `timestamp` | Yes |  |
| `in_contract_id` | `string` | Yes |  |
| `in_dispatch_id` | `int` | Yes |  |
| `in_replace_reason` | `string` | Yes |  |
| `age` | `int` | Yes |  |
| `replace_date` | `timestamp` | Yes |  |
| `rep_contract_id` | `string` | Yes |  |
| `rep_dispatch_id` | `int` | Yes |  |
| `rep_replace_reason` | `string` | Yes |  |
| `other_road_id` | `string` | Yes |  |
| `other_cway_start_m` | `string` | Yes |  |
| `other_side` | `string` | Yes |  |
| `other_location` | `string` | Yes |  |
| `loc_house_no` | `string` | Yes |  |
| `loc_feature` | `string` | Yes |  |
| `loc_house1` | `int` | Yes |  |
| `photo_ref` | `string` | Yes |  |
| `sign_number` | `string` | Yes |  |
| `batch_number` | `string` | Yes |  |
| `northing` | `decimal(14,4)` | Yes |  |
| `easting` | `decimal(14,4)` | Yes |  |
| `gps_date` | `timestamp` | Yes |  |
| `gps_by` | `string` | Yes |  |
| `gps_method_id` | `string` | Yes |  |
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
| `prior_id` | `string` | Yes |  |
| `standard_rc` | `string` | Yes |  |
| `use_default_rc` | `string` | Yes |  |
| `original_cost` | `decimal(10,2)` | Yes |  |
| `rc_value` | `decimal(14,4)` | Yes |  |
| `drc_value` | `decimal(14,4)` | Yes |  |
| `annual_drc_value` | `decimal(14,4)` | Yes |  |
| `valuation_date` | `timestamp` | Yes |  |
| `general_note` | `string` | Yes |  |
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
