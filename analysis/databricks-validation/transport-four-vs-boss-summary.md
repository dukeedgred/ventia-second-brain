# Transport Four Vs Summary

Generated: 09/06/2026

Scope: Asset Vision source tables and Transport contract/contractor schemas visible in Databricks.

## Caveats

- Volume is row count by table object. Views and base tables can overlap, so totals are not deduplicated business records.
- Contract/contractor table volumes are accessible row counts. Some views could not be counted because Databricks returned permission errors or broken view dependencies.
- Velocity is inferred from the freshest timestamp/date values found in the tables. It is not the confirmed pipeline schedule.
- Usage/veracity, as requested, means how much the data is used. Databricks lineage usage could not be measured with the current authentication because `system.access.table_lineage` returned `USE SCHEMA` permission denied.
- SHT/Maximo caveat: stakeholder documentation says Sydney Harbour Tunnel is operationally a Maximo tunnel contract. The Databricks source inventory also contains `ext_mssql_asset_vision_vns_gen7` with a supplied source-system comment mapping it to SHT/WHT. That proves an Asset Vision-labelled Databricks source catalogue exists for SHT/WHT data; it does not prove SHT's authoritative operational system is Asset Vision.

## Executive summary

| Data area | Volume | Velocity | Variety | Usage / veracity |
|---|---:|---|---|---|
| Asset Vision source tables | 111,802,224 rows across 230 table objects | Current operational data present; latest source-table activity reaches 09/06/2026 or 10/06/2026 depending on timestamp/timezone handling | Assets, jobs, inspections, defects/hazards, capital works, photos, forms/modules, workflow/status, resources, timesheets, reference/export/system data | Actual query/lineage usage not available with current permissions |
| Transport contract/contractor tables | 233,560,284 accessible rows across 319 table objects; 122 objects counted and 197 objects not executable/countable from current auth | Mixed: most active schemas have current data; RAMC/SRAP-C are recent; SHT latest counted timestamp is 14/04/2026 | Traffic counts, KPI/reporting views, job exports, timesheets, capital works, lane access, tunnel/contract-specific outputs, reference/date/EOT tables | Actual query/lineage usage not available with current permissions |

## Source table summary

| Source catalogue | Table objects | Row count | Velocity signal | Variety |
|---|---:|---:|---|---|
| `ext_mssql_asset_vision_ven_gen7` | 38 | 24,051,436 | Current source activity present | Asset Vision operational core: assets, jobs, inspections, capital works, photos, forms/modules, workflow, resources, timesheets |
| `ext_mssql_asset_vision_ven_rms` | 38 | 24,569,468 | Current source activity present | Asset Vision operational core, SRAP-C/RMS context |
| `ext_mssql_asset_vision_ven_vicroads` | 40 | 37,854,148 | Current source activity present | Asset Vision operational core plus lane access and SQL Server version metadata |
| `ext_mssql_asset_vision_vns_gen7` | 38 | 5,071,032 | Current source activity present | Asset Vision-labelled Databricks source catalogue mapped to SHT/WHT; operational SHT system remains documented as Maximo |
| `ext_mssql_asset_vision_vnz_gen7` | 38 | 14,430,838 | Current source activity present | Asset Vision operational core, Auckland West context |
| `ext_mssql_asset_vision_vsm_gen7` | 38 | 5,825,302 | Current source activity present | Asset Vision operational core, VentureSmart context |

## Contract / contractor table summary

| Contract schema | Objects | Counted objects | Accessible row count | Velocity signal | Variety | Count gaps |
|---|---:|---:|---:|---|---|---|
| `transport_dev.transport` | 40 | 8 | 16,519,404 | Current: latest data within 1 day | Forms/modules, contract-specific outputs, resources/timesheets | 32 views not counted due permission errors |
| `transport_dev.transport_aklw` | 11 | 11 | 1,822,984 | Current: latest data within 1 day | Capital works, forms/modules, resources/timesheets, contract-specific outputs | None from current run |
| `transport_dev.transport_fndc` | 12 | 12 | 264,594 | Current: latest data within 1 day | Contract-specific outputs | None from current run |
| `transport_dev.transport_nel` | 4 | 4 | 11,405 | Current: latest data within 1 day | Contract-specific outputs, reference support | None from current run |
| `transport_dev.transport_ramc` | 17 | 9 | 39,868 | Recent: latest data within 31 days | Audit/export/system, contract-specific outputs | 8 views not counted due permission errors |
| `transport_dev.transport_sht` | 27 | 13 | 165,474,873 | Stale: latest counted timestamp within 180 days, 14/04/2026 | Tunnel/contract-specific outputs | 14 views not counted due unresolved column/view issues |
| `transport_dev.transport_srapc` | 42 | 5 | 1,108 | Recent: latest data within 31 days | Asset/contract-specific outputs | 37 views not counted due broken dependencies |
| `transport_dev.transport_tsrc` | 88 | 42 | 829,475 | Current: latest data within 1 day | KPI/reporting views, traffic counts, reference support, contract-specific outputs | 46 views not counted due permission errors or invalid view SQL |
| `transport_dev.transport_wru` | 78 | 18 | 48,596,573 | Current: latest data within 1 day | Traffic counts, lane access, capital works, timesheets, audit/export/system, reference support | 60 views not counted due permission errors |

