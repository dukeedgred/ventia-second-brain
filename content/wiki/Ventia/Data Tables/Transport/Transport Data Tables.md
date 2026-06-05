---
type: table-catalog
topic: Ventia
sector: Transport
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-tables, databricks]
---

# Transport Data Tables

This page catalogs known Transport sector table documentation. Contract-specific Transport schemas are treated as contract or contract-group contexts when supported by source evidence; raw source schemas such as SQL Server `dbo` are tracked as source contexts instead.

## Context Index

| Context | Tables | Notes |
|---|---:|---|
| [[Transport Source Tables - asset_vision_ven_gen7]] | 38 | Source catalog supplied as `ext_mssql_asset_vision_ven_gen7`; SQL Server schema is `dbo`; catalog name includes `ven_gen7`, but client/contract mapping should be confirmed |
| [[Transport Source Tables - asset_vision_ven_rms]] | 40 | Source catalog supplied as `ext_mssql_asset_vision_ven_rms`; SQL Server schema is `dbo`; catalog name includes `ven_rms`, but client/contract mapping should be confirmed; 22 supplied objects had empty `columns: []` arrays |
| [[Transport Source Tables - asset_vision_ven_rms_old]] | 10 | Source catalog supplied as `ext_mssql_asset_vision_ven_rms_old`; SQL Server schema is `dbo`; catalog name includes `ven_rms_old`, but client/contract mapping should be confirmed |
| [[Transport Source Tables - asset_vision_ven_vicroads]] | 40 | Source catalog supplied as `ext_mssql_asset_vision_ven_vicroads`; SQL Server schema is `dbo`; catalog name includes `ven_vicroads`, but client/contract mapping should be confirmed; expanded from 10 previously documented tables |
| [[Transport Source Tables - asset_vision_vns_gen7]] | 38 | Source catalog supplied as `ext_mssql_asset_vision_vns_gen7`; SQL Server schema is `dbo`; catalog name includes `vns_gen7`, but client/contract mapping should be confirmed |
| [[Transport Source Tables - asset_vision_vnz_gen7]] | 38 | Source catalog supplied as `ext_mssql_asset_vision_vnz_gen7`; SQL Server schema is `dbo`; catalog name includes `vnz_gen7`, but client/contract mapping should be confirmed |
| [[Transport Source Tables - asset_vision_vsm_gen7]] | 38 | Source catalog supplied as `ext_mssql_asset_vision_vsm_gen7`; SQL Server schema is `dbo`; catalog name includes `vsm_gen7`, but client/contract mapping should be confirmed |
| [[Transport Contract Tables - transport]] | 9 | Schema identifier supplied as `transport` |
| [[Transport Contract Tables - transport_aklw]] | 9 | Schema identifier supplied as `transport_aklw` |
| [[Transport Contract Tables - transport_fndc]] | 3 | Schema identifier supplied as `transport_fndc` |
| [[Transport Contract Tables - transport_nel]] | 4 | Schema identifier supplied as `transport_nel` |
| [[Transport Contract Tables - transport_ramc]] | 9 | Schema identifier supplied as `transport_ramc` |
| [[Transport Contract Tables - transport_sht]] | 22 | Schema identifier supplied as `transport_sht` |
| [[Transport Contract Tables - transport_srapc]] | 6 | Schema identifier supplied as `transport_srapc` |
| [[Transport Contract Tables - transport_tsrc]] | 8 | Schema identifier supplied as `transport_tsrc` |
| [[Transport Contract Tables - transport_wru]] | 10 | Schema identifier supplied as `transport_wru` |

## Table Index

