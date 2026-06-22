# Log

Append-only history of ingestions and significant updates.

## [2026-05-25] ingest | Weekly planning meeting — UAT strategy, classification decisions, Obsidian setup

Created 6 wiki pages from weekly planning meeting notes: Engagement Team, Spend Cube Engagement, Classification Approach, Evaluation Framework, Taxonomy and Stakeholders, UAT Planning (new). Key decisions: keep rule/RAG/LLM determinations separate for UAT; add taxonomy suggestion column; use file extracts to hit Tuesday deadline while Snowflake write access is pending.

## [2026-05-28] ingest | DAII monthly meeting transcript

Created six wiki pages summarising DAII monthly meeting themes: data governance, safety metrics, data platform modernisation, EDW Ernie, and AI/innovation portfolio updates.

## [2026-05-28] ingest | Databricks walk-through

Created Databricks platform, Transport data landscape, Asset Vision, and source-summary pages from Kale Skinner's walkthrough; refreshed Engagement Team contacts.

## [2026-05-28] ingest | Transport Data and AI Working Group

Created Transport working group, asset intelligence roadmap, and Gen 3 tender innovation pages; updated Transport, Asset Vision, innovation, Evolve, and stakeholder context.

## [2026-06-01] ingest | DB walkthrough with Pranav Kumar

Created Transport contract portfolio and reporting opportunity pages; updated Databricks, Asset Vision, Transport landscape, asset intelligence, and stakeholder context.

## [2026-06-02] ingest | Integrated Transport Data Asset executive brief

Created source-summary and concept pages for Damien's Transport executive brief; updated Transport landscape, reporting opportunities, Databricks, and stakeholder context.

## [2026-06-02] ingest | Transport first two-week plan

Created a source-summary page for the Transport first-two-week plan and updated Transport data asset, landscape, RAMC, sensing, governance, reporting, and stakeholder pages.

## [2026-06-02] lint | Removed stale catalog rows, repaired metadata and link issues, and added a Databricks modernisation cross-reference.

## [2026-06-03] ingest | SAP data walk-through for Transport finance reporting

Created source-summary and Transport financial reporting pages; updated Transport landscape, platform, reporting, portfolio, Asset Vision, integrated data asset, and stakeholder context.

## [2026-06-03] ingest | Transport data asset stakeholder interview

Ingested Rui Luan's stakeholder interview, creating source-summary and Maximo pages while updating Transport data landscape, Asset Vision, reporting, portfolio, Databricks, finance, and stakeholder context.

## [2026-06-04] ingest | Transport asset data stakeholder interview with Toby Lin

Created Toby Lin source-summary plus asset inventory validation and condition inspection pages; updated Transport asset, data landscape, reporting, Databricks, and stakeholder context.

## [2026-06-05] table-docs | Transport AKLW Databricks views

Created the Transport data table catalog, the `transport_aklw` contract/schema catalog, and nine table schema pages for visible complete Databricks view definitions. Skipped `uvw_inspection` because the pasted schema was truncated before all columns could be verified.

## [2026-06-05] table-docs | Transport AKLW view SQL definitions

Refreshed eight `transport_aklw` table pages with supplied view SQL definitions: `uvw_asset`, `uvw_capitalwork`, `uvw_capitalworktask`, `uvw_formfield`, `uvw_timesheetitem`, `uvw_timesheetreport`, `uvw_updated_dispatch_id`, and `uvw_workflowstatus`. Left `uvw_inspection` incomplete and left `uvw_plant_pending_timesheet` without a view-query refresh because their complete supplied objects were not visible in the retained pasted payload.

## [2026-06-05] table-docs | Transport FNDC Databricks tables

Created the `transport_fndc` contract/schema catalog and three table schema pages for complete visible Databricks metadata objects: `byo_tbl_kerikeri_weather_hr_fc`, `byo_tbl_national_road_cl_nz`, and `weather_hourly_forecast`. Skipped `uvw_c_surface` and a later treatment-length view object because the pasted payload was truncated before complete table metadata and view SQL could be verified.

## [2026-06-05] table-docs | Transport NEL Databricks tables

Created the `transport_nel` contract/schema catalog and four table schema pages for complete Databricks metadata objects: `utbl_kpi_assets`, `utbl_kpi_work_orders`, `utbl_ref_date_table`, and `uvw_kpi_sys_av_devices`. Preserved the supplied SQL definition for the `uvw_kpi_sys_av_devices` view.

