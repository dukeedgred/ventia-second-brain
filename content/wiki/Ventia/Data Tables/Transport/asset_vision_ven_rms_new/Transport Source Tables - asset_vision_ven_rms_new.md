---
type: source-table-catalog
topic: Ventia
sector: Transport
source-context: asset_vision_ven_rms_new
source-catalog: ext_mssql_asset_vision_ven_rms_new
source-schema: dbo
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-tables, source-context, asset-vision-ven-rms-new]
---

# Transport Source Tables - asset_vision_ven_rms_new

This page catalogs table documentation for the `asset_vision_ven_rms_new` Transport source context. Generic source schemas such as `dbo` are source metadata and are not treated as client or contract names.

## Source Context

| Field | Value |
|---|---|
| Source system | Asset Vision |
| Source catalog | `ext_mssql_asset_vision_ven_rms_new` |
| Source schema | `dbo` |
| Notes | Source catalog supplied as `ext_mssql_asset_vision_ven_rms_new`; SQL Server schema is `dbo`; no source-system comment was supplied in the earlier source-system inventory |

## Table Index

| Table | Full name | Type | Columns | Domain | Purpose |
|---|---|---|---:|---|---|
| [[Transport Source Table - asset_vision_ven_rms_new - asset]] | `ext_mssql_asset_vision_ven_rms_new.dbo.asset` | FOREIGN | 55 | asset register / hierarchy |  |
| [[Transport Source Table - asset_vision_ven_rms_new - assetarea]] | `ext_mssql_asset_vision_ven_rms_new.dbo.assetarea` | FOREIGN | 12 | asset register / hierarchy |  |
| [[Transport Source Table - asset_vision_ven_rms_new - assetattribute]] | `ext_mssql_asset_vision_ven_rms_new.dbo.assetattribute` | FOREIGN | 12 | asset register / hierarchy |  |
| [[Transport Source Table - asset_vision_ven_rms_new - assetaudit]] | `ext_mssql_asset_vision_ven_rms_new.dbo.assetaudit` | FOREIGN | 0 | asset register / hierarchy |  |
| [[Transport Source Table - asset_vision_ven_rms_new - assetclassification]] | `ext_mssql_asset_vision_ven_rms_new.dbo.assetclassification` | FOREIGN | 0 | asset register / hierarchy |  |
| [[Transport Source Table - asset_vision_ven_rms_new - assethierarchy]] | `ext_mssql_asset_vision_ven_rms_new.dbo.assethierarchy` | FOREIGN | 0 | asset register / hierarchy |  |
| [[Transport Source Table - asset_vision_ven_rms_new - assetlocation]] | `ext_mssql_asset_vision_ven_rms_new.dbo.assetlocation` | FOREIGN | 0 | asset register / hierarchy |  |
| [[Transport Source Table - asset_vision_ven_rms_new - assetvaluation]] | `ext_mssql_asset_vision_ven_rms_new.dbo.assetvaluation` | FOREIGN | 0 | asset register / hierarchy |  |
| [[Transport Source Table - asset_vision_ven_rms_new - capitalwork]] | `ext_mssql_asset_vision_ven_rms_new.dbo.capitalwork` | FOREIGN | 35 | capital works / forward works |  |
| [[Transport Source Table - asset_vision_ven_rms_new - capitalworktask]] | `ext_mssql_asset_vision_ven_rms_new.dbo.capitalworktask` | FOREIGN | 0 | capital works / forward works |  |
| [[Transport Source Table - asset_vision_ven_rms_new - contractreference]] | `ext_mssql_asset_vision_ven_rms_new.dbo.contractreference` | FOREIGN | 0 | reference / mapping |  |
| [[Transport Source Table - asset_vision_ven_rms_new - custommoduleitem]] | `ext_mssql_asset_vision_ven_rms_new.dbo.custommoduleitem` | FOREIGN | 10 | forms / modules |  |
| [[Transport Source Table - asset_vision_ven_rms_new - exportdate]] | `ext_mssql_asset_vision_ven_rms_new.dbo.exportdate` | FOREIGN | 0 | reference / mapping |  |
| [[Transport Source Table - asset_vision_ven_rms_new - exportdatelog]] | `ext_mssql_asset_vision_ven_rms_new.dbo.exportdatelog` | FOREIGN | 0 | reference / mapping |  |
| [[Transport Source Table - asset_vision_ven_rms_new - formfield]] | `ext_mssql_asset_vision_ven_rms_new.dbo.formfield` | FOREIGN | 15 | forms / modules |  |
| [[Transport Source Table - asset_vision_ven_rms_new - inspection]] | `ext_mssql_asset_vision_ven_rms_new.dbo.inspection` | FOREIGN | 62 | inspection / audit / condition |  |
| [[Transport Source Table - asset_vision_ven_rms_new - inspectionrelationship]] | `ext_mssql_asset_vision_ven_rms_new.dbo.inspectionrelationship` | FOREIGN | 0 | inspection / audit / condition |  |
| [[Transport Source Table - asset_vision_ven_rms_new - inspectionstatus]] | `ext_mssql_asset_vision_ven_rms_new.dbo.inspectionstatus` | FOREIGN | 10 | inspection / audit / condition |  |
| [[Transport Source Table - asset_vision_ven_rms_new - job]] | `ext_mssql_asset_vision_ven_rms_new.dbo.job` | FOREIGN | 105 | jobs / work orders |  |
| [[Transport Source Table - asset_vision_ven_rms_new - jobasset]] | `ext_mssql_asset_vision_ven_rms_new.dbo.jobasset` | FOREIGN | 0 | jobs / work orders |  |
| [[Transport Source Table - asset_vision_ven_rms_new - jobcomment]] | `ext_mssql_asset_vision_ven_rms_new.dbo.jobcomment` | FOREIGN | 8 | jobs / work orders |  |
| [[Transport Source Table - asset_vision_ven_rms_new - log]] | `ext_mssql_asset_vision_ven_rms_new.dbo.log` | FOREIGN | 0 |  |  |
| [[Transport Source Table - asset_vision_ven_rms_new - module]] | `ext_mssql_asset_vision_ven_rms_new.dbo.module` | FOREIGN | 36 | forms / modules |  |
| [[Transport Source Table - asset_vision_ven_rms_new - photo]] | `ext_mssql_asset_vision_ven_rms_new.dbo.photo` | FOREIGN | 12 | documents / evidence |  |
| [[Transport Source Table - asset_vision_ven_rms_new - plannedresourceitem]] | `ext_mssql_asset_vision_ven_rms_new.dbo.plannedresourceitem` | FOREIGN | 30 | resources / timesheets |  |
| [[Transport Source Table - asset_vision_ven_rms_new - resource]] | `ext_mssql_asset_vision_ven_rms_new.dbo.resource` | FOREIGN | 0 | resources / timesheets |  |
| [[Transport Source Table - asset_vision_ven_rms_new - resourceattribute]] | `ext_mssql_asset_vision_ven_rms_new.dbo.resourceattribute` | FOREIGN | 0 | resources / timesheets |  |
| [[Transport Source Table - asset_vision_ven_rms_new - resourceaudit]] | `ext_mssql_asset_vision_ven_rms_new.dbo.resourceaudit` | FOREIGN | 0 | inspection / audit / condition |  |
| [[Transport Source Table - asset_vision_ven_rms_new - summarycheck]] | `ext_mssql_asset_vision_ven_rms_new.dbo.summarycheck` | FOREIGN | 0 |  |  |
| [[Transport Source Table - asset_vision_ven_rms_new - timesheetitem]] | `ext_mssql_asset_vision_ven_rms_new.dbo.timesheetitem` | FOREIGN | 30 | resources / timesheets |  |
| [[Transport Source Table - asset_vision_ven_rms_new - vassetaudit]] | `ext_mssql_asset_vision_ven_rms_new.dbo.vassetaudit` | FOREIGN | 0 | asset register / hierarchy |  |
| [[Transport Source Table - asset_vision_ven_rms_new - vassetlocation]] | `ext_mssql_asset_vision_ven_rms_new.dbo.vassetlocation` | FOREIGN | 12 | asset register / hierarchy |  |
| [[Transport Source Table - asset_vision_ven_rms_new - vcapitalwork]] | `ext_mssql_asset_vision_ven_rms_new.dbo.vcapitalwork` | FOREIGN | 0 | capital works / forward works |  |
| [[Transport Source Table - asset_vision_ven_rms_new - vcapitalworktask]] | `ext_mssql_asset_vision_ven_rms_new.dbo.vcapitalworktask` | FOREIGN | 0 | capital works / forward works |  |
| [[Transport Source Table - asset_vision_ven_rms_new - vinspection]] | `ext_mssql_asset_vision_ven_rms_new.dbo.vinspection` | FOREIGN | 63 | inspection / audit / condition |  |
| [[Transport Source Table - asset_vision_ven_rms_new - vinspectionstatus]] | `ext_mssql_asset_vision_ven_rms_new.dbo.vinspectionstatus` | FOREIGN | 0 | inspection / audit / condition |  |
| [[Transport Source Table - asset_vision_ven_rms_new - vjob]] | `ext_mssql_asset_vision_ven_rms_new.dbo.vjob` | FOREIGN | 106 | jobs / work orders |  |
| [[Transport Source Table - asset_vision_ven_rms_new - vmodule]] | `ext_mssql_asset_vision_ven_rms_new.dbo.vmodule` | FOREIGN | 37 | forms / modules |  |
| [[Transport Source Table - asset_vision_ven_rms_new - vworkflowstatus]] | `ext_mssql_asset_vision_ven_rms_new.dbo.vworkflowstatus` | FOREIGN | 0 | workflow / status |  |
| [[Transport Source Table - asset_vision_ven_rms_new - workflowstatus]] | `ext_mssql_asset_vision_ven_rms_new.dbo.workflowstatus` | FOREIGN | 17 | workflow / status |  |

## Related Pages

- [[Transport Data Tables]]
- [[Asset Vision]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
