---
type: contract-table-catalog
topic: Ventia
sector: Transport
contract-schema: transport
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-tables, contract-schema]
---

# Transport Contract Tables - transport

This page catalogs table documentation for the `transport` Transport schema. In Transport, schema differences usually indicate different contracts or contract groupings.

## Table Index

| Table | Full name | Type | Columns | Domain | Purpose |
|---|---|---|---:|---|---|
| [[Transport Table - transport - utbl_job_costing_timesheets_all_contracts]] | `transport_dev.transport.utbl_job_costing_timesheets_all_contracts` | MANAGED | 50 | job costing timesheet |  |
| [[Transport Table - transport - uvw_purgrp_masterdata_detail]] | `transport_dev.transport.uvw_purgrp_masterdata_detail` | VIEW | 6 | purchasing group |  |
| [[Transport Table - transport - uvw_purgrp_masterdata_uniquelist]] | `transport_dev.transport.uvw_purgrp_masterdata_uniquelist` | VIEW | 2 | purchasing group |  |
| [[Transport Table - transport - uvw_vendor_cleared_items_bsak]] | `transport_dev.transport.uvw_vendor_cleared_items_bsak` | VIEW | 16 | vendor finance |  |
| [[Transport Table - transport - uvw_vendor_master_data]] | `transport_dev.transport.uvw_vendor_master_data` | VIEW | 4 | vendor master |  |
| [[Transport Table - transport - uvw_vendor_open_items_bsik]] | `transport_dev.transport.uvw_vendor_open_items_bsik` | VIEW | 16 | vendor finance |  |
| [[Transport Table - transport - uvw_wbs_budget_forecast_data_cosp]] | `transport_dev.transport.uvw_wbs_budget_forecast_data_cosp` | VIEW | 24 | WBS finance |  |
| [[Transport Table - transport - uvw_wbs_master_data_prps]] | `transport_dev.transport.uvw_wbs_master_data_prps` | VIEW | 7 | WBS master |  |
| [[Transport Table - transport - uvw_wo_nwa_master_data_aufk_afko_afvc]] | `transport_dev.transport.uvw_wo_nwa_master_data_aufk_afko_afvc` | VIEW | 14 | work order master |  |

## Skipped Or Incomplete Inputs

- `utbl_jobs_allcontract` was visible in the pasted input but the schema was truncated before complete columns could be verified, so it has not been documented yet.
- One or more intervening `transport` schema objects between `utbl_jobs_allcontract` and `uvw_purgrp_masterdata_detail` were hidden by the pasted payload limit, so they have not been documented yet.

## Related Pages

- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
