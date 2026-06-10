---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_fndc
table-name: uvw_mc_cost
full-name: transport_dev.transport_fndc.uvw_mc_cost
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-fndc]
---

# Transport Table - transport_fndc - uvw_mc_cost

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_mc_cost` |
| Full name | `transport_dev.transport_fndc.uvw_mc_cost` |
| Catalog | `transport_dev` |
| Schema | `transport_fndc` |
| Contract/schema | `transport_fndc` |
| Table type | VIEW |
| Column count | 30 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | commercial / finance |
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2026-06-01T23:07:53.975Z; Last altered: 2026-06-01T23:07:53.975Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
SELECT
    CAST(transaction_id AS INT) AS transaction_id,
    batch_id AS batch_name,
    CAST(transaction_date AS TIMESTAMP) AS transaction_date,
    financial_year,
    cost_group,
    activity,
    fault,
    CAST(cost_amount AS DECIMAL(10, 2)) AS cost_amount,
    CAST(cost_amount_rci AS DECIMAL(10, 4)) AS cost_amount_rci,
    CAST(quantity AS DECIMAL(10, 2)) AS quantity,
    CAST(adj_quantity AS DECIMAL(10, 2)) AS adj_quantity,
    qty_unit,
    failure,
    asset_id,
    northing,
    easting,
    gps_by,
    gps_method_id,
    road_id AS road_name,
    CAST(start_m AS INT) AS start_m,
    CAST(end_m AS INT) AS end_m,
    CAST(length_m AS INT) AS length_m,
    work_position,
    analysis_code,
    external_id,
    CAST(added_on AS TIMESTAMP) AS added_on,
    added_by,
    CAST(chgd_on AS TIMESTAMP) AS chgd_on,
    chgd_by,
    CAST(dispatch_id AS INT) AS dispatch_id
FROM
    staged_dev.stg_api_amds_fndc_test.mc_cost
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `transaction_id` | `int` | Yes |  |
| `batch_name` | `string` | Yes |  |
| `transaction_date` | `timestamp` | Yes |  |
| `financial_year` | `string` | Yes |  |
| `cost_group` | `string` | Yes |  |
| `activity` | `string` | Yes |  |
| `fault` | `string` | Yes |  |
| `cost_amount` | `decimal(10,2)` | Yes |  |
| `cost_amount_rci` | `decimal(10,4)` | Yes |  |
| `quantity` | `decimal(10,2)` | Yes |  |
| `adj_quantity` | `decimal(10,2)` | Yes |  |
| `qty_unit` | `string` | Yes |  |
| `failure` | `string` | Yes |  |
| `asset_id` | `string` | Yes |  |
| `northing` | `string` | Yes |  |
| `easting` | `string` | Yes |  |
| `gps_by` | `string` | Yes |  |
| `gps_method_id` | `string` | Yes |  |
| `road_name` | `string` | Yes |  |
| `start_m` | `int` | Yes |  |
| `end_m` | `int` | Yes |  |
| `length_m` | `int` | Yes |  |
| `work_position` | `string` | Yes |  |
| `analysis_code` | `string` | Yes |  |
| `external_id` | `string` | Yes |  |
| `added_on` | `timestamp` | Yes |  |
| `added_by` | `string` | Yes |  |
| `chgd_on` | `timestamp` | Yes |  |
| `chgd_by` | `string` | Yes |  |
| `dispatch_id` | `int` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_fndc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
