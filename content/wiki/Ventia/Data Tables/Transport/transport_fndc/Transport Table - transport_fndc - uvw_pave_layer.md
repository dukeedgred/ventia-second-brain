---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_fndc
table-name: uvw_pave_layer
full-name: transport_dev.transport_fndc.uvw_pave_layer
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-fndc]
---

# Transport Table - transport_fndc - uvw_pave_layer

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_pave_layer` |
| Full name | `transport_dev.transport_fndc.uvw_pave_layer` |
| Catalog | `transport_dev` |
| Schema | `transport_fndc` |
| Contract/schema | `transport_fndc` |
| Table type | VIEW |
| Column count | 53 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2026-06-03T02:12:40.701Z; Last altered: 2026-06-03T02:12:40.701Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
SELECT
    CAST(layer_id AS INT) AS layer_id,
    road_id AS road_name,
    CAST(start_m AS INT) AS start_m,
    CAST(end_m AS INT) AS end_m,
    CAST(length_m AS INT) AS length_m,
    start_name,
    end_name,
    layer_subgrade,
    CAST(layer_date AS TIMESTAMP) AS layer_date,
    CAST(removed_date AS TIMESTAMP) AS removed_date,
    CAST(age AS INT) AS age,
    CAST(offset AS DECIMAL(10, 2)) AS offset,
    CAST(width AS DECIMAL(10, 2)) AS width,
    CAST(area AS DECIMAL(10, 2)) AS area,
    full_width_flag,
    lane_coverage,
    estimate_status,
    CAST(layer_strength AS DECIMAL(10, 2)) AS layer_strength,
    cbr_ucs,
    pave_subgrade,
    CAST(thickness AS INT) AS thickness,
    CAST(volume AS DECIMAL(10, 2)) AS volume,
    pave_material,
    pave_source,
    recycling,
    pct_recycled,
    surf_recycled_cpnt,
    pave_spec,
    reconstructed,
    work_origin_id,
    plan_no,
    CAST(design_life AS INT) AS design_life,
    CAST(expiry_year AS INT) AS expiry_year,
    CAST(design_esa AS INT) AS design_esa,
    fw_treatment,
    CAST(ru_life AS INT) AS ru_life,
    rul_reset,
    condition_wt,
    condition,
    CAST(condition_date AS TIMESTAMP) AS condition_date,
    asset_owner,
    standard_rc,
    use_default_rc,
    CAST(original_cost AS DECIMAL(10, 2)) AS original_cost,
    CAST(rc_value AS DECIMAL(10, 4)) AS rc_value,
    CAST(drc_value AS DECIMAL(10, 4)) AS drc_value,
    CAST(annual_drc_value AS DECIMAL(10, 4)) AS annual_drc_value,
    CAST(valuation_date AS TIMESTAMP) AS valuation_date,
    notes,
    CAST(added_on AS TIMESTAMP) AS added_on,
    added_by,
    CAST(chgd_on AS TIMESTAMP) AS chgd_on,
    chgd_by
FROM
    staged_dev.stg_api_amds_fndc_test.pave_layer
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `layer_id` | `int` | Yes |  |
| `road_name` | `string` | Yes |  |
| `start_m` | `int` | Yes |  |
| `end_m` | `int` | Yes |  |
| `length_m` | `int` | Yes |  |
| `start_name` | `string` | Yes |  |
| `end_name` | `string` | Yes |  |
| `layer_subgrade` | `string` | Yes |  |
| `layer_date` | `timestamp` | Yes |  |
| `removed_date` | `timestamp` | Yes |  |
| `age` | `int` | Yes |  |
| `offset` | `decimal(10,2)` | Yes |  |
| `width` | `decimal(10,2)` | Yes |  |
| `area` | `decimal(10,2)` | Yes |  |
| `full_width_flag` | `string` | Yes |  |
| `lane_coverage` | `string` | Yes |  |
| `estimate_status` | `string` | Yes |  |
| `layer_strength` | `decimal(10,2)` | Yes |  |
| `cbr_ucs` | `string` | Yes |  |
| `pave_subgrade` | `string` | Yes |  |
| `thickness` | `int` | Yes |  |
| `volume` | `decimal(10,2)` | Yes |  |
| `pave_material` | `string` | Yes |  |
| `pave_source` | `string` | Yes |  |
| `recycling` | `string` | Yes |  |
| `pct_recycled` | `string` | Yes |  |
| `surf_recycled_cpnt` | `string` | Yes |  |
| `pave_spec` | `string` | Yes |  |
| `reconstructed` | `string` | Yes |  |
| `work_origin_id` | `string` | Yes |  |
| `plan_no` | `string` | Yes |  |
| `design_life` | `int` | Yes |  |
| `expiry_year` | `int` | Yes |  |
| `design_esa` | `int` | Yes |  |
| `fw_treatment` | `string` | Yes |  |
| `ru_life` | `int` | Yes |  |
| `rul_reset` | `string` | Yes |  |
| `condition_wt` | `string` | Yes |  |
| `condition` | `string` | Yes |  |
| `condition_date` | `timestamp` | Yes |  |
| `asset_owner` | `string` | Yes |  |
| `standard_rc` | `string` | Yes |  |
| `use_default_rc` | `string` | Yes |  |
| `original_cost` | `decimal(10,2)` | Yes |  |
| `rc_value` | `decimal(10,4)` | Yes |  |
| `drc_value` | `decimal(10,4)` | Yes |  |
| `annual_drc_value` | `decimal(10,4)` | Yes |  |
| `valuation_date` | `timestamp` | Yes |  |
| `notes` | `string` | Yes |  |
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
