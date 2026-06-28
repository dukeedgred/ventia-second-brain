---
type: source-data-table
topic: Ventia
sector: Transport
source-context: asset_vision_ven_vicroads
source-catalog: ext_mssql_asset_vision_ven_vicroads
source-schema: dbo
table-name: summarycheck
full-name: ext_mssql_asset_vision_ven_vicroads.dbo.summarycheck
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, source-table, databricks, asset-vision, asset-vision-ven-vicroads, summarycheck]
---

# Transport Source Table - asset_vision_ven_vicroads - summarycheck

## Identity

| Field | Value |
|---|---|
| Table name | `summarycheck` |
| Full name | `ext_mssql_asset_vision_ven_vicroads.dbo.summarycheck` |
| Catalog | `ext_mssql_asset_vision_ven_vicroads` |
| Schema | `dbo` |
| Source context | `asset_vision_ven_vicroads` |
| Table type | FOREIGN |
| Column count | 8 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | summary check |
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
| `CheckDateUTC` | `timestamp` | Yes |  |
| `TableName` | `string` | Yes |  |
| `CountType` | `string` | Yes |  |
| `CountValueLocal` | `int` | Yes |  |
| `CountValueServer` | `int` | Yes |  |
| `Contract` | `string` | Yes |  |

## Related Pages

- [[Transport Source Tables - asset_vision_ven_vicroads]]
- [[Transport Data Tables]]
- [[Asset Vision]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]

