---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: uvw_kpi19_abatement_costs
full-name: transport_dev.transport_tsrc.uvw_kpi19_abatement_costs
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - uvw_kpi19_abatement_costs

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_kpi19_abatement_costs` |
| Full name | `transport_dev.transport_tsrc.uvw_kpi19_abatement_costs` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | VIEW |
| Column count | 53 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | KPI / reporting |
| Owner/SME | hui.chen@ventia.com |
| Refresh/freshness | Created: 2024-10-15T06:15:46.819Z; Last altered: 2024-10-15T06:15:46.819Z |
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
            b.`Week Number`,
            ROW_NUMBER() OVER(PARTITION BY `KPI 19 - Criteria Type`, b.`Year`,b.`Quarter` ORDER BY `KPI_19_DueDate`) AS KPI_19_Qtr_Count

        FROM
        --- Filter only for abated events
        (SELECT
            *
        FROM transport_dev.transport_tsrc.uvw_kpi19_stakeholder_events
        WHERE KPI_19_Abated = 'Yes') a
        --- Join with date table
        LEFT JOIN transport_dev.transport_tsrc.utbl_ref_date_table b
        ON b.`Date` = a.KPI_19_DueDate
    )
    --- Calculate the Abatement costs days
    SELECT
        *,
        CASE WHEN `KPI 19 - Criteria Type` = "Clause B" THEN 5000
                WHEN `KPI 19 - Criteria Type` = "Clause A" AND `KPI_19_Qtr_Count` = 3 THEN 5000
                ELSE 0 END AS KPI_19_AbatementValue
    FROM DateExpanded a
    ORDER BY a.`KPI_19_DueDate`
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
| `KPI19_GeneralResponse_DueDate` | `timestamp` | Yes |  |
| `KPI19_GeneralCloseOut_DueDate` | `timestamp` | Yes |  |
| `KPI19_MediaReqDueDate` | `timestamp` | Yes |  |
| `KPI19_Ministerial_DueDate` | `timestamp` | Yes |  |
| `WKT` | `string` | Yes |  |
| `KPI_19_DueDate` | `timestamp` | Yes |  |
| `KPI 19 - Event ID` | `string` | Yes |  |
| `KPI 19 - Criteria Type` | `string` | No |  |
| `KPI 19 - Event` | `string` | No |  |
| `KPI_19_Assessment_Date` | `timestamp` | Yes |  |
| `KPI_19_Abated` | `string` | No |  |
| `Date` | `date` | Yes |  |
| `Day of Week` | `string` | Yes |  |
| `Year` | `bigint` | Yes |  |
| `Quarter` | `string` | Yes |  |
| `Week Number` | `bigint` | Yes |  |
| `KPI_19_Qtr_Count` | `int` | No |  |
| `KPI_19_AbatementValue` | `int` | No |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
