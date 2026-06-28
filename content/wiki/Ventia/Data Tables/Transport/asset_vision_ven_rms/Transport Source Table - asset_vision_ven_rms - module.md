---
type: source-data-table
topic: Ventia
sector: Transport
source-context: asset_vision_ven_rms
source-catalog: ext_mssql_asset_vision_ven_rms
source-schema: dbo
table-name: module
full-name: ext_mssql_asset_vision_ven_rms.dbo.module
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, source-table, databricks, asset-vision, asset-vision-ven-rms, module]
---

# Transport Source Table - asset_vision_ven_rms - module

## Identity

| Field | Value |
|---|---|
| Table name | `module` |
| Full name | `ext_mssql_asset_vision_ven_rms.dbo.module` |
| Catalog | `ext_mssql_asset_vision_ven_rms` |
| Schema | `dbo` |
| Source context | `asset_vision_ven_rms` |
| Table type | FOREIGN |
| Column count | 36 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | module |
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
| `Contract` | `string` | Yes |  |
| `Region` | `string` | Yes |  |
| `CompletedDate` | `timestamp` | Yes |  |
| `ModuleName` | `string` | Yes |  |
| `Name` | `string` | Yes |  |
| `CreatedDate` | `timestamp` | Yes |  |
| `CreatedUser` | `string` | Yes |  |
| `AssignedUser` | `string` | Yes |  |
| `Comments` | `string` | Yes |  |
| `AssetID` | `int` | Yes |  |
| `AssetCode` | `string` | Yes |  |
| `AssetName` | `string` | Yes |  |
| `EntireLength` | `string` | Yes |  |
| `Direction` | `varchar(50)` | Yes |  |
| `StartPointName` | `string` | Yes |  |
| `ChainageFrom` | `int` | Yes |  |
| `StartDistancePast` | `int` | Yes |  |
| `EndPointName` | `string` | Yes |  |
| `ChainageTo` | `int` | Yes |  |
| `EndDistancePast` | `int` | Yes |  |
| `SpatialInfo` | `binary` | Yes |  |
| `ParentSourceTableName` | `string` | Yes |  |
| `ParentSourceTableID` | `int` | Yes |  |
| `Deleted` | `boolean` | Yes |  |
| `Ref_ContractID` | `int` | Yes |  |
| `Ref_RegionID` | `int` | Yes |  |
| `Ref_AssignedUserID` | `int` | Yes |  |
| `Ref_StartPointID` | `int` | Yes |  |
| `Ref_EndPointID` | `int` | Yes |  |
| `Ref_CreatedUserID` | `int` | Yes |  |
| `Ref_ModifiedUserID` | `int` | Yes |  |
| `Ref_ModuleTypeID` | `int` | Yes |  |

## Related Pages

- [[Transport Source Tables - asset_vision_ven_rms]]
- [[Transport Data Tables]]
- [[Asset Vision]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]