| Context | Table | Full name | Type | Columns | Domain | Purpose |
|---|---|---|---|---:|---|---|
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - asset]] | `ext_mssql_asset_vision_ven_gen7.dbo.asset` | FOREIGN | 35 | asset |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - assetarea]] | `ext_mssql_asset_vision_ven_gen7.dbo.assetarea` | FOREIGN | 11 | asset |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - assetattribute]] | `ext_mssql_asset_vision_ven_gen7.dbo.assetattribute` | FOREIGN | 9 | asset |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - assetaudit]] | `ext_mssql_asset_vision_ven_gen7.dbo.assetaudit` | FOREIGN | 11 | asset audit |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - assetclassification]] | `ext_mssql_asset_vision_ven_gen7.dbo.assetclassification` | FOREIGN | 12 | asset classification |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - assetlocation]] | `ext_mssql_asset_vision_ven_gen7.dbo.assetlocation` | FOREIGN | 10 | asset location |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - capitalwork]] | `ext_mssql_asset_vision_ven_gen7.dbo.capitalwork` | FOREIGN | 28 | capital work |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - capitalworktask]] | `ext_mssql_asset_vision_ven_gen7.dbo.capitalworktask` | FOREIGN | 32 | capital work task |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - contractreference]] | `ext_mssql_asset_vision_ven_gen7.dbo.contractreference` | FOREIGN | 15 | contract reference |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - custommoduleitem]] | `ext_mssql_asset_vision_ven_gen7.dbo.custommoduleitem` | FOREIGN | 9 | module item |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - exportdate]] | `ext_mssql_asset_vision_ven_gen7.dbo.exportdate` | FOREIGN | 4 | export tracking |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - exportdatelog]] | `ext_mssql_asset_vision_ven_gen7.dbo.exportdatelog` | FOREIGN | 5 | export tracking |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - formfield]] | `ext_mssql_asset_vision_ven_gen7.dbo.formfield` | FOREIGN | 13 | form metadata |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - inspection]] | `ext_mssql_asset_vision_ven_gen7.dbo.inspection` | FOREIGN | 49 | inspection |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - inspectionrelationship]] | `ext_mssql_asset_vision_ven_gen7.dbo.inspectionrelationship` | FOREIGN | 8 | inspection relationship |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - inspectionstatus]] | `ext_mssql_asset_vision_ven_gen7.dbo.inspectionstatus` | FOREIGN | 9 | inspection status |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - job]] | `ext_mssql_asset_vision_ven_gen7.dbo.job` | FOREIGN | 84 | job |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - jobasset]] | `ext_mssql_asset_vision_ven_gen7.dbo.jobasset` | FOREIGN | 11 | job asset |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - jobcomment]] | `ext_mssql_asset_vision_ven_gen7.dbo.jobcomment` | FOREIGN | 7 | job comment |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - log]] | `ext_mssql_asset_vision_ven_gen7.dbo.log` | FOREIGN | 4 | log |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - module]] | `ext_mssql_asset_vision_ven_gen7.dbo.module` | FOREIGN | 28 | module |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - photo]] | `ext_mssql_asset_vision_ven_gen7.dbo.photo` | FOREIGN | 11 | photo |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - plannedresourceitem]] | `ext_mssql_asset_vision_ven_gen7.dbo.plannedresourceitem` | FOREIGN | 24 | resource planning |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - resource]] | `ext_mssql_asset_vision_ven_gen7.dbo.resource` | FOREIGN | 21 | resource |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - resourceattribute]] | `ext_mssql_asset_vision_ven_gen7.dbo.resourceattribute` | FOREIGN | 9 | resource attribute |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - resourceaudit]] | `ext_mssql_asset_vision_ven_gen7.dbo.resourceaudit` | FOREIGN | 9 | resource audit |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - summarycheck]] | `ext_mssql_asset_vision_ven_gen7.dbo.summarycheck` | FOREIGN | 8 | summary check |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - timesheetitem]] | `ext_mssql_asset_vision_ven_gen7.dbo.timesheetitem` | FOREIGN | 24 | timesheet |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - vassetaudit]] | `ext_mssql_asset_vision_ven_gen7.dbo.vassetaudit` | FOREIGN | 12 | asset audit |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - vassetlocation]] | `ext_mssql_asset_vision_ven_gen7.dbo.vassetlocation` | FOREIGN | 11 | asset location |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - vcapitalwork]] | `ext_mssql_asset_vision_ven_gen7.dbo.vcapitalwork` | FOREIGN | 29 | capital work |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - vcapitalworktask]] | `ext_mssql_asset_vision_ven_gen7.dbo.vcapitalworktask` | FOREIGN | 33 | capital work task |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - vinspection]] | `ext_mssql_asset_vision_ven_gen7.dbo.vinspection` | FOREIGN | 50 | inspection |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - vinspectionstatus]] | `ext_mssql_asset_vision_ven_gen7.dbo.vinspectionstatus` | FOREIGN | 10 | inspection status |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - vjob]] | `ext_mssql_asset_vision_ven_gen7.dbo.vjob` | FOREIGN | 85 | job |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - vmodule]] | `ext_mssql_asset_vision_ven_gen7.dbo.vmodule` | FOREIGN | 29 | module |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - vworkflowstatus]] | `ext_mssql_asset_vision_ven_gen7.dbo.vworkflowstatus` | FOREIGN | 15 | workflow status |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - workflowstatus]] | `ext_mssql_asset_vision_ven_gen7.dbo.workflowstatus` | FOREIGN | 14 | workflow status |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - asset]] | `ext_mssql_asset_vision_ven_rms.dbo.asset` | FOREIGN | 55 | asset |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - assetarea]] | `ext_mssql_asset_vision_ven_rms.dbo.assetarea` | FOREIGN | 12 | asset |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - assetattribute]] | `ext_mssql_asset_vision_ven_rms.dbo.assetattribute` | FOREIGN | 12 | asset |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - assetaudit]] | `ext_mssql_asset_vision_ven_rms.dbo.assetaudit` | FOREIGN | 0 | asset audit |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - assetclassification]] | `ext_mssql_asset_vision_ven_rms.dbo.assetclassification` | FOREIGN | 0 | asset classification |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - assethierarchy]] | `ext_mssql_asset_vision_ven_rms.dbo.assethierarchy` | FOREIGN | 0 | asset hierarchy |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - assetlocation]] | `ext_mssql_asset_vision_ven_rms.dbo.assetlocation` | FOREIGN | 0 | asset location |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - assetvaluation]] | `ext_mssql_asset_vision_ven_rms.dbo.assetvaluation` | FOREIGN | 0 | asset valuation |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - capitalwork]] | `ext_mssql_asset_vision_ven_rms.dbo.capitalwork` | FOREIGN | 35 | capital work |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - capitalworktask]] | `ext_mssql_asset_vision_ven_rms.dbo.capitalworktask` | FOREIGN | 0 | capital work task |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - contractreference]] | `ext_mssql_asset_vision_ven_rms.dbo.contractreference` | FOREIGN | 0 | contract reference |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - custommoduleitem]] | `ext_mssql_asset_vision_ven_rms.dbo.custommoduleitem` | FOREIGN | 10 | module item |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - exportdate]] | `ext_mssql_asset_vision_ven_rms.dbo.exportdate` | FOREIGN | 0 | export tracking |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - exportdatelog]] | `ext_mssql_asset_vision_ven_rms.dbo.exportdatelog` | FOREIGN | 0 | export tracking |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - formfield]] | `ext_mssql_asset_vision_ven_rms.dbo.formfield` | FOREIGN | 15 | form metadata |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - inspection]] | `ext_mssql_asset_vision_ven_rms.dbo.inspection` | FOREIGN | 62 | inspection |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - inspectionrelationship]] | `ext_mssql_asset_vision_ven_rms.dbo.inspectionrelationship` | FOREIGN | 0 | inspection relationship |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - inspectionstatus]] | `ext_mssql_asset_vision_ven_rms.dbo.inspectionstatus` | FOREIGN | 0 | inspection status |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - job]] | `ext_mssql_asset_vision_ven_rms.dbo.job` | FOREIGN | 105 | job |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - jobasset]] | `ext_mssql_asset_vision_ven_rms.dbo.jobasset` | FOREIGN | 0 | job asset |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - jobcomment]] | `ext_mssql_asset_vision_ven_rms.dbo.jobcomment` | FOREIGN | 8 | job comment |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - log]] | `ext_mssql_asset_vision_ven_rms.dbo.log` | FOREIGN | 0 | log |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - module]] | `ext_mssql_asset_vision_ven_rms.dbo.module` | FOREIGN | 36 | module |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - photo]] | `ext_mssql_asset_vision_ven_rms.dbo.photo` | FOREIGN | 12 | photo |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - plannedresourceitem]] | `ext_mssql_asset_vision_ven_rms.dbo.plannedresourceitem` | FOREIGN | 30 | resource planning |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - resource]] | `ext_mssql_asset_vision_ven_rms.dbo.resource` | FOREIGN | 0 | resource |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - resourceattribute]] | `ext_mssql_asset_vision_ven_rms.dbo.resourceattribute` | FOREIGN | 0 | resource attribute |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - resourceaudit]] | `ext_mssql_asset_vision_ven_rms.dbo.resourceaudit` | FOREIGN | 0 | resource audit |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - summarycheck]] | `ext_mssql_asset_vision_ven_rms.dbo.summarycheck` | FOREIGN | 0 | summary check |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - timesheetitem]] | `ext_mssql_asset_vision_ven_rms.dbo.timesheetitem` | FOREIGN | 30 | timesheet |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - vassetaudit]] | `ext_mssql_asset_vision_ven_rms.dbo.vassetaudit` | FOREIGN | 0 | asset audit |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - vassetlocation]] | `ext_mssql_asset_vision_ven_rms.dbo.vassetlocation` | FOREIGN | 12 | asset location |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - vcapitalwork]] | `ext_mssql_asset_vision_ven_rms.dbo.vcapitalwork` | FOREIGN | 0 | capital work |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - vcapitalworktask]] | `ext_mssql_asset_vision_ven_rms.dbo.vcapitalworktask` | FOREIGN | 0 | capital work task |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - vinspection]] | `ext_mssql_asset_vision_ven_rms.dbo.vinspection` | FOREIGN | 63 | inspection |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - vinspectionstatus]] | `ext_mssql_asset_vision_ven_rms.dbo.vinspectionstatus` | FOREIGN | 0 | inspection status |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - vjob]] | `ext_mssql_asset_vision_ven_rms.dbo.vjob` | FOREIGN | 106 | job |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - vmodule]] | `ext_mssql_asset_vision_ven_rms.dbo.vmodule` | FOREIGN | 37 | module |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - vworkflowstatus]] | `ext_mssql_asset_vision_ven_rms.dbo.vworkflowstatus` | FOREIGN | 0 | workflow status |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - workflowstatus]] | `ext_mssql_asset_vision_ven_rms.dbo.workflowstatus` | FOREIGN | 17 | workflow status |  |
| `asset_vision_ven_rms_old` | [[Transport Source Table - asset_vision_ven_rms_old - asset]] | `ext_mssql_asset_vision_ven_rms_old.dbo.asset` | FOREIGN | 35 | asset |  |
| `asset_vision_ven_rms_old` | [[Transport Source Table - asset_vision_ven_rms_old - assetarea]] | `ext_mssql_asset_vision_ven_rms_old.dbo.assetarea` | FOREIGN | 11 | asset |  |
| `asset_vision_ven_rms_old` | [[Transport Source Table - asset_vision_ven_rms_old - assetattribute]] | `ext_mssql_asset_vision_ven_rms_old.dbo.assetattribute` | FOREIGN | 9 | asset |  |
| `asset_vision_ven_rms_old` | [[Transport Source Table - asset_vision_ven_rms_old - assetaudit]] | `ext_mssql_asset_vision_ven_rms_old.dbo.assetaudit` | FOREIGN | 11 | asset audit |  |
| `asset_vision_ven_rms_old` | [[Transport Source Table - asset_vision_ven_rms_old - assetclassification]] | `ext_mssql_asset_vision_ven_rms_old.dbo.assetclassification` | FOREIGN | 12 | asset classification |  |
| `asset_vision_ven_rms_old` | [[Transport Source Table - asset_vision_ven_rms_old - assetlocation]] | `ext_mssql_asset_vision_ven_rms_old.dbo.assetlocation` | FOREIGN | 10 | asset location |  |
| `asset_vision_ven_rms_old` | [[Transport Source Table - asset_vision_ven_rms_old - capitalwork]] | `ext_mssql_asset_vision_ven_rms_old.dbo.capitalwork` | FOREIGN | 28 | capital work |  |
| `asset_vision_ven_rms_old` | [[Transport Source Table - asset_vision_ven_rms_old - vmodule]] | `ext_mssql_asset_vision_ven_rms_old.dbo.vmodule` | FOREIGN | 29 | module |  |
| `asset_vision_ven_rms_old` | [[Transport Source Table - asset_vision_ven_rms_old - vworkflowstatus]] | `ext_mssql_asset_vision_ven_rms_old.dbo.vworkflowstatus` | FOREIGN | 15 | workflow status |  |
| `asset_vision_ven_rms_old` | [[Transport Source Table - asset_vision_ven_rms_old - workflowstatus]] | `ext_mssql_asset_vision_ven_rms_old.dbo.workflowstatus` | FOREIGN | 14 | workflow status |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - asset]] | `ext_mssql_asset_vision_ven_vicroads.dbo.asset` | FOREIGN | 35 | asset |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - assetarea]] | `ext_mssql_asset_vision_ven_vicroads.dbo.assetarea` | FOREIGN | 11 | asset |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - assetattribute]] | `ext_mssql_asset_vision_ven_vicroads.dbo.assetattribute` | FOREIGN | 9 | asset |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - assetaudit]] | `ext_mssql_asset_vision_ven_vicroads.dbo.assetaudit` | FOREIGN | 11 | asset audit |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - assetclassification]] | `ext_mssql_asset_vision_ven_vicroads.dbo.assetclassification` | FOREIGN | 12 | asset classification |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - assetlocation]] | `ext_mssql_asset_vision_ven_vicroads.dbo.assetlocation` | FOREIGN | 10 | asset location |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - capitalwork]] | `ext_mssql_asset_vision_ven_vicroads.dbo.capitalwork` | FOREIGN | 28 | capital work |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - capitalworktask]] | `ext_mssql_asset_vision_ven_vicroads.dbo.capitalworktask` | FOREIGN | 32 | capital work task |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - contractreference]] | `ext_mssql_asset_vision_ven_vicroads.dbo.contractreference` | FOREIGN | 15 | contract reference |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - custommoduleitem]] | `ext_mssql_asset_vision_ven_vicroads.dbo.custommoduleitem` | FOREIGN | 9 | module item |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - exportdate]] | `ext_mssql_asset_vision_ven_vicroads.dbo.exportdate` | FOREIGN | 4 | export tracking |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - exportdatelog]] | `ext_mssql_asset_vision_ven_vicroads.dbo.exportdatelog` | FOREIGN | 5 | export tracking |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - formfield]] | `ext_mssql_asset_vision_ven_vicroads.dbo.formfield` | FOREIGN | 13 | form metadata |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - inspection]] | `ext_mssql_asset_vision_ven_vicroads.dbo.inspection` | FOREIGN | 49 | inspection |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - inspectionrelationship]] | `ext_mssql_asset_vision_ven_vicroads.dbo.inspectionrelationship` | FOREIGN | 8 | inspection relationship |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - inspectionstatus]] | `ext_mssql_asset_vision_ven_vicroads.dbo.inspectionstatus` | FOREIGN | 9 | inspection status |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - job]] | `ext_mssql_asset_vision_ven_vicroads.dbo.job` | FOREIGN | 84 | job |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - jobasset]] | `ext_mssql_asset_vision_ven_vicroads.dbo.jobasset` | FOREIGN | 11 | job asset |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - jobcomment]] | `ext_mssql_asset_vision_ven_vicroads.dbo.jobcomment` | FOREIGN | 7 | job comment |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - laneaccess]] | `ext_mssql_asset_vision_ven_vicroads.dbo.laneaccess` | FOREIGN | 56 | lane access |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - log]] | `ext_mssql_asset_vision_ven_vicroads.dbo.log` | FOREIGN | 4 | log |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - module]] | `ext_mssql_asset_vision_ven_vicroads.dbo.module` | FOREIGN | 28 | module |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - photo]] | `ext_mssql_asset_vision_ven_vicroads.dbo.photo` | FOREIGN | 11 | photo |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - plannedresourceitem]] | `ext_mssql_asset_vision_ven_vicroads.dbo.plannedresourceitem` | FOREIGN | 24 | resource planning |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - resource]] | `ext_mssql_asset_vision_ven_vicroads.dbo.resource` | FOREIGN | 21 | resource |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - resourceattribute]] | `ext_mssql_asset_vision_ven_vicroads.dbo.resourceattribute` | FOREIGN | 9 | resource attribute |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - resourceaudit]] | `ext_mssql_asset_vision_ven_vicroads.dbo.resourceaudit` | FOREIGN | 9 | resource audit |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - sqlserverversions]] | `ext_mssql_asset_vision_ven_vicroads.dbo.sqlserverversions` | FOREIGN | 9 | SQL Server version |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - summarycheck]] | `ext_mssql_asset_vision_ven_vicroads.dbo.summarycheck` | FOREIGN | 8 | summary check |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - timesheetitem]] | `ext_mssql_asset_vision_ven_vicroads.dbo.timesheetitem` | FOREIGN | 24 | timesheet |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - vassetaudit]] | `ext_mssql_asset_vision_ven_vicroads.dbo.vassetaudit` | FOREIGN | 12 | asset audit |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - vassetlocation]] | `ext_mssql_asset_vision_ven_vicroads.dbo.vassetlocation` | FOREIGN | 11 | asset location |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - vcapitalwork]] | `ext_mssql_asset_vision_ven_vicroads.dbo.vcapitalwork` | FOREIGN | 29 | capital work |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - vcapitalworktask]] | `ext_mssql_asset_vision_ven_vicroads.dbo.vcapitalworktask` | FOREIGN | 33 | capital work task |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - vinspection]] | `ext_mssql_asset_vision_ven_vicroads.dbo.vinspection` | FOREIGN | 50 | inspection |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - vinspectionstatus]] | `ext_mssql_asset_vision_ven_vicroads.dbo.vinspectionstatus` | FOREIGN | 10 | inspection status |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - vjob]] | `ext_mssql_asset_vision_ven_vicroads.dbo.vjob` | FOREIGN | 85 | job |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - vmodule]] | `ext_mssql_asset_vision_ven_vicroads.dbo.vmodule` | FOREIGN | 29 | module |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - vworkflowstatus]] | `ext_mssql_asset_vision_ven_vicroads.dbo.vworkflowstatus` | FOREIGN | 15 | workflow status |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - workflowstatus]] | `ext_mssql_asset_vision_ven_vicroads.dbo.workflowstatus` | FOREIGN | 14 | workflow status |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - asset]] | `ext_mssql_asset_vision_vns_gen7.dbo.asset` | FOREIGN | 35 | asset |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - assetarea]] | `ext_mssql_asset_vision_vns_gen7.dbo.assetarea` | FOREIGN | 11 | asset |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - assetattribute]] | `ext_mssql_asset_vision_vns_gen7.dbo.assetattribute` | FOREIGN | 9 | asset |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - assetaudit]] | `ext_mssql_asset_vision_vns_gen7.dbo.assetaudit` | FOREIGN | 11 | asset audit |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - assetclassification]] | `ext_mssql_asset_vision_vns_gen7.dbo.assetclassification` | FOREIGN | 12 | asset classification |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - assetlocation]] | `ext_mssql_asset_vision_vns_gen7.dbo.assetlocation` | FOREIGN | 10 | asset location |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - capitalwork]] | `ext_mssql_asset_vision_vns_gen7.dbo.capitalwork` | FOREIGN | 28 | capital work |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - capitalworktask]] | `ext_mssql_asset_vision_vns_gen7.dbo.capitalworktask` | FOREIGN | 32 | capital work task |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - contractreference]] | `ext_mssql_asset_vision_vns_gen7.dbo.contractreference` | FOREIGN | 15 | contract reference |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - custommoduleitem]] | `ext_mssql_asset_vision_vns_gen7.dbo.custommoduleitem` | FOREIGN | 9 | module item |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - exportdate]] | `ext_mssql_asset_vision_vns_gen7.dbo.exportdate` | FOREIGN | 4 | export tracking |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - exportdatelog]] | `ext_mssql_asset_vision_vns_gen7.dbo.exportdatelog` | FOREIGN | 5 | export tracking |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - formfield]] | `ext_mssql_asset_vision_vns_gen7.dbo.formfield` | FOREIGN | 13 | form metadata |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - inspection]] | `ext_mssql_asset_vision_vns_gen7.dbo.inspection` | FOREIGN | 49 | inspection |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - inspectionrelationship]] | `ext_mssql_asset_vision_vns_gen7.dbo.inspectionrelationship` | FOREIGN | 8 | inspection relationship |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - inspectionstatus]] | `ext_mssql_asset_vision_vns_gen7.dbo.inspectionstatus` | FOREIGN | 9 | inspection status |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - job]] | `ext_mssql_asset_vision_vns_gen7.dbo.job` | FOREIGN | 84 | job |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - jobasset]] | `ext_mssql_asset_vision_vns_gen7.dbo.jobasset` | FOREIGN | 11 | job asset |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - jobcomment]] | `ext_mssql_asset_vision_vns_gen7.dbo.jobcomment` | FOREIGN | 7 | job comment |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - log]] | `ext_mssql_asset_vision_vns_gen7.dbo.log` | FOREIGN | 4 | log |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - module]] | `ext_mssql_asset_vision_vns_gen7.dbo.module` | FOREIGN | 28 | module |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - photo]] | `ext_mssql_asset_vision_vns_gen7.dbo.photo` | FOREIGN | 11 | photo |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - plannedresourceitem]] | `ext_mssql_asset_vision_vns_gen7.dbo.plannedresourceitem` | FOREIGN | 24 | resource planning |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - resource]] | `ext_mssql_asset_vision_vns_gen7.dbo.resource` | FOREIGN | 21 | resource |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - resourceattribute]] | `ext_mssql_asset_vision_vns_gen7.dbo.resourceattribute` | FOREIGN | 9 | resource attribute |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - resourceaudit]] | `ext_mssql_asset_vision_vns_gen7.dbo.resourceaudit` | FOREIGN | 9 | resource audit |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - summarycheck]] | `ext_mssql_asset_vision_vns_gen7.dbo.summarycheck` | FOREIGN | 8 | summary check |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - timesheetitem]] | `ext_mssql_asset_vision_vns_gen7.dbo.timesheetitem` | FOREIGN | 24 | timesheet |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - vassetaudit]] | `ext_mssql_asset_vision_vns_gen7.dbo.vassetaudit` | FOREIGN | 12 | asset audit |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - vassetlocation]] | `ext_mssql_asset_vision_vns_gen7.dbo.vassetlocation` | FOREIGN | 11 | asset location |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - vcapitalwork]] | `ext_mssql_asset_vision_vns_gen7.dbo.vcapitalwork` | FOREIGN | 29 | capital work |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - vcapitalworktask]] | `ext_mssql_asset_vision_vns_gen7.dbo.vcapitalworktask` | FOREIGN | 33 | capital work task |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - vinspection]] | `ext_mssql_asset_vision_vns_gen7.dbo.vinspection` | FOREIGN | 50 | inspection |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - vinspectionstatus]] | `ext_mssql_asset_vision_vns_gen7.dbo.vinspectionstatus` | FOREIGN | 10 | inspection status |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - vjob]] | `ext_mssql_asset_vision_vns_gen7.dbo.vjob` | FOREIGN | 85 | job |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - vmodule]] | `ext_mssql_asset_vision_vns_gen7.dbo.vmodule` | FOREIGN | 29 | module |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - vworkflowstatus]] | `ext_mssql_asset_vision_vns_gen7.dbo.vworkflowstatus` | FOREIGN | 15 | workflow status |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - workflowstatus]] | `ext_mssql_asset_vision_vns_gen7.dbo.workflowstatus` | FOREIGN | 14 | workflow status |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - asset]] | `ext_mssql_asset_vision_vnz_gen7.dbo.asset` | FOREIGN | 35 | asset |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - assetarea]] | `ext_mssql_asset_vision_vnz_gen7.dbo.assetarea` | FOREIGN | 11 | asset |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - assetattribute]] | `ext_mssql_asset_vision_vnz_gen7.dbo.assetattribute` | FOREIGN | 9 | asset |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - assetaudit]] | `ext_mssql_asset_vision_vnz_gen7.dbo.assetaudit` | FOREIGN | 11 | asset audit |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - assetclassification]] | `ext_mssql_asset_vision_vnz_gen7.dbo.assetclassification` | FOREIGN | 12 | asset classification |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - assetlocation]] | `ext_mssql_asset_vision_vnz_gen7.dbo.assetlocation` | FOREIGN | 10 | asset location |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - capitalwork]] | `ext_mssql_asset_vision_vnz_gen7.dbo.capitalwork` | FOREIGN | 28 | capital work |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - capitalworktask]] | `ext_mssql_asset_vision_vnz_gen7.dbo.capitalworktask` | FOREIGN | 32 | capital work task |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - contractreference]] | `ext_mssql_asset_vision_vnz_gen7.dbo.contractreference` | FOREIGN | 15 | contract reference |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - custommoduleitem]] | `ext_mssql_asset_vision_vnz_gen7.dbo.custommoduleitem` | FOREIGN | 9 | module item |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - exportdate]] | `ext_mssql_asset_vision_vnz_gen7.dbo.exportdate` | FOREIGN | 4 | export tracking |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - exportdatelog]] | `ext_mssql_asset_vision_vnz_gen7.dbo.exportdatelog` | FOREIGN | 5 | export tracking |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - formfield]] | `ext_mssql_asset_vision_vnz_gen7.dbo.formfield` | FOREIGN | 13 | form metadata |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - inspection]] | `ext_mssql_asset_vision_vnz_gen7.dbo.inspection` | FOREIGN | 49 | inspection |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - inspectionrelationship]] | `ext_mssql_asset_vision_vnz_gen7.dbo.inspectionrelationship` | FOREIGN | 8 | inspection relationship |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - inspectionstatus]] | `ext_mssql_asset_vision_vnz_gen7.dbo.inspectionstatus` | FOREIGN | 9 | inspection status |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - job]] | `ext_mssql_asset_vision_vnz_gen7.dbo.job` | FOREIGN | 84 | job |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - jobasset]] | `ext_mssql_asset_vision_vnz_gen7.dbo.jobasset` | FOREIGN | 11 | job asset |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - jobcomment]] | `ext_mssql_asset_vision_vnz_gen7.dbo.jobcomment` | FOREIGN | 7 | job comment |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - log]] | `ext_mssql_asset_vision_vnz_gen7.dbo.log` | FOREIGN | 4 | log |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - module]] | `ext_mssql_asset_vision_vnz_gen7.dbo.module` | FOREIGN | 28 | module |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - photo]] | `ext_mssql_asset_vision_vnz_gen7.dbo.photo` | FOREIGN | 11 | photo |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - plannedresourceitem]] | `ext_mssql_asset_vision_vnz_gen7.dbo.plannedresourceitem` | FOREIGN | 24 | resource planning |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - resource]] | `ext_mssql_asset_vision_vnz_gen7.dbo.resource` | FOREIGN | 21 | resource |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - resourceattribute]] | `ext_mssql_asset_vision_vnz_gen7.dbo.resourceattribute` | FOREIGN | 9 | resource attribute |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - resourceaudit]] | `ext_mssql_asset_vision_vnz_gen7.dbo.resourceaudit` | FOREIGN | 9 | resource audit |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - summarycheck]] | `ext_mssql_asset_vision_vnz_gen7.dbo.summarycheck` | FOREIGN | 0 | summary check |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - timesheetitem]] | `ext_mssql_asset_vision_vnz_gen7.dbo.timesheetitem` | FOREIGN | 24 | timesheet |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - vassetaudit]] | `ext_mssql_asset_vision_vnz_gen7.dbo.vassetaudit` | FOREIGN | 12 | asset audit |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - vassetlocation]] | `ext_mssql_asset_vision_vnz_gen7.dbo.vassetlocation` | FOREIGN | 11 | asset location |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - vcapitalwork]] | `ext_mssql_asset_vision_vnz_gen7.dbo.vcapitalwork` | FOREIGN | 29 | capital work |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - vcapitalworktask]] | `ext_mssql_asset_vision_vnz_gen7.dbo.vcapitalworktask` | FOREIGN | 33 | capital work task |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - vinspection]] | `ext_mssql_asset_vision_vnz_gen7.dbo.vinspection` | FOREIGN | 50 | inspection |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - vinspectionstatus]] | `ext_mssql_asset_vision_vnz_gen7.dbo.vinspectionstatus` | FOREIGN | 10 | inspection status |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - vjob]] | `ext_mssql_asset_vision_vnz_gen7.dbo.vjob` | FOREIGN | 85 | job |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - vmodule]] | `ext_mssql_asset_vision_vnz_gen7.dbo.vmodule` | FOREIGN | 29 | module |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - vworkflowstatus]] | `ext_mssql_asset_vision_vnz_gen7.dbo.vworkflowstatus` | FOREIGN | 15 | workflow status |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - workflowstatus]] | `ext_mssql_asset_vision_vnz_gen7.dbo.workflowstatus` | FOREIGN | 14 | workflow status |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - asset]] | `ext_mssql_asset_vision_vsm_gen7.dbo.asset` | FOREIGN | 35 | asset |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - assetarea]] | `ext_mssql_asset_vision_vsm_gen7.dbo.assetarea` | FOREIGN | 11 | asset |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - assetattribute]] | `ext_mssql_asset_vision_vsm_gen7.dbo.assetattribute` | FOREIGN | 9 | asset |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - assetaudit]] | `ext_mssql_asset_vision_vsm_gen7.dbo.assetaudit` | FOREIGN | 11 | asset audit |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - assetclassification]] | `ext_mssql_asset_vision_vsm_gen7.dbo.assetclassification` | FOREIGN | 12 | asset classification |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - assetlocation]] | `ext_mssql_asset_vision_vsm_gen7.dbo.assetlocation` | FOREIGN | 10 | asset location |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - capitalwork]] | `ext_mssql_asset_vision_vsm_gen7.dbo.capitalwork` | FOREIGN | 28 | capital work |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - capitalworktask]] | `ext_mssql_asset_vision_vsm_gen7.dbo.capitalworktask` | FOREIGN | 32 | capital work task |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - contractreference]] | `ext_mssql_asset_vision_vsm_gen7.dbo.contractreference` | FOREIGN | 15 | contract reference |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - custommoduleitem]] | `ext_mssql_asset_vision_vsm_gen7.dbo.custommoduleitem` | FOREIGN | 9 | module item |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - exportdate]] | `ext_mssql_asset_vision_vsm_gen7.dbo.exportdate` | FOREIGN | 4 | export tracking |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - exportdatelog]] | `ext_mssql_asset_vision_vsm_gen7.dbo.exportdatelog` | FOREIGN | 5 | export tracking |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - formfield]] | `ext_mssql_asset_vision_vsm_gen7.dbo.formfield` | FOREIGN | 13 | form metadata |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - inspection]] | `ext_mssql_asset_vision_vsm_gen7.dbo.inspection` | FOREIGN | 49 | inspection |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - inspectionrelationship]] | `ext_mssql_asset_vision_vsm_gen7.dbo.inspectionrelationship` | FOREIGN | 8 | inspection relationship |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - inspectionstatus]] | `ext_mssql_asset_vision_vsm_gen7.dbo.inspectionstatus` | FOREIGN | 9 | inspection status |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - job]] | `ext_mssql_asset_vision_vsm_gen7.dbo.job` | FOREIGN | 84 | job |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - jobasset]] | `ext_mssql_asset_vision_vsm_gen7.dbo.jobasset` | FOREIGN | 11 | job asset |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - jobcomment]] | `ext_mssql_asset_vision_vsm_gen7.dbo.jobcomment` | FOREIGN | 7 | job comment |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - log]] | `ext_mssql_asset_vision_vsm_gen7.dbo.log` | FOREIGN | 4 | log |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - module]] | `ext_mssql_asset_vision_vsm_gen7.dbo.module` | FOREIGN | 28 | module |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - photo]] | `ext_mssql_asset_vision_vsm_gen7.dbo.photo` | FOREIGN | 11 | photo |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - plannedresourceitem]] | `ext_mssql_asset_vision_vsm_gen7.dbo.plannedresourceitem` | FOREIGN | 24 | resource planning |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - resource]] | `ext_mssql_asset_vision_vsm_gen7.dbo.resource` | FOREIGN | 21 | resource |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - resourceattribute]] | `ext_mssql_asset_vision_vsm_gen7.dbo.resourceattribute` | FOREIGN | 9 | resource attribute |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - resourceaudit]] | `ext_mssql_asset_vision_vsm_gen7.dbo.resourceaudit` | FOREIGN | 9 | resource audit |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - summarycheck]] | `ext_mssql_asset_vision_vsm_gen7.dbo.summarycheck` | FOREIGN | 8 | summary check |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - timesheetitem]] | `ext_mssql_asset_vision_vsm_gen7.dbo.timesheetitem` | FOREIGN | 24 | timesheet |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - vassetaudit]] | `ext_mssql_asset_vision_vsm_gen7.dbo.vassetaudit` | FOREIGN | 12 | asset audit |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - vassetlocation]] | `ext_mssql_asset_vision_vsm_gen7.dbo.vassetlocation` | FOREIGN | 11 | asset location |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - vcapitalwork]] | `ext_mssql_asset_vision_vsm_gen7.dbo.vcapitalwork` | FOREIGN | 29 | capital work |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - vcapitalworktask]] | `ext_mssql_asset_vision_vsm_gen7.dbo.vcapitalworktask` | FOREIGN | 33 | capital work task |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - vinspection]] | `ext_mssql_asset_vision_vsm_gen7.dbo.vinspection` | FOREIGN | 50 | inspection |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - vinspectionstatus]] | `ext_mssql_asset_vision_vsm_gen7.dbo.vinspectionstatus` | FOREIGN | 10 | inspection status |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - vjob]] | `ext_mssql_asset_vision_vsm_gen7.dbo.vjob` | FOREIGN | 85 | job |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - vmodule]] | `ext_mssql_asset_vision_vsm_gen7.dbo.vmodule` | FOREIGN | 29 | module |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - vworkflowstatus]] | `ext_mssql_asset_vision_vsm_gen7.dbo.vworkflowstatus` | FOREIGN | 15 | workflow status |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - workflowstatus]] | `ext_mssql_asset_vision_vsm_gen7.dbo.workflowstatus` | FOREIGN | 14 | workflow status |  |
| `transport` | [[Transport Table - transport - utbl_job_costing_timesheets_all_contracts]] | `transport_dev.transport.utbl_job_costing_timesheets_all_contracts` | MANAGED | 50 | job costing timesheet |  |
| `transport` | [[Transport Table - transport - uvw_purgrp_masterdata_detail]] | `transport_dev.transport.uvw_purgrp_masterdata_detail` | VIEW | 6 | purchasing group |  |
| `transport` | [[Transport Table - transport - uvw_purgrp_masterdata_uniquelist]] | `transport_dev.transport.uvw_purgrp_masterdata_uniquelist` | VIEW | 2 | purchasing group |  |
| `transport` | [[Transport Table - transport - uvw_vendor_cleared_items_bsak]] | `transport_dev.transport.uvw_vendor_cleared_items_bsak` | VIEW | 16 | vendor finance |  |
| `transport` | [[Transport Table - transport - uvw_vendor_master_data]] | `transport_dev.transport.uvw_vendor_master_data` | VIEW | 4 | vendor master |  |
| `transport` | [[Transport Table - transport - uvw_vendor_open_items_bsik]] | `transport_dev.transport.uvw_vendor_open_items_bsik` | VIEW | 16 | vendor finance |  |
| `transport` | [[Transport Table - transport - uvw_wbs_budget_forecast_data_cosp]] | `transport_dev.transport.uvw_wbs_budget_forecast_data_cosp` | VIEW | 24 | WBS finance |  |
| `transport` | [[Transport Table - transport - uvw_wbs_master_data_prps]] | `transport_dev.transport.uvw_wbs_master_data_prps` | VIEW | 7 | WBS master |  |
| `transport` | [[Transport Table - transport - uvw_wo_nwa_master_data_aufk_afko_afvc]] | `transport_dev.transport.uvw_wo_nwa_master_data_aufk_afko_afvc` | VIEW | 14 | work order master |  |
| `transport_aklw` | [[Transport Table - transport_aklw - uvw_asset]] | `transport_dev.transport_aklw.uvw_asset` | VIEW | 33 | asset |  |
| `transport_aklw` | [[Transport Table - transport_aklw - uvw_capitalwork]] | `transport_dev.transport_aklw.uvw_capitalwork` | VIEW | 28 | capital work |  |
| `transport_aklw` | [[Transport Table - transport_aklw - uvw_capitalworktask]] | `transport_dev.transport_aklw.uvw_capitalworktask` | VIEW | 32 | capital work |  |
| `transport_aklw` | [[Transport Table - transport_aklw - uvw_formfield]] | `transport_dev.transport_aklw.uvw_formfield` | VIEW | 13 | form metadata |  |
| `transport_aklw` | [[Transport Table - transport_aklw - uvw_plant_pending_timesheet]] | `transport_dev.transport_aklw.uvw_plant_pending_timesheet` | VIEW | 21 | timesheet |  |
| `transport_aklw` | [[Transport Table - transport_aklw - uvw_timesheetitem]] | `transport_dev.transport_aklw.uvw_timesheetitem` | VIEW | 27 | timesheet |  |
| `transport_aklw` | [[Transport Table - transport_aklw - uvw_timesheetreport]] | `transport_dev.transport_aklw.uvw_timesheetreport` | VIEW | 31 | timesheet |  |
| `transport_aklw` | [[Transport Table - transport_aklw - uvw_updated_dispatch_id]] | `transport_dev.transport_aklw.uvw_updated_dispatch_id` | VIEW | 12 | dispatch |  |
| `transport_aklw` | [[Transport Table - transport_aklw - uvw_workflowstatus]] | `transport_dev.transport_aklw.uvw_workflowstatus` | VIEW | 14 | workflow |  |
| `transport_fndc` | [[Transport Table - transport_fndc - byo_tbl_kerikeri_weather_hr_fc]] | `transport_dev.transport_fndc.byo_tbl_kerikeri_weather_hr_fc` | MANAGED | 6 | weather |  |
| `transport_fndc` | [[Transport Table - transport_fndc - byo_tbl_national_road_cl_nz]] | `transport_dev.transport_fndc.byo_tbl_national_road_cl_nz` | MANAGED | 26 | road network | National road centreline network, traffic, and road-controlling-authority data |
| `transport_fndc` | [[Transport Table - transport_fndc - weather_hourly_forecast]] | `transport_dev.transport_fndc.weather_hourly_forecast` | MANAGED | 6 | weather |  |
| `transport_nel` | [[Transport Table - transport_nel - utbl_kpi_assets]] | `transport_dev.transport_nel.utbl_kpi_assets` | MANAGED | 66 | KPI asset |  |
| `transport_nel` | [[Transport Table - transport_nel - utbl_kpi_work_orders]] | `transport_dev.transport_nel.utbl_kpi_work_orders` | MANAGED | 26 | KPI work order |  |
| `transport_nel` | [[Transport Table - transport_nel - utbl_ref_date_table]] | `transport_dev.transport_nel.utbl_ref_date_table` | MANAGED | 25 | reference date |  |
| `transport_nel` | [[Transport Table - transport_nel - uvw_kpi_sys_av_devices]] | `transport_dev.transport_nel.uvw_kpi_sys_av_devices` | VIEW | 12 | KPI asset/device |  |
| `transport_ramc` | [[Transport Table - transport_ramc - bkp_backlog_change_report]] | `transport_dev.transport_ramc.bkp_backlog_change_report` | MANAGED | 9 | backlog |  |
| `transport_ramc` | [[Transport Table - transport_ramc - bkp_current_month_job_snapshot]] | `transport_dev.transport_ramc.bkp_current_month_job_snapshot` | MANAGED | 26 | job snapshot |  |
| `transport_ramc` | [[Transport Table - transport_ramc - bkp_last_month_job_snapshot]] | `transport_dev.transport_ramc.bkp_last_month_job_snapshot` | MANAGED | 24 | job snapshot |  |
| `transport_ramc` | [[Transport Table - transport_ramc - bkp_monthly_backlog_reduction]] | `transport_dev.transport_ramc.bkp_monthly_backlog_reduction` | MANAGED | 4 | backlog |  |
| `transport_ramc` | [[Transport Table - transport_ramc - utbl_backlog_change_report]] | `transport_dev.transport_ramc.utbl_backlog_change_report` | MANAGED | 9 | backlog |  |
| `transport_ramc` | [[Transport Table - transport_ramc - utbl_current_month_job_snapshot]] | `transport_dev.transport_ramc.utbl_current_month_job_snapshot` | MANAGED | 26 | job snapshot |  |
| `transport_ramc` | [[Transport Table - transport_ramc - uvw_stripmap_jobphotos]] | `transport_dev.transport_ramc.uvw_stripmap_jobphotos` | VIEW | 4 | stripmap photo |  |
| `transport_ramc` | [[Transport Table - transport_ramc - uvw_stripmap_jobs]] | `transport_dev.transport_ramc.uvw_stripmap_jobs` | VIEW | 56 | stripmap job |  |
| `transport_ramc` | [[Transport Table - transport_ramc - uvw_stripmap_wkt]] | `transport_dev.transport_ramc.uvw_stripmap_wkt` | VIEW | 11 | stripmap GIS |  |
| `transport_sht` | [[Transport Table - transport_sht - utbl_nps03_sb]] | `transport_dev.transport_sht.utbl_nps03_sb` | MANAGED | 3 | sensor reading |  |
| `transport_sht` | [[Transport Table - transport_sht - utbl_nps04_nb]] | `transport_dev.transport_sht.utbl_nps04_nb` | MANAGED | 1 | upload staging |  |
| `transport_sht` | [[Transport Table - transport_sht - utbl_sps01_nb]] | `transport_dev.transport_sht.utbl_sps01_nb` | MANAGED | 1 | upload staging |  |
| `transport_sht` | [[Transport Table - transport_sht - utbl_sps02_sb]] | `transport_dev.transport_sht.utbl_sps02_sb` | MANAGED | 3 | sensor reading |  |
| `transport_sht` | [[Transport Table - transport_sht - utbl_ss_latitude]] | `transport_dev.transport_sht.utbl_ss_latitude` | MANAGED | 8 | service schedule |  |
| `transport_sht` | [[Transport Table - transport_sht - utbl_tmp_nps03_sb]] | `transport_dev.transport_sht.utbl_tmp_nps03_sb` | MANAGED | 1 | temporary staging | Temporary staging table created via file upload |
| `transport_sht` | [[Transport Table - transport_sht - utbl_tmp_nps04_nb]] | `transport_dev.transport_sht.utbl_tmp_nps04_nb` | MANAGED | 1 | temporary staging | Temporary staging table for NPS or similar customer feedback data |
| `transport_sht` | [[Transport Table - transport_sht - utbl_tmp_sps01_nb]] | `transport_dev.transport_sht.utbl_tmp_sps01_nb` | MANAGED | 1 | temporary staging | Temporary or intermediate file-upload dataset |
| `transport_sht` | [[Transport Table - transport_sht - utbl_tmp_sps02_sb]] | `transport_dev.transport_sht.utbl_tmp_sps02_sb` | MANAGED | 1 | temporary staging | Temporary file-upload staging table |
| `transport_sht` | [[Transport Table - transport_sht - utbl_tmp_tvs03_sb]] | `transport_dev.transport_sht.utbl_tmp_tvs03_sb` | MANAGED | 1 | temporary staging | Temporary or staging table created via file upload |
| `transport_sht` | [[Transport Table - transport_sht - utbl_tmp_tvs07_nb]] | `transport_dev.transport_sht.utbl_tmp_tvs07_nb` | MANAGED | 1 | temporary staging | Temporary file-upload staging table |
| `transport_sht` | [[Transport Table - transport_sht - utbl_tvs03_sb]] | `transport_dev.transport_sht.utbl_tvs03_sb` | MANAGED | 3 | sensor reading |  |
| `transport_sht` | [[Transport Table - transport_sht - utbl_tvs07_nb]] | `transport_dev.transport_sht.utbl_tvs07_nb` | MANAGED | 3 | sensor reading |  |
| `transport_sht` | [[Transport Table - transport_sht - uvw_ai1]] | `transport_dev.transport_sht.uvw_ai1` | VIEW | 19 | inspection compliance |  |
| `transport_sht` | [[Transport Table - transport_sht - uvw_nps03_sb_segmented]] | `transport_dev.transport_sht.uvw_nps03_sb_segmented` | VIEW | 4 | segmented sensor reading |  |
| `transport_sht` | [[Transport Table - transport_sht - uvw_nps04_nb_segmented]] | `transport_dev.transport_sht.uvw_nps04_nb_segmented` | VIEW | 4 | segmented sensor reading |  |
| `transport_sht` | [[Transport Table - transport_sht - uvw_sps01_nb_segmented]] | `transport_dev.transport_sht.uvw_sps01_nb_segmented` | VIEW | 4 | segmented sensor reading |  |
| `transport_sht` | [[Transport Table - transport_sht - uvw_sps02_sb_segmented]] | `transport_dev.transport_sht.uvw_sps02_sb_segmented` | VIEW | 4 | segmented sensor reading |  |
| `transport_sht` | [[Transport Table - transport_sht - uvw_tvs03_sb_segmented]] | `transport_dev.transport_sht.uvw_tvs03_sb_segmented` | VIEW | 4 | segmented sensor reading |  |
| `transport_sht` | [[Transport Table - transport_sht - uvw_tvs07_nb_segmented]] | `transport_dev.transport_sht.uvw_tvs07_nb_segmented` | VIEW | 4 | segmented sensor reading |  |
| `transport_sht` | [[Transport Table - transport_sht - uvw_user_groups]] | `transport_dev.transport_sht.uvw_user_groups` | VIEW | 2 | user mapping |  |
| `transport_sht` | [[Transport Table - transport_sht - uvw_weather_north_sydney_hourly_rolling_30days]] | `transport_dev.transport_sht.uvw_weather_north_sydney_hourly_rolling_30days` | VIEW | 62 | weather |  |
| `transport_srapc` | [[Transport Table - transport_srapc - utbl_monthly_report]] | `transport_dev.transport_srapc.utbl_monthly_report` | MANAGED | 12 | monthly reporting |  |
| `transport_srapc` | [[Transport Table - transport_srapc - utbl_srapc_formitize_mapping]] | `transport_dev.transport_srapc.utbl_srapc_formitize_mapping` | MANAGED | 7 | form mapping |  |
| `transport_srapc` | [[Transport Table - transport_srapc - utbl_tacp_constants]] | `transport_dev.transport_srapc.utbl_tacp_constants` | MANAGED | 6 | TACP constants |  |
| `transport_srapc` | [[Transport Table - transport_srapc - utbl_tacp_toc]] | `transport_dev.transport_srapc.utbl_tacp_toc` | MANAGED | 3 | TACP mapping |  |
| `transport_srapc` | [[Transport Table - transport_srapc - utbl_tmp_civil_master]] | `transport_dev.transport_srapc.utbl_tmp_civil_master` | MANAGED | 54 | civil maintenance master |  |
| `transport_srapc` | [[Transport Table - transport_srapc - uvw_weatherobervations]] | `transport_dev.transport_srapc.uvw_weatherobervations` | VIEW | 26 | weather |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - bkp_uvw_incident_closures]] | `transport_dev.transport_tsrc.bkp_uvw_incident_closures` | MANAGED | 6 | incident closure |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - utbl_aed_asset_bridge]] | `transport_dev.transport_tsrc.utbl_aed_asset_bridge` | MANAGED | 56 | bridge asset |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - utbl_aed_assets]] | `transport_dev.transport_tsrc.utbl_aed_assets` | MANAGED | 4 | AED asset |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - utbl_aed_incidents_closures]] | `transport_dev.transport_tsrc.utbl_aed_incidents_closures` | MANAGED | 34 | incident closure |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - utbl_aed_incidents_events]] | `transport_dev.transport_tsrc.utbl_aed_incidents_events` | MANAGED | 6 | incident event |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - utbl_aed_incidents_list]] | `transport_dev.transport_tsrc.utbl_aed_incidents_list` | MANAGED | 11 | incident |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - uvw_traffic_closures]] | `transport_dev.transport_tsrc.uvw_traffic_closures` | VIEW | 17 | traffic closure |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - uvw_traffic_volume]] | `transport_dev.transport_tsrc.uvw_traffic_volume` | VIEW | 10 | traffic volume |  |
| `transport_wru` | [[Transport Table - transport_wru - utbl_capitalwork_chainage]] | `transport_dev.transport_wru.utbl_capitalwork_chainage` | MANAGED | 5 | capital work |  |
| `transport_wru` | [[Transport Table - transport_wru - utbl_counter_locations]] | `transport_dev.transport_wru.utbl_counter_locations` | MANAGED | 24 | traffic counter |  |
| `transport_wru` | [[Transport Table - transport_wru - utbl_counts_by_carriageway]] | `transport_dev.transport_wru.utbl_counts_by_carriageway` | MANAGED | 22 | traffic count |  |
| `transport_wru` | [[Transport Table - transport_wru - utbl_counts_by_lane]] | `transport_dev.transport_wru.utbl_counts_by_lane` | MANAGED | 25 | traffic count |  |
| `transport_wru` | [[Transport Table - transport_wru - utbl_counts_hourly]] | `transport_dev.transport_wru.utbl_counts_hourly` | MANAGED | 26 | traffic count |  |
| `transport_wru` | [[Transport Table - transport_wru - utbl_date_table]] | `transport_dev.transport_wru.utbl_date_table` | MANAGED | 13 | reference date |  |
| `transport_wru` | [[Transport Table - transport_wru - utbl_eot_reasons]] | `transport_dev.transport_wru.utbl_eot_reasons` | MANAGED | 2 | extension of time |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_timesheet]] | `transport_dev.transport_wru.uvw_timesheet` | VIEW | 21 | timesheet |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_timesheetitem]] | `transport_dev.transport_wru.uvw_timesheetitem` | VIEW | 29 | timesheet |  |
| `transport_wru` | [[Transport Table - transport_wru - vw_job_export_final]] | `transport_dev.transport_wru.vw_job_export_final` | VIEW | 32 | job export |  |

