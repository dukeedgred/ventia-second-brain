---
type: source-table-catalog
topic: Ventia
sector: Transport
source-context: asset_vision_vsm_gen7
source-catalog: ext_mssql_asset_vision_vsm_gen7
source-schema: dbo
date-created: 2026-06-05
date-updated: 2026-06-09
tags: [transport, data-tables, source-context, asset-vision-vsm-gen7]
---

# Transport Source Tables - asset_vision_vsm_gen7

This page catalogs table documentation for the `asset_vision_vsm_gen7` Transport source context. Generic source schemas such as `dbo` are source metadata and are not treated as client or contract names.

## Source Context

| Field | Value |
|---|---|
| Source system | Asset Vision |
| Source catalog | `ext_mssql_asset_vision_vsm_gen7` |
| Source schema | `dbo` |
| Notes | Source catalog supplied as `ext_mssql_asset_vision_vsm_gen7`; SQL Server schema is `dbo`; supplied source-system comment maps this Asset Vision work management and asset data to VentureSmart |

## Table Index

| Table | Full name | Type | Columns | Domain | Purpose |
|---|---|---|---:|---|---|
| [[Transport Source Table - asset_vision_vsm_gen7 - asset]] | `ext_mssql_asset_vision_vsm_gen7.dbo.asset` | FOREIGN | 35 | asset register / hierarchy |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - assetarea]] | `ext_mssql_asset_vision_vsm_gen7.dbo.assetarea` | FOREIGN | 11 | asset register / hierarchy |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - assetattribute]] | `ext_mssql_asset_vision_vsm_gen7.dbo.assetattribute` | FOREIGN | 9 | asset register / hierarchy |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - assetaudit]] | `ext_mssql_asset_vision_vsm_gen7.dbo.assetaudit` | FOREIGN | 11 | asset register / hierarchy |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - assetclassification]] | `ext_mssql_asset_vision_vsm_gen7.dbo.assetclassification` | FOREIGN | 12 | asset register / hierarchy |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - assetlocation]] | `ext_mssql_asset_vision_vsm_gen7.dbo.assetlocation` | FOREIGN | 10 | asset register / hierarchy |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - capitalwork]] | `ext_mssql_asset_vision_vsm_gen7.dbo.capitalwork` | FOREIGN | 28 | capital works / forward works |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - capitalworktask]] | `ext_mssql_asset_vision_vsm_gen7.dbo.capitalworktask` | FOREIGN | 32 | capital works / forward works |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - contractreference]] | `ext_mssql_asset_vision_vsm_gen7.dbo.contractreference` | FOREIGN | 15 | reference / mapping |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - custommoduleitem]] | `ext_mssql_asset_vision_vsm_gen7.dbo.custommoduleitem` | FOREIGN | 9 | forms / modules |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - exportdate]] | `ext_mssql_asset_vision_vsm_gen7.dbo.exportdate` | FOREIGN | 4 | reference / mapping |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - exportdatelog]] | `ext_mssql_asset_vision_vsm_gen7.dbo.exportdatelog` | FOREIGN | 5 | reference / mapping |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - formfield]] | `ext_mssql_asset_vision_vsm_gen7.dbo.formfield` | FOREIGN | 13 | forms / modules |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - inspection]] | `ext_mssql_asset_vision_vsm_gen7.dbo.inspection` | FOREIGN | 49 | inspection / audit / condition |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - inspectionrelationship]] | `ext_mssql_asset_vision_vsm_gen7.dbo.inspectionrelationship` | FOREIGN | 8 | inspection / audit / condition |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - inspectionstatus]] | `ext_mssql_asset_vision_vsm_gen7.dbo.inspectionstatus` | FOREIGN | 9 | inspection / audit / condition |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - job]] | `ext_mssql_asset_vision_vsm_gen7.dbo.job` | FOREIGN | 84 | jobs / work orders |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - jobasset]] | `ext_mssql_asset_vision_vsm_gen7.dbo.jobasset` | FOREIGN | 11 | jobs / work orders |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - jobcomment]] | `ext_mssql_asset_vision_vsm_gen7.dbo.jobcomment` | FOREIGN | 7 | jobs / work orders |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - log]] | `ext_mssql_asset_vision_vsm_gen7.dbo.log` | FOREIGN | 4 |  |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - module]] | `ext_mssql_asset_vision_vsm_gen7.dbo.module` | FOREIGN | 28 | forms / modules |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - photo]] | `ext_mssql_asset_vision_vsm_gen7.dbo.photo` | FOREIGN | 11 | documents / evidence |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - plannedresourceitem]] | `ext_mssql_asset_vision_vsm_gen7.dbo.plannedresourceitem` | FOREIGN | 24 | resources / timesheets |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - resource]] | `ext_mssql_asset_vision_vsm_gen7.dbo.resource` | FOREIGN | 21 | resources / timesheets |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - resourceattribute]] | `ext_mssql_asset_vision_vsm_gen7.dbo.resourceattribute` | FOREIGN | 9 | resources / timesheets |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - resourceaudit]] | `ext_mssql_asset_vision_vsm_gen7.dbo.resourceaudit` | FOREIGN | 9 | inspection / audit / condition |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - summarycheck]] | `ext_mssql_asset_vision_vsm_gen7.dbo.summarycheck` | FOREIGN | 8 |  |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - timesheetitem]] | `ext_mssql_asset_vision_vsm_gen7.dbo.timesheetitem` | FOREIGN | 24 | resources / timesheets |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - vassetaudit]] | `ext_mssql_asset_vision_vsm_gen7.dbo.vassetaudit` | FOREIGN | 12 | asset register / hierarchy |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - vassetlocation]] | `ext_mssql_asset_vision_vsm_gen7.dbo.vassetlocation` | FOREIGN | 11 | asset register / hierarchy |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - vcapitalwork]] | `ext_mssql_asset_vision_vsm_gen7.dbo.vcapitalwork` | FOREIGN | 29 | capital works / forward works |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - vcapitalworktask]] | `ext_mssql_asset_vision_vsm_gen7.dbo.vcapitalworktask` | FOREIGN | 33 | capital works / forward works |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - vinspection]] | `ext_mssql_asset_vision_vsm_gen7.dbo.vinspection` | FOREIGN | 50 | inspection / audit / condition |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - vinspectionstatus]] | `ext_mssql_asset_vision_vsm_gen7.dbo.vinspectionstatus` | FOREIGN | 10 | inspection / audit / condition |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - vjob]] | `ext_mssql_asset_vision_vsm_gen7.dbo.vjob` | FOREIGN | 85 | jobs / work orders |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - vmodule]] | `ext_mssql_asset_vision_vsm_gen7.dbo.vmodule` | FOREIGN | 29 | forms / modules |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - vworkflowstatus]] | `ext_mssql_asset_vision_vsm_gen7.dbo.vworkflowstatus` | FOREIGN | 15 | workflow / status |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - workflowstatus]] | `ext_mssql_asset_vision_vsm_gen7.dbo.workflowstatus` | FOREIGN | 14 | workflow / status |  |

## Related Pages

- [[Transport Data Tables]]
- [[Asset Vision]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
