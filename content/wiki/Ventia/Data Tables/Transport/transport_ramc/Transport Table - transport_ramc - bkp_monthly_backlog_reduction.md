---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_ramc
table-name: bkp_monthly_backlog_reduction
full-name: transport_dev.transport_ramc.bkp_monthly_backlog_reduction
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-table, databricks, transport-ramc, backlog]
---

# Transport Table - transport_ramc - bkp_monthly_backlog_reduction

## Identity

| Field | Value |
|---|---|
| Table name | `bkp_monthly_backlog_reduction` |
| Full name | `transport_dev.transport_ramc.bkp_monthly_backlog_reduction` |
| Catalog | `transport_dev` |
| Schema | `transport_ramc` |
| Contract/schema | `transport_ramc` |
| Table type | MANAGED |
| Column count | 4 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | backlog |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `ReportingMonth` | `string` | Yes |  |
| `Reason` | `string` | Yes |  |
| `JobType` | `string` | Yes |  |
| `JobCount` | `bigint` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_ramc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
