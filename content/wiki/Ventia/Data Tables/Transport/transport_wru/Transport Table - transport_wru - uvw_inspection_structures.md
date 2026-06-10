---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_inspection_structures
full-name: transport_dev.transport_wru.uvw_inspection_structures
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_inspection_structures

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_inspection_structures` |
| Full name | `transport_dev.transport_wru.uvw_inspection_structures` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 23 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | inspection / audit / condition |
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-06-19T02:24:20.764Z; Last altered: 2024-09-24T01:42:51.903Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
with sq2 as (
  with inspection_completions as(
    with selection as (
      with inspection_typesnormalised AS (
        SELECT
          id,
          assettypename,
          assetid,
          completeddate as completed_date,
          scheduleddate as scheduled_date,
          completeduser,
          jobid,
          CASE
            when inspectiontypename like "%Level 1 Inspection%" then "Level 1 Inspection"
            when inspectiontypename = "Event Inspection -Structures Level 1" then "Level 1 Inspection - Event"
            when inspectiontypename like "%Level 2 Inspection" then "Level 2 Inspection"
            when inspectiontypename like "%Level 3 Inspection" then "Level 3 Inspection"
            else inspectiontypename
          END as inspectiontype,
          comments
        FROM
          transport_dev.transport_wru.uvw_inspection
        where
          completeduser <> "VicRoads"
          and assettypename in (
            'Retaining Wall',
            'Major Sign Structure',
            'Noise Wall',
            'Bridge/Major Culvert',
            'Bridge'
          ) --and completeduser is not null
      )
      select
        row_number() over (
          PARTITION BY assetid,
          inspectiontype
          ORDER BY
            if(completed_date = '' or completed_date is null, 1, 0),
            completed_date asc,
            scheduled_date asc
        ) as rn, 
        /*
        (
          lead(scheduled_date) over (
            PARTITION BY assetid,
            inspectiontype
            ORDER BY
              if(
                completed_date = ''
                or completed_date is null,
                1,
                0
              ),
              completed_date
          )
        ) as leaddate,
        (
          lag(completed_date) over (
            PARTITION BY assetid,
            inspectiontype
            ORDER BY
              if(
                completed_date = ''
                or completed_date is null,
                1,
                0
              ),
              completed_date
          )
        ) as lagdate,
        case
          when inspectiontype = "Level 1 Inspection" then if(
            lagdate is null,
            completed_date,
            add_months(lagdate, 6)
          )
          when inspectiontype = "Level 2 Inspection" then if(
            lagdate is null,
            completed_date,
            add_months(lagdate, 36)
          )
          when inspectiontype = "Cathodic Protection" then if(
            lagdate is null,
            completed_date,
            add_months(lagdate, 12)
          )
        end as due_date_temp,
        CASE
          when inspectiontype = "Level 2 Inspection"
          and quarter(due_date_temp) = 1 then date(concat(string(year(due_date_temp)), '-3-31'))
          when inspectiontype = "Level 2 Inspection"
          and quarter(due_date_temp) = 2 then date(concat(string(year(due_date_temp)), '-6-30'))
          when inspectiontype = "Level 2 Inspection"
          and quarter(due_date_temp) = 3 then date(concat(string(year(due_date_temp)), '-9-30'))
          when inspectiontype = "Level 2 Inspection"
          and quarter(due_date_temp) = 4 then date(concat(string(year(due_date_temp)), '-12-31'))
          else due_date_temp
        END as due_date,
        case
          when inspectiontype = "Level 1 Inspection" then add_months(completed_date, 6)
          when inspectiontype = "Level 2 Inspection" then date(concat(string(year(completed_date) + 3), '-06-30'))
          when inspectiontype = "Cathodic Protection" then add_months(completed_date, 12)
        end as next_due_date, */
        id,
        assettypename,
        assetid,
        completed_date,
        completeduser,
        inspectiontype, 
        jobid,
        comments as  inspection_comments
      from
        inspection_typesnormalised
      where
        completed_date is not null
    )
    select
      rn,
      selection.id as inspection_id,
      concat(
        "https://vicroads.assetvision.com.au/Inspections/ViewInspection/",
        string(selection.id)
      ) as inspection_hyperlink,
      uvw_asset_register.assettype,
      assetid,
      uvw_asset_register.structure_name,
      completed_date,
      --scheduled_date,
      completeduser,
      inspectiontype,
      --due_date,
      --next_due_date,
      selection.inspection_comments,
      stage,
      uvw_asset_register.spatialinfo,
      --lagdate as previous_completed_date,
      jobid,
      bridge_function,
      structure_ID
    from
      selection
      join transport_dev.transport_wru.uvw_asset_register on uvw_asset_register.id = selection.assetid --where asset_register.stage = "Active"
      --where --not (completed_date is null and (quarter(scheduled_date) = quarter(lagdate) and year(scheduled_date) = year(lagdate))) --and assettypename in ("Level 1 Inspection", "Event Inspection -Structures Level 1", "Level 2 Inspection", "Complex Level 2 Inspection", "Level 3 Inspection", "Cathodic Protection", "Settlement Monitoring – B&MC")
  )
  SELECT
    a.inspection_id as inspection_id,
    a.inspection_hyperlink,
    coalesce(a.assetid, b.assetid) as assetid,
    coalesce(a.assettype, b.assettype) as assettype,
    coalesce(a.inspectiontype, b.inspectiontype) as inspectiontype,
    a.completeduser,
    coalesce(a.stage, b.stage) as stage,
    coalesce(a.spatialinfo, b.spatialinfo) as spatialinfo,
    coalesce(a.structure_name, b.structure_name) as structure_name,
    coalesce(a.bridge_function, b.bridge_function) as bridge_function,
    coalesce(a.structure_ID, b.structure_ID) as structure_ID,
    a.completed_date as completed_date,
    b.inspection_hyperlink as previous_inspection_hyperlink,
    b.inspection_id as previous_inspection_id,
    b.completed_date as previous_completed_date, 
    case
      when b.completed_date is not null and (a.inspectiontype = 'Level 1 Inspection' or b.inspectiontype = 'Level 1 Inspection') then ADD_MONTHS(b.completed_date, 6)
      when b.completed_date is not null and (a.inspectiontype = 'Level 2 Inspection' or b.inspectiontype = 'Level 2 Inspection') then ADD_MONTHS(b.completed_date, 36)
      when b.completed_date is not null and (a.inspectiontype = 'Cathodic Protection' or b.inspectiontype = 'Cathodic Protection') then ADD_MONTHS(b.completed_date, 12)
      when a.inspectiontype in ('Settlement Monitoring – B&MC', 'Level 3 Inspection', 'Ad hoc Inspection - Bridge', 'Noise Wall Inspection')
        or b.inspectiontype in ('Settlement Monitoring – B&MC', 'Level 3 Inspection', 'Ad hoc Inspection - Bridge', 'Noise Wall Inspection') then null
      else a.completed_date
    end as due_date_temp,
    a.inspection_comments
  FROM
    inspection_completions a 
    FULL JOIN inspection_completions b ON (a.rn = b.rn + 1)
    and (a.assetid = b.assetid)
    and (a.inspectiontype = b.inspectiontype)
  WHERE
    (a.assettype in ('Retaining Wall', 'Major Sign Structure', 'Noise Wall', 'Bridge', 'Major Culvert')
      or b.assettype in ('Retaining Wall', 'Major Sign Structure', 'Noise Wall', 'Bridge', 'Major Culvert'))
) 
select
  s.inspection_id,
  s.inspection_hyperlink,
  s.inspectiontype,
  s.assetid,
  s.assettype,
  s.completeduser,
  s.completed_date,
  s.previous_inspection_id,
  s.previous_inspection_hyperlink,
  s.previous_completed_date,
  s.inspection_comments,
  if(s.completed_date is null, 'N', 'Y') as inspected_binary,
  stage,
  structure_name,
  spatialinfo,
  bridge_function,
  structure_ID,
  case --need to order cathodic protection records by 2 assetid id and completed_date
    when inspectiontype = "Cathodic Protection" then row_number() over (partition by inspectiontype order by assetid, if(completed_date is null, 0,1) desc, completed_date asc)
    else null
  end as order_col,
  case
    when inspectiontype = 'Level 2 Inspection' then case
      when quarter(due_date_temp) = 1 then date(concat(string(year(due_date_temp)), '-3-31'))
      when quarter(due_date_temp) = 2 then date(concat(string(year(due_date_temp)), '-6-30'))
      when quarter(due_date_temp) = 3 then date(concat(string(year(due_date_temp)), '-9-30'))
      when quarter(due_date_temp) = 4 then date(concat(string(year(due_date_temp)), '-12-31'))
    end
    else date(due_date_temp)
  end as due_date,
  case
    when s.completed_date is not null and ((date(s.completed_date) <= date(due_date)) or (s.completed_date is not null and due_date is null)) then "On time"
    when s.completed_date is not null and (date(s.completed_date) > date(due_date)) then "Late" 
    when datediff(date(due_date),  date(convert_timezone('Australia/Sydney', getdate()))) < 0 then "Overdue"
    when s.completed_date is null then "Upcoming"
    else "undefined"
  end as inspection_status,
  case
    when inspection_status = "On time" then "#008000"
    when inspection_status = "Late" then "#FF5733"
    when inspection_status = "Overdue" then "#FF0000" -- red
    when inspection_status = "Upcoming" then "#118DFF" -- blue
    else "undefined"
  end as inspection_colour,
  case
    when completed_date is not null then datediff(date(due_date), date(completed_date))
    when completed_date is null then datediff(date(due_date), date(convert_timezone('Australia/Sydney', getdate())))
  end as days_to_due_date_int,
  --positive means before due date (ie on time).
  case
    --if completed before the due month/quarter (depending on inspectiontype) then classify as 'superseded' inspection, as due_date is now innacurate
    when inspectiontype = 'Level 1 Inspection' and (month(completed_date) >= month(due_date) and year(completed_date) >= year(due_date) or completed_date is null) then 'current'
    when inspectiontype = 'Level 2 Inspection' and (quarter(completed_date) >= quarter(due_date) and year(completed_date) >= year(due_date) or completed_date is null) then 'current'
    when inspectiontype = 'Cathodic Protection' and (month(completed_date) >= month(due_date) and year(completed_date) >= year(due_date) or completed_date is null) then 'current'
    when inspectiontype in ('Level 3 Inspection', 'Settlement Monitoring') then 'current'
    else 'superseded'
  end as superseded_status
from
  sq2 s
where
  (
    completed_date is not null
    or due_date_temp is not null
  )
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `inspection_id` | `int` | Yes |  |
| `inspection_hyperlink` | `string` | Yes |  |
| `inspectiontype` | `string` | Yes |  |
| `assetid` | `int` | Yes |  |
| `assettype` | `string` | Yes |  |
| `completeduser` | `string` | Yes |  |
| `completed_date` | `timestamp` | Yes |  |
| `previous_inspection_id` | `int` | Yes |  |
| `previous_inspection_hyperlink` | `string` | Yes |  |
| `previous_completed_date` | `timestamp` | Yes |  |
| `inspection_comments` | `string` | Yes |  |
| `inspected_binary` | `string` | No |  |
| `stage` | `string` | Yes |  |
| `structure_name` | `string` | Yes |  |
| `spatialinfo` | `string` | Yes |  |
| `bridge_function` | `string` | Yes |  |
| `structure_ID` | `string` | Yes |  |
| `order_col` | `int` | Yes |  |
| `due_date` | `date` | Yes |  |
| `inspection_status` | `string` | No |  |
| `inspection_colour` | `string` | No |  |
| `days_to_due_date_int` | `int` | Yes |  |
| `superseded_status` | `string` | No |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
