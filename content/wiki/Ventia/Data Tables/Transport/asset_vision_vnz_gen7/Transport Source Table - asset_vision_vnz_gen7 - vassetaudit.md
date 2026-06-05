---
type: source-data-table
topic: Ventia
sector: Transport
source-context: asset_vision_vnz_gen7
source-catalog: ext_mssql_asset_vision_vnz_gen7
source-schema: dbo
table-name: vassetaudit
full-name: ext_mssql_asset_vision_vnz_gen7.dbo.vassetaudit
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, source-table, databricks, asset-vision, asset-vision-vnz-gen7, vassetaudit]
---

# Transport Source Table - asset_vision_vnz_gen7 - vassetaudit

## Identity

| Field | Value |
|---|---|
| Table name | `vassetaudit` |
| Full name | `ext_mssql_asset_vision_vnz_gen7.dbo.vassetaudit` |
| Catalog | `ext_mssql_asset_vision_vnz_gen7` |
| Schema | `dbo` |
| Source context | `asset_vision_vnz_gen7` |
| Table type | FOREIGN |
| Column count | 12 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | asset audit |
| Source system | Asset Vision |
| Source catalog | `ext_mssql_asset_vision_vnz_gen7` |
| Source schema | `dbo` |
| Source context | `asset_vision_vnz_gen7` |
| Caveats/open questions | Catalog name includes `vnz_gen7`; confirm whether this maps to a client/contract, contract group, or environment/version. Do not treat `dbo` as a client or contractor. |

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
| `WKT` | `string` | Yes |  |

## Related Pages

- [[Transport Source Tables - asset_vision_vnz_gen7]]
- [[Transport Data Tables]]
- [[Asset Vision]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]



