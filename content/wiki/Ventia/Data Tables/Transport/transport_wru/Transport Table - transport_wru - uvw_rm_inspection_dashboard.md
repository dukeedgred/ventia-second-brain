---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_rm_inspection_dashboard
full-name: transport_dev.transport_wru.uvw_rm_inspection_dashboard
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_rm_inspection_dashboard

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_rm_inspection_dashboard` |
| Full name | `transport_dev.transport_wru.uvw_rm_inspection_dashboard` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 62 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | inspection / audit / condition |
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-07-01T23:08:22.764Z; Last altered: 2024-09-24T01:42:40.934Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
( 
with cte as (
    select distinct kpi_unique_id, assetname||" " ||assetcode|| " Defects", assettypename, assetcode, assetname, section, direction from 
      (
      select assetcode, assetcode|| direction||section as kpi_unique_id, --a way to differentiate between roads/sections/directions, as a road asset can be comprised of 2 directions and multiple sections
      assettypename, section, direction, assetname from ext_mssql_asset_vision_ven_vicroads.dbo.inspection 
      where assettypename in ("Road", "Pit") and deleted = false
      and year(createddate)=2024
      )
),
cte1 as (
    SELECT
    id,
    deltautc,
    modifiedutc,
    assettypename,
    assetid,
    assetcode,
    assetname,
    section,
    case
      when assetcode = 5042 and section = "Cat 2" then "RMC 2"
      when assetcode = 5042 and section = "Cat 3" then "RMC 3"
      else classification
    end as classification,
    contract,
    region,
    timestamp(convert_timezone('Australia/Sydney', startdate)) as startdate,
    startreferencepointname,
    chainagefrom,
    startdistancepast,
    endreferencepointname,
    chainageto,
    enddistancepast,
    direction,
    bothdirections,
    otherdirectioninspectionid,
    case
      when inspectionid = "" then null
      else inspectionid
    end as inspectionid,
    case
      when moduleid = "" then null
      else moduleid
    end as moduleid,
    inspectiontypeid,
    inspectiontypename,
    inspectiontypereference1,
    inspectiontypereference2,
    category,
    timestamp(createddate) as createddate,
    createduser,
    assigneduser,
    comments,
    entirelength,
    timestamp(scheduleddate) as scheduleddate,
    currentstatus,
    timestamp(
      convert_timezone('Australia/Sydney', completeddate)
    ) as completeddate,
    completeduser,
    case
      when jobid = "" then null
      else jobid
    end as jobid,
    case
      when capitalworkid = "" then null
      else capitalworkid
    end as capitalworkid,
    inspectionroutename,
    inspectiongroupid,
    reference1,
    reference2,
    estimatedduration,
    deleted,
    case 
        when left(wkt, 18) = "GEOMETRYCOLLECTION" THEN NULL --currently cannot represent geometry collection in power bi, therefore assign the geometrycollection entries as null. (Otherwise)
        else wkt
    end as wkt,
    'https://vicroads.assetvision.com.au/Inspections/ViewInspection/' || id as insp_hyperlink,
    month(completeddate) || " - " ||date_format(completeddate, 'MMMM') as completeddate_month,
    date_format(completeddate, 'y') as completeddate_year,
    dayofmonth(completeddate) as completeddate_day,
    date(completeddate) - dayofweek(completeddate) +2 as start_of_week_date_completed, 
    date(scheduleddate) - dayofweek(scheduleddate) +2 as start_of_week_date_scheduled, 

    month(scheduleddate) || " - " ||date_format(scheduleddate, 'MMMM') as scheduleddate_month,
    date_format(scheduleddate, 'y') as scheduleddate_year,
    dayofmonth(scheduleddate) as scheduleddate_day,

    case
      when completeddate is not null then assetid || if(direction is null, "", direction)||if(section is null, "", section)
      else null
    end as unique_assetid_completed, 
    case
      when scheduleddate is not null then assetid || if(direction is null, "", direction) ||if(section is null, "", section)
      else null
    end as unique_assetid_scheduled,
    assetid ||if(direction is null, "", direction)||if(section is null, "", section) as unique_assetid

  FROM
    ext_mssql_asset_vision_ven_vicroads.dbo.vinspection
  WHERE
    contract like '%Western Roads Upgrade (WRU)%'
    AND deleted = False
), 

cte3 as (
select a.kpi_unique_id, b.* 
from cte a
full outer join cte1 b 
on a.kpi_unique_id = b.unique_assetid
),

cte4 as (
    select distinct inspection_routes_concat, scheduleddate, assigneduser from (
select *,
    case
        when inspectionroutename is null then null
        else replace ( -- this whole section is to fix the weird formatting created by array_agg function
        replace(
            replace(
            string(
                array_agg(
                 inspectionroutename || " 
                 " || inspectiontypename || "
                 "
                ) over (partition by assigneduser, scheduleddate)
            ),
            "["
            ),
            "]"
        ),
        ",", "
        ")
        end as inspection_routes_concat from (
select (max(inspectionroutename)) as inspectionroutename, date(scheduleddate) as scheduleddate, assigneduser, inspectiontypename from cte1
group by assigneduser, date(scheduleddate), inspectionroutename, inspectiontypename)
))


select cte3.*, cte4.inspection_routes_concat, timestamp(convert_timezone('Australia/Sydney', current_timestamp()))  as update_time,
case
  when date(cte3.scheduleddate) < date(convert_timezone('Australia/Sydney', current_timestamp())) then "#7ce378" --scheduled date is less than current date then green
  when date(cte3.scheduleddate) = date(convert_timezone('Australia/Sydney', current_timestamp())) then "#f2ea8a" --scheduled date is today then yellow
  else "white"
end as schedule_colour
from cte3
join cte4
on date(cte3.scheduleddate) = cte4.scheduleddate and cte3.assigneduser = cte4.assigneduser
where date(cte3.scheduleddate) >= "2024-01-01" 
and cte3.inspectiontypename in ("Defect Inspection", "Hazard Inspection (Night)", "Hazard Inspection (Day)", "Drainage Pit - Functional Performance Checklist", "Defect Inspection,Hazard Inspection (Day)")
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `kpi_unique_id` | `string` | Yes |  |
| `id` | `int` | Yes |  |
| `deltautc` | `timestamp` | Yes |  |
| `modifiedutc` | `timestamp` | Yes |  |
| `assettypename` | `string` | Yes |  |
| `assetid` | `int` | Yes |  |
| `assetcode` | `string` | Yes |  |
| `assetname` | `string` | Yes |  |
| `section` | `string` | Yes |  |
| `classification` | `string` | Yes |  |
| `contract` | `string` | Yes |  |
| `region` | `string` | Yes |  |
| `startdate` | `timestamp` | Yes |  |
| `startreferencepointname` | `string` | Yes |  |
| `chainagefrom` | `int` | Yes |  |
| `startdistancepast` | `int` | Yes |  |
| `endreferencepointname` | `string` | Yes |  |
| `chainageto` | `int` | Yes |  |
| `enddistancepast` | `int` | Yes |  |
| `direction` | `string` | Yes |  |
| `bothdirections` | `string` | Yes |  |
| `otherdirectioninspectionid` | `int` | Yes |  |
| `inspectionid` | `int` | Yes |  |
| `moduleid` | `int` | Yes |  |
| `inspectiontypeid` | `int` | Yes |  |
| `inspectiontypename` | `string` | Yes |  |
| `inspectiontypereference1` | `string` | Yes |  |
| `inspectiontypereference2` | `string` | Yes |  |
| `category` | `string` | Yes |  |
| `createddate` | `timestamp` | Yes |  |
| `createduser` | `string` | Yes |  |
| `assigneduser` | `string` | Yes |  |
| `comments` | `string` | Yes |  |
| `entirelength` | `string` | Yes |  |
| `scheduleddate` | `timestamp` | Yes |  |
| `currentstatus` | `string` | Yes |  |
| `completeddate` | `timestamp` | Yes |  |
| `completeduser` | `string` | Yes |  |
| `jobid` | `int` | Yes |  |
| `capitalworkid` | `int` | Yes |  |
| `inspectionroutename` | `string` | Yes |  |
| `inspectiongroupid` | `int` | Yes |  |
| `reference1` | `string` | Yes |  |
| `reference2` | `string` | Yes |  |
| `estimatedduration` | `decimal(10,2)` | Yes |  |
| `deleted` | `boolean` | Yes |  |
| `wkt` | `string` | Yes |  |
| `insp_hyperlink` | `string` | Yes |  |
| `completeddate_month` | `string` | Yes |  |
| `completeddate_year` | `string` | Yes |  |
| `completeddate_day` | `int` | Yes |  |
| `start_of_week_date_completed` | `date` | Yes |  |
| `start_of_week_date_scheduled` | `date` | Yes |  |
| `scheduleddate_month` | `string` | Yes |  |
| `scheduleddate_year` | `string` | Yes |  |
| `scheduleddate_day` | `int` | Yes |  |
| `unique_assetid_completed` | `string` | Yes |  |
| `unique_assetid_scheduled` | `string` | Yes |  |
| `unique_assetid` | `string` | Yes |  |
| `inspection_routes_concat` | `string` | Yes |  |
| `update_time` | `timestamp` | No |  |
| `schedule_colour` | `string` | No |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
