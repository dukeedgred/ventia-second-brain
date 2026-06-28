---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport
table-name: utbl_job_costing_timesheets_all_contracts
full-name: transport_dev.transport.utbl_job_costing_timesheets_all_contracts
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-table, databricks, job-costing, timesheet]
---

# Transport Table - transport - utbl_job_costing_timesheets_all_contracts

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_job_costing_timesheets_all_contracts` |
| Full name | `transport_dev.transport.utbl_job_costing_timesheets_all_contracts` |
| Catalog | `transport_dev` |
| Schema | `transport` |
| Contract/schema | `transport` |
| Table type | MANAGED |
| Column count | 50 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | job costing timesheet |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Contract` | `string` | Yes |  |
| `AV_Database` | `string` | Yes |  |
| `Activity` | `string` | Yes |  |
| `AV_Link` | `string` | Yes |  |
| `RecordID` | `int` | Yes |  |
| `MergedJobID` | `int` | Yes |  |
| `completeduser` | `string` | Yes |  |
| `Job_CompletedDate` | `timestamp` | Yes |  |
| `TimesheetCreatedUser` | `string` | Yes |  |
| `TimesheetDate` | `timestamp` | Yes |  |
| `Utilisation_Date` | `timestamp` | Yes |  |
| `TimeSheetFilled` | `string` | Yes |  |
| `TimesheetID` | `int` | Yes |  |
| `ResourceType` | `string` | Yes |  |
| `TimesheetType` | `string` | Yes |  |
| `ResourceCode` | `string` | Yes |  |
| `ResourceName` | `string` | Yes |  |
| `Hours` | `int` | Yes |  |
| `Minutes` | `int` | Yes |  |
| `DurationInDecimal` | `decimal(5,2)` | Yes |  |
| `DurationMultiplier` | `int` | Yes |  |
| `TotalDurationInDecimal` | `decimal(5,2)` | Yes |  |
| `TimeStart` | `timestamp` | Yes |  |
| `TimeEnd` | `timestamp` | Yes |  |
| `Quantity` | `decimal(5,2)` | Yes |  |
| `UnitOfMeasure` | `string` | Yes |  |
| `ResourceUnit` | `string` | Yes |  |
| `ResourceRate` | `decimal(5,2)` | Yes |  |
| `ResourceCost` | `double` | Yes |  |
| `Standard_FaultType` | `string` | Yes |  |
| `JobStatus` | `string` | Yes |  |
| `ActivityCategoryCode` | `string` | Yes |  |
| `ActivityCategory` | `string` | Yes |  |
| `ActivityCode` | `string` | Yes |  |
| `ActivityName` | `string` | Yes |  |
| `InterventionCode` | `string` | Yes |  |
| `InterventionName` | `string` | Yes |  |
| `Classification` | `string` | Yes |  |
| `StandardRoadClass` | `string` | Yes |  |
| `StandardClassCode` | `string` | Yes |  |
| `AssetType` | `string` | Yes |  |
| `AssetCode` | `string` | Yes |  |
| `AssetName` | `string` | Yes |  |
| `WRU_FindandFix` | `string` | Yes |  |
| `WBSNumber` | `string` | Yes |  |
| `SAPWorkOrder` | `string` | Yes |  |
| `CompanyRate` | `string` | Yes |  |
| `SAPWorkOrderFilled` | `string` | Yes |  |
| `SAPWorkOrder_Trimmed` | `string` | Yes |  |
| `SAP_Record_Exists` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
