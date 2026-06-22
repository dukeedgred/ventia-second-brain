---
type: analysis-summary
topic: Ventia
sector: Transport
date-created: 2026-06-19
date-updated: 2026-06-19
tags: [transport, kpi, contracts, data-tables, databricks]
---

# Transport Contractor KPI Inventory

This page inventories Transport KPI and KPI-adjacent reporting areas found in the current wiki and Databricks table documentation. It is not an authoritative contract KPI schedule. The contract documents remain the source of truth, and several rows below are inferred from table/view names rather than confirmed contractual KPI definitions.

## Evidence Boundary

KPI evidence comes from two source types:

- Stakeholder notes that explicitly describe KPI areas, especially [[Transport Data Asset Stakeholder Interview Anna Covell]], [[Transport Data Asset Stakeholder Interview Toby Lin]], [[Transport Data Asset Stakeholder Interview Huy Nguyen]], and [[Transport Asset Condition Inspections]].
- Databricks table documentation where objects are named with `kpi`, `compliance`, `abatement`, `incident`, `road_safety`, `tollroad`, `unavailability`, `lane`, `pcas`, `monthly_report`, or similar reporting terms.

Rows marked as "table-name evidence" should be validated against the contract KPI appendix before being treated as contractual KPIs.

## KPI Inventory

