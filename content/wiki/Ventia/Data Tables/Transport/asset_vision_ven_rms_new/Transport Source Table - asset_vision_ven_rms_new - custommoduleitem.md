---
type: source-data-table
topic: Ventia
sector: Transport
source-context: asset_vision_ven_rms_new
source-catalog: ext_mssql_asset_vision_ven_rms_new
source-schema: dbo
table-name: custommoduleitem
full-name: ext_mssql_asset_vision_ven_rms_new.dbo.custommoduleitem
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, source-table, databricks, asset-vision-ven-rms-new]
---

# Transport Source Table - asset_vision_ven_rms_new - custommoduleitem

## Identity

| Field | Value |
|---|---|
| Table name | `custommoduleitem` |
| Full name | `ext_mssql_asset_vision_ven_rms_new.dbo.custommoduleitem` |
| Catalog | `ext_mssql_asset_vision_ven_rms_new` |
| Schema | `dbo` |
| Source context | `asset_vision_ven_rms_new` |
| Table type | FOREIGN |
| Column count | 10 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | forms / modules |
| Source system | Asset Vision |
| Source catalog | `ext_mssql_asset_vision_ven_rms_new` |
| Source schema | `dbo` |
| Source context | `asset_vision_ven_rms_new` |
| Owner/SME | kale.skinner@ventia.com |
| Refresh/freshness | Created: 2025-12-09T22:03:24.313Z; Last altered: 2026-06-02T01:04:27.939Z |
| Source details | Data source format: SQLSERVER_FORMAT |
| Caveats/open questions | Preserve `dbo` as source schema metadata; do not treat it as a client or contract. |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `ID` | `int` | Yes |  |
| `DeltaUTC` | `timestamp` | Yes |  |
| `ModifiedUTC` | `timestamp` | Yes |  |
| `ModifiedUser` | `string` | Yes |  |
| `ModuleID` | `int` | Yes |  |
| `SourceTable` | `string` | Yes |  |
| `SourceTableID` | `int` | Yes |  |
| `SortOrder` | `int` | Yes |  |
| `Deleted` | `boolean` | Yes |  |
| `Ref_ModifiedUserID` | `int` | Yes |  |

## Related Pages

- [[Transport Source Tables - asset_vision_ven_rms_new]]
- [[Transport Data Tables]]
- [[Asset Vision]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
