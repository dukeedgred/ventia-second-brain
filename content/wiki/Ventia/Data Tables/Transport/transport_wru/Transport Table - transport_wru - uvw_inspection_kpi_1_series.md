---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_inspection_kpi_1_series
full-name: transport_dev.transport_wru.uvw_inspection_kpi_1_series
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_inspection_kpi_1_series

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_inspection_kpi_1_series` |
| Full name | `transport_dev.transport_wru.uvw_inspection_kpi_1_series` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 28 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | KPI / reporting |
| Owner/SME | rui.luan@ventia.com |
| Refresh/freshness | Created: 2026-01-12T05:03:58.682Z; Last altered: 2026-01-12T05:03:58.682Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
with preData as (
  select
    dateuid,
    RdNo,
    RdName,
    section_name,
    Section_Desc,
    Rd_Desc,
    InspRunType,
    Forward_Start_Chainage,
    Forward_End_Chainage,
    Reverse_Start_Chainage,
    Reverse_End_Chainage,
    Inspection_Type,
    type,
    --lag(completeddate) over(partition by Section_Desc, Inspection_Type, type order by completeddate) as Previous_InspDate,
    --date_format(lag(completeddate) over(partition by Section_Desc, Inspection_Type, type order by completeddate),'E' ) as Previous_InspDay,
    completeddate,
    completedDay,
    --completedTime
    --datediff(completeddate, lag(completeddate) over(partition by Section_Desc, Inspection_Type, type order by completeddate)) as Days_Since_LastInsp,
    classification,
    KPI_Reference,
    date_format(completeddate, 'yyyyMM') as Reporting_ID,
    concat(
      date_format(completeddate, 'yyyyMM'), '_', inspection_Type, '_', section_desc
    ) as section_Reporting_ID,
    case
      when
        Forward = ''
        or Forward is null
      then
        Reverse
      else Forward
    end as F_Insp,
    case
      when
        Reverse = ''
        or Reverse is null
      then
        Forward
      else Reverse
    end as R_Insp,
    case
      when
        Forward = ''
        or Forward is null
      then
        concat('https://vicroads.assetvision.com.au/Inspections/ViewInspection/', Reverse)
      else concat('https://vicroads.assetvision.com.au/Inspections/ViewInspection/', Forward)
    end as F_Insp_AV_LInk,
    case
      when
        Reverse = ''
        or Reverse is null
      then
        concat('https://vicroads.assetvision.com.au/Inspections/ViewInspection/', Forward)
      else concat('https://vicroads.assetvision.com.au/Inspections/ViewInspection/', Reverse)
    end as R_Insp_AV_LInk
  from
    (
      select
        dateuid,
        assetcode as RdNo,
        asset_name as RdName,
        section_name,
        Section_Desc,
        Rd_Desc,
        Forward_Start_Chainage,
        Forward_End_Chainage,
        Reverse_Start_Chainage,
        Reverse_End_Chainage,
        inspectiontypename as Inspection_Type,
        InspRunType,
        type,
        completedDay,
        startdate,
        completeddate,
        --completedTime,
        classification,
        InspRunType,
        direction,
        inspection_ID,
        KPI_Reference
      from
        transport_dev.transport_wru.uvw_inspection_hazard_defect
      where
        Not_Valid_COMS_Insp = 'No'
        or inspection_ID in (2534668,2534670,2534672,2534674,2534671,2534676,2534753,2534762,2534757,2534764,2534755,2534763,2534758,2534761,2534789,2534793,2534791,2534795,2534673,2534677,2534792,2534796,2534790,2534794,2534754,2534759,2534756,2534760,2534669,2534678,2534675,2534679)
      group by
        dateuid,
        assetcode,
        asset_name,
        section_name,
        Section_Desc,
        Rd_Desc,
        Forward_Start_Chainage,
        Forward_End_Chainage,
        Reverse_Start_Chainage,
        Reverse_End_Chainage,
        inspectiontypename,
        InspRunType,
        type,
        completedDay,
        startdate,
        completeddate,
        --completedTime,
        classification,
        InspRunType,
        direction,
        inspection_ID,
        KPI_Reference
    )
      PIVOT (min(inspection_ID) FOR direction in ('Forward', 'Reverse'))
),
inspection_time as (
  select
    dateuid,
    max(completed_time_Full) as completedTime
  from
    transport_dev.transport_wru.uvw_inspection_hazard_defect
  group by
    dateuid
),
inspection_data as (
  select
    b.completedTime,
    lag(b.completedTime) over (
        partition by Section_Desc, Inspection_Type, type
        order by b.completedTime
      ) as Previous_InspDate,
    date_format(
      lag(b.completedTime) over (
          partition by Section_Desc, Inspection_Type, type
          order by b.completedTime
        ),
      'E'
    ) as Previous_InspDay,
    datediff(
      b.completedTime,
      lag(b.completedTime) over (
          partition by Section_Desc, Inspection_Type, type
          order by b.completedTime
        )
    ) as Days_Since_LastInsp,
    a.*
  from
    preData a
      join inspection_time b
        on a.dateuid = b.dateuid
)
select
  case
    --======= Hazard Day Checks ===========
    when
      Previous_Inspdate is null
      or Previous_Inspdate = ''
    then
      'On Time'
    --RMC 2
    when
      classification = 'RMC 2'
      and inspection_Type = 'Hazard Inspection (Day)'
      and (
        completedday = 'Mon'
        or completedDay = 'Tue'
      )
    then
      'On Time'
    when
      classification = 'RMC 2'
      and inspection_Type = 'Hazard Inspection (Day)'
      and (
        completedday = 'Thu'
        or Previous_InspDay = 'Mon'
      )
    then
      'On Time'
    when
      classification = 'RMC 2'
      and inspection_Type = 'Hazard Inspection (Day)'
      and (
        completedday = 'Fri'
        or Previous_InspDay = 'Tue'
      )
    then
      'On Time'
    --RMC 3
    when
      classification = 'RMC 3'
      and inspection_Type = 'Hazard Inspection (Day)'
      and Days_Since_LastInsp <= 7
    then
      'On Time'
    --RMC 5
    when
      classification = 'RMC 5'
      and inspection_Type = 'Hazard Inspection (Day)'
      and completeddate <= date_format(DATEADD(month, 1, Previous_Inspdate), 'yyyy-MM-dd')
    then
      'On Time'
    --======= Hazard Night Checks ===========
    --RMC 2
    when
      inspection_Type = 'Hazard Inspection (Night)'
      and classification = 'RMC 2'
      and completeddate <= last_day(date_format(DATEADD(month, 6, Previous_Inspdate), 'yyyy-MM-dd'))
    then
      'On Time'
    --RMC 3
    when
      inspection_Type = 'Hazard Inspection (Night)'
      and classification = 'RMC 3'
      and completeddate <= last_day(date_format(DATEADD(month, 6, Previous_Inspdate), 'yyyy-MM-dd'))
    then
      'On Time'
    --RMC 5
    when
      inspection_Type = 'Hazard Inspection (Night)'
      and classification = 'RMC 5'
      and completeddate <= last_day(date_format(DATEADD(year, 1, Previous_Inspdate), 'yyyy-MM-dd'))
    then
      'On Time'
    --======= Defect Checks ===========
    when
      inspection_Type = 'Defect Inspection'
    then
      'On Time'
    else 'Late'
  end Compliant_Timing,
  *
from
  inspection_data
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Compliant_Timing` | `string` | No |  |
| `completedTime` | `timestamp` | Yes |  |
| `Previous_InspDate` | `timestamp` | Yes |  |
| `Previous_InspDay` | `string` | Yes |  |
| `Days_Since_LastInsp` | `int` | Yes |  |
| `dateuid` | `string` | Yes |  |
| `RdNo` | `string` | Yes |  |
| `RdName` | `string` | Yes |  |
| `section_name` | `string` | Yes |  |
| `Section_Desc` | `string` | Yes |  |
| `Rd_Desc` | `string` | Yes |  |
| `InspRunType` | `string` | Yes |  |
| `Forward_Start_Chainage` | `bigint` | Yes |  |
| `Forward_End_Chainage` | `bigint` | Yes |  |
| `Reverse_Start_Chainage` | `bigint` | Yes |  |
| `Reverse_End_Chainage` | `bigint` | Yes |  |
| `Inspection_Type` | `string` | Yes |  |
| `type` | `string` | No |  |
| `completeddate` | `string` | Yes |  |
| `completedDay` | `string` | Yes |  |
| `classification` | `string` | Yes |  |
| `KPI_Reference` | `string` | Yes |  |
| `Reporting_ID` | `string` | Yes |  |
| `section_Reporting_ID` | `string` | Yes |  |
| `F_Insp` | `int` | Yes |  |
| `R_Insp` | `int` | Yes |  |
| `F_Insp_AV_LInk` | `string` | Yes |  |
| `R_Insp_AV_LInk` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
