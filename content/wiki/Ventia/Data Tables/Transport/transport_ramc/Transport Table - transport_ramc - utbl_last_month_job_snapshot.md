---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_ramc
table-name: utbl_last_month_job_snapshot
full-name: transport_dev.transport_ramc.utbl_last_month_job_snapshot
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-ramc]
---

# Transport Table - transport_ramc - utbl_last_month_job_snapshot

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_last_month_job_snapshot` |
| Full name | `transport_dev.transport_ramc.utbl_last_month_job_snapshot` |
| Catalog | `transport_dev` |
| Schema | `transport_ramc` |
| Contract/schema | `transport_ramc` |
| Table type | MANAGED |
| Column count | 24 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | jobs / work orders |
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2024-09-30T05:23:15.747Z; Last altered: 2026-05-22T06:33:41.833Z |
| Source details | Data source format: DELTA |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `JobID` | `int` | Yes |  |
| `Contract` | `string` | Yes |  |
| `Classification` | `string` | Yes |  |
| `AssetTypeName` | `string` | Yes |  |
| `AssetCode` | `string` | Yes |  |
| `AssetName` | `string` | Yes |  |
| `Direction` | `string` | Yes |  |
| `ChainageFrom` | `int` | Yes |  |
| `ActivityCategoryCode` | `string` | Yes |  |
| `ActivityCategoryName` | `string` | Yes |  |
| `ActivityCode` | `string` | Yes |  |
| `ActivityName` | `string` | Yes |  |
| `Type` | `string` | Yes |  |
| `ActivityType` | `string` | Yes |  |
| `JobLocation` | `string` | Yes |  |
| `LatestComments` | `string` | Yes |  |
| `EstimatedQuantity` | `decimal(10,3)` | Yes |  |
| `EstimatedCost` | `decimal(18,2)` | Yes |  |
| `CreatedDatetime` | `timestamp` | Yes |  |
| `CreatedUser` | `string` | Yes |  |
| `Status` | `string` | Yes |  |
| `CompletedDatetime` | `timestamp` | Yes |  |
| `CompletedUser` | `string` | Yes |  |
| `BacklogMonth` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_ramc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
