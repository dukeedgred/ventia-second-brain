---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_timesheet
full-name: transport_dev.transport_wru.uvw_timesheet
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-table, databricks, transport-wru, timesheet]
---

# Transport Table - transport_wru - uvw_timesheet

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_timesheet` |
| Full name | `transport_dev.transport_wru.uvw_timesheet` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 21 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | timesheet |
| Related tables/reports | `ext_mssql_asset_vision_ven_vicroads.dbo.timesheetitem`, `transport_dev.transport_wru.uvw_job` |

## View Query

```sql
with timesheet as (
  select
    case
      when int(date_format(timesheetcreateddate, 'H')) >= 20 or int(date_format(timesheetcreateddate, 'H')) <= 7 then 'Night'
      else 'Day'
    end as Shift_Type,
    case
      when int(date_format(timesheetcreateddate, 'H')) <= 7 then to_Date(date_format(dateadd(Day, -1, timesheetcreateddate), 'yyyy-MM-dd'))
      else to_Date(date_format(timesheetcreateddate, 'yyyy-MM-dd'))
    end as Shift_Date,
    timestampadd(MINUTE, -1 * (a.hours * 60 + a.minutes), timesheetcreateddate) as timesheet_start,
    timestamp(a.timesheetcreateddate) timesheet_end,
    b.activitycategorycode,
    b.activitycategoryname,
    b.activitycode,
    b.activityname,
    b.activitytype,
    a.id,
    a.timesheetid,
    a.timesheetcreateduser,
    a.sourcetableid as Job_ID,
    a.timesheettypename,
    a.hours + (a.minutes / 60) as job_Duration_hrs,
    a.hours * 60 + a.minutes as job_Duration_minutes,
    case
      when a.hours = '' then 0
      else int(a.hours)
    end as hours,
    case
      when a.minutes = '' then 0
      else int(a.minutes)
    end as minutes,
    a.resourcecode as EmployeeNo,
    a.resourcename as Employee_Name
  from
    ext_mssql_asset_vision_ven_vicroads.dbo.timesheetitem a
    join transport_dev.transport_wru.uvw_job b on a.sourcetableid = b.id
  where
    timesheettypename = 'Employees'
    and a.deleted is false
    and a.sourcetable = 'Job'
    and a.resourcecode <> ''
)
select
  row_number() over(partition by Shift_date, EmployeeNo order by timesheet_start) as rn,
  *
from
  timesheet
order by
  Shift_date,
  EmployeeNo,
  timesheet_start
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `rn` | `int` | No |  |
| `Shift_Type` | `string` | No |  |
| `Shift_Date` | `date` | Yes |  |
| `timesheet_start` | `timestamp` | Yes |  |
| `timesheet_end` | `timestamp` | Yes |  |
| `activitycategorycode` | `string` | Yes |  |
| `activitycategoryname` | `string` | Yes |  |
| `activitycode` | `string` | Yes |  |
| `activityname` | `string` | Yes |  |
| `activitytype` | `string` | Yes |  |
| `id` | `int` | Yes |  |
| `timesheetid` | `int` | Yes |  |
| `timesheetcreateduser` | `string` | Yes |  |
| `Job_ID` | `int` | Yes |  |
| `timesheettypename` | `string` | Yes |  |
| `job_Duration_hrs` | `double` | Yes |  |
| `job_Duration_minutes` | `int` | Yes |  |
| `hours` | `int` | Yes |  |
| `minutes` | `int` | Yes |  |
| `EmployeeNo` | `string` | Yes |  |
| `Employee_Name` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