## What each contract / contractor schema contains

| Contract schema | Sort of data present | Table/view signals |
|---|---|---|
| `transport_dev.transport` | Cross-contract transport commercial, workforce and work-order support data. | All-contract jobs, job form fields, resources, timesheets, SAP items, purchase orders, purchase requisitions, vendor master/open/cleared items, cost centre/WBS/project master data, equipment master/depreciation, service entry and CATS/PTMW views. |
| `transport_dev.transport_aklw` | Auckland West operational Asset Vision-style data. | Asset, job, inspection, capital work, capital work task, form fields, workflow status, timesheet item/report, plant pending timesheet and updated dispatch ID views. |
| `transport_dev.transport_fndc` | Road asset layers, forward works, dispatch/cost and weather data. | Surface, drainage, footpath, pavement layer, railings, signs, treatment length, forward work view, maintenance cost, dispatch, dispatch claim and hourly weather forecast tables/views. |
| `transport_dev.transport_nel` | KPI-oriented asset, work-order and system availability data. | KPI assets, KPI work orders, KPI system availability devices and reference date table. |
| `transport_dev.transport_ramc` | Backlog, monthly job snapshot, strip-map and job/inspection reporting data. | Backlog change reports, current/last month job snapshots, monthly backlog reduction, reporting period, job, inspection, road-last-inspected and strip-map views. |
| `transport_dev.transport_sht` | SHT contract reporting/curated data. This is not the same thing as saying the source operational system is Asset Vision. | NPS/SPS/TVS northbound/southbound segment tables, segmented views, all assets, critical assets, job, inspection, user groups, AI views and North Sydney rolling weather view. Stakeholder notes identify SHT operational work management as Maximo. |
| `transport_dev.transport_srapc` | SRAP-C asset, job, inspection, customer request, monthly report and subcontractor reporting data. | Monthly report, Formitize mapping, TACP constants/TOC/data loads, civil master, bridge/slope/school-zone assets, asset/job/inspection/customer request attribute views, photos, monthly subcontractor energy/health-safety/material/social/fuel/waste views, special projects, TFNSW monthly defect intervention and weather observations. |
| `transport_dev.transport_tsrc` | TSRC assets, incidents, work orders, inspections, KPI/abatement, PCAS/pavement, traffic and lane-closure data. | AED assets/incidents/work orders, asset register, work order, inspection requirements, road safety audit, KPI 2/3/10/18/19/25 views, ITS asset uptime/jobs, CCTV requests, toll road unavailability, PCAS/pavement tables, lane closure reference factors, traffic closures/volume, customer requests and capital work views. |
| `transport_dev.transport_wru` | WRU traffic counts, lane access, road asset categories, inspections, jobs, capital works, documents and timesheets. | Counter locations, counts by carriageway/lane/hour, lane access config/chainage/traffic volumes, asset category views for drainage/embankments/fencing/kerb/culverts/pathways/paved areas/pits/roads/signs/table drains/barriers, bridge/BIS/RAS views, inspection dashboards/levels/hazard-defect/completions, job/job geometry/job export, capital work, EOT, documents, timesheets, TGS speed limits, public holidays and work peak periods. |

## What this says in plain language

- Volume: the data estate is large. Source tables hold about 111.8M table-object rows. Contract/contractor schemas hold at least 233.6M accessible rows, with more behind views that could not be executed with the current account.
- Velocity: this is not a static archive. Current timestamp signals exist in the main source tables and most contract schemas. SHT is the main visible stale area in the counted contract tables.
- Variety: the source layer is operational Asset Vision data. The contract layer is more reporting/curation-heavy, especially traffic counts, KPI outputs, timesheets, lane access, capital works and contract-specific views.
- Usage/veracity: actual usage counts were not available because Databricks system lineage access is blocked. Any claim about "most used" tables would need `system.access.table_lineage`, query history, dashboard lineage, or BI/report access logs.
- SHT system interpretation: treat SHT as Maximo-led operationally unless the tunnel SMEs or source owners confirm otherwise. Treat `ext_mssql_asset_vision_vns_gen7` as an Asset Vision-labelled Databricks source catalogue that contains SHT/WHT-mapped data, not as proof that SHT operates in Asset Vision.
