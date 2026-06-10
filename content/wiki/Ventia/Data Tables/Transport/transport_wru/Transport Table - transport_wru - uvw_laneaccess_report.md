---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_laneaccess_report
full-name: transport_dev.transport_wru.uvw_laneaccess_report
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_laneaccess_report

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_laneaccess_report` |
| Full name | `transport_dev.transport_wru.uvw_laneaccess_report` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 41 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | lane access |
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-07-25T02:06:15.647Z; Last altered: 2024-09-24T01:42:32.778Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
with laneAccess_prep as(
  select
    row_number() over(partition by a.RecordID, a.Access_Type order by a.date, b.Timing_Begin) as rn,
    b.Period,
    if(
      Analysis_CalcStartTime > replace(B.Timing_Begin, ':', ''),
      a.Analysis_StartDateTime,
      timestamp(concat(date_format(a.Analysis_StartDateTime, 'yyyy-MM-dd'), ' ', b.Timing_Begin))
    ) as start_Time,
    if(
      Analysis_CalcendTime < replace(b.Timing_End, ':', ''),
      a.Analysis_EndDateTime,
      timestamp(concat(date_format(a.Analysis_EndDateTime, 'yyyy-MM-dd'), ' ', b.Timing_end))
    ) as end_Time,
    a.*
  from
    transport_dev.transport_wru.uvw_laneaccess_raw a
    left join transport_dev.transport_wru.utbl_work_peaktime_periods b on a.Day_Type = b.Day_Type
    and ((replace(b.Timing_End, ':', '') >= a.Analysis_CalcEndTime and replace(b.timing_begin, ':', '') < a.Analysis_CalcEndTime)
          or 
          (a.Analysis_CalcStartTime < replace(b.Timing_End, ':', '') and a.Analysis_CalcStartTime >= replace(b.Timing_Begin, ':', ''))
          or 
          (a.Analysis_CalcStartTime <= replace(b.Timing_Begin, ':', '') and a.Analysis_CalcEndTime >= replace(b.Timing_end, ':', '')))
),

predata as(
  select
    case
      when dayofweek(start_Time) -1 = 0 then 7
      else dayofweek(start_Time) -1
    end number_day_of_week, 
    -- dayofweek() 1 = Sunday,  and 7 = Saturday,
    timestampdiff(minute, start_Time, end_Time) as DURATION_IN_MIN,
    ceiling(timestampdiff(minute, start_Time, end_Time) / 15) as NO_OF_PERIODS_OF_15MIN,
    ceiling(LengthofWorksite / 500) as NO_OF_LENGTHS_OF_500M,
    case
      when (Normal_Speed_limit - Reduce_Speed_limit) > 10 then 'Yes'
      else 'No'
    end as SpeedReducationGreaterThan10,
    *
  from
    laneAccess_prep
),

all_traffic_data as(
  select
    case
      when SpeedReducationGreaterThan10 = 'No'
      and a.Access_Type = 'Speed Reduction' then 0
      else a.NO_OF_LENGTHS_OF_500M * a.NO_OF_PERIODS_OF_15MIN * No_of_Lanes
    end as Lane_access_units,
    b.Period as hour_period,
    b.Traffic_Vol,
    c.`Number of Lanes` as Total_No_Lanes,
    a.IsOneLaneOpenIsSameDirection,
    --case
    --when a.IsOneLaneOpenIsSameDirection = 'No' then 0
    --when a.IsOneLaneOpenIsSameDirection = 'Yes' and c.`Number of Lanes` is null then 1
    --when a.IsOneLaneOpenIsSameDirection = 'Yes' and c.`Number of Lanes` < a.No_of_Lanes then 1
    --when a.Access_Type = 'Lane Closure' then case when c.`Number of Lanes` < a.No_of_Lanes then 0 else c.`Number of Lanes` - a.No_of_Lanes end
    --else
    --c.`Number of Lanes` end as lanes_open,
    case
      when d.`Divided Section` is null then 'No'
      else 'Yes'
    end Divided_Section,
    case
      when d.`Divided Section` is null then 600
      else 800
    end Allowed_Hourly_Traf_Vol_PerLane,
    a.*
  from
    predata a
    left join transport_dev.transport_wru.utbl_lane_access_traffic_volumes b on a.roadno = b.Road_ID
    and a.direction = b.Direction
    and a.number_day_of_week = b.DOW
    and a.Parent_Asset_chainage >= b.Chainage_S
    and a.Parent_Asset_chainage < b.Chainage_E
    and b.Period >= hour(a.start_time)
    and b.Period <= hour(end_time)
    and b.year = 2023 -- UPDATE THIS NUMBER WHEN NEW TRAFFIC VOLUME IS AVAILABLE IN THE FUTURE
    left join transport_dev.transport_wru.utbl_lane_access_lane_config c on a.roadno = c.NB_ROAD
    and a.direction = c.`Chainage Direction`
    and ((a.Parent_Asset_chainage >= c.`Start Chainage (SRRS)` and a.Parent_Asset_chainage < c.`End Chainage (SRRS)`)
        or 
        (a.Parent_Asset_chainage > c.`Start Chainage (SRRS)` and a.Parent_Asset_chainage <= c.`End Chainage (SRRS)`))
    left join transport_dev.transport_wru.utbl_lane_access_road_chainage d on a.roadno = d.Road_No
    and a.direction = d.Direction
    and a.Parent_Asset_chainage >= d.`Start`
    and a.Parent_Asset_chainage < d.`End`
),

report as(
  select
    Reporting_ID,
    RecordID,
    Work_Order_Type,
    Work_Order_Number,
    Access_Type,
    RN,
    MOA_REF,
    assettype,
    AssetName,
    activitycategorycode,
    activitycode,
    intervention_level,
    Exempted,
    RoadNo,
    direction,
    Parent_Asset_chainage,
    ClosureType,
    Day_Type,
    period,
    day_of_week,
    Public_Holiday,
    Holiday_Name,
    start_Time,
    end_Time,
    DURATION_IN_MIN,
    NO_OF_PERIODS_OF_15MIN,
    LengthofWorksite,
    NO_OF_LENGTHS_OF_500M,
    Normal_Speed_limit,
    Reduce_Speed_limit,
    SpeedReducationGreaterThan10,
    Total_No_Lanes,
    No_of_Lanes as No_lane_access_lanes, -- lanes_open,
    Divided_Section,
    Lane_access_units,
    max(Traffic_Vol) as Max_Hourly_Traf_Vol,
    Allowed_Hourly_Traf_Vol_PerLane,
    IsOneLaneOpenIsSameDirection,
    LA_Link,
    Work_Order_Link
  from
    all_traffic_data
  group by
    Reporting_ID,
    RecordID,
    Work_Order_Type,
    Work_Order_Number,
    Access_Type,
    RN,
    MOA_REF,
    assettype,
    AssetName,
    activitycategorycode,
    activitycode,
    intervention_level,
    Exempted,
    RoadNo,
    direction,
    Parent_Asset_chainage,
    ClosureType,
    Day_Type,
    period,
    day_of_week,
    Public_Holiday,
    Holiday_Name,
    start_Time,
    end_Time,
    DURATION_IN_MIN,
    NO_OF_PERIODS_OF_15MIN,
    LengthofWorksite,
    NO_OF_LENGTHS_OF_500M,
    Normal_Speed_limit,
    Reduce_Speed_limit,
    SpeedReducationGreaterThan10,
    Total_No_Lanes,
    No_of_Lanes, -- lanes_open,
    Divided_Section,
    Lane_access_units,
    Allowed_Hourly_Traf_Vol_PerLane,
    IsOneLaneOpenIsSameDirection,
    LA_Link,
    Work_Order_Link
),

lanesclosed as(
  select
    RecordID
  from
    report
  where
    Access_Type = 'Lane Closure'
    and IsOneLaneOpenIsSameDirection = 'No'
),

Access_Full as(
  select
    Reporting_ID,
    a.RecordID,
    Work_Order_Type,
    Work_Order_Number,
    Access_Type,
    RN,
    MOA_REF,
    assettype,
    AssetName,
    activitycategorycode,
    activitycode,
    intervention_level,
    Exempted,
    RoadNo,
    direction,
    Parent_Asset_chainage,
    ClosureType,
    Day_Type,
    period,
    day_of_week,
    Public_Holiday,
    Holiday_Name,
    start_Time,
    end_Time,
    DURATION_IN_MIN,
    NO_OF_PERIODS_OF_15MIN,
    LengthofWorksite,
    NO_OF_LENGTHS_OF_500M,
    Normal_Speed_limit,
    Reduce_Speed_limit,
    SpeedReducationGreaterThan10,
    Total_No_Lanes,
    No_lane_access_lanes,
    case
      when b.RecordID is not null then 0
      when a.IsOneLaneOpenIsSameDirection = 'No' then 0
      when a.IsOneLaneOpenIsSameDirection = 'Yes' and Total_No_Lanes <= No_lane_access_lanes then 1
      when Total_No_Lanes > No_lane_access_lanes then Total_No_Lanes - No_lane_access_lanes
    end as lanes_open,
    Divided_Section,
    Lane_access_units,
    Max_Hourly_Traf_Vol,
    Allowed_Hourly_Traf_Vol_PerLane,
    IsOneLaneOpenIsSameDirection,
    LA_Link,
    Work_Order_Link
  from
    report a
    left join lanesclosed b on a.RecordID = b.RecordID
),

laneOpen as (
  select
    RecordID,
    lanes_open
  from
    Access_Full
  where
    Access_Type = 'Lane Closure'
  group by
    RecordID,
    lanes_open
)

select
  Reporting_ID,
  a.RecordID,
  Work_Order_Type,
  Work_Order_Number,
  Access_Type,
  RN,
  MOA_REF,
  assettype,
  AssetName,
  activitycategorycode,
  activitycode,
  intervention_level,
  Exempted,
  RoadNo,
  direction,
  Parent_Asset_chainage,
  ClosureType,
  Day_Type,
  period,
  day_of_week,
  Public_Holiday,
  Holiday_Name,
  start_Time,
  end_Time,
  DURATION_IN_MIN,
  NO_OF_PERIODS_OF_15MIN,
  LengthofWorksite,
  NO_OF_LENGTHS_OF_500M,
  Normal_Speed_limit,
  Reduce_Speed_limit,
  SpeedReducationGreaterThan10,
  Total_No_Lanes,
  No_lane_access_lanes,
  case
    when a.IsOneLaneOpenIsSameDirection = 'No' then 0
    when b.RecordID is null then a.Total_No_Lanes
    else b.lanes_open
  end as lanes_open,
  Divided_Section,
  Lane_access_units,
  Max_Hourly_Traf_Vol,
  Allowed_Hourly_Traf_Vol_PerLane,
  IsOneLaneOpenIsSameDirection,
  LA_Link,
  Work_Order_Link
from
  Access_Full a
  left join laneOpen b on a.RecordID = b.RecordID
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Reporting_ID` | `string` | Yes |  |
| `RecordID` | `int` | Yes |  |
| `Work_Order_Type` | `string` | Yes |  |
| `Work_Order_Number` | `int` | Yes |  |
| `Access_Type` | `string` | No |  |
| `RN` | `int` | No |  |
| `MOA_REF` | `int` | Yes |  |
| `assettype` | `string` | Yes |  |
| `AssetName` | `string` | Yes |  |
| `activitycategorycode` | `string` | Yes |  |
| `activitycode` | `string` | Yes |  |
| `intervention_level` | `string` | Yes |  |
| `Exempted` | `string` | No |  |
| `RoadNo` | `string` | Yes |  |
| `direction` | `string` | Yes |  |
| `Parent_Asset_chainage` | `bigint` | Yes |  |
| `ClosureType` | `string` | Yes |  |
| `Day_Type` | `string` | No |  |
| `period` | `string` | Yes |  |
| `day_of_week` | `string` | Yes |  |
| `Public_Holiday` | `string` | No |  |
| `Holiday_Name` | `string` | Yes |  |
| `start_Time` | `timestamp` | Yes |  |
| `end_Time` | `timestamp` | Yes |  |
| `DURATION_IN_MIN` | `bigint` | Yes |  |
| `NO_OF_PERIODS_OF_15MIN` | `bigint` | Yes |  |
| `LengthofWorksite` | `int` | Yes |  |
| `NO_OF_LENGTHS_OF_500M` | `bigint` | Yes |  |
| `Normal_Speed_limit` | `int` | Yes |  |
| `Reduce_Speed_limit` | `int` | Yes |  |
| `SpeedReducationGreaterThan10` | `string` | No |  |
| `Total_No_Lanes` | `bigint` | Yes |  |
| `No_lane_access_lanes` | `int` | Yes |  |
| `lanes_open` | `bigint` | Yes |  |
| `Divided_Section` | `string` | No |  |
| `Lane_access_units` | `bigint` | Yes |  |
| `Max_Hourly_Traf_Vol` | `bigint` | Yes |  |
| `Allowed_Hourly_Traf_Vol_PerLane` | `int` | No |  |
| `IsOneLaneOpenIsSameDirection` | `string` | Yes |  |
| `LA_Link` | `string` | Yes |  |
| `Work_Order_Link` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
