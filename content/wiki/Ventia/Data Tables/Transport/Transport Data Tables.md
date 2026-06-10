---
type: table-catalog
topic: Ventia
sector: Transport
date-created: 2026-06-05
date-updated: 2026-06-09
tags: [transport, data-tables, databricks]
---

# Transport Data Tables

This page catalogs known Transport sector table documentation. Contract-specific Transport schemas are treated as contract or contract-group contexts when supported by source evidence; raw source schemas such as SQL Server `dbo` are tracked as source contexts instead.

## Context Index

| Context | Tables | Notes |
|---|---:|---|
| [[Transport Source Tables - asset_vision_ven_gen7]] | 38 | Source catalog supplied as `ext_mssql_asset_vision_ven_gen7`; SQL Server schema is `dbo`; supplied source-system comment maps this Asset Vision work management and asset data to RAMC, BAC, PoB, and TSRC |
| [[Transport Source Tables - asset_vision_ven_rms]] | 40 | Source catalog supplied as `ext_mssql_asset_vision_ven_rms`; SQL Server schema is `dbo`; no source-system comment was supplied in the 2026-06-09 inventory |
| [[Transport Source Tables - asset_vision_ven_rms_new]] | 40 | Source catalog supplied as `ext_mssql_asset_vision_ven_rms_new`; SQL Server schema is `dbo`; no source-system comment was supplied in the earlier source-system inventory |
| [[Transport Source Tables - asset_vision_ven_rms_old]] | 10 |  |
| [[Transport Source Tables - asset_vision_ven_vicroads]] | 40 | Source catalog supplied as `ext_mssql_asset_vision_ven_vicroads`; SQL Server schema is `dbo`; supplied source-system comment maps this Asset Vision work management and asset data to WRU |
| [[Transport Source Tables - asset_vision_vns_gen7]] | 38 | Source catalog supplied as `ext_mssql_asset_vision_vns_gen7`; SQL Server schema is `dbo`; supplied source-system comment maps this Asset Vision-labelled data to SHT/WHT; stakeholder documentation still identifies SHT operational work management as Maximo |
| [[Transport Source Tables - asset_vision_vnz_gen7]] | 38 | Source catalog supplied as `ext_mssql_asset_vision_vnz_gen7`; SQL Server schema is `dbo`; supplied source-system comment maps this Asset Vision work management and asset data to Auckland West |
| [[Transport Source Tables - asset_vision_vsm_gen7]] | 38 | Source catalog supplied as `ext_mssql_asset_vision_vsm_gen7`; SQL Server schema is `dbo`; supplied source-system comment maps this Asset Vision work management and asset data to VentureSmart |
| [[Transport Contract Tables - formitize_srapc]] | 7 | Schema identifier supplied as `formitize_srapc` |
| [[Transport Contract Tables - stg_enterprise_reporting]] | 26 | Schema identifier supplied as `stg_enterprise_reporting` |
| [[Transport Contract Tables - transport]] | 40 | Schema identifier supplied as `transport` |
| [[Transport Contract Tables - transport_aklw]] | 11 | Schema identifier supplied as `transport_aklw` |
| [[Transport Contract Tables - transport_fndc]] | 14 | Schema identifier supplied as `transport_fndc` |
| [[Transport Contract Tables - transport_nel]] | 4 | Schema identifier supplied as `transport_nel` |
| [[Transport Contract Tables - transport_ramc]] | 17 | Schema identifier supplied as `transport_ramc` |
| [[Transport Contract Tables - transport_sht]] | 27 | Schema identifier supplied as `transport_sht` |
| [[Transport Contract Tables - transport_srapc]] | 42 | Schema identifier supplied as `transport_srapc` |
| [[Transport Contract Tables - transport_tsrc]] | 88 | Schema identifier supplied as `transport_tsrc` |
| [[Transport Contract Tables - transport_vsm]] | 1 | Schema identifier supplied as `transport_vsm` |
| [[Transport Contract Tables - transport_wru]] | 78 | Schema identifier supplied as `transport_wru` |

## Table Index

