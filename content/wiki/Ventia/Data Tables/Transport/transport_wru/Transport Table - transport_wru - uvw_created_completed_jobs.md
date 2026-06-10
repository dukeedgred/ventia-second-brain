---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_created_completed_jobs
full-name: transport_dev.transport_wru.uvw_created_completed_jobs
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_created_completed_jobs

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_created_completed_jobs` |
| Full name | `transport_dev.transport_wru.uvw_created_completed_jobs` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 4 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | jobs / work orders |
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-06-24T22:55:18.897Z; Last altered: 2024-09-24T01:42:25.777Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
select job_id, completeddate as job_date, "completed" as date_type, find_and_fix from uvw_rm_jobs_reporting
where year(completeddate) >= 2024
union
select job_id, createddate as job_date, "created" as date_type, find_and_fix from uvw_rm_jobs_reporting
where year(createddate) >= 2024
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `job_id` | `int` | Yes |  |
| `job_date` | `timestamp` | Yes |  |
| `date_type` | `string` | No |  |
| `find_and_fix` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
