---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: uvw_kpi25_2_abatement_costs
full-name: transport_dev.transport_tsrc.uvw_kpi25_2_abatement_costs
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - uvw_kpi25_2_abatement_costs

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_kpi25_2_abatement_costs` |
| Full name | `transport_dev.transport_tsrc.uvw_kpi25_2_abatement_costs` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | VIEW |
| Column count | 35 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | KPI / reporting |
| Owner/SME | hui.chen@ventia.com |
| Refresh/freshness | Created: 2024-10-24T05:09:35.94Z; Last altered: 2024-10-24T05:09:35.94Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
with step3 as (
    WITH step2 AS (
        WITH step1 AS (
            SELECT  
                code
                , assettype
                , `Asset_Type`
                , `Asset_Raised_Against`
                , `Activity_Name`
                , Frequency
                , EarliestStartDate
                , DueDate
                , Completeddate
                , NonCompliantDate
                , ComplianceStatus
                , AdditionalRectificationPeriod
                , `ReqMaintId`
                , AssessmentDate
                , concat(code,`Activity_Name`, EarliestStartDate, DueDate) as InspKey
            FROM transport_dev.transport_tsrc.utbl_asset_perf_maint_kpi25_2
            --- Filtering only for overdue or late events
            WHERE ComplianceStatus IN ('Overdue', 'Late')

            )

            SELECT
            step1.*
            , ( SELECT 
                max(`Date`) AS `Date`
                FROM (
                    SELECT 
                        `Date`
                        , row_number() OVER (ORDER BY `Date` ASC) AS row_no
                    FROM transport_dev.transport_tsrc.utbl_ref_date_table
                    WHERE `Date` > to_date(DueDate)
                    AND (Weekday = 'Yes' AND PublicHoliday = 'No')
                    ORDER BY `Date` ASC
                    LIMIT 20)   
                WHERE row_no = AdditionalRectificationPeriod) 
                --- AKA Compliance Due Date
                AS `EndAdditionalRectificationPeriod`
                FROM step1

            )

        SELECT
        a.*
        , b.Date
        , to_date(a.`AssessmentDate`) AS KPI_Assessment_Date_time
        , b.`Day of Week`
        , b.Year
        , b.Quarter
        , b.`Week Number`
        , b.Weekday
        , b.PublicHoliday,
        --- Create a row number to count the number of Business days
        ROW_NUMBER() OVER(PARTITION BY a.`ReqMaintId` ORDER BY b.`Date`) AS KPI_BD_Counter,
        --- Set which days triggers an abatement - 5 buisness day rectification period
        CASE WHEN ROUND(
                    ROW_NUMBER() OVER(PARTITION BY a.`ReqMaintId` ORDER BY b.`Date`)/5,0) =
                    ROW_NUMBER() OVER(PARTITION BY a.`ReqMaintId` ORDER BY b.`Date`)/5
             THEN 1 
             ELSE 0
        END AS KPI_5BD_Trigger,
        --- Set which days triggers an abatement - 5 buisness day rectification period - Ceiling version
        CASE WHEN ROW_NUMBER() OVER(PARTITION BY a.`ReqMaintId` ORDER BY b.`Date`) = 1 THEN 1
             WHEN mod((ROW_NUMBER() OVER(PARTITION BY a.`ReqMaintId` ORDER BY b.`Date`)),5) = 1 THEN 1 
             ELSE 0
        END AS KPI_5BD_Trigger_Ceiling,
        --- Set which days triggers an abatement - 10 buisness day rectification period
        CASE WHEN ROUND(
                    ROW_NUMBER() OVER(PARTITION BY a.`ReqMaintId` ORDER BY b.`Date`)/10,0) =
                    ROW_NUMBER() OVER(PARTITION BY a.`ReqMaintId` ORDER BY b.`Date`)/10
             THEN 1 
             ELSE 0
        END AS KPI_10BD_Trigger,
        --- Set which days triggers an abatement - 10 buisness day rectification period - Ceiling version
        CASE WHEN ROW_NUMBER() OVER(PARTITION BY a.`ReqMaintId` ORDER BY b.`Date`) = 1 THEN 1
             WHEN mod((ROW_NUMBER() OVER(PARTITION BY a.`ReqMaintId` ORDER BY b.`Date`)),10) = 1 THEN 1 
             ELSE 0
        END AS KPI_10BD_Trigger_Ceiling,
        --- Set which days triggers an abatement - 20 buisness day rectification period
        CASE WHEN ROUND(
                    ROW_NUMBER() OVER(PARTITION BY a.`ReqMaintId` ORDER BY b.`Date`)/20,0) =
                    ROW_NUMBER() OVER(PARTITION BY a.`ReqMaintId` ORDER BY b.`Date`)/20
             THEN 1 
             ELSE 0
        END AS KPI_20BD_Trigger,
        --- Set which days triggers an abatement - 20 buisness day rectification period - Ceiling version
        CASE WHEN ROW_NUMBER() OVER(PARTITION BY a.`ReqMaintId` ORDER BY b.`Date`) = 1 THEN 1
             WHEN mod((ROW_NUMBER() OVER(PARTITION BY a.`ReqMaintId` ORDER BY b.`Date`)),20) = 1 THEN 1 
             ELSE 0
        END AS KPI_20BD_Trigger_Ceiling,
        --- For tracking start and end events
        CASE 
            WHEN b.`Date` = TO_DATE(a.`AssessmentDate`) THEN 'Event End' 
            WHEN b.`Date` = TO_DATE(DATEADD(DAY,1,a.`EndAdditionalRectificationPeriod`)) THEN 'Event Start'
            ELSE 'NA' 
            END AS `Event_Tracking`
        FROM step2 a
        --- Join with reference date table for only business days
        LEFT JOIN transport_dev.transport_tsrc.utbl_ref_date_table b
        WHERE (((`Date` > to_date(EndAdditionalRectificationPeriod) 
        AND `Date` <= to_date(`AssessmentDate`))
        AND (Weekday = 'Yes' and PublicHoliday = 'No')))

        )

    SELECT 
      a.*,
      --- Initial Abatement Cost - Event Trigger
      CASE WHEN Event_Tracking = "Event Start" THEN 250
           ELSE 0
      END AS Initial_Abt_Cost,
      --- Ongoing Abatement Cost - triggered at end of rectification period
      CASE WHEN AdditionalRectificationPeriod = '5' AND KPI_5BD_Trigger = 1 THEN 500
           WHEN AdditionalRectificationPeriod = '10' AND KPI_10BD_Trigger = 1 THEN 500
           WHEN AdditionalRectificationPeriod = '20' AND KPI_20BD_Trigger = 1 THEN 500
           ELSE 0
      END AS Ongoing_Abt_Cost,
      --- Ongoing Abatement Cost - triggered at end of rectification period
      CASE WHEN AdditionalRectificationPeriod = '5' AND KPI_5BD_Trigger_Ceiling = 1 THEN 500
           WHEN AdditionalRectificationPeriod = '10' AND KPI_10BD_Trigger_Ceiling = 1 THEN 500
           WHEN AdditionalRectificationPeriod = '20' AND KPI_20BD_Trigger_Ceiling = 1 THEN 500
           ELSE 0
      END AS Ongoing_Abt_Cost_Ceiling

    FROM step3 a
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `code` | `string` | Yes |  |
| `assettype` | `string` | Yes |  |
| `Asset_Type` | `string` | Yes |  |
| `Asset_Raised_Against` | `string` | Yes |  |
| `Activity_Name` | `string` | Yes |  |
| `Frequency` | `string` | Yes |  |
| `EarliestStartDate` | `date` | Yes |  |
| `DueDate` | `date` | Yes |  |
| `Completeddate` | `date` | Yes |  |
| `NonCompliantDate` | `date` | Yes |  |
| `ComplianceStatus` | `string` | Yes |  |
| `AdditionalRectificationPeriod` | `int` | Yes |  |
| `ReqMaintId` | `string` | Yes |  |
| `AssessmentDate` | `date` | Yes |  |
| `InspKey` | `string` | Yes |  |
| `EndAdditionalRectificationPeriod` | `date` | Yes |  |
| `Date` | `date` | Yes |  |
| `KPI_Assessment_Date_time` | `date` | Yes |  |
| `Day of Week` | `string` | Yes |  |
| `Year` | `bigint` | Yes |  |
| `Quarter` | `string` | Yes |  |
| `Week Number` | `bigint` | Yes |  |
| `Weekday` | `string` | Yes |  |
| `PublicHoliday` | `string` | Yes |  |
| `KPI_BD_Counter` | `int` | No |  |
| `KPI_5BD_Trigger` | `int` | No |  |
| `KPI_5BD_Trigger_Ceiling` | `int` | No |  |
| `KPI_10BD_Trigger` | `int` | No |  |
| `KPI_10BD_Trigger_Ceiling` | `int` | No |  |
| `KPI_20BD_Trigger` | `int` | No |  |
| `KPI_20BD_Trigger_Ceiling` | `int` | No |  |
| `Event_Tracking` | `string` | No |  |
| `Initial_Abt_Cost` | `int` | No |  |
| `Ongoing_Abt_Cost` | `int` | No |  |
| `Ongoing_Abt_Cost_Ceiling` | `int` | No |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
