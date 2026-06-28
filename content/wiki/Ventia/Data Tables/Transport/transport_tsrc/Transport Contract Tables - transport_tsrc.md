---
type: contract-table-catalog
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
date-created: 2026-06-05
date-updated: 2026-06-09
tags: [transport, data-tables, contract-schema, transport-tsrc]
---

# Transport Contract Tables - transport_tsrc

This page catalogs table documentation for the `transport_tsrc` Transport schema. In Transport, schema differences usually indicate different contracts, contract groupings, or curated reporting contexts.

## Table Index

| Table | Full name | Type | Columns | Domain | Purpose |
|---|---|---|---:|---|---|
| [[Transport Table - transport_tsrc - bkp_uvw_incident_closures]] | `transport_dev.transport_tsrc.bkp_uvw_incident_closures` | MANAGED | 6 | traffic counts / closures |  |
| [[Transport Table - transport_tsrc - utbl_aed_asset_bridge]] | `transport_dev.transport_tsrc.utbl_aed_asset_bridge` | MANAGED | 56 | asset register / hierarchy | Created by the file upload UI |
| [[Transport Table - transport_tsrc - utbl_aed_assets]] | `transport_dev.transport_tsrc.utbl_aed_assets` | MANAGED | 4 | asset register / hierarchy | Created by the file upload UI |
| [[Transport Table - transport_tsrc - utbl_aed_incidents_closures]] | `transport_dev.transport_tsrc.utbl_aed_incidents_closures` | MANAGED | 34 | traffic counts / closures | Created by the file upload UI |
| [[Transport Table - transport_tsrc - utbl_aed_incidents_events]] | `transport_dev.transport_tsrc.utbl_aed_incidents_events` | MANAGED | 6 | incidents | Created by the file upload UI |
| [[Transport Table - transport_tsrc - utbl_aed_incidents_list]] | `transport_dev.transport_tsrc.utbl_aed_incidents_list` | MANAGED | 11 | incidents | Created by the file upload UI |
| [[Transport Table - transport_tsrc - utbl_aed_incidents_sr]] | `transport_dev.transport_tsrc.utbl_aed_incidents_sr` | MANAGED | 14 | incidents | Created by the file upload UI |
| [[Transport Table - transport_tsrc - utbl_aed_inspection_requirements]] | `transport_dev.transport_tsrc.utbl_aed_inspection_requirements` | MANAGED | 8 | inspection / audit / condition | Created by the file upload UI |
| [[Transport Table - transport_tsrc - utbl_aed_wo_assets]] | `transport_dev.transport_tsrc.utbl_aed_wo_assets` | MANAGED | 6 | asset register / hierarchy | Created by the file upload UI |
| [[Transport Table - transport_tsrc - utbl_aed_wo_list]] | `transport_dev.transport_tsrc.utbl_aed_wo_list` | MANAGED | 25 |  | Created by the file upload UI |
| [[Transport Table - transport_tsrc - utbl_asset_perf_maint_kpi25_1]] | `transport_dev.transport_tsrc.utbl_asset_perf_maint_kpi25_1` | MANAGED | 32 | KPI / reporting |  |
| [[Transport Table - transport_tsrc - utbl_asset_perf_maint_kpi25_2]] | `transport_dev.transport_tsrc.utbl_asset_perf_maint_kpi25_2` | MANAGED | 33 | KPI / reporting |  |
| [[Transport Table - transport_tsrc - utbl_asset_perf_maint_kpi25_3]] | `transport_dev.transport_tsrc.utbl_asset_perf_maint_kpi25_3` | MANAGED | 30 | KPI / reporting |  |
| [[Transport Table - transport_tsrc - utbl_asset_register]] | `transport_dev.transport_tsrc.utbl_asset_register` | MANAGED | 66 | asset register / hierarchy | Created by the file upload UI |
| [[Transport Table - transport_tsrc - utbl_incident_triggered_section_geom]] | `transport_dev.transport_tsrc.utbl_incident_triggered_section_geom` | MANAGED | 39 | incidents |  |
| [[Transport Table - transport_tsrc - utbl_kpi2_road_safety]] | `transport_dev.transport_tsrc.utbl_kpi2_road_safety` | MANAGED | 127 | KPI / reporting |  |
| [[Transport Table - transport_tsrc - utbl_pavement_reporting_sections_test]] | `transport_dev.transport_tsrc.utbl_pavement_reporting_sections_test` | MANAGED | 12 | capital works / forward works | Created by the file upload UI |
| [[Transport Table - transport_tsrc - utbl_pcas_test]] | `transport_dev.transport_tsrc.utbl_pcas_test` | MANAGED | 17 | capital works / forward works | Created by the file upload UI |
| [[Transport Table - transport_tsrc - utbl_ref_activitytype_to_category_mapping]] | `transport_dev.transport_tsrc.utbl_ref_activitytype_to_category_mapping` | MANAGED | 5 | reference / mapping | Created by the file upload UI |
| [[Transport Table - transport_tsrc - utbl_ref_comp_code_to_inc_category]] | `transport_dev.transport_tsrc.utbl_ref_comp_code_to_inc_category` | MANAGED | 6 | reference / mapping | Created by the file upload UI |
| [[Transport Table - transport_tsrc - utbl_ref_corrective_maintenance_compliance]] | `transport_dev.transport_tsrc.utbl_ref_corrective_maintenance_compliance` | MANAGED | 12 | reference / mapping | Created by the file upload UI |
| [[Transport Table - transport_tsrc - utbl_ref_date_table]] | `transport_dev.transport_tsrc.utbl_ref_date_table` | MANAGED | 25 | reference / mapping | Created by the file upload UI |
| [[Transport Table - transport_tsrc - utbl_ref_incident_group]] | `transport_dev.transport_tsrc.utbl_ref_incident_group` | MANAGED | 2 | incidents | Created by the file upload UI |
| [[Transport Table - transport_tsrc - utbl_ref_inspection_due_dates_monthly]] | `transport_dev.transport_tsrc.utbl_ref_inspection_due_dates_monthly` | MANAGED | 7 | inspection / audit / condition | Created by the file upload UI |
| [[Transport Table - transport_tsrc - utbl_ref_inspection_due_dates_weekly]] | `transport_dev.transport_tsrc.utbl_ref_inspection_due_dates_weekly` | MANAGED | 5 | inspection / audit / condition | Created by the file upload UI |
| [[Transport Table - transport_tsrc - utbl_ref_inspection_due_dates_yearly]] | `transport_dev.transport_tsrc.utbl_ref_inspection_due_dates_yearly` | MANAGED | 8 | inspection / audit / condition | Created by the file upload UI |
| [[Transport Table - transport_tsrc - utbl_ref_kpi_25_coms_asset_ref]] | `transport_dev.transport_tsrc.utbl_ref_kpi_25_coms_asset_ref` | MANAGED | 3 | KPI / reporting | Created by the file upload UI |
| [[Transport Table - transport_tsrc - utbl_ref_lane_closure_abate_pct]] | `transport_dev.transport_tsrc.utbl_ref_lane_closure_abate_pct` | MANAGED | 5 | traffic counts / closures | Created by the file upload UI |
| [[Transport Table - transport_tsrc - utbl_ref_lane_closure_financial_factor]] | `transport_dev.transport_tsrc.utbl_ref_lane_closure_financial_factor` | MANAGED | 3 | traffic counts / closures | Created by the file upload UI |
| [[Transport Table - transport_tsrc - utbl_ref_lane_closure_lane_factor]] | `transport_dev.transport_tsrc.utbl_ref_lane_closure_lane_factor` | MANAGED | 5 | traffic counts / closures | Created by the file upload UI |
| [[Transport Table - transport_tsrc - utbl_ref_lane_closure_section_factor]] | `transport_dev.transport_tsrc.utbl_ref_lane_closure_section_factor` | MANAGED | 2 | traffic counts / closures | Created by the file upload UI |
| [[Transport Table - transport_tsrc - utbl_ref_lane_closure_special_day]] | `transport_dev.transport_tsrc.utbl_ref_lane_closure_special_day` | MANAGED | 3 | traffic counts / closures | Created by the file upload UI |
| [[Transport Table - transport_tsrc - utbl_ref_lane_closure_type]] | `transport_dev.transport_tsrc.utbl_ref_lane_closure_type` | MANAGED | 2 | traffic counts / closures | Created by the file upload UI |
| [[Transport Table - transport_tsrc - utbl_ref_road_chng_10_m]] | `transport_dev.transport_tsrc.utbl_ref_road_chng_10_m` | MANAGED | 7 | reference / mapping | Created by the file upload UI |
| [[Transport Table - transport_tsrc - utbl_ref_routine_inspection_compliance]] | `transport_dev.transport_tsrc.utbl_ref_routine_inspection_compliance` | MANAGED | 12 | inspection / audit / condition | Created by the file upload UI |
| [[Transport Table - transport_tsrc - utbl_ref_routine_maintenance_compliance]] | `transport_dev.transport_tsrc.utbl_ref_routine_maintenance_compliance` | MANAGED | 26 | reference / mapping | Created by the file upload UI |
| [[Transport Table - transport_tsrc - utbl_ref_section_to_km_mapping]] | `transport_dev.transport_tsrc.utbl_ref_section_to_km_mapping` | MANAGED | 10 | reference / mapping | Created by the file upload UI |
| [[Transport Table - transport_tsrc - utbl_ref_section_to_m_mapping_2_km_sections]] | `transport_dev.transport_tsrc.utbl_ref_section_to_m_mapping_2_km_sections` | MANAGED | 10 | reference / mapping | Created by the file upload UI |
| [[Transport Table - transport_tsrc - utbl_ref_sections_kpi]] | `transport_dev.transport_tsrc.utbl_ref_sections_kpi` | MANAGED | 5 | KPI / reporting | Created by the file upload UI |
| [[Transport Table - transport_tsrc - utbl_road_safety_audit_register]] | `transport_dev.transport_tsrc.utbl_road_safety_audit_register` | MANAGED | 35 | inspection / audit / condition |  |
| [[Transport Table - transport_tsrc - utbl_test_condition_data]] | `transport_dev.transport_tsrc.utbl_test_condition_data` | MANAGED | 11 | inspection / audit / condition | Created by the file upload UI |
| [[Transport Table - transport_tsrc - utbl_work_order]] | `transport_dev.transport_tsrc.utbl_work_order` | MANAGED | 26 | jobs / work orders | Created by the file upload UI |
| [[Transport Table - transport_tsrc - uvw_asset_perf_maint_kpi25_1]] | `transport_dev.transport_tsrc.uvw_asset_perf_maint_kpi25_1` | VIEW | 30 | KPI / reporting |  |
| [[Transport Table - transport_tsrc - uvw_assets]] | `transport_dev.transport_tsrc.uvw_assets` | VIEW | 37 | asset register / hierarchy |  |
| [[Transport Table - transport_tsrc - uvw_capital_work]] | `transport_dev.transport_tsrc.uvw_capital_work` | VIEW | 18 |  |  |
| [[Transport Table - transport_tsrc - uvw_customer_requests]] | `transport_dev.transport_tsrc.uvw_customer_requests` | VIEW | 88 |  |  |
| [[Transport Table - transport_tsrc - uvw_customer_requests_report]] | `transport_dev.transport_tsrc.uvw_customer_requests_report` | VIEW | 8 |  |  |
| [[Transport Table - transport_tsrc - uvw_incident_closures]] | `transport_dev.transport_tsrc.uvw_incident_closures` | VIEW | 6 | traffic counts / closures |  |
| [[Transport Table - transport_tsrc - uvw_incident_report]] | `transport_dev.transport_tsrc.uvw_incident_report` | VIEW | 25 | incidents |  |
| [[Transport Table - transport_tsrc - uvw_incident_trigger_report_map_geom]] | `transport_dev.transport_tsrc.uvw_incident_trigger_report_map_geom` | VIEW | 7 | incidents |  |
| [[Transport Table - transport_tsrc - uvw_incident_triggered_report]] | `transport_dev.transport_tsrc.uvw_incident_triggered_report` | VIEW | 17 | incidents |  |
| [[Transport Table - transport_tsrc - uvw_inspection]] | `transport_dev.transport_tsrc.uvw_inspection` | VIEW | 54 | inspection / audit / condition |  |
| [[Transport Table - transport_tsrc - uvw_job]] | `transport_dev.transport_tsrc.uvw_job` | VIEW | 64 | jobs / work orders |  |
| [[Transport Table - transport_tsrc - uvw_jobs_all_attributes]] | `transport_dev.transport_tsrc.uvw_jobs_all_attributes` | VIEW | 127 | jobs / work orders |  |
| [[Transport Table - transport_tsrc - uvw_kpi18_abatement_costs]] | `transport_dev.transport_tsrc.uvw_kpi18_abatement_costs` | VIEW | 52 | KPI / reporting |  |
| [[Transport Table - transport_tsrc - uvw_kpi18_noise_events]] | `transport_dev.transport_tsrc.uvw_kpi18_noise_events` | VIEW | 43 | KPI / reporting |  |
| [[Transport Table - transport_tsrc - uvw_kpi19_abatement_costs]] | `transport_dev.transport_tsrc.uvw_kpi19_abatement_costs` | VIEW | 53 | KPI / reporting |  |
| [[Transport Table - transport_tsrc - uvw_kpi19_stakeholder_events]] | `transport_dev.transport_tsrc.uvw_kpi19_stakeholder_events` | VIEW | 46 | KPI / reporting |  |
| [[Transport Table - transport_tsrc - uvw_kpi25_1_abatement_costs]] | `transport_dev.transport_tsrc.uvw_kpi25_1_abatement_costs` | VIEW | 34 | KPI / reporting |  |
| [[Transport Table - transport_tsrc - uvw_kpi25_2_abatement_costs]] | `transport_dev.transport_tsrc.uvw_kpi25_2_abatement_costs` | VIEW | 35 | KPI / reporting |  |
| [[Transport Table - transport_tsrc - uvw_kpi25_3_abatement_costs]] | `transport_dev.transport_tsrc.uvw_kpi25_3_abatement_costs` | VIEW | 49 | KPI / reporting |  |
| [[Transport Table - transport_tsrc - uvw_kpi2_abatement_costs]] | `transport_dev.transport_tsrc.uvw_kpi2_abatement_costs` | VIEW | 40 | KPI / reporting |  |
| [[Transport Table - transport_tsrc - uvw_kpi3_abatement_costs]] | `transport_dev.transport_tsrc.uvw_kpi3_abatement_costs` | VIEW | 64 | KPI / reporting |  |
| [[Transport Table - transport_tsrc - uvw_kpi3_road_safety]] | `transport_dev.transport_tsrc.uvw_kpi3_road_safety` | VIEW | 54 | KPI / reporting |  |
| [[Transport Table - transport_tsrc - uvw_kpi456_incidents]] | `transport_dev.transport_tsrc.uvw_kpi456_incidents` | VIEW | 23 | KPI / reporting |  |
| [[Transport Table - transport_tsrc - uvw_kpi_10_abatement_costs]] | `transport_dev.transport_tsrc.uvw_kpi_10_abatement_costs` | VIEW | 28 | KPI / reporting |  |
| [[Transport Table - transport_tsrc - uvw_kpi_10_cctv_requests]] | `transport_dev.transport_tsrc.uvw_kpi_10_cctv_requests` | VIEW | 16 | KPI / reporting |  |
| [[Transport Table - transport_tsrc - uvw_kpi_20_21_pcas_test]] | `transport_dev.transport_tsrc.uvw_kpi_20_21_pcas_test` | VIEW | 9 | KPI / reporting |  |
| [[Transport Table - transport_tsrc - uvw_kpi_22_23_pcas_test]] | `transport_dev.transport_tsrc.uvw_kpi_22_23_pcas_test` | VIEW | 15 | KPI / reporting |  |
| [[Transport Table - transport_tsrc - uvw_kpi_7_to_14_its_asset_uptime]] | `transport_dev.transport_tsrc.uvw_kpi_7_to_14_its_asset_uptime` | VIEW | 45 | KPI / reporting |  |
| [[Transport Table - transport_tsrc - uvw_kpi_7_to_14_its_jobs]] | `transport_dev.transport_tsrc.uvw_kpi_7_to_14_its_jobs` | VIEW | 33 | KPI / reporting |  |
| [[Transport Table - transport_tsrc - uvw_pcas_all_attributes]] | `transport_dev.transport_tsrc.uvw_pcas_all_attributes` | VIEW | 103 | capital works / forward works |  |
| [[Transport Table - transport_tsrc - uvw_pcas_capdone_pivotted]] | `transport_dev.transport_tsrc.uvw_pcas_capdone_pivotted` | VIEW | 19 | capital works / forward works |  |
| [[Transport Table - transport_tsrc - uvw_pcas_caplentrted_pivotted]] | `transport_dev.transport_tsrc.uvw_pcas_caplentrted_pivotted` | VIEW | 19 | capital works / forward works |  |
| [[Transport Table - transport_tsrc - uvw_pcas_condrating_pivotted]] | `transport_dev.transport_tsrc.uvw_pcas_condrating_pivotted` | VIEW | 14 | capital works / forward works |  |
| [[Transport Table - transport_tsrc - uvw_pcas_lppc_defects_pivotted]] | `transport_dev.transport_tsrc.uvw_pcas_lppc_defects_pivotted` | VIEW | 110 | defects / hazards / failures |  |
| [[Transport Table - transport_tsrc - uvw_pcas_numeric_data]] | `transport_dev.transport_tsrc.uvw_pcas_numeric_data` | VIEW | 43 | capital works / forward works |  |
| [[Transport Table - transport_tsrc - uvw_pcas_numeric_data_pivotted]] | `transport_dev.transport_tsrc.uvw_pcas_numeric_data_pivotted` | VIEW | 41 | capital works / forward works |  |
| [[Transport Table - transport_tsrc - uvw_pcas_seg_geom_wkt]] | `transport_dev.transport_tsrc.uvw_pcas_seg_geom_wkt` | VIEW | 8 | capital works / forward works |  |
| [[Transport Table - transport_tsrc - uvw_pcas_stripmap_all]] | `transport_dev.transport_tsrc.uvw_pcas_stripmap_all` | VIEW | 33 | capital works / forward works |  |
| [[Transport Table - transport_tsrc - uvw_pcas_stripmap_ele_capworks_singlelane]] | `transport_dev.transport_tsrc.uvw_pcas_stripmap_ele_capworks_singlelane` | VIEW | 27 | lane access |  |
| [[Transport Table - transport_tsrc - uvw_pcas_stripmap_ele_feature_singlelane]] | `transport_dev.transport_tsrc.uvw_pcas_stripmap_ele_feature_singlelane` | VIEW | 27 | lane access |  |
| [[Transport Table - transport_tsrc - uvw_road_safety_audit_register]] | `transport_dev.transport_tsrc.uvw_road_safety_audit_register` | VIEW | 35 | inspection / audit / condition |  |
| [[Transport Table - transport_tsrc - uvw_sys_av_devices]] | `transport_dev.transport_tsrc.uvw_sys_av_devices` | VIEW | 12 |  |  |
| [[Transport Table - transport_tsrc - uvw_test_asset_condition_report]] | `transport_dev.transport_tsrc.uvw_test_asset_condition_report` | VIEW | 9 | asset register / hierarchy |  |
| [[Transport Table - transport_tsrc - uvw_tollroad_unavailability_events]] | `transport_dev.transport_tsrc.uvw_tollroad_unavailability_events` | VIEW | 32 | KPI / reporting |  |
| [[Transport Table - transport_tsrc - uvw_traffic_closures]] | `transport_dev.transport_tsrc.uvw_traffic_closures` | VIEW | 17 | traffic counts / closures |  |
| [[Transport Table - transport_tsrc - uvw_traffic_volume]] | `transport_dev.transport_tsrc.uvw_traffic_volume` | VIEW | 10 | traffic counts / closures |  |

## Related Pages

- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
