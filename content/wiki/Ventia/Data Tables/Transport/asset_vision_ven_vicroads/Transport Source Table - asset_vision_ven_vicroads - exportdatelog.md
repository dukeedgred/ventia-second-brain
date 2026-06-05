---
type: source-data-table
topic: Ventia
sector: Transport
source-context: asset_vision_ven_vicroads
source-catalog: ext_mssql_asset_vision_ven_vicroads
source-schema: dbo
table-name: exportdatelog
full-name: ext_mssql_asset_vision_ven_vicroads.dbo.exportdatelog
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, source-table, databricks, asset-vision, asset-vision-ven-vicroads, exportdatelog]
---

# Transport Source Table - asset_vision_ven_vicroads - exportdatelog

## Identity

| Field | Value |
|---|---|
| Table name | `exportdatelog` |
| Full name | `ext_mssql_asset_vision_ven_vicroads.dbo.exportdatelog` |
| Catalog | `ext_mssql_asset_vision_ven_vicroads` |
| Schema | `dbo` |
| Source context | `asset_vision_ven_vicroads` |
| Table type | FOREIGN |
| Column count | 5 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | export tracking |
| Source system | Asset Vision |
| Source catalog | `ext_mssql_asset_vision_ven_vicroads` |
| Source schema | `dbo` |
| Source context | `asset_vision_ven_vicroads` |
| Caveats/open questions | Catalog name includes `ven_vicroads`; confirm whether this maps to a client/contract, contract group, or source environment. Do not treat `dbo` as a client or contractor. |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `ID` | `int` | Yes |  |
| `ExportDateID` | `int` | Yes |  |
| `DeltaUTC` | `timestamp` | Yes |  |
| `Name` | `string` | Yes |  |
| `LastExported` | `timestamp` | Yes |  |

## Related Pages

- [[Transport Source Tables - asset_vision_ven_vicroads]]
- [[Transport Data Tables]]
- [[Asset Vision]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]

