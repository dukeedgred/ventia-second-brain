---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: uvw_kpi3_abatement_costs
full-name: transport_dev.transport_tsrc.uvw_kpi3_abatement_costs
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - uvw_kpi3_abatement_costs

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_kpi3_abatement_costs` |
| Full name | `transport_dev.transport_tsrc.uvw_kpi3_abatement_costs` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | VIEW |
| Column count | 64 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | KPI / reporting |
| Owner/SME | unknown |
| Refresh/freshness | Created: 2024-10-22T22:38:24.488Z; Last altered: 2024-10-22T22:38:24.488Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
WITH kpi3abatementcost AS (
  WITH kpi3businessday AS (
    SELECT
      kpi3.*,
      concat(`Year`, `Quarter`) as RepQtrKey,
      `Year`,
      `Quarter`, 
      getdate() as TodaysDate,
      case when ((8-(17 - Hour(getdate()))) / 8) < 0 then 0
          when ((8-(17 - Hour(getdate()))) / 8) > 1 then 1
          else ((8-(17 - Hour(getdate()))) / 8)
      end as PartialDay,
      cast(count(1) as int) as BusinessDaysLateinQTR,
      (select max(RepQtrKey) from
        (select concat(`Year`, `Quarter`) as RepQtrKey, `Year`, `Quarter`, count(1) as BusinessDays 
        from transport_dev.transport_tsrc.utbl_ref_date_table
        where (`Date` > to_date(`due date`) and 
        `Date` < to_date(getdate()))
        and (Weekday = 'Yes' and PublicHoliday = 'No')
        group by `Quarter`, `Year`)
      ) AS maxYearQtr, 
      (select min(RepQtrKey) from
        (select concat(`Year`, `Quarter`) as RepQtrKey, `Year`, `Quarter`, count(1) as BusinessDays 
        from transport_dev.transport_tsrc.utbl_ref_date_table
        where (`Date` > to_date(`due date`) and 
        `Date` < to_date(getdate()))
        and (Weekday = 'Yes' and PublicHoliday = 'No')
        group by `Quarter`, `Year`)
      ) AS minYearQtr

    FROM transport_dev.transport_tsrc.uvw_kpi3_road_safety kpi3
    left join transport_dev.transport_tsrc.utbl_ref_date_table
    where (`Date` > to_date(`due date`) and 
    `Date` < to_date(getdate()))
    and (Weekday = 'Yes' and PublicHoliday = 'No') and 
    `Completion Status` = 'Open' and
    `Progress Status` = 'Overdue'
    group by all

    union all

    SELECT 
      kpi3.*, 
      concat(`Year`, `Quarter`) as RepQtrKey,
      `Year`,
      `Quarter`,
      getdate() as TodaysDate,
      case when ((8-(17 - Hour(to_timestamp(`task actual finish`)))) / 8) < 0 then 0
           when ((8-(17 - Hour(to_timestamp(`task actual finish`)))) / 8) > 1 then 1
           else ((8-(17 - Hour(to_timestamp(`task actual finish`)))) / 8)
      end as PartialDay,
      cast(count(1) as int) as BusinessDaysLateinQTR,
      (select max(RepQtrKey) from
        (select concat(`Year`, `Quarter`) as RepQtrKey, `Year`, `Quarter`, count(1) as BusinessDays
         FROM transport_dev.transport_tsrc.utbl_ref_date_table
         where (`Date` < to_date(`task actual finish`) and 
         `Date` > to_date(`due date`))
         and (Weekday = 'Yes' and PublicHoliday = 'No')
         group by `Quarter`, `Year`)
      ) as maxYearQtr,
      (select min(RepQtrKey) from
        (select concat(`Year`, `Quarter`) as RepQtrKey, `Year`, `Quarter`, count(1) as BusinessDays 
         from transport_dev.transport_tsrc.utbl_ref_date_table
         where (`Date` > to_date(`due date`) and 
         `Date` < to_date(getdate()))
         and (Weekday = 'Yes' and PublicHoliday = 'No')
         group by `Quarter`, `Year`)
      ) AS minYearQtr

    From transport_dev.transport_tsrc.uvw_kpi3_road_safety kpi3
    left join transport_dev.transport_tsrc.utbl_ref_date_table
    where 
    (`Date` < to_date(`task actual finish`) and 
    `Date` > to_date(`due date`))
    and (Weekday = 'Yes' and PublicHoliday = 'No') and 
    `Completion Status` = 'Completed' and
    `Progress Status` = 'Overdue'
    group by all

  )
  SELECT 
    kpi3bd.*, 
    CASE WHEN `Completion Status` = 'Open' and `Progress Status` = 'Overdue' and RepQtrKey = minYearQtr and RepQtrKey = maxYearQtr then BusinessDaysLateinQTR + PartialDay
        WHEN `Completion Status` = 'Open' and `Progress Status` = 'Overdue' and RepQtrKey = minYearQtr then BusinessDaysLateinQTR
        WHEN `Completion Status` = 'Open' and `Progress Status` = 'Overdue' and RepQtrKey = maxYearQtr then BusinessDaysLateinQTR + PartialDay
        WHEN `Completion Status` = 'Completed' and `Progress Status` = 'Overdue' and RepQtrKey = minYearQtr and RepQtrKey = maxYearQtr then BusinessDaysLateinQTR + PartialDay
        WHEN `Completion Status` = 'Completed' and `Progress Status` = 'Overdue' and RepQtrKey = minYearQtr then  BusinessDaysLateinQTR + PartialDay
        WHEN `Completion Status` = 'Completed' and `Progress Status` = 'Overdue' and RepQtrKey = maxYearQtr then  BusinessDaysLateinQTR
    ELSE 0
    END AS TotalBusinessDaysLateinQtr

  FROM kpi3businessday kpi3bd
)

SELECT 
  kpi3ac.*,
  CASE WHEN `Completion Status` = 'Open' and `Progress Status` = 'Overdue' and RepQtrKey = minYearQtr and RepQtrKey = maxYearQtr 
            THEN 50000.0 + (FLOOR(TotalBusinessDaysLateinQtr,0) * 5000.0)
       WHEN `Completion Status` = 'Open' and `Progress Status` = 'Overdue' and RepQtrKey = minYearQtr
            THEN 50000.0 + (FLOOR(TotalBusinessDaysLateinQtr,0) * 5000.0)
       WHEN `Completion Status` = 'Open' and `Progress Status` = 'Overdue' and RepQtrKey = maxYearQtr 
            THEN (FLOOR(TotalBusinessDaysLateinQtr,0) * 5000.0)
       WHEN `Completion Status` = 'Completed' and `Progress Status` = 'Overdue' and RepQtrKey = minYearQtr and RepQtrKey = maxYearQtr 
            THEN 50000.0 + (FLOOR(TotalBusinessDaysLateinQtr,0) * 5000.0)
       WHEN `Completion Status` = 'Completed' and `Progress Status` = 'Overdue' and RepQtrKey = minYearQtr
            THEN 50000.0 + (FLOOR(TotalBusinessDaysLateinQtr,0) * 5000.0) 
       WHEN `Completion Status` = 'Completed' and `Progress Status` = 'Overdue' and RepQtrKey = maxYearQtr
            THEN (FLOOR(TotalBusinessDaysLateinQtr,0) * 5000.0)
  ELSE 0 end as AbabementCostinQTR

FROM kpi3abatementcost kpi3ac
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
| `RepQtrKey` | `string` | Yes |  |
| `Year` | `bigint` | Yes |  |
| `Quarter` | `string` | Yes |  |
| `TodaysDate` | `timestamp` | No |  |
| `PartialDay` | `double` | Yes |  |
| `BusinessDaysLateinQTR` | `int` | No |  |
| `maxYearQtr` | `string` | Yes |  |
| `minYearQtr` | `string` | Yes |  |
| `TotalBusinessDaysLateinQtr` | `double` | Yes |  |
| `AbabementCostinQTR` | `decimal(23,1)` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
