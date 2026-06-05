---
type: contract-table-catalog
topic: Ventia
sector: Transport
contract-schema: transport_wru
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-tables, contract-schema, transport-wru]
---

# Transport Contract Tables - transport_wru

This page catalogs table documentation for the `transport_wru` Transport schema. In Transport, schema differences usually indicate different contracts or contract groupings.

## Table Index

| Table | Full name | Type | Columns | Domain | Purpose |
|---|---|---|---:|---|---|
| [[Transport Table - transport_wru - utbl_capitalwork_chainage]] | `transport_dev.transport_wru.utbl_capitalwork_chainage` | MANAGED | 5 | capital work |  |
| [[Transport Table - transport_wru - utbl_counter_locations]] | `transport_dev.transport_wru.utbl_counter_locations` | MANAGED | 24 | traffic counter |  |
| [[Transport Table - transport_wru - utbl_counts_by_carriageway]] | `transport_dev.transport_wru.utbl_counts_by_carriageway` | MANAGED | 22 | traffic count |  |
| [[Transport Table - transport_wru - utbl_counts_by_lane]] | `transport_dev.transport_wru.utbl_counts_by_lane` | MANAGED | 25 | traffic count |  |
| [[Transport Table - transport_wru - utbl_counts_hourly]] | `transport_dev.transport_wru.utbl_counts_hourly` | MANAGED | 26 | traffic count |  |
| [[Transport Table - transport_wru - utbl_date_table]] | `transport_dev.transport_wru.utbl_date_table` | MANAGED | 13 | reference date |  |
| [[Transport Table - transport_wru - utbl_eot_reasons]] | `transport_dev.transport_wru.utbl_eot_reasons` | MANAGED | 2 | extension of time |  |
| [[Transport Table - transport_wru - uvw_timesheet]] | `transport_dev.transport_wru.uvw_timesheet` | VIEW | 21 | timesheet |  |
| [[Transport Table - transport_wru - uvw_timesheetitem]] | `transport_dev.transport_wru.uvw_timesheetitem` | VIEW | 29 | timesheet |  |
| [[Transport Table - transport_wru - vw_job_export_final]] | `transport_dev.transport_wru.vw_job_export_final` | VIEW | 32 | job export |  |

## Skipped Or Incomplete Inputs

- `utbl_inspection_road_sections` was visible in the pasted input but the schema was truncated before complete columns could be verified, so it has not been documented yet.
- A WRU view object with `module_id` and `speed` columns was visible only as the tail of a schema and query after truncation and without a verifiable table identity, so it has not been documented yet.

## Related Pages

- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
