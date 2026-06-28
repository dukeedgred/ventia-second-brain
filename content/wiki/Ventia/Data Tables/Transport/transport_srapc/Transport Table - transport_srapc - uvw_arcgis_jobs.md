---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_srapc
table-name: uvw_arcgis_jobs
full-name: transport_dev.transport_srapc.uvw_arcgis_jobs
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-srapc]
---

# Transport Table - transport_srapc - uvw_arcgis_jobs

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_arcgis_jobs` |
| Full name | `transport_dev.transport_srapc.uvw_arcgis_jobs` |
| Catalog | `transport_dev` |
| Schema | `transport_srapc` |
| Contract/schema | `transport_srapc` |
| Table type | VIEW |
| Column count | 20 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | jobs / work orders |
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2024-06-18T04:27:19.098Z; Last altered: 2024-07-18T20:30:55.667Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
select
  j.id,
  j.classification,
  j.interventioncode,
  j.interventionname,
  j.activitycategoryname,
  j.activityname,
  j.priority,
  to_timestamp(j.createddate) as createddate,
  to_timestamp(j.duedate) as duedate,
  j.completedstatus,
  to_timestamp(j.completeddate) as completeddate,
  j.createduser,
  (select
      c.comment
    from
      ext_mssql_asset_vision_ven_rms.dbo.jobcomment c
    where
      c.JobID = j.id
    order by
      c.id DESC
    limit
      1
  ) as lastcomment,
  j.completeduser, -- LGA -- pending for helix to add this to databrick
  j.WKT as spatialinfo,
  substring(j.WKT, instr(j.WKT, '-'), (instr(j.WKT, ')') - instr(j.WKT, '-'))) as Latitude,
  substring(j.WKT, instr(j.WKT, '(') + 1, (instr(j.WKT, ' -') - instr(j.WKT, '(') - 1)) as Longitude,
  j.currentworkflowitemname,
  w.reason as currentworkflowstatusreason,
  f.value as IncidentNumber
from
  ext_mssql_asset_vision_ven_rms.dbo.vjob j
  left join ext_mssql_asset_vision_ven_rms.dbo.formfield f on f.sourcetable = 'Job'
  and f.name = 'Incident|TMC Number'
  and f.sourcetableid = j.id
  and f.deleted = False
  left join ext_mssql_asset_vision_ven_rms.dbo.workflowstatus w on w.sourcetable = 'Job'
  and w.sourcetableid = j.id
  and w.workflowitemname = j.currentworkflowitemname
where
  j.contract = 'SRAP-C'
  and j.deleted = False
order by
  j.id
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `id` | `int` | Yes |  |
| `classification` | `string` | Yes |  |
| `interventioncode` | `string` | Yes |  |
| `interventionname` | `string` | Yes |  |
| `activitycategoryname` | `string` | Yes |  |
| `activityname` | `string` | Yes |  |
| `priority` | `string` | Yes |  |
| `createddate` | `timestamp` | Yes |  |
| `duedate` | `timestamp` | Yes |  |
| `completedstatus` | `string` | Yes |  |
| `completeddate` | `timestamp` | Yes |  |
| `createduser` | `string` | Yes |  |
| `lastcomment` | `string` | Yes |  |
| `completeduser` | `string` | Yes |  |
| `spatialinfo` | `string` | Yes |  |
| `Latitude` | `string` | Yes |  |
| `Longitude` | `string` | Yes |  |
| `currentworkflowitemname` | `string` | Yes |  |
| `currentworkflowstatusreason` | `string` | Yes |  |
| `IncidentNumber` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_srapc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
