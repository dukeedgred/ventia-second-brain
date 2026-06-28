---
type: source-table-catalog
topic: Ventia
sector: Transport
source-context: asset_vision_ven_vicroads
source-catalog: ext_mssql_asset_vision_ven_vicroads
source-schema: dbo
date-created: 2026-06-05
date-updated: 2026-06-09
tags: [transport, data-tables, source-context, asset-vision-ven-vicroads]
---

# Transport Source Tables - asset_vision_ven_vicroads

This page catalogs table documentation for the `asset_vision_ven_vicroads` Transport source context. Generic source schemas such as `dbo` are source metadata and are not treated as client or contract names.

## Source Context

| Field | Value |
|---|---|
| Source system | Asset Vision |
| Source catalog | `ext_mssql_asset_vision_ven_vicroads` |
| Source schema | `dbo` |
| Notes | Source catalog supplied as `ext_mssql_asset_vision_ven_vicroads`; SQL Server schema is `dbo`; supplied source-system comment maps this Asset Vision work management and asset data to WRU |

## Table Index

| Table | Full name | Type | Columns | Domain | Purpose |
|---|---|---|---:|---|---|
| [[Transport Source Table - asset_vision_ven_vicroads - asset]] | `ext_mssql_asset_vision_ven_vicroads.dbo.asset` | FOREIGN | 35 | asset register / hierarchy |  |
| [[Transport Source Table - asset_vision_ven_vicroads - assetarea]] | `ext_mssql_asset_vision_ven_vicroads.dbo.assetarea` | FOREIGN | 11 | asset register / hierarchy |  |
| [[Transport Source Table - asset_vision_ven_vicroads - assetattribute]] | `ext_mssql_asset_vision_ven_vicroads.dbo.assetattribute` | FOREIGN | 9 | asset register / hierarchy |  |
| [[Transport Source Table - asset_vision_ven_vicroads - assetaudit]] | `ext_mssql_asset_vision_ven_vicroads.dbo.assetaudit` | FOREIGN | 11 | asset register / hierarchy |  |
| [[Transport Source Table - asset_vision_ven_vicroads - assetclassification]] | `ext_mssql_asset_vision_ven_vicroads.dbo.assetclassification` | FOREIGN | 12 | asset register / hierarchy |  |
| [[Transport Source Table - asset_vision_ven_vicroads - assetlocation]] | `ext_mssql_asset_vision_ven_vicroads.dbo.assetlocation` | FOREIGN | 10 | asset register / hierarchy |  |
| [[Transport Source Table - asset_vision_ven_vicroads - capitalwork]] | `ext_mssql_asset_vision_ven_vicroads.dbo.capitalwork` | FOREIGN | 28 | capital works / forward works |  |
| [[Transport Source Table - asset_vision_ven_vicroads - capitalworktask]] | `ext_mssql_asset_vision_ven_vicroads.dbo.capitalworktask` | FOREIGN | 32 | capital works / forward works |  |
| [[Transport Source Table - asset_vision_ven_vicroads - contractreference]] | `ext_mssql_asset_vision_ven_vicroads.dbo.contractreference` | FOREIGN | 15 | reference / mapping |  |
| [[Transport Source Table - asset_vision_ven_vicroads - custommoduleitem]] | `ext_mssql_asset_vision_ven_vicroads.dbo.custommoduleitem` | FOREIGN | 9 | forms / modules |  |
| [[Transport Source Table - asset_vision_ven_vicroads - exportdate]] | `ext_mssql_asset_vision_ven_vicroads.dbo.exportdate` | FOREIGN | 4 | reference / mapping |  |
| [[Transport Source Table - asset_vision_ven_vicroads - exportdatelog]] | `ext_mssql_asset_vision_ven_vicroads.dbo.exportdatelog` | FOREIGN | 5 | reference / mapping |  |
| [[Transport Source Table - asset_vision_ven_vicroads - formfield]] | `ext_mssql_asset_vision_ven_vicroads.dbo.formfield` | FOREIGN | 13 | forms / modules |  |
| [[Transport Source Table - asset_vision_ven_vicroads - inspection]] | `ext_mssql_asset_vision_ven_vicroads.dbo.inspection` | FOREIGN | 49 | inspection / audit / condition |  |
| [[Transport Source Table - asset_vision_ven_vicroads - inspectionrelationship]] | `ext_mssql_asset_vision_ven_vicroads.dbo.inspectionrelationship` | FOREIGN | 8 | inspection / audit / condition |  |
| [[Transport Source Table - asset_vision_ven_vicroads - inspectionstatus]] | `ext_mssql_asset_vision_ven_vicroads.dbo.inspectionstatus` | FOREIGN | 9 | inspection / audit / condition |  |
| [[Transport Source Table - asset_vision_ven_vicroads - job]] | `ext_mssql_asset_vision_ven_vicroads.dbo.job` | FOREIGN | 84 | jobs / work orders |  |
| [[Transport Source Table - asset_vision_ven_vicroads - jobasset]] | `ext_mssql_asset_vision_ven_vicroads.dbo.jobasset` | FOREIGN | 11 | jobs / work orders |  |
| [[Transport Source Table - asset_vision_ven_vicroads - jobcomment]] | `ext_mssql_asset_vision_ven_vicroads.dbo.jobcomment` | FOREIGN | 7 | jobs / work orders |  |
| [[Transport Source Table - asset_vision_ven_vicroads - laneaccess]] | `ext_mssql_asset_vision_ven_vicroads.dbo.laneaccess` | FOREIGN | 56 | lane access |  |
| [[Transport Source Table - asset_vision_ven_vicroads - log]] | `ext_mssql_asset_vision_ven_vicroads.dbo.log` | FOREIGN | 4 |  |  |
| [[Transport Source Table - asset_vision_ven_vicroads - module]] | `ext_mssql_asset_vision_ven_vicroads.dbo.module` | FOREIGN | 28 | forms / modules |  |
| [[Transport Source Table - asset_vision_ven_vicroads - photo]] | `ext_mssql_asset_vision_ven_vicroads.dbo.photo` | FOREIGN | 11 | documents / evidence |  |
| [[Transport Source Table - asset_vision_ven_vicroads - plannedresourceitem]] | `ext_mssql_asset_vision_ven_vicroads.dbo.plannedresourceitem` | FOREIGN | 24 | resources / timesheets |  |
| [[Transport Source Table - asset_vision_ven_vicroads - resource]] | `ext_mssql_asset_vision_ven_vicroads.dbo.resource` | FOREIGN | 21 | resources / timesheets |  |
| [[Transport Source Table - asset_vision_ven_vicroads - resourceattribute]] | `ext_mssql_asset_vision_ven_vicroads.dbo.resourceattribute` | FOREIGN | 9 | resources / timesheets |  |
| [[Transport Source Table - asset_vision_ven_vicroads - resourceaudit]] | `ext_mssql_asset_vision_ven_vicroads.dbo.resourceaudit` | FOREIGN | 9 | inspection / audit / condition |  |
| [[Transport Source Table - asset_vision_ven_vicroads - sqlserverversions]] | `ext_mssql_asset_vision_ven_vicroads.dbo.sqlserverversions` | FOREIGN | 9 |  |  |
| [[Transport Source Table - asset_vision_ven_vicroads - summarycheck]] | `ext_mssql_asset_vision_ven_vicroads.dbo.summarycheck` | FOREIGN | 8 |  |  |
| [[Transport Source Table - asset_vision_ven_vicroads - timesheetitem]] | `ext_mssql_asset_vision_ven_vicroads.dbo.timesheetitem` | FOREIGN | 24 | resources / timesheets |  |
| [[Transport Source Table - asset_vision_ven_vicroads - vassetaudit]] | `ext_mssql_asset_vision_ven_vicroads.dbo.vassetaudit` | FOREIGN | 12 | asset register / hierarchy |  |
| [[Transport Source Table - asset_vision_ven_vicroads - vassetlocation]] | `ext_mssql_asset_vision_ven_vicroads.dbo.vassetlocation` | FOREIGN | 11 | asset register / hierarchy |  |
| [[Transport Source Table - asset_vision_ven_vicroads - vcapitalwork]] | `ext_mssql_asset_vision_ven_vicroads.dbo.vcapitalwork` | FOREIGN | 29 | capital works / forward works |  |
| [[Transport Source Table - asset_vision_ven_vicroads - vcapitalworktask]] | `ext_mssql_asset_vision_ven_vicroads.dbo.vcapitalworktask` | FOREIGN | 33 | capital works / forward works |  |
| [[Transport Source Table - asset_vision_ven_vicroads - vinspection]] | `ext_mssql_asset_vision_ven_vicroads.dbo.vinspection` | FOREIGN | 50 | inspection / audit / condition |  |
| [[Transport Source Table - asset_vision_ven_vicroads - vinspectionstatus]] | `ext_mssql_asset_vision_ven_vicroads.dbo.vinspectionstatus` | FOREIGN | 10 | inspection / audit / condition |  |
| [[Transport Source Table - asset_vision_ven_vicroads - vjob]] | `ext_mssql_asset_vision_ven_vicroads.dbo.vjob` | FOREIGN | 85 | jobs / work orders |  |
| [[Transport Source Table - asset_vision_ven_vicroads - vmodule]] | `ext_mssql_asset_vision_ven_vicroads.dbo.vmodule` | FOREIGN | 29 | forms / modules |  |
| [[Transport Source Table - asset_vision_ven_vicroads - vworkflowstatus]] | `ext_mssql_asset_vision_ven_vicroads.dbo.vworkflowstatus` | FOREIGN | 15 | workflow / status |  |
| [[Transport Source Table - asset_vision_ven_vicroads - workflowstatus]] | `ext_mssql_asset_vision_ven_vicroads.dbo.workflowstatus` | FOREIGN | 14 | workflow / status |  |

## Related Pages

- [[Transport Data Tables]]
- [[Asset Vision]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
