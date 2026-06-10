---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_inspections_level_2
full-name: transport_dev.transport_wru.uvw_inspections_level_2
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_inspections_level_2

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_inspections_level_2` |
| Full name | `transport_dev.transport_wru.uvw_inspections_level_2` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 18 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | inspection / audit / condition |
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-06-19T02:37:28.539Z; Last altered: 2024-09-24T01:42:48.528Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
with selection as (
  SELECT 
    a.id as inspection_id, 
    a.inspection_hyperlink,
    coalesce(a.assetid, b.assetid) as assetid, 
    coalesce(a.assettypename, b.assettypename) as assettypename,
    a.completeduser,
    a.completed_date as completed_date_datetime,
    b.completed_date as previous_completed_date,
    if(b.completed_date is null, completed_date_datetime, ADD_MONTHS(b.completed_date,36)) as due_date_temp,
    a.inspection_comments
  FROM transport_dev.transport_wru.uvw_inspection_completions a
  FULL JOIN transport_dev.transport_wru.uvw_inspection_completions b
    ON (a.rn = b.rn + 1) and (a.assetid = b.assetid) and (a.inspectiontype = b.inspectiontype)
  WHERE (a.assettypename in ('Retaining Wall', 'Major Sign Structure', 'Noise Wall', 'Bridge/Major Culvert', 'Bridge') or b.assettypename in ('Retaining Wall', 'Major Sign Structure', 'Noise Wall', 'Bridge/Major Culvert', 'Bridge'))
    and (a.inspectiontype = 'Level 2 Inspection' or b.inspectiontype = 'Level 2 Inspection') 
)
SELECT 
  selection.*, 
  case 
    when (quarter(completed_date_datetime) > quarter(due_date_temp)) or (year(completed_date_datetime) > year(due_date_temp)) 
      then add_months(lag(due_date_temp) over (PARTITION BY assetid ORDER BY if(completed_date_datetime = '' or completed_date_datetime is null,1,0),completed_date_datetime),36) --when inspection is late
    else due_date_temp --when inspection is on time or early/superseded
  end as due_date,
  --IF(isnull(completed_date_datetime), 'Not Inspected', date_format(completed_date_datetime,'yyyy/MM/dd')) as completed_date,
  completed_date_datetime as completed_date,
  if(completed_date is null, 'N', 'Y') as inspected_binary,
  CASE
    when quarter(due_date) = 1 then date(concat(string(year(due_date)), '-3-31'))
    when quarter(due_date) = 2 then date(concat(string(year(due_date)), '-6-30'))
    when quarter(due_date) = 3 then date(concat(string(year(due_date)), '-9-30'))
    when quarter(due_date) = 4 then date(concat(string(year(due_date)), '-12-31'))
  END as due_date_quarter,
  if((quarter(completed_date_datetime)>=quarter(due_date) and year(completed_date_datetime)>=year(due_date)) or (isnull(completed_date_datetime)) ,'current','superseded') as superseded_status, --or (due_date_quarter < convert_timezone('Australia/Sydney', getdate()))
  IF(isnotnull(completed_date_datetime) and ((completed_date_datetime <= due_date_quarter) or (isnotnull(completed_date_datetime) and isnull(due_date_quarter))),  "Inspected",
    IF(isnotnull(completed_date_datetime) and (completed_date_datetime > due_date_quarter), concat(string(datediff(completed_date_datetime,due_date_quarter))," day(s) late"),
    IF(datediff(due_date_quarter, convert_timezone('Australia/Sydney', getdate()))< 0, "Overdue", datediff(due_date_quarter, convert_timezone('Australia/Sydney', getdate()))))) as days_to_due_date,
  /*
  case
    when ((completed_date_datetime is not null) and (completed_date_datetime <= due_date_quarter or ((completed_date_datetime is not null) and (due_date_quarter is null)))) then null
    when ((completed_date_datetime is not null) and (completed_date_datetime > due_date_quarter)) then null
    when datediff(due_date_quarter, convert_timezone('Australia/Sydney', getdate())) <0 then null
    else datediff(due_date_quarter, convert_timezone('Australia/Sydney', getdate()))
  end as days_to_due_date_int*/
  case 
      when completed_date_datetime is not null and ((completed_date_datetime <= due_date_quarter) or (completed_date_datetime is not null and due_date_quarter is null)) then  "On time"
      when completed_date_datetime is not null and (completed_date_datetime > due_date_quarter) then "Late"
      when datediff(due_date_quarter, convert_timezone('Australia/Sydney', getdate()))< 0 then "Overdue" 
      when completed_date_datetime is null then "Upcoming"
      else "undefined"
    end as inspection_status,
  case 
      when inspection_status = "On time" then  "#008000"
      when inspection_status = "Late" then "#FF5733"
      when inspection_status = "Overdue" then "#FF0000" -- red
      when inspection_status = "Upcoming" then "#118DFF" -- blue
      else "undefined"
  end as inspection_colour,
  case
      when completed_date_datetime is not null then datediff(due_date_quarter,completed_date_datetime)
      when completed_date_datetime is null then datediff(due_date_quarter, convert_timezone('Australia/Sydney', getdate()))
    end as days_to_due_date_int --positive means on time.
from selection
where (due_date_temp IS NOT NULL or completed_date_datetime IS NOT NULL)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `inspection_id` | `int` | Yes |  |
| `inspection_hyperlink` | `string` | Yes |  |
| `assetid` | `int` | Yes |  |
| `assettypename` | `string` | Yes |  |
| `completeduser` | `string` | Yes |  |
| `completed_date_datetime` | `date` | Yes |  |
| `previous_completed_date` | `date` | Yes |  |
| `due_date_temp` | `date` | Yes |  |
| `inspection_comments` | `string` | Yes |  |
| `due_date` | `date` | Yes |  |
| `completed_date` | `date` | Yes |  |
| `inspected_binary` | `string` | No |  |
| `due_date_quarter` | `date` | Yes |  |
| `superseded_status` | `string` | No |  |
| `days_to_due_date` | `string` | Yes |  |
| `inspection_status` | `string` | No |  |
| `inspection_colour` | `string` | No |  |
| `days_to_due_date_int` | `int` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
