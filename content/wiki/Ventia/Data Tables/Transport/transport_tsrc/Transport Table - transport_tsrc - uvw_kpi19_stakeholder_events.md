---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: uvw_kpi19_stakeholder_events
full-name: transport_dev.transport_tsrc.uvw_kpi19_stakeholder_events
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - uvw_kpi19_stakeholder_events

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_kpi19_stakeholder_events` |
| Full name | `transport_dev.transport_tsrc.uvw_kpi19_stakeholder_events` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | VIEW |
| Column count | 46 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | KPI / reporting |
| Owner/SME | hui.chen@ventia.com |
| Refresh/freshness | Created: 2024-10-15T05:47:59.859Z; Last altered: 2024-10-15T05:47:59.859Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
  WITH tmp2 AS
  (
    WITH tmp1 AS
    (
        SELECT

            `id`,
            CONCAT("https://gen7.assetvision.com.au/Inspections/ViewContainer/",`id`) AS `AV_Link_URL`,
            custrequestname,
            a.assetcode,
            a.direction,
            a.chainagefrom,
            a.chainageto,
            comments,
            createddate,
            ---- Event Type Fields ----
            `EventType-EventType`,
            `EventType-EventClassification`,
            `EventType-DateReceived`,
            ---- Customer Information and Enquiry Details Fields ----
            `CustInfoEnqDetails-ContactName`,
            `CustInfoEnqDetails-ContactNumber`,
            `CustInfoEnqDetails-ContactEmail`,
            `CustInfoEnqDetails-ContactAddress`,
            `CustInfoEnqDetails-StakeholderType`,
            `CustInfoEnqDetails-BusinessName`,
            `CustInfoEnqDetails-DateEventOccured`,
            `CustInfoEnqDetails-Topic`,
            `CustInfoEnqDetails-ResponseDate`,
            `CustInfoEnqDetails-EventStreetAddress`,
            `CustInfoEnqDetails-GeographicCoord`,

            --- Close Out Details Fields
            `CloseOutDetails-Status`,
            `CloseOutDetails-ProjectCoandStateNotified`,
            `CloseOutDetails-NoiseLevelAssessmentAttached`,
            `CloseOutDetails-NoiseLevelAssessmentDate`,
            `CloseOutDetails-RectReqfromAssessment`,
            `CloseOutDetails-DescNoiseRectWorks`,
            `CloseOutDetails-AgreedRectDueDate`,
            `CloseOutDetails-MediaReqRespDueDate`,
            `CloseOutDetails-RequestUrgency`,
            `CloseOutDetails-ResolutionCommentary`,
            `CloseOutDetails-CloseOut/ResolutionDate`,
            convert_timezone('Australia/Queensland',getdate()) AS `Current Date`,
            ---- KPI 19 - All Enquiry Response Due Date - 2 Business days
            timestamp(
            CONCAT(
            (SELECT MAX(b.`Date`)
            FROM
            (SELECT * FROM transport_dev.transport_tsrc.utbl_ref_date_table
            WHERE Weekday = 'Yes' AND PublicHoliday = 'No' AND `Date` > a.`EventType-DateReceived`
            ORDER BY `Date` ASC
            LIMIT 2) b),' 17:00:00'))
            AS `KPI19_GeneralResponse_DueDate`,
            ---- KPI 19 - All Enquiry Close Out Due Date - 20 Business days
            timestamp(
            CONCAT(
            (SELECT MAX(b.`Date`)
            FROM
            (SELECT * FROM transport_dev.transport_tsrc.utbl_ref_date_table
            WHERE Weekday = 'Yes' AND PublicHoliday = 'No' AND `Date` > a.`EventType-DateReceived`
            ORDER BY `Date` ASC
            LIMIT 20) b),' 17:00:00'))
            AS `KPI19_GeneralCloseOut_DueDate`,
            ---- KPI 19 - Media Requet Due Date
            `CloseOutDetails-MediaReqRespDueDate` AS `KPI19_MediaReqDueDate`,
            ---- KPI 19 - Ministerial Requet Due Date Modifier based on urgency
            CASE WHEN a.`CloseOutDetails-RequestUrgency` = "Urgent" THEN
                      (SELECT MAX(b.`Date`)
                      FROM
                      (SELECT * FROM transport_dev.transport_tsrc.utbl_ref_date_table
                      WHERE Weekday = 'Yes' AND PublicHoliday = 'No' AND `Date` > a.`EventType-DateReceived`
                      ORDER BY `Date` ASC
                      LIMIT 2) b)
                 WHEN a.`CloseOutDetails-RequestUrgency` = "Non-Urgent" THEN
                      (SELECT MAX(b.`Date`)
                      FROM
                      (SELECT * FROM transport_dev.transport_tsrc.utbl_ref_date_table
                      WHERE Weekday = 'Yes' AND PublicHoliday = 'No' AND `Date` > a.`EventType-DateReceived`
                      ORDER BY `Date` ASC
                      LIMIT 10) b)
                 WHEN a.`CloseOutDetails-RequestUrgency` = "General Correspondence" THEN
                      (SELECT MAX(b.`Date`)
                      FROM
                      (SELECT * FROM transport_dev.transport_tsrc.utbl_ref_date_table
                      WHERE Weekday = 'Yes' AND PublicHoliday = 'No' AND `Date` > a.`EventType-DateReceived`
                      ORDER BY `Date` ASC
                      LIMIT 5) b)
                 WHEN a.`CloseOutDetails-RequestUrgency` = "Phone Enquiry" THEN
                      timestampadd(HOUR,6 , a.`EventType-DateReceived`)
            END AS `KPI19_Ministerial_DueDate`

        FROM transport_dev.transport_tsrc.uvw_customer_requests a
        WHERE a.`EventType-EventClassification` IS NOT NULL
        ORDER BY `createddate` ASC
    )
    --- Get WKT of the asset
    SELECT 
      *,
      -- Create WKT
      (SELECT
            CONCAT("LINESTRING(",array_join(collect_list(SegWKT),", "),")")
      FROM
        (SELECT
            Concat(Longitude," ",Latitude) as SegWKT
        FROM
        transport_dev.transport_tsrc.utbl_ref_road_chng_10_m
        WHERE `Asset Code` = a.assetcode
              AND Direction_AV = a.direction
              AND (Chainage >= a.chainagefrom AND Chainage <= a.chainageto)
        ORDER BY Chainage ASC)) AS WKT
    FROM tmp1 a
  )

  ----------  UNION THE FOUR TYPES OF EVENTS
  -----------------------------------------------------------
  SELECT
      *,
      `KPI19_GeneralResponse_DueDate` AS `KPI_19_DueDate`,
      --- General Response - Abatement Indicator
      CONCAT(CAST(`id` AS CHAR(50)), '_a') AS `KPI 19 - Event ID`,
      'Clause A' AS `KPI 19 - Criteria Type`,
      'General Response Time' AS `KPI 19 - Event`,
      --- Assessment date of the event
      CASE WHEN `CustInfoEnqDetails-ResponseDate` IS NULL
           THEN convert_timezone('Australia/Queensland',getdate()) 
           ELSE `CustInfoEnqDetails-ResponseDate`
           END AS KPI_19_Assessment_Date,
      --- Assessment results
      CASE WHEN `CustInfoEnqDetails-ResponseDate` IS NULL
          THEN CASE WHEN convert_timezone('Australia/Queensland',getdate()) > `KPI19_GeneralResponse_DueDate` THEN 'Yes' ELSE 'No' END
          ELSE CASE WHEN `CustInfoEnqDetails-ResponseDate` > `KPI19_GeneralResponse_DueDate` THEN 'Yes' ELSE 'No' END
          END AS KPI_19_Abated

  FROM tmp2 a

  UNION
  -----------------------------------------------------------
  SELECT
      *,
      `KPI19_GeneralCloseOut_DueDate` AS `KPI_19_DueDate`,
      --- General Close Out - Abatement Indicator
      CONCAT(CAST(`id` AS CHAR(50)), '_b') AS `KPI 19 - Event ID`,
      'Clause A' AS `KPI 19 - Criteria Type`,
      'General Close Out' AS `KPI 19 - Event`,
      --- Assessment date of the event
      CASE WHEN `CloseOutDetails-CloseOut/ResolutionDate` IS NULL
           THEN convert_timezone('Australia/Queensland',getdate()) 
           ELSE `CloseOutDetails-CloseOut/ResolutionDate`
           END AS KPI_19_Assessment_Date,
      --- Assessment results
      CASE WHEN `CloseOutDetails-CloseOut/ResolutionDate` IS NULL
          THEN CASE WHEN convert_timezone('Australia/Queensland',getdate()) > `KPI19_GeneralCloseOut_DueDate` THEN 'Yes' ELSE 'No' END
          ELSE CASE WHEN `CloseOutDetails-CloseOut/ResolutionDate` > `KPI19_GeneralCloseOut_DueDate` THEN 'Yes' ELSE 'No' END
          END AS KPI_19_Abated

  FROM tmp2 a

  UNION
  -----------------------------------------------------------
  SELECT
      *,
      `KPI19_MediaReqDueDate` AS `KPI_19_DueDate`,
      --- Media Request Close Out - Abatement Indicator
      CONCAT(CAST(`id` AS CHAR(50)), '_b') AS `KPI 19 - Event ID`,
      'Clause B' AS `KPI 19 - Criteria Type`,
      'Media Request Response' AS `KPI 19 - Event`,
      --- Assessment date of the event
      CASE WHEN `CloseOutDetails-CloseOut/ResolutionDate` IS NULL
           THEN convert_timezone('Australia/Queensland',getdate()) 
           ELSE `CloseOutDetails-CloseOut/ResolutionDate`
           END AS KPI_19_Assessment_Date,
      --- Assessment results
      CASE WHEN `CloseOutDetails-CloseOut/ResolutionDate` IS NULL
          THEN CASE WHEN convert_timezone('Australia/Queensland',getdate()) > `KPI19_MediaReqDueDate` THEN 'Yes' ELSE 'No' END
          ELSE CASE WHEN `CloseOutDetails-CloseOut/ResolutionDate` > `KPI19_MediaReqDueDate` THEN 'Yes' ELSE 'No' END
          END AS KPI_19_Abated

  FROM tmp2 a
  WHERE `EventType-EventClassification` = "Media Request"

  UNION

-----------------------------------------------------------
  SELECT
      *,
      `KPI19_Ministerial_DueDate` AS `KPI_19_DueDate`,
      --- Ministerial Request Close Out - Abatement Indicator
      CONCAT(CAST(`id` AS CHAR(50)), '_b') AS `KPI 19 - Event ID`,
      'Clause B' AS `KPI 19 - Criteria Type`,
      'Ministerial Request Close Out' AS `KPI 19 - Event`,
      --- Assessment date of the event
      CASE WHEN `CloseOutDetails-CloseOut/ResolutionDate` IS NULL
           THEN convert_timezone('Australia/Queensland',getdate()) 
           ELSE `CloseOutDetails-CloseOut/ResolutionDate`
           END AS KPI_19_Assessment_Date,
      --- Assessment results
      CASE WHEN `CloseOutDetails-CloseOut/ResolutionDate` IS NULL
          THEN CASE WHEN convert_timezone('Australia/Queensland',getdate()) > `KPI19_Ministerial_DueDate` THEN 'Yes' ELSE 'No' END
          ELSE CASE WHEN `CloseOutDetails-CloseOut/ResolutionDate` > `KPI19_Ministerial_DueDate` THEN 'Yes' ELSE 'No' END
          END AS KPI_19_Abated

  FROM tmp2 a
  WHERE `EventType-EventClassification` = "Ministerial"

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

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