## [2026-06-05] table-docs | Transport RAMC Databricks tables

Created the `transport_ramc` contract/schema catalog and nine table schema pages for complete visible Databricks metadata objects: `bkp_backlog_change_report`, `bkp_current_month_job_snapshot`, `bkp_last_month_job_snapshot`, `bkp_monthly_backlog_reduction`, `utbl_backlog_change_report`, `utbl_current_month_job_snapshot`, `uvw_stripmap_jobphotos`, `uvw_stripmap_jobs`, and `uvw_stripmap_wkt`. Preserved the supplied SQL definitions for the three visible stripmap views. Skipped `utbl_last_month_job_snapshot` and one RAMC view object because the pasted payload was truncated before complete metadata could be verified.

## [2026-06-05] table-docs | Transport SHT Databricks tables

Created the `transport_sht` contract/schema catalog and 22 table schema pages for complete visible Databricks metadata objects, including SHT sensor reading tables, temporary upload staging tables, service schedule latitude data, inspection compliance view `uvw_ai1`, segmented sensor reading views, user-group mapping, and the North Sydney hourly rolling weather view. Preserved supplied SQL definitions for all complete visible SHT views. Skipped `uvw_ai2` and one SHT job view object because the pasted payload was truncated before complete metadata could be verified.

## [2026-06-05] table-docs | Transport SRAPC Databricks tables

Created the `transport_srapc` contract/schema catalog and six table schema pages for complete visible Databricks metadata objects: `utbl_monthly_report`, `utbl_srapc_formitize_mapping`, `utbl_tacp_constants`, `utbl_tacp_toc`, `utbl_tmp_civil_master`, and `uvw_weatherobervations`. Preserved the supplied SQL definition for `uvw_weatherobervations`. Skipped `uvw_a_bridge_all_data` and one SRAPC TACP/export view object because the pasted payload was truncated before complete metadata could be verified.

## [2026-06-05] table-docs | Transport TSRC Databricks tables

Created the `transport_tsrc` contract/schema catalog and eight table schema pages for complete visible Databricks metadata objects: `bkp_uvw_incident_closures`, `utbl_aed_asset_bridge`, `utbl_aed_assets`, `utbl_aed_incidents_closures`, `utbl_aed_incidents_events`, `utbl_aed_incidents_list`, `uvw_traffic_closures`, and `uvw_traffic_volume`. Preserved the supplied SQL definitions for `uvw_traffic_closures` and `uvw_traffic_volume`. Skipped `utbl_aed_incidents_sr` and one or more intervening TSRC KPI/abatement objects because the pasted payload was truncated before complete metadata could be verified.

## [2026-06-05] table-docs | Transport WRU Databricks tables

Created the `transport_wru` contract/schema catalog and 10 table schema pages for complete visible Databricks metadata objects: `utbl_capitalwork_chainage`, `utbl_counter_locations`, `utbl_counts_by_carriageway`, `utbl_counts_by_lane`, `utbl_counts_hourly`, `utbl_date_table`, `utbl_eot_reasons`, `uvw_timesheet`, `uvw_timesheetitem`, and `vw_job_export_final`. Preserved the supplied SQL definitions for the three visible WRU views. Skipped `utbl_inspection_road_sections` and one WRU speed view object because the pasted payload was truncated before complete metadata could be verified.

## [2026-06-05] table-docs | Transport shared Databricks tables

Created the `transport` contract/schema catalog and nine table schema pages for complete visible Databricks metadata objects: `utbl_job_costing_timesheets_all_contracts`, `uvw_purgrp_masterdata_detail`, `uvw_purgrp_masterdata_uniquelist`, `uvw_vendor_cleared_items_bsak`, `uvw_vendor_master_data`, `uvw_vendor_open_items_bsik`, `uvw_wbs_budget_forecast_data_cosp`, `uvw_wbs_master_data_prps`, and `uvw_wo_nwa_master_data_aufk_afko_afvc`. Preserved supplied SQL definitions for the eight visible `transport` views. Skipped `utbl_jobs_allcontract` and any intervening hidden objects because the pasted payload was truncated before complete metadata could be verified.

## [2026-06-05] table-docs | Transport enterprise current-state interactive visual

