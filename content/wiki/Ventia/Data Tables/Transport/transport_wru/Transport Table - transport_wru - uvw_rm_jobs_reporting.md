---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_rm_jobs_reporting
full-name: transport_dev.transport_wru.uvw_rm_jobs_reporting
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_rm_jobs_reporting

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_rm_jobs_reporting` |
| Full name | `transport_dev.transport_wru.uvw_rm_jobs_reporting` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 64 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | jobs / work orders |
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-06-26T03:44:55.733Z; Last altered: 2024-09-24T01:42:42.59Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
    with sq as (
    select a.createddate, a.createduser, a.id as job_id, b.id as assetid, b.code as asset_code, b.name as asset_name, 
        case 
            when left(a.wkt, 18) = "GEOMETRYCOLLECTION" THEN NULL --currently cannot represent geometry collection in power bi as far as I know
            else wkt
        end as wkt,
        a.completeduser,
        case     
            when b.parentassetname is null then b.name
            else b.parentassetname
        end as road,
        case
            when activitycategorycode like "RM1%" or activitycode like "RM1%" then "RM100"
            when activitycategorycode like "RM2%" or activitycode like "RM2%" then "RM200"
            when activitycategorycode like "RM3%" or activitycode like "RM3%" then "RM300"
            when activitycategorycode like "RM4%" or activitycode like "RM4%" then "RM400"
            when activitycategorycode like "RM5%" or activitycode like "RM5%" then "RM500"
            when activitycategorycode like "RM6%" or activitycode like "RM6%" then "RM600"
            when activitycategorycode like "RM7%" or activitycode like "RM7%" then "RM700"
            when activitycategorycode like "RM8%" or activitycode like "RM8%" then "RM800"
            when activitycategorycode like "RM9%" or activitycode like "RM9%" then "RM900"
            when activitycode like "OM" then "OM"
        end as summarised_rm_code,
        activitycode,
        LEFT(activitycode, 5) as activitycode_trim, 
        case 
            when a.completeddate is null then datediff(MINUTE, a.createddate,timestamp(convert_timezone('Australia/Sydney', current_timestamp())))
            else if(datediff(MINUTE, createddate, completeddate)<0, null, datediff(MINUTE, createddate, completeddate))
        end as time_used,
        datediff(minute, createddate, duedate) as time_allocated,
        round(time_used/time_allocated,3) as percentage_used, 
        case
            when time_used < 10080 then "A - Less Than One Week" --10080 is minutes in a week
            when 10080 <= time_used and time_used <40320 then "B- Between One and Four Weeks"
            when 40320 <= time_used and time_used <524160 then "C - Between Four Weeks and A Year"
            when 524160 <= time_used and time_used <1048320 then "D - Between One and Two Years"
            when time_used >= 1048320 then "E - Over Two Years"
        end as time_open_range,  
        case
            when percentage_used <0.1 then "A-Less Than 10%"
            when percentage_used >=0.1 and percentage_used <0.2 then "B-Between 10% and 20%"
            when percentage_used >=0.2 and percentage_used <0.3 then "C-Between 20% and 30%"
            when percentage_used >=0.3 and percentage_used <0.4 then "D-Between 30% and 40%"
            when percentage_used >=0.4 and percentage_used <0.5 then "E-Between 40% and 50%"
            when percentage_used >=0.5 and percentage_used <0.6 then "F-Between 50% and 60%"
            when percentage_used >=0.6 and percentage_used <0.7 then "G-Between 60% and 70%"
            when percentage_used >=0.7 and percentage_used <0.8 then "H-Between 70% and 80%"
            when percentage_used >=0.8 and percentage_used <0.9 then "I-Between 80% and 90%"
            when percentage_used >=0.9 and percentage_used <1 then "J-Between 90% and 100%"
            when percentage_used >=1  then "K-100% and Over"
        end as percentage_used_range,
        case
            when date_format(completeddate, 'H') >= 19 or date_format(completeddate, 'H') < 7 then "Night Shift"
            else "Day Shift"
        end completed_shift,
        dateadd(hour,-7, completeddate) as completeddate_shift, -- for use when filtering.
        case
            when inspectiontypename is null then `Job Data|Job Origin`--get from formfield --HAS BOTH BLANK AND EMPTY STRING
            else inspectiontypename
        end as job_origin,
        activitycategorycode,
        activitytype,
        activitycategoryname,
        activityname,
        interventionname,
        assigneduser,
        duedate,
        completeddate,
        a.area as council, 
        completedstatus,
        compliant,
        --rm owner,
        --response name
        --c.spatialinfo, --ideally separated into start/end lat/long, currently can't use the spatial data anyway.  
        b.stage, 
        b.assettype,
        a.Classification,
        a.InterventionCode,
        --all comments,
        a.interventionreference1 as KPI,
        case 
            when coalesce(string(`Job Data|F&F (Find and Fix)`), `Finish Work On Site|F&F (Find and Fix)`) is null or coalesce(string(`Job Data|F&F (Find and Fix)`), `Finish Work On Site|F&F (Find and Fix)`) ='' then "No" 
            else coalesce(string(`Job Data|F&F (Find and Fix)`), `Finish Work On Site|F&F (Find and Fix)`)
        end as find_and_fix, 

        `Job Data|Third Party Works Hazard` as third_party_works_hazard, 
        `Job Data|Extension of Time` as extension_of_time, `Job Data|Original Due Date` as original_due_date, `Job Data|Extension Reason` as extension_reason,
        if(`Quality Assurance|Job Details Quality` ="", null, `Quality Assurance|Job Details Quality`) as jobs_details_quality,
        case
            when `Job Data|Job Origin` = "" then null
            else `Job Data|Job Origin`
        end as job_origin_ets,
        case
            when `Job Data|Job Origin` = "ETS" then
            case
                when jobs_details_quality in ("Further Details Provided", "Existing WRU Identified Job", "Job Detail Sufficient", "Third Party to Rectify", "Further Details Required" ) 
                    then "ETS at intervention and actioned by WRU"
                when jobs_details_quality is null then "Not yet categorised"
                else "ETS received was not for WRU action"
            end
        end as ets_category,
        `Job Data|COMs Required` as coms_required, 
        `Job Data|COMs Start Date` as coms_start_date, `Job Data|COMs End Date` as coms_end_date, 
        cast(`Job Data|ETS ID` as numeric) as ets_id, 
        if(`Quality Assurance|Workmanship Quality (Desktop check)` = "", null, `Quality Assurance|Workmanship Quality (Desktop check)`)  as workmanship_quality_desktop,
        if(`Quality Assurance|Workmanship Quality (On-Site check)` ="", null,`Quality Assurance|Workmanship Quality (On-Site check)`)  as workmanship_quality_onsite,

        timestamp(
            convert_timezone('Australia/Sydney', e.modifiedutc)
            ) as modified_aest,
        e.comment,
        "https://vicroads.assetvision.com.au/Maintenance/ViewJob/"||string(a.id) as job_link,
        datediff(hour,a.createddate, a.duedate) as response_time,
        case 
            when response_time in (1,2,3,4,8) then string(response_time)|| " Hour/s"
            when date_format(duedate, 'H:m') = "23:59" then "Same Day"
            when response_time = 24 then "24 Hours"
            when response_time = 48 then "48 Hours"
            when response_time = 72 then "72 Hours"
            when response_time = 120 then "5 Days"
            when response_time = 168 then "1 Week"
            when response_time = 240 then "10 Days"
            when response_time = 336 then "2 Weeks"
            when response_time = 672 then "4 Weeks"
            when response_time in (696, 720, 744) then "1 Month"
            when response_time = 1008 then "6 Weeks"
            when response_time = 1344 then "8 Weeks"
            when response_time in (1392, 1416, 1440, 1464, 1488) then "2 Months"
            when response_time = 1680 then "10 Weeks"
            when response_time = 2136 then "3 Months"
            else null
        end as response_time_str, --MANY BLANKS, BUT MOST SEEM TO COME FROM OLD DATA
        case 
            when response_time_str = "2 Hour/s" then "#9e0142"
            when response_time_str = "4 Hour/s" then "#d53e4f"
            when response_time_str = "8 Hour/s" then "#f46d43"
            when response_time_str = "Same Day" then "#fdae61"
            when response_time_str = "24 Hours" then "#fee08b"
            when response_time_str = "48 Hours" then "#e6f598"
            when response_time_str = "5 Days" then "#abdda4"
            when response_time_str = "1 Week" then "#66c2a5"
            when response_time_str = "2 Weeks" then "#3288bd"
            when response_time_str = "4 Weeks" then "#5e4fa2"
            when response_time_str = "1 Month" then "#ffffbf"
            when response_time_str = "8 Weeks" then "#808080"
            when response_time_str = "10 Weeks" then "#FFD1DC"
            when response_time_str = "2 Months" then "#ADD8E6"
            when response_time_str is null then "#FFFFFF"
        end as response_time_colour,
        case
            when find_and_fix = "Yes" then "Find and Fix"
            else job_origin_ets
        end as drill_down,
        inspectionid

        from ext_mssql_asset_vision_ven_vicroads.dbo.vjob a
        left join ext_mssql_asset_vision_ven_vicroads.dbo.jobcomment e
        on a.id = e.jobid
        left join ext_mssql_asset_vision_ven_vicroads.dbo.asset b
        on a.assetid = b.id

        left join
        (
            with sq as (
                select sourcetableid, name, coalesce(value,"") as value from ext_mssql_asset_vision_ven_vicroads.dbo.formfield where deleted = false and sourcetable = "Job" --and value is null
            )
        select * from sq
        pivot (max(value) for name in ("Job Data|F&F (Find and Fix)", "Finish Work On Site|F&F (Find and Fix)", "Job Data|Third Party Works Hazard", 
        "Job Data|Extension of Time", "Job Data|Original Due Date", "Job Data|Extension Reason",
        "Quality Assurance|Job Details Quality", "Job Data|COMs Required", "Quality Assurance|Workmanship Quality (Desktop check)", "Quality Assurance|Workmanship Quality (On-Site check)",
        "Job Data|COMs Start Date", "Job Data|COMs End Date", "Job Data|ETS ID", "Job Data|Job Origin"))
        ) d
        on a.id = d.sourcetableid
        where a.deleted = False and b.deleted = False and a.contract = "Western Roads Upgrade (WRU)" 
        and mergedjobid is null --and e.deleted = False
    ),

sq1 as (
    select sq.*,
        row_number() over (
        partition by job_id
        order by
            modified_aest
        ) as rn,
        case
        when comment is null then null
        else replace(
            replace(
            string(
                array_agg(
                "Date: " || modified_aest || " Comment: " || comment
                ) over (partition by job_id)
            ),
            "["
            ),
            "]"
        )
        end as job_comments
        from sq
        )
    select *, 
    count(assetid) over (partition by assetid, date(createddate) >=  date(dateadd(day, -365, timestamp(convert_timezone('Australia/Sydney', current_timestamp()))))) as yesterday_job_filter,
    timestamp(convert_timezone('Australia/Sydney', current_timestamp())) as latest_refresh,
    row_number() over (order by asset_code desc, createddate desc) as order_for_yesterday_jobs,
    case
        when left(completeduser,3) = "VEN" then "Internal"
        else "External"
    end as internal_completed_user
    from sq1
    where rn = 1
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `createddate` | `timestamp` | Yes |  |
| `createduser` | `string` | Yes |  |
| `job_id` | `int` | Yes |  |
| `assetid` | `int` | Yes |  |
| `asset_code` | `string` | Yes |  |
| `asset_name` | `string` | Yes |  |
| `wkt` | `string` | Yes |  |
| `completeduser` | `string` | Yes |  |
| `road` | `string` | Yes |  |
| `summarised_rm_code` | `string` | Yes |  |
| `activitycode` | `string` | Yes |  |
| `activitycode_trim` | `string` | Yes |  |
| `time_used` | `bigint` | Yes |  |
| `time_allocated` | `bigint` | Yes |  |
| `percentage_used` | `double` | Yes |  |
| `time_open_range` | `string` | Yes |  |
| `percentage_used_range` | `string` | Yes |  |
| `completed_shift` | `string` | No |  |
| `completeddate_shift` | `timestamp` | Yes |  |
| `job_origin` | `string` | Yes |  |
| `activitycategorycode` | `string` | Yes |  |
| `activitytype` | `string` | Yes |  |
| `activitycategoryname` | `string` | Yes |  |
| `activityname` | `string` | Yes |  |
| `interventionname` | `string` | Yes |  |
| `assigneduser` | `string` | Yes |  |
| `duedate` | `timestamp` | Yes |  |
| `completeddate` | `timestamp` | Yes |  |
| `council` | `string` | Yes |  |
| `completedstatus` | `string` | Yes |  |
| `compliant` | `string` | Yes |  |
| `stage` | `string` | Yes |  |
| `assettype` | `string` | Yes |  |
| `Classification` | `string` | Yes |  |
| `InterventionCode` | `string` | Yes |  |
| `KPI` | `string` | Yes |  |
| `find_and_fix` | `string` | Yes |  |
| `third_party_works_hazard` | `string` | Yes |  |
| `extension_of_time` | `string` | Yes |  |
| `original_due_date` | `string` | Yes |  |
| `extension_reason` | `string` | Yes |  |
| `jobs_details_quality` | `string` | Yes |  |
| `job_origin_ets` | `string` | Yes |  |
| `ets_category` | `string` | Yes |  |
| `coms_required` | `string` | Yes |  |
| `coms_start_date` | `string` | Yes |  |
| `coms_end_date` | `string` | Yes |  |
| `ets_id` | `decimal(10,0)` | Yes |  |
| `workmanship_quality_desktop` | `string` | Yes |  |
| `workmanship_quality_onsite` | `string` | Yes |  |
| `modified_aest` | `timestamp` | Yes |  |
| `comment` | `string` | Yes |  |
| `job_link` | `string` | Yes |  |
| `response_time` | `bigint` | Yes |  |
| `response_time_str` | `string` | Yes |  |
| `response_time_colour` | `string` | Yes |  |
| `drill_down` | `string` | Yes |  |
| `inspectionid` | `int` | Yes |  |
| `rn` | `int` | No |  |
| `job_comments` | `string` | Yes |  |
| `yesterday_job_filter` | `bigint` | No |  |
| `latest_refresh` | `timestamp` | No |  |
| `order_for_yesterday_jobs` | `int` | No |  |
| `internal_completed_user` | `string` | No |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
