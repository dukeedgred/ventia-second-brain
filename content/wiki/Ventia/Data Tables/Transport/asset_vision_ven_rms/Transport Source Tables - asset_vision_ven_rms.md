---
type: source-table-catalog
topic: Ventia
sector: Transport
source-context: asset_vision_ven_rms
source-catalog: ext_mssql_asset_vision_ven_rms
source-schema: dbo
date-created: 2026-06-05
date-updated: 2026-06-09
tags: [transport, data-tables, source-context, asset-vision-ven-rms]
---

# Transport Source Tables - asset_vision_ven_rms

This page catalogs table documentation for the `asset_vision_ven_rms` Transport source context. Generic source schemas such as `dbo` are source metadata and are not treated as client or contract names.

## Source Context

| Field | Value |
|---|---|
| Source system | Asset Vision |
| Source catalog | `ext_mssql_asset_vision_ven_rms` |
| Source schema | `dbo` |
| Notes | Source catalog supplied as `ext_mssql_asset_vision_ven_rms`; SQL Server schema is `dbo`; no source-system comment was supplied in the 2026-06-09 inventory |

## Table Index

| Table | Full name | Type | Columns | Domain | Purpose |
|---|---|---|---:|---|---|
| [[Transport Source Table - asset_vision_ven_rms - asset]] | `ext_mssql_asset_vision_ven_rms.dbo.asset` | FOREIGN | 35 | asset register / hierarchy |  |
| [[Transport Source Table - asset_vision_ven_rms - assetarea]] | `ext_mssql_asset_vision_ven_rms.dbo.assetarea` | FOREIGN | 11 | asset register / hierarchy |  |
| [[Transport Source Table - asset_vision_ven_rms - assetattribute]] | `ext_mssql_asset_vision_ven_rms.dbo.assetattribute` | FOREIGN | 9 | asset register / hierarchy |  |
| [[Transport Source Table - asset_vision_ven_rms - assetaudit]] | `ext_mssql_asset_vision_ven_rms.dbo.assetaudit` | FOREIGN | 11 | asset register / hierarchy |  |
| [[Transport Source Table - asset_vision_ven_rms - assetclassification]] | `ext_mssql_asset_vision_ven_rms.dbo.assetclassification` | FOREIGN | 12 | asset register / hierarchy |  |
| [[Transport Source Table - asset_vision_ven_rms - assethierarchy]] | `ext_mssql_asset_vision_ven_rms.dbo.assethierarchy` | FOREIGN | 0 | asset hierarchy |  |
| [[Transport Source Table - asset_vision_ven_rms - assetlocation]] | `ext_mssql_asset_vision_ven_rms.dbo.assetlocation` | FOREIGN | 10 | asset register / hierarchy |  |
| [[Transport Source Table - asset_vision_ven_rms - assetvaluation]] | `ext_mssql_asset_vision_ven_rms.dbo.assetvaluation` | FOREIGN | 0 | asset valuation |  |
| [[Transport Source Table - asset_vision_ven_rms - capitalwork]] | `ext_mssql_asset_vision_ven_rms.dbo.capitalwork` | FOREIGN | 28 | capital works / forward works |  |
| [[Transport Source Table - asset_vision_ven_rms - capitalworktask]] | `ext_mssql_asset_vision_ven_rms.dbo.capitalworktask` | FOREIGN | 32 | capital works / forward works |  |
| [[Transport Source Table - asset_vision_ven_rms - contractreference]] | `ext_mssql_asset_vision_ven_rms.dbo.contractreference` | FOREIGN | 15 | reference / mapping |  |
| [[Transport Source Table - asset_vision_ven_rms - custommoduleitem]] | `ext_mssql_asset_vision_ven_rms.dbo.custommoduleitem` | FOREIGN | 9 | forms / modules |  |
| [[Transport Source Table - asset_vision_ven_rms - exportdate]] | `ext_mssql_asset_vision_ven_rms.dbo.exportdate` | FOREIGN | 4 | reference / mapping |  |
| [[Transport Source Table - asset_vision_ven_rms - exportdatelog]] | `ext_mssql_asset_vision_ven_rms.dbo.exportdatelog` | FOREIGN | 5 | reference / mapping |  |
| [[Transport Source Table - asset_vision_ven_rms - formfield]] | `ext_mssql_asset_vision_ven_rms.dbo.formfield` | FOREIGN | 13 | forms / modules |  |
| [[Transport Source Table - asset_vision_ven_rms - inspection]] | `ext_mssql_asset_vision_ven_rms.dbo.inspection` | FOREIGN | 49 | inspection / audit / condition |  |
| [[Transport Source Table - asset_vision_ven_rms - inspectionrelationship]] | `ext_mssql_asset_vision_ven_rms.dbo.inspectionrelationship` | FOREIGN | 8 | inspection / audit / condition |  |
| [[Transport Source Table - asset_vision_ven_rms - inspectionstatus]] | `ext_mssql_asset_vision_ven_rms.dbo.inspectionstatus` | FOREIGN | 9 | inspection / audit / condition |  |
| [[Transport Source Table - asset_vision_ven_rms - job]] | `ext_mssql_asset_vision_ven_rms.dbo.job` | FOREIGN | 84 | jobs / work orders |  |
| [[Transport Source Table - asset_vision_ven_rms - jobasset]] | `ext_mssql_asset_vision_ven_rms.dbo.jobasset` | FOREIGN | 11 | jobs / work orders |  |
| [[Transport Source Table - asset_vision_ven_rms - jobcomment]] | `ext_mssql_asset_vision_ven_rms.dbo.jobcomment` | FOREIGN | 7 | jobs / work orders |  |
| [[Transport Source Table - asset_vision_ven_rms - log]] | `ext_mssql_asset_vision_ven_rms.dbo.log` | FOREIGN | 4 |  |  |
| [[Transport Source Table - asset_vision_ven_rms - module]] | `ext_mssql_asset_vision_ven_rms.dbo.module` | FOREIGN | 28 | forms / modules |  |
| [[Transport Source Table - asset_vision_ven_rms - photo]] | `ext_mssql_asset_vision_ven_rms.dbo.photo` | FOREIGN | 11 | documents / evidence |  |
| [[Transport Source Table - asset_vision_ven_rms - plannedresourceitem]] | `ext_mssql_asset_vision_ven_rms.dbo.plannedresourceitem` | FOREIGN | 24 | resources / timesheets |  |
| [[Transport Source Table - asset_vision_ven_rms - resource]] | `ext_mssql_asset_vision_ven_rms.dbo.resource` | FOREIGN | 21 | resources / timesheets |  |
| [[Transport Source Table - asset_vision_ven_rms - resourceattribute]] | `ext_mssql_asset_vision_ven_rms.dbo.resourceattribute` | FOREIGN | 9 | resources / timesheets |  |
| [[Transport Source Table - asset_vision_ven_rms - resourceaudit]] | `ext_mssql_asset_vision_ven_rms.dbo.resourceaudit` | FOREIGN | 9 | inspection / audit / condition |  |
| [[Transport Source Table - asset_vision_ven_rms - summarycheck]] | `ext_mssql_asset_vision_ven_rms.dbo.summarycheck` | FOREIGN | 8 |  |  |
| [[Transport Source Table - asset_vision_ven_rms - timesheetitem]] | `ext_mssql_asset_vision_ven_rms.dbo.timesheetitem` | FOREIGN | 24 | resources / timesheets |  |
| [[Transport Source Table - asset_vision_ven_rms - vassetaudit]] | `ext_mssql_asset_vision_ven_rms.dbo.vassetaudit` | FOREIGN | 12 | asset register / hierarchy |  |
| [[Transport Source Table - asset_vision_ven_rms - vassetlocation]] | `ext_mssql_asset_vision_ven_rms.dbo.vassetlocation` | FOREIGN | 11 | asset register / hierarchy |  |
| [[Transport Source Table - asset_vision_ven_rms - vcapitalwork]] | `ext_mssql_asset_vision_ven_rms.dbo.vcapitalwork` | FOREIGN | 29 | capital works / forward works |  |
| [[Transport Source Table - asset_vision_ven_rms - vcapitalworktask]] | `ext_mssql_asset_vision_ven_rms.dbo.vcapitalworktask` | FOREIGN | 33 | capital works / forward works |  |
| [[Transport Source Table - asset_vision_ven_rms - vinspection]] | `ext_mssql_asset_vision_ven_rms.dbo.vinspection` | FOREIGN | 50 | inspection / audit / condition |  |
| [[Transport Source Table - asset_vision_ven_rms - vinspectionstatus]] | `ext_mssql_asset_vision_ven_rms.dbo.vinspectionstatus` | FOREIGN | 10 | inspection / audit / condition |  |
| [[Transport Source Table - asset_vision_ven_rms - vjob]] | `ext_mssql_asset_vision_ven_rms.dbo.vjob` | FOREIGN | 85 | jobs / work orders |  |
| [[Transport Source Table - asset_vision_ven_rms - vmodule]] | `ext_mssql_asset_vision_ven_rms.dbo.vmodule` | FOREIGN | 29 | forms / modules |  |
| [[Transport Source Table - asset_vision_ven_rms - vworkflowstatus]] | `ext_mssql_asset_vision_ven_rms.dbo.vworkflowstatus` | FOREIGN | 15 | workflow / status |  |
| [[Transport Source Table - asset_vision_ven_rms - workflowstatus]] | `ext_mssql_asset_vision_ven_rms.dbo.workflowstatus` | FOREIGN | 14 | workflow / status |  |

## Related Pages

- [[Transport Data Tables]]
- [[Asset Vision]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
