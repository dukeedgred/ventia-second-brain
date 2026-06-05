---
type: source-table-catalog
topic: Ventia
sector: Transport
source-context: asset_vision_ven_vicroads
source-catalog: ext_mssql_asset_vision_ven_vicroads
source-schema: dbo
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-tables, source-table, asset-vision, asset-vision-ven-vicroads]
---

# Transport Source Tables - asset_vision_ven_vicroads

This page catalogs source table documentation for the supplied `ext_mssql_asset_vision_ven_vicroads` Asset Vision source catalog. The `dbo` component is the SQL Server source schema, not a Transport contractor or client name.

## Source Context

| Field | Value |
|---|---|
| Source context | `asset_vision_ven_vicroads` |
| Source catalog | `ext_mssql_asset_vision_ven_vicroads` |
| Source schema | `dbo` |
| Source system | Asset Vision |
| Client/contract mapping | Catalog name includes `ven_vicroads`, which may be a client/contract, source context, or environment signal. Confirm from source notes, view filters, `Contract` values, or validated naming conventions; do not infer it from `dbo`. |

## Source Notes

- This refresh expands the supplied `ext_mssql_asset_vision_ven_vicroads.dbo` metadata from 10 previously documented source tables to 40 complete table objects, including job, resource, timesheet, lane-access, and WKT source-table variants.

## Table Index

