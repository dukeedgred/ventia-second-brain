---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_eot_jobs
full-name: transport_dev.transport_wru.uvw_eot_jobs
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_eot_jobs

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_eot_jobs` |
| Full name | `transport_dev.transport_wru.uvw_eot_jobs` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 23 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | jobs / work orders |
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-06-20T07:33:10.2Z; Last altered: 2024-09-24T01:42:50.153Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
with EOT_Jobs as(
  select
    a.id as `JobID`,
    timestamp(concat(substring(b.value, 7, 4), '-', substring(b.value, 4, 2), '-', substring(b.value, 1, 2), ' ', right(b.value, 8))) as `OriginalDueDate`,
    timestamp(date_format(a.duedate, 'yyyy-MM-dd HH:mm')) as `NewDueDate`,
    a.createddate,
    a.assetid,
    a.assetcode,
    a.assetname,
    a.hazarddefectcode,
    a.hazardcode,
    a.activitycategorycode,
    a.activitycode,
    a.activityname,
    a.interventioncode,
    a.assigneduser,
    a.activitytype,
    a.completedstatus,
    a.classification,
    a.spatialinfo,
    a.assettypename,
    a.job_comments,
    a.job_hyperlink
  from
    transport_dev.transport_wru.uvw_job a
    join ext_mssql_asset_vision_ven_vicroads.dbo.formfield b on a.id = b.sourcetableid
    and b.name = 'Job Data|Original Due Date' and b.value <> '' and b.deleted = false
 
  union

  --Ballart Rd Bridge fence, one off EOT
  select
    id as `JobID`,
    timestamp('2023-12-24T18:32:00.000') as `OriginalDueDate`,
    timestamp('2024-01-31T23:59:00.000') as `NewDueDate`,
    a.createddate,
    a.assetid,
    a.assetcode,
    a.assetname,
    a.hazarddefectcode,
    a.hazardcode,
    a.activitycategorycode,
    a.activitycode,
    a.activityname,
    a.interventioncode,
    a.assigneduser,
    a.activitytype,
    a.completedstatus,
    a.classification,
    a.spatialinfo,
    a.assettypename,
    a.job_comments,
    a.job_hyperlink
  from
    transport_dev.transport_wru.uvw_job a
  where
    a.id = 3048143
)
select
  date_format(OriginalDueDate, 'yyyyMM') as Reporting_ID,
  a.*, 
  case
    when c.job_id is not null then c.extension_reason
    else b.value
  end as `Job Data|Extension Reason`
from
  EOT_Jobs a
  left join ext_mssql_asset_vision_ven_vicroads.dbo.formfield b on a.jobid = b.sourcetableid
  and b.name = 'Job Data|Extension Reason' 
  and b.deleted = false
  left join transport_dev.transport_wru.utbl_eot_reasons c on a.jobid = c.job_id
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Reporting_ID` | `string` | Yes |  |
| `JobID` | `int` | Yes |  |
| `OriginalDueDate` | `timestamp` | Yes |  |
| `NewDueDate` | `timestamp` | Yes |  |
| `createddate` | `timestamp` | Yes |  |
| `assetid` | `int` | Yes |  |
| `assetcode` | `string` | Yes |  |
| `assetname` | `string` | Yes |  |
| `hazarddefectcode` | `string` | Yes |  |
| `hazardcode` | `string` | Yes |  |
| `activitycategorycode` | `string` | Yes |  |
| `activitycode` | `string` | Yes |  |
| `activityname` | `string` | Yes |  |
| `interventioncode` | `string` | Yes |  |
| `assigneduser` | `string` | Yes |  |
| `activitytype` | `string` | Yes |  |
| `completedstatus` | `string` | Yes |  |
| `classification` | `string` | Yes |  |
| `spatialinfo` | `string` | Yes |  |
| `assettypename` | `string` | Yes |  |
| `job_comments` | `string` | Yes |  |
| `job_hyperlink` | `string` | Yes |  |
| `Job Data|Extension Reason` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
