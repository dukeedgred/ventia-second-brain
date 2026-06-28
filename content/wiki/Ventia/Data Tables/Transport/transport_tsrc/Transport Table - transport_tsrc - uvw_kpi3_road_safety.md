---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: uvw_kpi3_road_safety
full-name: transport_dev.transport_tsrc.uvw_kpi3_road_safety
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - uvw_kpi3_road_safety

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_kpi3_road_safety` |
| Full name | `transport_dev.transport_tsrc.uvw_kpi3_road_safety` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | VIEW |
| Column count | 54 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | KPI / reporting |
| Owner/SME | unknown |
| Refresh/freshness | Created: 2024-07-15T05:37:31.984Z; Last altered: 2024-10-22T22:38:08.816Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
with kpi3_compliance as
(
with kpi3_completed_status as 
(
  with tmp as (
select 
  cw.id as `capital works id`
, CONCAT('https://gen7.assetvision.com.au/CapitalWorks/ViewCapitalWork/',cw.id) AS `capital works id link`
, cw.name as `capital works name`
, cw.description as `capital works description`
, cw.capitalworktype
, cw.assettypename as `capital works asset type`
, cw.assetid as `capital works asset id`
, cw.assetcode as `capital works asset code`
, cw.assetname as `capital works asset name`
, cw.section as `capital works section`
, case 
  when cw.direction = '1 or 2' then 'Westbound'
  when cw.direction = '3' then 'Eastbound'
  else null
  end as `capital works direction`
, cw.chainagefrom as `capital works chainagefrom`
, cw.chainageto as `capital works chainageto`
, cw.contract
, cw.plannedstart as `capital works planned start`
, cw.plannedfinish as `capital works planned finish`
, cw.actualstart as `capital works actual start`
, cw.actualfinish as `capital works actual finish`
, cw.reference1 as `capital works reference1`
, cw.reference2 as `capital works reference2`
, cw.bothdirections as `capital works both directions`
--, cw.spatialinfo as `capital works spatialinfo`
, cwt.id as `task id`
, cwt.name as `task name`
, cwt.description as `task description`
, cwt.plannedstart as `task planned start`
, cwt.plannedfinish as `task planned finish` 
, cwt.actualstart as `task actual start`
, cwt.actualfinish as `task actual finish`
, cwt.estimatedquantity
, cwt.actualquantity
, cwt.unit
, cwt.estimatedcost
, cwt.actualcost
, cwt.reference1 as `task reference1`
, cwt.reference2 as `task reference2`
, cwt.comments as `task comments`
, cwt.assettypename as `task asset type name`
, cwt.assetid as `task asset id`
, cwt.assetcode as `task asset code`
, cwt.assetname as `task asset name`
, cwt.section as `task section`
, case 
  when cwt.direction = '1 or 2' then 'Westbound'
  when cwt.direction = '3' then 'Eastbound'
  else null
  end as `task direction`
, cwt.chainagefrom as `task chainagefrom`
, cwt.chainageto as `task chainageto`
, cwt.bothdirections as `task both directions` 
--, cwt.spatialinfo as `task spatialinfo`
, case
when replace(left(cwt.WKT, CHARINDEX(', POINT ', cwt.WKT) -1), 'GEOMETRYCOLLECTION (', '') = '' then cwt.WKT
else replace(left(cwt.WKT, CHARINDEX(', POINT ', cwt.WKT) -1), 'GEOMETRYCOLLECTION (', '') end as WKT
, f.name
, f.value
from
  ext_mssql_asset_vision_ven_gen7.dbo.vcapitalwork cw
  left join ext_mssql_asset_vision_ven_gen7.dbo.vcapitalworktask cwt on cwt.capitalworkid = cw.id
  and cwt.deleted = false
  --and cwt.source_database_name = 'DataServices_VEN_Gen7'
  left join ext_mssql_asset_vision_ven_gen7.dbo.formfield f on f.sourcetableid = cwt.id 
where
  cw.deleted = false
  and cw.contract = 'Toowoomba Second Range Crossing'
  and cw.capitalworktype = 'Road Safety Improvement'
order by
  cw.id,
  cwt.sortorder
)
select * from tmp
pivot (
  max(value) for name in (
'Road Safety Report Task Details|Contractual Due Date' as `Contractual Due Date`,
'Road Safety Report Task Details|Report Task ID/Reference' as `Report Task ID/Reference`
  )
)
)

select 
compstat.* 
, to_timestamp(`Contractual Due Date`, 'd/M/yyyy H:m:s') as `due date`
, case 
when `task actual finish` <> '' then 'Completed' 
else 'Open'
end as `Completion Status`
from kpi3_completed_status compstat
)

Select 
comp.*
, case
when `Completion Status` = 'Open' and getdate() < `due date` then 'On track'
when `Completion Status` = 'Completed' and `task actual finish` < `due date` then 'On time'
when `Completion Status` = 'Completed' and `task actual finish` > `due date` then 'Overdue'
when `Completion Status` = 'Open' and  getdate() > `due date` then 'Overdue'
else 'DQ Issue'
end as `Progress Status`

--f1.Date = Due Date, f2.Date = Today's date and f3.Date = Actual Finish Date
, case when `Completion Status` = 'Open' and `Progress Status` = 'Overdue' 
then (select count(1) from utbl_ref_date_table dt
where f1.`Date` < dt.`Date`
and f2.`Date` >= dt.`Date`
and dt.Weekday = 'Yes'
and dt.PublicHoliday = 'No') 
else 0
end as IncompleteDaysOverdue

, case
when `Completion Status` = 'Completed' and `Progress Status` = 'On time' then 0
else (select count(1) from utbl_ref_date_table dt
where f1.`Date` > dt.`Date`
and f2.`Date` <= dt.`Date`
and dt.Weekday = 'Yes'
and dt.PublicHoliday = 'No') 
end as DaysUntilOverdue

, case
when `Completion Status` = 'Completed' and `Progress Status` = 'Overdue' 
then (select count(1) from utbl_ref_date_table dt
where f1.`Date` < dt.`Date`
and f3.`Date` >= dt.`Date`
and dt.Weekday = 'Yes'
and dt.PublicHoliday = 'No') 
else 0
end as CompletedDaysOverdue

from kpi3_compliance comp

left join utbl_ref_date_table f1
on to_date(f1.`Date`) = to_date(`due date`)

left join utbl_ref_date_table f3
on to_date(f3.`Date`) = to_date(`task actual finish`)

inner join utbl_ref_date_table f2
on f2.`Date` = date(getdate())


)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `capital works id` | `int` | Yes |  |
| `capital works id link` | `string` | Yes |  |
| `capital works name` | `string` | Yes |  |
| `capital works description` | `string` | Yes |  |
| `capitalworktype` | `string` | Yes |  |
| `capital works asset type` | `string` | Yes |  |
| `capital works asset id` | `int` | Yes |  |
| `capital works asset code` | `string` | Yes |  |
| `capital works asset name` | `string` | Yes |  |
| `capital works section` | `string` | Yes |  |
| `capital works direction` | `string` | Yes |  |
| `capital works chainagefrom` | `int` | Yes |  |
| `capital works chainageto` | `int` | Yes |  |
| `contract` | `string` | Yes |  |
| `capital works planned start` | `timestamp` | Yes |  |
| `capital works planned finish` | `timestamp` | Yes |  |
| `capital works actual start` | `timestamp` | Yes |  |
| `capital works actual finish` | `timestamp` | Yes |  |
| `capital works reference1` | `string` | Yes |  |
| `capital works reference2` | `string` | Yes |  |
| `capital works both directions` | `string` | Yes |  |
| `task id` | `int` | Yes |  |
| `task name` | `string` | Yes |  |
| `task description` | `string` | Yes |  |
| `task planned start` | `timestamp` | Yes |  |
| `task planned finish` | `timestamp` | Yes |  |
| `task actual start` | `timestamp` | Yes |  |
| `task actual finish` | `timestamp` | Yes |  |
| `estimatedquantity` | `decimal(10,3)` | Yes |  |
| `actualquantity` | `decimal(10,3)` | Yes |  |
| `unit` | `string` | Yes |  |
| `estimatedcost` | `decimal(18,2)` | Yes |  |
| `actualcost` | `decimal(18,2)` | Yes |  |
| `task reference1` | `string` | Yes |  |
| `task reference2` | `string` | Yes |  |
| `task comments` | `string` | Yes |  |
| `task asset type name` | `string` | Yes |  |
| `task asset id` | `int` | Yes |  |
| `task asset code` | `string` | Yes |  |
| `task asset name` | `string` | Yes |  |
| `task section` | `string` | Yes |  |
| `task direction` | `string` | Yes |  |
| `task chainagefrom` | `int` | Yes |  |
| `task chainageto` | `int` | Yes |  |
| `task both directions` | `string` | Yes |  |
| `WKT` | `string` | Yes |  |
| `Contractual Due Date` | `string` | Yes |  |
| `Report Task ID/Reference` | `string` | Yes |  |
| `due date` | `timestamp` | Yes |  |
| `Completion Status` | `string` | No |  |
| `Progress Status` | `string` | No |  |
| `IncompleteDaysOverdue` | `bigint` | Yes |  |
| `DaysUntilOverdue` | `bigint` | Yes |  |
| `CompletedDaysOverdue` | `bigint` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
