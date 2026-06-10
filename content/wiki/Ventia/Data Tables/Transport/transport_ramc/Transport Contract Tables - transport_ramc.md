---
type: contract-table-catalog
topic: Ventia
sector: Transport
contract-schema: transport_ramc
date-created: 2026-06-05
date-updated: 2026-06-09
tags: [transport, data-tables, contract-schema, transport-ramc]
---

# Transport Contract Tables - transport_ramc

This page catalogs table documentation for the `transport_ramc` Transport schema. In Transport, schema differences usually indicate different contracts, contract groupings, or curated reporting contexts.

## Table Index

| Table | Full name | Type | Columns | Domain | Purpose |
|---|---|---|---:|---|---|
| [[Transport Table - transport_ramc - bkp_backlog_change_report]] | `transport_dev.transport_ramc.bkp_backlog_change_report` | MANAGED | 9 | staging / backup |  |
| [[Transport Table - transport_ramc - bkp_current_month_job_snapshot]] | `transport_dev.transport_ramc.bkp_current_month_job_snapshot` | MANAGED | 26 | jobs / work orders |  |
| [[Transport Table - transport_ramc - bkp_last_month_job_snapshot]] | `transport_dev.transport_ramc.bkp_last_month_job_snapshot` | MANAGED | 24 | jobs / work orders |  |
| [[Transport Table - transport_ramc - bkp_monthly_backlog_reduction]] | `transport_dev.transport_ramc.bkp_monthly_backlog_reduction` | MANAGED | 4 | staging / backup |  |
| [[Transport Table - transport_ramc - utbl_backlog_change_report]] | `transport_dev.transport_ramc.utbl_backlog_change_report` | MANAGED | 9 |  |  |
| [[Transport Table - transport_ramc - utbl_current_month_job_snapshot]] | `transport_dev.transport_ramc.utbl_current_month_job_snapshot` | MANAGED | 26 | jobs / work orders | Created by the file upload UI |
| [[Transport Table - transport_ramc - utbl_last_month_job_snapshot]] | `transport_dev.transport_ramc.utbl_last_month_job_snapshot` | MANAGED | 24 | jobs / work orders |  |
| [[Transport Table - transport_ramc - utbl_monthly_backlog_reduction]] | `transport_dev.transport_ramc.utbl_monthly_backlog_reduction` | MANAGED | 4 |  |  |
| [[Transport Table - transport_ramc - utbl_reporting_period]] | `transport_dev.transport_ramc.utbl_reporting_period` | MANAGED | 3 |  | Created by the file upload UI |
| [[Transport Table - transport_ramc - uvw_inspection]] | `transport_dev.transport_ramc.uvw_inspection` | VIEW | 36 | inspection / audit / condition |  |
| [[Transport Table - transport_ramc - uvw_job]] | `transport_dev.transport_ramc.uvw_job` | VIEW | 45 | jobs / work orders |  |
| [[Transport Table - transport_ramc - uvw_job_temp]] | `transport_dev.transport_ramc.uvw_job_temp` | VIEW | 41 | jobs / work orders |  |
| [[Transport Table - transport_ramc - uvw_roadlastinspected]] | `transport_dev.transport_ramc.uvw_roadlastinspected` | VIEW | 12 |  |  |
| [[Transport Table - transport_ramc - uvw_stripmap_full]] | `transport_dev.transport_ramc.uvw_stripmap_full` | VIEW | 25 |  |  |
| [[Transport Table - transport_ramc - uvw_stripmap_jobphotos]] | `transport_dev.transport_ramc.uvw_stripmap_jobphotos` | VIEW | 4 | jobs / work orders |  |
| [[Transport Table - transport_ramc - uvw_stripmap_jobs]] | `transport_dev.transport_ramc.uvw_stripmap_jobs` | VIEW | 56 | jobs / work orders |  |
| [[Transport Table - transport_ramc - uvw_stripmap_wkt]] | `transport_dev.transport_ramc.uvw_stripmap_wkt` | VIEW | 11 |  |  |

## Related Pages

- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
