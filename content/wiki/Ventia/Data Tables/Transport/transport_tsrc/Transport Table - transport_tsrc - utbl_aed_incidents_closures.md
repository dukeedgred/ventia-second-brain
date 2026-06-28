---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: utbl_aed_incidents_closures
full-name: transport_dev.transport_tsrc.utbl_aed_incidents_closures
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-table, databricks, transport-tsrc, incident-closure]
---

# Transport Table - transport_tsrc - utbl_aed_incidents_closures

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_aed_incidents_closures` |
| Full name | `transport_dev.transport_tsrc.utbl_aed_incidents_closures` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | MANAGED |
| Column count | 34 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | incident closure |
| Source details | Created by the file upload UI |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Closure ID` | `bigint` | Yes |  |
| `Description` | `string` | Yes |  |
| `Status` | `string` | Yes |  |
| `StatusDate` | `timestamp` | Yes |  |
| `Category` | `string` | Yes |  |
| `Class` | `string` | Yes |  |
| `Purpose` | `string` | Yes |  |
| `Type` | `string` | Yes |  |
| `SectionId` | `bigint` | Yes |  |
| `Section` | `string` | Yes |  |
| `Location` | `string` | Yes |  |
| `LaneAffected` | `string` | Yes |  |
| `Direction` | `string` | Yes |  |
| `HasGuideline` | `bigint` | Yes |  |
| `ChainageStart` | `bigint` | Yes |  |
| `ChainageEnd` | `bigint` | Yes |  |
| `ActualStartDate` | `timestamp` | Yes |  |
| `ActualEndDate` | `timestamp` | Yes |  |
| `TrafficFlowStopped` | `timestamp` | Yes |  |
| `TGS_ID` | `string` | Yes |  |
| `TGS_SetupStart` | `timestamp` | Yes |  |
| `TGS_SetupEnd` | `timestamp` | Yes |  |
| `TGS_PackupStart` | `timestamp` | Yes |  |
| `TGS_PackupEnd` | `timestamp` | Yes |  |
| `TrafficFlowResumed` | `timestamp` | Yes |  |
| `CompletedDate` | `string` | Yes |  |
| `DurationInHours` | `double` | Yes |  |
| `DurationInMinutes` | `bigint` | Yes |  |
| `UnavailabilityEventTriggered` | `bigint` | Yes |  |
| `UnavailabilityDurationInMinutes` | `string` | Yes |  |
| `TGS_TMI_Id` | `string` | Yes |  |
| `DutyTCCO` | `string` | Yes |  |
| `Creator` | `string` | Yes |  |
| `CreatedDate` | `timestamp` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
