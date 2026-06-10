---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: utbl_aed_wo_list
full-name: transport_dev.transport_tsrc.utbl_aed_wo_list
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - utbl_aed_wo_list

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_aed_wo_list` |
| Full name | `transport_dev.transport_tsrc.utbl_aed_wo_list` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | MANAGED |
| Column count | 25 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Business purpose | Created by the file upload UI |
| Owner/SME | Helix_readwrite_corporate_dev |
| Refresh/freshness | Created: 2024-09-20T05:19:37.304Z; Last altered: 2026-06-09T05:40:05.002Z |
| Source details | Data source format: DELTA |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `WO Num` | `bigint` | Yes |  |
| `Description` | `string` | Yes |  |
| `WorkType` | `string` | Yes |  |
| `Code` | `string` | Yes |  |
| `WOStatus` | `string` | Yes |  |
| `StatusDate` | `timestamp` | Yes |  |
| `TargetStartDate` | `timestamp` | Yes |  |
| `TargetCompleteDate` | `timestamp` | Yes |  |
| `ActualStartDate` | `timestamp` | Yes |  |
| `ActualCompleteDate` | `timestamp` | Yes |  |
| `ScheduledStartDate` | `timestamp` | Yes |  |
| `ScheduledCompleteDate` | `timestamp` | Yes |  |
| `ReportedDate` | `timestamp` | Yes |  |
| `CreateDate` | `timestamp` | Yes |  |
| `ReportedBy` | `string` | Yes |  |
| `Lead` | `string` | Yes |  |
| `Phone` | `string` | Yes |  |
| `LeadMobile` | `string` | Yes |  |
| `Direction` | `string` | Yes |  |
| `WCP_Code` | `string` | Yes |  |
| `WorkControlProcedure` | `string` | Yes |  |
| `WorkPlan` | `string` | Yes |  |
| `Crew` | `string` | Yes |  |
| `Supervisor` | `string` | Yes |  |
| `Contractor` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