Created an Enterprise Current State folder with an interactive HTML visual and summary page covering Transport enterprise data readiness across shared schema context, contract asset enrichments, inspections, condition, defects, and geospatial capability. Updated the current-state assumption to mark `transport_dev.transport.utbl_jobs_allcontract` as decommissioned rather than an active enterprise work-order base.

## [2026-06-05] table-docs | Transport contract data maturity assessment

Added a detailed maturity assessment page and extended the interactive current-state visual with a Data Maturity tab. Scored each Transport contract/schema on a 1-5 planning scale and documented each contract's strengths, limitations, and next maturity step.

## [2026-06-05] table-docs | Asset Vision VSM Gen7 source tables

Created the `dbo` source schema catalog and 10 table schema pages for complete visible `ext_mssql_asset_vision_vsm_gen7.dbo` metadata objects: `asset`, `assetarea`, `assetattribute`, `assetaudit`, `assetclassification`, `assetlocation`, `capitalwork`, `vmodule`, `vworkflowstatus`, and `workflowstatus`. Kept the source catalog separate from contract mapping because no contractor/contract identifier was supplied. Skipped `capitalworktask` and at least one intervening source-table object because the pasted payload was truncated before complete metadata could be verified.

## [2026-06-05] table-docs | Corrected Asset Vision source context

Reclassified the `ext_mssql_asset_vision_vsm_gen7.dbo` pages from a `dbo` contract/schema context to an `asset_vision_vsm_gen7` source context. Preserved `dbo` only as the SQL Server source schema and added an explicit caveat that client or contract identity should be confirmed from source notes, view filters, `Contract` values, table/view names, or validated naming conventions rather than inferred from generic database schemas.

## [2026-06-05] table-docs | Asset Vision VNZ Gen7 source tables

Created the `asset_vision_vnz_gen7` source context catalog and 10 table schema pages for complete visible `ext_mssql_asset_vision_vnz_gen7.dbo` metadata objects: `asset`, `assetarea`, `assetattribute`, `assetaudit`, `assetclassification`, `assetlocation`, `capitalwork`, `vmodule`, `vworkflowstatus`, and `workflowstatus`. Preserved `dbo` only as the SQL Server source schema. Skipped `capitalworktask` and at least one intervening source-table object because the pasted payload was truncated before complete metadata could be verified.

## [2026-06-05] table-docs | Asset Vision VNS Gen7 source tables

Created the `asset_vision_vns_gen7` source context catalog and 10 table schema pages for complete visible `ext_mssql_asset_vision_vns_gen7.dbo` metadata objects: `asset`, `assetarea`, `assetattribute`, `assetaudit`, `assetclassification`, `assetlocation`, `capitalwork`, `vmodule`, `vworkflowstatus`, and `workflowstatus`. Preserved `dbo` only as the SQL Server source schema. Skipped `capitalworktask` and at least one intervening source-table object because the pasted payload was truncated before complete metadata could be verified.

## [2026-06-05] table-docs | Asset Vision VEN VicRoads source tables

Created the `asset_vision_ven_vicroads` source context catalog and 10 table schema pages for complete visible `ext_mssql_asset_vision_ven_vicroads.dbo` metadata objects: `asset`, `assetarea`, `assetattribute`, `assetaudit`, `assetclassification`, `assetlocation`, `capitalwork`, `vmodule`, `vworkflowstatus`, and `workflowstatus`. Preserved `dbo` only as the SQL Server source schema and treated `ven_vicroads` as a catalog naming signal to confirm against source notes or column values. Skipped `capitalworktask` and at least one intervening source-table object because the pasted payload was truncated before complete metadata could be verified.

## [2026-06-05] table-docs | Asset Vision VEN RMS Old source tables

Created the `asset_vision_ven_rms_old` source context catalog and 10 table schema pages for complete visible `ext_mssql_asset_vision_ven_rms_old.dbo` metadata objects: `asset`, `assetarea`, `assetattribute`, `assetaudit`, `assetclassification`, `assetlocation`, `capitalwork`, `vmodule`, `vworkflowstatus`, and `workflowstatus`. Preserved `dbo` only as the SQL Server source schema and treated `ven_rms_old` as a catalog naming signal to confirm against source notes or column values. Skipped `capitalworktask` and at least one intervening source-table object because the pasted payload was truncated before complete metadata could be verified.

## [2026-06-05] table-docs | Asset Vision VEN Gen7 source tables

