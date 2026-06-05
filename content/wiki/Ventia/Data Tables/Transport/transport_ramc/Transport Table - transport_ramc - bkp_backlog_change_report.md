---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_ramc
table-name: bkp_backlog_change_report
full-name: transport_dev.transport_ramc.bkp_backlog_change_report
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-table, databricks, transport-ramc, backlog]
---

# Transport Table - transport_ramc - bkp_backlog_change_report

## Identity

| Field | Value |
|---|---|
| Table name | `bkp_backlog_change_report` |
| Full name | `transport_dev.transport_ramc.bkp_backlog_change_report` |
| Catalog | `transport_dev` |
| Schema | `transport_ramc` |
| Contract/schema | `transport_ramc` |
| Table type | MANAGED |
| Column count | 9 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | backlog |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `BacklogMonth` | `string` | Yes |  |
| `Type` | `string` | Yes |  |
| `Classification` | `string` | Yes |  |
| `CurrActivityType` | `string` | Yes |  |
| `LastActivityType` | `string` | Yes |  |
| `IsChanged` | `string` | Yes |  |
| `BacklogChange` | `string` | Yes |  |
| `JobCount` | `bigint` | Yes |  |
| `EstimatedCost` | `decimal(28,2)` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_ramc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
