---
type: source-data-table
topic: Ventia
sector: Transport
source-context: asset_vision_ven_rms_new
source-catalog: ext_mssql_asset_vision_ven_rms_new
source-schema: dbo
table-name: inspection
full-name: ext_mssql_asset_vision_ven_rms_new.dbo.inspection
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, source-table, databricks, asset-vision-ven-rms-new]
---

# Transport Source Table - asset_vision_ven_rms_new - inspection

## Identity

| Field | Value |
|---|---|
| Table name | `inspection` |
| Full name | `ext_mssql_asset_vision_ven_rms_new.dbo.inspection` |
| Catalog | `ext_mssql_asset_vision_ven_rms_new` |
| Schema | `dbo` |
| Source context | `asset_vision_ven_rms_new` |
| Table type | FOREIGN |
| Column count | 62 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | inspection / audit / condition |
| Source system | Asset Vision |
| Source catalog | `ext_mssql_asset_vision_ven_rms_new` |
| Source schema | `dbo` |
| Source context | `asset_vision_ven_rms_new` |
| Owner/SME | kale.skinner@ventia.com |
| Refresh/freshness | Created: 2025-12-09T22:03:24.353Z; Last altered: 2025-12-10T05:18:50.953Z |
| Source details | Data source format: SQLSERVER_FORMAT |
| Caveats/open questions | Preserve `dbo` as source schema metadata; do not treat it as a client or contract. |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `ID` | `int` | Yes |  |
| `DeltaUTC` | `timestamp` | Yes |  |
| `ModifiedUTC` | `timestamp` | Yes |  |
| `ModifiedUser` | `string` | Yes |  |
| `AssetTypeName` | `string` | Yes |  |
| `AssetID` | `int` | Yes |  |
| `AssetCode` | `string` | Yes |  |
| `AssetName` | `string` | Yes |  |
| `Section` | `string` | Yes |  |
| `Classification` | `string` | Yes |  |
| `Contract` | `string` | Yes |  |
| `Region` | `string` | Yes |  |
| `StartDate` | `timestamp` | Yes |  |
| `StartReferencePointName` | `string` | Yes |  |
| `ChainageFrom` | `int` | Yes |  |
| `StartDistancePast` | `int` | Yes |  |
| `EndReferencePointName` | `string` | Yes |  |
| `ChainageTo` | `int` | Yes |  |
| `EndDistancePast` | `int` | Yes |  |
| `Direction` | `string` | Yes |  |
| `BothDirections` | `string` | Yes |  |
| `OtherDirectionInspectionID` | `int` | Yes |  |
| `InspectionTypeID` | `int` | Yes |  |
| `InspectionTypeName` | `string` | Yes |  |
| `InspectionTypeReference1` | `string` | Yes |  |
| `InspectionTypeReference2` | `string` | Yes |  |
| `Category` | `string` | Yes |  |
| `CreatedDate` | `timestamp` | Yes |  |
| `CreatedUser` | `string` | Yes |  |
| `AssignedUser` | `string` | Yes |  |
| `Comments` | `string` | Yes |  |
| `EntireLength` | `string` | Yes |  |
| `ScheduledDate` | `timestamp` | Yes |  |
| `ScheduledDateFrom` | `timestamp` | Yes |  |
| `ScheduledDateTo` | `timestamp` | Yes |  |
| `CurrentStatus` | `string` | Yes |  |
| `CompletedDate` | `timestamp` | Yes |  |
| `CompletedUser` | `string` | Yes |  |
| `JobID` | `int` | Yes |  |
| `CapitalWorkID` | `int` | Yes |  |
| `InspectionRouteName` | `string` | Yes |  |
| `InspectionGroupID` | `int` | Yes |  |
| `Reference1` | `string` | Yes |  |
| `Reference2` | `string` | Yes |  |
| `EstimatedDuration` | `decimal(10,2)` | Yes |  |
| `SpatialInfo` | `binary` | Yes |  |
| `InspectionID` | `int` | Yes |  |
| `ModuleID` | `int` | Yes |  |
| `Deleted` | `boolean` | Yes |  |
| `Ref_ModifiedUserID` | `int` | Yes |  |
| `Ref_ContractRoadID` | `int` | Yes |  |
| `Ref_AssetTypeID` | `int` | Yes |  |
| `Ref_ContractID` | `int` | Yes |  |
| `Ref_RegionID` | `int` | Yes |  |
| `Ref_StartPointID` | `int` | Yes |  |
| `Ref_EndPointID` | `int` | Yes |  |
| `Ref_CreatedUserID` | `int` | Yes |  |
| `Ref_AssignedUserID` | `int` | Yes |  |
| `Ref_CompletedUserID` | `int` | Yes |  |
| `Ref_InspectionRouteID` | `int` | Yes |  |
| `Ref_ClassificationIDs` | `varchar(4000)` | Yes |  |
| `Ref_InspectionTypeIDs` | `varchar(4000)` | Yes |  |

## Related Pages

- [[Transport Source Tables - asset_vision_ven_rms_new]]
- [[Transport Data Tables]]
- [[Asset Vision]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
