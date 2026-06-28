---
type: source-data-table
topic: Ventia
sector: Transport
source-context: asset_vision_vnz_gen7
source-catalog: ext_mssql_asset_vision_vnz_gen7
source-schema: dbo
table-name: jobasset
full-name: ext_mssql_asset_vision_vnz_gen7.dbo.jobasset
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, source-table, databricks, asset-vision, asset-vision-vnz-gen7, jobasset]
---

# Transport Source Table - asset_vision_vnz_gen7 - jobasset

## Identity

| Field | Value |
|---|---|
| Table name | `jobasset` |
| Full name | `ext_mssql_asset_vision_vnz_gen7.dbo.jobasset` |
| Catalog | `ext_mssql_asset_vision_vnz_gen7` |
| Schema | `dbo` |
| Source context | `asset_vision_vnz_gen7` |
| Table type | FOREIGN |
| Column count | 11 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | job asset |
| Source system | Asset Vision |
| Source catalog | `ext_mssql_asset_vision_vnz_gen7` |
| Source schema | `dbo` |
| Source context | `asset_vision_vnz_gen7` |
| Caveats/open questions | Catalog name includes `vnz_gen7`; confirm whether this maps to a client/contract, contract group, or environment/version. Do not treat `dbo` as a client or contractor. |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `ID` | `int` | Yes |  |
| `DeltaUTC` | `timestamp` | Yes |  |
| `ModifiedUTC` | `timestamp` | Yes |  |
| `ModifiedUser` | `string` | Yes |  |
| `JobID` | `int` | Yes |  |
| `AssetID` | `int` | Yes |  |
| `Direction` | `string` | Yes |  |
| `ChainageFrom` | `int` | Yes |  |
| `ChainageTo` | `int` | Yes |  |
| `SystemGenerated` | `boolean` | Yes |  |
| `Deleted` | `boolean` | Yes |  |

## Related Pages

- [[Transport Source Tables - asset_vision_vnz_gen7]]
- [[Transport Data Tables]]
- [[Asset Vision]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]



