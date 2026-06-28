---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_jeopardy_board_jobs
full-name: transport_dev.transport_wru.uvw_jeopardy_board_jobs
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_jeopardy_board_jobs

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_jeopardy_board_jobs` |
| Full name | `transport_dev.transport_wru.uvw_jeopardy_board_jobs` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 22 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | jobs / work orders |
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-06-18T02:53:54.99Z; Last altered: 2024-09-24T01:42:58.231Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
  select activitycode as activity_code, activitytype as activity_type, assetcode as asset_code, assetname as asset_name, assettype, assigneduser as assigned_to, 
  classification, createddate as created_date, duedate as due_date, interventioncode as intervention_code, id as job_id, 
  parentassetname as parent_asset_name, parentassetcode, completedstatus as status, 
  CASE 
    WHEN parentassetname is null THEN assetname 
    ELSE parentassetname 
  END location_, 
  ROUND(TIMESTAMPDIFF(MINUTE, from_utc_timestamp(current_timestamp(), 'Australia/Sydney'), duedate), 2) AS time_to_due_mins,
  case 
    when time_to_due_mins < 0 then "Overdue"
    when time_to_due_mins <= 120 and time_to_due_mins >=0 then "In Jeopardy"
    else "Up Coming"
  end as jeopardy_status,
  "https://vicroads.assetvision.com.au/Maintenance/ViewJob/" || Job_ID as job_hyperlink,
  CASE 
        WHEN ROUND(TIMESTAMPDIFF(MINUTE,from_utc_timestamp(current_timestamp(),'Australia/Sydney'), duedate),2) <= 120 and 
          ROUND(TIMESTAMPDIFF(MINUTE,from_utc_timestamp(current_timestamp(),'Australia/Sydney'), duedate),2) >0 and
          completedstatus = 'Open'
          and assigneduser<>"VEN - Phil Thiel" THEN 1
        ELSE 0
  END as job_in_jeopardy_flag,  -- jobs due in the next 2 hours
  CASE 
        WHEN ROUND(TIMESTAMPDIFF(MINUTE,from_utc_timestamp(current_timestamp(),'Australia/Sydney'), duedate),2) < 0 and 
          completedstatus = 'Open'
          and assigneduser<>"VEN - Phil Thiel" THEN 1
        ELSE 0
  end as job_overdue_flag,
  case
    when time_to_due_mins <= 1440 and time_to_due_mins >= 60 then floor(time_to_due_mins/60)|| "h " || (time_to_due_mins%60) || "m " -- 1440 is no. mins in a day
    when time_to_due_mins < 60 and time_to_due_mins >= 0 then floor(time_to_due_mins/60)|| "h " || (time_to_due_mins%60) || "m " -- 1440 is no. mins in a day
    when time_to_due_mins < 0 and time_to_due_mins > -60 then (time_to_due_mins%60) || "m " -- 1440 is no. mins in a day
    when time_to_due_mins <= -60 and time_to_due_mins >= -1440 then ceiling(time_to_due_mins/60)|| "h " || -1*(time_to_due_mins%60) || "m " -- 1440 is no. mins in a day
    when time_to_due_mins > 1440 then floor(time_to_due_mins/60/24) || "d " || floor(time_to_due_mins/60)%24|| "h " || (time_to_due_mins%60) || "m "
    else ceiling(time_to_due_mins/60/24) || "d " || -1*ceiling(time_to_due_mins/60)%24|| "h " || -1*(time_to_due_mins%60) || "m "
  end as time_to_due_str,
  case 
      when left(wkt, 18) = "GEOMETRYCOLLECTION" THEN NULL --currently cannot represent geometry collection in power bi as far as I know
      else wkt
  end as wkt
  

  from (select a.*, b.parentassetname, b.parentassetcode, b.assettype from ext_mssql_asset_vision_ven_vicroads.dbo.vjob a
        join ext_mssql_asset_vision_ven_vicroads.dbo.asset b
        on a.assetid = b.id
        where a.contract = "Western Roads Upgrade (WRU)"
        and a.deleted is false
        and activitytype in ('Defect', 'Hazard')
        and mergedjobid is null
        and b.stage = "Active"
        and a.deleted = False
        and b.deleted = False
        and ROUND(TIMESTAMPDIFF(MINUTE, from_utc_timestamp(current_timestamp(), 'Australia/Sydney'), duedate), 2) > -10080
        and completedstatus = "Open")
  order by duedate asc
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `activity_code` | `string` | Yes |  |
| `activity_type` | `string` | Yes |  |
| `asset_code` | `string` | Yes |  |
| `asset_name` | `string` | Yes |  |
| `assettype` | `string` | Yes |  |
| `assigned_to` | `string` | Yes |  |
| `classification` | `string` | Yes |  |
| `created_date` | `timestamp` | Yes |  |
| `due_date` | `timestamp` | Yes |  |
| `intervention_code` | `string` | Yes |  |
| `job_id` | `int` | Yes |  |
| `parent_asset_name` | `string` | Yes |  |
| `parentassetcode` | `string` | Yes |  |
| `status` | `string` | Yes |  |
| `location_` | `string` | Yes |  |
| `time_to_due_mins` | `bigint` | Yes |  |
| `jeopardy_status` | `string` | No |  |
| `job_hyperlink` | `string` | Yes |  |
| `job_in_jeopardy_flag` | `int` | No |  |
| `job_overdue_flag` | `int` | No |  |
| `time_to_due_str` | `string` | Yes |  |
| `wkt` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
