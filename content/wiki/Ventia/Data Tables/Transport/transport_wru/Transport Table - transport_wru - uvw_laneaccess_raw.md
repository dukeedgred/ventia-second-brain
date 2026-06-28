---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_laneaccess_raw
full-name: transport_dev.transport_wru.uvw_laneaccess_raw
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_laneaccess_raw

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_laneaccess_raw` |
| Full name | `transport_dev.transport_wru.uvw_laneaccess_raw` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 40 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | lane access |
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-07-25T01:52:16.808Z; Last altered: 2024-09-24T01:42:26.59Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
with LaneAccess_Combined as(
  --Lane Closures
  SELECT
    `Record ID` as RecordID,
    case
      when a.AssetCode is null then b.assetcode
    end as AssetCode,
    case
      when a.AssetName is null then b.assetname
    end as AssetName,
    case
      when a.jobid is not null then 'Maintenance'
      when CapitalWorkID is not null then 'Captial Work'
      when a.inspectionid is not null then 'Maintenance'
    end as Work_Order_Type,
    case
      when a.jobid is not null then a.jobid
      when CapitalWorkID is not null then CapitalWorkID
      when a.inspectionid is not null then a.inspectionid
    end as Work_Order_Number,
    'Lane Closure' as Access_Type,
    int(`Number of Lane Closed`) as No_of_Lanes,
    int(`Length of Worksite`) as LengthofWorksite,
    int(`MoA RWE Number`) as MOA_REF,
    --TMPTGSNumber as TGS_REF,
    b.activitycategorycode,
    b.activitycode,
    b.interventioncode,
    b.intervention_level,
    `Closure Type` as ClosureType,
    to_timestamp(concat(substring(`First Sign placed Date Time`, 7, 4), '-', substring(`First Sign placed Date Time`, 4, 2), '-', left(`First Sign placed Date Time`, 2), ' ', right(`First Sign placed Date Time`, 8))) as StateDateTime,
    to_date(concat(substring(`First Sign placed Date Time`, 7, 4), '-', substring(`First Sign placed Date Time`, 4, 2), '-', left(`First Sign placed Date Time`, 2), ' ', right(`First Sign placed Date Time`, 8))) as StartDate,
    to_timestamp(concat(substring(`Last Sign placed Date Time`, 7, 4), '-', substring(`Last Sign placed Date Time`, 4, 2), '-', left(`Last Sign placed Date Time`, 2), ' ', right(`Last Sign placed Date Time`, 8))) as EndDateTime,
    to_date(concat(substring(`Last Sign placed Date Time`, 7, 4), '-', substring(`Last Sign placed Date Time`, 4, 2), '-', left(`Last Sign placed Date Time`, 2), ' ', right(`Last Sign placed Date Time`, 8))) as EndDate,
    int(`Normal Speed`) as Normal_Speed_limit,
    int(`Reduced Speed`) as Reduce_Speed_limit,
    a.Comments,
    `Is One Lane Open Is Same Direction` as IsOneLaneOpenIsSameDirection,
    concat('https://vicroads.assetvision.com.au/Inspections/ViewInspection/', `Record ID`) as LA_Link,
    case
      when a.jobid is not null then concat('https://vicroads.assetvision.com.au/Maintenance/ViewJob/', a.jobid)
      when CapitalWorkID is not null then concat('https://vicroads.assetvision.com.au/CapitalWorks/ViewCapitalWork/', CapitalWorkID)
      when a.inspectionid is not null then concat('https://vicroads.assetvision.com.au/Inspections/ViewInspection/', a.inspectionid)
    end as Work_Order_Link,
    case
      when `First Sign placed Date Time` is null or `Last Sign placed Date Time` is null then 'No'
      else 'Yes'
    end as valid_data
  FROM
    ext_mssql_asset_vision_ven_vicroads.dbo.laneaccess a
    left join transport_dev.transport_wru.uvw_job b on a.jobid = b.id
  where
    int(`Number of Lane Closed`) > 0
    and `Number of Lane Closed` is not null
    and a.CreatedDate >= '2023-03-01'
    and `First Sign placed Date Time` is not null
    and a.CurrentStatus = 'Completed'
  union
    --Lane Speed Reduction
  SELECT
    `Record ID` as RecordID,
    case
      when a.AssetCode is null then b.assetcode
    end as AssetCode,
    case
      when a.AssetName is null then b.assetname
    end as AssetName,
    case
      when a.jobid is not null then 'Maintenance'
      when CapitalWorkID is not null then 'Captial Work'
      when a.inspectionid is not null then 'Maintenance'
    end as Work_Order_Type,
    case
      when a.jobid is not null then a.jobid
      when CapitalWorkID is not null then CapitalWorkID
      when a.inspectionid is not null then a.inspectionid
    end as Work_Order_Number,
    'Speed Reduction' as Access_Type,
    int(`Number of Lane Speed Reduced`) as No_of_Lanes,
    int(`Length of Worksite`) as LengthofWorksite,
    int(`MoA RWE Number`) as MOA_REF, 
    -- TMPTGSNumber as TGS_REF,
    b.activitycategorycode,
    b.activitycode,
    b.interventioncode,
    b.intervention_level,
    `Closure Type` as ClosureType,
    to_timestamp(concat(substring(`First Sign placed Date Time`, 7, 4), '-', substring(`First Sign placed Date Time`, 4, 2), '-', left(`First Sign placed Date Time`, 2), ' ', right(`First Sign placed Date Time`, 8))) as StateDateTime,
    to_date(concat(substring(`First Sign placed Date Time`, 7, 4), '-', substring(`First Sign placed Date Time`, 4, 2), '-', left(`First Sign placed Date Time`, 2), ' ', right(`First Sign placed Date Time`, 8))) as StartDate,
    to_timestamp(concat(substring(`Last Sign placed Date Time`, 7, 4), '-', substring(`Last Sign placed Date Time`, 4, 2), '-', left(`Last Sign placed Date Time`, 2), ' ', right(`Last Sign placed Date Time`, 8))) as EndDateTime,
    to_date(concat(substring(`Last Sign placed Date Time`, 7, 4), '-', substring(`Last Sign placed Date Time`, 4, 2), '-', left(`Last Sign placed Date Time`, 2), ' ', right(`Last Sign placed Date Time`, 8))) as EndDate,
    int(`Normal Speed`) as Normal_Speed_limit,
    int(`Reduced Speed`) as Reduce_Speed_limit,
    a.Comments,
    `Is One Lane Open Is Same Direction` as IsOneLaneOpenIsSameDirection,
    concat('https://vicroads.assetvision.com.au/Inspections/ViewInspection/', RecordID) as LA_Link,
    case
      when a.jobid is not null then concat('https://vicroads.assetvision.com.au/Maintenance/ViewJob/', a.jobid)
      when CapitalWorkID is not null then concat('https://vicroads.assetvision.com.au/CapitalWorks/ViewCapitalWork/', CapitalWorkID)
      when a.inspectionid is not null then concat('https://vicroads.assetvision.com.au/Inspections/ViewInspection/', a.inspectionid)
    end as Work_Order_Link,
    case
      when `First Sign placed Date Time` is null or `Last Sign placed Date Time` is null then 'No'
      else 'Yes'
    end as valid_data
  FROM
   ext_mssql_asset_vision_ven_vicroads.dbo.laneaccess a
    left join transport_dev.transport_wru.uvw_job b on a.jobid = b.id
  where
    int(`Number of Lane Speed Reduced`) > 0
    and `Number of Lane Closed` is not null
    and a.CreatedDate >= '2023-03-01'
    and `First Sign placed Date Time` is not null
    and a.CurrentStatus = 'Completed'
),

report_dates as(
  select
    date_format(a.date, 'yyyyMM') as Reporting_ID,
    weekday(a.date) + 1 as Week_Day_Number,
    a.*,
    if(b.date is not null, 'Yes', 'No') as Public_Holiday,
    b.holiday as Holiday_Name
  from
    transport_dev.transport_wru.utbl_date_table a
    left join transport_dev.transport_wru.utbl_public_holidays b on a.date = b.date
),
Lane_Access_Processed as (
  select
    b.Reporting_ID,
    case
      when b.Public_Holiday = 'Yes' then 'Weekends & Public Holidays'
      when b.Week_Day_Number > 5 then 'Weekends & Public Holidays'
      else 'Monday - Friday'
    end as Day_Type,
    b.day_of_week,
    case
      when a.StartDate = b.date then a.StateDateTime
      else to_timestamp(b.date)
    end as Analysis_StartDateTime,
    case
      when a.EndDate = b.date then a.EndDateTime
      else dateadd(second, -1, date_add(b.date, 1))
    end as Analysis_EndDateTime,
    date_format(case
                  when a.StartDate = b.date then a.StateDateTime
                  else to_timestamp(b.date)
                end,
                'HHmmss'
               ) as Analysis_CalcStartTime,
    date_format(case
                  when a.EndDate = b.date then a.EndDateTime
                  else dateadd(second, -1, date_add(b.date, 1))
                end,
                'HHmmss'
               ) as Analysis_CalcEndTime,
    b.date,
    b.Public_Holiday,
    b.Holiday_Name,
    a.*
  from
    LaneAccess_Combined a
    join report_dates b on a.StartDate <= b.date
    and b.date <= a.EndDate
),

work_chainage as (
  -- Maintenance Job Road,  Direction and Chainage
  select
    `Record ID` as recordId,
    a.createddate,
    c.assettype,
    case
      when c.assettype = 'Road' and a.assetcode is not null then a.assetcode
      when c.assettype = 'Road' then b.assetcode
      else c.parentassetcode
    end as RoadNo,
    case
      when a.Direction = 'Inbound' then 'Reverse'
      when a.Direction = 'Outbound' then 'Forward'
      when a.direction is null then ( case
                                        when c.direction = 'Inbound' then 'Reverse'
                                        when c.direction = 'Outbound' then 'Forward'
                                        else c.direction
                                      end)
      else a.direction
    end as direction,
    case
      when a.chainagefrom is not null then a.chainagefrom
      when b.chainagefrom >= 0 then b.chainagefrom
      else c.chainagefrom
    end as Parent_Asset_chainage
  from
    ext_mssql_asset_vision_ven_vicroads.dbo.laneaccess a
    join transport_dev.transport_wru.uvw_job b on a.jobid = b.id
    join transport_dev.transport_wru.uvw_asset c on b.assetid = c.id
  union
    -- Inspections ,  Direction and Chainage
  select
    `Record ID` as recordId,
    a.createddate,
    c.assettype,
    case
      when c.assettype = 'Road'
      and a.assetcode is not null then a.assetcode
      when c.assettype = 'Road' then b.assetcode
      else c.parentassetcode
    end as RoadNo,
    case
      when a.Direction = 'Inbound' then 'Reverse'
      when a.Direction = 'Outbound' then 'Forward'
      when a.direction is null then (
        case
          when c.direction = 'Inbound' then 'Reverse'
          when c.direction = 'Outbound' then 'Forward'
          else c.direction
        end
      )
      else a.direction
    end as direction,
    case
      when a.chainagefrom is not null then a.chainagefrom
      when b.chainagefrom >= 0 then b.chainagefrom
      else c.chainagefrom
    end as Parent_Asset_chainage
  from
    ext_mssql_asset_vision_ven_vicroads.dbo.laneaccess a
    join transport_dev.transport_wru.uvw_inspection b on a.inspectionid = b.id
    join transport_dev.transport_wru.uvw_asset c on b.assetid = c.id
  union
    -- Capital Works ,  Direction and Chainage
  select
    `Record ID` as recordId,
    a.createddate,
    if(c.assettype is null, d.assettype, c.assettype) as assettype,
    case
      when d.capital_work_id is not null then d.roadno
      when c.assettype = 'Road' and a.assetcode is not null then a.assetcode
      when c.assettype = 'Road' then b.assetcode
      else c.parentassetcode
    end as RoadNo,
    case
      when d.capital_work_id is not null then d.direction
      when a.Direction = 'Inbound' then 'Reverse'
      when a.Direction = 'Outbound' then 'Forward'
      when a.direction is null then ( case
                                        when c.direction = 'Inbound' then 'Reverse'
                                        when c.direction = 'Outbound' then 'Forward'
                                        else c.direction
                                      end)
      else a.direction
    end as direction,
    case
      when d.capital_work_id is not null then d.chainagefrom
      when a.chainagefrom is not null then a.chainagefrom
      when b.chainagefrom >= 0 then b.chainagefrom
      else c.chainagefrom
    end as Parent_Asset_chainage
  from
    ext_mssql_asset_vision_ven_vicroads.dbo.laneaccess a
    join transport_dev.transport_wru.uvw_capitalwork b on a.CapitalWorkID = b.id
    left join transport_dev.transport_wru.uvw_asset c on b.assetid = c.id
    left join transport_dev.transport_wru.utbl_capitalwork_chainage d on b.id = Capital_Work_ID
)
select
  b.assettype,
  b.roadno,
  b.direction,
  b.Parent_Asset_chainage,
  case
    when intervention_level in ('Emergency Response', 'Hazard') then 'Yes'
    else 'No'
  end as Exempted,
  a.*
from
  Lane_Access_Processed a
  left join work_chainage b on a.RecordID = b.recordId
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `assettype` | `string` | Yes |  |
| `roadno` | `string` | Yes |  |
| `direction` | `string` | Yes |  |
| `Parent_Asset_chainage` | `bigint` | Yes |  |
| `Exempted` | `string` | No |  |
| `Reporting_ID` | `string` | Yes |  |
| `Day_Type` | `string` | No |  |
| `day_of_week` | `string` | Yes |  |
| `Analysis_StartDateTime` | `timestamp` | Yes |  |
| `Analysis_EndDateTime` | `timestamp` | Yes |  |
| `Analysis_CalcStartTime` | `string` | Yes |  |
| `Analysis_CalcEndTime` | `string` | Yes |  |
| `date` | `date` | Yes |  |
| `Public_Holiday` | `string` | No |  |
| `Holiday_Name` | `string` | Yes |  |
| `RecordID` | `int` | Yes |  |
| `AssetCode` | `string` | Yes |  |
| `AssetName` | `string` | Yes |  |
| `Work_Order_Type` | `string` | Yes |  |
| `Work_Order_Number` | `int` | Yes |  |
| `Access_Type` | `string` | No |  |
| `No_of_Lanes` | `int` | Yes |  |
| `LengthofWorksite` | `int` | Yes |  |
| `MOA_REF` | `int` | Yes |  |
| `activitycategorycode` | `string` | Yes |  |
| `activitycode` | `string` | Yes |  |
| `interventioncode` | `string` | Yes |  |
| `intervention_level` | `string` | Yes |  |
| `ClosureType` | `string` | Yes |  |
| `StateDateTime` | `timestamp` | Yes |  |
| `StartDate` | `date` | Yes |  |
| `EndDateTime` | `timestamp` | Yes |  |
| `EndDate` | `date` | Yes |  |
| `Normal_Speed_limit` | `int` | Yes |  |
| `Reduce_Speed_limit` | `int` | Yes |  |
| `Comments` | `string` | Yes |  |
| `IsOneLaneOpenIsSameDirection` | `string` | Yes |  |
| `LA_Link` | `string` | Yes |  |
| `Work_Order_Link` | `string` | Yes |  |
| `valid_data` | `string` | No |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
