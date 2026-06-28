---
type: analysis-summary
topic: Ventia
sector: Transport
date-created: 2026-06-18
date-updated: 2026-06-18
tags: [transport, data-tables, databricks, asset-vision, source-systems, data-availability]
---

# Transport Data Beyond Asset Vision

This page lists Transport Databricks tables and views that appear to represent data beyond the raw Asset Vision source tables. It is intended as a working source-selection aid for the [[Integrated Transport Data Asset]] and contract/category data-availability analysis.

## Evidence Boundary

The classification below is conservative. A table is included when the documented table catalog, table name, schema context, or stakeholder notes indicate one of these patterns:

- Managed or uploaded `utbl_*`, `bkp_*`, or `byo_*` data in a contract schema.
- Formitize, SAP/procurement, weather, traffic, incident, KPI, GIS, Maximo/tunnel, pavement, lane-access, or finance-oriented data.
- Curated contract views that are clearly around reporting, KPI, traffic, weather, incident, PCAS/pavement, or other adjacent domains.

Standard Asset Vision-like operational views such as plain `uvw_asset`, `uvw_job`, and `uvw_inspection` are excluded unless the documented context indicates a non-Asset-Vision upstream or adjacent usage. Some rows are still inferred from table names and documented domains rather than confirmed end-to-end lineage.

## Per-Table Matrix

