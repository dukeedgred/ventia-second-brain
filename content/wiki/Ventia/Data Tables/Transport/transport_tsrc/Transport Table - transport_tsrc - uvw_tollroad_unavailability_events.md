---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: uvw_tollroad_unavailability_events
full-name: transport_dev.transport_tsrc.uvw_tollroad_unavailability_events
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - uvw_tollroad_unavailability_events

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_tollroad_unavailability_events` |
| Full name | `transport_dev.transport_tsrc.uvw_tollroad_unavailability_events` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | VIEW |
| Column count | 32 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | KPI / reporting |
| Owner/SME | hui.chen@ventia.com |
| Refresh/freshness | Created: 2024-09-16T02:32:42.979Z; Last altered: 2024-09-16T02:32:42.979Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(

(

----------- Abatement Incident Factor retrieves all the factors that are used to calcualte the Abatements  -------------
WITH AbatementIncidentFactor AS (
    --- Create a table called Total Time Factor    
    WITH TotalTimeFactor AS (
        SELECT
          inc.id as `Incident Id`,
          floor(
          ((datediff(hour,inc.`OccurrenceDateandTime`,to_timestamp(inc.`Rectification-EndTime`, 'd/M/yyyy H:m:s')))
          + 
          (
            (
              (datediff(minute,inc.`OccurrenceDateandTime`,to_timestamp(inc.`Rectification-EndTime`, 'd/M/yyyy H:m:s')) / 60.0)
              - 
              (datediff(hour,inc.`OccurrenceDateandTime`,to_timestamp(inc.`Rectification-EndTime`, 'd/M/yyyy H:m:s')))
            ) * 60.0
          ) / 100 )/ 24 , 0) AS FullDays,
          -- Total Time Factor (TFe)
          (
           floor(
          ((datediff(hour,inc.`OccurrenceDateandTime`,to_timestamp(inc.`Rectification-EndTime`, 'd/M/yyyy H:m:s')))
          + 
          (
            (
              (datediff(minute,inc.`OccurrenceDateandTime`,to_timestamp(inc.`Rectification-EndTime`, 'd/M/yyyy H:m:s')) / 60.0)
              - 
              (datediff(hour,inc.`OccurrenceDateandTime`,to_timestamp(inc.`Rectification-EndTime`, 'd/M/yyyy H:m:s')))
            ) * 60.0
          ) / 100 )/ 24 , 0) 
           *
           (SELECT SUM(Percentage) FROM transport_dev.transport_tsrc.utbl_ref_lane_closure_abate_pct) 
          )
          +
          cast(
          --- If occurrence and not on the same day
          CASE WHEN date(inc.OccurrenceDateandTime) <> date(to_timestamp(inc.`Rectification-EndTime`, 'd/M/yyyy H:m:s'))
               THEN CAST(  -- IF on different days you have to go from start time to 12am and add from 12am next day to end time
                      (SELECT SUM(Percentage) FROM transport_dev.transport_tsrc.utbl_ref_lane_closure_abate_pct
                       WHERE `Start` >= (floor((hour(inc.OccurrenceDateandTime) + (minute(inc.OccurrenceDateandTime) / 60.0)) * 2,0) / 2))
                      +
                      (SELECT SUM(Percentage) FROM transport_dev.transport_tsrc.utbl_ref_lane_closure_abate_pct
                       WHERE `End` <= (ceil((hour(to_timestamp(inc.`Rectification-EndTime`, 'd/M/yyyy H:m:s')) + 
                                      (minute(to_timestamp(inc.`Rectification-EndTime`, 'd/M/yyyy H:m:s')) / 60.0)) * 2,0) / 2)) 
                    AS decimal (10,5))
               ELSE 
                    CAST( -- ELSE on different days you have to go from start time to end time
                      (SELECT SUM(Percentage) FROM transport_dev.transport_tsrc.utbl_ref_lane_closure_abate_pct
                       WHERE `Start` >= (floor((hour(inc.OccurrenceDateandTime) + (minute(inc.OccurrenceDateandTime) / 60.0)) * 2,0) / 2)
                              AND `End` <= (ceil((hour(to_timestamp(inc.`Rectification-EndTime`, 'd/M/yyyy H:m:s')) + 
                                           (minute(to_timestamp(inc.`Rectification-EndTime`, 'd/M/yyyy H:m:s')) / 60.0)) * 2,0) / 2))
                    AS decimal (10,5))
              END AS decimal (10,5)) AS `Total Time Factor (TFe)`
        FROM transport_dev.transport_tsrc.utbl_kpi2_road_safety inc  --- Update transport
        WHERE inc.`OccurrenceDateandTime` IS NOT NULL AND inc.`Rectification-EndTime` <>''
    )

    --- Create a temp table that calculates all the abatement factors
    SELECT
      --- General Information Attributes
      inc.id as `Incident Id`,
      inc.IncidentDescription as `Incident Name`,
      inc.`Details-IncidentType` as `Incident Type`,
      inc.`Details-AbatementSection` as `Abatement Section`,
      inc.`Overview-Subsection` as `Subsection Location`,
      inc.`Details-LanesAffected` as `Lanes Affected`,
      to_date(inc.`OccurrenceDateandTime`) as `datekey`,
      inc.`OccurrenceDateandTime` as `Occurrence`,
      to_timestamp(inc.`Rectification-EndTime`, 'd/M/yyyy H:m:s') as `End Time - Rectification`,
      lct.`Closure Type` as `Rule based on Lanes affected`,
      inc.IncidentStatus,
      inc.`Overview-DidanAbatementOccur`,
      inc.`Overview-AbatementExemption`,
      inc.`IncidentClosureDetails-ClosurePurpose`,
      inc.`Details-Emergencyservicesonsite`,
      ---- Calculate Rectification Duration in (Hrs) - hours as integer and add the decimals
      ttf.FullDays,
      (datediff(hour,inc.`OccurrenceDateandTime`,to_timestamp(inc.`Rectification-EndTime`, 'd/M/yyyy H:m:s')))
      + 
      (
        (
          (datediff(minute,inc.`OccurrenceDateandTime`,to_timestamp(inc.`Rectification-EndTime`, 'd/M/yyyy H:m:s')) / 60.0)
          - 
          (datediff(hour,inc.`OccurrenceDateandTime`,to_timestamp(inc.`Rectification-EndTime`, 'd/M/yyyy H:m:s')))
        ) * 60.0
      ) / 100 as `Rectification Duration (hrs)`,
      -- Calculation Rectificcation Duration in Minutes
      datediff(second,inc.`OccurrenceDateandTime`, to_timestamp(inc.`Rectification-EndTime`, 'd/M/yyyy H:m:s')) / 60.0 AS `Rectification Duration (min)`,
      -- Calculation Section factor
      cast(lcs.Factor as decimal (10, 4)) as `Section Factor (SFe)`,
      -- Lane Factor (B) Calc
      CASE WHEN inc.`Overview-AbatementExemption` = 'Yes' THEN 0
           WHEN lct.`Closure Type` = 'Partial Carriageway Closure' THEN lcl.`Partial Carriageway Closure`
           WHEN lct.`Closure Type` = 'Full Carriageway Closure' THEN lcl.`Full Carriageway Closure`
           WHEN lct.`Closure Type` = 'Emergency Stopping Lane Closure' THEN lcl.`Emergency Stopping Lane Closure`
           WHEN lct.`Closure Type` = 'Shoulder Closure' THEN lcl.`Shoulder Closure`
           ELSE NULL
      END AS `Lane Factor (LFe)`,
      -- Special Day factor Calculation
      COALESCE(
      (SELECT MAX(Factor) FROM transport_dev.transport_tsrc.utbl_ref_lane_closure_special_day
       WHERE `Day`>=date(to_timestamp(inc.`OccurrenceDateandTime`, 'd/M/yyyy H:m:s')) AND
             `Day`<=date(to_timestamp(inc.`Rectification-EndTime`, 'd/M/yyyy H:m:s'))
      ),1)
      AS `Special Day Factor (SDFe)`,
      -- Total time factor
      `Total Time Factor (TFe)`,
      -- LCTRe (E) to check if an event went 4 hours or more
      CASE WHEN datediff(minute,inc.`OccurrenceDateandTime`,to_timestamp(inc.`Rectification-EndTime`, 'd/M/yyyy H:m:s')) / 60.0 > (3.0 + (59.0 / 60.0)) then 2
           ELSE 1
      END AS `Long Term Closure Factor (LCTRe)`,
      -- Set Minimum Abatement
      1000.00 as `Minimum Abatement (MA)`,
      -- Calcuate Financial Factors
      fjd.`Financial_Join_date`,
      lcfB.QIFq as `QIFq`,
      lcfB.BQSPq as `BQSPq`,
      -- Calculate Abatements ----------------
      -- Check if an abatement occured
      CASE WHEN inc.`Overview-DidanAbatementOccur` = 'Yes' THEN 'Yes'
           ----- Deemed Unavailability Events
           WHEN inc.`Details-IncidentType` IN ('Unavailability Event - O&M Contractor Fault','Deemed Unavailability - (a) LPPC',
                                               'Deemed Unavailability - (b) Flood','Deemed Unavailability - (c) Defects',
                                               'Deemed Unavailability - (d) Debris','Deemed Unavailability - (f) LoS') THEN 'Yes'
           ----- As per Schedule 3 - cars and LCVs you get 90 mins
           WHEN (inc.`IncidentClosureDetails-ClosurePurpose` = 'Closures caused by Cars and LCVs - Rectification 90 Mins'
                 OR inc.`IncidentClosureDetails-ClosurePurpose` = 'Closures caused by Cars and LCVs'
                )
                AND 
                (datediff(second,inc.`OccurrenceDateandTime`,to_timestamp(inc.`Rectification-EndTime`, 'd/M/yyyy H:m:s')) / 60.0) > 90 THEN 'Yes'
           ----- As per Schedule 3 - HCVS you get 120 mins
           WHEN (inc.`IncidentClosureDetails-ClosurePurpose` = 'Closures caused by HCVs - Rectification 120 Mins'
                 OR inc.`IncidentClosureDetails-ClosurePurpose` = 'Closures caused by HCVs'
                )
                AND 
                (datediff(second,inc.`OccurrenceDateandTime`,to_timestamp(inc.`Rectification-EndTime`, 'd/M/yyyy H:m:s')) / 60.0) > 120 THEN 'Yes'
           ----- As per Schedule 3 - LCVS and HCVS in arrestor beds you get 360 mins
           WHEN (inc.`IncidentClosureDetails-ClosurePurpose` = 'Remove LCVs and HCVs that are in the Arrester Beds - Rectification 360 Mins'
                 OR inc.`IncidentClosureDetails-ClosurePurpose` = 'Remove LCVs and HCVs that are in the Arrester Beds'
                )
                AND (datediff(second,inc.`OccurrenceDateandTime`,to_timestamp(inc.`Rectification-EndTime`, 'd/M/yyyy H:m:s')) / 60.0) > 360 THEN 'Yes'
           ELSE 'N/A'
      END AS AbatementOccurredDerived
    FROM TotalTimeFactor ttf --- temp table
    --- Right join with the original incidents table
    RIGHT JOIN transport_dev.transport_tsrc.utbl_kpi2_road_safety inc
      ON ttf.`Incident Id` = inc.id
    --- Join to get lane closure type based on 'Lanes Affected' from the incident module
    LEFT JOIN transport_dev.transport_tsrc.utbl_ref_lane_closure_type lct 
      ON (CASE WHEN inc.`Details-LanesAffected` IS NULL then 'NA'
               ELSE inc.`Details-LanesAffected`
          END) = lct.`Lanes Affected`
    --- Join to get the Section Factor based on the closure section
    LEFT JOIN transport_dev.transport_tsrc.utbl_ref_lane_closure_section_factor lcs 
      ON (CASE WHEN inc.`Details-AbatementSection` IS NULL then 'Null'
               ELSE inc.`Details-AbatementSection`
          END) = lcs.Section
    --- Join to get special days against the incident date
    LEFT JOIN transport_dev.transport_tsrc.utbl_ref_lane_closure_special_day lcsd 
      ON lcsd.Day = date(to_timestamp(inc.`OccurrenceDateandTime`, 'd/M/yyyy H:m:s'))
    --- Join to get Lane Factors based on which lane was closed on which Sections
    LEFT JOIN transport_dev.transport_tsrc.utbl_ref_lane_closure_lane_factor lcl 
      ON lcl.Section = inc.`Details-AbatementSection`
     --- Join to get the max date from financial factors table to join against
    LEFT JOIN 
        (SELECT
            inc.`id`,
            inc.OccurrenceDateandTime,
            inc.OccurrenceDateandTimeDerived,
            (SELECT MAX(`Date`) FROM transport_dev.transport_tsrc.utbl_ref_lane_closure_financial_factor 
             WHERE `Date` <= inc.OccurrenceDateandTimeDerived) AS `Financial_Join_date`
         FROM transport_dev.transport_tsrc.utbl_kpi2_road_safety inc
         ORDER BY inc.OccurrenceDateandTimeDerived DESC) fjd
      ON fjd.id = inc.id
    --- Join to get the financial factor to apply adjustments to the QSP
    LEFT JOIN  transport_dev.transport_tsrc.utbl_ref_lane_closure_financial_factor lcfB
      ON fjd.`Financial_Join_date` = lcfB.`Date`
)

------------   End of First Table Abatement Incident Factors   ---------------

------------- Using the factors to start calculating the Abatement Costs and Exceptions -----------------
SELECT
  AbatementIncidentFactor.*,
  --- Calculate first part of the abatement -- (BQSPq × SFe × LFe × TFe × LTCRe × SDFe)
  (
    (`Section Factor (SFe)`) * (`Lane Factor (LFe)`) * (`Special Day Factor (SDFe)`) * `Total Time Factor (TFe)` * `Long Term Closure Factor (LCTRe)` * BQSPq
  ) as `Part 1`,
  --- Calculate second part of the abatement -- (MA × (1 + QIFq))
  `Minimum Abatement (MA)` * (1 + QIFq) as `Part 2`,
  --- Calculate UAE
  COALESCE(
    CASE WHEN `Rectification Duration (hrs)` = 0 then 0
         ELSE ((`Section Factor (SFe)`) * (`Lane Factor (LFe)`) * (`Special Day Factor (SDFe)`) * `Total Time Factor (TFe)` * `Long Term Closure Factor (LCTRe)` * BQSPq) 
               +
               (`Minimum Abatement (MA)` * (1 + QIFq))
         END,0
  ) AS `UAE`,
  --- Create field to highlight exceptions
  (
    CASE
      WHEN `Lanes Affected` = '' OR `Lanes Affected` IS NULL THEN "'Lanes Affected' value missing. "
      ELSE ''
    END
  ) || (
    CASE
      WHEN `Occurrence` = `End Time - Rectification` THEN "'Occurence Date Time' and 'Rectification End Time' are the same. "
      ELSE ''
    END
  ) || (
    CASE
      WHEN `Abatement Section` = '' OR `Abatement Section` IS NULL THEN "'Abatement Section' value missing. "
      ELSE ''
    END
  ) || (
    CASE
      WHEN `Occurrence` IS NULL THEN "'Occurrence Date Time' value missing. "
      ELSE ''
    END
  ) || (
    CASE
      WHEN `End Time - Rectification` IS NULL THEN "'Rectification End Date' Time value missing. "
      ELSE ''
    END
  ) as Exceptions
FROM AbatementIncidentFactor
)
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Incident Id` | `int` | Yes |  |
| `Incident Name` | `string` | Yes |  |
| `Incident Type` | `string` | Yes |  |
| `Abatement Section` | `string` | Yes |  |
| `Subsection Location` | `string` | Yes |  |
| `Lanes Affected` | `string` | Yes |  |
| `datekey` | `date` | Yes |  |
| `Occurrence` | `timestamp` | Yes |  |
| `End Time - Rectification` | `timestamp` | Yes |  |
| `Rule based on Lanes affected` | `string` | Yes |  |
| `IncidentStatus` | `string` | Yes |  |
| `Overview-DidanAbatementOccur` | `string` | Yes |  |
| `Overview-AbatementExemption` | `string` | Yes |  |
| `IncidentClosureDetails-ClosurePurpose` | `string` | Yes |  |
| `Details-Emergencyservicesonsite` | `string` | Yes |  |
| `FullDays` | `decimal(27,0)` | Yes |  |
| `Rectification Duration (hrs)` | `decimal(37,11)` | Yes |  |
| `Rectification Duration (min)` | `decimal(27,6)` | Yes |  |
| `Section Factor (SFe)` | `decimal(10,4)` | Yes |  |
| `Lane Factor (LFe)` | `double` | Yes |  |
| `Special Day Factor (SDFe)` | `bigint` | No |  |
| `Total Time Factor (TFe)` | `decimal(38,5)` | Yes |  |
| `Long Term Closure Factor (LCTRe)` | `int` | No |  |
| `Minimum Abatement (MA)` | `decimal(6,2)` | No |  |
| `Financial_Join_date` | `date` | Yes |  |
| `QIFq` | `double` | Yes |  |
| `BQSPq` | `double` | Yes |  |
| `AbatementOccurredDerived` | `string` | No |  |
| `Part 1` | `double` | Yes |  |
| `Part 2` | `double` | Yes |  |
| `UAE` | `double` | No |  |
| `Exceptions` | `string` | No |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
