---
type: source-data-table
topic: Ventia
sector: Transport
source-context: asset_vision_ven_rms_old
source-catalog: ext_mssql_asset_vision_ven_rms_old
source-schema: dbo
table-name: assetarea
full-name: ext_mssql_asset_vision_ven_rms_old.dbo.assetarea
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, source-table, databricks, asset-vision, asset-vision-ven-rms-old, asset]
---

# Transport Source Table - asset_vision_ven_rms_old - assetarea

## Identity

| Field | Value |
|---|---|
| Table name | `assetarea` |
| Full name | `ext_mssql_asset_vision_ven_rms_old.dbo.assetarea` |
| Catalog | `ext_mssql_asset_vision_ven_rms_old` |
| Schema | `dbo` |
| Source context | `asset_vision_ven_rms_old` |
| Table type | FOREIGN |
| Column count | 11 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | asset |
| Source system | Asset Vision |
| Source catalog | `ext_mssql_asset_vision_ven_rms_old` |
| Source schema | `dbo` |
| Source context | `asset_vision_ven_rms_old` |
| Caveats/open questions | Catalog name includes `ven_rms_old`; confirm whether this maps to legacy RMS client/contract, contract group, or environment. Do not treat `dbo` as a client or contractor. |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `ID` | `int` | Yes |  |
| `AssetAreaID` | `int` | Yes |  |
| `DeltaUTC` | `timestamp` | Yes |  |
| `ModifiedUTC` | `timestamp` | Yes |  |
| `ModifiedUser` | `string` | Yes |  |
| `AssetID` | `int` | Yes |  |
| `Area` | `string` | Yes |  |
| `Direction` | `string` | Yes |  |
| `ChainageFrom` | `int` | Yes |  |
| `ChainageTo` | `int` | Yes |  |
| `Deleted` | `boolean` | Yes |  |

## Related Pages

- [[Transport Source Tables - asset_vision_ven_rms_old]]
- [[Transport Data Tables]]
- [[Asset Vision]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]





