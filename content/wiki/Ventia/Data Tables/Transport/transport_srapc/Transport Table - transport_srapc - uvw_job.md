---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_srapc
table-name: uvw_job
full-name: transport_dev.transport_srapc.uvw_job
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-srapc]
---

# Transport Table - transport_srapc - uvw_job

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_job` |
| Full name | `transport_dev.transport_srapc.uvw_job` |
| Catalog | `transport_dev` |
| Schema | `transport_srapc` |
| Contract/schema | `transport_srapc` |
| Table type | VIEW |
| Column count | 82 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | jobs / work orders |
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2024-06-18T04:51:52.415Z; Last altered: 2024-09-11T01:04:03.888Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
select
  j.*,
  f.value as IncidentNumber
from
  ext_mssql_asset_vision_ven_rms.dbo.vjob j
  left join ext_mssql_asset_vision_ven_rms.dbo.formfield f on f.sourcetable = 'Job'
  and f.name = 'Incident|TMC Number'
  and f.deleted = false
  and f.sourcetableid = j.id
where
  j.contract = 'SRAP-C'
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `ID` | `int` | Yes |  |
| `DeltaUTC` | `timestamp` | Yes |  |
| `ModifiedUTC` | `timestamp` | Yes |  |
| `AssetID` | `int` | Yes |  |
| `AssetCode` | `string` | Yes |  |
| `AssetName` | `string` | Yes |  |
| `Section` | `string` | Yes |  |
| `Contract` | `string` | Yes |  |
| `Region` | `string` | Yes |  |
| `HazardDefectCode` | `string` | Yes |  |
| `HazardCode` | `string` | Yes |  |
| `ActivityCategoryCode` | `string` | Yes |  |
| `ActivityCategoryName` | `string` | Yes |  |
| `ActivityCode` | `string` | Yes |  |
| `ActivityName` | `string` | Yes |  |
| `InterventionID` | `int` | Yes |  |
| `InterventionCode` | `string` | Yes |  |
| `FullInterventionCode` | `string` | Yes |  |
| `InterventionName` | `string` | Yes |  |
| `InterventionReference1` | `string` | Yes |  |
| `InterventionReference2` | `string` | Yes |  |
| `CreatedDate` | `timestamp` | Yes |  |
| `Direction` | `string` | Yes |  |
| `ReferencePointName` | `string` | Yes |  |
| `EndReferencePointName` | `string` | Yes |  |
| `EstimatedDuration` | `decimal(10,2)` | Yes |  |
| `ChainageFrom` | `int` | Yes |  |
| `ChainageTo` | `int` | Yes |  |
| `BothDirections` | `string` | Yes |  |
| `DistancePast` | `int` | Yes |  |
| `EndDistancePast` | `int` | Yes |  |
| `Unit` | `string` | Yes |  |
| `EstimatedQuantity` | `decimal(10,3)` | Yes |  |
| `Priority` | `string` | Yes |  |
| `InspectionID` | `int` | Yes |  |
| `DueDate` | `timestamp` | Yes |  |
| `ScheduledStart` | `timestamp` | Yes |  |
| `ScheduledEnd` | `timestamp` | Yes |  |
| `CompletedDate` | `timestamp` | Yes |  |
| `AssignedUser` | `string` | Yes |  |
| `ApprovalDate` | `timestamp` | Yes |  |
| `ApprovalNumber` | `string` | Yes |  |
| `FutureWorks` | `boolean` | Yes |  |
| `EstimatedCost` | `decimal(18,2)` | Yes |  |
| `Area` | `string` | Yes |  |
| `AssignedDate` | `timestamp` | Yes |  |
| `ActivityType` | `string` | Yes |  |
| `CompletedStatus` | `string` | Yes |  |
| `Reference1` | `string` | Yes |  |
| `Reference2` | `string` | Yes |  |
| `ReferencePointTypeName` | `string` | Yes |  |
| `EndReferencePointTypeName` | `string` | Yes |  |
| `Compliant` | `string` | Yes |  |
| `Classification` | `string` | Yes |  |
| `Comments` | `string` | Yes |  |
| `RemainingQuantity` | `decimal(38,2)` | Yes |  |
| `ActualQuantity` | `decimal(38,2)` | Yes |  |
| `CreatedUser` | `string` | Yes |  |
| `ApprovedUser` | `string` | Yes |  |
| `CompletedUser` | `string` | Yes |  |
| `ExternalID` | `string` | Yes |  |
| `AssetTypeName` | `string` | Yes |  |
| `InspectionTypeName` | `string` | Yes |  |
| `CurrentWorkflowItemCode` | `string` | Yes |  |
| `CurrentWorkflowItemName` | `string` | Yes |  |
| `SpatialInfo` | `binary` | Yes |  |
| `MergedJobID` | `int` | Yes |  |
| `LinkedJobID` | `int` | Yes |  |
| `CRMID` | `string` | Yes |  |
| `MadeSafe` | `boolean` | Yes |  |
| `MadeSafeDateUTC` | `timestamp` | Yes |  |
| `ComplianceCalculationDate` | `timestamp` | Yes |  |
| `CRMDescription` | `string` | Yes |  |
| `CRMField1` | `string` | Yes |  |
| `CRMField2` | `string` | Yes |  |
| `CRMField3` | `string` | Yes |  |
| `CRMField4` | `string` | Yes |  |
| `CRMField5` | `int` | Yes |  |
| `CRMField6` | `timestamp` | Yes |  |
| `Deleted` | `boolean` | Yes |  |
| `WKT` | `string` | Yes |  |
| `IncidentNumber` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_srapc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
