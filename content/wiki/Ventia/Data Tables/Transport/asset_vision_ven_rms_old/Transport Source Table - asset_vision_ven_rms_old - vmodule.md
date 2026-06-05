---
type: source-data-table
topic: Ventia
sector: Transport
source-context: asset_vision_ven_rms_old
source-catalog: ext_mssql_asset_vision_ven_rms_old
source-schema: dbo
table-name: vmodule
full-name: ext_mssql_asset_vision_ven_rms_old.dbo.vmodule
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, source-table, databricks, asset-vision, asset-vision-ven-rms-old, module]
---

# Transport Source Table - asset_vision_ven_rms_old - vmodule

## Identity

| Field | Value |
|---|---|
| Table name | `vmodule` |
| Full name | `ext_mssql_asset_vision_ven_rms_old.dbo.vmodule` |
| Catalog | `ext_mssql_asset_vision_ven_rms_old` |
| Schema | `dbo` |
| Source context | `asset_vision_ven_rms_old` |
| Table type | FOREIGN |
| Column count | 29 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | module |
| Source system | Asset Vision |
| Source catalog | `ext_mssql_asset_vision_ven_rms_old` |
| Source schema | `dbo` |
| Source context | `asset_vision_ven_rms_old` |
| Caveats/open questions | Catalog name includes `ven_rms_old`; confirm whether this maps to legacy RMS client/contract, contract group, or environment. Do not treat `dbo` as a client or contractor. |

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
| `WKT` | `string` | Yes |  |

## Related Pages

- [[Transport Source Tables - asset_vision_ven_rms_old]]
- [[Transport Data Tables]]
- [[Asset Vision]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]





