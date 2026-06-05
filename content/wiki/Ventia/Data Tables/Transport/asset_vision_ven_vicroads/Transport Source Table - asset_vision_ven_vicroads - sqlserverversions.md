---
type: source-data-table
topic: Ventia
sector: Transport
source-context: asset_vision_ven_vicroads
source-catalog: ext_mssql_asset_vision_ven_vicroads
source-schema: dbo
table-name: sqlserverversions
full-name: ext_mssql_asset_vision_ven_vicroads.dbo.sqlserverversions
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, source-table, databricks, asset-vision, asset-vision-ven-vicroads, sqlserverversions]
---

# Transport Source Table - asset_vision_ven_vicroads - sqlserverversions

## Identity

| Field | Value |
|---|---|
| Table name | `sqlserverversions` |
| Full name | `ext_mssql_asset_vision_ven_vicroads.dbo.sqlserverversions` |
| Catalog | `ext_mssql_asset_vision_ven_vicroads` |
| Schema | `dbo` |
| Source context | `asset_vision_ven_vicroads` |
| Table type | FOREIGN |
| Column count | 9 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | SQL Server version |
| Source system | Asset Vision |
| Source catalog | `ext_mssql_asset_vision_ven_vicroads` |
| Source schema | `dbo` |
| Source context | `asset_vision_ven_vicroads` |
| Caveats/open questions | Catalog name includes `ven_vicroads`; confirm whether this maps to a client/contract, contract group, or source environment. Do not treat `dbo` as a client or contractor. |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `MajorVersionNumber` | `smallint` | Yes |  |
| `MinorVersionNumber` | `smallint` | Yes |  |
| `Branch` | `varchar(34)` | Yes |  |
| `Url` | `varchar(99)` | Yes |  |
| `ReleaseDate` | `date` | Yes |  |
| `MainstreamSupportEndDate` | `date` | Yes |  |
| `ExtendedSupportEndDate` | `date` | Yes |  |
| `MajorVersionName` | `varchar(19)` | Yes |  |
| `MinorVersionName` | `varchar(67)` | Yes |  |

## Related Pages

- [[Transport Source Tables - asset_vision_ven_vicroads]]
- [[Transport Data Tables]]
- [[Asset Vision]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]

