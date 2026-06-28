---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_ramc
table-name: utbl_monthly_backlog_reduction
full-name: transport_dev.transport_ramc.utbl_monthly_backlog_reduction
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-ramc]
---

# Transport Table - transport_ramc - utbl_monthly_backlog_reduction

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_monthly_backlog_reduction` |
| Full name | `transport_dev.transport_ramc.utbl_monthly_backlog_reduction` |
| Catalog | `transport_dev` |
| Schema | `transport_ramc` |
| Contract/schema | `transport_ramc` |
| Table type | MANAGED |
| Column count | 4 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2024-10-14T22:28:53.468Z; Last altered: 2026-05-21T03:40:39.285Z |
| Source details | Data source format: DELTA |

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
- [[Transport Contract Portfolio]]
