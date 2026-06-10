---
type: contract-table-catalog
topic: Ventia
sector: Transport
contract-schema: transport
date-created: 2026-06-05
date-updated: 2026-06-09
tags: [transport, data-tables, contract-schema, transport]
---

# Transport Contract Tables - transport

This page catalogs table documentation for the `transport` Transport schema. In Transport, schema differences usually indicate different contracts, contract groupings, or curated reporting contexts.

## Table Index

| Table | Full name | Type | Columns | Domain | Purpose |
|---|---|---|---:|---|---|
| [[Transport Table - transport - utbl_job_costing_timesheets_all_contracts]] | `transport_dev.transport.utbl_job_costing_timesheets_all_contracts` | MANAGED | 50 | jobs / work orders |  |
| [[Transport Table - transport - utbl_jobs_allcontract]] | `transport_dev.transport.utbl_jobs_allcontract` | MANAGED | 83 | jobs / work orders |  |
| [[Transport Table - transport - utbl_jobs_formfield_allcontract]] | `transport_dev.transport.utbl_jobs_formfield_allcontract` | MANAGED | 14 | jobs / work orders |  |
| [[Transport Table - transport - utbl_ref_job_costing_fault_map]] | `transport_dev.transport.utbl_ref_job_costing_fault_map` | MANAGED | 4 | jobs / work orders | Created by the file upload UI |
| [[Transport Table - transport - utbl_ref_job_costing_std_road_class]] | `transport_dev.transport.utbl_ref_job_costing_std_road_class` | MANAGED | 5 | jobs / work orders | Created by the file upload UI |
| [[Transport Table - transport - utbl_resource_allcontract]] | `transport_dev.transport.utbl_resource_allcontract` | MANAGED | 22 | resources / timesheets |  |
| [[Transport Table - transport - utbl_sap_items_20_24_fy]] | `transport_dev.transport.utbl_sap_items_20_24_fy` | MANAGED | 22 | commercial / finance | Created by the file upload UI |
| [[Transport Table - transport - utbl_timesheetitem_jobs_allcontract]] | `transport_dev.transport.utbl_timesheetitem_jobs_allcontract` | MANAGED | 25 | jobs / work orders |  |
| [[Transport Table - transport - uvw_catsdata]] | `transport_dev.transport.uvw_catsdata` | VIEW | 22 |  |  |
| [[Transport Table - transport - uvw_cc_budget_forecast_data_cosp]] | `transport_dev.transport.uvw_cc_budget_forecast_data_cosp` | VIEW | 22 | weather |  |
| [[Transport Table - transport - uvw_cc_master_data_csks]] | `transport_dev.transport.uvw_cc_master_data_csks` | VIEW | 4 |  |  |
| [[Transport Table - transport - uvw_cc_masterdata]] | `transport_dev.transport.uvw_cc_masterdata` | VIEW | 6 |  |  |
| [[Transport Table - transport - uvw_completed_po_with_ageing_transport]] | `transport_dev.transport.uvw_completed_po_with_ageing_transport` | VIEW | 52 | commercial / finance |  |
| [[Transport Table - transport - uvw_controlling_doc_transport]] | `transport_dev.transport.uvw_controlling_doc_transport` | VIEW | 56 |  |  |
| [[Transport Table - transport - uvw_employee_listing]] | `transport_dev.transport.uvw_employee_listing` | VIEW | 15 |  |  |
| [[Transport Table - transport - uvw_equipment_deppostings_anlp]] | `transport_dev.transport.uvw_equipment_deppostings_anlp` | VIEW | 20 |  |  |
| [[Transport Table - transport - uvw_equipment_master_data_ie36]] | `transport_dev.transport.uvw_equipment_master_data_ie36` | VIEW | 73 |  |  |
| [[Transport Table - transport - uvw_equipment_nbv_dep_zftm_asseteqip]] | `transport_dev.transport.uvw_equipment_nbv_dep_zftm_asseteqip` | VIEW | 66 | asset register / hierarchy |  |
| [[Transport Table - transport - uvw_pc_masterdata]] | `transport_dev.transport.uvw_pc_masterdata` | VIEW | 29 |  |  |
| [[Transport Table - transport - uvw_po_account_assignment_ekkn]] | `transport_dev.transport.uvw_po_account_assignment_ekkn` | VIEW | 15 | commercial / finance |  |
| [[Transport Table - transport - uvw_po_delivery_dates_eket]] | `transport_dev.transport.uvw_po_delivery_dates_eket` | VIEW | 4 | commercial / finance |  |
| [[Transport Table - transport - uvw_po_header_data_ekko]] | `transport_dev.transport.uvw_po_header_data_ekko` | VIEW | 11 | commercial / finance |  |
| [[Transport Table - transport - uvw_po_history_ekbe]] | `transport_dev.transport.uvw_po_history_ekbe` | VIEW | 17 | commercial / finance |  |
| [[Transport Table - transport - uvw_po_item_data_ekpo]] | `transport_dev.transport.uvw_po_item_data_ekpo` | VIEW | 23 | commercial / finance |  |
| [[Transport Table - transport - uvw_po_open_commitment_with_ageing_transport]] | `transport_dev.transport.uvw_po_open_commitment_with_ageing_transport` | VIEW | 52 | commercial / finance |  |
| [[Transport Table - transport - uvw_po_service_entry_header_data_essr]] | `transport_dev.transport.uvw_po_service_entry_header_data_essr` | VIEW | 18 | commercial / finance |  |
| [[Transport Table - transport - uvw_po_service_entry_lines_rawdata_esll]] | `transport_dev.transport.uvw_po_service_entry_lines_rawdata_esll` | VIEW | 12 | commercial / finance |  |
| [[Transport Table - transport - uvw_po_service_package_account_assignment_eskn]] | `transport_dev.transport.uvw_po_service_package_account_assignment_eskn` | VIEW | 14 | commercial / finance |  |
| [[Transport Table - transport - uvw_po_service_package_header_data_eslh]] | `transport_dev.transport.uvw_po_service_package_header_data_eslh` | VIEW | 7 | commercial / finance |  |
| [[Transport Table - transport - uvw_ptmw_data]] | `transport_dev.transport.uvw_ptmw_data` | VIEW | 33 |  |  |
| [[Transport Table - transport - uvw_ptmw_data_history]] | `transport_dev.transport.uvw_ptmw_data_history` | VIEW | 33 |  |  |
| [[Transport Table - transport - uvw_purchase_requisitions_transport]] | `transport_dev.transport.uvw_purchase_requisitions_transport` | VIEW | 67 | commercial / finance |  |
| [[Transport Table - transport - uvw_purgrp_masterdata_detail]] | `transport_dev.transport.uvw_purgrp_masterdata_detail` | VIEW | 6 |  |  |
| [[Transport Table - transport - uvw_purgrp_masterdata_uniquelist]] | `transport_dev.transport.uvw_purgrp_masterdata_uniquelist` | VIEW | 2 |  |  |
| [[Transport Table - transport - uvw_vendor_cleared_items_bsak]] | `transport_dev.transport.uvw_vendor_cleared_items_bsak` | VIEW | 16 | commercial / finance |  |
| [[Transport Table - transport - uvw_vendor_master_data]] | `transport_dev.transport.uvw_vendor_master_data` | VIEW | 4 | commercial / finance |  |
| [[Transport Table - transport - uvw_vendor_open_items_bsik]] | `transport_dev.transport.uvw_vendor_open_items_bsik` | VIEW | 16 | commercial / finance |  |
| [[Transport Table - transport - uvw_wbs_budget_forecast_data_cosp]] | `transport_dev.transport.uvw_wbs_budget_forecast_data_cosp` | VIEW | 24 | weather |  |
| [[Transport Table - transport - uvw_wbs_master_data_prps]] | `transport_dev.transport.uvw_wbs_master_data_prps` | VIEW | 7 | commercial / finance |  |
| [[Transport Table - transport - uvw_wo_nwa_master_data_aufk_afko_afvc]] | `transport_dev.transport.uvw_wo_nwa_master_data_aufk_afko_afvc` | VIEW | 14 |  |  |

## Related Pages

- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