Created the `asset_vision_ven_gen7` source context catalog and 10 table schema pages for complete visible `ext_mssql_asset_vision_ven_gen7.dbo` metadata objects: `asset`, `assetarea`, `assetattribute`, `assetaudit`, `assetclassification`, `assetlocation`, `capitalwork`, `vmodule`, `vworkflowstatus`, and `workflowstatus`. Preserved `dbo` only as the SQL Server source schema and treated `ven_gen7` as a catalog naming signal to confirm against source notes or column values. Skipped `capitalworktask` and at least one intervening source-table object because the pasted payload was truncated before complete metadata could be verified.

## [2026-06-05] table-docs | Expanded Asset Vision VEN Gen7 source tables

Updated the `asset_vision_ven_gen7` source context from 10 to 38 complete `ext_mssql_asset_vision_ven_gen7.dbo` table schemas. Added source table pages for the previously missing Asset Vision job, inspection, capital work task, resource, timesheet, photo, module, export tracking, summary check, and WKT view-style source tables. Removed the obsolete `capitalworktask` truncation note for this context because the new payload supplied a complete schema. Preserved `dbo` only as the SQL Server source schema, not a client or contract.
## [2026-06-05] table-docs | Asset Vision VEN RMS source tables

Created the `asset_vision_ven_rms` source context catalog and 40 table schema pages for supplied `ext_mssql_asset_vision_ven_rms.dbo` metadata objects. Preserved `dbo` only as the SQL Server source schema and treated `ven_rms` as a catalog naming signal to confirm against source notes, view filters, `Contract` values, or validated naming conventions. Documented 22 explicit empty `columns: []` arrays as column count `0` rather than treating those table objects as truncated input.
## [2026-06-05] table-docs | Expanded Asset Vision VEN VicRoads source tables

Updated the `asset_vision_ven_vicroads` source context from 10 to 40 complete `ext_mssql_asset_vision_ven_vicroads.dbo` table schemas. Added source table pages for the previously missing Asset Vision job, lane-access, inspection, capital work task, resource, timesheet, photo, SQL Server version, summary check, and WKT view-style source tables. Removed the obsolete `capitalworktask` truncation note for this context because the new payload supplied a complete schema. Preserved `dbo` only as the SQL Server source schema, not a client or contract.

## [2026-06-09] table-docs | Databricks source-system inventory

Added [[Databricks Source Systems]] with 10 supplied external Databricks catalogs, including Asset Vision Transport contract mappings and null/blank schema or comment gaps. Updated [[Transport Data Tables]], seven Asset Vision source-context catalogs, [[Ventia Databricks Platform]], and [[Transport Data Landscape]] to link the inventory and preserve `dbo` as SQL Server source schema metadata.

## [2026-06-09] table-docs | Databricks full-access Transport table refresh

Queried Databricks with the `ventia-transport` OAuth profile and refreshed Transport table documentation coverage from `system.information_schema`. Added missing table pages across Asset Vision RMS New, `formitize_srapc`, `stg_enterprise_reporting`, `transport_vsm`, and newly visible views/tables in existing `transport_dev` schemas. Refreshed the Transport sector catalog and context catalog pages while preserving existing historical `asset_vision_ven_rms_old` documentation. Maximo was visible in Databricks but intentionally deferred from this Transport table documentation pass for now. EWG MEXDB and Urbanise Plaza catalogues were visible but not added to Transport table docs because no current source-backed Transport mapping was available.

## [2026-06-09] report | Transport contractor data maturity HTML

Created [[Transport Contractor Data Maturity Report]] with an interactive HTML dashboard comparing documented Transport contract/schema contexts by data maturity, analytics sophistication, evidence-backed strengths, risks, and recommendations. The report uses current Transport table documentation and curated wiki notes, excludes Maximo from the scored comparison for now, and states the metadata-based evidence boundary.

## [2026-06-10] report | Contractor table-use inference layer

Added a per-table inferred-use layer to [[Transport Contractor Data Maturity Report]] for 289 documented contractor/schema tables. The layer uses documented domains, table descriptions, column names, and view SQL where available, and keeps inferred use separate from source-backed table-page business-purpose fields by showing confidence and evidence basis in the HTML report.

Updated the same report with common-analysis coverage rows that show which contractor/schema contexts are present and missing for analysis categories appearing in at least half of the documented contractor set.

