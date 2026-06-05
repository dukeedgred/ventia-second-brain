---
type: source-table-catalog
topic: Ventia
sector: Transport
source-context: asset_vision_ven_rms
source-catalog: ext_mssql_asset_vision_ven_rms
source-schema: dbo
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-tables, source-table, asset-vision, asset-vision-ven-rms]
---

# Transport Source Tables - asset_vision_ven_rms

This page catalogs source table documentation for the supplied `ext_mssql_asset_vision_ven_rms` Asset Vision source catalog. The `dbo` component is the SQL Server source schema, not a Transport contractor or client name.

## Source Context

| Field | Value |
|---|---|
| Source context | `asset_vision_ven_rms` |
| Source catalog | `ext_mssql_asset_vision_ven_rms` |
| Source schema | `dbo` |
| Source system | Asset Vision |
| Client/contract mapping | Catalog name includes `ven_rms`, which may be a source context or environment/version signal. Confirm from source notes, view filters, `Contract` values, or validated naming conventions; do not infer it from `dbo`. |

## Source Notes

- Some supplied table objects explicitly contained empty `columns: []` arrays; these are documented with column count `0` rather than treated as truncated input.

## Table Index

| Table | Full name | Type | Columns | Domain | Purpose |
|---|---|---|---:|---|---|
| [[Transport Source Table - asset_vision_ven_rms - asset]] | `ext_mssql_asset_vision_ven_rms.dbo.asset` | FOREIGN | 55 | asset |  |
| [[Transport Source Table - asset_vision_ven_rms - assetarea]] | `ext_mssql_asset_vision_ven_rms.dbo.assetarea` | FOREIGN | 12 | asset |  |
| [[Transport Source Table - asset_vision_ven_rms - assetattribute]] | `ext_mssql_asset_vision_ven_rms.dbo.assetattribute` | FOREIGN | 12 | asset |  |
| [[Transport Source Table - asset_vision_ven_rms - assetaudit]] | `ext_mssql_asset_vision_ven_rms.dbo.assetaudit` | FOREIGN | 0 | asset audit |  |
| [[Transport Source Table - asset_vision_ven_rms - assetclassification]] | `ext_mssql_asset_vision_ven_rms.dbo.assetclassification` | FOREIGN | 0 | asset classification |  |
| [[Transport Source Table - asset_vision_ven_rms - assethierarchy]] | `ext_mssql_asset_vision_ven_rms.dbo.assethierarchy` | FOREIGN | 0 | asset hierarchy |  |
| [[Transport Source Table - asset_vision_ven_rms - assetlocation]] | `ext_mssql_asset_vision_ven_rms.dbo.assetlocation` | FOREIGN | 0 | asset location |  |
| [[Transport Source Table - asset_vision_ven_rms - assetvaluation]] | `ext_mssql_asset_vision_ven_rms.dbo.assetvaluation` | FOREIGN | 0 | asset valuation |  |
| [[Transport Source Table - asset_vision_ven_rms - capitalwork]] | `ext_mssql_asset_vision_ven_rms.dbo.capitalwork` | FOREIGN | 35 | capital work |  |
| [[Transport Source Table - asset_vision_ven_rms - capitalworktask]] | `ext_mssql_asset_vision_ven_rms.dbo.capitalworktask` | FOREIGN | 0 | capital work task |  |
| [[Transport Source Table - asset_vision_ven_rms - contractreference]] | `ext_mssql_asset_vision_ven_rms.dbo.contractreference` | FOREIGN | 0 | contract reference |  |
| [[Transport Source Table - asset_vision_ven_rms - custommoduleitem]] | `ext_mssql_asset_vision_ven_rms.dbo.custommoduleitem` | FOREIGN | 10 | module item |  |
| [[Transport Source Table - asset_vision_ven_rms - exportdate]] | `ext_mssql_asset_vision_ven_rms.dbo.exportdate` | FOREIGN | 0 | export tracking |  |
| [[Transport Source Table - asset_vision_ven_rms - exportdatelog]] | `ext_mssql_asset_vision_ven_rms.dbo.exportdatelog` | FOREIGN | 0 | export tracking |  |
| [[Transport Source Table - asset_vision_ven_rms - formfield]] | `ext_mssql_asset_vision_ven_rms.dbo.formfield` | FOREIGN | 15 | form metadata |  |
| [[Transport Source Table - asset_vision_ven_rms - inspection]] | `ext_mssql_asset_vision_ven_rms.dbo.inspection` | FOREIGN | 62 | inspection |  |
| [[Transport Source Table - asset_vision_ven_rms - inspectionrelationship]] | `ext_mssql_asset_vision_ven_rms.dbo.inspectionrelationship` | FOREIGN | 0 | inspection relationship |  |
| [[Transport Source Table - asset_vision_ven_rms - inspectionstatus]] | `ext_mssql_asset_vision_ven_rms.dbo.inspectionstatus` | FOREIGN | 0 | inspection status |  |
| [[Transport Source Table - asset_vision_ven_rms - job]] | `ext_mssql_asset_vision_ven_rms.dbo.job` | FOREIGN | 105 | job |  |
| [[Transport Source Table - asset_vision_ven_rms - jobasset]] | `ext_mssql_asset_vision_ven_rms.dbo.jobasset` | FOREIGN | 0 | job asset |  |
| [[Transport Source Table - asset_vision_ven_rms - jobcomment]] | `ext_mssql_asset_vision_ven_rms.dbo.jobcomment` | FOREIGN | 8 | job comment |  |
| [[Transport Source Table - asset_vision_ven_rms - log]] | `ext_mssql_asset_vision_ven_rms.dbo.log` | FOREIGN | 0 | log |  |
| [[Transport Source Table - asset_vision_ven_rms - module]] | `ext_mssql_asset_vision_ven_rms.dbo.module` | FOREIGN | 36 | module |  |
| [[Transport Source Table - asset_vision_ven_rms - photo]] | `ext_mssql_asset_vision_ven_rms.dbo.photo` | FOREIGN | 12 | photo |  |
| [[Transport Source Table - asset_vision_ven_rms - plannedresourceitem]] | `ext_mssql_asset_vision_ven_rms.dbo.plannedresourceitem` | FOREIGN | 30 | resource planning |  |
| [[Transport Source Table - asset_vision_ven_rms - resource]] | `ext_mssql_asset_vision_ven_rms.dbo.resource` | FOREIGN | 0 | resource |  |
| [[Transport Source Table - asset_vision_ven_rms - resourceattribute]] | `ext_mssql_asset_vision_ven_rms.dbo.resourceattribute` | FOREIGN | 0 | resource attribute |  |
| [[Transport Source Table - asset_vision_ven_rms - resourceaudit]] | `ext_mssql_asset_vision_ven_rms.dbo.resourceaudit` | FOREIGN | 0 | resource audit |  |
| [[Transport Source Table - asset_vision_ven_rms - summarycheck]] | `ext_mssql_asset_vision_ven_rms.dbo.summarycheck` | FOREIGN | 0 | summary check |  |
| [[Transport Source Table - asset_vision_ven_rms - timesheetitem]] | `ext_mssql_asset_vision_ven_rms.dbo.timesheetitem` | FOREIGN | 30 | timesheet |  |
| [[Transport Source Table - asset_vision_ven_rms - vassetaudit]] | `ext_mssql_asset_vision_ven_rms.dbo.vassetaudit` | FOREIGN | 0 | asset audit |  |
| [[Transport Source Table - asset_vision_ven_rms - vassetlocation]] | `ext_mssql_asset_vision_ven_rms.dbo.vassetlocation` | FOREIGN | 12 | asset location |  |
| [[Transport Source Table - asset_vision_ven_rms - vcapitalwork]] | `ext_mssql_asset_vision_ven_rms.dbo.vcapitalwork` | FOREIGN | 0 | capital work |  |
| [[Transport Source Table - asset_vision_ven_rms - vcapitalworktask]] | `ext_mssql_asset_vision_ven_rms.dbo.vcapitalworktask` | FOREIGN | 0 | capital work task |  |
| [[Transport Source Table - asset_vision_ven_rms - vinspection]] | `ext_mssql_asset_vision_ven_rms.dbo.vinspection` | FOREIGN | 63 | inspection |  |
| [[Transport Source Table - asset_vision_ven_rms - vinspectionstatus]] | `ext_mssql_asset_vision_ven_rms.dbo.vinspectionstatus` | FOREIGN | 0 | inspection status |  |
| [[Transport Source Table - asset_vision_ven_rms - vjob]] | `ext_mssql_asset_vision_ven_rms.dbo.vjob` | FOREIGN | 106 | job |  |
| [[Transport Source Table - asset_vision_ven_rms - vmodule]] | `ext_mssql_asset_vision_ven_rms.dbo.vmodule` | FOREIGN | 37 | module |  |
| [[Transport Source Table - asset_vision_ven_rms - vworkflowstatus]] | `ext_mssql_asset_vision_ven_rms.dbo.vworkflowstatus` | FOREIGN | 0 | workflow status |  |
| [[Transport Source Table - asset_vision_ven_rms - workflowstatus]] | `ext_mssql_asset_vision_ven_rms.dbo.workflowstatus` | FOREIGN | 17 | workflow status |  |

## Related Pages

- [[Transport Data Tables]]
- [[Asset Vision]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]

