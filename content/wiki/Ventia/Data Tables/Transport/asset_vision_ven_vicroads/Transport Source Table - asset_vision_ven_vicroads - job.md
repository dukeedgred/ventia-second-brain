---
type: source-data-table
topic: Ventia
sector: Transport
source-context: asset_vision_ven_vicroads
source-catalog: ext_mssql_asset_vision_ven_vicroads
source-schema: dbo
table-name: job
full-name: ext_mssql_asset_vision_ven_vicroads.dbo.job
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, source-table, databricks, asset-vision, asset-vision-ven-vicroads, job]
---

# Transport Source Table - asset_vision_ven_vicroads - job

## Identity

| Field | Value |
|---|---|
| Table name | `job` |
| Full name | `ext_mssql_asset_vision_ven_vicroads.dbo.job` |
| Catalog | `ext_mssql_asset_vision_ven_vicroads` |
| Schema | `dbo` |
| Source context | `asset_vision_ven_vicroads` |
| Table type | FOREIGN |
| Column count | 84 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | job |
| Source system | Asset Vision |
| Source catalog | `ext_mssql_asset_vision_ven_vicroads` |
| Source schema | `dbo` |
| Source context | `asset_vision_ven_vicroads` |
| Caveats/open questions | Catalog name includes `ven_vicroads`; confirm whether this maps to a client/contract, contract group, or source environment. Do not treat `dbo` as a client or contractor. |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `ID` | `int` | Yes |  |
| `DeltaUTC` | `timestamp` | Yes |  |
| `ModifiedUTC` | `timestamp` | Yes |  |
| `ModifiedUser` | `string` | Yes |  |
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
| `EstimatedLength` | `decimal(10,3)` | Yes |  |
| `EstimatedWidth` | `decimal(10,3)` | Yes |  |
| `EstimatedDepth` | `decimal(10,3)` | Yes |  |
| `Deleted` | `boolean` | Yes |  |

## Related Pages

- [[Transport Source Tables - asset_vision_ven_vicroads]]
- [[Transport Data Tables]]
- [[Asset Vision]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]

