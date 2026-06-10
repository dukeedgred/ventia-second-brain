---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_jeopardy_board
full-name: transport_dev.transport_wru.uvw_jeopardy_board
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_jeopardy_board

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_jeopardy_board` |
| Full name | `transport_dev.transport_wru.uvw_jeopardy_board` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 23 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-08-30T01:32:21.492Z; Last altered: 2024-09-24T01:42:44.2Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
  select a.id as job_id,activitycode as activity_code, activitytype as activity_type, assetcode as asset_code, assetname as asset_name, a.AssetTypeName, assigneduser as assigned_to, 
  a.classification, createddate as created_date, duedate as due_date, interventioncode as intervention_code,  
  parentassetname as parent_asset_name, parentassetcode, completedstatus as status, 
  CASE 
    WHEN parentassetname is null THEN assetname 
    ELSE parentassetname 
  END location_, 
  ROUND(TIMESTAMPDIFF(MINUTE, from_utc_timestamp(current_timestamp(), 'Australia/Sydney'), a.duedate), 2) AS time_to_due_mins,
case 
    when time_to_due_mins < 0 then "0. Over due"
    when time_to_due_mins <=120 then  "1. Less than 2 hours"
    when time_to_due_mins <= 1440 then  "2. Less than 1 day"
    when time_to_due_mins <= 2880 then "3. Less than 2 days"
    when time_to_due_mins <= 10080 then "4. Less than 7 days"
    else "5. Less than 2 weeks"
end 
    as Jeopardy_Category,
case
      when time_to_due_mins < 0 then "Overdue"
      when time_to_due_mins <= 120
      and time_to_due_mins >= 0 then "In Jeopardy"
      else "Up Coming"
    end as jeopardy_status

 , "https://vicroads.assetvision.com.au/Maintenance/ViewJob/" || Job_ID as job_hyperlink,
  case
    when time_to_due_mins <= 1440 and time_to_due_mins >= 60 then floor(time_to_due_mins/60)|| "h " || (time_to_due_mins%60) || "m " -- 1440 is no. mins in a day
    when time_to_due_mins < 60 and time_to_due_mins >= 0 then floor(time_to_due_mins/60)|| "h " || (time_to_due_mins%60) || "m " -- 1440 is no. mins in a day
    when time_to_due_mins < 0 and time_to_due_mins > -60 then (time_to_due_mins%60) || "m " -- 1440 is no. mins in a day
    when time_to_due_mins <= -60 and time_to_due_mins >= -1440 then ceiling(time_to_due_mins/60)|| "h " || -1*(time_to_due_mins%60) || "m " -- 1440 is no. mins in a day
    when time_to_due_mins > 1440 then floor(time_to_due_mins/60/24) || "d " || floor(time_to_due_mins/60)%24|| "h " || (time_to_due_mins%60) || "m "
    else ceiling(time_to_due_mins/60/24) || "d " || -1*ceiling(time_to_due_mins/60)%24|| "h " || -1*(time_to_due_mins%60) || "m "
  end as time_to_due_str,
  case 
      when b.wkt_Type = "GEOMETRYCOLLECTION" THEN NULL --currently cannot represent geometry collection in power bi as far as I know
      else b.wkt
  end as wkt
    ,b.start_longitude, b.start_latitude

  from 
    transport_dev.transport_wru.uvw_job a
    join transport_dev.transport_wru.uvw_asset c on a.assetid = c.id
    join transport_dev.transport_wru.uvw_job_geom b on a.id = b.id
 where
    ROUND(TIMESTAMPDIFF(MINUTE, from_utc_timestamp(current_timestamp(), 'Australia/Sydney'), a.duedate), 2) <= 20160
    and ROUND(TIMESTAMPDIFF(MINUTE, from_utc_timestamp(current_timestamp(), 'Australia/Sydney'), a.duedate), 2) >= -10080
    and a.completedstatus = 'Open'
    and a.mergedjobid is null
    and a.activitytype in ('Defect', 'Hazard')
    and a.assigneduser <> 'VEN - Phil Thiel'
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `job_id` | `int` | Yes |  |
| `activity_code` | `string` | Yes |  |
| `activity_type` | `string` | Yes |  |
| `asset_code` | `string` | Yes |  |
| `asset_name` | `string` | Yes |  |
| `AssetTypeName` | `string` | Yes |  |
| `assigned_to` | `string` | Yes |  |
| `classification` | `string` | Yes |  |
| `created_date` | `timestamp` | Yes |  |
| `due_date` | `timestamp` | Yes |  |
| `intervention_code` | `string` | Yes |  |
| `parent_asset_name` | `string` | Yes |  |
| `parentassetcode` | `string` | Yes |  |
| `status` | `string` | Yes |  |
| `location_` | `string` | Yes |  |
| `time_to_due_mins` | `bigint` | Yes |  |
| `Jeopardy_Category` | `string` | No |  |
| `jeopardy_status` | `string` | No |  |
| `job_hyperlink` | `string` | Yes |  |
| `time_to_due_str` | `string` | Yes |  |
| `wkt` | `string` | Yes |  |
| `start_longitude` | `float` | Yes |  |
| `start_latitude` | `float` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
