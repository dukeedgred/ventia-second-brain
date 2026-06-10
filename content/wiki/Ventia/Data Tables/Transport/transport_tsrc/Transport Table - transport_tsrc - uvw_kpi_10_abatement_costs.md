---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: uvw_kpi_10_abatement_costs
full-name: transport_dev.transport_tsrc.uvw_kpi_10_abatement_costs
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - uvw_kpi_10_abatement_costs

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_kpi_10_abatement_costs` |
| Full name | `transport_dev.transport_tsrc.uvw_kpi_10_abatement_costs` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | VIEW |
| Column count | 28 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | KPI / reporting |
| Owner/SME | hui.chen@ventia.com |
| Refresh/freshness | Created: 2024-10-22T23:26:50.559Z; Last altered: 2024-10-22T23:26:50.559Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
WITH AbatementCalc AS (
    WITH DateExpanded AS (
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
        FROM transport_dev.transport_tsrc.uvw_kpi_10_cctv_requests
        WHERE KPI_10_Status = 'Late' OR KPI_10_Status = 'Overdue') a
        LEFT JOIN
        --- Join with business days from date table
        (SELECT 
            * 
        FROM transport_dev.transport_tsrc.utbl_ref_date_table 
        WHERE Weekday = 'Yes' AND PublicHoliday = 'No') b
        ON b.`Date` > a.KPI_10_DueDate AND b.`Date` <= a.KPI_10_Assess_DateTime
    )
    --- Calculate the Abatement costs based on business days
    SELECT
        *,
        --- Track Event Start or End
        CASE WHEN a.`Date` = (SELECT MIN(`Date`) FROM DateExpanded WHERE id = a.id) THEN 'Event Start'
             WHEN a.`Date` = (SELECT MAX(`Date`) FROM DateExpanded WHERE id = a.id) THEN 'Event End'
             ELSE 'NA' 
        END AS `Event_Tracking`,
        --- Abatement Cost Calculation - Initial
        CASE WHEN a.`Date` = (SELECT MIN(`Date`) FROM DateExpanded WHERE id = a.id) THEN 5000
             ELSE 0 
        END AS `Abatement_Costs_Initial`,
        TO_TIMESTAMP(CONCAT(to_date(KPI_10_Assess_DateTime),' 09:00:00')) AS AssessmentDateMorning,
        --- Partial hour calculation
        CASE WHEN a.`Date` = (SELECT MAX(`Date`) FROM DateExpanded WHERE id = a.id)
             THEN DATEDIFF(hour,TO_TIMESTAMP(CONCAT(to_date(KPI_10_Assess_DateTime),' 09:00:00')),KPI_10_Assess_DateTime)
             ELSE 0
        END AS `Partial_Businessday_Check`,
        --- Abatement Cost Calculation - Ongoing
        CASE WHEN a.`Date` = (SELECT MAX(`Date`) FROM DateExpanded WHERE id = a.id) 
             THEN    --- If work is completed before start of the business day then 0 costs
                CASE WHEN DATEDIFF(hour,TO_TIMESTAMP(CONCAT(to_date(KPI_10_Assess_DateTime),' 09:00:00')),KPI_10_Assess_DateTime) < 0 THEN 0
                     --- If work is completed after the end of business day i.e. after 5pm or on weekend then full 1k
                     WHEN TO_DATE(KPI_10_Assess_DateTime) <> `Date` OR
                          DATEDIFF(hour,TO_TIMESTAMP(CONCAT(to_date(KPI_10_Assess_DateTime),' 09:00:00')),KPI_10_Assess_DateTime) > 8 THEN 1000
                     --- If work is completed middle of the day then take the full business day 
                     ELSE CEILING(DATEDIFF(hour,TO_TIMESTAMP(CONCAT(to_date(KPI_10_Assess_DateTime),' 09:00:00')),KPI_10_Assess_DateTime)/8,0) * 1000
                     END
            ELSE 1000
        END AS `Abatement_Costs_Ongoing`
    FROM DateExpanded a
    ORDER BY a.id ASC, a.`Date`
)

SELECT
    *,
    --- Calculate total abatement costs
    SUM(Abatement_Costs_Initial + Abatement_Costs_Ongoing) OVER(PARTITION BY id ORDER BY `Date`) AS Total_Abate_Costs,
    --- Apply cap of 15000
    CASE WHEN SUM(Abatement_Costs_Initial + Abatement_Costs_Ongoing) OVER(PARTITION BY id ORDER BY `Date`) > 15000 THEN 0
         ELSE Abatement_Costs_Initial + Abatement_Costs_Ongoing
    END AS Total_Abate_Costs_Capped

FROM AbatementCalc
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `id` | `int` | Yes |  |
| `AV_Url` | `string` | Yes |  |
| `assetid` | `int` | Yes |  |
| `assetcode` | `string` | Yes |  |
| `assetname` | `string` | Yes |  |
| `createddate` | `timestamp` | Yes |  |
| `createduser` | `string` | Yes |  |
| `assigneduser` | `string` | Yes |  |
| `cctvrequestname` | `string` | Yes |  |
| `TMRRequestIDRef` | `string` | Yes |  |
| `RequestDate` | `string` | Yes |  |
| `completeddate` | `timestamp` | Yes |  |
| `Request_DateTime` | `timestamp` | Yes |  |
| `KPI_10_DueDate` | `date` | Yes |  |
| `KPI_10_Assess_DateTime` | `timestamp` | Yes |  |
| `KPI_10_Status` | `string` | No |  |
| `Date` | `date` | Yes |  |
| `Day of Week` | `string` | Yes |  |
| `Year` | `bigint` | Yes |  |
| `Quarter` | `string` | Yes |  |
| `Week Number` | `bigint` | Yes |  |
| `Event_Tracking` | `string` | No |  |
| `Abatement_Costs_Initial` | `int` | No |  |
| `AssessmentDateMorning` | `timestamp` | Yes |  |
| `Partial_Businessday_Check` | `bigint` | Yes |  |
| `Abatement_Costs_Ongoing` | `decimal(21,0)` | Yes |  |
| `Total_Abate_Costs` | `decimal(32,0)` | Yes |  |
| `Total_Abate_Costs_Capped` | `decimal(22,0)` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
