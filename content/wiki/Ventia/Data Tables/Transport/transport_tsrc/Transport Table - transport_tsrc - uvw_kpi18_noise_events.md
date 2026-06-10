---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: uvw_kpi18_noise_events
full-name: transport_dev.transport_tsrc.uvw_kpi18_noise_events
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - uvw_kpi18_noise_events

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_kpi18_noise_events` |
| Full name | `transport_dev.transport_tsrc.uvw_kpi18_noise_events` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | VIEW |
| Column count | 43 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | KPI / reporting |
| Owner/SME | hui.chen@ventia.com |
| Refresh/freshness | Created: 2024-10-15T03:32:39.546Z; Last altered: 2024-10-15T03:32:39.546Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
  WITH tmp2 AS (
    WITH tmp1 AS (
      SELECT
        `id`,
        CONCAT("https://gen7.assetvision.com.au/Inspections/ViewContainer/", `id`) AS `AV_Link_URL`,
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
        convert_timezone('Australia/Queensland', getdate()) AS `Current Date`,
        ---- KPI 18 - Noise Level Assessment Due Date
        (SELECT MAX(b.`Date`) FROM (SELECT * FROM transport_dev.transport_tsrc.utbl_ref_date_table
                                    WHERE Weekday = 'Yes' AND PublicHoliday = 'No' AND `Date` > a.`EventType-DateReceived`
                                    ORDER BY `Date` ASC 
                                    LIMIT 20) b
        ) AS `KPI18_NoiseAssessment_DueDate`,
        ---- KPI 18 - Rectification Due Date
        CASE
          WHEN `CloseOutDetails-RectReqfromAssessment` = 'Yes' 
          THEN (
                SELECT
                  MAX(b.`Date`)
                FROM
                  (
                    SELECT
                      *
                    FROM
                      transport_dev.transport_tsrc.utbl_ref_date_table
                    WHERE
                      Weekday = 'Yes'
                      AND PublicHoliday = 'No'
                      AND `Date` > a.`CloseOutDetails-AgreedRectDueDate`
                    ORDER BY
                      `Date` ASC
                    LIMIT
                      2
                  ) b
                )
          ELSE NULL
        END AS `KPI18_Rectification_DueDate`
      FROM
        transport_dev.transport_tsrc.uvw_customer_requests a
      WHERE
        a.`EventType-EventClassification` = 'Noise Level Complaint'
      ORDER BY
        `createddate` ASC
    )
    SELECT
      *,
      -- Create WKT
      (
        SELECT
          CONCAT(
            "LINESTRING(",
            array_join(collect_list(SegWKT), ", "),
            ")"
          )
        FROM
          (
            SELECT
              Concat(Longitude, " ", Latitude) as SegWKT
            FROM
              transport_dev.transport_tsrc.utbl_ref_road_chng_10_m
            WHERE
              `Asset Code` = a.assetcode
              AND Direction_AV = a.direction
              AND (
                Chainage >= a.chainagefrom
                AND Chainage <= a.chainageto
              )
            ORDER BY
              Chainage ASC
          )
      ) AS WKT
    FROM
      tmp1 a
  ) ----------  UNION THE TWO TYPES OF EVENTS
  SELECT
    *,
    `KPI18_NoiseAssessment_DueDate` AS `KPI_18_DueDate`,
    --- Noise Level Assessment - Abatement Indicator
    CONCAT(CAST(`id` AS CHAR(50)), '_a') AS `KPI 18 - Event ID`,
    'Noise Level Assessment' AS `KPI 18 - Event`,
    --- Assessment date of the event
    CASE
      WHEN `CloseOutDetails-NoiseLevelAssessmentDate` IS NULL THEN convert_timezone('Australia/Queensland', getdate())
      ELSE `CloseOutDetails-NoiseLevelAssessmentDate`
    END AS KPI_18_Assessment_Date,
    --- Assessment results
    CASE WHEN `CloseOutDetails-NoiseLevelAssessmentAttached` <> 'NA' AND `CloseOutDetails-Status` <> 'Refer/Transferred external parties'
              AND `CloseOutDetails-NoiseLevelAssessmentDate` IS NULL THEN 
              CASE WHEN convert_timezone('Australia/Queensland', getdate()) > `KPI18_NoiseAssessment_DueDate` THEN 'Yes'
                   ELSE 'No'
                   END
         ELSE 
              CASE WHEN `CloseOutDetails-NoiseLevelAssessmentAttached` <> 'NA' AND `CloseOutDetails-Status` <> 'Refer/Transferred external parties'
                        AND `CloseOutDetails-NoiseLevelAssessmentDate` > `KPI18_NoiseAssessment_DueDate` THEN 'Yes'
                   ELSE 'No'
                   END
    END AS KPI_18_Abated
  FROM
    tmp2 a
  UNION
  SELECT
    *,
    `KPI18_Rectification_DueDate` AS `KPI_18_DueDate`,
    --- Noise Rectification - Abatement Indicator
    CONCAT(CAST(`id` AS CHAR(50)), '_b') AS `KPI 18 - Event ID`,
    'Rectification Requirement' AS `KPI 18 - Event`,
    --- Assessment date of the event
    CASE
      WHEN `CloseOutDetails-RectReqfromAssessment` = 'Yes' THEN CASE
        WHEN `CloseOutDetails-CloseOut/ResolutionDate` IS NULL THEN convert_timezone('Australia/Queensland', getdate())
        ELSE `CloseOutDetails-CloseOut/ResolutionDate`
      END
      ELSE Null
    END AS KPI_18_Assessment_Date,
    --- Assessment results
    CASE
      WHEN `CloseOutDetails-RectReqfromAssessment` = 'Yes' THEN CASE
        WHEN (
          `CloseOutDetails-CloseOut/ResolutionDate` IS NULL
          AND convert_timezone('Australia/Queensland', getdate()) > `KPI18_Rectification_DueDate`
        )
        OR (
          `CloseOutDetails-CloseOut/ResolutionDate` IS NOT NULL
          AND `CloseOutDetails-CloseOut/ResolutionDate` > `KPI18_Rectification_DueDate`
        ) THEN 'Yes'
        ELSE 'No'
      END
      ELSE 'No'
    END AS KPI_18_Abated
  FROM
    tmp2 a
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

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