| Contract / context | KPI or reporting area | KPI number / label found | Evidence table or view | Usage / interpretation | Evidence confidence |
|---|---|---|---|---|---|
| RAMC / RAMCSC | Routine maintenance | Not enumerated | Not found as dedicated KPI table | Anna described RAMCSC as having a varied KPI appendix including routine maintenance. | Stakeholder-confirmed area; KPI details missing |
| RAMC / RAMCSC | Stakeholder relations | Not enumerated | Not found as dedicated KPI table | Anna described stakeholder relations as a RAMCSC KPI appendix area. | Stakeholder-confirmed area; KPI details missing |
| RAMC / RAMCSC | Projects | Not enumerated | Not found as dedicated KPI table | Anna described projects as a RAMCSC KPI appendix area. | Stakeholder-confirmed area; KPI details missing |
| RAMC / RAMCSC | Lane openings | Not enumerated | Not found as dedicated KPI table | Anna described lane openings as a RAMCSC KPI appendix area. | Stakeholder-confirmed area; KPI details missing |
| RAMC / RAMCSC | Hazards | Not enumerated | Not found as dedicated KPI table | Anna described hazards as a RAMCSC KPI appendix area. | Stakeholder-confirmed area; KPI details missing |
| RAMC / RAMCSC | Safety | Not enumerated | Not found as dedicated KPI table | Anna described safety as a RAMCSC KPI appendix area. | Stakeholder-confirmed area; KPI details missing |
| RAMC / RAMCSC | Jobs and work orders | Not enumerated | `transport_dev.transport_ramc.utbl_current_month_job_snapshot`; `transport_dev.transport_ramc.utbl_last_month_job_snapshot`; `transport_dev.transport_ramc.utbl_backlog_change_report`; `transport_dev.transport_ramc.utbl_monthly_backlog_reduction`; backup `bkp_*` variants | RAMCSC backlog status, job snapshots, and backlog reduction reporting likely support jobs/work-orders KPI tracking. | Stakeholder-confirmed area; table linkage inferred |
| BAC / Brisbane Airport | Corrective maintenance completion | Not enumerated | Not found as dedicated KPI table | Anna said BAC is more focused on corrective maintenance completion within the relevant month. | Stakeholder-confirmed area; table missing |
| BAC / Brisbane Airport | Planned maintenance completion | Not enumerated | Not found as dedicated KPI table | Anna said BAC is more focused on planned maintenance completion within the relevant month. | Stakeholder-confirmed area; table missing |
| Port of Brisbane | Corrective maintenance completion | Not enumerated | Not found as dedicated KPI table | Anna said Port of Brisbane is more focused on corrective maintenance completion within the relevant month. | Stakeholder-confirmed area; table missing |
| Port of Brisbane | Planned maintenance completion | Not enumerated | Not found as dedicated KPI table | Anna said Port of Brisbane is more focused on planned maintenance completion within the relevant month. | Stakeholder-confirmed area; table missing |
| Open-road asset inspection context | Condition inspection completion | KPI 3.1 mentioned by Toby | Not found as a cross-contract KPI table | Monthly reporting shows scheduled and completed inspections, incidents, and inspection counts by asset type. | Stakeholder-confirmed KPI label; contract/table mapping missing |
| Open-road asset inspection context | Condition ratings | No numeric KPI label found | Asset Vision condition fields and inspection views vary by contract | Condition ratings run 1 to 5, but wording and standards differ by contract. | Stakeholder-confirmed metric area; not a single KPI table |
| Open-road asset inspection context | Defect/hazard response timing | No numeric KPI label found | Asset Vision job/inspection data; response fields still need validation | Response time is driven by asset category, issue category, urgency/intervention level, and contract rules. | Stakeholder-confirmed metric area; field mapping missing |
| WRU | Inspection KPI dashboard | KPI 1 | `transport_dev.transport_wru.uvw_inspection_kpi_1_dashboard` | Inspection KPI dashboard view for WRU. | Table-name evidence plus Rui WRU dashboard notes |
| WRU | Inspection KPI trend/series | KPI 1 | `transport_dev.transport_wru.uvw_inspection_kpi_1_series` | KPI 1 trend or series reporting. | Table-name evidence plus Rui WRU dashboard notes |
| WRU | Inspection non-compliance | KPI 1 non-compliant | `transport_dev.transport_wru.uvw_kpi_1_noncompliant`; `transport_dev.transport_wru.utbl_non_compliant_inspections` | Non-compliant inspection reporting. | Table-name evidence |
| WRU | Job KPI | KPI 2 | `transport_dev.transport_wru.uvw_job_kpi_2` | Job response or job KPI reporting. | Table-name evidence |
| WRU | Lane access reporting | Not enumerated | `transport_dev.transport_wru.uvw_laneaccess_report`; `transport_dev.transport_wru.uvw_laneaccess_raw`; `transport_dev.transport_wru.utbl_lane_access_lane_config`; `transport_dev.transport_wru.utbl_lane_access_road_chainage`; `transport_dev.transport_wru.utbl_lane_access_traffic_volumes` | Lane-access report and supporting reference/input tables. | KPI-adjacent table evidence |
| WRU | Inspection road sections | Not enumerated | `transport_dev.transport_wru.utbl_inspection_road_sections` | Inspection section reference for KPI/reporting or route logic. | KPI-adjacent table evidence |
| SRAPC | Monthly report | Not enumerated | `transport_dev.transport_srapc.utbl_monthly_report` | Monthly report input. | Reporting table evidence |
| SRAPC | TfNSW defect/intervention monthly report | Not enumerated | `transport_dev.transport_srapc.uvw_srapc_tfnsw_monthly_report_defect_intervention` | Defect/intervention reporting for TfNSW monthly report. | Reporting table evidence |
| SRAPC | Subcontractor monthly reporting | Not enumerated | `transport_dev.transport_srapc.uvw_monthly_subcontractor_data`; `uvw_monthly_subcontractor_data_energy`; `uvw_monthly_subcontractor_data_health_safety`; `uvw_monthly_subcontractor_data_material`; `uvw_monthly_subcontractor_data_social`; `uvw_monthly_subcontractor_data_stationary_fuel`; `uvw_monthly_subcontractor_data_waste` | Monthly subcontractor reporting across energy, health/safety, materials, social, fuel, and waste dimensions. | Reporting table evidence |
| SRAPC | TACP reporting/load data | Not enumerated | `transport_dev.transport_srapc.utbl_tacp_constants`; `utbl_tacp_toc`; `uvw_tacp_data_initial_load`; `uvw_tacp_data_delta_load` | TACP reference and load views. Exact KPI relationship requires validation. | KPI-adjacent table evidence |
| TSRC | Road safety | KPI 2 | `transport_dev.transport_tsrc.utbl_kpi2_road_safety`; `transport_dev.transport_tsrc.uvw_kpi2_abatement_costs` | KPI 2 road-safety and associated abatement-cost reporting. | Table-name evidence |
| TSRC | Road safety | KPI 3 | `transport_dev.transport_tsrc.uvw_kpi3_road_safety`; `transport_dev.transport_tsrc.uvw_kpi3_abatement_costs` | KPI 3 road-safety and associated abatement-cost reporting. | Table-name evidence |
| TSRC | Incident KPIs | KPI 4/5/6 | `transport_dev.transport_tsrc.uvw_kpi456_incidents` | Incident KPI reporting for KPI 4, 5, and 6. | Table-name evidence |
| TSRC | ITS asset uptime | KPI 7 to 14 | `transport_dev.transport_tsrc.uvw_kpi_7_to_14_its_asset_uptime` | ITS asset uptime KPI reporting. | Table-name evidence |
| TSRC | ITS jobs | KPI 7 to 14 | `transport_dev.transport_tsrc.uvw_kpi_7_to_14_its_jobs` | ITS job KPI reporting. | Table-name evidence |
| TSRC | Abatement costs | KPI 10 | `transport_dev.transport_tsrc.uvw_kpi_10_abatement_costs` | KPI 10 abatement-cost reporting. | Table-name evidence |
| TSRC | CCTV requests | KPI 10 | `transport_dev.transport_tsrc.uvw_kpi_10_cctv_requests` | KPI 10 CCTV request reporting. | Table-name evidence |
| TSRC | Noise events | KPI 18 | `transport_dev.transport_tsrc.uvw_kpi18_noise_events` | KPI 18 noise-event reporting. | Table-name evidence |
| TSRC | Abatement costs | KPI 18 | `transport_dev.transport_tsrc.uvw_kpi18_abatement_costs` | KPI 18 abatement-cost reporting. | Table-name evidence |
| TSRC | Stakeholder events | KPI 19 | `transport_dev.transport_tsrc.uvw_kpi19_stakeholder_events` | KPI 19 stakeholder-event reporting. | Table-name evidence |
| TSRC | Abatement costs | KPI 19 | `transport_dev.transport_tsrc.uvw_kpi19_abatement_costs` | KPI 19 abatement-cost reporting. | Table-name evidence |
| TSRC | PCAS test/reporting | KPI 20/21 | `transport_dev.transport_tsrc.uvw_kpi_20_21_pcas_test` | KPI 20/21 PCAS reporting. | Table-name evidence |
| TSRC | PCAS test/reporting | KPI 22/23 | `transport_dev.transport_tsrc.uvw_kpi_22_23_pcas_test` | KPI 22/23 PCAS reporting. | Table-name evidence |
| TSRC | Asset performance maintenance | KPI 25.1 | `transport_dev.transport_tsrc.utbl_asset_perf_maint_kpi25_1`; `transport_dev.transport_tsrc.uvw_kpi25_1_abatement_costs` | Asset performance maintenance KPI and abatement-cost reporting. | Table-name evidence |
| TSRC | Asset performance maintenance | KPI 25.2 | `transport_dev.transport_tsrc.utbl_asset_perf_maint_kpi25_2`; `transport_dev.transport_tsrc.uvw_kpi25_2_abatement_costs` | Asset performance maintenance KPI and abatement-cost reporting. | Table-name evidence |
| TSRC | Asset performance maintenance | KPI 25.3 | `transport_dev.transport_tsrc.utbl_asset_perf_maint_kpi25_3`; `transport_dev.transport_tsrc.uvw_kpi25_3_abatement_costs` | Asset performance maintenance KPI and abatement-cost reporting. | Table-name evidence |
| TSRC | COMS asset reference | KPI 25 | `transport_dev.transport_tsrc.utbl_ref_kpi_25_coms_asset_ref` | Reference table for KPI 25 COMS assets. Exact acronym should be validated. | Table-name evidence |
| TSRC | Routine inspection compliance | Not enumerated | `transport_dev.transport_tsrc.utbl_ref_routine_inspection_compliance` | Reference/compliance logic for routine inspection KPI reporting. | Table-name evidence |
| TSRC | Routine maintenance compliance | Not enumerated | `transport_dev.transport_tsrc.utbl_ref_routine_maintenance_compliance` | Reference/compliance logic for routine maintenance KPI reporting. | Table-name evidence |
| TSRC | Corrective maintenance compliance | Not enumerated | `transport_dev.transport_tsrc.utbl_ref_corrective_maintenance_compliance` | Reference/compliance logic for corrective maintenance KPI reporting. | Table-name evidence |
| TSRC | Lane closure abatement | Not enumerated | `transport_dev.transport_tsrc.utbl_ref_lane_closure_abate_pct`; `utbl_ref_lane_closure_financial_factor`; `utbl_ref_lane_closure_lane_factor`; `utbl_ref_lane_closure_section_factor`; `utbl_ref_lane_closure_special_day`; `utbl_ref_lane_closure_type` | Lane-closure abatement and adjustment reference data. | KPI-adjacent table evidence |
| TSRC | Tollroad unavailability events | Not enumerated | `transport_dev.transport_tsrc.uvw_tollroad_unavailability_events` | Tollroad unavailability event reporting. | KPI-adjacent table evidence |
| TSRC | Road safety audit | Not enumerated | `transport_dev.transport_tsrc.utbl_road_safety_audit_register`; `transport_dev.transport_tsrc.uvw_road_safety_audit_register` | Road safety audit register/reporting. | KPI-adjacent table evidence |
| TSRC | Incident reporting | Not enumerated | `transport_dev.transport_tsrc.utbl_aed_incidents_closures`; `utbl_aed_incidents_events`; `utbl_aed_incidents_list`; `utbl_aed_incidents_sr`; `uvw_incident_closures`; `uvw_incident_report`; `uvw_incident_trigger_report_map_geom`; `uvw_incident_triggered_report`; `utbl_incident_triggered_section_geom` | Incident, closure, triggered section, and map/geometry reporting. | KPI-adjacent table evidence |
| TSRC | PCAS/pavement attributes | Not enumerated | `transport_dev.transport_tsrc.utbl_pcas_test`; `utbl_pavement_reporting_sections_test`; `uvw_pcas_all_attributes`; `uvw_pcas_capdone_pivotted`; `uvw_pcas_caplentrted_pivotted`; `uvw_pcas_condrating_pivotted`; `uvw_pcas_lppc_defects_pivotted`; `uvw_pcas_numeric_data`; `uvw_pcas_numeric_data_pivotted`; `uvw_pcas_seg_geom_wkt`; `uvw_pcas_stripmap_all`; `uvw_pcas_stripmap_ele_capworks_singlelane`; `uvw_pcas_stripmap_ele_feature_singlelane` | Pavement/PCAS/capital-works reporting that appears to support KPI or performance reporting. | KPI-adjacent table evidence |
| SHT / WHT | Inspection/job/critical asset reporting | No KPI number found | `transport_dev.transport_sht.uvw_inspection`; `transport_dev.transport_sht.uvw_job`; `transport_dev.transport_sht.uvw_all_critical_assets`; `transport_dev.transport_sht.uvw_weather_north_sydney_hourly_rolling_30days` | SHT is identified as Maximo-based, but the current table catalog does not expose KPI-numbered SHT views. | Reporting area; KPI definitions missing |
| NEL | KPI assets | No KPI number found | `transport_dev.transport_nel.utbl_kpi_assets` | Synthetic or manually uploaded KPI asset data for NEL mobilisation before live Maximo data. | Stakeholder-confirmed synthetic/manual KPI data; table-name evidence |
| NEL | KPI work orders | No KPI number found | `transport_dev.transport_nel.utbl_kpi_work_orders` | Synthetic or manually uploaded KPI work-order data for NEL mobilisation before live Maximo data. | Stakeholder-confirmed synthetic/manual KPI data; table-name evidence |
| NEL | System/AV devices | No KPI number found | `transport_dev.transport_nel.uvw_kpi_sys_av_devices` | KPI system/AV device reporting. Exact upstream and definition require validation. | Table-name evidence |
| FNDC | No explicit KPI table found | Not found | No KPI-labelled table found | Current catalog has forward works, cost, dispatch, weather, road network, pavement, and treatment views, but no explicit KPI-labelled table. | KPI evidence missing |
| Auckland West / AKLW | No explicit KPI table found | Not found | No KPI-labelled table found | Current catalog is mostly Asset Vision-style operational views. | KPI evidence missing |
| VentureSmart / VSM | No explicit KPI table found | Not found | No KPI-labelled table found | Current catalog only documents `transport_dev.transport_vsm.uvw_all_asset_with_photo`. | KPI evidence missing |

## Validation Gaps

- Obtain the RAMCSC, BAC, and Port of Brisbane KPI appendices or monthly report templates from the contract/commercial owners.
- Confirm whether TSRC KPI-numbered views map directly to contractual KPIs or internal report labels.
- Validate PCAS, COMS, AED, and TACP acronym meanings with contract SMEs before standardising these labels.
- Confirm whether SHT Maximo KPI outputs are available in Databricks or only represented through curated reporting views.
- For NEL, distinguish synthetic/manual KPI test data from future Maximo-sourced operational KPI data.

## Related Pages

- [[Transport Data Tables]]
- [[Transport Data Beyond Asset Vision]]
- [[Transport Asset Condition Inspections]]
- [[Transport Data Asset Stakeholder Interview Anna Covell]]
- [[Transport Data Asset Stakeholder Interview Toby Lin]]
- [[Transport Data Asset Stakeholder Interview Huy Nguyen]]
- [[Transport Contract Tables - transport_ramc]]
- [[Transport Contract Tables - transport_wru]]
- [[Transport Contract Tables - transport_srapc]]
- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Contract Tables - transport_sht]]
- [[Transport Contract Tables - transport_nel]]
- [[Transport Contract Tables - transport_fndc]]
