---
type: contract-table-catalog
topic: Ventia
sector: Transport
contract-schema: transport_wru
date-created: 2026-06-05
date-updated: 2026-06-09
tags: [transport, data-tables, contract-schema, transport-wru]
---

# Transport Contract Tables - transport_wru

This page catalogs table documentation for the `transport_wru` Transport schema. In Transport, schema differences usually indicate different contracts, contract groupings, or curated reporting contexts.

## Table Index

| Table | Full name | Type | Columns | Domain | Purpose |
|---|---|---|---:|---|---|
| [[Transport Table - transport_wru - utbl_capitalwork_chainage]] | `transport_dev.transport_wru.utbl_capitalwork_chainage` | MANAGED | 5 | asset register / hierarchy | Created by the file upload UI |
| [[Transport Table - transport_wru - utbl_counter_locations]] | `transport_dev.transport_wru.utbl_counter_locations` | MANAGED | 24 | traffic counts / closures | Created by the file upload UI |
| [[Transport Table - transport_wru - utbl_counts_by_carriageway]] | `transport_dev.transport_wru.utbl_counts_by_carriageway` | MANAGED | 22 | traffic counts / closures | Created by the file upload UI |
| [[Transport Table - transport_wru - utbl_counts_by_lane]] | `transport_dev.transport_wru.utbl_counts_by_lane` | MANAGED | 25 | traffic counts / closures | Created by the file upload UI |
| [[Transport Table - transport_wru - utbl_counts_hourly]] | `transport_dev.transport_wru.utbl_counts_hourly` | MANAGED | 26 | traffic counts / closures | Created by the file upload UI |
| [[Transport Table - transport_wru - utbl_date_table]] | `transport_dev.transport_wru.utbl_date_table` | MANAGED | 13 | reference / mapping | Created by the file upload UI |
| [[Transport Table - transport_wru - utbl_eot_reasons]] | `transport_dev.transport_wru.utbl_eot_reasons` | MANAGED | 2 | reference / mapping | Created by the file upload UI |
| [[Transport Table - transport_wru - utbl_inspection_road_sections]] | `transport_dev.transport_wru.utbl_inspection_road_sections` | MANAGED | 10 | inspection / audit / condition | Created by the file upload UI |
| [[Transport Table - transport_wru - utbl_lane_access_lane_config]] | `transport_dev.transport_wru.utbl_lane_access_lane_config` | MANAGED | 7 | lane access | Created by the file upload UI |
| [[Transport Table - transport_wru - utbl_lane_access_road_chainage]] | `transport_dev.transport_wru.utbl_lane_access_road_chainage` | MANAGED | 5 | lane access | Created by the file upload UI |
| [[Transport Table - transport_wru - utbl_lane_access_traffic_volumes]] | `transport_dev.transport_wru.utbl_lane_access_traffic_volumes` | MANAGED | 10 | traffic counts / closures | Created by the file upload UI |
| [[Transport Table - transport_wru - utbl_metrocount_direction_converter]] | `transport_dev.transport_wru.utbl_metrocount_direction_converter` | MANAGED | 9 |  | Created by the file upload UI |
| [[Transport Table - transport_wru - utbl_monthly_bins]] | `transport_dev.transport_wru.utbl_monthly_bins` | MANAGED | 9 |  | Created by the file upload UI |
| [[Transport Table - transport_wru - utbl_non_compliant_inspections]] | `transport_dev.transport_wru.utbl_non_compliant_inspections` | MANAGED | 2 | inspection / audit / condition | Created by the file upload UI |
| [[Transport Table - transport_wru - utbl_psdr_comparison]] | `transport_dev.transport_wru.utbl_psdr_comparison` | MANAGED | 6 |  | Created by the file upload UI |
| [[Transport Table - transport_wru - utbl_public_holidays]] | `transport_dev.transport_wru.utbl_public_holidays` | MANAGED | 3 | reference / mapping | Created by the file upload UI |
| [[Transport Table - transport_wru - utbl_raw_data_march]] | `transport_dev.transport_wru.utbl_raw_data_march` | MANAGED | 6 |  | Created by the file upload UI |
| [[Transport Table - transport_wru - utbl_work_peaktime_periods]] | `transport_dev.transport_wru.utbl_work_peaktime_periods` | MANAGED | 4 |  | Created by the file upload UI |
| [[Transport Table - transport_wru - uvw_a_drainage]] | `transport_dev.transport_wru.uvw_a_drainage` | VIEW | 21 |  |  |
| [[Transport Table - transport_wru - uvw_a_embankments]] | `transport_dev.transport_wru.uvw_a_embankments` | VIEW | 11 |  |  |
| [[Transport Table - transport_wru - uvw_a_fencing]] | `transport_dev.transport_wru.uvw_a_fencing` | VIEW | 26 |  |  |
| [[Transport Table - transport_wru - uvw_a_kerb_and_channels]] | `transport_dev.transport_wru.uvw_a_kerb_and_channels` | VIEW | 13 |  |  |
| [[Transport Table - transport_wru - uvw_a_minor_culverts]] | `transport_dev.transport_wru.uvw_a_minor_culverts` | VIEW | 53 |  |  |
| [[Transport Table - transport_wru - uvw_a_pathways]] | `transport_dev.transport_wru.uvw_a_pathways` | VIEW | 30 |  |  |
| [[Transport Table - transport_wru - uvw_a_paved_areas]] | `transport_dev.transport_wru.uvw_a_paved_areas` | VIEW | 20 |  |  |
| [[Transport Table - transport_wru - uvw_a_pit]] | `transport_dev.transport_wru.uvw_a_pit` | VIEW | 20 |  |  |
| [[Transport Table - transport_wru - uvw_a_road]] | `transport_dev.transport_wru.uvw_a_road` | VIEW | 11 |  |  |
| [[Transport Table - transport_wru - uvw_a_signs]] | `transport_dev.transport_wru.uvw_a_signs` | VIEW | 31 |  |  |
| [[Transport Table - transport_wru - uvw_a_table_drains]] | `transport_dev.transport_wru.uvw_a_table_drains` | VIEW | 19 |  |  |
| [[Transport Table - transport_wru - uvw_a_vehicle_barriers]] | `transport_dev.transport_wru.uvw_a_vehicle_barriers` | VIEW | 35 |  |  |
| [[Transport Table - transport_wru - uvw_asset]] | `transport_dev.transport_wru.uvw_asset` | VIEW | 33 | asset register / hierarchy |  |
| [[Transport Table - transport_wru - uvw_asset_audit]] | `transport_dev.transport_wru.uvw_asset_audit` | VIEW | 9 | asset register / hierarchy |  |
| [[Transport Table - transport_wru - uvw_asset_pwa]] | `transport_dev.transport_wru.uvw_asset_pwa` | VIEW | 16 | asset register / hierarchy |  |
| [[Transport Table - transport_wru - uvw_asset_register]] | `transport_dev.transport_wru.uvw_asset_register` | VIEW | 13 | asset register / hierarchy |  |
| [[Transport Table - transport_wru - uvw_assetattribute]] | `transport_dev.transport_wru.uvw_assetattribute` | VIEW | 9 | asset register / hierarchy |  |
| [[Transport Table - transport_wru - uvw_bis_bridge]] | `transport_dev.transport_wru.uvw_bis_bridge` | VIEW | 23 |  |  |
| [[Transport Table - transport_wru - uvw_bis_new_ras_bridge]] | `transport_dev.transport_wru.uvw_bis_new_ras_bridge` | VIEW | 14 |  |  |
| [[Transport Table - transport_wru - uvw_bis_new_ras_component]] | `transport_dev.transport_wru.uvw_bis_new_ras_component` | VIEW | 22 |  |  |
| [[Transport Table - transport_wru - uvw_bis_new_ras_inventory]] | `transport_dev.transport_wru.uvw_bis_new_ras_inventory` | VIEW | 46 | inventory / materials |  |
| [[Transport Table - transport_wru - uvw_bis_new_ras_miscellaneous]] | `transport_dev.transport_wru.uvw_bis_new_ras_miscellaneous` | VIEW | 16 | lane access |  |
| [[Transport Table - transport_wru - uvw_bis_new_ras_status]] | `transport_dev.transport_wru.uvw_bis_new_ras_status` | VIEW | 5 | workflow / status |  |
| [[Transport Table - transport_wru - uvw_capitalwork]] | `transport_dev.transport_wru.uvw_capitalwork` | VIEW | 27 | capital works / forward works |  |
| [[Transport Table - transport_wru - uvw_capitalworktask]] | `transport_dev.transport_wru.uvw_capitalworktask` | VIEW | 33 | capital works / forward works |  |
| [[Transport Table - transport_wru - uvw_created_assets]] | `transport_dev.transport_wru.uvw_created_assets` | VIEW | 6 | asset register / hierarchy |  |
| [[Transport Table - transport_wru - uvw_created_completed_jobs]] | `transport_dev.transport_wru.uvw_created_completed_jobs` | VIEW | 4 | jobs / work orders |  |
| [[Transport Table - transport_wru - uvw_doc_signees]] | `transport_dev.transport_wru.uvw_doc_signees` | VIEW | 9 |  |  |
| [[Transport Table - transport_wru - uvw_documents]] | `transport_dev.transport_wru.uvw_documents` | VIEW | 13 | documents / evidence |  |
| [[Transport Table - transport_wru - uvw_eot_jobs]] | `transport_dev.transport_wru.uvw_eot_jobs` | VIEW | 23 | jobs / work orders |  |
| [[Transport Table - transport_wru - uvw_exportdate]] | `transport_dev.transport_wru.uvw_exportdate` | VIEW | 5 | reference / mapping |  |
| [[Transport Table - transport_wru - uvw_inspection]] | `transport_dev.transport_wru.uvw_inspection` | VIEW | 47 | inspection / audit / condition |  |
| [[Transport Table - transport_wru - uvw_inspection_cathodic_protection]] | `transport_dev.transport_wru.uvw_inspection_cathodic_protection` | VIEW | 20 | inspection / audit / condition |  |
| [[Transport Table - transport_wru - uvw_inspection_completions]] | `transport_dev.transport_wru.uvw_inspection_completions` | VIEW | 16 | inspection / audit / condition |  |
| [[Transport Table - transport_wru - uvw_inspection_hazard_defect]] | `transport_dev.transport_wru.uvw_inspection_hazard_defect` | VIEW | 50 | defects / hazards / failures |  |
| [[Transport Table - transport_wru - uvw_inspection_kpi_1_dashboard]] | `transport_dev.transport_wru.uvw_inspection_kpi_1_dashboard` | VIEW | 30 | KPI / reporting |  |
| [[Transport Table - transport_wru - uvw_inspection_kpi_1_series]] | `transport_dev.transport_wru.uvw_inspection_kpi_1_series` | VIEW | 28 | KPI / reporting |  |
| [[Transport Table - transport_wru - uvw_inspection_settlement_monitoring]] | `transport_dev.transport_wru.uvw_inspection_settlement_monitoring` | VIEW | 8 | inspection / audit / condition |  |
| [[Transport Table - transport_wru - uvw_inspection_structures]] | `transport_dev.transport_wru.uvw_inspection_structures` | VIEW | 23 | inspection / audit / condition |  |
| [[Transport Table - transport_wru - uvw_inspection_typesnormalised]] | `transport_dev.transport_wru.uvw_inspection_typesnormalised` | VIEW | 8 | inspection / audit / condition |  |
| [[Transport Table - transport_wru - uvw_inspections_level_1]] | `transport_dev.transport_wru.uvw_inspections_level_1` | VIEW | 17 | inspection / audit / condition |  |
| [[Transport Table - transport_wru - uvw_inspections_level_2]] | `transport_dev.transport_wru.uvw_inspections_level_2` | VIEW | 18 | inspection / audit / condition |  |
| [[Transport Table - transport_wru - uvw_inspections_level_3]] | `transport_dev.transport_wru.uvw_inspections_level_3` | VIEW | 9 | inspection / audit / condition |  |
| [[Transport Table - transport_wru - uvw_jeopardy_board]] | `transport_dev.transport_wru.uvw_jeopardy_board` | VIEW | 23 |  |  |
| [[Transport Table - transport_wru - uvw_jeopardy_board_jobs]] | `transport_dev.transport_wru.uvw_jeopardy_board_jobs` | VIEW | 22 | jobs / work orders |  |
| [[Transport Table - transport_wru - uvw_job]] | `transport_dev.transport_wru.uvw_job` | VIEW | 87 | jobs / work orders |  |
| [[Transport Table - transport_wru - uvw_job_geom]] | `transport_dev.transport_wru.uvw_job_geom` | VIEW | 5 | jobs / work orders |  |
| [[Transport Table - transport_wru - uvw_job_kpi_2]] | `transport_dev.transport_wru.uvw_job_kpi_2` | VIEW | 44 | KPI / reporting |  |
| [[Transport Table - transport_wru - uvw_kpi_1_noncompliant]] | `transport_dev.transport_wru.uvw_kpi_1_noncompliant` | VIEW | 3 | KPI / reporting |  |
| [[Transport Table - transport_wru - uvw_laneaccess_raw]] | `transport_dev.transport_wru.uvw_laneaccess_raw` | VIEW | 40 | lane access |  |
| [[Transport Table - transport_wru - uvw_laneaccess_report]] | `transport_dev.transport_wru.uvw_laneaccess_report` | VIEW | 41 | lane access |  |
| [[Transport Table - transport_wru - uvw_lastmodified]] | `transport_dev.transport_wru.uvw_lastmodified` | VIEW | 2 |  |  |
| [[Transport Table - transport_wru - uvw_rm_inspection_dashboard]] | `transport_dev.transport_wru.uvw_rm_inspection_dashboard` | VIEW | 62 | inspection / audit / condition |  |
| [[Transport Table - transport_wru - uvw_rm_jobs_reporting]] | `transport_dev.transport_wru.uvw_rm_jobs_reporting` | VIEW | 64 | jobs / work orders |  |
| [[Transport Table - transport_wru - uvw_rm_yesterdays_jobs]] | `transport_dev.transport_wru.uvw_rm_yesterdays_jobs` | VIEW | 5 | jobs / work orders |  |
| [[Transport Table - transport_wru - uvw_tgs_module]] | `transport_dev.transport_wru.uvw_tgs_module` | VIEW | 7 | forms / modules |  |
| [[Transport Table - transport_wru - uvw_tgs_speed_limits]] | `transport_dev.transport_wru.uvw_tgs_speed_limits` | VIEW | 2 |  |  |
| [[Transport Table - transport_wru - uvw_timesheet]] | `transport_dev.transport_wru.uvw_timesheet` | VIEW | 21 | resources / timesheets |  |
| [[Transport Table - transport_wru - uvw_timesheetitem]] | `transport_dev.transport_wru.uvw_timesheetitem` | VIEW | 29 | resources / timesheets |  |
| [[Transport Table - transport_wru - vw_job_export_final]] | `transport_dev.transport_wru.vw_job_export_final` | VIEW | 32 | jobs / work orders |  |

## Related Pages

- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