| Contract / context | Table | Data beyond Asset Vision | Usage |
|---|---|---|---|
| RAMC / RAMCSC | `transport_dev.transport_ramc.bkp_backlog_change_report` | Backlog report backup data | Historical or backup copy for backlog-change reporting. |
| RAMC / RAMCSC | `transport_dev.transport_ramc.bkp_current_month_job_snapshot` | Current-month job snapshot backup | Historical or backup copy for current-month backlog/job reporting. |
| RAMC / RAMCSC | `transport_dev.transport_ramc.bkp_last_month_job_snapshot` | Last-month job snapshot backup | Historical or backup copy for month-on-month backlog/job reporting. |
| RAMC / RAMCSC | `transport_dev.transport_ramc.bkp_monthly_backlog_reduction` | Monthly backlog reduction backup | Historical or backup copy for backlog-reduction reporting. |
| RAMC / RAMCSC | `transport_dev.transport_ramc.utbl_backlog_change_report` | Backlog change upload or curated table | RAMCSC backlog change reporting. |
| RAMC / RAMCSC | `transport_dev.transport_ramc.utbl_current_month_job_snapshot` | Current-month job snapshot upload | RAMCSC backlog status and current-month job reporting. |
| RAMC / RAMCSC | `transport_dev.transport_ramc.utbl_last_month_job_snapshot` | Last-month job snapshot upload | Month-on-month backlog/job comparison. |
| RAMC / RAMCSC | `transport_dev.transport_ramc.utbl_monthly_backlog_reduction` | Monthly backlog reduction upload | Backlog-reduction reporting. |
| RAMC / RAMCSC | `transport_dev.transport_ramc.utbl_reporting_period` | Reporting period reference upload | Reporting-period control for RAMCSC backlog/reporting views. |
| SRAPC / Formitize | `transport_dev.formitize_srapc._attachments` | Formitize attachment data | Evidence or document attachment support for Formitize forms. |
| SRAPC / Formitize | `transport_dev.formitize_srapc._json_structure` | Formitize form structure metadata | Form schema/JSON structure discovery for Formitize data. |
| SRAPC / Formitize | `transport_dev.formitize_srapc.civil_maintenance_pre_start_form` | Formitize pre-start form data | Civil maintenance pre-start form capture. |
| SRAPC / Formitize | `transport_dev.formitize_srapc.pre_start_checklist_light_and_heavy_vehicles` | Formitize vehicle checklist data | Light/heavy vehicle pre-start checklist capture. |
| SRAPC / Formitize | `transport_dev.formitize_srapc.srap_parkland_sustainable_procurement_questionnaire` | Formitize procurement questionnaire data | Sustainable procurement questionnaire reporting. |
| SRAPC / Formitize | `transport_dev.formitize_srapc.srapc_monthly_subcontractor_data_capture_portal` | Formitize subcontractor monthly capture | Monthly subcontractor data capture and reporting. |
| SRAPC / Formitize | `transport_dev.formitize_srapc.srapc_monthly_subcontractor_data_capture_portal_fuel_stationary` | Formitize subcontractor fuel capture | Stationary fuel subset of monthly subcontractor reporting. |
| SRAPC | `transport_dev.transport_srapc.utbl_monthly_report` | Monthly report upload | SRAPC monthly reporting input. |
| SRAPC | `transport_dev.transport_srapc.utbl_srapc_formitize_mapping` | Formitize mapping upload | Mapping layer between SRAPC reporting and Formitize data. |
| SRAPC | `transport_dev.transport_srapc.utbl_tacp_constants` | TACP reference constants | Reference values for TACP reporting or transformation. |
| SRAPC | `transport_dev.transport_srapc.utbl_tacp_toc` | TACP table-of-contents/reference upload | TACP reporting/reference control. |
| SRAPC | `transport_dev.transport_srapc.utbl_tmp_civil_master` | Civil master staging upload | Temporary/staging civil master data. |
| SRAPC | `transport_dev.transport_srapc.uvw_arcgis_jobs` | ArcGIS job data | GIS-oriented job reporting or map integration. |
| SRAPC | `transport_dev.transport_srapc.uvw_monthly_subcontractor_data` | Monthly subcontractor reporting data | Consolidated subcontractor reporting. |
| SRAPC | `transport_dev.transport_srapc.uvw_monthly_subcontractor_data_energy` | Monthly subcontractor energy data | Energy subset of subcontractor reporting. |
| SRAPC | `transport_dev.transport_srapc.uvw_monthly_subcontractor_data_health_safety` | Monthly subcontractor health and safety data | Health and safety subset of subcontractor reporting. |
| SRAPC | `transport_dev.transport_srapc.uvw_monthly_subcontractor_data_material` | Monthly subcontractor material data | Materials subset of subcontractor reporting. |
| SRAPC | `transport_dev.transport_srapc.uvw_monthly_subcontractor_data_social` | Monthly subcontractor social data | Social-value subset of subcontractor reporting. |
| SRAPC | `transport_dev.transport_srapc.uvw_monthly_subcontractor_data_stationary_fuel` | Monthly subcontractor stationary fuel data | Stationary-fuel subset of subcontractor reporting. |
| SRAPC | `transport_dev.transport_srapc.uvw_monthly_subcontractor_data_waste` | Monthly subcontractor waste data | Waste subset of subcontractor reporting. |
| SRAPC | `transport_dev.transport_srapc.uvw_srapc_tfnsw_monthly_report_defect_intervention` | TfNSW defect/intervention monthly report | Contractual defect and intervention reporting. |
| SRAPC | `transport_dev.transport_srapc.uvw_tacp_data_delta_load` | TACP delta-load data | Incremental TACP reporting or transformation data. |
| SRAPC | `transport_dev.transport_srapc.uvw_tacp_data_initial_load` | TACP initial-load data | Initial TACP reporting or transformation data. |
| SRAPC | `transport_dev.transport_srapc.uvw_weatherobervations` | Weather observations | Weather context for operations or reporting. |
| WRU | `transport_dev.transport_wru.utbl_capitalwork_chainage` | Capital works chainage upload | Chainage reference for capital works. |
| WRU | `transport_dev.transport_wru.utbl_counter_locations` | Traffic counter location upload | Traffic count counter location reference. |
| WRU | `transport_dev.transport_wru.utbl_counts_by_carriageway` | Traffic counts by carriageway | Traffic-count analysis by carriageway. |
| WRU | `transport_dev.transport_wru.utbl_counts_by_lane` | Traffic counts by lane | Traffic-count analysis by lane. |
| WRU | `transport_dev.transport_wru.utbl_counts_hourly` | Hourly traffic counts | Hourly traffic-volume reporting. |
| WRU | `transport_dev.transport_wru.utbl_date_table` | Date reference upload | Calendar/date reference for WRU reports. |
| WRU | `transport_dev.transport_wru.utbl_eot_reasons` | EOT reason reference upload | Extension-of-time reason reference. |
| WRU | `transport_dev.transport_wru.utbl_inspection_road_sections` | Inspection road section upload | Inspection route or section reference. |
| WRU | `transport_dev.transport_wru.utbl_lane_access_lane_config` | Lane access configuration upload | Lane-access reporting and configuration. |
| WRU | `transport_dev.transport_wru.utbl_lane_access_road_chainage` | Lane access road chainage upload | Lane-access chainage reference. |
| WRU | `transport_dev.transport_wru.utbl_lane_access_traffic_volumes` | Lane access traffic volumes | Lane-access and traffic-volume reporting. |
| WRU | `transport_dev.transport_wru.utbl_metrocount_direction_converter` | MetroCount direction converter | Direction/reference conversion for traffic count data. |
| WRU | `transport_dev.transport_wru.utbl_monthly_bins` | Monthly bin/reference upload | Monthly reporting bin reference. |
| WRU | `transport_dev.transport_wru.utbl_non_compliant_inspections` | Non-compliant inspection upload | KPI/non-compliance reporting for inspections. |
| WRU | `transport_dev.transport_wru.utbl_psdr_comparison` | PSDR comparison upload | Comparison dataset; exact business meaning requires validation. |
| WRU | `transport_dev.transport_wru.utbl_public_holidays` | Public holiday reference upload | Calendar adjustment for KPI or operational reporting. |
| WRU | `transport_dev.transport_wru.utbl_raw_data_march` | Raw March upload | Raw uploaded data; exact source requires validation. |
| WRU | `transport_dev.transport_wru.utbl_work_peaktime_periods` | Work peak-time period reference | Peak-time period control for reporting. |
| WRU | `transport_dev.transport_wru.uvw_asset_register` | Curated asset register view | Asset register reporting view, potentially curated beyond raw Asset Vision. |
| WRU | `transport_dev.transport_wru.uvw_bis_new_ras_miscellaneous` | BIS/RAS miscellaneous lane-access view | Lane-access or miscellaneous bridge/asset reporting. |
| WRU | `transport_dev.transport_wru.uvw_inspection_kpi_1_dashboard` | Inspection KPI dashboard view | KPI 1 dashboard reporting. |
| WRU | `transport_dev.transport_wru.uvw_inspection_kpi_1_series` | Inspection KPI series view | KPI 1 trend or series reporting. |
| WRU | `transport_dev.transport_wru.uvw_job_kpi_2` | Job KPI 2 view | Job response or KPI reporting. |
| WRU | `transport_dev.transport_wru.uvw_kpi_1_noncompliant` | KPI 1 non-compliance view | Non-compliance reporting for KPI 1. |
| WRU | `transport_dev.transport_wru.uvw_laneaccess_raw` | Raw lane-access view | Lane-access reporting. |
| WRU | `transport_dev.transport_wru.uvw_laneaccess_report` | Lane-access report view | Lane-access reporting output. |
| TSRC | `transport_dev.transport_tsrc.bkp_uvw_incident_closures` | Incident closures backup | Backup copy for incident closure reporting. |
| TSRC | `transport_dev.transport_tsrc.utbl_aed_asset_bridge` | AED asset bridge upload | Asset bridge/reference data for AED-aligned reporting. |
| TSRC | `transport_dev.transport_tsrc.utbl_aed_assets` | AED asset upload | AED asset reference data. |
| TSRC | `transport_dev.transport_tsrc.utbl_aed_incidents_closures` | AED incident closure upload | Incident and closure reporting. |
| TSRC | `transport_dev.transport_tsrc.utbl_aed_incidents_events` | AED incident event upload | Incident event reporting. |
| TSRC | `transport_dev.transport_tsrc.utbl_aed_incidents_list` | AED incident list upload | Incident list reporting. |
| TSRC | `transport_dev.transport_tsrc.utbl_aed_incidents_sr` | AED incident service request upload | Incident/service request reporting. |
| TSRC | `transport_dev.transport_tsrc.utbl_aed_inspection_requirements` | AED inspection requirement upload | Inspection requirement reference. |
| TSRC | `transport_dev.transport_tsrc.utbl_aed_wo_assets` | AED work-order asset upload | Work-order to asset reference. |
| TSRC | `transport_dev.transport_tsrc.utbl_aed_wo_list` | AED work-order list upload | Work-order reporting. |
| TSRC | `transport_dev.transport_tsrc.utbl_asset_perf_maint_kpi25_1` | KPI 25 asset performance table | Asset performance maintenance KPI reporting. |
| TSRC | `transport_dev.transport_tsrc.utbl_asset_perf_maint_kpi25_2` | KPI 25 asset performance table | Asset performance maintenance KPI reporting. |
| TSRC | `transport_dev.transport_tsrc.utbl_asset_perf_maint_kpi25_3` | KPI 25 asset performance table | Asset performance maintenance KPI reporting. |
| TSRC | `transport_dev.transport_tsrc.utbl_asset_register` | Asset register upload | Uploaded asset register/reference data. |
| TSRC | `transport_dev.transport_tsrc.utbl_incident_triggered_section_geom` | Incident-triggered section geometry | Spatial/geometry support for incident-triggered section reporting. |
| TSRC | `transport_dev.transport_tsrc.utbl_kpi2_road_safety` | KPI 2 road-safety table | Road-safety KPI reporting. |
| TSRC | `transport_dev.transport_tsrc.utbl_pavement_reporting_sections_test` | Pavement reporting section test data | Pavement/capital works reporting reference. |
| TSRC | `transport_dev.transport_tsrc.utbl_pcas_test` | PCAS test data | PCAS/pavement or capital works reporting. |
| TSRC | `transport_dev.transport_tsrc.utbl_ref_activitytype_to_category_mapping` | Activity type mapping reference | Activity-category mapping. |
| TSRC | `transport_dev.transport_tsrc.utbl_ref_comp_code_to_inc_category` | Component-code to incident-category reference | Incident classification mapping. |
| TSRC | `transport_dev.transport_tsrc.utbl_ref_corrective_maintenance_compliance` | Corrective maintenance compliance reference | Compliance/KPI logic reference. |
| TSRC | `transport_dev.transport_tsrc.utbl_ref_date_table` | Date reference upload | Calendar/date reference. |
| TSRC | `transport_dev.transport_tsrc.utbl_ref_incident_group` | Incident group reference | Incident grouping. |
| TSRC | `transport_dev.transport_tsrc.utbl_ref_inspection_due_dates_monthly` | Monthly inspection due date reference | Monthly inspection due-date control. |
| TSRC | `transport_dev.transport_tsrc.utbl_ref_inspection_due_dates_weekly` | Weekly inspection due date reference | Weekly inspection due-date control. |
| TSRC | `transport_dev.transport_tsrc.utbl_ref_inspection_due_dates_yearly` | Yearly inspection due date reference | Yearly inspection due-date control. |
| TSRC | `transport_dev.transport_tsrc.utbl_ref_kpi_25_coms_asset_ref` | KPI 25 communications asset reference | KPI 25 asset reference. |
| TSRC | `transport_dev.transport_tsrc.utbl_ref_lane_closure_abate_pct` | Lane closure abatement percentage reference | Lane-closure abatement calculation. |
| TSRC | `transport_dev.transport_tsrc.utbl_ref_lane_closure_financial_factor` | Lane closure financial factor reference | Lane-closure financial calculation. |
| TSRC | `transport_dev.transport_tsrc.utbl_ref_lane_closure_lane_factor` | Lane closure lane factor reference | Lane-closure scoring or calculation by lane. |
| TSRC | `transport_dev.transport_tsrc.utbl_ref_lane_closure_section_factor` | Lane closure section factor reference | Lane-closure scoring or calculation by section. |
| TSRC | `transport_dev.transport_tsrc.utbl_ref_lane_closure_special_day` | Lane closure special-day reference | Lane-closure special-day adjustment. |
| TSRC | `transport_dev.transport_tsrc.utbl_ref_lane_closure_type` | Lane closure type reference | Lane-closure type classification. |
| TSRC | `transport_dev.transport_tsrc.utbl_ref_road_chng_10_m` | Road chainage 10m reference | Road/chainage mapping reference. |
| TSRC | `transport_dev.transport_tsrc.utbl_ref_routine_inspection_compliance` | Routine inspection compliance reference | Routine inspection KPI/compliance logic. |
| TSRC | `transport_dev.transport_tsrc.utbl_ref_routine_maintenance_compliance` | Routine maintenance compliance reference | Routine maintenance KPI/compliance logic. |
| TSRC | `transport_dev.transport_tsrc.utbl_ref_section_to_km_mapping` | Section to kilometre mapping | Section/km mapping reference. |
| TSRC | `transport_dev.transport_tsrc.utbl_ref_section_to_m_mapping_2_km_sections` | Section to metre mapping | Section/metre mapping for 2km sections. |
| TSRC | `transport_dev.transport_tsrc.utbl_ref_sections_kpi` | Section KPI reference | KPI section reference. |
| TSRC | `transport_dev.transport_tsrc.utbl_road_safety_audit_register` | Road safety audit register | Road safety audit reporting. |
| TSRC | `transport_dev.transport_tsrc.utbl_test_condition_data` | Test condition data upload | Condition reporting or test input. |
| TSRC | `transport_dev.transport_tsrc.utbl_work_order` | Work order upload | Work-order reporting. |
| TSRC | `transport_dev.transport_tsrc.uvw_asset_perf_maint_kpi25_1` | KPI 25 asset performance view | Asset performance maintenance KPI reporting. |
| TSRC | `transport_dev.transport_tsrc.uvw_incident_closures` | Incident closure view | Incident/closure reporting. |
| TSRC | `transport_dev.transport_tsrc.uvw_incident_report` | Incident report view | Incident reporting output. |
| TSRC | `transport_dev.transport_tsrc.uvw_incident_trigger_report_map_geom` | Incident trigger map geometry view | Spatial incident-trigger reporting. |
| TSRC | `transport_dev.transport_tsrc.uvw_incident_triggered_report` | Incident triggered report view | Incident-triggered reporting. |
| TSRC | `transport_dev.transport_tsrc.uvw_kpi18_abatement_costs` | KPI 18 abatement cost view | KPI abatement-cost reporting. |
| TSRC | `transport_dev.transport_tsrc.uvw_kpi18_noise_events` | KPI 18 noise event view | Noise-event KPI reporting. |
| TSRC | `transport_dev.transport_tsrc.uvw_kpi19_abatement_costs` | KPI 19 abatement cost view | KPI abatement-cost reporting. |
| TSRC | `transport_dev.transport_tsrc.uvw_kpi19_stakeholder_events` | KPI 19 stakeholder event view | Stakeholder-event KPI reporting. |
| TSRC | `transport_dev.transport_tsrc.uvw_kpi25_1_abatement_costs` | KPI 25.1 abatement cost view | KPI abatement-cost reporting. |
| TSRC | `transport_dev.transport_tsrc.uvw_kpi25_2_abatement_costs` | KPI 25.2 abatement cost view | KPI abatement-cost reporting. |
| TSRC | `transport_dev.transport_tsrc.uvw_kpi25_3_abatement_costs` | KPI 25.3 abatement cost view | KPI abatement-cost reporting. |
| TSRC | `transport_dev.transport_tsrc.uvw_kpi2_abatement_costs` | KPI 2 abatement cost view | KPI abatement-cost reporting. |
| TSRC | `transport_dev.transport_tsrc.uvw_kpi3_abatement_costs` | KPI 3 abatement cost view | KPI abatement-cost reporting. |
| TSRC | `transport_dev.transport_tsrc.uvw_kpi3_road_safety` | KPI 3 road-safety view | Road-safety KPI reporting. |
| TSRC | `transport_dev.transport_tsrc.uvw_kpi456_incidents` | KPI 4/5/6 incident view | Incident KPI reporting. |
| TSRC | `transport_dev.transport_tsrc.uvw_kpi_10_abatement_costs` | KPI 10 abatement cost view | KPI abatement-cost reporting. |
| TSRC | `transport_dev.transport_tsrc.uvw_kpi_10_cctv_requests` | KPI 10 CCTV request view | CCTV request KPI reporting. |
| TSRC | `transport_dev.transport_tsrc.uvw_kpi_20_21_pcas_test` | KPI 20/21 PCAS view | PCAS/pavement KPI reporting. |
| TSRC | `transport_dev.transport_tsrc.uvw_kpi_22_23_pcas_test` | KPI 22/23 PCAS view | PCAS/pavement KPI reporting. |
| TSRC | `transport_dev.transport_tsrc.uvw_kpi_7_to_14_its_asset_uptime` | KPI 7-14 ITS asset uptime view | ITS asset uptime KPI reporting. |
| TSRC | `transport_dev.transport_tsrc.uvw_kpi_7_to_14_its_jobs` | KPI 7-14 ITS jobs view | ITS job KPI reporting. |
| TSRC | `transport_dev.transport_tsrc.uvw_pcas_all_attributes` | PCAS all attributes view | Pavement/capital works reporting. |
| TSRC | `transport_dev.transport_tsrc.uvw_pcas_capdone_pivotted` | PCAS capital works done pivot | Pavement/capital works reporting. |
| TSRC | `transport_dev.transport_tsrc.uvw_pcas_caplentrted_pivotted` | PCAS capital length treated pivot | Pavement/capital works reporting. |
| TSRC | `transport_dev.transport_tsrc.uvw_pcas_condrating_pivotted` | PCAS condition rating pivot | Pavement/condition reporting. |
| TSRC | `transport_dev.transport_tsrc.uvw_pcas_lppc_defects_pivotted` | PCAS LPPC defects pivot | Pavement defect reporting. |
| TSRC | `transport_dev.transport_tsrc.uvw_pcas_numeric_data` | PCAS numeric data view | Pavement/capital works reporting. |
| TSRC | `transport_dev.transport_tsrc.uvw_pcas_numeric_data_pivotted` | PCAS numeric data pivot | Pavement/capital works reporting. |
| TSRC | `transport_dev.transport_tsrc.uvw_pcas_seg_geom_wkt` | PCAS segment geometry WKT | Pavement/capital works spatial reporting. |
| TSRC | `transport_dev.transport_tsrc.uvw_pcas_stripmap_all` | PCAS stripmap view | Pavement/capital works stripmap reporting. |
| TSRC | `transport_dev.transport_tsrc.uvw_pcas_stripmap_ele_capworks_singlelane` | PCAS stripmap capital works lane view | Lane-specific capital works reporting. |
| TSRC | `transport_dev.transport_tsrc.uvw_pcas_stripmap_ele_feature_singlelane` | PCAS stripmap feature lane view | Lane-specific pavement/feature reporting. |
| TSRC | `transport_dev.transport_tsrc.uvw_road_safety_audit_register` | Road safety audit register view | Road safety audit reporting. |
| TSRC | `transport_dev.transport_tsrc.uvw_traffic_closures` | Traffic closure view | Traffic closure reporting. |
| TSRC | `transport_dev.transport_tsrc.uvw_traffic_volume` | Traffic volume view | Traffic volume reporting. |
| SHT / WHT | `transport_dev.transport_sht.utbl_nps03_sb` | Tunnel segment/reference upload | Segment/reference support for SHT tunnel reporting; exact source requires validation. |
| SHT / WHT | `transport_dev.transport_sht.utbl_nps04_nb` | Tunnel segment/reference upload | Segment/reference support for SHT tunnel reporting; exact source requires validation. |
| SHT / WHT | `transport_dev.transport_sht.utbl_sps01_nb` | Tunnel segment/reference upload | Segment/reference support for SHT tunnel reporting; exact source requires validation. |
| SHT / WHT | `transport_dev.transport_sht.utbl_sps02_sb` | Tunnel segment/reference upload | Segment/reference support for SHT tunnel reporting; exact source requires validation. |
| SHT / WHT | `transport_dev.transport_sht.utbl_ss_latitude` | Latitude/reference upload | Spatial/reference support for SHT tunnel reporting. |
| SHT / WHT | `transport_dev.transport_sht.utbl_tmp_nps03_sb` | Temporary tunnel segment upload | Staging/backup segment data. |
| SHT / WHT | `transport_dev.transport_sht.utbl_tmp_nps04_nb` | Temporary tunnel segment upload | Staging/backup segment data. |
| SHT / WHT | `transport_dev.transport_sht.utbl_tmp_sps01_nb` | Temporary tunnel segment upload | Staging/backup segment data. |
| SHT / WHT | `transport_dev.transport_sht.utbl_tmp_sps02_sb` | Temporary tunnel segment upload | Staging/backup segment data. |
| SHT / WHT | `transport_dev.transport_sht.utbl_tmp_tvs03_sb` | Temporary tunnel segment upload | Staging/backup segment data. |
| SHT / WHT | `transport_dev.transport_sht.utbl_tmp_tvs07_nb` | Temporary tunnel segment upload | Staging/backup segment data. |
| SHT / WHT | `transport_dev.transport_sht.utbl_tvs03_sb` | Tunnel segment/reference upload | Segment/reference support for SHT tunnel reporting; exact source requires validation. |
| SHT / WHT | `transport_dev.transport_sht.utbl_tvs07_nb` | Tunnel segment/reference upload | Segment/reference support for SHT tunnel reporting; exact source requires validation. |
| SHT / WHT | `transport_dev.transport_sht.uvw_ai1` | Tunnel/AI-labelled curated view | Tunnel reporting or analysis view; exact upstream requires validation. |
| SHT / WHT | `transport_dev.transport_sht.uvw_ai2` | Tunnel/AI-labelled curated view | Tunnel reporting or analysis view; exact upstream requires validation. |
| SHT / WHT | `transport_dev.transport_sht.uvw_all_assets` | Maximo-aligned or curated tunnel asset view | Tunnel asset reporting; stakeholder notes identify SHT operational work management as Maximo. |
| SHT / WHT | `transport_dev.transport_sht.uvw_all_critical_assets` | Maximo-aligned or curated critical asset view | Tunnel critical asset reporting. |
| SHT / WHT | `transport_dev.transport_sht.uvw_inspection` | Maximo-aligned or curated inspection view | Tunnel inspection reporting. |
| SHT / WHT | `transport_dev.transport_sht.uvw_job` | Maximo-aligned or curated job view | Tunnel job/work-order reporting. |
| SHT / WHT | `transport_dev.transport_sht.uvw_nps03_sb_segmented` | Tunnel segment view | Segment-level tunnel reporting. |
| SHT / WHT | `transport_dev.transport_sht.uvw_nps04_nb_segmented` | Tunnel segment view | Segment-level tunnel reporting. |
| SHT / WHT | `transport_dev.transport_sht.uvw_sps01_nb_segmented` | Tunnel segment view | Segment-level tunnel reporting. |
| SHT / WHT | `transport_dev.transport_sht.uvw_sps02_sb_segmented` | Tunnel segment view | Segment-level tunnel reporting. |
| SHT / WHT | `transport_dev.transport_sht.uvw_tvs03_sb_segmented` | Tunnel segment view | Segment-level tunnel reporting. |
| SHT / WHT | `transport_dev.transport_sht.uvw_tvs07_nb_segmented` | Tunnel segment view | Segment-level tunnel reporting. |
| SHT / WHT | `transport_dev.transport_sht.uvw_user_groups` | User/security view | User group reporting or security mapping. |
| SHT / WHT | `transport_dev.transport_sht.uvw_weather_north_sydney_hourly_rolling_30days` | North Sydney hourly weather | Weather context for SHT reporting. |
| NEL | `transport_dev.transport_nel.utbl_kpi_assets` | Synthetic or manual KPI asset upload | NEL KPI design and mobilisation testing before live Maximo data. |
| NEL | `transport_dev.transport_nel.utbl_kpi_work_orders` | Synthetic or manual KPI work-order upload | NEL KPI design and mobilisation testing before live Maximo data. |
| NEL | `transport_dev.transport_nel.utbl_ref_date_table` | Date reference upload | Date reference for KPI testing/reporting. |
| NEL | `transport_dev.transport_nel.uvw_kpi_sys_av_devices` | KPI system/AV device view | KPI device reporting; exact upstream requires validation. |
| FNDC | `transport_dev.transport_fndc.byo_tbl_kerikeri_weather_hr_fc` | Kerikeri hourly weather forecast | Weather forecast context. |
| FNDC | `transport_dev.transport_fndc.byo_tbl_national_road_cl_nz` | NZ national road centreline | Road-network reference. |
| FNDC | `transport_dev.transport_fndc.uvw_fw_forward_work_view` | Forward works view | Forward works planning/reporting. |
| FNDC | `transport_dev.transport_fndc.uvw_mc_cost` | Maintenance/commercial cost view | Commercial or cost reporting. |
| FNDC | `transport_dev.transport_fndc.uvw_mt_dispatch` | Dispatch view | Dispatch reporting. |
| FNDC | `transport_dev.transport_fndc.uvw_mt_dispatch_claim` | Dispatch claim view | Dispatch claim or commercial reporting. |
| FNDC | `transport_dev.transport_fndc.uvw_pave_layer` | Pavement layer view | Pavement/asset condition or treatment planning. |
| FNDC | `transport_dev.transport_fndc.uvw_treatment_length` | Treatment length view | Treatment planning/reporting. |
| FNDC | `transport_dev.transport_fndc.weather_hourly_forecast` | Hourly weather forecast | Weather forecast context. |
| Cross-contract Transport | `transport_dev.transport.utbl_job_costing_timesheets_all_contracts` | Cross-contract job costing and timesheet table | Job costing across contracts. |
| Cross-contract Transport | `transport_dev.transport.utbl_jobs_allcontract` | Cross-contract jobs table | Cross-contract job reporting. |
| Cross-contract Transport | `transport_dev.transport.utbl_jobs_formfield_allcontract` | Cross-contract job form fields | Cross-contract job form-field analysis. |
| Cross-contract Transport | `transport_dev.transport.utbl_ref_job_costing_fault_map` | Job costing fault map reference | Fault mapping for job-costing analysis. |
| Cross-contract Transport | `transport_dev.transport.utbl_ref_job_costing_std_road_class` | Job costing standard road class reference | Standard road-class mapping for job-costing analysis. |
| Cross-contract Transport | `transport_dev.transport.utbl_resource_allcontract` | Cross-contract resources table | Resource analysis across contracts. |
| Cross-contract Transport | `transport_dev.transport.utbl_sap_items_20_24_fy` | SAP item upload for FY20-FY24 | SAP/finance analysis. |
| Cross-contract Transport | `transport_dev.transport.utbl_timesheetitem_jobs_allcontract` | Cross-contract job timesheet items | Timesheet/job-costing analysis across contracts. |
| Cross-contract Transport | `transport_dev.transport.uvw_catsdata` | CATS/time data view | Time/labour reporting; exact upstream requires validation. |
| Cross-contract Transport | `transport_dev.transport.uvw_cc_budget_forecast_data_cosp` | SAP cost-centre budget/forecast data | Finance budget/forecast reporting. |
| Cross-contract Transport | `transport_dev.transport.uvw_cc_master_data_csks` | SAP cost-centre master data | Finance master data reference. |
| Cross-contract Transport | `transport_dev.transport.uvw_cc_masterdata` | Cost-centre master data | Finance master data reference. |
| Cross-contract Transport | `transport_dev.transport.uvw_completed_po_with_ageing_transport` | Completed purchase orders with ageing | Procurement/finance reporting. |
| Cross-contract Transport | `transport_dev.transport.uvw_controlling_doc_transport` | SAP controlling document data | Finance line-item or controlling-document reporting. |
| Cross-contract Transport | `transport_dev.transport.uvw_employee_listing` | Employee listing | Employee/labour reference for reporting. |
| Cross-contract Transport | `transport_dev.transport.uvw_equipment_deppostings_anlp` | Equipment depreciation postings | Equipment finance reporting. |
| Cross-contract Transport | `transport_dev.transport.uvw_equipment_master_data_ie36` | Equipment master data | Equipment reference for finance/operations reporting. |
| Cross-contract Transport | `transport_dev.transport.uvw_equipment_nbv_dep_zftm_asseteqip` | Equipment net book value/depreciation | Equipment asset finance reporting. |
| Cross-contract Transport | `transport_dev.transport.uvw_pc_masterdata` | Profit-centre master data | Finance master data reference. |
| Cross-contract Transport | `transport_dev.transport.uvw_po_account_assignment_ekkn` | PO account assignment | Procurement/finance reporting. |
| Cross-contract Transport | `transport_dev.transport.uvw_po_delivery_dates_eket` | PO delivery dates | Procurement delivery reporting. |
| Cross-contract Transport | `transport_dev.transport.uvw_po_header_data_ekko` | PO header data | Procurement reporting. |
| Cross-contract Transport | `transport_dev.transport.uvw_po_history_ekbe` | PO history | Procurement/finance history reporting. |
| Cross-contract Transport | `transport_dev.transport.uvw_po_item_data_ekpo` | PO item data | Procurement reporting. |
| Cross-contract Transport | `transport_dev.transport.uvw_po_open_commitment_with_ageing_transport` | Open PO commitments with ageing | Open commitment reporting. |
| Cross-contract Transport | `transport_dev.transport.uvw_po_service_entry_header_data_essr` | PO service entry header data | Service-entry/procurement reporting. |
| Cross-contract Transport | `transport_dev.transport.uvw_po_service_entry_lines_rawdata_esll` | PO service entry line data | Service-entry/procurement reporting. |
| Cross-contract Transport | `transport_dev.transport.uvw_po_service_package_account_assignment_eskn` | PO service package account assignment | Service-entry/procurement reporting. |
| Cross-contract Transport | `transport_dev.transport.uvw_po_service_package_header_data_eslh` | PO service package header data | Service-entry/procurement reporting. |
| Cross-contract Transport | `transport_dev.transport.uvw_ptmw_data` | PTMW data | Exact upstream and business usage require validation. |
| Cross-contract Transport | `transport_dev.transport.uvw_ptmw_data_history` | PTMW history data | Exact upstream and business usage require validation. |
| Cross-contract Transport | `transport_dev.transport.uvw_purchase_requisitions_transport` | Purchase requisitions | Procurement reporting. |
| Cross-contract Transport | `transport_dev.transport.uvw_purgrp_masterdata_detail` | Purchasing group master detail | Procurement master data. |
| Cross-contract Transport | `transport_dev.transport.uvw_purgrp_masterdata_uniquelist` | Purchasing group master list | Procurement master data. |
| Cross-contract Transport | `transport_dev.transport.uvw_vendor_cleared_items_bsak` | Vendor cleared items | Vendor finance reporting. |
| Cross-contract Transport | `transport_dev.transport.uvw_vendor_master_data` | Vendor master data | Vendor reference for procurement/finance reporting. |
| Cross-contract Transport | `transport_dev.transport.uvw_vendor_open_items_bsik` | Vendor open items | Vendor finance reporting. |
| Cross-contract Transport | `transport_dev.transport.uvw_wbs_budget_forecast_data_cosp` | WBS budget/forecast data | WBS finance budget/forecast reporting. |
| Cross-contract Transport | `transport_dev.transport.uvw_wbs_master_data_prps` | WBS master data | WBS finance master data reference. |
| Cross-contract Transport | `transport_dev.transport.uvw_wo_nwa_master_data_aufk_afko_afvc` | Work-order/network-activity master data | SAP work-order/network-activity reference. |
| Enterprise reporting | `transport_dev.stg_enterprise_reporting.uvw_completed_po` | Completed purchase orders | Enterprise procurement/finance reporting. |
| Enterprise reporting | `transport_dev.stg_enterprise_reporting.uvw_completed_pos_with_ageing` | Completed purchase orders with ageing | Enterprise procurement/finance reporting. |
| Enterprise reporting | `transport_dev.stg_enterprise_reporting.uvw_dts_allowances_data_r2` | DTS allowances data | DTS/time/allowance reporting; exact upstream requires validation. |
| Enterprise reporting | `transport_dev.stg_enterprise_reporting.uvw_dts_allowances_prod_data` | DTS allowances production data | DTS/time/allowance reporting. |
| Enterprise reporting | `transport_dev.stg_enterprise_reporting.uvw_dts_comments_data_r2` | DTS comments data | DTS/time reporting comments. |
| Enterprise reporting | `transport_dev.stg_enterprise_reporting.uvw_dts_comments_prod_data` | DTS production comments data | DTS/time reporting comments. |
| Enterprise reporting | `transport_dev.stg_enterprise_reporting.uvw_dts_testing_data` | DTS testing data | DTS/time reporting test data. |
| Enterprise reporting | `transport_dev.stg_enterprise_reporting.uvw_dts_time_data_new_r2` | DTS time data | DTS/time reporting. |
| Enterprise reporting | `transport_dev.stg_enterprise_reporting.uvw_dts_time_data_new_with_comments_allowances_r2` | DTS time data with comments and allowances | DTS/time reporting with comments and allowances. |
| Enterprise reporting | `transport_dev.stg_enterprise_reporting.uvw_dts_time_prod_data` | DTS production time data | DTS/time reporting. |
| Enterprise reporting | `transport_dev.stg_enterprise_reporting.uvw_dts_time_prod_data_new_with_comments_allowances` | DTS production time data with comments and allowances | DTS/time reporting with comments and allowances. |
| Enterprise reporting | `transport_dev.stg_enterprise_reporting.uvw_gr_ir_against_ses_ekbe` | GR/IR against service entry data | Procurement/finance reconciliation. |
| Enterprise reporting | `transport_dev.stg_enterprise_reporting.uvw_po_account_assignment_ekkn` | PO account assignment | Enterprise procurement/finance reporting. |
| Enterprise reporting | `transport_dev.stg_enterprise_reporting.uvw_po_commitment_status` | PO commitment status | Open commitment workflow/status reporting. |
| Enterprise reporting | `transport_dev.stg_enterprise_reporting.uvw_po_delivery_dates_eket` | PO delivery dates | Enterprise procurement delivery reporting. |
| Enterprise reporting | `transport_dev.stg_enterprise_reporting.uvw_po_header_item_data_ekko_ekpo_main` | PO header/item main data | Enterprise procurement reporting. |
| Enterprise reporting | `transport_dev.stg_enterprise_reporting.uvw_po_header_item_data_ekko_ekpo_rest` | PO header/item residual data | Enterprise procurement reporting. |
| Enterprise reporting | `transport_dev.stg_enterprise_reporting.uvw_po_history_ekbe` | PO history | Enterprise procurement/finance reporting. |
| Enterprise reporting | `transport_dev.stg_enterprise_reporting.uvw_po_history_ekbe_open_commitment` | PO history open commitments | Enterprise open commitment reporting. |
| Enterprise reporting | `transport_dev.stg_enterprise_reporting.uvw_po_open_commitment` | Open PO commitments | Enterprise open commitment reporting. |
| Enterprise reporting | `transport_dev.stg_enterprise_reporting.uvw_po_open_commitment_with_ageing` | Open PO commitments with ageing | Enterprise open commitment ageing. |
| Enterprise reporting | `transport_dev.stg_enterprise_reporting.uvw_po_service_entry_lines_rawdata_esll` | PO service entry lines | Enterprise service-entry/procurement reporting. |
| Enterprise reporting | `transport_dev.stg_enterprise_reporting.uvw_po_service_package_account_assignment_eskn` | PO service package account assignment | Enterprise service-entry/procurement reporting. |
| Enterprise reporting | `transport_dev.stg_enterprise_reporting.uvw_purgrp` | Purchasing group data | Enterprise procurement master data. |
| Enterprise reporting | `transport_dev.stg_enterprise_reporting.uvw_sap_employee_master_data` | SAP employee master data | Employee/labour reference for enterprise reporting. |
| Enterprise reporting | `transport_dev.stg_enterprise_reporting.uvw_sap_open_commitment_line_items_with_pur_grp` | SAP open commitment line items with purchasing group | Enterprise procurement open commitment reporting. |

