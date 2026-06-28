---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_fndc
table-name: uvw_mt_dispatch_claim
full-name: transport_dev.transport_fndc.uvw_mt_dispatch_claim
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-fndc]
---

# Transport Table - transport_fndc - uvw_mt_dispatch_claim

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_mt_dispatch_claim` |
| Full name | `transport_dev.transport_fndc.uvw_mt_dispatch_claim` |
| Catalog | `transport_dev` |
| Schema | `transport_fndc` |
| Contract/schema | `transport_fndc` |
| Table type | VIEW |
| Column count | 58 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2026-06-03T02:11:37.978Z; Last altered: 2026-06-03T02:11:37.978Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
SELECT
    CAST(dispatch_claim_id AS INT) AS dispatch_claim_id,
    contract_id AS contract_name,
    CAST(dispatch_id AS INT) AS dispatch_id,
    item_no,
    CAST(claim_no AS INT) AS claim_no,
    units,
    CAST(cost_rate AS DECIMAL(10, 2)) AS cost_rate,
    CAST(on_cost_pct AS DECIMAL(5, 2)) AS on_cost_pct,
    est_status,
    CAST(est_quantity AS DECIMAL(10, 2)) AS est_quantity,
    est_quantity_dispatch,
    CAST(est_rate AS DECIMAL(10, 2)) AS est_rate,
    CAST(est_amount AS INT) AS est_amount,
    CAST(est_cost_amount AS INT) AS est_cost_amount,
    CAST(est_cost_difference AS INT) AS est_cost_difference,
    est_fixed_price,
    est_maintained_by,
    CAST(est_maintained_date AS TIMESTAMP) AS est_maintained_date,
    est_presented_by,
    CAST(est_presented_date AS TIMESTAMP) AS est_presented_date,
    est_accepted_by,
    CAST(est_accepted_date AS TIMESTAMP) AS est_accepted_date,
    est_held_by,
    CAST(est_held_date AS TIMESTAMP) AS est_held_date,
    claim_status,
    CAST(claim_quantity AS DECIMAL(10, 2)) AS claim_quantity,
    claim_quantity_dispatch,
    CAST(claim_rate AS DECIMAL(10, 2)) AS claim_rate,
    CAST(claim_amount AS DECIMAL(10, 2)) AS claim_amount,
    CAST(claim_cost_amount AS DECIMAL(10, 2)) AS claim_cost_amount,
    CAST(claim_cost_difference AS DECIMAL(10,2)) as claim_cost_difference,
    claim_maintained_by,
    CAST(claim_maintained_date AS TIMESTAMP) AS claim_maintained_date,
    claim_presented_by,
    CAST(claim_presented_date AS TIMESTAMP) AS claim_presented_date,
    claim_accepted_by,
    CAST(claim_accepted_date AS TIMESTAMP) AS claim_accepted_date,
    claim_held_by,
    CAST(claim_held_date AS TIMESTAMP) AS claim_held_date,
    work_completed_by,
    CAST(work_completed_date AS TIMESTAMP) AS work_completed_date,
    asset_type,
    claim_owner,
    claim_group_1,
    claim_group_2,
    account_1,
    account_2,
    account_3,
    mc_cost_group,
    mc_activity,
    mc_fault,
    mc_failure,
    notes,
    add_claim_method,
    CAST(added_on AS TIMESTAMP) AS added_on,
    added_by,
    CAST(chgd_on AS TIMESTAMP) AS chgd_on,
    chgd_by
FROM
    staged_dev.stg_api_amds_fndc_test.mt_dispatch_claim
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `dispatch_claim_id` | `int` | Yes |  |
| `contract_name` | `string` | Yes |  |
| `dispatch_id` | `int` | Yes |  |
| `item_no` | `string` | Yes |  |
| `claim_no` | `int` | Yes |  |
| `units` | `string` | Yes |  |
| `cost_rate` | `decimal(10,2)` | Yes |  |
| `on_cost_pct` | `decimal(5,2)` | Yes |  |
| `est_status` | `string` | Yes |  |
| `est_quantity` | `decimal(10,2)` | Yes |  |
| `est_quantity_dispatch` | `string` | Yes |  |
| `est_rate` | `decimal(10,2)` | Yes |  |
| `est_amount` | `int` | Yes |  |
| `est_cost_amount` | `int` | Yes |  |
| `est_cost_difference` | `int` | Yes |  |
| `est_fixed_price` | `string` | Yes |  |
| `est_maintained_by` | `string` | Yes |  |
| `est_maintained_date` | `timestamp` | Yes |  |
| `est_presented_by` | `string` | Yes |  |
| `est_presented_date` | `timestamp` | Yes |  |
| `est_accepted_by` | `string` | Yes |  |
| `est_accepted_date` | `timestamp` | Yes |  |
| `est_held_by` | `string` | Yes |  |
| `est_held_date` | `timestamp` | Yes |  |
| `claim_status` | `string` | Yes |  |
| `claim_quantity` | `decimal(10,2)` | Yes |  |
| `claim_quantity_dispatch` | `string` | Yes |  |
| `claim_rate` | `decimal(10,2)` | Yes |  |
| `claim_amount` | `decimal(10,2)` | Yes |  |
| `claim_cost_amount` | `decimal(10,2)` | Yes |  |
| `claim_cost_difference` | `decimal(10,2)` | Yes |  |
| `claim_maintained_by` | `string` | Yes |  |
| `claim_maintained_date` | `timestamp` | Yes |  |
| `claim_presented_by` | `string` | Yes |  |
| `claim_presented_date` | `timestamp` | Yes |  |
| `claim_accepted_by` | `string` | Yes |  |
| `claim_accepted_date` | `timestamp` | Yes |  |
| `claim_held_by` | `string` | Yes |  |
| `claim_held_date` | `timestamp` | Yes |  |
| `work_completed_by` | `string` | Yes |  |
| `work_completed_date` | `timestamp` | Yes |  |
| `asset_type` | `string` | Yes |  |
| `claim_owner` | `string` | Yes |  |
| `claim_group_1` | `string` | Yes |  |
| `claim_group_2` | `string` | Yes |  |
| `account_1` | `string` | Yes |  |
| `account_2` | `string` | Yes |  |
| `account_3` | `string` | Yes |  |
| `mc_cost_group` | `string` | Yes |  |
| `mc_activity` | `string` | Yes |  |
| `mc_fault` | `string` | Yes |  |
| `mc_failure` | `string` | Yes |  |
| `notes` | `string` | Yes |  |
| `add_claim_method` | `string` | Yes |  |
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