Expanded the report evidence ledger and contractor detail panel with explicit score-rationale and missing-evidence notes, including the caveat that KPI presence is scored by documented depth and reuse readiness rather than as a simple yes/no flag.

## [2026-06-14] ingest | Transport data asset stakeholder interview Anna Covell

Created [[Transport Data Asset Stakeholder Interview Anna Covell]] and updated related Asset Vision, Transport contract portfolio, data landscape, condition-inspection, reporting, roadmap, data asset, and stakeholder pages.

## [2026-06-14] ingest | Transport data asset stakeholder interview Huy Nguyen

Created [[Transport Data Asset Stakeholder Interview Huy Nguyen]] and updated related Maximo, Databricks, asset handover, condition inspection, reporting, portfolio, data asset, and stakeholder pages.

## [2026-06-14] ingest | Transport data asset stakeholder interview Rui Luan part 2

Created [[Transport Data Asset Stakeholder Interview Rui Luan Part 2]] and [[Western Roads Upgrade]], then updated related Asset Vision, data landscape, inspections, reporting, roadmap, portfolio, Databricks, data asset, and stakeholder pages.

## [2026-06-15] ingest | Transport data asset stakeholder interview Syed Umar

Created [[Transport Data Asset Stakeholder Interview Syed Umar]] and [[Transport Hand-Back Systems]], then updated related Maximo, Transport data landscape, integrated data asset, portfolio, reporting, inventory-validation, Databricks, and stakeholder pages.

## [2026-06-17] analysis | Transport asset-type metrics and attributes

Created [[Transport Asset Type Metrics and Attributes]] from a live Databricks OAuth validation run across seven active Asset Vision source catalogues. Standardised 245 raw `asset.AssetType` values into 227 asset-type rows using the existing manual mapping, summarized 645,806 non-deleted assets, and documented WKT/geospatial coverage, core asset attributes, custom attributes, job, inspection, capital work, photo/evidence metrics, and generated metric formulas. Wrote repeatable supporting outputs under `analysis/asset-type-metrics/output/` and published six `atm_` Delta tables in `transport_dev.integ_transport_assets` for dashboard/tableau-style consumption: summary, detail, source-contract breakdown, mapping, metric dictionary, and run status. `ext_mssql_asset_vision_ven_rms_old` was skipped because the catalog was not visible in Databricks during the run.

## [2026-06-17] analysis | Transport asset-type metrics SQL workflow

Added `analysis/asset-type-metrics/create_atm_dashboard_tables.sql` as a shorter Databricks SQL-first workflow for recreating the dashboard/helper `atm_` tables from `atm_asset_type_metrics_detail`, so dashboard iteration does not require reading or running the full Python refresh script.

Added `analysis/asset-type-metrics/create_atm_detail_table_from_sources.sql` to document and reproduce the `atm_asset_type_metrics_detail` build directly in Databricks SQL: active Asset Vision source catalogues are unioned, rolled up by source context, contract, and raw asset type, then joined to `asset_vision_asset_type_category_map` to add the standardised taxonomy and coverage metrics.

## [2026-06-18] analysis | Transport data beyond Asset Vision

Created [[Transport Data Beyond Asset Vision]] as a per-table matrix of documented Transport tables and views that appear to represent data beyond raw Asset Vision source tables. The matrix covers Formitize, SAP/procurement, weather, traffic, incident, KPI, Maximo/tunnel, pavement, lane-access, cross-contract, and managed/uploaded contract data, while noting evidence boundaries for rows inferred from table names or documented domains rather than confirmed end-to-end lineage.

## [2026-06-19] analysis | Transport contractor KPI inventory

Created [[Transport Contractor KPI Inventory]] to consolidate contractor KPI and KPI-adjacent reporting areas found in stakeholder notes and Databricks table documentation. The inventory separates stakeholder-confirmed KPI areas from KPI-numbered or KPI-labelled table/view evidence, covering RAMCSC, BAC, Port of Brisbane, WRU, SRAPC, TSRC, SHT/WHT, NEL, FNDC, Auckland West, and VentureSmart with validation gaps for contract KPI appendices and acronym meanings.

## [2026-06-22] ingest | Transport data product meeting recording

Created [[Transport Data Product Meeting Recording]] and updated related Transport data asset, data landscape, Databricks, Asset Vision, and stakeholder pages with the standardised data asset rationale and data-quality dashboard context.

