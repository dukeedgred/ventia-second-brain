---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: uvw_kpi18_abatement_costs
full-name: transport_dev.transport_tsrc.uvw_kpi18_abatement_costs
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - uvw_kpi18_abatement_costs

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_kpi18_abatement_costs` |
| Full name | `transport_dev.transport_tsrc.uvw_kpi18_abatement_costs` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | VIEW |
| Column count | 52 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | KPI / reporting |
| Owner/SME | hui.chen@ventia.com |
| Refresh/freshness | Created: 2024-10-23T00:15:13.489Z; Last altered: 2024-10-23T00:15:13.489Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
    WITH DateExpanded(
        SELECT
            a.*,
            b.Date,
            b.`Day of Week`,
            b.Year,
            b.Quarter,
            b.`Week Number`

        FROM
        --- Filter only for abated events
        (SELECT
            *
        FROM transport_dev.transport_tsrc.uvw_kpi18_noise_events
        WHERE KPI_18_Abated = 'Yes') a
        LEFT JOIN
        --- Join with business days from date table
        (SELECT 
            * 
        FROM transport_dev.transport_tsrc.utbl_ref_date_table 
        WHERE Weekday = 'Yes' AND PublicHoliday = 'No') b
        ON b.`Date` > a.KPI_18_DueDate AND b.`Date` <= a.KPI_18_Assessment_Date
    )
    --- Calculate the Abatement costs based on business days
    SELECT
        *,
        --- Track Event Start or End
        CASE WHEN a.`Date` = (SELECT MIN(`Date`) FROM DateExpanded WHERE `KPI 18 - Event ID` = a.`KPI 18 - Event ID`) THEN 'Event Start'
             WHEN a.`Date` = (SELECT MAX(`Date`) FROM DateExpanded WHERE `KPI 18 - Event ID` = a.`KPI 18 - Event ID`) THEN 'Event End'
             ELSE 'NA' 
        END AS `Event_Tracking`,
        --- Abatement Cost Calculation - Initial
        CASE WHEN a.`Date` = (SELECT MIN(`Date`) FROM DateExpanded WHERE `KPI 18 - Event ID` = a.`KPI 18 - Event ID`) THEN 50000
             ELSE 0 
        END AS `Abatement_Costs_Initial`,
        --- Partial hour calculation
        CASE WHEN a.`Date` = (SELECT MAX(`Date`) FROM DateExpanded WHERE `KPI 18 - Event ID` = a.`KPI 18 - Event ID`)
             THEN DATEDIFF(hour,TO_TIMESTAMP(CONCAT(to_date(KPI_18_Assessment_Date),' 09:00:00')),KPI_18_Assessment_Date)
             ELSE 0
        END AS `Partial_Businessday_Check`,
        --- Abatement Cost Calculation - Ongoing
        CASE WHEN a.`Date` = (SELECT MAX(`Date`) FROM DateExpanded WHERE `KPI 18 - Event ID` = a.`KPI 18 - Event ID`) 
             THEN    --- If work is completed before start of the business day then 0 costs
                CASE WHEN DATEDIFF(hour,TO_TIMESTAMP(CONCAT(to_date(KPI_18_Assessment_Date),' 09:00:00')),KPI_18_Assessment_Date) < 0 THEN 0
                     --- If work is completed after then end of business day i.e. after 5pm or on weekend then full 5k
                     WHEN TO_DATE(KPI_18_Assessment_Date) <> `Date` OR
                          DATEDIFF(hour,TO_TIMESTAMP(CONCAT(to_date(KPI_18_Assessment_Date),' 09:00:00')),KPI_18_Assessment_Date) > 8 THEN 5000
                     --- If work is completed middle of a business day, round up to end of business day
                     ELSE CEILING(DATEDIFF(hour,TO_TIMESTAMP(CONCAT(to_date(KPI_18_Assessment_Date),' 09:00:00')),KPI_18_Assessment_Date)/8,0) * 5000
                     END
             ELSE 5000
        END AS `Abatement_Costs_Ongoing`
    FROM DateExpanded a
    ORDER BY a.`KPI 18 - Event ID` ASC, a.`Date`
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `id` | `int` | Yes |  |
| `AV_Link_URL` | `string` | Yes |  |
| `custrequestname` | `string` | Yes |  |
| `assetcode` | `string` | Yes |  |
| `direction` | `varchar(50)` | Yes |  |
| `chainagefrom` | `int` | Yes |  |
| `chainageto` | `int` | Yes |  |
| `comments` | `string` | Yes |  |
| `createddate` | `timestamp` | Yes |  |
| `EventType-EventType` | `string` | Yes |  |
| `EventType-EventClassification` | `string` | Yes |  |
| `EventType-DateReceived` | `timestamp` | Yes |  |
| `CustInfoEnqDetails-ContactName` | `string` | Yes |  |
| `CustInfoEnqDetails-ContactNumber` | `string` | Yes |  |
| `CustInfoEnqDetails-ContactEmail` | `string` | Yes |  |
| `CustInfoEnqDetails-ContactAddress` | `string` | Yes |  |
| `CustInfoEnqDetails-StakeholderType` | `string` | Yes |  |
| `CustInfoEnqDetails-BusinessName` | `string` | Yes |  |
| `CustInfoEnqDetails-DateEventOccured` | `timestamp` | Yes |  |
| `CustInfoEnqDetails-Topic` | `string` | Yes |  |
| `CustInfoEnqDetails-ResponseDate` | `timestamp` | Yes |  |
| `CustInfoEnqDetails-EventStreetAddress` | `string` | Yes |  |
| `CustInfoEnqDetails-GeographicCoord` | `string` | Yes |  |
| `CloseOutDetails-Status` | `string` | Yes |  |
| `CloseOutDetails-ProjectCoandStateNotified` | `string` | Yes |  |
| `CloseOutDetails-NoiseLevelAssessmentAttached` | `string` | Yes |  |
| `CloseOutDetails-NoiseLevelAssessmentDate` | `timestamp` | Yes |  |
| `CloseOutDetails-RectReqfromAssessment` | `string` | Yes |  |
| `CloseOutDetails-DescNoiseRectWorks` | `string` | Yes |  |
| `CloseOutDetails-AgreedRectDueDate` | `timestamp` | Yes |  |
| `CloseOutDetails-MediaReqRespDueDate` | `timestamp` | Yes |  |
| `CloseOutDetails-RequestUrgency` | `string` | Yes |  |
| `CloseOutDetails-ResolutionCommentary` | `string` | Yes |  |
| `CloseOutDetails-CloseOut/ResolutionDate` | `timestamp` | Yes |  |
| `Current Date` | `timestamp_ntz` | No |  |
| `KPI18_NoiseAssessment_DueDate` | `date` | Yes |  |
| `KPI18_Rectification_DueDate` | `date` | Yes |  |
| `WKT` | `string` | Yes |  |
| `KPI_18_DueDate` | `date` | Yes |  |
| `KPI 18 - Event ID` | `string` | Yes |  |
| `KPI 18 - Event` | `string` | No |  |
| `KPI_18_Assessment_Date` | `timestamp` | Yes |  |
| `KPI_18_Abated` | `string` | No |  |
| `Date` | `date` | Yes |  |
| `Day of Week` | `string` | Yes |  |
| `Year` | `bigint` | Yes |  |
| `Quarter` | `string` | Yes |  |
| `Week Number` | `bigint` | Yes |  |
| `Event_Tracking` | `string` | No |  |
| `Abatement_Costs_Initial` | `int` | No |  |
| `Partial_Businessday_Check` | `bigint` | Yes |  |
| `Abatement_Costs_Ongoing` | `decimal(21,0)` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
