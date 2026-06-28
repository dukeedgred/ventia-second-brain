---
type: source-data-table
topic: Ventia
sector: Transport
source-context: asset_vision_ven_vicroads
source-catalog: ext_mssql_asset_vision_ven_vicroads
source-schema: dbo
table-name: asset
full-name: ext_mssql_asset_vision_ven_vicroads.dbo.asset
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, source-table, databricks, asset-vision, asset-vision-ven-vicroads, asset]
---

# Transport Source Table - asset_vision_ven_vicroads - asset

## Identity

| Field | Value |
|---|---|
| Table name | `asset` |
| Full name | `ext_mssql_asset_vision_ven_vicroads.dbo.asset` |
| Catalog | `ext_mssql_asset_vision_ven_vicroads` |
| Schema | `dbo` |
| Source context | `asset_vision_ven_vicroads` |
| Table type | FOREIGN |
| Column count | 35 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | asset |
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
| `ExportDateUTC` | `timestamp` | Yes |  |
| `ModifiedUser` | `string` | Yes |  |
| `Code` | `string` | Yes |  |
| `Name` | `string` | Yes |  |
| `Contract` | `string` | Yes |  |
| `AssetType` | `string` | Yes |  |
| `SpatialType` | `string` | Yes |  |
| `ParentAssetID` | `int` | Yes |  |
| `ParentAssetCode` | `string` | Yes |  |
| `ParentAssetName` | `string` | Yes |  |
| `ParentAssetTypeName` | `string` | Yes |  |
| `Direction` | `string` | Yes |  |
| `ChainageFrom` | `int` | Yes |  |
| `ChainageTo` | `int` | Yes |  |
| `ParentAssetPosition` | `string` | Yes |  |
| `Stage` | `string` | Yes |  |
| `ConstructionDate` | `timestamp` | Yes |  |
| `ConstructionCost` | `decimal(12,2)` | Yes |  |
| `DisposalDate` | `timestamp` | Yes |  |
| `DisposalCost` | `decimal(12,2)` | Yes |  |
| `UsefulLife` | `decimal(6,2)` | Yes |  |
| `AssetCriticality` | `string` | Yes |  |
| `AssetCondition` | `string` | Yes |  |
| `AssetRisk` | `string` | Yes |  |
| `AssetConditionModel` | `string` | Yes |  |
| `ConditionDate` | `timestamp` | Yes |  |
| `Classification` | `string` | Yes |  |
| `Notes` | `string` | Yes |  |
| `AlertNotes` | `string` | Yes |  |
| `OffsetSide` | `string` | Yes |  |
| `OffsetMetres` | `int` | Yes |  |
| `Deleted` | `boolean` | Yes |  |

## Related Pages

- [[Transport Source Tables - asset_vision_ven_vicroads]]
- [[Transport Data Tables]]
- [[Asset Vision]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]

