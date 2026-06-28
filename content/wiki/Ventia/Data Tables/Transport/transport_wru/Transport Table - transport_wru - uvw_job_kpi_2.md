---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_job_kpi_2
full-name: transport_dev.transport_wru.uvw_job_kpi_2
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_job_kpi_2

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_job_kpi_2` |
| Full name | `transport_dev.transport_wru.uvw_job_kpi_2` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 44 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | KPI / reporting |
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-06-18T13:31:49.118Z; Last altered: 2024-09-24T01:43:01.559Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
with KPI_2_Jobs as(
  select
    *
  from
    transport_dev.transport_wru.uvw_job
  where
    intervention_level in ('Defect', 'Hazard', 'Emergency Response')
    and (mergedjobid = '' or mergedjobid is null)
),
Travel_To_Site as(
  select
    to_timestamp(concat(substring(b.value, 7, 4), '-', substring(b.value, 4, 2), '-', left(b.value, 2), ' ', right(b.value, 8))) as Travel_To_Site,
    a.id
  from
    transport_dev.transport_wru.uvw_job a
    join ext_mssql_asset_vision_ven_vicroads.dbo.formfield b on a.id = b.sourcetableid
  where
    b.name = 'Travel To Site|Travel Start Date and Time'
    and b.deleted = false
    and b.sourcetable = 'Job'
),
Arrvied_On_Site as(
  select
    to_timestamp(concat(substring(b.value, 7, 4), '-', substring(b.value, 4, 2), '-', left(b.value, 2), ' ', right(b.value, 8))) as Arrvied_On_Site,
    a.id
  from
    transport_dev.transport_wru.uvw_job a
    join ext_mssql_asset_vision_ven_vicroads.dbo.formfield b on a.id = b.sourcetableid
  where
    b.name = 'Arrive on Site|Arrive on Site Date and Time'
    and b.deleted = false
    and b.sourcetable = 'Job'
),
Start_On_Site as (
  select
    to_timestamp(concat(substring(b.value, 7, 4), '-', substring(b.value, 4, 2), '-', left(b.value, 2), ' ', right(b.value, 8))) as Start_On_Site,
    a.id
  from
    transport_dev.transport_wru.uvw_job a
    join ext_mssql_asset_vision_ven_vicroads.dbo.formfield b on a.id = b.sourcetableid
  where
    b.name = 'Start Work On Site|Start Work Date and Time'
    and b.deleted = false
    and b.sourcetable = 'Job'
),
Finish_On_Site as (
  select
    to_timestamp(concat(substring(b.value, 7, 4), '-', substring(b.value, 4, 2), '-', left(b.value, 2), ' ', right(b.value, 8))) as Finish_On_Site,
    a.id
  from
    transport_dev.transport_wru.uvw_job a
    join ext_mssql_asset_vision_ven_vicroads.dbo.formfield b on a.id = b.sourcetableid
  where
    b.name = 'Finish Work On Site|Finish work Date and Time'
    and b.deleted = false
    and b.sourcetable = 'Job'
)
select
  concat(year(a.duedate), format_number(month(a.duedate), "00")) as reporting_ID,
  a.id as job_id,
  a.assetid,
  a.assetcode,
  a.assetname,
  a.assettypename,
  a.activitytype,
  a.hazarddefectcode,
  a.hazardcode,
  a.activitycategorycode,
  a.activitycategoryname,
  a.activitycode,
  a.activityname,
  case
    when a.intervention_level = 'Hazard' then '2.1'
    when a.intervention_level = 'Emergency Response' then '2.3'
    when a.intervention_level = 'Defect' and left(a.activitycode, 5) in ( 'RM111',
                                                                          'RM121',
                                                                          'RM211',
                                                                          'RM212',
                                                                          'RM231',
                                                                          'RM414',
                                                                          'RM612',
                                                                          'RM613',
                                                                          'RM615',
                                                                          'RM617',
                                                                          'RM619',
                                                                          'RM816',
                                                                          'RM818',
                                                                          'RM620'
                                                                        ) then '2.2A'
    when a.intervention_level = 'Defect' and a.activitycode = 'RM221_1' then '2.2A'
    when a.intervention_level = 'Defect' then '2.2B'
  end as KPI_Category,
  a.interventionid,
  a.interventioncode,
  a.fullinterventioncode,
  a.interventionname,
  a.createddate,
  a.duedate,
  a.scheduledstart,
  a.scheduledend,
  a.completeddate,
  a.assigneddate,
  a.completedstatus,
  a.classification,
  a.assigneduser,
  a.createduser,
  a.completeduser,
  b.Travel_To_Site,
  c.Arrvied_On_Site,
  d.Start_On_Site,
  e.Finish_On_Site,
  a.inspectionid,
  a.inspectiontypename,
  a.area,
  a.mergedjobid,
  a.crmid as ETS_ID, 
  case
    when a.crmid is null or a.crmid = '' then 'Yes'
    else 'No'
  end as ETS_Request,
  job_hyperlink,
  a.intervention_level,
  a.comment,
  a.job_comments as full_Comments,
  a.html_job_comments
from
  KPI_2_Jobs a
  left join Travel_To_Site b on a.id = b.id
  left join Arrvied_On_Site c on a.id = c.id
  left join Start_On_Site d on a.id = d.id
  left join Finish_On_Site e on a.id = e.id
where
  a.hazarddefectcode <> 'CP.CP'
  and activitycategorycode <> 'RM_TP'
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `reporting_ID` | `string` | Yes |  |
| `job_id` | `int` | Yes |  |
| `assetid` | `int` | Yes |  |
| `assetcode` | `string` | Yes |  |
| `assetname` | `string` | Yes |  |
| `assettypename` | `string` | Yes |  |
| `activitytype` | `string` | Yes |  |
| `hazarddefectcode` | `string` | Yes |  |
| `hazardcode` | `string` | Yes |  |
| `activitycategorycode` | `string` | Yes |  |
| `activitycategoryname` | `string` | Yes |  |
| `activitycode` | `string` | Yes |  |
| `activityname` | `string` | Yes |  |
| `KPI_Category` | `string` | Yes |  |
| `interventionid` | `int` | Yes |  |
| `interventioncode` | `string` | Yes |  |
| `fullinterventioncode` | `string` | Yes |  |
| `interventionname` | `string` | Yes |  |
| `createddate` | `timestamp` | Yes |  |
| `duedate` | `timestamp` | Yes |  |
| `scheduledstart` | `timestamp` | Yes |  |
| `scheduledend` | `timestamp` | Yes |  |
| `completeddate` | `timestamp` | Yes |  |
| `assigneddate` | `timestamp` | Yes |  |
| `completedstatus` | `string` | Yes |  |
| `classification` | `string` | Yes |  |
| `assigneduser` | `string` | Yes |  |
| `createduser` | `string` | Yes |  |
| `completeduser` | `string` | Yes |  |
| `Travel_To_Site` | `timestamp` | Yes |  |
| `Arrvied_On_Site` | `timestamp` | Yes |  |
| `Start_On_Site` | `timestamp` | Yes |  |
| `Finish_On_Site` | `timestamp` | Yes |  |
| `inspectionid` | `int` | Yes |  |
| `inspectiontypename` | `string` | Yes |  |
| `area` | `string` | Yes |  |
| `mergedjobid` | `int` | Yes |  |
| `ETS_ID` | `string` | Yes |  |
| `ETS_Request` | `string` | No |  |
| `job_hyperlink` | `string` | Yes |  |
| `intervention_level` | `string` | Yes |  |
| `comment` | `string` | Yes |  |
| `full_Comments` | `string` | Yes |  |
| `html_job_comments` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
