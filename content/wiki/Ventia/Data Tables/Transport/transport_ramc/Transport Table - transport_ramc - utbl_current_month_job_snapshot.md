---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_ramc
table-name: utbl_current_month_job_snapshot
full-name: transport_dev.transport_ramc.utbl_current_month_job_snapshot
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-table, databricks, transport-ramc, job-snapshot]
---

# Transport Table - transport_ramc - utbl_current_month_job_snapshot

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_current_month_job_snapshot` |
| Full name | `transport_dev.transport_ramc.utbl_current_month_job_snapshot` |
| Catalog | `transport_dev` |
| Schema | `transport_ramc` |
| Contract/schema | `transport_ramc` |
| Table type | MANAGED |
| Column count | 26 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | job snapshot |
| Source details | Created by the file upload UI |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `JobID` | `bigint` | Yes |  |
| `Contract` | `string` | Yes |  |
| `Classification` | `string` | Yes |  |
| `AssetTypeName` | `string` | Yes |  |
| `AssetCode` | `string` | Yes |  |
| `AssetName` | `string` | Yes |  |
| `Direction` | `string` | Yes |  |
| `ChainageFrom` | `bigint` | Yes |  |
| `ActivityCategoryCode` | `string` | Yes |  |
| `ActivityCategoryName` | `string` | Yes |  |
| `ActivityCode` | `bigint` | Yes |  |
| `ActivityName` | `string` | Yes |  |
| `Type` | `string` | Yes |  |
| `ActivityType` | `string` | Yes |  |
| `JobLocation` | `string` | Yes |  |
| `LatestComments` | `string` | Yes |  |
| `EstimatedQuantity` | `double` | Yes |  |
| `EstimatedCost` | `double` | Yes |  |
| `CreatedDatetime` | `timestamp` | Yes |  |
| `CreatedUser` | `string` | Yes |  |
| `Status` | `string` | Yes |  |
| `CompletedDatetime` | `timestamp` | Yes |  |
| `CompletedUser` | `string` | Yes |  |
| `IsFWP` | `string` | Yes |  |
| `IsBacklog` | `string` | Yes |  |
| `BacklogMonth` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_ramc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