| Table | Full name | Type | Columns | Domain | Purpose |
|---|---|---|---:|---|---|
| [[Transport Source Table - asset_vision_ven_vicroads - asset]] | `ext_mssql_asset_vision_ven_vicroads.dbo.asset` | FOREIGN | 35 | asset |  |
| [[Transport Source Table - asset_vision_ven_vicroads - assetarea]] | `ext_mssql_asset_vision_ven_vicroads.dbo.assetarea` | FOREIGN | 11 | asset |  |
| [[Transport Source Table - asset_vision_ven_vicroads - assetattribute]] | `ext_mssql_asset_vision_ven_vicroads.dbo.assetattribute` | FOREIGN | 9 | asset |  |
| [[Transport Source Table - asset_vision_ven_vicroads - assetaudit]] | `ext_mssql_asset_vision_ven_vicroads.dbo.assetaudit` | FOREIGN | 11 | asset audit |  |
| [[Transport Source Table - asset_vision_ven_vicroads - assetclassification]] | `ext_mssql_asset_vision_ven_vicroads.dbo.assetclassification` | FOREIGN | 12 | asset classification |  |
| [[Transport Source Table - asset_vision_ven_vicroads - assetlocation]] | `ext_mssql_asset_vision_ven_vicroads.dbo.assetlocation` | FOREIGN | 10 | asset location |  |
| [[Transport Source Table - asset_vision_ven_vicroads - capitalwork]] | `ext_mssql_asset_vision_ven_vicroads.dbo.capitalwork` | FOREIGN | 28 | capital work |  |
| [[Transport Source Table - asset_vision_ven_vicroads - capitalworktask]] | `ext_mssql_asset_vision_ven_vicroads.dbo.capitalworktask` | FOREIGN | 32 | capital work task |  |
| [[Transport Source Table - asset_vision_ven_vicroads - contractreference]] | `ext_mssql_asset_vision_ven_vicroads.dbo.contractreference` | FOREIGN | 15 | contract reference |  |
| [[Transport Source Table - asset_vision_ven_vicroads - custommoduleitem]] | `ext_mssql_asset_vision_ven_vicroads.dbo.custommoduleitem` | FOREIGN | 9 | module item |  |
| [[Transport Source Table - asset_vision_ven_vicroads - exportdate]] | `ext_mssql_asset_vision_ven_vicroads.dbo.exportdate` | FOREIGN | 4 | export tracking |  |
| [[Transport Source Table - asset_vision_ven_vicroads - exportdatelog]] | `ext_mssql_asset_vision_ven_vicroads.dbo.exportdatelog` | FOREIGN | 5 | export tracking |  |
| [[Transport Source Table - asset_vision_ven_vicroads - formfield]] | `ext_mssql_asset_vision_ven_vicroads.dbo.formfield` | FOREIGN | 13 | form metadata |  |
| [[Transport Source Table - asset_vision_ven_vicroads - inspection]] | `ext_mssql_asset_vision_ven_vicroads.dbo.inspection` | FOREIGN | 49 | inspection |  |
| [[Transport Source Table - asset_vision_ven_vicroads - inspectionrelationship]] | `ext_mssql_asset_vision_ven_vicroads.dbo.inspectionrelationship` | FOREIGN | 8 | inspection relationship |  |
| [[Transport Source Table - asset_vision_ven_vicroads - inspectionstatus]] | `ext_mssql_asset_vision_ven_vicroads.dbo.inspectionstatus` | FOREIGN | 9 | inspection status |  |
| [[Transport Source Table - asset_vision_ven_vicroads - job]] | `ext_mssql_asset_vision_ven_vicroads.dbo.job` | FOREIGN | 84 | job |  |
| [[Transport Source Table - asset_vision_ven_vicroads - jobasset]] | `ext_mssql_asset_vision_ven_vicroads.dbo.jobasset` | FOREIGN | 11 | job asset |  |
| [[Transport Source Table - asset_vision_ven_vicroads - jobcomment]] | `ext_mssql_asset_vision_ven_vicroads.dbo.jobcomment` | FOREIGN | 7 | job comment |  |
| [[Transport Source Table - asset_vision_ven_vicroads - laneaccess]] | `ext_mssql_asset_vision_ven_vicroads.dbo.laneaccess` | FOREIGN | 56 | lane access |  |
| [[Transport Source Table - asset_vision_ven_vicroads - log]] | `ext_mssql_asset_vision_ven_vicroads.dbo.log` | FOREIGN | 4 | log |  |
| [[Transport Source Table - asset_vision_ven_vicroads - module]] | `ext_mssql_asset_vision_ven_vicroads.dbo.module` | FOREIGN | 28 | module |  |
| [[Transport Source Table - asset_vision_ven_vicroads - photo]] | `ext_mssql_asset_vision_ven_vicroads.dbo.photo` | FOREIGN | 11 | photo |  |
| [[Transport Source Table - asset_vision_ven_vicroads - plannedresourceitem]] | `ext_mssql_asset_vision_ven_vicroads.dbo.plannedresourceitem` | FOREIGN | 24 | resource planning |  |
| [[Transport Source Table - asset_vision_ven_vicroads - resource]] | `ext_mssql_asset_vision_ven_vicroads.dbo.resource` | FOREIGN | 21 | resource |  |
| [[Transport Source Table - asset_vision_ven_vicroads - resourceattribute]] | `ext_mssql_asset_vision_ven_vicroads.dbo.resourceattribute` | FOREIGN | 9 | resource attribute |  |
| [[Transport Source Table - asset_vision_ven_vicroads - resourceaudit]] | `ext_mssql_asset_vision_ven_vicroads.dbo.resourceaudit` | FOREIGN | 9 | resource audit |  |
| [[Transport Source Table - asset_vision_ven_vicroads - sqlserverversions]] | `ext_mssql_asset_vision_ven_vicroads.dbo.sqlserverversions` | FOREIGN | 9 | SQL Server version |  |
| [[Transport Source Table - asset_vision_ven_vicroads - summarycheck]] | `ext_mssql_asset_vision_ven_vicroads.dbo.summarycheck` | FOREIGN | 8 | summary check |  |
| [[Transport Source Table - asset_vision_ven_vicroads - timesheetitem]] | `ext_mssql_asset_vision_ven_vicroads.dbo.timesheetitem` | FOREIGN | 24 | timesheet |  |
| [[Transport Source Table - asset_vision_ven_vicroads - vassetaudit]] | `ext_mssql_asset_vision_ven_vicroads.dbo.vassetaudit` | FOREIGN | 12 | asset audit |  |
| [[Transport Source Table - asset_vision_ven_vicroads - vassetlocation]] | `ext_mssql_asset_vision_ven_vicroads.dbo.vassetlocation` | FOREIGN | 11 | asset location |  |
| [[Transport Source Table - asset_vision_ven_vicroads - vcapitalwork]] | `ext_mssql_asset_vision_ven_vicroads.dbo.vcapitalwork` | FOREIGN | 29 | capital work |  |
| [[Transport Source Table - asset_vision_ven_vicroads - vcapitalworktask]] | `ext_mssql_asset_vision_ven_vicroads.dbo.vcapitalworktask` | FOREIGN | 33 | capital work task |  |
| [[Transport Source Table - asset_vision_ven_vicroads - vinspection]] | `ext_mssql_asset_vision_ven_vicroads.dbo.vinspection` | FOREIGN | 50 | inspection |  |
| [[Transport Source Table - asset_vision_ven_vicroads - vinspectionstatus]] | `ext_mssql_asset_vision_ven_vicroads.dbo.vinspectionstatus` | FOREIGN | 10 | inspection status |  |
| [[Transport Source Table - asset_vision_ven_vicroads - vjob]] | `ext_mssql_asset_vision_ven_vicroads.dbo.vjob` | FOREIGN | 85 | job |  |
| [[Transport Source Table - asset_vision_ven_vicroads - vmodule]] | `ext_mssql_asset_vision_ven_vicroads.dbo.vmodule` | FOREIGN | 29 | module |  |
| [[Transport Source Table - asset_vision_ven_vicroads - vworkflowstatus]] | `ext_mssql_asset_vision_ven_vicroads.dbo.vworkflowstatus` | FOREIGN | 15 | workflow status |  |
| [[Transport Source Table - asset_vision_ven_vicroads - workflowstatus]] | `ext_mssql_asset_vision_ven_vicroads.dbo.workflowstatus` | FOREIGN | 14 | workflow status |  |

## Related Pages

- [[Transport Data Tables]]
- [[Asset Vision]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]