## Contracts With No Specific Non-Asset-Vision Table Confirmed

| Contract / context | Current evidence |
|---|---|
| BAC / Brisbane Airport | Stakeholder notes describe inspection-led planning, QGIS/ArcGIS use, and contract-specific reporting, but the current table catalog does not show a dedicated BAC non-Asset-Vision table. BAC is mapped to the shared `ext_mssql_asset_vision_ven_gen7` Asset Vision source context. |
| Port of Brisbane | Stakeholder notes describe inspection-led planning and contract-specific reporting, but the current table catalog does not show a dedicated PoB non-Asset-Vision table. PoB is mapped to the shared `ext_mssql_asset_vision_ven_gen7` Asset Vision source context. |
| Auckland West / AKLW | The current `transport_aklw` catalog is mostly Asset Vision-style operational views such as asset, job, inspection, capital works, workflow status, and timesheet views. No separate non-Asset-Vision source is confirmed from the table catalog. |
| VentureSmart / VSM | The current `transport_vsm` catalog only documents `uvw_all_asset_with_photo`, which is not enough to classify a separate non-Asset-Vision source. |

## Related Pages

- [[Transport Data Tables]]
- [[Databricks Source Systems]]
- [[Transport Data Landscape]]
- [[Transport Contract Portfolio]]
- [[Integrated Transport Data Asset]]
- [[Asset Vision]]
- [[Maximo]]
- [[Transport Financial Reporting]]
- [[Transport Contract Tables - transport_ramc]]
- [[Transport Contract Tables - formitize_srapc]]
- [[Transport Contract Tables - transport_srapc]]
- [[Transport Contract Tables - transport_wru]]
- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Contract Tables - transport_sht]]
- [[Transport Contract Tables - transport_nel]]
- [[Transport Contract Tables - transport_fndc]]
- [[Transport Contract Tables - transport]]
- [[Transport Contract Tables - stg_enterprise_reporting]]
