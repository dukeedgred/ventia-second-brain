---
type: source-data-table
topic: Ventia
sector: Transport
source-context: asset_vision_ven_rms
source-catalog: ext_mssql_asset_vision_ven_rms
source-schema: dbo
table-name: vjob
full-name: ext_mssql_asset_vision_ven_rms.dbo.vjob
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, source-table, databricks, asset-vision, asset-vision-ven-rms, vjob]
---

# Transport Source Table - asset_vision_ven_rms - vjob

## Identity

| Field | Value |
|---|---|
| Table name | `vjob` |
| Full name | `ext_mssql_asset_vision_ven_rms.dbo.vjob` |
| Catalog | `ext_mssql_asset_vision_ven_rms` |
| Schema | `dbo` |
| Source context | `asset_vision_ven_rms` |
| Table type | FOREIGN |
| Column count | 106 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | job |
| Source system | Asset Vision |
| Source catalog | `ext_mssql_asset_vision_ven_rms` |
| Source schema | `dbo` |
| Source context | `asset_vision_ven_rms` |
| Caveats/open questions | Catalog name includes `ven_rms`; confirm whether this maps to a client/contract, contract group, or environment/version. Do not treat `dbo` as a client or contractor. |

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
| `Ref_ContractRoadID` | `int` | Yes |  |
| `Ref_ContractID` | `int` | Yes |  |
| `Ref_RegionID` | `int` | Yes |  |
| `Ref_ResponseID` | `int` | Yes |  |
| `Ref_HazardResponseID` | `int` | Yes |  |
| `Ref_ActivityCategoryID` | `int` | Yes |  |
| `Ref_ActivityID` | `int` | Yes |  |
| `Ref_PointID` | `int` | Yes |  |
| `Ref_EndPointID` | `int` | Yes |  |
| `Ref_UnitID` | `int` | Yes |  |
| `Ref_AssignedUserID` | `int` | Yes |  |
| `Ref_CompletedUserID` | `int` | Yes |  |
| `Ref_ApprovedUserID` | `int` | Yes |  |
| `Ref_ModifiedUserID` | `int` | Yes |  |
| `Ref_PointTypeID` | `int` | Yes |  |
| `Ref_EndPointTypeID` | `int` | Yes |  |
| `Ref_ClassificationID` | `int` | Yes |  |
| `Ref_AssetTypeID` | `int` | Yes |  |
| `Ref_InspectionTypeID` | `int` | Yes |  |
| `Ref_WorkflowItemID` | `int` | Yes |  |
| `Ref_CreatedUserID` | `int` | Yes |  |
| `WKT` | `string` | Yes |  |

## Related Pages

- [[Transport Source Tables - asset_vision_ven_rms]]
- [[Transport Data Tables]]
- [[Asset Vision]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]

