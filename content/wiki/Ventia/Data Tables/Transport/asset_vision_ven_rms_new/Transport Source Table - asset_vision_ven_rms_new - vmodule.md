---
type: source-data-table
topic: Ventia
sector: Transport
source-context: asset_vision_ven_rms_new
source-catalog: ext_mssql_asset_vision_ven_rms_new
source-schema: dbo
table-name: vmodule
full-name: ext_mssql_asset_vision_ven_rms_new.dbo.vmodule
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, source-table, databricks, asset-vision-ven-rms-new]
---

# Transport Source Table - asset_vision_ven_rms_new - vmodule

## Identity

| Field | Value |
|---|---|
| Table name | `vmodule` |
| Full name | `ext_mssql_asset_vision_ven_rms_new.dbo.vmodule` |
| Catalog | `ext_mssql_asset_vision_ven_rms_new` |
| Schema | `dbo` |
| Source context | `asset_vision_ven_rms_new` |
| Table type | FOREIGN |
| Column count | 37 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | forms / modules |
| Source system | Asset Vision |
| Source catalog | `ext_mssql_asset_vision_ven_rms_new` |
| Source schema | `dbo` |
| Source context | `asset_vision_ven_rms_new` |
| Owner/SME | kale.skinner@ventia.com |
| Refresh/freshness | Created: 2025-12-09T22:03:24.478Z; Last altered: 2026-06-03T05:29:58.479Z |
| Source details | Data source format: SQLSERVER_FORMAT |
| Caveats/open questions | Preserve `dbo` as source schema metadata; do not treat it as a client or contract. |

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
| `WKT` | `string` | Yes |  |

## Related Pages

- [[Transport Source Tables - asset_vision_ven_rms_new]]
- [[Transport Data Tables]]
- [[Asset Vision]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
