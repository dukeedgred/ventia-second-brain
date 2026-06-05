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
