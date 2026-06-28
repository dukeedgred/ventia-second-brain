---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_aklw
table-name: uvw_plant_pending_timesheet
full-name: transport_dev.transport_aklw.uvw_plant_pending_timesheet
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-table, databricks, transport-aklw, timesheet, plant]
---

# Transport Table - transport_aklw - uvw_plant_pending_timesheet

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_plant_pending_timesheet` |
| Full name | `transport_dev.transport_aklw.uvw_plant_pending_timesheet` |
| Catalog | `transport_dev` |
| Schema | `transport_aklw` |
| Contract/schema | `transport_aklw` |
| Table type | VIEW |
| Column count | 21 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | timesheet |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `ID` | `int` | Yes |  |
| `TimesheetID` | `int` | Yes |  |
| `CreatedDate` | `timestamp` | Yes |  |
| `CreatedUser` | `string` | Yes |  |
| `Activity` | `string` | Yes |  |
| `RecordID` | `int` | Yes |  |
| `TimesheetType` | `string` | Yes |  |
| `Hours` | `int` | Yes |  |
| `Minutes` | `int` | Yes |  |
| `Quantity` | `decimal(9,2)` | Yes |  |
| `StartDate` | `timestamp` | Yes |  |
| `EndDate` | `timestamp` | Yes |  |
| `ResourceID` | `string` | Yes |  |
| `ResourceName` | `string` | Yes |  |
| `ResourceType` | `string` | Yes |  |
| `WBSNumber` | `string` | Yes |  |
| `SAPWorkOrder` | `string` | Yes |  |
| `WorkflowStatus` | `string` | Yes |  |
| `ActivityCategoryCode` | `string` | Yes |  |
| `ActivityCode` | `string` | Yes |  |
| `InterventionCode` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_aklw]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
