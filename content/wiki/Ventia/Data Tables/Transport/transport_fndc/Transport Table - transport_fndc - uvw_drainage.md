---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_fndc
table-name: uvw_drainage
full-name: transport_dev.transport_fndc.uvw_drainage
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-fndc]
---

# Transport Table - transport_fndc - uvw_drainage

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_drainage` |
| Full name | `transport_dev.transport_fndc.uvw_drainage` |
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
| Refresh/freshness | Created: 2026-06-03T02:16:15.913Z; Last altered: 2026-06-03T02:16:15.913Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
SELECT
    road_id AS road_name,
    carrway_start_m,
    CAST(drainage_id AS INT) AS drainage_id,
    drain_type,
    CAST(construct_date AS TIMESTAMP) AS construct_date,
    CAST(age AS INT) AS age,
    CAST(location AS INT) AS location,
    CAST(offset_kerb AS DECIMAL(5, 2)) AS offset_kerb,
    CAST(offset AS DECIMAL(5, 2)) AS offset,
    CAST(offset_lhs AS DECIMAL(5, 2)) AS offset_lhs,
    offset_side,
    CAST(drain_length AS DECIMAL(5, 2)) AS drain_length,
    CAST(drain_size AS INT) AS drain_size,
    CAST(wall_thickness AS INT) AS wall_thickness,
    drain_material,
    inlet,
    outlet,
    CAST(culv_number AS DECIMAL(5, 2)) AS culv_number,
    drain_culvert,
    CAST(cul_width AS INT) AS cul_width,
    CAST(cul_area AS DECIMAL(5, 2)) AS cul_area,
    CAST(depth_of_cover AS DECIMAL(5, 2)) AS depth_of_cover,
    drain_lining,
    CAST(lining_date AS TIMESTAMP) AS lining_date,
    flow_direction,
    bridge_id,
    CAST(inspect_date AS TIMESTAMP) AS inspect_date,
    hazard,
    adequacy,
    maint_type,
    organisation,
    file_ref,
    CAST(maint_date AS TIMESTAMP) AS maint_date,
    maint_cycle,
    wway,
    fish_passage,
    asset_owner,
    drain_shape,
    CAST(northing AS DECIMAL(14, 4)) AS northing,
    CAST(easting AS DECIMAL(14, 4)) AS easting,
    CAST(gps_date AS TIMESTAMP) AS gps_date,
    gps_by,
    gps_method_id,
    condition,
    CAST(condition_date AS TIMESTAMP) AS condition_date,
    condition_wt,
    as_tip_note,
    risk,
    CAST(risk_date AS TIMESTAMP) AS risk_date,
    risk_likelihood,
    likelihood_wt,
    risk_consequence,
    consequence_wt,
    CAST(ru_life AS INT) AS ru_life,
    rul_reset,
    standard_rc,
    use_default_rc,
    CAST(original_cost AS DECIMAL(10, 2)) AS original_cost,
    CAST(rc_value AS DECIMAL(14, 4)) AS rc_value,
    CAST(drc_value AS DECIMAL(14, 4)) AS drc_value,
    CAST(annual_drc_value AS DECIMAL(14, 4)) AS annual_drc_value,
    CAST(valuation_date AS TIMESTAMP) AS valuation_date,
    notes,
    collect_name,
    CAST(collect_date AS TIMESTAMP) AS collect_date,
    CAST(added_on AS TIMESTAMP) AS added_on,
    added_by,
    CAST(chgd_on AS TIMESTAMP) AS chgd_on,
    chgd_by,
    work_origin_id AS work_origin,
    work_category,
    prior_id,
    in_contract_id,
    CAST(in_dispatch_id AS INT) AS in_dispatch_id,
    in_replace_reason,
    CAST(replace_date AS TIMESTAMP) AS replace_date,
    rep_contract_id,
    CAST(rep_dispatch_id AS INT) AS rep_dispatch_id,
    rep_replace_reason,
    state_code
FROM
    staged_dev.stg_api_amds_fndc_test.drainage
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `road_name` | `string` | Yes |  |
| `carrway_start_m` | `string` | Yes |  |
| `drainage_id` | `int` | Yes |  |
| `drain_type` | `string` | Yes |  |
| `construct_date` | `timestamp` | Yes |  |
| `age` | `int` | Yes |  |
| `location` | `int` | Yes |  |
| `offset_kerb` | `decimal(5,2)` | Yes |  |
| `offset` | `decimal(5,2)` | Yes |  |
| `offset_lhs` | `decimal(5,2)` | Yes |  |
| `offset_side` | `string` | Yes |  |
| `drain_length` | `decimal(5,2)` | Yes |  |
| `drain_size` | `int` | Yes |  |
| `wall_thickness` | `int` | Yes |  |
| `drain_material` | `string` | Yes |  |
| `inlet` | `string` | Yes |  |
| `outlet` | `string` | Yes |  |
| `culv_number` | `decimal(5,2)` | Yes |  |
| `drain_culvert` | `string` | Yes |  |
| `cul_width` | `int` | Yes |  |
| `cul_area` | `decimal(5,2)` | Yes |  |
| `depth_of_cover` | `decimal(5,2)` | Yes |  |
| `drain_lining` | `string` | Yes |  |
| `lining_date` | `timestamp` | Yes |  |
| `flow_direction` | `string` | Yes |  |
| `bridge_id` | `string` | Yes |  |
| `inspect_date` | `timestamp` | Yes |  |
| `hazard` | `string` | Yes |  |
| `adequacy` | `string` | Yes |  |
| `maint_type` | `string` | Yes |  |
| `organisation` | `string` | Yes |  |
| `file_ref` | `string` | Yes |  |
| `maint_date` | `timestamp` | Yes |  |
| `maint_cycle` | `string` | Yes |  |
| `wway` | `string` | Yes |  |
| `fish_passage` | `string` | Yes |  |
| `asset_owner` | `string` | Yes |  |
| `drain_shape` | `string` | Yes |  |
| `northing` | `decimal(14,4)` | Yes |  |
| `easting` | `decimal(14,4)` | Yes |  |
| `gps_date` | `timestamp` | Yes |  |
| `gps_by` | `string` | Yes |  |
| `gps_method_id` | `string` | Yes |  |
| `condition` | `string` | Yes |  |
| `condition_date` | `timestamp` | Yes |  |
| `condition_wt` | `string` | Yes |  |
| `as_tip_note` | `string` | Yes |  |
| `risk` | `string` | Yes |  |
| `risk_date` | `timestamp` | Yes |  |
| `risk_likelihood` | `string` | Yes |  |
| `likelihood_wt` | `string` | Yes |  |
| `risk_consequence` | `string` | Yes |  |
| `consequence_wt` | `string` | Yes |  |
| `ru_life` | `int` | Yes |  |
| `rul_reset` | `string` | Yes |  |
| `standard_rc` | `string` | Yes |  |
| `use_default_rc` | `string` | Yes |  |
| `original_cost` | `decimal(10,2)` | Yes |  |
| `rc_value` | `decimal(14,4)` | Yes |  |
| `drc_value` | `decimal(14,4)` | Yes |  |
| `annual_drc_value` | `decimal(14,4)` | Yes |  |
| `valuation_date` | `timestamp` | Yes |  |
| `notes` | `string` | Yes |  |
| `collect_name` | `string` | Yes |  |
| `collect_date` | `timestamp` | Yes |  |
| `added_on` | `timestamp` | Yes |  |
| `added_by` | `string` | Yes |  |
| `chgd_on` | `timestamp` | Yes |  |
| `chgd_by` | `string` | Yes |  |
| `work_origin` | `string` | Yes |  |
| `work_category` | `string` | Yes |  |
| `prior_id` | `string` | Yes |  |
| `in_contract_id` | `string` | Yes |  |
| `in_dispatch_id` | `int` | Yes |  |
| `in_replace_reason` | `string` | Yes |  |
| `replace_date` | `timestamp` | Yes |  |
| `rep_contract_id` | `string` | Yes |  |
| `rep_dispatch_id` | `int` | Yes |  |
| `rep_replace_reason` | `string` | Yes |  |
| `state_code` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_fndc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
