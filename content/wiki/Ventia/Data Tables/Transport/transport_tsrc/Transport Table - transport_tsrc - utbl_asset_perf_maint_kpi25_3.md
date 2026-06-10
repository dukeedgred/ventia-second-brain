---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: utbl_asset_perf_maint_kpi25_3
full-name: transport_dev.transport_tsrc.utbl_asset_perf_maint_kpi25_3
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - utbl_asset_perf_maint_kpi25_3

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_asset_perf_maint_kpi25_3` |
| Full name | `transport_dev.transport_tsrc.utbl_asset_perf_maint_kpi25_3` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | MANAGED |
| Column count | 30 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | KPI / reporting |
| Owner/SME | Helix_admins |
| Refresh/freshness | Created: 2024-07-22T01:55:51.718Z; Last altered: 2025-05-27T22:24:08.416Z |
| Source details | Data source format: DELTA |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `id` | `int` | Yes |  |
| `AV_Link` | `string` | Yes |  |
| `assettypename` | `string` | Yes |  |
| `assetcode` | `string` | Yes |  |
| `activitycategorycode` | `string` | Yes |  |
| `activitycode` | `string` | Yes |  |
| `activityname` | `string` | Yes |  |
| `activitytype` | `string` | Yes |  |
| `interventioncode` | `string` | Yes |  |
| `fullinterventioncode` | `string` | Yes |  |
| `interventionname` | `string` | Yes |  |
| `interventionreference1` | `string` | Yes |  |
| `interventionreference2` | `string` | Yes |  |
| `createddate_time` | `timestamp` | Yes |  |
| `duedate_time` | `timestamp` | Yes |  |
| `completeddate_time` | `timestamp` | Yes |  |
| `createddate` | `date` | Yes |  |
| `duedate` | `date` | Yes |  |
| `completeddate` | `date` | Yes |  |
| `completedstatus` | `string` | Yes |  |
| `priority` | `string` | Yes |  |
| `KPI_Criticality` | `string` | Yes |  |
| `ResponseValue_ScheduleInterval` | `bigint` | Yes |  |
| `Response_IntervalUnit` | `string` | Yes |  |
| `KPI_TwiceDueDate` | `timestamp` | Yes |  |
| `KPI_Add10_BusDays` | `timestamp` | Yes |  |
| `KPI_25_ComplianceDueDate` | `timestamp` | Yes |  |
| `KPI_25_ComplianceDueDate_Type` | `string` | Yes |  |
| `KPI_Assessment_Date` | `timestamp` | Yes |  |
| `compliantstatus` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