## Skipped Or Incomplete Inputs

- `capitalworktask` was visible in the pasted `ext_mssql_asset_vision_ven_rms_old.dbo` source-table payload but the object was truncated before complete columns could be verified, so it has not been documented yet under `asset_vision_ven_rms_old`.
- At least one intervening `ext_mssql_asset_vision_ven_rms_old.dbo` source-table object between `capitalworktask` and `vmodule` was hidden or visible only as a truncated tail, so it has not been documented yet under `asset_vision_ven_rms_old`.
- `uvw_inspection` was visible in the pasted input but the schema was truncated before all columns could be verified, so it has not been documented yet.
- `uvw_c_surface` was visible in the pasted FNDC input but the view query and following payload were truncated before the full object could be verified, so it has not been documented yet.
- A later FNDC treatment-length view object was visible only after truncation and without a verifiable table identity, so it has not been documented yet.
- `utbl_last_month_job_snapshot` was visible in the pasted RAMC input but the schema was truncated before all columns could be verified, so it has not been documented yet.
- A RAMC view object before `uvw_stripmap_jobphotos` was visible only as the tail of a view query after truncation and without a verifiable table identity, so it has not been documented yet.
- `uvw_ai2` was visible in the pasted SHT input but the schema was truncated before all columns and view SQL could be verified, so it has not been documented yet.
- A SHT job view object was visible only as the tail of a schema and query after truncation and without a verifiable table identity, so it has not been documented yet.
- `uvw_a_bridge_all_data` was visible in the pasted SRAPC input but the schema was truncated before all columns and view SQL could be verified, so it has not been documented yet.
- A SRAPC TACP/export view object was visible only as the tail of a schema and query after truncation and without a verifiable table identity, so it has not been documented yet.
- `utbl_aed_incidents_sr` was visible in the pasted TSRC input but the object was truncated before complete columns could be verified, so it has not been documented yet.
- One or more intervening TSRC objects between `utbl_aed_incidents_sr` and `uvw_traffic_closures`, including a KPI/abatement view query tail, were hidden or truncated by the pasted payload limit, so they have not been documented yet.
- `utbl_inspection_road_sections` was visible in the pasted WRU input but the schema was truncated before complete columns could be verified, so it has not been documented yet.
- A WRU view object with `module_id` and `speed` columns was visible only as the tail of a schema and query after truncation and without a verifiable table identity, so it has not been documented yet.
- `utbl_jobs_allcontract` was visible in the pasted `transport` schema input but the schema was truncated before complete columns could be verified, so it has not been documented yet.
- One or more intervening `transport` schema objects between `utbl_jobs_allcontract` and `uvw_purgrp_masterdata_detail` were hidden by the pasted payload limit, so they have not been documented yet.

## Related Pages

- [[Transport Enterprise Current State Visuals]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]

