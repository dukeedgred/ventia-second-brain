---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_inspection_cathodic_protection
full-name: transport_dev.transport_wru.uvw_inspection_cathodic_protection
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_inspection_cathodic_protection

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_inspection_cathodic_protection` |
| Full name | `transport_dev.transport_wru.uvw_inspection_cathodic_protection` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 20 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | inspection / audit / condition |
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-06-18T14:22:27.158Z; Last altered: 2024-09-24T01:42:49.325Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
with selection as (
SELECT
  a.id as inspection_id, a.inspection_hyperlink,
  coalesce(a.assetid, b.assetid) as assetid, coalesce(a.assettypename, b.assettypename) as assettypename, a.completeduser, 
  coalesce(a.code, b.code) as code,
  a.completed_date as completed_date_datetime, 
  b.completed_date as previous_completed_date,
  ADD_MONTHS(b.completed_date,12) as duedate,
  IF(isnotnull(completed_date_datetime) and ((completed_date_datetime <= duedate) or (isnotnull(completed_date_datetime) and isnull(duedate))),  "Inspected", 
    IF(isnotnull(completed_date_datetime) and (completed_date_datetime > duedate), concat(string(datediff(completed_date_datetime,duedate))," day(s) late"),
    IF(datediff(duedate, convert_timezone('Australia/Sydney', getdate()))< 0, concat(string(datediff(duedate, convert_timezone('Australia/Sydney', getdate())))," days overdue"), datediff(duedate, convert_timezone('Australia/Sydney', getdate()))))) as days_to_due_date,
  --IF(isnull(completed_date_datetime), 'Not Inspected', date_format(completed_date_datetime,'yyyy/MM/dd')) as completed_date,
  coalesce(a.inspectiontype, b.inspectiontype) as inspectiontype,
  a.inspection_comments,
  case 
    when completed_date_datetime is not null and ((completed_date_datetime <= duedate) or (completed_date_datetime is not null and duedate is null)) then  "On time"
    when completed_date_datetime is not null and (completed_date_datetime > duedate) then "Late"
    when datediff(duedate, convert_timezone('Australia/Sydney', getdate()))< 0 then "Overdue" 
    when completed_date_datetime is null then "Upcoming"
    else "undefined"
  end as inspection_status,
  case 
    when completed_date_datetime is not null and ((completed_date_datetime <= duedate) or (completed_date_datetime is not null and duedate is null)) then  "#008000"
    when completed_date_datetime is not null and (completed_date_datetime > duedate) then "#FF5733"
    when datediff(duedate, convert_timezone('Australia/Sydney', getdate()))< 0 then "#FF0000" -- red
    when completed_date_datetime is null then "#118DFF" -- blue
    else "undefined"
  end as inspection_colour
from transport_dev.transport_wru.uvw_inspection_completions a
  full join transport_dev.transport_wru.uvw_inspection_completions b 
    on (a.rn = b.rn+1) and (a.assetid = b.assetid) 
    and (a.inspectiontype = b.inspectiontype)
where (a.assettypename in ('Retaining Wall', 'Major Sign Structure', 'Noise Wall', 'Bridge/Major Culvert', 'Bridge') or b.assettypename in ('Retaining Wall', 'Major Sign Structure', 'Noise Wall', 'Bridge/Major Culvert', 'Bridge')) 
      and (a.inspectiontype = 'Cathodic Protection' or b.inspectiontype = 'Cathodic Protection')
)
select 
  row_number() over (order by  assetid, if(completed_date_datetime is null, 'N', 'Y'), completed_date_datetime) as rn,   
  completed_date_datetime as completed_date, 
  selection.*, 
  if(duedate is null, completed_date_datetime, duedate) as due_date, 
  if(completed_date is null, 0, 1) as inspected_binary,
  if((month(completed_date_datetime)>=month(due_date)) or (isnull(completed_date_datetime)) ,'current','superseded') as superseded_status, 
  /*case
    when days_to_due_date = 'Inspected' then null
    when days_to_due_date like '%day(s) late' then null
    when datediff(duedate, convert_timezone('Australia/Sydney', getdate()))< 0 then null
    else days_to_due_date
  end as days_to_due_date_int */
  case
      when completed_date_datetime is not null then datediff(due_date,completed_date_datetime)
      when completed_date_datetime is null then datediff(due_date, convert_timezone('Australia/Sydney', getdate()))
  end as days_to_due_date_int --positive means on time.
from selection
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `rn` | `int` | No |  |
| `completed_date` | `date` | Yes |  |
| `inspection_id` | `int` | Yes |  |
| `inspection_hyperlink` | `string` | Yes |  |
| `assetid` | `int` | Yes |  |
| `assettypename` | `string` | Yes |  |
| `completeduser` | `string` | Yes |  |
| `code` | `string` | Yes |  |
| `completed_date_datetime` | `date` | Yes |  |
| `previous_completed_date` | `date` | Yes |  |
| `duedate` | `date` | Yes |  |
| `days_to_due_date` | `string` | Yes |  |
| `inspectiontype` | `string` | Yes |  |
| `inspection_comments` | `string` | Yes |  |
| `inspection_status` | `string` | No |  |
| `inspection_colour` | `string` | No |  |
| `due_date` | `date` | Yes |  |
| `inspected_binary` | `int` | No |  |
| `superseded_status` | `string` | No |  |
| `days_to_due_date_int` | `int` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
