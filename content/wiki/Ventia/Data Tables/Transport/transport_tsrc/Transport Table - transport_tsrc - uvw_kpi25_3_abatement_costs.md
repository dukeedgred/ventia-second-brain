---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: uvw_kpi25_3_abatement_costs
full-name: transport_dev.transport_tsrc.uvw_kpi25_3_abatement_costs
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - uvw_kpi25_3_abatement_costs

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_kpi25_3_abatement_costs` |
| Full name | `transport_dev.transport_tsrc.uvw_kpi25_3_abatement_costs` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | VIEW |
| Column count | 49 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | KPI / reporting |
| Owner/SME | hui.chen@ventia.com |
| Refresh/freshness | Created: 2024-10-23T03:17:46.247Z; Last altered: 2024-10-23T03:17:46.247Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
  WITH AbtTriggers AS(
      WITH DateExpanded(
          SELECT
              a.*,
              b.Date,
              to_date(a.KPI_Assessment_Date) AS KPI_Assessment_Date_time,
              b.`Day of Week`,
              b.Year,
              b.Quarter,
              b.`Week Number`,
              b.Weekday,
              b.PublicHoliday,
              ROW_NUMBER() OVER(PARTITION BY a.id, b.`PublicHoliday`,b.`Weekday` ORDER BY b.`Date`) AS KPI_10BD_Counter,
              --- Version one of the trigger when you only get abated once you reached the end of a rectification period
              CASE WHEN ROUND(ROW_NUMBER() OVER(PARTITION BY a.id, b.`PublicHoliday`,b.`Weekday` ORDER BY b.`Date`)/10,0) =
                              ROW_NUMBER() OVER(PARTITION BY a.id, b.`PublicHoliday`,b.`Weekday` ORDER BY b.`Date`)/10
                      THEN 1 
                      ELSE 0
              END AS KPI_10BD_Trigger,
              --- Version two of the trigger where as soon as you enter into new period you get abated
              CASE WHEN ROW_NUMBER() OVER(PARTITION BY a.id, b.`PublicHoliday`,b.`Weekday` ORDER BY b.`Date`) = 1 THEN 1
                   WHEN mod((ROW_NUMBER() OVER(PARTITION BY a.id, b.`PublicHoliday`,b.`Weekday` ORDER BY b.`Date`)),10) = 1 THEN 1 
                   ELSE 0
              END AS KPI_10BD_Trigger_Partitioned,
              --- Track Event Start or End
              CASE WHEN b.`Date` = TO_DATE(a.KPI_Assessment_Date) THEN 'Event End' 
                      WHEN b.`Date` = TO_DATE(DATEADD(DAY,1,a.KPI_25_ComplianceDueDate)) THEN 'Event Start'
                      ELSE 'NA' 
              END AS `Event_Tracking`,
              --- Calculate how many hours between the assessment date and the compliance date
              CASE WHEN b.`Date` = TO_DATE(a.KPI_Assessment_Date)
                        --- if its on the same day
                        THEN DATEDIFF(HOUR,a.KPI_25_ComplianceDueDate,a.KPI_Assessment_Date)
                        --- if its not on the same day
                        ELSE DATEDIFF(HOUR,a.KPI_25_ComplianceDueDate,TO_TIMESTAMP(CONCAT(b.Date,' 23:59:00')))
              END AS KPI_2XRT_Timer_hr

          FROM
          --- Filter only for abated events
          (SELECT *
          FROM transport_dev.transport_tsrc.utbl_asset_perf_maint_kpi25_3
          WHERE compliantstatus = 'Late' OR compliantstatus= 'Overdue') a
          --- Join with business days from date table
          LEFT JOIN transport_dev.transport_tsrc.utbl_ref_date_table b
          ON b.`Date` > a.KPI_25_ComplianceDueDate AND b.`Date` <= a.KPI_Assessment_Date
      )

      SELECT 
          *,
              --- Calculate how many multiples of the rectificaiton period rounded down
              FLOOR(
              CASE WHEN Response_IntervalUnit = "Hour" THEN FLOAT(KPI_2XRT_Timer_hr)/FLOAT(ResponseValue_ScheduleInterval)
                   WHEN Response_IntervalUnit = "Day" THEN FLOAT(KPI_2XRT_Timer_hr)/FLOAT(ResponseValue_ScheduleInterval*24)
                   WHEN Response_IntervalUnit = "Week" THEN FLOAT(KPI_2XRT_Timer_hr)/FLOAT(ResponseValue_ScheduleInterval*7*24)
                   ELSE FLOAT(KPI_2XRT_Timer_hr)/FLOAT(ResponseValue_ScheduleInterval*30*24)
              END,0) AS KPI_2XRT_Trigger_floor,
              --- Calculate how many multiples of the rectificaiton period rounded up
              CEILING(
              CASE WHEN Response_IntervalUnit = "Hour" THEN FLOAT(KPI_2XRT_Timer_hr)/FLOAT(ResponseValue_ScheduleInterval)
                   WHEN Response_IntervalUnit = "Day" THEN FLOAT(KPI_2XRT_Timer_hr)/FLOAT(ResponseValue_ScheduleInterval*24)
                   WHEN Response_IntervalUnit = "Week" THEN FLOAT(KPI_2XRT_Timer_hr)/FLOAT(ResponseValue_ScheduleInterval*7*24)
                   ELSE FLOAT(KPI_2XRT_Timer_hr)/FLOAT(ResponseValue_ScheduleInterval*30*24)
              END,0) AS KPI_2XRT_Trigger_ceiling,
              --- Calculate Initial Abatement Costs
              CASE WHEN Event_Tracking = "Event Start" AND KPI_Criticality = "KPI - Critical" THEN 500
                   WHEN Event_Tracking = "Event Start" AND KPI_Criticality = "KPI - Non-Critical" THEN 250
                   ELSE 0
              END AS Initial_Abt_Cost
      FROM DateExpanded
      ORDER BY id, `Date`
  )

  SELECT
    *,
    ROW_NUMBER() OVER(PARTITION BY id, KPI_2XRT_Trigger_floor ORDER BY `Date`) AS KPI_2XRT_Counter,
    --- Calculate Ongoing Abatement Costs
    CASE WHEN (KPI_25_ComplianceDueDate_Type = "10 Business Days" AND KPI_10BD_Trigger = 1)
              OR
              (KPI_25_ComplianceDueDate_Type = "Twice Response time"
              AND KPI_2XRT_Trigger_floor > 0 
              AND ROW_NUMBER() OVER(PARTITION BY id, KPI_2XRT_Trigger_floor ORDER BY `Date`) = 1)
        THEN CASE WHEN KPI_Criticality = "KPI - Critical" THEN 1000 ELSE 500 END
    ELSE 0
    END AS Ongoing_Abt_Cost,
    --- Calculate Ongoing Abatement Costs - rounded up version
    CASE WHEN (KPI_25_ComplianceDueDate_Type = "10 Business Days" AND KPI_10BD_Trigger_Partitioned = 1)
              OR
              (KPI_25_ComplianceDueDate_Type = "Twice Response time"
              AND KPI_2XRT_Trigger_ceiling > 0 
              AND ROW_NUMBER() OVER(PARTITION BY id, KPI_2XRT_Trigger_ceiling ORDER BY `Date`) = 1)
        THEN CASE WHEN KPI_Criticality = "KPI - Critical" THEN 1000 ELSE 500 END
    ELSE 0
    END AS Ongoing_Abt_Cost_ceiling
  FROM AbtTriggers
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `id` | `int` | Yes |  |
| `AV_Link` | `string` | Yes |  |
| `assettypename` | `string` | Yes |  |
| `assetcode` | `string` | Yes |  |
| `activitycategorycode` | `string` | Yes |  |
| `activitycode` | `string` | Yes |  |
| `activityname` | `string` | Yes |  |
| `activitytype` | `string` | Yes |  |
| `interventioncode` | `string` | Yes |  |
| `fullinterventioncode` | `string` | Yes |  |
| `interventionname` | `string` | Yes |  |
| `interventionreference1` | `string` | Yes |  |
| `interventionreference2` | `string` | Yes |  |
| `createddate_time` | `timestamp` | Yes |  |
| `duedate_time` | `timestamp` | Yes |  |
| `completeddate_time` | `timestamp` | Yes |  |
| `createddate` | `date` | Yes |  |
| `duedate` | `date` | Yes |  |
| `completeddate` | `date` | Yes |  |
| `completedstatus` | `string` | Yes |  |
| `priority` | `string` | Yes |  |
| `KPI_Criticality` | `string` | Yes |  |
| `ResponseValue_ScheduleInterval` | `bigint` | Yes |  |
| `Response_IntervalUnit` | `string` | Yes |  |
| `KPI_TwiceDueDate` | `timestamp` | Yes |  |
| `KPI_Add10_BusDays` | `timestamp` | Yes |  |
| `KPI_25_ComplianceDueDate` | `timestamp` | Yes |  |
| `KPI_25_ComplianceDueDate_Type` | `string` | Yes |  |
| `KPI_Assessment_Date` | `timestamp` | Yes |  |
| `compliantstatus` | `string` | Yes |  |
| `Date` | `date` | Yes |  |
| `KPI_Assessment_Date_time` | `date` | Yes |  |
| `Day of Week` | `string` | Yes |  |
| `Year` | `bigint` | Yes |  |
| `Quarter` | `string` | Yes |  |
| `Week Number` | `bigint` | Yes |  |
| `Weekday` | `string` | Yes |  |
| `PublicHoliday` | `string` | Yes |  |
| `KPI_10BD_Counter` | `int` | No |  |
| `KPI_10BD_Trigger` | `int` | No |  |
| `KPI_10BD_Trigger_Partitioned` | `int` | No |  |
| `Event_Tracking` | `string` | No |  |
| `KPI_2XRT_Timer_hr` | `bigint` | Yes |  |
| `KPI_2XRT_Trigger_floor` | `decimal(16,0)` | Yes |  |
| `KPI_2XRT_Trigger_ceiling` | `decimal(16,0)` | Yes |  |
| `Initial_Abt_Cost` | `int` | No |  |
| `KPI_2XRT_Counter` | `int` | No |  |
| `Ongoing_Abt_Cost` | `int` | No |  |
| `Ongoing_Abt_Cost_ceiling` | `int` | No |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
