---
type: source-data-table
topic: Ventia
sector: Transport
source-context: asset_vision_vns_gen7
source-catalog: ext_mssql_asset_vision_vns_gen7
source-schema: dbo
table-name: vcapitalwork
full-name: ext_mssql_asset_vision_vns_gen7.dbo.vcapitalwork
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, source-table, databricks, asset-vision, asset-vision-vns-gen7, vcapitalwork]
---

# Transport Source Table - asset_vision_vns_gen7 - vcapitalwork

## Identity

| Field | Value |
|---|---|
| Table name | `vcapitalwork` |
| Full name | `ext_mssql_asset_vision_vns_gen7.dbo.vcapitalwork` |
| Catalog | `ext_mssql_asset_vision_vns_gen7` |
| Schema | `dbo` |
| Source context | `asset_vision_vns_gen7` |
| Table type | FOREIGN |
| Column count | 29 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | capital work |
| Source system | Asset Vision |
| Source catalog | `ext_mssql_asset_vision_vns_gen7` |
| Source schema | `dbo` |
| Source context | `asset_vision_vns_gen7` |
| Caveats/open questions | Catalog name includes `vns_gen7`; confirm whether this maps to a client/contract, contract group, or environment/version. Do not treat `dbo` as a client or contractor. |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `ID` | `int` | Yes |  |
| `DeltaUTC` | `timestamp` | Yes |  |
| `ModifiedUTC` | `timestamp` | Yes |  |
| `ModifiedUser` | `string` | Yes |  |
| `Name` | `string` | Yes |  |
| `Description` | `string` | Yes |  |
| `CapitalWorkType` | `string` | Yes |  |
| `AssetTypeName` | `string` | Yes |  |
| `AssetID` | `int` | Yes |  |
| `AssetCode` | `string` | Yes |  |
| `AssetName` | `string` | Yes |  |
| `Section` | `string` | Yes |  |
| `Direction` | `string` | Yes |  |
| `ChainageFrom` | `int` | Yes |  |
| `ChainageTo` | `int` | Yes |  |
| `BothDirections` | `string` | Yes |  |
| `Contract` | `string` | Yes |  |
| `CreatedUser` | `string` | Yes |  |
| `Area` | `decimal(18,2)` | Yes |  |
| `PlannedStart` | `timestamp` | Yes |  |
| `PlannedFinish` | `timestamp` | Yes |  |
| `ActualStart` | `timestamp` | Yes |  |
| `ActualFinish` | `timestamp` | Yes |  |
| `Reference1` | `string` | Yes |  |
| `Reference2` | `string` | Yes |  |
| `Supervisor` | `string` | Yes |  |
| `SpatialInfo` | `binary` | Yes |  |
| `Deleted` | `boolean` | Yes |  |
| `WKT` | `string` | Yes |  |

## Related Pages

- [[Transport Source Tables - asset_vision_vns_gen7]]
- [[Transport Data Tables]]
- [[Asset Vision]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]


