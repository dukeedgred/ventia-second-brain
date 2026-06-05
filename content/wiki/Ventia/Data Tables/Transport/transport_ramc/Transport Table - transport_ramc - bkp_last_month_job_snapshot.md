---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_ramc
table-name: bkp_last_month_job_snapshot
full-name: transport_dev.transport_ramc.bkp_last_month_job_snapshot
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-table, databricks, transport-ramc, job-snapshot]
---

# Transport Table - transport_ramc - bkp_last_month_job_snapshot

## Identity

| Field | Value |
|---|---|
| Table name | `bkp_last_month_job_snapshot` |
| Full name | `transport_dev.transport_ramc.bkp_last_month_job_snapshot` |
| Catalog | `transport_dev` |
| Schema | `transport_ramc` |
| Contract/schema | `transport_ramc` |
| Table type | MANAGED |
| Column count | 24 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | job snapshot |

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
