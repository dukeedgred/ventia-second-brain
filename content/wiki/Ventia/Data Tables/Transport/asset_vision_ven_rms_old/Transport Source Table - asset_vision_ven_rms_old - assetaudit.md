---
type: source-data-table
topic: Ventia
sector: Transport
source-context: asset_vision_ven_rms_old
source-catalog: ext_mssql_asset_vision_ven_rms_old
source-schema: dbo
table-name: assetaudit
full-name: ext_mssql_asset_vision_ven_rms_old.dbo.assetaudit
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, source-table, databricks, asset-vision, asset-vision-ven-rms-old, asset-audit]
---

# Transport Source Table - asset_vision_ven_rms_old - assetaudit

## Identity

| Field | Value |
|---|---|
| Table name | `assetaudit` |
| Full name | `ext_mssql_asset_vision_ven_rms_old.dbo.assetaudit` |
| Catalog | `ext_mssql_asset_vision_ven_rms_old` |
| Schema | `dbo` |
| Source context | `asset_vision_ven_rms_old` |
| Table type | FOREIGN |
| Column count | 11 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | asset audit |
| Source system | Asset Vision |
| Source catalog | `ext_mssql_asset_vision_ven_rms_old` |
| Source schema | `dbo` |
| Source context | `asset_vision_ven_rms_old` |
| Caveats/open questions | Catalog name includes `ven_rms_old`; confirm whether this maps to legacy RMS client/contract, contract group, or environment. Do not treat `dbo` as a client or contractor. |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `ID` | `int` | Yes |  |
| `AssetID` | `int` | Yes |  |
| `Modified` | `timestamp` | Yes |  |
| `DeltaUTC` | `timestamp` | Yes |  |
| `DisplayName` | `string` | Yes |  |
| `OriginalValue` | `string` | Yes |  |
| `NewValue` | `string` | Yes |  |
| `ModifiedUser` | `string` | Yes |  |
| `Source` | `varchar(255)` | Yes |  |
| `RecordID` | `int` | Yes |  |
| `SpatialInfo` | `binary` | Yes |  |

## Related Pages

- [[Transport Source Tables - asset_vision_ven_rms_old]]
- [[Transport Data Tables]]
- [[Asset Vision]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]





