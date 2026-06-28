---
type: source-data-table
topic: Ventia
sector: Transport
source-context: asset_vision_ven_gen7
source-catalog: ext_mssql_asset_vision_ven_gen7
source-schema: dbo
table-name: summarycheck
full-name: ext_mssql_asset_vision_ven_gen7.dbo.summarycheck
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, source-table, databricks, asset-vision, asset-vision-ven-gen7, summarycheck]
---

# Transport Source Table - asset_vision_ven_gen7 - summarycheck

## Identity

| Field | Value |
|---|---|
| Table name | `summarycheck` |
| Full name | `ext_mssql_asset_vision_ven_gen7.dbo.summarycheck` |
| Catalog | `ext_mssql_asset_vision_ven_gen7` |
| Schema | `dbo` |
| Source context | `asset_vision_ven_gen7` |
| Table type | FOREIGN |
| Column count | 8 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | summary check |
| Source system | Asset Vision |
| Source catalog | `ext_mssql_asset_vision_ven_gen7` |
| Source schema | `dbo` |
| Source context | `asset_vision_ven_gen7` |
| Caveats/open questions | Catalog name includes `ven_gen7`; confirm whether this maps to a client/contract, contract group, or environment/version. Do not treat `dbo` as a client or contractor. |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `ID` | `int` | Yes |  |
| `DeltaUTC` | `timestamp` | Yes |  |
| `CheckDateUTC` | `timestamp` | Yes |  |
| `TableName` | `string` | Yes |  |
| `CountType` | `string` | Yes |  |
| `CountValueLocal` | `int` | Yes |  |
| `CountValueServer` | `int` | Yes |  |
| `Contract` | `string` | Yes |  |

## Related Pages

- [[Transport Source Tables - asset_vision_ven_gen7]]
- [[Transport Data Tables]]
- [[Asset Vision]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]

