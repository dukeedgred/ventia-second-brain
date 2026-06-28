---
type: contract-table-catalog
topic: Ventia
sector: Transport
contract-schema: transport_srapc
date-created: 2026-06-05
date-updated: 2026-06-09
tags: [transport, data-tables, contract-schema, transport-srapc]
---

# Transport Contract Tables - transport_srapc

This page catalogs table documentation for the `transport_srapc` Transport schema. In Transport, schema differences usually indicate different contracts, contract groupings, or curated reporting contexts.

## Table Index

| Table | Full name | Type | Columns | Domain | Purpose |
|---|---|---|---:|---|---|
| [[Transport Table - transport_srapc - utbl_monthly_report]] | `transport_dev.transport_srapc.utbl_monthly_report` | MANAGED | 12 |  | Created by the file upload UI |
| [[Transport Table - transport_srapc - utbl_srapc_formitize_mapping]] | `transport_dev.transport_srapc.utbl_srapc_formitize_mapping` | MANAGED | 7 | forms / modules | Created by the file upload UI |
| [[Transport Table - transport_srapc - utbl_tacp_constants]] | `transport_dev.transport_srapc.utbl_tacp_constants` | MANAGED | 6 | reference / mapping | Created by the file upload UI |
| [[Transport Table - transport_srapc - utbl_tacp_toc]] | `transport_dev.transport_srapc.utbl_tacp_toc` | MANAGED | 3 |  | Created by the file upload UI |
| [[Transport Table - transport_srapc - utbl_tmp_civil_master]] | `transport_dev.transport_srapc.utbl_tmp_civil_master` | MANAGED | 54 | staging / backup | Created by the file upload UI |
| [[Transport Table - transport_srapc - uvw_a_bridge_all_data]] | `transport_dev.transport_srapc.uvw_a_bridge_all_data` | VIEW | 58 |  |  |
| [[Transport Table - transport_srapc - uvw_a_slope_all_data]] | `transport_dev.transport_srapc.uvw_a_slope_all_data` | VIEW | 86 |  |  |
| [[Transport Table - transport_srapc - uvw_arcgis_jobs]] | `transport_dev.transport_srapc.uvw_arcgis_jobs` | VIEW | 20 | jobs / work orders |  |
| [[Transport Table - transport_srapc - uvw_asset]] | `transport_dev.transport_srapc.uvw_asset` | VIEW | 38 | asset register / hierarchy |  |
| [[Transport Table - transport_srapc - uvw_asset_all_data_withphoto]] | `transport_dev.transport_srapc.uvw_asset_all_data_withphoto` | VIEW | 56 | asset register / hierarchy |  |
| [[Transport Table - transport_srapc - uvw_asset_inspection_last]] | `transport_dev.transport_srapc.uvw_asset_inspection_last` | VIEW | 48 | asset register / hierarchy |  |
| [[Transport Table - transport_srapc - uvw_asset_inspection_next]] | `transport_dev.transport_srapc.uvw_asset_inspection_next` | VIEW | 48 | asset register / hierarchy |  |
| [[Transport Table - transport_srapc - uvw_assetattribute]] | `transport_dev.transport_srapc.uvw_assetattribute` | VIEW | 9 | asset register / hierarchy |  |
| [[Transport Table - transport_srapc - uvw_av_tmp_combined]] | `transport_dev.transport_srapc.uvw_av_tmp_combined` | VIEW | 69 | staging / backup |  |
| [[Transport Table - transport_srapc - uvw_customerrequest]] | `transport_dev.transport_srapc.uvw_customerrequest` | VIEW | 28 |  |  |
| [[Transport Table - transport_srapc - uvw_customerrequest_all_attributes]] | `transport_dev.transport_srapc.uvw_customerrequest_all_attributes` | VIEW | 54 |  |  |
| [[Transport Table - transport_srapc - uvw_customerrequestpivot]] | `transport_dev.transport_srapc.uvw_customerrequestpivot` | VIEW | 5 |  |  |
| [[Transport Table - transport_srapc - uvw_inspection_all_attributes]] | `transport_dev.transport_srapc.uvw_inspection_all_attributes` | VIEW | 41 | inspection / audit / condition |  |
| [[Transport Table - transport_srapc - uvw_inspections_all]] | `transport_dev.transport_srapc.uvw_inspections_all` | VIEW | 42 | inspection / audit / condition |  |
| [[Transport Table - transport_srapc - uvw_job]] | `transport_dev.transport_srapc.uvw_job` | VIEW | 82 | jobs / work orders |  |
| [[Transport Table - transport_srapc - uvw_job_all_attributes]] | `transport_dev.transport_srapc.uvw_job_all_attributes` | VIEW | 78 | jobs / work orders |  |
| [[Transport Table - transport_srapc - uvw_jobs_actgroup]] | `transport_dev.transport_srapc.uvw_jobs_actgroup` | VIEW | 15 | jobs / work orders |  |
| [[Transport Table - transport_srapc - uvw_jobs_am_weighted_score]] | `transport_dev.transport_srapc.uvw_jobs_am_weighted_score` | VIEW | 22 | jobs / work orders |  |
| [[Transport Table - transport_srapc - uvw_jobspowerbi]] | `transport_dev.transport_srapc.uvw_jobspowerbi` | VIEW | 33 | jobs / work orders |  |
| [[Transport Table - transport_srapc - uvw_monthly_subcontractor_data]] | `transport_dev.transport_srapc.uvw_monthly_subcontractor_data` | VIEW | 282 |  |  |
| [[Transport Table - transport_srapc - uvw_monthly_subcontractor_data_energy]] | `transport_dev.transport_srapc.uvw_monthly_subcontractor_data_energy` | VIEW | 37 |  |  |
| [[Transport Table - transport_srapc - uvw_monthly_subcontractor_data_health_safety]] | `transport_dev.transport_srapc.uvw_monthly_subcontractor_data_health_safety` | VIEW | 15 |  |  |
| [[Transport Table - transport_srapc - uvw_monthly_subcontractor_data_material]] | `transport_dev.transport_srapc.uvw_monthly_subcontractor_data_material` | VIEW | 28 | inventory / materials |  |
| [[Transport Table - transport_srapc - uvw_monthly_subcontractor_data_social]] | `transport_dev.transport_srapc.uvw_monthly_subcontractor_data_social` | VIEW | 11 |  |  |
| [[Transport Table - transport_srapc - uvw_monthly_subcontractor_data_stationary_fuel]] | `transport_dev.transport_srapc.uvw_monthly_subcontractor_data_stationary_fuel` | VIEW | 18 |  |  |
| [[Transport Table - transport_srapc - uvw_monthly_subcontractor_data_waste]] | `transport_dev.transport_srapc.uvw_monthly_subcontractor_data_waste` | VIEW | 75 |  |  |
| [[Transport Table - transport_srapc - uvw_ndh_shift_report]] | `transport_dev.transport_srapc.uvw_ndh_shift_report` | VIEW | 20 |  |  |
| [[Transport Table - transport_srapc - uvw_pbi_master_jobs_export]] | `transport_dev.transport_srapc.uvw_pbi_master_jobs_export` | VIEW | 33 | jobs / work orders |  |
| [[Transport Table - transport_srapc - uvw_photos_unique]] | `transport_dev.transport_srapc.uvw_photos_unique` | VIEW | 12 | documents / evidence |  |
| [[Transport Table - transport_srapc - uvw_school_zone]] | `transport_dev.transport_srapc.uvw_school_zone` | VIEW | 3 |  |  |
| [[Transport Table - transport_srapc - uvw_srapc_assets]] | `transport_dev.transport_srapc.uvw_srapc_assets` | VIEW | 22 | asset register / hierarchy |  |
| [[Transport Table - transport_srapc - uvw_srapc_jobs_am_weighted_score]] | `transport_dev.transport_srapc.uvw_srapc_jobs_am_weighted_score` | VIEW | 21 | jobs / work orders |  |
| [[Transport Table - transport_srapc - uvw_srapc_special_projects]] | `transport_dev.transport_srapc.uvw_srapc_special_projects` | VIEW | 94 |  |  |
| [[Transport Table - transport_srapc - uvw_srapc_tfnsw_monthly_report_defect_intervention]] | `transport_dev.transport_srapc.uvw_srapc_tfnsw_monthly_report_defect_intervention` | VIEW | 11 | defects / hazards / failures |  |
| [[Transport Table - transport_srapc - uvw_tacp_data_delta_load]] | `transport_dev.transport_srapc.uvw_tacp_data_delta_load` | VIEW | 65 |  |  |
| [[Transport Table - transport_srapc - uvw_tacp_data_initial_load]] | `transport_dev.transport_srapc.uvw_tacp_data_initial_load` | VIEW | 65 |  |  |
| [[Transport Table - transport_srapc - uvw_weatherobervations]] | `transport_dev.transport_srapc.uvw_weatherobervations` | VIEW | 26 | weather |  |

## Related Pages

- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