| Context | Table | Full name | Type | Columns | Domain | Purpose |
|---|---|---|---|---:|---|---|
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - asset]] | `ext_mssql_asset_vision_ven_gen7.dbo.asset` | FOREIGN | 35 | asset register / hierarchy |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - assetarea]] | `ext_mssql_asset_vision_ven_gen7.dbo.assetarea` | FOREIGN | 11 | asset register / hierarchy |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - assetattribute]] | `ext_mssql_asset_vision_ven_gen7.dbo.assetattribute` | FOREIGN | 9 | asset register / hierarchy |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - assetaudit]] | `ext_mssql_asset_vision_ven_gen7.dbo.assetaudit` | FOREIGN | 11 | asset register / hierarchy |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - assetclassification]] | `ext_mssql_asset_vision_ven_gen7.dbo.assetclassification` | FOREIGN | 12 | asset register / hierarchy |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - assetlocation]] | `ext_mssql_asset_vision_ven_gen7.dbo.assetlocation` | FOREIGN | 10 | asset register / hierarchy |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - capitalwork]] | `ext_mssql_asset_vision_ven_gen7.dbo.capitalwork` | FOREIGN | 28 | capital works / forward works |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - capitalworktask]] | `ext_mssql_asset_vision_ven_gen7.dbo.capitalworktask` | FOREIGN | 32 | capital works / forward works |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - contractreference]] | `ext_mssql_asset_vision_ven_gen7.dbo.contractreference` | FOREIGN | 15 | reference / mapping |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - custommoduleitem]] | `ext_mssql_asset_vision_ven_gen7.dbo.custommoduleitem` | FOREIGN | 9 | forms / modules |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - exportdate]] | `ext_mssql_asset_vision_ven_gen7.dbo.exportdate` | FOREIGN | 4 | reference / mapping |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - exportdatelog]] | `ext_mssql_asset_vision_ven_gen7.dbo.exportdatelog` | FOREIGN | 5 | reference / mapping |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - formfield]] | `ext_mssql_asset_vision_ven_gen7.dbo.formfield` | FOREIGN | 13 | forms / modules |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - inspection]] | `ext_mssql_asset_vision_ven_gen7.dbo.inspection` | FOREIGN | 49 | inspection / audit / condition |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - inspectionrelationship]] | `ext_mssql_asset_vision_ven_gen7.dbo.inspectionrelationship` | FOREIGN | 8 | inspection / audit / condition |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - inspectionstatus]] | `ext_mssql_asset_vision_ven_gen7.dbo.inspectionstatus` | FOREIGN | 9 | inspection / audit / condition |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - job]] | `ext_mssql_asset_vision_ven_gen7.dbo.job` | FOREIGN | 84 | jobs / work orders |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - jobasset]] | `ext_mssql_asset_vision_ven_gen7.dbo.jobasset` | FOREIGN | 11 | jobs / work orders |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - jobcomment]] | `ext_mssql_asset_vision_ven_gen7.dbo.jobcomment` | FOREIGN | 7 | jobs / work orders |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - log]] | `ext_mssql_asset_vision_ven_gen7.dbo.log` | FOREIGN | 4 |  |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - module]] | `ext_mssql_asset_vision_ven_gen7.dbo.module` | FOREIGN | 28 | forms / modules |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - photo]] | `ext_mssql_asset_vision_ven_gen7.dbo.photo` | FOREIGN | 11 | documents / evidence |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - plannedresourceitem]] | `ext_mssql_asset_vision_ven_gen7.dbo.plannedresourceitem` | FOREIGN | 24 | resources / timesheets |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - resource]] | `ext_mssql_asset_vision_ven_gen7.dbo.resource` | FOREIGN | 21 | resources / timesheets |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - resourceattribute]] | `ext_mssql_asset_vision_ven_gen7.dbo.resourceattribute` | FOREIGN | 9 | resources / timesheets |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - resourceaudit]] | `ext_mssql_asset_vision_ven_gen7.dbo.resourceaudit` | FOREIGN | 9 | inspection / audit / condition |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - summarycheck]] | `ext_mssql_asset_vision_ven_gen7.dbo.summarycheck` | FOREIGN | 8 |  |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - timesheetitem]] | `ext_mssql_asset_vision_ven_gen7.dbo.timesheetitem` | FOREIGN | 24 | resources / timesheets |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - vassetaudit]] | `ext_mssql_asset_vision_ven_gen7.dbo.vassetaudit` | FOREIGN | 12 | asset register / hierarchy |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - vassetlocation]] | `ext_mssql_asset_vision_ven_gen7.dbo.vassetlocation` | FOREIGN | 11 | asset register / hierarchy |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - vcapitalwork]] | `ext_mssql_asset_vision_ven_gen7.dbo.vcapitalwork` | FOREIGN | 29 | capital works / forward works |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - vcapitalworktask]] | `ext_mssql_asset_vision_ven_gen7.dbo.vcapitalworktask` | FOREIGN | 33 | capital works / forward works |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - vinspection]] | `ext_mssql_asset_vision_ven_gen7.dbo.vinspection` | FOREIGN | 50 | inspection / audit / condition |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - vinspectionstatus]] | `ext_mssql_asset_vision_ven_gen7.dbo.vinspectionstatus` | FOREIGN | 10 | inspection / audit / condition |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - vjob]] | `ext_mssql_asset_vision_ven_gen7.dbo.vjob` | FOREIGN | 85 | jobs / work orders |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - vmodule]] | `ext_mssql_asset_vision_ven_gen7.dbo.vmodule` | FOREIGN | 29 | forms / modules |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - vworkflowstatus]] | `ext_mssql_asset_vision_ven_gen7.dbo.vworkflowstatus` | FOREIGN | 15 | workflow / status |  |
| `asset_vision_ven_gen7` | [[Transport Source Table - asset_vision_ven_gen7 - workflowstatus]] | `ext_mssql_asset_vision_ven_gen7.dbo.workflowstatus` | FOREIGN | 14 | workflow / status |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - asset]] | `ext_mssql_asset_vision_ven_rms.dbo.asset` | FOREIGN | 35 | asset register / hierarchy |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - assetarea]] | `ext_mssql_asset_vision_ven_rms.dbo.assetarea` | FOREIGN | 11 | asset register / hierarchy |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - assetattribute]] | `ext_mssql_asset_vision_ven_rms.dbo.assetattribute` | FOREIGN | 9 | asset register / hierarchy |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - assetaudit]] | `ext_mssql_asset_vision_ven_rms.dbo.assetaudit` | FOREIGN | 11 | asset register / hierarchy |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - assetclassification]] | `ext_mssql_asset_vision_ven_rms.dbo.assetclassification` | FOREIGN | 12 | asset register / hierarchy |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - assethierarchy]] | `ext_mssql_asset_vision_ven_rms.dbo.assethierarchy` | FOREIGN | 0 | asset hierarchy |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - assetlocation]] | `ext_mssql_asset_vision_ven_rms.dbo.assetlocation` | FOREIGN | 10 | asset register / hierarchy |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - assetvaluation]] | `ext_mssql_asset_vision_ven_rms.dbo.assetvaluation` | FOREIGN | 0 | asset valuation |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - capitalwork]] | `ext_mssql_asset_vision_ven_rms.dbo.capitalwork` | FOREIGN | 28 | capital works / forward works |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - capitalworktask]] | `ext_mssql_asset_vision_ven_rms.dbo.capitalworktask` | FOREIGN | 32 | capital works / forward works |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - contractreference]] | `ext_mssql_asset_vision_ven_rms.dbo.contractreference` | FOREIGN | 15 | reference / mapping |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - custommoduleitem]] | `ext_mssql_asset_vision_ven_rms.dbo.custommoduleitem` | FOREIGN | 9 | forms / modules |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - exportdate]] | `ext_mssql_asset_vision_ven_rms.dbo.exportdate` | FOREIGN | 4 | reference / mapping |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - exportdatelog]] | `ext_mssql_asset_vision_ven_rms.dbo.exportdatelog` | FOREIGN | 5 | reference / mapping |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - formfield]] | `ext_mssql_asset_vision_ven_rms.dbo.formfield` | FOREIGN | 13 | forms / modules |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - inspection]] | `ext_mssql_asset_vision_ven_rms.dbo.inspection` | FOREIGN | 49 | inspection / audit / condition |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - inspectionrelationship]] | `ext_mssql_asset_vision_ven_rms.dbo.inspectionrelationship` | FOREIGN | 8 | inspection / audit / condition |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - inspectionstatus]] | `ext_mssql_asset_vision_ven_rms.dbo.inspectionstatus` | FOREIGN | 9 | inspection / audit / condition |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - job]] | `ext_mssql_asset_vision_ven_rms.dbo.job` | FOREIGN | 84 | jobs / work orders |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - jobasset]] | `ext_mssql_asset_vision_ven_rms.dbo.jobasset` | FOREIGN | 11 | jobs / work orders |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - jobcomment]] | `ext_mssql_asset_vision_ven_rms.dbo.jobcomment` | FOREIGN | 7 | jobs / work orders |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - log]] | `ext_mssql_asset_vision_ven_rms.dbo.log` | FOREIGN | 4 |  |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - module]] | `ext_mssql_asset_vision_ven_rms.dbo.module` | FOREIGN | 28 | forms / modules |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - photo]] | `ext_mssql_asset_vision_ven_rms.dbo.photo` | FOREIGN | 11 | documents / evidence |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - plannedresourceitem]] | `ext_mssql_asset_vision_ven_rms.dbo.plannedresourceitem` | FOREIGN | 24 | resources / timesheets |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - resource]] | `ext_mssql_asset_vision_ven_rms.dbo.resource` | FOREIGN | 21 | resources / timesheets |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - resourceattribute]] | `ext_mssql_asset_vision_ven_rms.dbo.resourceattribute` | FOREIGN | 9 | resources / timesheets |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - resourceaudit]] | `ext_mssql_asset_vision_ven_rms.dbo.resourceaudit` | FOREIGN | 9 | inspection / audit / condition |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - summarycheck]] | `ext_mssql_asset_vision_ven_rms.dbo.summarycheck` | FOREIGN | 8 |  |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - timesheetitem]] | `ext_mssql_asset_vision_ven_rms.dbo.timesheetitem` | FOREIGN | 24 | resources / timesheets |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - vassetaudit]] | `ext_mssql_asset_vision_ven_rms.dbo.vassetaudit` | FOREIGN | 12 | asset register / hierarchy |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - vassetlocation]] | `ext_mssql_asset_vision_ven_rms.dbo.vassetlocation` | FOREIGN | 11 | asset register / hierarchy |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - vcapitalwork]] | `ext_mssql_asset_vision_ven_rms.dbo.vcapitalwork` | FOREIGN | 29 | capital works / forward works |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - vcapitalworktask]] | `ext_mssql_asset_vision_ven_rms.dbo.vcapitalworktask` | FOREIGN | 33 | capital works / forward works |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - vinspection]] | `ext_mssql_asset_vision_ven_rms.dbo.vinspection` | FOREIGN | 50 | inspection / audit / condition |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - vinspectionstatus]] | `ext_mssql_asset_vision_ven_rms.dbo.vinspectionstatus` | FOREIGN | 10 | inspection / audit / condition |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - vjob]] | `ext_mssql_asset_vision_ven_rms.dbo.vjob` | FOREIGN | 85 | jobs / work orders |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - vmodule]] | `ext_mssql_asset_vision_ven_rms.dbo.vmodule` | FOREIGN | 29 | forms / modules |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - vworkflowstatus]] | `ext_mssql_asset_vision_ven_rms.dbo.vworkflowstatus` | FOREIGN | 15 | workflow / status |  |
| `asset_vision_ven_rms` | [[Transport Source Table - asset_vision_ven_rms - workflowstatus]] | `ext_mssql_asset_vision_ven_rms.dbo.workflowstatus` | FOREIGN | 14 | workflow / status |  |
| `asset_vision_ven_rms_new` | [[Transport Source Table - asset_vision_ven_rms_new - asset]] | `ext_mssql_asset_vision_ven_rms_new.dbo.asset` | FOREIGN | 55 | asset register / hierarchy |  |
| `asset_vision_ven_rms_new` | [[Transport Source Table - asset_vision_ven_rms_new - assetarea]] | `ext_mssql_asset_vision_ven_rms_new.dbo.assetarea` | FOREIGN | 12 | asset register / hierarchy |  |
| `asset_vision_ven_rms_new` | [[Transport Source Table - asset_vision_ven_rms_new - assetattribute]] | `ext_mssql_asset_vision_ven_rms_new.dbo.assetattribute` | FOREIGN | 12 | asset register / hierarchy |  |
| `asset_vision_ven_rms_new` | [[Transport Source Table - asset_vision_ven_rms_new - assetaudit]] | `ext_mssql_asset_vision_ven_rms_new.dbo.assetaudit` | FOREIGN | 0 | asset register / hierarchy |  |
| `asset_vision_ven_rms_new` | [[Transport Source Table - asset_vision_ven_rms_new - assetclassification]] | `ext_mssql_asset_vision_ven_rms_new.dbo.assetclassification` | FOREIGN | 0 | asset register / hierarchy |  |
| `asset_vision_ven_rms_new` | [[Transport Source Table - asset_vision_ven_rms_new - assethierarchy]] | `ext_mssql_asset_vision_ven_rms_new.dbo.assethierarchy` | FOREIGN | 0 | asset register / hierarchy |  |
| `asset_vision_ven_rms_new` | [[Transport Source Table - asset_vision_ven_rms_new - assetlocation]] | `ext_mssql_asset_vision_ven_rms_new.dbo.assetlocation` | FOREIGN | 0 | asset register / hierarchy |  |
| `asset_vision_ven_rms_new` | [[Transport Source Table - asset_vision_ven_rms_new - assetvaluation]] | `ext_mssql_asset_vision_ven_rms_new.dbo.assetvaluation` | FOREIGN | 0 | asset register / hierarchy |  |
| `asset_vision_ven_rms_new` | [[Transport Source Table - asset_vision_ven_rms_new - capitalwork]] | `ext_mssql_asset_vision_ven_rms_new.dbo.capitalwork` | FOREIGN | 35 | capital works / forward works |  |
| `asset_vision_ven_rms_new` | [[Transport Source Table - asset_vision_ven_rms_new - capitalworktask]] | `ext_mssql_asset_vision_ven_rms_new.dbo.capitalworktask` | FOREIGN | 0 | capital works / forward works |  |
| `asset_vision_ven_rms_new` | [[Transport Source Table - asset_vision_ven_rms_new - contractreference]] | `ext_mssql_asset_vision_ven_rms_new.dbo.contractreference` | FOREIGN | 0 | reference / mapping |  |
| `asset_vision_ven_rms_new` | [[Transport Source Table - asset_vision_ven_rms_new - custommoduleitem]] | `ext_mssql_asset_vision_ven_rms_new.dbo.custommoduleitem` | FOREIGN | 10 | forms / modules |  |
| `asset_vision_ven_rms_new` | [[Transport Source Table - asset_vision_ven_rms_new - exportdate]] | `ext_mssql_asset_vision_ven_rms_new.dbo.exportdate` | FOREIGN | 0 | reference / mapping |  |
| `asset_vision_ven_rms_new` | [[Transport Source Table - asset_vision_ven_rms_new - exportdatelog]] | `ext_mssql_asset_vision_ven_rms_new.dbo.exportdatelog` | FOREIGN | 0 | reference / mapping |  |
| `asset_vision_ven_rms_new` | [[Transport Source Table - asset_vision_ven_rms_new - formfield]] | `ext_mssql_asset_vision_ven_rms_new.dbo.formfield` | FOREIGN | 15 | forms / modules |  |
| `asset_vision_ven_rms_new` | [[Transport Source Table - asset_vision_ven_rms_new - inspection]] | `ext_mssql_asset_vision_ven_rms_new.dbo.inspection` | FOREIGN | 62 | inspection / audit / condition |  |
| `asset_vision_ven_rms_new` | [[Transport Source Table - asset_vision_ven_rms_new - inspectionrelationship]] | `ext_mssql_asset_vision_ven_rms_new.dbo.inspectionrelationship` | FOREIGN | 0 | inspection / audit / condition |  |
| `asset_vision_ven_rms_new` | [[Transport Source Table - asset_vision_ven_rms_new - inspectionstatus]] | `ext_mssql_asset_vision_ven_rms_new.dbo.inspectionstatus` | FOREIGN | 10 | inspection / audit / condition |  |
| `asset_vision_ven_rms_new` | [[Transport Source Table - asset_vision_ven_rms_new - job]] | `ext_mssql_asset_vision_ven_rms_new.dbo.job` | FOREIGN | 105 | jobs / work orders |  |
| `asset_vision_ven_rms_new` | [[Transport Source Table - asset_vision_ven_rms_new - jobasset]] | `ext_mssql_asset_vision_ven_rms_new.dbo.jobasset` | FOREIGN | 0 | jobs / work orders |  |
| `asset_vision_ven_rms_new` | [[Transport Source Table - asset_vision_ven_rms_new - jobcomment]] | `ext_mssql_asset_vision_ven_rms_new.dbo.jobcomment` | FOREIGN | 8 | jobs / work orders |  |
| `asset_vision_ven_rms_new` | [[Transport Source Table - asset_vision_ven_rms_new - log]] | `ext_mssql_asset_vision_ven_rms_new.dbo.log` | FOREIGN | 0 |  |  |
| `asset_vision_ven_rms_new` | [[Transport Source Table - asset_vision_ven_rms_new - module]] | `ext_mssql_asset_vision_ven_rms_new.dbo.module` | FOREIGN | 36 | forms / modules |  |
| `asset_vision_ven_rms_new` | [[Transport Source Table - asset_vision_ven_rms_new - photo]] | `ext_mssql_asset_vision_ven_rms_new.dbo.photo` | FOREIGN | 12 | documents / evidence |  |
| `asset_vision_ven_rms_new` | [[Transport Source Table - asset_vision_ven_rms_new - plannedresourceitem]] | `ext_mssql_asset_vision_ven_rms_new.dbo.plannedresourceitem` | FOREIGN | 30 | resources / timesheets |  |
| `asset_vision_ven_rms_new` | [[Transport Source Table - asset_vision_ven_rms_new - resource]] | `ext_mssql_asset_vision_ven_rms_new.dbo.resource` | FOREIGN | 0 | resources / timesheets |  |
| `asset_vision_ven_rms_new` | [[Transport Source Table - asset_vision_ven_rms_new - resourceattribute]] | `ext_mssql_asset_vision_ven_rms_new.dbo.resourceattribute` | FOREIGN | 0 | resources / timesheets |  |
| `asset_vision_ven_rms_new` | [[Transport Source Table - asset_vision_ven_rms_new - resourceaudit]] | `ext_mssql_asset_vision_ven_rms_new.dbo.resourceaudit` | FOREIGN | 0 | inspection / audit / condition |  |
| `asset_vision_ven_rms_new` | [[Transport Source Table - asset_vision_ven_rms_new - summarycheck]] | `ext_mssql_asset_vision_ven_rms_new.dbo.summarycheck` | FOREIGN | 0 |  |  |
| `asset_vision_ven_rms_new` | [[Transport Source Table - asset_vision_ven_rms_new - timesheetitem]] | `ext_mssql_asset_vision_ven_rms_new.dbo.timesheetitem` | FOREIGN | 30 | resources / timesheets |  |
| `asset_vision_ven_rms_new` | [[Transport Source Table - asset_vision_ven_rms_new - vassetaudit]] | `ext_mssql_asset_vision_ven_rms_new.dbo.vassetaudit` | FOREIGN | 0 | asset register / hierarchy |  |
| `asset_vision_ven_rms_new` | [[Transport Source Table - asset_vision_ven_rms_new - vassetlocation]] | `ext_mssql_asset_vision_ven_rms_new.dbo.vassetlocation` | FOREIGN | 12 | asset register / hierarchy |  |
| `asset_vision_ven_rms_new` | [[Transport Source Table - asset_vision_ven_rms_new - vcapitalwork]] | `ext_mssql_asset_vision_ven_rms_new.dbo.vcapitalwork` | FOREIGN | 0 | capital works / forward works |  |
| `asset_vision_ven_rms_new` | [[Transport Source Table - asset_vision_ven_rms_new - vcapitalworktask]] | `ext_mssql_asset_vision_ven_rms_new.dbo.vcapitalworktask` | FOREIGN | 0 | capital works / forward works |  |
| `asset_vision_ven_rms_new` | [[Transport Source Table - asset_vision_ven_rms_new - vinspection]] | `ext_mssql_asset_vision_ven_rms_new.dbo.vinspection` | FOREIGN | 63 | inspection / audit / condition |  |
| `asset_vision_ven_rms_new` | [[Transport Source Table - asset_vision_ven_rms_new - vinspectionstatus]] | `ext_mssql_asset_vision_ven_rms_new.dbo.vinspectionstatus` | FOREIGN | 0 | inspection / audit / condition |  |
| `asset_vision_ven_rms_new` | [[Transport Source Table - asset_vision_ven_rms_new - vjob]] | `ext_mssql_asset_vision_ven_rms_new.dbo.vjob` | FOREIGN | 106 | jobs / work orders |  |
| `asset_vision_ven_rms_new` | [[Transport Source Table - asset_vision_ven_rms_new - vmodule]] | `ext_mssql_asset_vision_ven_rms_new.dbo.vmodule` | FOREIGN | 37 | forms / modules |  |
| `asset_vision_ven_rms_new` | [[Transport Source Table - asset_vision_ven_rms_new - vworkflowstatus]] | `ext_mssql_asset_vision_ven_rms_new.dbo.vworkflowstatus` | FOREIGN | 0 | workflow / status |  |
| `asset_vision_ven_rms_new` | [[Transport Source Table - asset_vision_ven_rms_new - workflowstatus]] | `ext_mssql_asset_vision_ven_rms_new.dbo.workflowstatus` | FOREIGN | 17 | workflow / status |  |
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
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - asset]] | `ext_mssql_asset_vision_ven_vicroads.dbo.asset` | FOREIGN | 35 | asset register / hierarchy |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - assetarea]] | `ext_mssql_asset_vision_ven_vicroads.dbo.assetarea` | FOREIGN | 11 | asset register / hierarchy |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - assetattribute]] | `ext_mssql_asset_vision_ven_vicroads.dbo.assetattribute` | FOREIGN | 9 | asset register / hierarchy |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - assetaudit]] | `ext_mssql_asset_vision_ven_vicroads.dbo.assetaudit` | FOREIGN | 11 | asset register / hierarchy |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - assetclassification]] | `ext_mssql_asset_vision_ven_vicroads.dbo.assetclassification` | FOREIGN | 12 | asset register / hierarchy |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - assetlocation]] | `ext_mssql_asset_vision_ven_vicroads.dbo.assetlocation` | FOREIGN | 10 | asset register / hierarchy |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - capitalwork]] | `ext_mssql_asset_vision_ven_vicroads.dbo.capitalwork` | FOREIGN | 28 | capital works / forward works |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - capitalworktask]] | `ext_mssql_asset_vision_ven_vicroads.dbo.capitalworktask` | FOREIGN | 32 | capital works / forward works |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - contractreference]] | `ext_mssql_asset_vision_ven_vicroads.dbo.contractreference` | FOREIGN | 15 | reference / mapping |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - custommoduleitem]] | `ext_mssql_asset_vision_ven_vicroads.dbo.custommoduleitem` | FOREIGN | 9 | forms / modules |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - exportdate]] | `ext_mssql_asset_vision_ven_vicroads.dbo.exportdate` | FOREIGN | 4 | reference / mapping |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - exportdatelog]] | `ext_mssql_asset_vision_ven_vicroads.dbo.exportdatelog` | FOREIGN | 5 | reference / mapping |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - formfield]] | `ext_mssql_asset_vision_ven_vicroads.dbo.formfield` | FOREIGN | 13 | forms / modules |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - inspection]] | `ext_mssql_asset_vision_ven_vicroads.dbo.inspection` | FOREIGN | 49 | inspection / audit / condition |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - inspectionrelationship]] | `ext_mssql_asset_vision_ven_vicroads.dbo.inspectionrelationship` | FOREIGN | 8 | inspection / audit / condition |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - inspectionstatus]] | `ext_mssql_asset_vision_ven_vicroads.dbo.inspectionstatus` | FOREIGN | 9 | inspection / audit / condition |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - job]] | `ext_mssql_asset_vision_ven_vicroads.dbo.job` | FOREIGN | 84 | jobs / work orders |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - jobasset]] | `ext_mssql_asset_vision_ven_vicroads.dbo.jobasset` | FOREIGN | 11 | jobs / work orders |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - jobcomment]] | `ext_mssql_asset_vision_ven_vicroads.dbo.jobcomment` | FOREIGN | 7 | jobs / work orders |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - laneaccess]] | `ext_mssql_asset_vision_ven_vicroads.dbo.laneaccess` | FOREIGN | 56 | lane access |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - log]] | `ext_mssql_asset_vision_ven_vicroads.dbo.log` | FOREIGN | 4 |  |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - module]] | `ext_mssql_asset_vision_ven_vicroads.dbo.module` | FOREIGN | 28 | forms / modules |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - photo]] | `ext_mssql_asset_vision_ven_vicroads.dbo.photo` | FOREIGN | 11 | documents / evidence |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - plannedresourceitem]] | `ext_mssql_asset_vision_ven_vicroads.dbo.plannedresourceitem` | FOREIGN | 24 | resources / timesheets |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - resource]] | `ext_mssql_asset_vision_ven_vicroads.dbo.resource` | FOREIGN | 21 | resources / timesheets |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - resourceattribute]] | `ext_mssql_asset_vision_ven_vicroads.dbo.resourceattribute` | FOREIGN | 9 | resources / timesheets |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - resourceaudit]] | `ext_mssql_asset_vision_ven_vicroads.dbo.resourceaudit` | FOREIGN | 9 | inspection / audit / condition |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - sqlserverversions]] | `ext_mssql_asset_vision_ven_vicroads.dbo.sqlserverversions` | FOREIGN | 9 |  |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - summarycheck]] | `ext_mssql_asset_vision_ven_vicroads.dbo.summarycheck` | FOREIGN | 8 |  |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - timesheetitem]] | `ext_mssql_asset_vision_ven_vicroads.dbo.timesheetitem` | FOREIGN | 24 | resources / timesheets |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - vassetaudit]] | `ext_mssql_asset_vision_ven_vicroads.dbo.vassetaudit` | FOREIGN | 12 | asset register / hierarchy |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - vassetlocation]] | `ext_mssql_asset_vision_ven_vicroads.dbo.vassetlocation` | FOREIGN | 11 | asset register / hierarchy |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - vcapitalwork]] | `ext_mssql_asset_vision_ven_vicroads.dbo.vcapitalwork` | FOREIGN | 29 | capital works / forward works |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - vcapitalworktask]] | `ext_mssql_asset_vision_ven_vicroads.dbo.vcapitalworktask` | FOREIGN | 33 | capital works / forward works |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - vinspection]] | `ext_mssql_asset_vision_ven_vicroads.dbo.vinspection` | FOREIGN | 50 | inspection / audit / condition |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - vinspectionstatus]] | `ext_mssql_asset_vision_ven_vicroads.dbo.vinspectionstatus` | FOREIGN | 10 | inspection / audit / condition |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - vjob]] | `ext_mssql_asset_vision_ven_vicroads.dbo.vjob` | FOREIGN | 85 | jobs / work orders |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - vmodule]] | `ext_mssql_asset_vision_ven_vicroads.dbo.vmodule` | FOREIGN | 29 | forms / modules |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - vworkflowstatus]] | `ext_mssql_asset_vision_ven_vicroads.dbo.vworkflowstatus` | FOREIGN | 15 | workflow / status |  |
| `asset_vision_ven_vicroads` | [[Transport Source Table - asset_vision_ven_vicroads - workflowstatus]] | `ext_mssql_asset_vision_ven_vicroads.dbo.workflowstatus` | FOREIGN | 14 | workflow / status |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - asset]] | `ext_mssql_asset_vision_vns_gen7.dbo.asset` | FOREIGN | 35 | asset register / hierarchy |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - assetarea]] | `ext_mssql_asset_vision_vns_gen7.dbo.assetarea` | FOREIGN | 11 | asset register / hierarchy |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - assetattribute]] | `ext_mssql_asset_vision_vns_gen7.dbo.assetattribute` | FOREIGN | 9 | asset register / hierarchy |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - assetaudit]] | `ext_mssql_asset_vision_vns_gen7.dbo.assetaudit` | FOREIGN | 11 | asset register / hierarchy |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - assetclassification]] | `ext_mssql_asset_vision_vns_gen7.dbo.assetclassification` | FOREIGN | 12 | asset register / hierarchy |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - assetlocation]] | `ext_mssql_asset_vision_vns_gen7.dbo.assetlocation` | FOREIGN | 10 | asset register / hierarchy |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - capitalwork]] | `ext_mssql_asset_vision_vns_gen7.dbo.capitalwork` | FOREIGN | 28 | capital works / forward works |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - capitalworktask]] | `ext_mssql_asset_vision_vns_gen7.dbo.capitalworktask` | FOREIGN | 32 | capital works / forward works |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - contractreference]] | `ext_mssql_asset_vision_vns_gen7.dbo.contractreference` | FOREIGN | 15 | reference / mapping |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - custommoduleitem]] | `ext_mssql_asset_vision_vns_gen7.dbo.custommoduleitem` | FOREIGN | 9 | forms / modules |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - exportdate]] | `ext_mssql_asset_vision_vns_gen7.dbo.exportdate` | FOREIGN | 4 | reference / mapping |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - exportdatelog]] | `ext_mssql_asset_vision_vns_gen7.dbo.exportdatelog` | FOREIGN | 5 | reference / mapping |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - formfield]] | `ext_mssql_asset_vision_vns_gen7.dbo.formfield` | FOREIGN | 13 | forms / modules |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - inspection]] | `ext_mssql_asset_vision_vns_gen7.dbo.inspection` | FOREIGN | 49 | inspection / audit / condition |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - inspectionrelationship]] | `ext_mssql_asset_vision_vns_gen7.dbo.inspectionrelationship` | FOREIGN | 8 | inspection / audit / condition |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - inspectionstatus]] | `ext_mssql_asset_vision_vns_gen7.dbo.inspectionstatus` | FOREIGN | 9 | inspection / audit / condition |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - job]] | `ext_mssql_asset_vision_vns_gen7.dbo.job` | FOREIGN | 84 | jobs / work orders |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - jobasset]] | `ext_mssql_asset_vision_vns_gen7.dbo.jobasset` | FOREIGN | 11 | jobs / work orders |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - jobcomment]] | `ext_mssql_asset_vision_vns_gen7.dbo.jobcomment` | FOREIGN | 7 | jobs / work orders |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - log]] | `ext_mssql_asset_vision_vns_gen7.dbo.log` | FOREIGN | 4 |  |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - module]] | `ext_mssql_asset_vision_vns_gen7.dbo.module` | FOREIGN | 28 | forms / modules |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - photo]] | `ext_mssql_asset_vision_vns_gen7.dbo.photo` | FOREIGN | 11 | documents / evidence |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - plannedresourceitem]] | `ext_mssql_asset_vision_vns_gen7.dbo.plannedresourceitem` | FOREIGN | 24 | resources / timesheets |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - resource]] | `ext_mssql_asset_vision_vns_gen7.dbo.resource` | FOREIGN | 21 | resources / timesheets |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - resourceattribute]] | `ext_mssql_asset_vision_vns_gen7.dbo.resourceattribute` | FOREIGN | 9 | resources / timesheets |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - resourceaudit]] | `ext_mssql_asset_vision_vns_gen7.dbo.resourceaudit` | FOREIGN | 9 | inspection / audit / condition |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - summarycheck]] | `ext_mssql_asset_vision_vns_gen7.dbo.summarycheck` | FOREIGN | 8 |  |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - timesheetitem]] | `ext_mssql_asset_vision_vns_gen7.dbo.timesheetitem` | FOREIGN | 24 | resources / timesheets |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - vassetaudit]] | `ext_mssql_asset_vision_vns_gen7.dbo.vassetaudit` | FOREIGN | 12 | asset register / hierarchy |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - vassetlocation]] | `ext_mssql_asset_vision_vns_gen7.dbo.vassetlocation` | FOREIGN | 11 | asset register / hierarchy |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - vcapitalwork]] | `ext_mssql_asset_vision_vns_gen7.dbo.vcapitalwork` | FOREIGN | 29 | capital works / forward works |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - vcapitalworktask]] | `ext_mssql_asset_vision_vns_gen7.dbo.vcapitalworktask` | FOREIGN | 33 | capital works / forward works |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - vinspection]] | `ext_mssql_asset_vision_vns_gen7.dbo.vinspection` | FOREIGN | 50 | inspection / audit / condition |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - vinspectionstatus]] | `ext_mssql_asset_vision_vns_gen7.dbo.vinspectionstatus` | FOREIGN | 10 | inspection / audit / condition |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - vjob]] | `ext_mssql_asset_vision_vns_gen7.dbo.vjob` | FOREIGN | 85 | jobs / work orders |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - vmodule]] | `ext_mssql_asset_vision_vns_gen7.dbo.vmodule` | FOREIGN | 29 | forms / modules |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - vworkflowstatus]] | `ext_mssql_asset_vision_vns_gen7.dbo.vworkflowstatus` | FOREIGN | 15 | workflow / status |  |
| `asset_vision_vns_gen7` | [[Transport Source Table - asset_vision_vns_gen7 - workflowstatus]] | `ext_mssql_asset_vision_vns_gen7.dbo.workflowstatus` | FOREIGN | 14 | workflow / status |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - asset]] | `ext_mssql_asset_vision_vnz_gen7.dbo.asset` | FOREIGN | 35 | asset register / hierarchy |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - assetarea]] | `ext_mssql_asset_vision_vnz_gen7.dbo.assetarea` | FOREIGN | 11 | asset register / hierarchy |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - assetattribute]] | `ext_mssql_asset_vision_vnz_gen7.dbo.assetattribute` | FOREIGN | 9 | asset register / hierarchy |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - assetaudit]] | `ext_mssql_asset_vision_vnz_gen7.dbo.assetaudit` | FOREIGN | 11 | asset register / hierarchy |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - assetclassification]] | `ext_mssql_asset_vision_vnz_gen7.dbo.assetclassification` | FOREIGN | 12 | asset register / hierarchy |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - assetlocation]] | `ext_mssql_asset_vision_vnz_gen7.dbo.assetlocation` | FOREIGN | 10 | asset register / hierarchy |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - capitalwork]] | `ext_mssql_asset_vision_vnz_gen7.dbo.capitalwork` | FOREIGN | 28 | capital works / forward works |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - capitalworktask]] | `ext_mssql_asset_vision_vnz_gen7.dbo.capitalworktask` | FOREIGN | 32 | capital works / forward works |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - contractreference]] | `ext_mssql_asset_vision_vnz_gen7.dbo.contractreference` | FOREIGN | 15 | reference / mapping |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - custommoduleitem]] | `ext_mssql_asset_vision_vnz_gen7.dbo.custommoduleitem` | FOREIGN | 9 | forms / modules |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - exportdate]] | `ext_mssql_asset_vision_vnz_gen7.dbo.exportdate` | FOREIGN | 4 | reference / mapping |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - exportdatelog]] | `ext_mssql_asset_vision_vnz_gen7.dbo.exportdatelog` | FOREIGN | 5 | reference / mapping |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - formfield]] | `ext_mssql_asset_vision_vnz_gen7.dbo.formfield` | FOREIGN | 13 | forms / modules |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - inspection]] | `ext_mssql_asset_vision_vnz_gen7.dbo.inspection` | FOREIGN | 49 | inspection / audit / condition |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - inspectionrelationship]] | `ext_mssql_asset_vision_vnz_gen7.dbo.inspectionrelationship` | FOREIGN | 8 | inspection / audit / condition |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - inspectionstatus]] | `ext_mssql_asset_vision_vnz_gen7.dbo.inspectionstatus` | FOREIGN | 9 | inspection / audit / condition |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - job]] | `ext_mssql_asset_vision_vnz_gen7.dbo.job` | FOREIGN | 84 | jobs / work orders |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - jobasset]] | `ext_mssql_asset_vision_vnz_gen7.dbo.jobasset` | FOREIGN | 11 | jobs / work orders |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - jobcomment]] | `ext_mssql_asset_vision_vnz_gen7.dbo.jobcomment` | FOREIGN | 7 | jobs / work orders |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - log]] | `ext_mssql_asset_vision_vnz_gen7.dbo.log` | FOREIGN | 4 |  |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - module]] | `ext_mssql_asset_vision_vnz_gen7.dbo.module` | FOREIGN | 28 | forms / modules |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - photo]] | `ext_mssql_asset_vision_vnz_gen7.dbo.photo` | FOREIGN | 11 | documents / evidence |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - plannedresourceitem]] | `ext_mssql_asset_vision_vnz_gen7.dbo.plannedresourceitem` | FOREIGN | 24 | resources / timesheets |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - resource]] | `ext_mssql_asset_vision_vnz_gen7.dbo.resource` | FOREIGN | 21 | resources / timesheets |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - resourceattribute]] | `ext_mssql_asset_vision_vnz_gen7.dbo.resourceattribute` | FOREIGN | 9 | resources / timesheets |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - resourceaudit]] | `ext_mssql_asset_vision_vnz_gen7.dbo.resourceaudit` | FOREIGN | 9 | inspection / audit / condition |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - summarycheck]] | `ext_mssql_asset_vision_vnz_gen7.dbo.summarycheck` | FOREIGN | 8 |  |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - timesheetitem]] | `ext_mssql_asset_vision_vnz_gen7.dbo.timesheetitem` | FOREIGN | 24 | resources / timesheets |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - vassetaudit]] | `ext_mssql_asset_vision_vnz_gen7.dbo.vassetaudit` | FOREIGN | 12 | asset register / hierarchy |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - vassetlocation]] | `ext_mssql_asset_vision_vnz_gen7.dbo.vassetlocation` | FOREIGN | 11 | asset register / hierarchy |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - vcapitalwork]] | `ext_mssql_asset_vision_vnz_gen7.dbo.vcapitalwork` | FOREIGN | 29 | capital works / forward works |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - vcapitalworktask]] | `ext_mssql_asset_vision_vnz_gen7.dbo.vcapitalworktask` | FOREIGN | 33 | capital works / forward works |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - vinspection]] | `ext_mssql_asset_vision_vnz_gen7.dbo.vinspection` | FOREIGN | 50 | inspection / audit / condition |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - vinspectionstatus]] | `ext_mssql_asset_vision_vnz_gen7.dbo.vinspectionstatus` | FOREIGN | 10 | inspection / audit / condition |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - vjob]] | `ext_mssql_asset_vision_vnz_gen7.dbo.vjob` | FOREIGN | 85 | jobs / work orders |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - vmodule]] | `ext_mssql_asset_vision_vnz_gen7.dbo.vmodule` | FOREIGN | 29 | forms / modules |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - vworkflowstatus]] | `ext_mssql_asset_vision_vnz_gen7.dbo.vworkflowstatus` | FOREIGN | 15 | workflow / status |  |
| `asset_vision_vnz_gen7` | [[Transport Source Table - asset_vision_vnz_gen7 - workflowstatus]] | `ext_mssql_asset_vision_vnz_gen7.dbo.workflowstatus` | FOREIGN | 14 | workflow / status |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - asset]] | `ext_mssql_asset_vision_vsm_gen7.dbo.asset` | FOREIGN | 35 | asset register / hierarchy |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - assetarea]] | `ext_mssql_asset_vision_vsm_gen7.dbo.assetarea` | FOREIGN | 11 | asset register / hierarchy |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - assetattribute]] | `ext_mssql_asset_vision_vsm_gen7.dbo.assetattribute` | FOREIGN | 9 | asset register / hierarchy |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - assetaudit]] | `ext_mssql_asset_vision_vsm_gen7.dbo.assetaudit` | FOREIGN | 11 | asset register / hierarchy |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - assetclassification]] | `ext_mssql_asset_vision_vsm_gen7.dbo.assetclassification` | FOREIGN | 12 | asset register / hierarchy |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - assetlocation]] | `ext_mssql_asset_vision_vsm_gen7.dbo.assetlocation` | FOREIGN | 10 | asset register / hierarchy |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - capitalwork]] | `ext_mssql_asset_vision_vsm_gen7.dbo.capitalwork` | FOREIGN | 28 | capital works / forward works |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - capitalworktask]] | `ext_mssql_asset_vision_vsm_gen7.dbo.capitalworktask` | FOREIGN | 32 | capital works / forward works |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - contractreference]] | `ext_mssql_asset_vision_vsm_gen7.dbo.contractreference` | FOREIGN | 15 | reference / mapping |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - custommoduleitem]] | `ext_mssql_asset_vision_vsm_gen7.dbo.custommoduleitem` | FOREIGN | 9 | forms / modules |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - exportdate]] | `ext_mssql_asset_vision_vsm_gen7.dbo.exportdate` | FOREIGN | 4 | reference / mapping |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - exportdatelog]] | `ext_mssql_asset_vision_vsm_gen7.dbo.exportdatelog` | FOREIGN | 5 | reference / mapping |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - formfield]] | `ext_mssql_asset_vision_vsm_gen7.dbo.formfield` | FOREIGN | 13 | forms / modules |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - inspection]] | `ext_mssql_asset_vision_vsm_gen7.dbo.inspection` | FOREIGN | 49 | inspection / audit / condition |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - inspectionrelationship]] | `ext_mssql_asset_vision_vsm_gen7.dbo.inspectionrelationship` | FOREIGN | 8 | inspection / audit / condition |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - inspectionstatus]] | `ext_mssql_asset_vision_vsm_gen7.dbo.inspectionstatus` | FOREIGN | 9 | inspection / audit / condition |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - job]] | `ext_mssql_asset_vision_vsm_gen7.dbo.job` | FOREIGN | 84 | jobs / work orders |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - jobasset]] | `ext_mssql_asset_vision_vsm_gen7.dbo.jobasset` | FOREIGN | 11 | jobs / work orders |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - jobcomment]] | `ext_mssql_asset_vision_vsm_gen7.dbo.jobcomment` | FOREIGN | 7 | jobs / work orders |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - log]] | `ext_mssql_asset_vision_vsm_gen7.dbo.log` | FOREIGN | 4 |  |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - module]] | `ext_mssql_asset_vision_vsm_gen7.dbo.module` | FOREIGN | 28 | forms / modules |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - photo]] | `ext_mssql_asset_vision_vsm_gen7.dbo.photo` | FOREIGN | 11 | documents / evidence |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - plannedresourceitem]] | `ext_mssql_asset_vision_vsm_gen7.dbo.plannedresourceitem` | FOREIGN | 24 | resources / timesheets |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - resource]] | `ext_mssql_asset_vision_vsm_gen7.dbo.resource` | FOREIGN | 21 | resources / timesheets |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - resourceattribute]] | `ext_mssql_asset_vision_vsm_gen7.dbo.resourceattribute` | FOREIGN | 9 | resources / timesheets |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - resourceaudit]] | `ext_mssql_asset_vision_vsm_gen7.dbo.resourceaudit` | FOREIGN | 9 | inspection / audit / condition |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - summarycheck]] | `ext_mssql_asset_vision_vsm_gen7.dbo.summarycheck` | FOREIGN | 8 |  |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - timesheetitem]] | `ext_mssql_asset_vision_vsm_gen7.dbo.timesheetitem` | FOREIGN | 24 | resources / timesheets |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - vassetaudit]] | `ext_mssql_asset_vision_vsm_gen7.dbo.vassetaudit` | FOREIGN | 12 | asset register / hierarchy |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - vassetlocation]] | `ext_mssql_asset_vision_vsm_gen7.dbo.vassetlocation` | FOREIGN | 11 | asset register / hierarchy |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - vcapitalwork]] | `ext_mssql_asset_vision_vsm_gen7.dbo.vcapitalwork` | FOREIGN | 29 | capital works / forward works |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - vcapitalworktask]] | `ext_mssql_asset_vision_vsm_gen7.dbo.vcapitalworktask` | FOREIGN | 33 | capital works / forward works |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - vinspection]] | `ext_mssql_asset_vision_vsm_gen7.dbo.vinspection` | FOREIGN | 50 | inspection / audit / condition |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - vinspectionstatus]] | `ext_mssql_asset_vision_vsm_gen7.dbo.vinspectionstatus` | FOREIGN | 10 | inspection / audit / condition |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - vjob]] | `ext_mssql_asset_vision_vsm_gen7.dbo.vjob` | FOREIGN | 85 | jobs / work orders |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - vmodule]] | `ext_mssql_asset_vision_vsm_gen7.dbo.vmodule` | FOREIGN | 29 | forms / modules |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - vworkflowstatus]] | `ext_mssql_asset_vision_vsm_gen7.dbo.vworkflowstatus` | FOREIGN | 15 | workflow / status |  |
| `asset_vision_vsm_gen7` | [[Transport Source Table - asset_vision_vsm_gen7 - workflowstatus]] | `ext_mssql_asset_vision_vsm_gen7.dbo.workflowstatus` | FOREIGN | 14 | workflow / status |  |
| `formitize_srapc` | [[Transport Table - formitize_srapc - _attachments]] | `transport_dev.formitize_srapc._attachments` | MANAGED | 9 | documents / evidence |  |
| `formitize_srapc` | [[Transport Table - formitize_srapc - _json_structure]] | `transport_dev.formitize_srapc._json_structure` | MANAGED | 24 |  |  |
| `formitize_srapc` | [[Transport Table - formitize_srapc - civil_maintenance_pre_start_form]] | `transport_dev.formitize_srapc.civil_maintenance_pre_start_form` | MANAGED | 53 | forms / modules |  |
| `formitize_srapc` | [[Transport Table - formitize_srapc - pre_start_checklist_light_and_heavy_vehicles]] | `transport_dev.formitize_srapc.pre_start_checklist_light_and_heavy_vehicles` | MANAGED | 53 |  |  |
| `formitize_srapc` | [[Transport Table - formitize_srapc - srap_parkland_sustainable_procurement_questionnaire]] | `transport_dev.formitize_srapc.srap_parkland_sustainable_procurement_questionnaire` | MANAGED | 128 | forms / modules |  |
| `formitize_srapc` | [[Transport Table - formitize_srapc - srapc_monthly_subcontractor_data_capture_portal]] | `transport_dev.formitize_srapc.srapc_monthly_subcontractor_data_capture_portal` | MANAGED | 291 |  |  |
| `formitize_srapc` | [[Transport Table - formitize_srapc - srapc_monthly_subcontractor_data_capture_portal_fuel_stationary]] | `transport_dev.formitize_srapc.srapc_monthly_subcontractor_data_capture_portal_fuel_stationary` | MANAGED | 14 |  |  |
| `stg_enterprise_reporting` | [[Transport Table - stg_enterprise_reporting - uvw_completed_po]] | `transport_dev.stg_enterprise_reporting.uvw_completed_po` | VIEW | 52 |  |  |
| `stg_enterprise_reporting` | [[Transport Table - stg_enterprise_reporting - uvw_completed_pos_with_ageing]] | `transport_dev.stg_enterprise_reporting.uvw_completed_pos_with_ageing` | VIEW | 52 |  |  |
| `stg_enterprise_reporting` | [[Transport Table - stg_enterprise_reporting - uvw_dts_allowances_data_r2]] | `transport_dev.stg_enterprise_reporting.uvw_dts_allowances_data_r2` | VIEW | 3 |  |  |
| `stg_enterprise_reporting` | [[Transport Table - stg_enterprise_reporting - uvw_dts_allowances_prod_data]] | `transport_dev.stg_enterprise_reporting.uvw_dts_allowances_prod_data` | VIEW | 5 |  |  |
| `stg_enterprise_reporting` | [[Transport Table - stg_enterprise_reporting - uvw_dts_comments_data_r2]] | `transport_dev.stg_enterprise_reporting.uvw_dts_comments_data_r2` | VIEW | 3 |  |  |
| `stg_enterprise_reporting` | [[Transport Table - stg_enterprise_reporting - uvw_dts_comments_prod_data]] | `transport_dev.stg_enterprise_reporting.uvw_dts_comments_prod_data` | VIEW | 5 |  |  |
| `stg_enterprise_reporting` | [[Transport Table - stg_enterprise_reporting - uvw_dts_testing_data]] | `transport_dev.stg_enterprise_reporting.uvw_dts_testing_data` | VIEW | 53 |  |  |
| `stg_enterprise_reporting` | [[Transport Table - stg_enterprise_reporting - uvw_dts_time_data_new_r2]] | `transport_dev.stg_enterprise_reporting.uvw_dts_time_data_new_r2` | VIEW | 53 |  |  |
| `stg_enterprise_reporting` | [[Transport Table - stg_enterprise_reporting - uvw_dts_time_data_new_with_comments_allowances_r2]] | `transport_dev.stg_enterprise_reporting.uvw_dts_time_data_new_with_comments_allowances_r2` | VIEW | 55 |  |  |
| `stg_enterprise_reporting` | [[Transport Table - stg_enterprise_reporting - uvw_dts_time_prod_data]] | `transport_dev.stg_enterprise_reporting.uvw_dts_time_prod_data` | VIEW | 51 |  |  |
| `stg_enterprise_reporting` | [[Transport Table - stg_enterprise_reporting - uvw_dts_time_prod_data_new_with_comments_allowances]] | `transport_dev.stg_enterprise_reporting.uvw_dts_time_prod_data_new_with_comments_allowances` | VIEW | 54 |  |  |
| `stg_enterprise_reporting` | [[Transport Table - stg_enterprise_reporting - uvw_gr_ir_against_ses_ekbe]] | `transport_dev.stg_enterprise_reporting.uvw_gr_ir_against_ses_ekbe` | VIEW | 8 |  |  |
| `stg_enterprise_reporting` | [[Transport Table - stg_enterprise_reporting - uvw_po_account_assignment_ekkn]] | `transport_dev.stg_enterprise_reporting.uvw_po_account_assignment_ekkn` | VIEW | 18 | commercial / finance |  |
| `stg_enterprise_reporting` | [[Transport Table - stg_enterprise_reporting - uvw_po_commitment_status]] | `transport_dev.stg_enterprise_reporting.uvw_po_commitment_status` | VIEW | 43 | workflow / status |  |
| `stg_enterprise_reporting` | [[Transport Table - stg_enterprise_reporting - uvw_po_delivery_dates_eket]] | `transport_dev.stg_enterprise_reporting.uvw_po_delivery_dates_eket` | VIEW | 4 | commercial / finance |  |
| `stg_enterprise_reporting` | [[Transport Table - stg_enterprise_reporting - uvw_po_header_item_data_ekko_ekpo_main]] | `transport_dev.stg_enterprise_reporting.uvw_po_header_item_data_ekko_ekpo_main` | VIEW | 30 | commercial / finance |  |
| `stg_enterprise_reporting` | [[Transport Table - stg_enterprise_reporting - uvw_po_header_item_data_ekko_ekpo_rest]] | `transport_dev.stg_enterprise_reporting.uvw_po_header_item_data_ekko_ekpo_rest` | VIEW | 30 | commercial / finance |  |
| `stg_enterprise_reporting` | [[Transport Table - stg_enterprise_reporting - uvw_po_history_ekbe]] | `transport_dev.stg_enterprise_reporting.uvw_po_history_ekbe` | VIEW | 11 | commercial / finance |  |
| `stg_enterprise_reporting` | [[Transport Table - stg_enterprise_reporting - uvw_po_history_ekbe_open_commitment]] | `transport_dev.stg_enterprise_reporting.uvw_po_history_ekbe_open_commitment` | VIEW | 12 | commercial / finance |  |
| `stg_enterprise_reporting` | [[Transport Table - stg_enterprise_reporting - uvw_po_open_commitment]] | `transport_dev.stg_enterprise_reporting.uvw_po_open_commitment` | VIEW | 52 | commercial / finance |  |
| `stg_enterprise_reporting` | [[Transport Table - stg_enterprise_reporting - uvw_po_open_commitment_with_ageing]] | `transport_dev.stg_enterprise_reporting.uvw_po_open_commitment_with_ageing` | VIEW | 52 | commercial / finance |  |
| `stg_enterprise_reporting` | [[Transport Table - stg_enterprise_reporting - uvw_po_service_entry_lines_rawdata_esll]] | `transport_dev.stg_enterprise_reporting.uvw_po_service_entry_lines_rawdata_esll` | VIEW | 3 | commercial / finance |  |
| `stg_enterprise_reporting` | [[Transport Table - stg_enterprise_reporting - uvw_po_service_package_account_assignment_eskn]] | `transport_dev.stg_enterprise_reporting.uvw_po_service_package_account_assignment_eskn` | VIEW | 8 | commercial / finance |  |
| `stg_enterprise_reporting` | [[Transport Table - stg_enterprise_reporting - uvw_purgrp]] | `transport_dev.stg_enterprise_reporting.uvw_purgrp` | VIEW | 3 |  |  |
| `stg_enterprise_reporting` | [[Transport Table - stg_enterprise_reporting - uvw_sap_employee_master_data]] | `transport_dev.stg_enterprise_reporting.uvw_sap_employee_master_data` | VIEW | 24 | commercial / finance |  |
| `stg_enterprise_reporting` | [[Transport Table - stg_enterprise_reporting - uvw_sap_open_commitment_line_items_with_pur_grp]] | `transport_dev.stg_enterprise_reporting.uvw_sap_open_commitment_line_items_with_pur_grp` | VIEW | 51 | commercial / finance |  |
| `transport` | [[Transport Table - transport - utbl_job_costing_timesheets_all_contracts]] | `transport_dev.transport.utbl_job_costing_timesheets_all_contracts` | MANAGED | 50 | jobs / work orders |  |
| `transport` | [[Transport Table - transport - utbl_jobs_allcontract]] | `transport_dev.transport.utbl_jobs_allcontract` | MANAGED | 83 | jobs / work orders |  |
| `transport` | [[Transport Table - transport - utbl_jobs_formfield_allcontract]] | `transport_dev.transport.utbl_jobs_formfield_allcontract` | MANAGED | 14 | jobs / work orders |  |
| `transport` | [[Transport Table - transport - utbl_ref_job_costing_fault_map]] | `transport_dev.transport.utbl_ref_job_costing_fault_map` | MANAGED | 4 | jobs / work orders | Created by the file upload UI |
| `transport` | [[Transport Table - transport - utbl_ref_job_costing_std_road_class]] | `transport_dev.transport.utbl_ref_job_costing_std_road_class` | MANAGED | 5 | jobs / work orders | Created by the file upload UI |
| `transport` | [[Transport Table - transport - utbl_resource_allcontract]] | `transport_dev.transport.utbl_resource_allcontract` | MANAGED | 22 | resources / timesheets |  |
| `transport` | [[Transport Table - transport - utbl_sap_items_20_24_fy]] | `transport_dev.transport.utbl_sap_items_20_24_fy` | MANAGED | 22 | commercial / finance | Created by the file upload UI |
| `transport` | [[Transport Table - transport - utbl_timesheetitem_jobs_allcontract]] | `transport_dev.transport.utbl_timesheetitem_jobs_allcontract` | MANAGED | 25 | jobs / work orders |  |
| `transport` | [[Transport Table - transport - uvw_catsdata]] | `transport_dev.transport.uvw_catsdata` | VIEW | 22 |  |  |
| `transport` | [[Transport Table - transport - uvw_cc_budget_forecast_data_cosp]] | `transport_dev.transport.uvw_cc_budget_forecast_data_cosp` | VIEW | 22 | weather |  |
| `transport` | [[Transport Table - transport - uvw_cc_master_data_csks]] | `transport_dev.transport.uvw_cc_master_data_csks` | VIEW | 4 |  |  |
| `transport` | [[Transport Table - transport - uvw_cc_masterdata]] | `transport_dev.transport.uvw_cc_masterdata` | VIEW | 6 |  |  |
| `transport` | [[Transport Table - transport - uvw_completed_po_with_ageing_transport]] | `transport_dev.transport.uvw_completed_po_with_ageing_transport` | VIEW | 52 | commercial / finance |  |
| `transport` | [[Transport Table - transport - uvw_controlling_doc_transport]] | `transport_dev.transport.uvw_controlling_doc_transport` | VIEW | 56 |  |  |
| `transport` | [[Transport Table - transport - uvw_employee_listing]] | `transport_dev.transport.uvw_employee_listing` | VIEW | 15 |  |  |
| `transport` | [[Transport Table - transport - uvw_equipment_deppostings_anlp]] | `transport_dev.transport.uvw_equipment_deppostings_anlp` | VIEW | 20 |  |  |
| `transport` | [[Transport Table - transport - uvw_equipment_master_data_ie36]] | `transport_dev.transport.uvw_equipment_master_data_ie36` | VIEW | 73 |  |  |
| `transport` | [[Transport Table - transport - uvw_equipment_nbv_dep_zftm_asseteqip]] | `transport_dev.transport.uvw_equipment_nbv_dep_zftm_asseteqip` | VIEW | 66 | asset register / hierarchy |  |
| `transport` | [[Transport Table - transport - uvw_pc_masterdata]] | `transport_dev.transport.uvw_pc_masterdata` | VIEW | 29 |  |  |
| `transport` | [[Transport Table - transport - uvw_po_account_assignment_ekkn]] | `transport_dev.transport.uvw_po_account_assignment_ekkn` | VIEW | 15 | commercial / finance |  |
| `transport` | [[Transport Table - transport - uvw_po_delivery_dates_eket]] | `transport_dev.transport.uvw_po_delivery_dates_eket` | VIEW | 4 | commercial / finance |  |
| `transport` | [[Transport Table - transport - uvw_po_header_data_ekko]] | `transport_dev.transport.uvw_po_header_data_ekko` | VIEW | 11 | commercial / finance |  |
| `transport` | [[Transport Table - transport - uvw_po_history_ekbe]] | `transport_dev.transport.uvw_po_history_ekbe` | VIEW | 17 | commercial / finance |  |
| `transport` | [[Transport Table - transport - uvw_po_item_data_ekpo]] | `transport_dev.transport.uvw_po_item_data_ekpo` | VIEW | 23 | commercial / finance |  |
| `transport` | [[Transport Table - transport - uvw_po_open_commitment_with_ageing_transport]] | `transport_dev.transport.uvw_po_open_commitment_with_ageing_transport` | VIEW | 52 | commercial / finance |  |
| `transport` | [[Transport Table - transport - uvw_po_service_entry_header_data_essr]] | `transport_dev.transport.uvw_po_service_entry_header_data_essr` | VIEW | 18 | commercial / finance |  |
| `transport` | [[Transport Table - transport - uvw_po_service_entry_lines_rawdata_esll]] | `transport_dev.transport.uvw_po_service_entry_lines_rawdata_esll` | VIEW | 12 | commercial / finance |  |
| `transport` | [[Transport Table - transport - uvw_po_service_package_account_assignment_eskn]] | `transport_dev.transport.uvw_po_service_package_account_assignment_eskn` | VIEW | 14 | commercial / finance |  |
| `transport` | [[Transport Table - transport - uvw_po_service_package_header_data_eslh]] | `transport_dev.transport.uvw_po_service_package_header_data_eslh` | VIEW | 7 | commercial / finance |  |
| `transport` | [[Transport Table - transport - uvw_ptmw_data]] | `transport_dev.transport.uvw_ptmw_data` | VIEW | 33 |  |  |
| `transport` | [[Transport Table - transport - uvw_ptmw_data_history]] | `transport_dev.transport.uvw_ptmw_data_history` | VIEW | 33 |  |  |
| `transport` | [[Transport Table - transport - uvw_purchase_requisitions_transport]] | `transport_dev.transport.uvw_purchase_requisitions_transport` | VIEW | 67 | commercial / finance |  |
| `transport` | [[Transport Table - transport - uvw_purgrp_masterdata_detail]] | `transport_dev.transport.uvw_purgrp_masterdata_detail` | VIEW | 6 |  |  |
| `transport` | [[Transport Table - transport - uvw_purgrp_masterdata_uniquelist]] | `transport_dev.transport.uvw_purgrp_masterdata_uniquelist` | VIEW | 2 |  |  |
| `transport` | [[Transport Table - transport - uvw_vendor_cleared_items_bsak]] | `transport_dev.transport.uvw_vendor_cleared_items_bsak` | VIEW | 16 | commercial / finance |  |
| `transport` | [[Transport Table - transport - uvw_vendor_master_data]] | `transport_dev.transport.uvw_vendor_master_data` | VIEW | 4 | commercial / finance |  |
| `transport` | [[Transport Table - transport - uvw_vendor_open_items_bsik]] | `transport_dev.transport.uvw_vendor_open_items_bsik` | VIEW | 16 | commercial / finance |  |
| `transport` | [[Transport Table - transport - uvw_wbs_budget_forecast_data_cosp]] | `transport_dev.transport.uvw_wbs_budget_forecast_data_cosp` | VIEW | 24 | weather |  |
| `transport` | [[Transport Table - transport - uvw_wbs_master_data_prps]] | `transport_dev.transport.uvw_wbs_master_data_prps` | VIEW | 7 | commercial / finance |  |
| `transport` | [[Transport Table - transport - uvw_wo_nwa_master_data_aufk_afko_afvc]] | `transport_dev.transport.uvw_wo_nwa_master_data_aufk_afko_afvc` | VIEW | 14 |  |  |
| `transport_aklw` | [[Transport Table - transport_aklw - uvw_asset]] | `transport_dev.transport_aklw.uvw_asset` | VIEW | 33 | asset register / hierarchy |  |
| `transport_aklw` | [[Transport Table - transport_aklw - uvw_capitalwork]] | `transport_dev.transport_aklw.uvw_capitalwork` | VIEW | 28 | capital works / forward works |  |
| `transport_aklw` | [[Transport Table - transport_aklw - uvw_capitalworktask]] | `transport_dev.transport_aklw.uvw_capitalworktask` | VIEW | 32 | capital works / forward works |  |
| `transport_aklw` | [[Transport Table - transport_aklw - uvw_formfield]] | `transport_dev.transport_aklw.uvw_formfield` | VIEW | 13 | forms / modules |  |
| `transport_aklw` | [[Transport Table - transport_aklw - uvw_inspection]] | `transport_dev.transport_aklw.uvw_inspection` | VIEW | 46 | inspection / audit / condition |  |
| `transport_aklw` | [[Transport Table - transport_aklw - uvw_job]] | `transport_dev.transport_aklw.uvw_job` | VIEW | 80 | jobs / work orders |  |
| `transport_aklw` | [[Transport Table - transport_aklw - uvw_plant_pending_timesheet]] | `transport_dev.transport_aklw.uvw_plant_pending_timesheet` | VIEW | 21 | resources / timesheets |  |
| `transport_aklw` | [[Transport Table - transport_aklw - uvw_timesheetitem]] | `transport_dev.transport_aklw.uvw_timesheetitem` | VIEW | 27 | resources / timesheets |  |
| `transport_aklw` | [[Transport Table - transport_aklw - uvw_timesheetreport]] | `transport_dev.transport_aklw.uvw_timesheetreport` | VIEW | 31 | resources / timesheets |  |
| `transport_aklw` | [[Transport Table - transport_aklw - uvw_updated_dispatch_id]] | `transport_dev.transport_aklw.uvw_updated_dispatch_id` | VIEW | 12 | reference / mapping |  |
| `transport_aklw` | [[Transport Table - transport_aklw - uvw_workflowstatus]] | `transport_dev.transport_aklw.uvw_workflowstatus` | VIEW | 14 | workflow / status |  |
| `transport_fndc` | [[Transport Table - transport_fndc - byo_tbl_kerikeri_weather_hr_fc]] | `transport_dev.transport_fndc.byo_tbl_kerikeri_weather_hr_fc` | MANAGED | 6 | weather |  |
| `transport_fndc` | [[Transport Table - transport_fndc - byo_tbl_national_road_cl_nz]] | `transport_dev.transport_fndc.byo_tbl_national_road_cl_nz` | MANAGED | 26 | road network |  |
| `transport_fndc` | [[Transport Table - transport_fndc - uvw_c_surface]] | `transport_dev.transport_fndc.uvw_c_surface` | VIEW | 79 |  |  |
| `transport_fndc` | [[Transport Table - transport_fndc - uvw_drainage]] | `transport_dev.transport_fndc.uvw_drainage` | VIEW | 80 |  |  |
| `transport_fndc` | [[Transport Table - transport_fndc - uvw_footpath]] | `transport_dev.transport_fndc.uvw_footpath` | VIEW | 74 |  |  |
| `transport_fndc` | [[Transport Table - transport_fndc - uvw_fw_forward_work_view]] | `transport_dev.transport_fndc.uvw_fw_forward_work_view` | VIEW | 18 | capital works / forward works |  |
| `transport_fndc` | [[Transport Table - transport_fndc - uvw_mc_cost]] | `transport_dev.transport_fndc.uvw_mc_cost` | VIEW | 30 | commercial / finance |  |
| `transport_fndc` | [[Transport Table - transport_fndc - uvw_mt_dispatch]] | `transport_dev.transport_fndc.uvw_mt_dispatch` | VIEW | 94 |  |  |
| `transport_fndc` | [[Transport Table - transport_fndc - uvw_mt_dispatch_claim]] | `transport_dev.transport_fndc.uvw_mt_dispatch_claim` | VIEW | 58 |  |  |
| `transport_fndc` | [[Transport Table - transport_fndc - uvw_pave_layer]] | `transport_dev.transport_fndc.uvw_pave_layer` | VIEW | 53 |  |  |
| `transport_fndc` | [[Transport Table - transport_fndc - uvw_railings]] | `transport_dev.transport_fndc.uvw_railings` | VIEW | 79 |  |  |
| `transport_fndc` | [[Transport Table - transport_fndc - uvw_sign]] | `transport_dev.transport_fndc.uvw_sign` | VIEW | 80 |  |  |
| `transport_fndc` | [[Transport Table - transport_fndc - uvw_treatment_length]] | `transport_dev.transport_fndc.uvw_treatment_length` | VIEW | 197 |  |  |
| `transport_fndc` | [[Transport Table - transport_fndc - weather_hourly_forecast]] | `transport_dev.transport_fndc.weather_hourly_forecast` | MANAGED | 6 | weather |  |
| `transport_nel` | [[Transport Table - transport_nel - utbl_kpi_assets]] | `transport_dev.transport_nel.utbl_kpi_assets` | MANAGED | 66 | KPI / reporting | Created by the file upload UI |
| `transport_nel` | [[Transport Table - transport_nel - utbl_kpi_work_orders]] | `transport_dev.transport_nel.utbl_kpi_work_orders` | MANAGED | 26 | KPI / reporting | Created by the file upload UI |
| `transport_nel` | [[Transport Table - transport_nel - utbl_ref_date_table]] | `transport_dev.transport_nel.utbl_ref_date_table` | MANAGED | 25 | reference / mapping | Created by the file upload UI |
| `transport_nel` | [[Transport Table - transport_nel - uvw_kpi_sys_av_devices]] | `transport_dev.transport_nel.uvw_kpi_sys_av_devices` | VIEW | 12 | KPI / reporting |  |
| `transport_ramc` | [[Transport Table - transport_ramc - bkp_backlog_change_report]] | `transport_dev.transport_ramc.bkp_backlog_change_report` | MANAGED | 9 | staging / backup |  |
| `transport_ramc` | [[Transport Table - transport_ramc - bkp_current_month_job_snapshot]] | `transport_dev.transport_ramc.bkp_current_month_job_snapshot` | MANAGED | 26 | jobs / work orders |  |
| `transport_ramc` | [[Transport Table - transport_ramc - bkp_last_month_job_snapshot]] | `transport_dev.transport_ramc.bkp_last_month_job_snapshot` | MANAGED | 24 | jobs / work orders |  |
| `transport_ramc` | [[Transport Table - transport_ramc - bkp_monthly_backlog_reduction]] | `transport_dev.transport_ramc.bkp_monthly_backlog_reduction` | MANAGED | 4 | staging / backup |  |
| `transport_ramc` | [[Transport Table - transport_ramc - utbl_backlog_change_report]] | `transport_dev.transport_ramc.utbl_backlog_change_report` | MANAGED | 9 |  |  |
| `transport_ramc` | [[Transport Table - transport_ramc - utbl_current_month_job_snapshot]] | `transport_dev.transport_ramc.utbl_current_month_job_snapshot` | MANAGED | 26 | jobs / work orders | Created by the file upload UI |
| `transport_ramc` | [[Transport Table - transport_ramc - utbl_last_month_job_snapshot]] | `transport_dev.transport_ramc.utbl_last_month_job_snapshot` | MANAGED | 24 | jobs / work orders |  |
| `transport_ramc` | [[Transport Table - transport_ramc - utbl_monthly_backlog_reduction]] | `transport_dev.transport_ramc.utbl_monthly_backlog_reduction` | MANAGED | 4 |  |  |
| `transport_ramc` | [[Transport Table - transport_ramc - utbl_reporting_period]] | `transport_dev.transport_ramc.utbl_reporting_period` | MANAGED | 3 |  | Created by the file upload UI |
| `transport_ramc` | [[Transport Table - transport_ramc - uvw_inspection]] | `transport_dev.transport_ramc.uvw_inspection` | VIEW | 36 | inspection / audit / condition |  |
| `transport_ramc` | [[Transport Table - transport_ramc - uvw_job]] | `transport_dev.transport_ramc.uvw_job` | VIEW | 45 | jobs / work orders |  |
| `transport_ramc` | [[Transport Table - transport_ramc - uvw_job_temp]] | `transport_dev.transport_ramc.uvw_job_temp` | VIEW | 41 | jobs / work orders |  |
| `transport_ramc` | [[Transport Table - transport_ramc - uvw_roadlastinspected]] | `transport_dev.transport_ramc.uvw_roadlastinspected` | VIEW | 12 |  |  |
| `transport_ramc` | [[Transport Table - transport_ramc - uvw_stripmap_full]] | `transport_dev.transport_ramc.uvw_stripmap_full` | VIEW | 25 |  |  |
| `transport_ramc` | [[Transport Table - transport_ramc - uvw_stripmap_jobphotos]] | `transport_dev.transport_ramc.uvw_stripmap_jobphotos` | VIEW | 4 | jobs / work orders |  |
| `transport_ramc` | [[Transport Table - transport_ramc - uvw_stripmap_jobs]] | `transport_dev.transport_ramc.uvw_stripmap_jobs` | VIEW | 56 | jobs / work orders |  |
| `transport_ramc` | [[Transport Table - transport_ramc - uvw_stripmap_wkt]] | `transport_dev.transport_ramc.uvw_stripmap_wkt` | VIEW | 11 |  |  |
| `transport_sht` | [[Transport Table - transport_sht - utbl_nps03_sb]] | `transport_dev.transport_sht.utbl_nps03_sb` | MANAGED | 3 |  |  |
| `transport_sht` | [[Transport Table - transport_sht - utbl_nps04_nb]] | `transport_dev.transport_sht.utbl_nps04_nb` | MANAGED | 1 |  | Created by the file upload UI |
| `transport_sht` | [[Transport Table - transport_sht - utbl_sps01_nb]] | `transport_dev.transport_sht.utbl_sps01_nb` | MANAGED | 1 |  | Created by the file upload UI |
| `transport_sht` | [[Transport Table - transport_sht - utbl_sps02_sb]] | `transport_dev.transport_sht.utbl_sps02_sb` | MANAGED | 3 |  |  |
| `transport_sht` | [[Transport Table - transport_sht - utbl_ss_latitude]] | `transport_dev.transport_sht.utbl_ss_latitude` | MANAGED | 8 |  | Created by the file upload UI |
| `transport_sht` | [[Transport Table - transport_sht - utbl_tmp_nps03_sb]] | `transport_dev.transport_sht.utbl_tmp_nps03_sb` | MANAGED | 1 | staging / backup | This table contains a single column named 'value' and appears to be a temporary staging table created via the file upload interface. The data likely represents preliminary or intermediate information related to transport, but the exact content and purpose are not detailed here. It may be useful for short-term data processing or data import tasks before moving data into more structured tables. |
| `transport_sht` | [[Transport Table - transport_sht - utbl_tmp_nps04_nb]] | `transport_dev.transport_sht.utbl_tmp_nps04_nb` | MANAGED | 1 | staging / backup | This table contains temporary data related to Net Promoter Score (NPS) or similar customer feedback metrics, stored as string values in a single column. It appears to be created via a file upload interface, likely for intermediate or temporary use during data import or processing. It may be useful for quick analysis or transformation tasks before integrating the data into permanent reporting tables. |
| `transport_sht` | [[Transport Table - transport_sht - utbl_tmp_sps01_nb]] | `transport_dev.transport_sht.utbl_tmp_sps01_nb` | MANAGED | 1 | staging / backup | This table contains a single column of string data and appears to be a temporary or intermediate dataset created via file upload. Due to its minimal structure and general nature, it might be used primarily for staging or transferring data before further processing or integration into more detailed tables. It could serve as a placeholder or initial import point for textual data related to transportation shipment tasks. |
| `transport_sht` | [[Transport Table - transport_sht - utbl_tmp_sps02_sb]] | `transport_dev.transport_sht.utbl_tmp_sps02_sb` | MANAGED | 1 | staging / backup | This table contains data imported through a file upload interface. It includes a single column labeled 'value' which stores string entries. The table is suitable for temporary or intermediary storage of textual data during data processing or integration workflows in transportation-related projects. |
| `transport_sht` | [[Transport Table - transport_sht - utbl_tmp_tvs03_sb]] | `transport_dev.transport_sht.utbl_tmp_tvs03_sb` | MANAGED | 1 | staging / backup | This table contains basic data with a single string column named 'value'. It appears to be a temporary or staging table, likely created via a file upload interface. Use cases could include intermediate storage or processing of raw data before further transformation or integration into other datasets. It is not specific to any domain based on the current data definition. |
| `transport_sht` | [[Transport Table - transport_sht - utbl_tmp_tvs07_nb]] | `transport_dev.transport_sht.utbl_tmp_tvs07_nb` | MANAGED | 1 | staging / backup | This table contains a temporary dataset created via the file upload interface, with a single string column named 'value'. It appears to serve as a staging or intermediate storage for data before further processing or transformation. Use cases include temporarily holding data imported from external sources for validation, cleansing, or loading into more structured tables. |
| `transport_sht` | [[Transport Table - transport_sht - utbl_tvs03_sb]] | `transport_dev.transport_sht.utbl_tvs03_sb` | MANAGED | 3 |  |  |
| `transport_sht` | [[Transport Table - transport_sht - utbl_tvs07_nb]] | `transport_dev.transport_sht.utbl_tvs07_nb` | MANAGED | 3 |  |  |
| `transport_sht` | [[Transport Table - transport_sht - uvw_ai1]] | `transport_dev.transport_sht.uvw_ai1` | VIEW | 19 |  |  |
| `transport_sht` | [[Transport Table - transport_sht - uvw_ai2]] | `transport_dev.transport_sht.uvw_ai2` | VIEW | 17 |  |  |
| `transport_sht` | [[Transport Table - transport_sht - uvw_all_assets]] | `transport_dev.transport_sht.uvw_all_assets` | VIEW | 35 | asset register / hierarchy |  |
| `transport_sht` | [[Transport Table - transport_sht - uvw_all_critical_assets]] | `transport_dev.transport_sht.uvw_all_critical_assets` | VIEW | 21 | asset register / hierarchy |  |
| `transport_sht` | [[Transport Table - transport_sht - uvw_inspection]] | `transport_dev.transport_sht.uvw_inspection` | VIEW | 46 | inspection / audit / condition |  |
| `transport_sht` | [[Transport Table - transport_sht - uvw_job]] | `transport_dev.transport_sht.uvw_job` | VIEW | 80 | jobs / work orders |  |
| `transport_sht` | [[Transport Table - transport_sht - uvw_nps03_sb_segmented]] | `transport_dev.transport_sht.uvw_nps03_sb_segmented` | VIEW | 4 | asset register / hierarchy |  |
| `transport_sht` | [[Transport Table - transport_sht - uvw_nps04_nb_segmented]] | `transport_dev.transport_sht.uvw_nps04_nb_segmented` | VIEW | 4 | asset register / hierarchy |  |
| `transport_sht` | [[Transport Table - transport_sht - uvw_sps01_nb_segmented]] | `transport_dev.transport_sht.uvw_sps01_nb_segmented` | VIEW | 4 | asset register / hierarchy |  |
| `transport_sht` | [[Transport Table - transport_sht - uvw_sps02_sb_segmented]] | `transport_dev.transport_sht.uvw_sps02_sb_segmented` | VIEW | 4 | asset register / hierarchy |  |
| `transport_sht` | [[Transport Table - transport_sht - uvw_tvs03_sb_segmented]] | `transport_dev.transport_sht.uvw_tvs03_sb_segmented` | VIEW | 4 | asset register / hierarchy |  |
| `transport_sht` | [[Transport Table - transport_sht - uvw_tvs07_nb_segmented]] | `transport_dev.transport_sht.uvw_tvs07_nb_segmented` | VIEW | 4 | asset register / hierarchy |  |
| `transport_sht` | [[Transport Table - transport_sht - uvw_user_groups]] | `transport_dev.transport_sht.uvw_user_groups` | VIEW | 2 | user / security |  |
| `transport_sht` | [[Transport Table - transport_sht - uvw_weather_north_sydney_hourly_rolling_30days]] | `transport_dev.transport_sht.uvw_weather_north_sydney_hourly_rolling_30days` | VIEW | 62 | weather |  |
| `transport_srapc` | [[Transport Table - transport_srapc - utbl_monthly_report]] | `transport_dev.transport_srapc.utbl_monthly_report` | MANAGED | 12 |  | Created by the file upload UI |
| `transport_srapc` | [[Transport Table - transport_srapc - utbl_srapc_formitize_mapping]] | `transport_dev.transport_srapc.utbl_srapc_formitize_mapping` | MANAGED | 7 | forms / modules | Created by the file upload UI |
| `transport_srapc` | [[Transport Table - transport_srapc - utbl_tacp_constants]] | `transport_dev.transport_srapc.utbl_tacp_constants` | MANAGED | 6 | reference / mapping | Created by the file upload UI |
| `transport_srapc` | [[Transport Table - transport_srapc - utbl_tacp_toc]] | `transport_dev.transport_srapc.utbl_tacp_toc` | MANAGED | 3 |  | Created by the file upload UI |
| `transport_srapc` | [[Transport Table - transport_srapc - utbl_tmp_civil_master]] | `transport_dev.transport_srapc.utbl_tmp_civil_master` | MANAGED | 54 | staging / backup | Created by the file upload UI |
| `transport_srapc` | [[Transport Table - transport_srapc - uvw_a_bridge_all_data]] | `transport_dev.transport_srapc.uvw_a_bridge_all_data` | VIEW | 58 |  |  |
| `transport_srapc` | [[Transport Table - transport_srapc - uvw_a_slope_all_data]] | `transport_dev.transport_srapc.uvw_a_slope_all_data` | VIEW | 86 |  |  |
| `transport_srapc` | [[Transport Table - transport_srapc - uvw_arcgis_jobs]] | `transport_dev.transport_srapc.uvw_arcgis_jobs` | VIEW | 20 | jobs / work orders |  |
| `transport_srapc` | [[Transport Table - transport_srapc - uvw_asset]] | `transport_dev.transport_srapc.uvw_asset` | VIEW | 38 | asset register / hierarchy |  |
| `transport_srapc` | [[Transport Table - transport_srapc - uvw_asset_all_data_withphoto]] | `transport_dev.transport_srapc.uvw_asset_all_data_withphoto` | VIEW | 56 | asset register / hierarchy |  |
| `transport_srapc` | [[Transport Table - transport_srapc - uvw_asset_inspection_last]] | `transport_dev.transport_srapc.uvw_asset_inspection_last` | VIEW | 48 | asset register / hierarchy |  |
| `transport_srapc` | [[Transport Table - transport_srapc - uvw_asset_inspection_next]] | `transport_dev.transport_srapc.uvw_asset_inspection_next` | VIEW | 48 | asset register / hierarchy |  |
| `transport_srapc` | [[Transport Table - transport_srapc - uvw_assetattribute]] | `transport_dev.transport_srapc.uvw_assetattribute` | VIEW | 9 | asset register / hierarchy |  |
| `transport_srapc` | [[Transport Table - transport_srapc - uvw_av_tmp_combined]] | `transport_dev.transport_srapc.uvw_av_tmp_combined` | VIEW | 69 | staging / backup |  |
| `transport_srapc` | [[Transport Table - transport_srapc - uvw_customerrequest]] | `transport_dev.transport_srapc.uvw_customerrequest` | VIEW | 28 |  |  |
| `transport_srapc` | [[Transport Table - transport_srapc - uvw_customerrequest_all_attributes]] | `transport_dev.transport_srapc.uvw_customerrequest_all_attributes` | VIEW | 54 |  |  |
| `transport_srapc` | [[Transport Table - transport_srapc - uvw_customerrequestpivot]] | `transport_dev.transport_srapc.uvw_customerrequestpivot` | VIEW | 5 |  |  |
| `transport_srapc` | [[Transport Table - transport_srapc - uvw_inspection_all_attributes]] | `transport_dev.transport_srapc.uvw_inspection_all_attributes` | VIEW | 41 | inspection / audit / condition |  |
| `transport_srapc` | [[Transport Table - transport_srapc - uvw_inspections_all]] | `transport_dev.transport_srapc.uvw_inspections_all` | VIEW | 42 | inspection / audit / condition |  |
| `transport_srapc` | [[Transport Table - transport_srapc - uvw_job]] | `transport_dev.transport_srapc.uvw_job` | VIEW | 82 | jobs / work orders |  |
| `transport_srapc` | [[Transport Table - transport_srapc - uvw_job_all_attributes]] | `transport_dev.transport_srapc.uvw_job_all_attributes` | VIEW | 78 | jobs / work orders |  |
| `transport_srapc` | [[Transport Table - transport_srapc - uvw_jobs_actgroup]] | `transport_dev.transport_srapc.uvw_jobs_actgroup` | VIEW | 15 | jobs / work orders |  |
| `transport_srapc` | [[Transport Table - transport_srapc - uvw_jobs_am_weighted_score]] | `transport_dev.transport_srapc.uvw_jobs_am_weighted_score` | VIEW | 22 | jobs / work orders |  |
| `transport_srapc` | [[Transport Table - transport_srapc - uvw_jobspowerbi]] | `transport_dev.transport_srapc.uvw_jobspowerbi` | VIEW | 33 | jobs / work orders |  |
| `transport_srapc` | [[Transport Table - transport_srapc - uvw_monthly_subcontractor_data]] | `transport_dev.transport_srapc.uvw_monthly_subcontractor_data` | VIEW | 282 |  |  |
| `transport_srapc` | [[Transport Table - transport_srapc - uvw_monthly_subcontractor_data_energy]] | `transport_dev.transport_srapc.uvw_monthly_subcontractor_data_energy` | VIEW | 37 |  |  |
| `transport_srapc` | [[Transport Table - transport_srapc - uvw_monthly_subcontractor_data_health_safety]] | `transport_dev.transport_srapc.uvw_monthly_subcontractor_data_health_safety` | VIEW | 15 |  |  |
| `transport_srapc` | [[Transport Table - transport_srapc - uvw_monthly_subcontractor_data_material]] | `transport_dev.transport_srapc.uvw_monthly_subcontractor_data_material` | VIEW | 28 | inventory / materials |  |
| `transport_srapc` | [[Transport Table - transport_srapc - uvw_monthly_subcontractor_data_social]] | `transport_dev.transport_srapc.uvw_monthly_subcontractor_data_social` | VIEW | 11 |  |  |
| `transport_srapc` | [[Transport Table - transport_srapc - uvw_monthly_subcontractor_data_stationary_fuel]] | `transport_dev.transport_srapc.uvw_monthly_subcontractor_data_stationary_fuel` | VIEW | 18 |  |  |
| `transport_srapc` | [[Transport Table - transport_srapc - uvw_monthly_subcontractor_data_waste]] | `transport_dev.transport_srapc.uvw_monthly_subcontractor_data_waste` | VIEW | 75 |  |  |
| `transport_srapc` | [[Transport Table - transport_srapc - uvw_ndh_shift_report]] | `transport_dev.transport_srapc.uvw_ndh_shift_report` | VIEW | 20 |  |  |
| `transport_srapc` | [[Transport Table - transport_srapc - uvw_pbi_master_jobs_export]] | `transport_dev.transport_srapc.uvw_pbi_master_jobs_export` | VIEW | 33 | jobs / work orders |  |
| `transport_srapc` | [[Transport Table - transport_srapc - uvw_photos_unique]] | `transport_dev.transport_srapc.uvw_photos_unique` | VIEW | 12 | documents / evidence |  |
| `transport_srapc` | [[Transport Table - transport_srapc - uvw_school_zone]] | `transport_dev.transport_srapc.uvw_school_zone` | VIEW | 3 |  |  |
| `transport_srapc` | [[Transport Table - transport_srapc - uvw_srapc_assets]] | `transport_dev.transport_srapc.uvw_srapc_assets` | VIEW | 22 | asset register / hierarchy |  |
| `transport_srapc` | [[Transport Table - transport_srapc - uvw_srapc_jobs_am_weighted_score]] | `transport_dev.transport_srapc.uvw_srapc_jobs_am_weighted_score` | VIEW | 21 | jobs / work orders |  |
| `transport_srapc` | [[Transport Table - transport_srapc - uvw_srapc_special_projects]] | `transport_dev.transport_srapc.uvw_srapc_special_projects` | VIEW | 94 |  |  |
| `transport_srapc` | [[Transport Table - transport_srapc - uvw_srapc_tfnsw_monthly_report_defect_intervention]] | `transport_dev.transport_srapc.uvw_srapc_tfnsw_monthly_report_defect_intervention` | VIEW | 11 | defects / hazards / failures |  |
| `transport_srapc` | [[Transport Table - transport_srapc - uvw_tacp_data_delta_load]] | `transport_dev.transport_srapc.uvw_tacp_data_delta_load` | VIEW | 65 |  |  |
| `transport_srapc` | [[Transport Table - transport_srapc - uvw_tacp_data_initial_load]] | `transport_dev.transport_srapc.uvw_tacp_data_initial_load` | VIEW | 65 |  |  |
| `transport_srapc` | [[Transport Table - transport_srapc - uvw_weatherobervations]] | `transport_dev.transport_srapc.uvw_weatherobervations` | VIEW | 26 | weather |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - bkp_uvw_incident_closures]] | `transport_dev.transport_tsrc.bkp_uvw_incident_closures` | MANAGED | 6 | traffic counts / closures |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - utbl_aed_asset_bridge]] | `transport_dev.transport_tsrc.utbl_aed_asset_bridge` | MANAGED | 56 | asset register / hierarchy | Created by the file upload UI |
| `transport_tsrc` | [[Transport Table - transport_tsrc - utbl_aed_assets]] | `transport_dev.transport_tsrc.utbl_aed_assets` | MANAGED | 4 | asset register / hierarchy | Created by the file upload UI |
| `transport_tsrc` | [[Transport Table - transport_tsrc - utbl_aed_incidents_closures]] | `transport_dev.transport_tsrc.utbl_aed_incidents_closures` | MANAGED | 34 | traffic counts / closures | Created by the file upload UI |
| `transport_tsrc` | [[Transport Table - transport_tsrc - utbl_aed_incidents_events]] | `transport_dev.transport_tsrc.utbl_aed_incidents_events` | MANAGED | 6 | incidents | Created by the file upload UI |
| `transport_tsrc` | [[Transport Table - transport_tsrc - utbl_aed_incidents_list]] | `transport_dev.transport_tsrc.utbl_aed_incidents_list` | MANAGED | 11 | incidents | Created by the file upload UI |
| `transport_tsrc` | [[Transport Table - transport_tsrc - utbl_aed_incidents_sr]] | `transport_dev.transport_tsrc.utbl_aed_incidents_sr` | MANAGED | 14 | incidents | Created by the file upload UI |
| `transport_tsrc` | [[Transport Table - transport_tsrc - utbl_aed_inspection_requirements]] | `transport_dev.transport_tsrc.utbl_aed_inspection_requirements` | MANAGED | 8 | inspection / audit / condition | Created by the file upload UI |
| `transport_tsrc` | [[Transport Table - transport_tsrc - utbl_aed_wo_assets]] | `transport_dev.transport_tsrc.utbl_aed_wo_assets` | MANAGED | 6 | asset register / hierarchy | Created by the file upload UI |
| `transport_tsrc` | [[Transport Table - transport_tsrc - utbl_aed_wo_list]] | `transport_dev.transport_tsrc.utbl_aed_wo_list` | MANAGED | 25 |  | Created by the file upload UI |
| `transport_tsrc` | [[Transport Table - transport_tsrc - utbl_asset_perf_maint_kpi25_1]] | `transport_dev.transport_tsrc.utbl_asset_perf_maint_kpi25_1` | MANAGED | 32 | KPI / reporting |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - utbl_asset_perf_maint_kpi25_2]] | `transport_dev.transport_tsrc.utbl_asset_perf_maint_kpi25_2` | MANAGED | 33 | KPI / reporting |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - utbl_asset_perf_maint_kpi25_3]] | `transport_dev.transport_tsrc.utbl_asset_perf_maint_kpi25_3` | MANAGED | 30 | KPI / reporting |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - utbl_asset_register]] | `transport_dev.transport_tsrc.utbl_asset_register` | MANAGED | 66 | asset register / hierarchy | Created by the file upload UI |
| `transport_tsrc` | [[Transport Table - transport_tsrc - utbl_incident_triggered_section_geom]] | `transport_dev.transport_tsrc.utbl_incident_triggered_section_geom` | MANAGED | 39 | incidents |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - utbl_kpi2_road_safety]] | `transport_dev.transport_tsrc.utbl_kpi2_road_safety` | MANAGED | 127 | KPI / reporting |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - utbl_pavement_reporting_sections_test]] | `transport_dev.transport_tsrc.utbl_pavement_reporting_sections_test` | MANAGED | 12 | capital works / forward works | Created by the file upload UI |
| `transport_tsrc` | [[Transport Table - transport_tsrc - utbl_pcas_test]] | `transport_dev.transport_tsrc.utbl_pcas_test` | MANAGED | 17 | capital works / forward works | Created by the file upload UI |
| `transport_tsrc` | [[Transport Table - transport_tsrc - utbl_ref_activitytype_to_category_mapping]] | `transport_dev.transport_tsrc.utbl_ref_activitytype_to_category_mapping` | MANAGED | 5 | reference / mapping | Created by the file upload UI |
| `transport_tsrc` | [[Transport Table - transport_tsrc - utbl_ref_comp_code_to_inc_category]] | `transport_dev.transport_tsrc.utbl_ref_comp_code_to_inc_category` | MANAGED | 6 | reference / mapping | Created by the file upload UI |
| `transport_tsrc` | [[Transport Table - transport_tsrc - utbl_ref_corrective_maintenance_compliance]] | `transport_dev.transport_tsrc.utbl_ref_corrective_maintenance_compliance` | MANAGED | 12 | reference / mapping | Created by the file upload UI |
| `transport_tsrc` | [[Transport Table - transport_tsrc - utbl_ref_date_table]] | `transport_dev.transport_tsrc.utbl_ref_date_table` | MANAGED | 25 | reference / mapping | Created by the file upload UI |
| `transport_tsrc` | [[Transport Table - transport_tsrc - utbl_ref_incident_group]] | `transport_dev.transport_tsrc.utbl_ref_incident_group` | MANAGED | 2 | incidents | Created by the file upload UI |
| `transport_tsrc` | [[Transport Table - transport_tsrc - utbl_ref_inspection_due_dates_monthly]] | `transport_dev.transport_tsrc.utbl_ref_inspection_due_dates_monthly` | MANAGED | 7 | inspection / audit / condition | Created by the file upload UI |
| `transport_tsrc` | [[Transport Table - transport_tsrc - utbl_ref_inspection_due_dates_weekly]] | `transport_dev.transport_tsrc.utbl_ref_inspection_due_dates_weekly` | MANAGED | 5 | inspection / audit / condition | Created by the file upload UI |
| `transport_tsrc` | [[Transport Table - transport_tsrc - utbl_ref_inspection_due_dates_yearly]] | `transport_dev.transport_tsrc.utbl_ref_inspection_due_dates_yearly` | MANAGED | 8 | inspection / audit / condition | Created by the file upload UI |
| `transport_tsrc` | [[Transport Table - transport_tsrc - utbl_ref_kpi_25_coms_asset_ref]] | `transport_dev.transport_tsrc.utbl_ref_kpi_25_coms_asset_ref` | MANAGED | 3 | KPI / reporting | Created by the file upload UI |
| `transport_tsrc` | [[Transport Table - transport_tsrc - utbl_ref_lane_closure_abate_pct]] | `transport_dev.transport_tsrc.utbl_ref_lane_closure_abate_pct` | MANAGED | 5 | traffic counts / closures | Created by the file upload UI |
| `transport_tsrc` | [[Transport Table - transport_tsrc - utbl_ref_lane_closure_financial_factor]] | `transport_dev.transport_tsrc.utbl_ref_lane_closure_financial_factor` | MANAGED | 3 | traffic counts / closures | Created by the file upload UI |
| `transport_tsrc` | [[Transport Table - transport_tsrc - utbl_ref_lane_closure_lane_factor]] | `transport_dev.transport_tsrc.utbl_ref_lane_closure_lane_factor` | MANAGED | 5 | traffic counts / closures | Created by the file upload UI |
| `transport_tsrc` | [[Transport Table - transport_tsrc - utbl_ref_lane_closure_section_factor]] | `transport_dev.transport_tsrc.utbl_ref_lane_closure_section_factor` | MANAGED | 2 | traffic counts / closures | Created by the file upload UI |
| `transport_tsrc` | [[Transport Table - transport_tsrc - utbl_ref_lane_closure_special_day]] | `transport_dev.transport_tsrc.utbl_ref_lane_closure_special_day` | MANAGED | 3 | traffic counts / closures | Created by the file upload UI |
| `transport_tsrc` | [[Transport Table - transport_tsrc - utbl_ref_lane_closure_type]] | `transport_dev.transport_tsrc.utbl_ref_lane_closure_type` | MANAGED | 2 | traffic counts / closures | Created by the file upload UI |
| `transport_tsrc` | [[Transport Table - transport_tsrc - utbl_ref_road_chng_10_m]] | `transport_dev.transport_tsrc.utbl_ref_road_chng_10_m` | MANAGED | 7 | reference / mapping | Created by the file upload UI |
| `transport_tsrc` | [[Transport Table - transport_tsrc - utbl_ref_routine_inspection_compliance]] | `transport_dev.transport_tsrc.utbl_ref_routine_inspection_compliance` | MANAGED | 12 | inspection / audit / condition | Created by the file upload UI |
| `transport_tsrc` | [[Transport Table - transport_tsrc - utbl_ref_routine_maintenance_compliance]] | `transport_dev.transport_tsrc.utbl_ref_routine_maintenance_compliance` | MANAGED | 26 | reference / mapping | Created by the file upload UI |
| `transport_tsrc` | [[Transport Table - transport_tsrc - utbl_ref_section_to_km_mapping]] | `transport_dev.transport_tsrc.utbl_ref_section_to_km_mapping` | MANAGED | 10 | reference / mapping | Created by the file upload UI |
| `transport_tsrc` | [[Transport Table - transport_tsrc - utbl_ref_section_to_m_mapping_2_km_sections]] | `transport_dev.transport_tsrc.utbl_ref_section_to_m_mapping_2_km_sections` | MANAGED | 10 | reference / mapping | Created by the file upload UI |
| `transport_tsrc` | [[Transport Table - transport_tsrc - utbl_ref_sections_kpi]] | `transport_dev.transport_tsrc.utbl_ref_sections_kpi` | MANAGED | 5 | KPI / reporting | Created by the file upload UI |
| `transport_tsrc` | [[Transport Table - transport_tsrc - utbl_road_safety_audit_register]] | `transport_dev.transport_tsrc.utbl_road_safety_audit_register` | MANAGED | 35 | inspection / audit / condition |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - utbl_test_condition_data]] | `transport_dev.transport_tsrc.utbl_test_condition_data` | MANAGED | 11 | inspection / audit / condition | Created by the file upload UI |
| `transport_tsrc` | [[Transport Table - transport_tsrc - utbl_work_order]] | `transport_dev.transport_tsrc.utbl_work_order` | MANAGED | 26 | jobs / work orders | Created by the file upload UI |
| `transport_tsrc` | [[Transport Table - transport_tsrc - uvw_asset_perf_maint_kpi25_1]] | `transport_dev.transport_tsrc.uvw_asset_perf_maint_kpi25_1` | VIEW | 30 | KPI / reporting |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - uvw_assets]] | `transport_dev.transport_tsrc.uvw_assets` | VIEW | 37 | asset register / hierarchy |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - uvw_capital_work]] | `transport_dev.transport_tsrc.uvw_capital_work` | VIEW | 18 |  |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - uvw_customer_requests]] | `transport_dev.transport_tsrc.uvw_customer_requests` | VIEW | 88 |  |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - uvw_customer_requests_report]] | `transport_dev.transport_tsrc.uvw_customer_requests_report` | VIEW | 8 |  |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - uvw_incident_closures]] | `transport_dev.transport_tsrc.uvw_incident_closures` | VIEW | 6 | traffic counts / closures |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - uvw_incident_report]] | `transport_dev.transport_tsrc.uvw_incident_report` | VIEW | 25 | incidents |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - uvw_incident_trigger_report_map_geom]] | `transport_dev.transport_tsrc.uvw_incident_trigger_report_map_geom` | VIEW | 7 | incidents |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - uvw_incident_triggered_report]] | `transport_dev.transport_tsrc.uvw_incident_triggered_report` | VIEW | 17 | incidents |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - uvw_inspection]] | `transport_dev.transport_tsrc.uvw_inspection` | VIEW | 54 | inspection / audit / condition |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - uvw_job]] | `transport_dev.transport_tsrc.uvw_job` | VIEW | 64 | jobs / work orders |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - uvw_jobs_all_attributes]] | `transport_dev.transport_tsrc.uvw_jobs_all_attributes` | VIEW | 127 | jobs / work orders |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - uvw_kpi18_abatement_costs]] | `transport_dev.transport_tsrc.uvw_kpi18_abatement_costs` | VIEW | 52 | KPI / reporting |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - uvw_kpi18_noise_events]] | `transport_dev.transport_tsrc.uvw_kpi18_noise_events` | VIEW | 43 | KPI / reporting |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - uvw_kpi19_abatement_costs]] | `transport_dev.transport_tsrc.uvw_kpi19_abatement_costs` | VIEW | 53 | KPI / reporting |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - uvw_kpi19_stakeholder_events]] | `transport_dev.transport_tsrc.uvw_kpi19_stakeholder_events` | VIEW | 46 | KPI / reporting |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - uvw_kpi25_1_abatement_costs]] | `transport_dev.transport_tsrc.uvw_kpi25_1_abatement_costs` | VIEW | 34 | KPI / reporting |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - uvw_kpi25_2_abatement_costs]] | `transport_dev.transport_tsrc.uvw_kpi25_2_abatement_costs` | VIEW | 35 | KPI / reporting |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - uvw_kpi25_3_abatement_costs]] | `transport_dev.transport_tsrc.uvw_kpi25_3_abatement_costs` | VIEW | 49 | KPI / reporting |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - uvw_kpi2_abatement_costs]] | `transport_dev.transport_tsrc.uvw_kpi2_abatement_costs` | VIEW | 40 | KPI / reporting |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - uvw_kpi3_abatement_costs]] | `transport_dev.transport_tsrc.uvw_kpi3_abatement_costs` | VIEW | 64 | KPI / reporting |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - uvw_kpi3_road_safety]] | `transport_dev.transport_tsrc.uvw_kpi3_road_safety` | VIEW | 54 | KPI / reporting |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - uvw_kpi456_incidents]] | `transport_dev.transport_tsrc.uvw_kpi456_incidents` | VIEW | 23 | KPI / reporting |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - uvw_kpi_10_abatement_costs]] | `transport_dev.transport_tsrc.uvw_kpi_10_abatement_costs` | VIEW | 28 | KPI / reporting |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - uvw_kpi_10_cctv_requests]] | `transport_dev.transport_tsrc.uvw_kpi_10_cctv_requests` | VIEW | 16 | KPI / reporting |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - uvw_kpi_20_21_pcas_test]] | `transport_dev.transport_tsrc.uvw_kpi_20_21_pcas_test` | VIEW | 9 | KPI / reporting |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - uvw_kpi_22_23_pcas_test]] | `transport_dev.transport_tsrc.uvw_kpi_22_23_pcas_test` | VIEW | 15 | KPI / reporting |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - uvw_kpi_7_to_14_its_asset_uptime]] | `transport_dev.transport_tsrc.uvw_kpi_7_to_14_its_asset_uptime` | VIEW | 45 | KPI / reporting |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - uvw_kpi_7_to_14_its_jobs]] | `transport_dev.transport_tsrc.uvw_kpi_7_to_14_its_jobs` | VIEW | 33 | KPI / reporting |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - uvw_pcas_all_attributes]] | `transport_dev.transport_tsrc.uvw_pcas_all_attributes` | VIEW | 103 | capital works / forward works |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - uvw_pcas_capdone_pivotted]] | `transport_dev.transport_tsrc.uvw_pcas_capdone_pivotted` | VIEW | 19 | capital works / forward works |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - uvw_pcas_caplentrted_pivotted]] | `transport_dev.transport_tsrc.uvw_pcas_caplentrted_pivotted` | VIEW | 19 | capital works / forward works |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - uvw_pcas_condrating_pivotted]] | `transport_dev.transport_tsrc.uvw_pcas_condrating_pivotted` | VIEW | 14 | capital works / forward works |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - uvw_pcas_lppc_defects_pivotted]] | `transport_dev.transport_tsrc.uvw_pcas_lppc_defects_pivotted` | VIEW | 110 | defects / hazards / failures |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - uvw_pcas_numeric_data]] | `transport_dev.transport_tsrc.uvw_pcas_numeric_data` | VIEW | 43 | capital works / forward works |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - uvw_pcas_numeric_data_pivotted]] | `transport_dev.transport_tsrc.uvw_pcas_numeric_data_pivotted` | VIEW | 41 | capital works / forward works |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - uvw_pcas_seg_geom_wkt]] | `transport_dev.transport_tsrc.uvw_pcas_seg_geom_wkt` | VIEW | 8 | capital works / forward works |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - uvw_pcas_stripmap_all]] | `transport_dev.transport_tsrc.uvw_pcas_stripmap_all` | VIEW | 33 | capital works / forward works |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - uvw_pcas_stripmap_ele_capworks_singlelane]] | `transport_dev.transport_tsrc.uvw_pcas_stripmap_ele_capworks_singlelane` | VIEW | 27 | lane access |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - uvw_pcas_stripmap_ele_feature_singlelane]] | `transport_dev.transport_tsrc.uvw_pcas_stripmap_ele_feature_singlelane` | VIEW | 27 | lane access |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - uvw_road_safety_audit_register]] | `transport_dev.transport_tsrc.uvw_road_safety_audit_register` | VIEW | 35 | inspection / audit / condition |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - uvw_sys_av_devices]] | `transport_dev.transport_tsrc.uvw_sys_av_devices` | VIEW | 12 |  |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - uvw_test_asset_condition_report]] | `transport_dev.transport_tsrc.uvw_test_asset_condition_report` | VIEW | 9 | asset register / hierarchy |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - uvw_tollroad_unavailability_events]] | `transport_dev.transport_tsrc.uvw_tollroad_unavailability_events` | VIEW | 32 | KPI / reporting |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - uvw_traffic_closures]] | `transport_dev.transport_tsrc.uvw_traffic_closures` | VIEW | 17 | traffic counts / closures |  |
| `transport_tsrc` | [[Transport Table - transport_tsrc - uvw_traffic_volume]] | `transport_dev.transport_tsrc.uvw_traffic_volume` | VIEW | 10 | traffic counts / closures |  |
| `transport_vsm` | [[Transport Table - transport_vsm - uvw_all_asset_with_photo]] | `transport_dev.transport_vsm.uvw_all_asset_with_photo` | VIEW | 25 | asset register / hierarchy |  |
| `transport_wru` | [[Transport Table - transport_wru - utbl_capitalwork_chainage]] | `transport_dev.transport_wru.utbl_capitalwork_chainage` | MANAGED | 5 | asset register / hierarchy | Created by the file upload UI |
| `transport_wru` | [[Transport Table - transport_wru - utbl_counter_locations]] | `transport_dev.transport_wru.utbl_counter_locations` | MANAGED | 24 | traffic counts / closures | Created by the file upload UI |
| `transport_wru` | [[Transport Table - transport_wru - utbl_counts_by_carriageway]] | `transport_dev.transport_wru.utbl_counts_by_carriageway` | MANAGED | 22 | traffic counts / closures | Created by the file upload UI |
| `transport_wru` | [[Transport Table - transport_wru - utbl_counts_by_lane]] | `transport_dev.transport_wru.utbl_counts_by_lane` | MANAGED | 25 | traffic counts / closures | Created by the file upload UI |
| `transport_wru` | [[Transport Table - transport_wru - utbl_counts_hourly]] | `transport_dev.transport_wru.utbl_counts_hourly` | MANAGED | 26 | traffic counts / closures | Created by the file upload UI |
| `transport_wru` | [[Transport Table - transport_wru - utbl_date_table]] | `transport_dev.transport_wru.utbl_date_table` | MANAGED | 13 | reference / mapping | Created by the file upload UI |
| `transport_wru` | [[Transport Table - transport_wru - utbl_eot_reasons]] | `transport_dev.transport_wru.utbl_eot_reasons` | MANAGED | 2 | reference / mapping | Created by the file upload UI |
| `transport_wru` | [[Transport Table - transport_wru - utbl_inspection_road_sections]] | `transport_dev.transport_wru.utbl_inspection_road_sections` | MANAGED | 10 | inspection / audit / condition | Created by the file upload UI |
| `transport_wru` | [[Transport Table - transport_wru - utbl_lane_access_lane_config]] | `transport_dev.transport_wru.utbl_lane_access_lane_config` | MANAGED | 7 | lane access | Created by the file upload UI |
| `transport_wru` | [[Transport Table - transport_wru - utbl_lane_access_road_chainage]] | `transport_dev.transport_wru.utbl_lane_access_road_chainage` | MANAGED | 5 | lane access | Created by the file upload UI |
| `transport_wru` | [[Transport Table - transport_wru - utbl_lane_access_traffic_volumes]] | `transport_dev.transport_wru.utbl_lane_access_traffic_volumes` | MANAGED | 10 | traffic counts / closures | Created by the file upload UI |
| `transport_wru` | [[Transport Table - transport_wru - utbl_metrocount_direction_converter]] | `transport_dev.transport_wru.utbl_metrocount_direction_converter` | MANAGED | 9 |  | Created by the file upload UI |
| `transport_wru` | [[Transport Table - transport_wru - utbl_monthly_bins]] | `transport_dev.transport_wru.utbl_monthly_bins` | MANAGED | 9 |  | Created by the file upload UI |
| `transport_wru` | [[Transport Table - transport_wru - utbl_non_compliant_inspections]] | `transport_dev.transport_wru.utbl_non_compliant_inspections` | MANAGED | 2 | inspection / audit / condition | Created by the file upload UI |
| `transport_wru` | [[Transport Table - transport_wru - utbl_psdr_comparison]] | `transport_dev.transport_wru.utbl_psdr_comparison` | MANAGED | 6 |  | Created by the file upload UI |
| `transport_wru` | [[Transport Table - transport_wru - utbl_public_holidays]] | `transport_dev.transport_wru.utbl_public_holidays` | MANAGED | 3 | reference / mapping | Created by the file upload UI |
| `transport_wru` | [[Transport Table - transport_wru - utbl_raw_data_march]] | `transport_dev.transport_wru.utbl_raw_data_march` | MANAGED | 6 |  | Created by the file upload UI |
| `transport_wru` | [[Transport Table - transport_wru - utbl_work_peaktime_periods]] | `transport_dev.transport_wru.utbl_work_peaktime_periods` | MANAGED | 4 |  | Created by the file upload UI |
| `transport_wru` | [[Transport Table - transport_wru - uvw_a_drainage]] | `transport_dev.transport_wru.uvw_a_drainage` | VIEW | 21 |  |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_a_embankments]] | `transport_dev.transport_wru.uvw_a_embankments` | VIEW | 11 |  |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_a_fencing]] | `transport_dev.transport_wru.uvw_a_fencing` | VIEW | 26 |  |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_a_kerb_and_channels]] | `transport_dev.transport_wru.uvw_a_kerb_and_channels` | VIEW | 13 |  |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_a_minor_culverts]] | `transport_dev.transport_wru.uvw_a_minor_culverts` | VIEW | 53 |  |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_a_pathways]] | `transport_dev.transport_wru.uvw_a_pathways` | VIEW | 30 |  |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_a_paved_areas]] | `transport_dev.transport_wru.uvw_a_paved_areas` | VIEW | 20 |  |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_a_pit]] | `transport_dev.transport_wru.uvw_a_pit` | VIEW | 20 |  |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_a_road]] | `transport_dev.transport_wru.uvw_a_road` | VIEW | 11 |  |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_a_signs]] | `transport_dev.transport_wru.uvw_a_signs` | VIEW | 31 |  |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_a_table_drains]] | `transport_dev.transport_wru.uvw_a_table_drains` | VIEW | 19 |  |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_a_vehicle_barriers]] | `transport_dev.transport_wru.uvw_a_vehicle_barriers` | VIEW | 35 |  |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_asset]] | `transport_dev.transport_wru.uvw_asset` | VIEW | 33 | asset register / hierarchy |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_asset_audit]] | `transport_dev.transport_wru.uvw_asset_audit` | VIEW | 9 | asset register / hierarchy |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_asset_pwa]] | `transport_dev.transport_wru.uvw_asset_pwa` | VIEW | 16 | asset register / hierarchy |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_asset_register]] | `transport_dev.transport_wru.uvw_asset_register` | VIEW | 13 | asset register / hierarchy |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_assetattribute]] | `transport_dev.transport_wru.uvw_assetattribute` | VIEW | 9 | asset register / hierarchy |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_bis_bridge]] | `transport_dev.transport_wru.uvw_bis_bridge` | VIEW | 23 |  |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_bis_new_ras_bridge]] | `transport_dev.transport_wru.uvw_bis_new_ras_bridge` | VIEW | 14 |  |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_bis_new_ras_component]] | `transport_dev.transport_wru.uvw_bis_new_ras_component` | VIEW | 22 |  |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_bis_new_ras_inventory]] | `transport_dev.transport_wru.uvw_bis_new_ras_inventory` | VIEW | 46 | inventory / materials |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_bis_new_ras_miscellaneous]] | `transport_dev.transport_wru.uvw_bis_new_ras_miscellaneous` | VIEW | 16 | lane access |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_bis_new_ras_status]] | `transport_dev.transport_wru.uvw_bis_new_ras_status` | VIEW | 5 | workflow / status |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_capitalwork]] | `transport_dev.transport_wru.uvw_capitalwork` | VIEW | 27 | capital works / forward works |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_capitalworktask]] | `transport_dev.transport_wru.uvw_capitalworktask` | VIEW | 33 | capital works / forward works |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_created_assets]] | `transport_dev.transport_wru.uvw_created_assets` | VIEW | 6 | asset register / hierarchy |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_created_completed_jobs]] | `transport_dev.transport_wru.uvw_created_completed_jobs` | VIEW | 4 | jobs / work orders |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_doc_signees]] | `transport_dev.transport_wru.uvw_doc_signees` | VIEW | 9 |  |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_documents]] | `transport_dev.transport_wru.uvw_documents` | VIEW | 13 | documents / evidence |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_eot_jobs]] | `transport_dev.transport_wru.uvw_eot_jobs` | VIEW | 23 | jobs / work orders |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_exportdate]] | `transport_dev.transport_wru.uvw_exportdate` | VIEW | 5 | reference / mapping |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_inspection]] | `transport_dev.transport_wru.uvw_inspection` | VIEW | 47 | inspection / audit / condition |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_inspection_cathodic_protection]] | `transport_dev.transport_wru.uvw_inspection_cathodic_protection` | VIEW | 20 | inspection / audit / condition |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_inspection_completions]] | `transport_dev.transport_wru.uvw_inspection_completions` | VIEW | 16 | inspection / audit / condition |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_inspection_hazard_defect]] | `transport_dev.transport_wru.uvw_inspection_hazard_defect` | VIEW | 50 | defects / hazards / failures |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_inspection_kpi_1_dashboard]] | `transport_dev.transport_wru.uvw_inspection_kpi_1_dashboard` | VIEW | 30 | KPI / reporting |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_inspection_kpi_1_series]] | `transport_dev.transport_wru.uvw_inspection_kpi_1_series` | VIEW | 28 | KPI / reporting |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_inspection_settlement_monitoring]] | `transport_dev.transport_wru.uvw_inspection_settlement_monitoring` | VIEW | 8 | inspection / audit / condition |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_inspection_structures]] | `transport_dev.transport_wru.uvw_inspection_structures` | VIEW | 23 | inspection / audit / condition |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_inspection_typesnormalised]] | `transport_dev.transport_wru.uvw_inspection_typesnormalised` | VIEW | 8 | inspection / audit / condition |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_inspections_level_1]] | `transport_dev.transport_wru.uvw_inspections_level_1` | VIEW | 17 | inspection / audit / condition |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_inspections_level_2]] | `transport_dev.transport_wru.uvw_inspections_level_2` | VIEW | 18 | inspection / audit / condition |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_inspections_level_3]] | `transport_dev.transport_wru.uvw_inspections_level_3` | VIEW | 9 | inspection / audit / condition |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_jeopardy_board]] | `transport_dev.transport_wru.uvw_jeopardy_board` | VIEW | 23 |  |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_jeopardy_board_jobs]] | `transport_dev.transport_wru.uvw_jeopardy_board_jobs` | VIEW | 22 | jobs / work orders |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_job]] | `transport_dev.transport_wru.uvw_job` | VIEW | 87 | jobs / work orders |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_job_geom]] | `transport_dev.transport_wru.uvw_job_geom` | VIEW | 5 | jobs / work orders |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_job_kpi_2]] | `transport_dev.transport_wru.uvw_job_kpi_2` | VIEW | 44 | KPI / reporting |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_kpi_1_noncompliant]] | `transport_dev.transport_wru.uvw_kpi_1_noncompliant` | VIEW | 3 | KPI / reporting |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_laneaccess_raw]] | `transport_dev.transport_wru.uvw_laneaccess_raw` | VIEW | 40 | lane access |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_laneaccess_report]] | `transport_dev.transport_wru.uvw_laneaccess_report` | VIEW | 41 | lane access |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_lastmodified]] | `transport_dev.transport_wru.uvw_lastmodified` | VIEW | 2 |  |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_rm_inspection_dashboard]] | `transport_dev.transport_wru.uvw_rm_inspection_dashboard` | VIEW | 62 | inspection / audit / condition |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_rm_jobs_reporting]] | `transport_dev.transport_wru.uvw_rm_jobs_reporting` | VIEW | 64 | jobs / work orders |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_rm_yesterdays_jobs]] | `transport_dev.transport_wru.uvw_rm_yesterdays_jobs` | VIEW | 5 | jobs / work orders |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_tgs_module]] | `transport_dev.transport_wru.uvw_tgs_module` | VIEW | 7 | forms / modules |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_tgs_speed_limits]] | `transport_dev.transport_wru.uvw_tgs_speed_limits` | VIEW | 2 |  |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_timesheet]] | `transport_dev.transport_wru.uvw_timesheet` | VIEW | 21 | resources / timesheets |  |
| `transport_wru` | [[Transport Table - transport_wru - uvw_timesheetitem]] | `transport_dev.transport_wru.uvw_timesheetitem` | VIEW | 29 | resources / timesheets |  |
| `transport_wru` | [[Transport Table - transport_wru - vw_job_export_final]] | `transport_dev.transport_wru.vw_job_export_final` | VIEW | 32 | jobs / work orders |  |

## Not Catalogued In This Transport Pass

- `ext_mssql_vntprdbpmxsql01_maximo` was visible in Databricks but intentionally excluded from this Transport table documentation pass for now; Maximo source-table documentation is deferred.
- `ext_mssql_ewg_twb_db1_mexdb` was visible in Databricks with 1,139 `dbo` tables, but the current wiki and source-system inventory do not provide a Transport contract/source mapping. It was not added to the Transport table docs in this pass.
- `ext_psql_urbanise_ventia_dwh_pg_plaza` was visible in Databricks with 148 `public` tables, but the current wiki and source-system inventory do not provide a Transport contract/source mapping. It was not added to the Transport table docs in this pass.
- System schemas, `information_schema`, SQL Server `sys`, PostgreSQL catalog schemas, samples, and Databricks internal catalogues were excluded.

## Related Pages

- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
- [[Databricks Source Systems]]

