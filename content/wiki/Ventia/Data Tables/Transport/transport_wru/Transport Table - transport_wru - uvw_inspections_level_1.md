---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_inspections_level_1
full-name: transport_dev.transport_wru.uvw_inspections_level_1
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_inspections_level_1

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_inspections_level_1` |
| Full name | `transport_dev.transport_wru.uvw_inspections_level_1` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 17 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | inspection / audit / condition |
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-06-19T02:33:10.363Z; Last altered: 2024-09-24T01:42:55.762Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
with selection as (
select
  a.id as inspection_id, 
  coalesce(a.assetid, b.assetid) as assetid, 
  coalesce(a.assettypename, b.assettypename) as assettypename, 
  a.completeduser, 
  a.inspection_hyperlink,
  a.completed_date as completed_date_datetime, 
  b.completed_date as previous_completed_date,
  ADD_MONTHS(b.completed_date,6) as duedate, 
  IF(isnotnull(completed_date_datetime) and ((completed_date_datetime <= duedate) or (isnotnull(completed_date_datetime) and isnull(duedate))),  "Inspected", 
    IF(isnotnull(completed_date_datetime) and (completed_date_datetime > duedate), concat(string(datediff(completed_date_datetime,duedate))," day(s) late"),
    IF(datediff(duedate, convert_timezone('Australia/Sydney', getdate()))< 0, concat(string(datediff(duedate, convert_timezone('Australia/Sydney', getdate())))," days overdue"), 
      datediff(duedate, convert_timezone('Australia/Sydney', getdate()))))) as days_to_due_date,
  case 
    when completed_date_datetime is not null and ((completed_date_datetime <= duedate) or (completed_date_datetime is not null and duedate is null)) then  "On time" -- dark green
    when completed_date_datetime is not null and (completed_date_datetime > duedate) then "Late" -- orange
    when datediff(duedate, convert_timezone('Australia/Sydney', getdate()))< 0 then "Overdue" -- red
    when completed_date_datetime is null then "Upcoming" -- blue
    else "undefined"
  end as inspection_status,
  case 
    when completed_date_datetime is not null and ((completed_date_datetime <= duedate) or (completed_date_datetime is not null and duedate is null)) then "#008000"
    when completed_date_datetime is not null and (completed_date_datetime > duedate) then "#FF5733"
    when datediff(duedate, convert_timezone('Australia/Sydney', getdate()))< 0 then "#FF0000" 
    when completed_date_datetime is null then "#118DFF" 
    else null
  end as inspection_colour,
  --IF(isnull(completed_date_datetime), 'Not Inspected', date_format(completed_date_datetime,'yyyy/MM/dd')) as completed_date,
  coalesce(a.inspectiontype, b.inspectiontype) as inspectiontype,
  a.inspection_comments
from transport_dev.transport_wru.uvw_inspection_completions a
  full join transport_dev.transport_wru.uvw_inspection_completions b
    on (a.rn = b.rn+1) and (a.assetid = b.assetid) and (a.inspectiontype = b.inspectiontype)
where (a.assettypename in ('Retaining Wall', 'Major Sign Structure', 'Noise Wall', 'Bridge/Major Culvert', 'Bridge') or b.assettypename in ('Retaining Wall', 'Major Sign Structure', 'Noise Wall', 'Bridge/Major Culvert', 'Bridge')) 
      and (a.inspectiontype = 'Level 1 Inspection' or b.inspectiontype = 'Level 1 Inspection')
)
select 
  s.inspection_id, 
  s.assetid, 
  s.assettypename, 
  s.completeduser, 
  s.completed_date_datetime as completed_date, 
  s.completed_date_datetime, 
  s.previous_completed_date, 
  s.days_to_due_date, 
  s.inspection_status, 
  s.inspectiontype, 
  s.inspection_comments, 
  s.inspection_hyperlink, 
  s.inspection_colour, 
  if(duedate is null, completed_date_datetime, duedate) as due_date, 
  if(completed_date_datetime is null, 'Not Inspected', 'Inspected') as inspected_binary,
  /*
  case
    when days_to_due_date = 'Inspected' then null
    when days_to_due_date like '%day(s) late' then null
    when datediff(duedate, convert_timezone('Australia/Sydney', getdate()))< 0 then null
    else days_to_due_date
  end as days_to_due_date_int,
  */
  case
      when completed_date_datetime is not null then datediff(due_date,completed_date_datetime)
      when completed_date_datetime is null then datediff(due_date, convert_timezone('Australia/Sydney', getdate()))
  end as days_to_due_date_int, --positive means on time.
  if((month(completed_date_datetime)>=month(due_date)) or (completed_date_datetime is null),'current','superseded') as superseded_status
from selection s
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `inspection_id` | `int` | Yes |  |
| `assetid` | `int` | Yes |  |
| `assettypename` | `string` | Yes |  |
| `completeduser` | `string` | Yes |  |
| `completed_date` | `date` | Yes |  |
| `completed_date_datetime` | `date` | Yes |  |
| `previous_completed_date` | `date` | Yes |  |
| `days_to_due_date` | `string` | Yes |  |
| `inspection_status` | `string` | No |  |
| `inspectiontype` | `string` | Yes |  |
| `inspection_comments` | `string` | Yes |  |
| `inspection_hyperlink` | `string` | Yes |  |
| `inspection_colour` | `string` | Yes |  |
| `due_date` | `date` | Yes |  |
| `inspected_binary` | `string` | No |  |
| `days_to_due_date_int` | `int` | Yes |  |
| `superseded_status` | `string` | No |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
