---
type: source-table-catalog
topic: Ventia
sector: Transport
source-context: asset_vision_ven_rms_old
source-catalog: ext_mssql_asset_vision_ven_rms_old
source-schema: dbo
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-tables, source-table, asset-vision, asset-vision-ven-rms-old]
---

# Transport Source Tables - asset_vision_ven_rms_old

This page catalogs source table documentation for the supplied `ext_mssql_asset_vision_ven_rms_old` Asset Vision source catalog. The `dbo` component is the SQL Server source schema, not a Transport contractor or client name.

## Source Context

| Field | Value |
|---|---|
| Source context | `asset_vision_ven_rms_old` |
| Source catalog | `ext_mssql_asset_vision_ven_rms_old` |
| Source schema | `dbo` |
| Source system | Asset Vision |
| Client/contract mapping | Catalog name includes `ven_rms_old`, which may be a legacy RMS context. Confirm from source notes, view filters, `Contract` values, or validated naming conventions; do not infer it from `dbo`. |

## Table Index

| Table | Full name | Type | Columns | Domain | Purpose |
|---|---|---|---:|---|---|
| [[Transport Source Table - asset_vision_ven_rms_old - asset]] | `ext_mssql_asset_vision_ven_rms_old.dbo.asset` | FOREIGN | 35 | asset |  |
| [[Transport Source Table - asset_vision_ven_rms_old - assetarea]] | `ext_mssql_asset_vision_ven_rms_old.dbo.assetarea` | FOREIGN | 11 | asset |  |
| [[Transport Source Table - asset_vision_ven_rms_old - assetattribute]] | `ext_mssql_asset_vision_ven_rms_old.dbo.assetattribute` | FOREIGN | 9 | asset |  |
| [[Transport Source Table - asset_vision_ven_rms_old - assetaudit]] | `ext_mssql_asset_vision_ven_rms_old.dbo.assetaudit` | FOREIGN | 11 | asset audit |  |
| [[Transport Source Table - asset_vision_ven_rms_old - assetclassification]] | `ext_mssql_asset_vision_ven_rms_old.dbo.assetclassification` | FOREIGN | 12 | asset classification |  |
| [[Transport Source Table - asset_vision_ven_rms_old - assetlocation]] | `ext_mssql_asset_vision_ven_rms_old.dbo.assetlocation` | FOREIGN | 10 | asset location |  |
| [[Transport Source Table - asset_vision_ven_rms_old - capitalwork]] | `ext_mssql_asset_vision_ven_rms_old.dbo.capitalwork` | FOREIGN | 28 | capital work |  |
| [[Transport Source Table - asset_vision_ven_rms_old - vmodule]] | `ext_mssql_asset_vision_ven_rms_old.dbo.vmodule` | FOREIGN | 29 | module |  |
| [[Transport Source Table - asset_vision_ven_rms_old - vworkflowstatus]] | `ext_mssql_asset_vision_ven_rms_old.dbo.vworkflowstatus` | FOREIGN | 15 | workflow status |  |
| [[Transport Source Table - asset_vision_ven_rms_old - workflowstatus]] | `ext_mssql_asset_vision_ven_rms_old.dbo.workflowstatus` | FOREIGN | 14 | workflow status |  |

## Skipped Or Incomplete Inputs

- `capitalworktask` was visible in the pasted source-table payload but the object was truncated before complete columns could be verified, so it has not been documented yet.
- At least one intervening source-table object between `capitalworktask` and `vmodule` was hidden or visible only as a truncated tail, so it has not been documented yet.

## Related Pages

- [[Transport Data Tables]]
- [[Asset Vision]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]



