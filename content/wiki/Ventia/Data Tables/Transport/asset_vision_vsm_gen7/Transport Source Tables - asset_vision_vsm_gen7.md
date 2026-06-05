---
type: source-table-catalog
topic: Ventia
sector: Transport
source-context: asset_vision_vsm_gen7
source-catalog: ext_mssql_asset_vision_vsm_gen7
source-schema: dbo
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-tables, source-table, asset-vision, asset-vision-vsm-gen7]
---

# Transport Source Tables - asset_vision_vsm_gen7

This page catalogs source table documentation for the supplied `ext_mssql_asset_vision_vsm_gen7` Asset Vision source catalog. The `dbo` component is the SQL Server source schema, not a Transport contractor or client name.

## Source Context

| Field | Value |
|---|---|
| Source context | `asset_vision_vsm_gen7` |
| Source catalog | `ext_mssql_asset_vision_vsm_gen7` |
| Source schema | `dbo` |
| Source system | Asset Vision |
| Client/contract mapping | Catalog name includes `vsm_gen7`, which may be a source context or environment/version signal. Confirm from source notes, view filters, `Contract` values, or validated naming conventions; do not infer it from `dbo`. |

## Table Index

| Table | Full name | Type | Columns | Domain | Purpose |
|---|---|---|---:|---|---|
| [[Transport Source Table - asset_vision_vsm_gen7 - asset]] | `ext_mssql_asset_vision_vsm_gen7.dbo.asset` | FOREIGN | 35 | asset |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - assetarea]] | `ext_mssql_asset_vision_vsm_gen7.dbo.assetarea` | FOREIGN | 11 | asset |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - assetattribute]] | `ext_mssql_asset_vision_vsm_gen7.dbo.assetattribute` | FOREIGN | 9 | asset |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - assetaudit]] | `ext_mssql_asset_vision_vsm_gen7.dbo.assetaudit` | FOREIGN | 11 | asset audit |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - assetclassification]] | `ext_mssql_asset_vision_vsm_gen7.dbo.assetclassification` | FOREIGN | 12 | asset classification |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - assetlocation]] | `ext_mssql_asset_vision_vsm_gen7.dbo.assetlocation` | FOREIGN | 10 | asset location |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - capitalwork]] | `ext_mssql_asset_vision_vsm_gen7.dbo.capitalwork` | FOREIGN | 28 | capital work |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - capitalworktask]] | `ext_mssql_asset_vision_vsm_gen7.dbo.capitalworktask` | FOREIGN | 32 | capital work task |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - contractreference]] | `ext_mssql_asset_vision_vsm_gen7.dbo.contractreference` | FOREIGN | 15 | contract reference |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - custommoduleitem]] | `ext_mssql_asset_vision_vsm_gen7.dbo.custommoduleitem` | FOREIGN | 9 | module item |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - exportdate]] | `ext_mssql_asset_vision_vsm_gen7.dbo.exportdate` | FOREIGN | 4 | export tracking |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - exportdatelog]] | `ext_mssql_asset_vision_vsm_gen7.dbo.exportdatelog` | FOREIGN | 5 | export tracking |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - formfield]] | `ext_mssql_asset_vision_vsm_gen7.dbo.formfield` | FOREIGN | 13 | form metadata |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - inspection]] | `ext_mssql_asset_vision_vsm_gen7.dbo.inspection` | FOREIGN | 49 | inspection |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - inspectionrelationship]] | `ext_mssql_asset_vision_vsm_gen7.dbo.inspectionrelationship` | FOREIGN | 8 | inspection relationship |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - inspectionstatus]] | `ext_mssql_asset_vision_vsm_gen7.dbo.inspectionstatus` | FOREIGN | 9 | inspection status |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - job]] | `ext_mssql_asset_vision_vsm_gen7.dbo.job` | FOREIGN | 84 | job |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - jobasset]] | `ext_mssql_asset_vision_vsm_gen7.dbo.jobasset` | FOREIGN | 11 | job asset |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - jobcomment]] | `ext_mssql_asset_vision_vsm_gen7.dbo.jobcomment` | FOREIGN | 7 | job comment |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - log]] | `ext_mssql_asset_vision_vsm_gen7.dbo.log` | FOREIGN | 4 | log |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - module]] | `ext_mssql_asset_vision_vsm_gen7.dbo.module` | FOREIGN | 28 | module |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - photo]] | `ext_mssql_asset_vision_vsm_gen7.dbo.photo` | FOREIGN | 11 | photo |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - plannedresourceitem]] | `ext_mssql_asset_vision_vsm_gen7.dbo.plannedresourceitem` | FOREIGN | 24 | resource planning |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - resource]] | `ext_mssql_asset_vision_vsm_gen7.dbo.resource` | FOREIGN | 21 | resource |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - resourceattribute]] | `ext_mssql_asset_vision_vsm_gen7.dbo.resourceattribute` | FOREIGN | 9 | resource attribute |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - resourceaudit]] | `ext_mssql_asset_vision_vsm_gen7.dbo.resourceaudit` | FOREIGN | 9 | resource audit |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - summarycheck]] | `ext_mssql_asset_vision_vsm_gen7.dbo.summarycheck` | FOREIGN | 8 | summary check |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - timesheetitem]] | `ext_mssql_asset_vision_vsm_gen7.dbo.timesheetitem` | FOREIGN | 24 | timesheet |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - vassetaudit]] | `ext_mssql_asset_vision_vsm_gen7.dbo.vassetaudit` | FOREIGN | 12 | asset audit |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - vassetlocation]] | `ext_mssql_asset_vision_vsm_gen7.dbo.vassetlocation` | FOREIGN | 11 | asset location |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - vcapitalwork]] | `ext_mssql_asset_vision_vsm_gen7.dbo.vcapitalwork` | FOREIGN | 29 | capital work |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - vcapitalworktask]] | `ext_mssql_asset_vision_vsm_gen7.dbo.vcapitalworktask` | FOREIGN | 33 | capital work task |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - vinspection]] | `ext_mssql_asset_vision_vsm_gen7.dbo.vinspection` | FOREIGN | 50 | inspection |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - vinspectionstatus]] | `ext_mssql_asset_vision_vsm_gen7.dbo.vinspectionstatus` | FOREIGN | 10 | inspection status |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - vjob]] | `ext_mssql_asset_vision_vsm_gen7.dbo.vjob` | FOREIGN | 85 | job |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - vmodule]] | `ext_mssql_asset_vision_vsm_gen7.dbo.vmodule` | FOREIGN | 29 | module |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - vworkflowstatus]] | `ext_mssql_asset_vision_vsm_gen7.dbo.vworkflowstatus` | FOREIGN | 15 | workflow status |  |
| [[Transport Source Table - asset_vision_vsm_gen7 - workflowstatus]] | `ext_mssql_asset_vision_vsm_gen7.dbo.workflowstatus` | FOREIGN | 14 | workflow status |  |

## Related Pages

- [[Transport Data Tables]]
- [[Asset Vision]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]



