---
type: contract-table-catalog
topic: Ventia
sector: Transport
contract-schema: transport_ramc
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-tables, contract-schema, transport-ramc]
---

# Transport Contract Tables - transport_ramc

This page catalogs table documentation for the `transport_ramc` Transport schema. In Transport, schema differences usually indicate different contracts or contract groupings.

## Table Index

| Table | Full name | Type | Columns | Domain | Purpose |
|---|---|---|---:|---|---|
| [[Transport Table - transport_ramc - bkp_backlog_change_report]] | `transport_dev.transport_ramc.bkp_backlog_change_report` | MANAGED | 9 | backlog |  |
| [[Transport Table - transport_ramc - bkp_current_month_job_snapshot]] | `transport_dev.transport_ramc.bkp_current_month_job_snapshot` | MANAGED | 26 | job snapshot |  |
| [[Transport Table - transport_ramc - bkp_last_month_job_snapshot]] | `transport_dev.transport_ramc.bkp_last_month_job_snapshot` | MANAGED | 24 | job snapshot |  |
| [[Transport Table - transport_ramc - bkp_monthly_backlog_reduction]] | `transport_dev.transport_ramc.bkp_monthly_backlog_reduction` | MANAGED | 4 | backlog |  |
| [[Transport Table - transport_ramc - utbl_backlog_change_report]] | `transport_dev.transport_ramc.utbl_backlog_change_report` | MANAGED | 9 | backlog |  |
| [[Transport Table - transport_ramc - utbl_current_month_job_snapshot]] | `transport_dev.transport_ramc.utbl_current_month_job_snapshot` | MANAGED | 26 | job snapshot |  |
| [[Transport Table - transport_ramc - uvw_stripmap_jobphotos]] | `transport_dev.transport_ramc.uvw_stripmap_jobphotos` | VIEW | 4 | stripmap photo |  |
| [[Transport Table - transport_ramc - uvw_stripmap_jobs]] | `transport_dev.transport_ramc.uvw_stripmap_jobs` | VIEW | 56 | stripmap job |  |
| [[Transport Table - transport_ramc - uvw_stripmap_wkt]] | `transport_dev.transport_ramc.uvw_stripmap_wkt` | VIEW | 11 | stripmap GIS |  |

## Skipped Or Incomplete Inputs

- `utbl_last_month_job_snapshot` was visible in the pasted input but the schema was truncated before all columns could be verified, so it has not been documented yet.
- A RAMC view object before `uvw_stripmap_jobphotos` was visible only as the tail of a view query after truncation and without a verifiable table identity, so it has not been documented yet.

## Related Pages

- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
