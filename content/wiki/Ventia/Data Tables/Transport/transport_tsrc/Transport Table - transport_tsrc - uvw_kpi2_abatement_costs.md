---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: uvw_kpi2_abatement_costs
full-name: transport_dev.transport_tsrc.uvw_kpi2_abatement_costs
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - uvw_kpi2_abatement_costs

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_kpi2_abatement_costs` |
| Full name | `transport_dev.transport_tsrc.uvw_kpi2_abatement_costs` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | VIEW |
| Column count | 40 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | KPI / reporting |
| Owner/SME | hui.chen@ventia.com |
| Refresh/freshness | Created: 2024-10-24T22:26:27.414Z; Last altered: 2024-10-24T22:26:27.414Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
WITH kpi2_abatementcost AS (
  WITH kpi2_abatementbusinessday AS (
    WITH kpi2_abatementqtrportioning AS (
      WITH kpi2_compliance AS (
        SELECT 
          inc.TriggerSectionId,
          inc.assetcode,
          inc.assetname,
          inc.direction,
          inc.incidentcount,
          inc.minChainage,
          inc.minIncidentDate,
          inc.maxChainage,
          inc.maxIncidentDate,
          inc.AbatementTriggerDate,
          inc.TriggerSectionWKT,
          inc.abatablecount,
          inc.rsaregkey,
          reg.id,
          reg.contract,
          reg.region,
          reg.completeddate,
          reg.modulename,
          reg.rsaname,
          reg.`TriggeredSectionDetails_-_EndDate`,
          reg.TMRTeambinderSubmissionReferenceID,
          reg.InitiatedbyaKPI02event,
          reg.`TriggeredSectionDetails_-_StartDate`,
          reg.ConsultantContractor,
          to_timestamp(reg.ReportSubmissionDate, 'd/M/yyyy H:m:s') AS `ReportSubmissionDate`,
          -- Check whether section is abatable
          CASE WHEN inc.abatablecount >= 6 THEN 'Yes' ELSE 'No' END AS `AbatableSection`,
          reg.triggersectionkey,
          CASE WHEN reg.ReportSubmissionDate IS NULL AND inc.AbatementTriggerDate <> 'N/A' THEN 'Open'
              WHEN inc.AbatementTriggerDate = 'N/A' THEN 'N/A'
              ELSE 'Completed' END AS CompletionStatus,
          -- Check if it is past due date of 20 business days
          (SELECT to_timestamp(max(`Date`), 'd/M/yyyy H:m:s') AS `Date`
          FROM (SELECT `Date` 
                FROM transport_dev.transport_tsrc.utbl_ref_date_table
                WHERE `Date` > to_date(AbatementTriggerDate) 
                AND (Weekday = 'Yes' AND PublicHoliday = 'No')
                ORDER BY `Date` ASC
                LIMIT 20)
          ) AS DueDate
        
        FROM transport_dev.transport_tsrc.utbl_incident_triggered_section_geom inc
        LEFT JOIN transport_dev.transport_tsrc.utbl_road_safety_audit_register reg 
        ON reg.triggersectionkey = inc.rsaregkey
      )

    SELECT 
      comp.*, 
      case when `ReportSubmissionDate` > DueDate or getdate() > DueDate then 'Overdue' else '' end as ProgressStatus

    from kpi2_compliance comp
    where CompletionStatus <> 'N/A'
    )

  select 
    aqp.*, 
    concat(`Year`, `Quarter`) as RepQtrKey, 
    `Year`, 
    `Quarter`, 
    cast(count(1) as int)  as BusinessDaysLateinQTR, 
    (select max(RepQtrKey) from (
      select concat(`Year`, `Quarter`) 
      as RepQtrKey, `Year`, `Quarter`
      as BusinessDays 
      from transport_dev.transport_tsrc.utbl_ref_date_table
      where (`Date` > to_date(`DueDate`) 
      and `Date` < to_date(getdate()))
      and (Weekday = 'Yes' and PublicHoliday = 'No')
      group by `Quarter`, `Year`)) as maxYearQtr, 
      (select min(RepQtrKey) from
      (select concat(`Year`, `Quarter`) 
      as RepQtrKey, `Year`, `Quarter`
      as BusinessDays 
      from transport_dev.transport_tsrc.utbl_ref_date_table
      where (`Date` > to_date(`DueDate`) 
      and `Date` < to_date(getdate()))
      and (Weekday = 'Yes' and PublicHoliday = 'No')
      group by `Quarter`, `Year`)) as minYearQtr,
      case when ((17 - Hour(getdate())) / 8) > 1 then 0 else (17 - Hour(getdate())) / 8 end as PartialDay

  from kpi2_abatementqtrportioning aqp
  left join transport_dev.transport_tsrc.utbl_ref_date_table
  where (`Date` > to_date(`DueDate`) and 
        `Date` < to_date(getdate()))
        and (Weekday = 'Yes' and PublicHoliday = 'No') and 
        `CompletionStatus` = 'Open' and
        `ProgressStatus` = 'Overdue'
  group by all

  union all

  select 
    aqp.*, 
    concat(`Year`, `Quarter`) as RepQtrKey,
    `Year`, 
    `Quarter`, 
    cast(count(1) as int)  as BusinessDaysLateinQTR, 
    (select max(RepQtrKey) from
    (select concat(`Year`, `Quarter`) 
    as RepQtrKey, `Year`, `Quarter`
    as BusinessDays 
    from transport_dev.transport_tsrc.utbl_ref_date_table
    where (`Date` > to_date(`DueDate`) 
    and `Date` < to_date(`ReportSubmissionDate`))
    and (Weekday = 'Yes' and PublicHoliday = 'No')
    group by `Quarter`, `Year`)) as maxYearQtr,
    (select min(RepQtrKey) from
    (select concat(`Year`, `Quarter`) 
    as RepQtrKey, `Year`, `Quarter`
    as BusinessDays 
    from transport_dev.transport_tsrc.utbl_ref_date_table
    where (`Date` > to_date(`DueDate`) 
    and `Date` < to_date(`ReportSubmissionDate`))
    and (Weekday = 'Yes' and PublicHoliday = 'No')
    group by `Quarter`, `Year`)) as minYearQtr,
    case when ((17 - Hour(`ReportSubmissionDate`)) / 8) > 1 then 0 else (17 - Hour(`ReportSubmissionDate`)) / 8 end as PartialDay

  from kpi2_abatementqtrportioning aqp
  left join transport_dev.transport_tsrc.utbl_ref_date_table
        where (`Date` > to_date(`DueDate`) and 
        `Date` < to_date(`ReportSubmissionDate`))
        and (Weekday = 'Yes' and PublicHoliday = 'No') and 
        `CompletionStatus` = 'Completed' and
        `ProgressStatus` = 'Overdue'
        group by all
        )

  Select 
    abd.*,
    case when RepQtrKey = minYearQtr and RepQtrKey = maxYearQtr then BusinessDaysLateinQTR + PartialDay
        when RepQtrKey = minYearQtr then BusinessDaysLateinQTR
        when RepQtrKey = maxYearQtr then BusinessDaysLateinQTR + PartialDay
        else BusinessDaysLateinQTR
    end as TotalBusinessDaysLateinQtr
    
  from kpi2_abatementbusinessday abd
  )

select 
  ac.*,
  `abatablecount` * TotalBusinessDaysLateinQtr * 5000.0 as AbatementCost,
  `abatablecount` * CEILING(TotalBusinessDaysLateinQtr,0) * 5000.0 as AbatementCost_Ceiling
from kpi2_abatementcost ac
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `TriggerSectionId` | `int` | Yes |  |
| `assetcode` | `string` | Yes |  |
| `assetname` | `string` | Yes |  |
| `direction` | `string` | Yes |  |
| `incidentcount` | `bigint` | Yes |  |
| `minChainage` | `int` | Yes |  |
| `minIncidentDate` | `timestamp` | Yes |  |
| `maxChainage` | `int` | Yes |  |
| `maxIncidentDate` | `timestamp` | Yes |  |
| `AbatementTriggerDate` | `string` | Yes |  |
| `TriggerSectionWKT` | `string` | Yes |  |
| `abatablecount` | `bigint` | Yes |  |
| `rsaregkey` | `string` | Yes |  |
| `id` | `int` | Yes |  |
| `contract` | `string` | Yes |  |
| `region` | `string` | Yes |  |
| `completeddate` | `timestamp` | Yes |  |
| `modulename` | `string` | Yes |  |
| `rsaname` | `string` | Yes |  |
| `TriggeredSectionDetails_-_EndDate` | `string` | Yes |  |
| `TMRTeambinderSubmissionReferenceID` | `string` | Yes |  |
| `InitiatedbyaKPI02event` | `string` | Yes |  |
| `TriggeredSectionDetails_-_StartDate` | `string` | Yes |  |
| `ConsultantContractor` | `string` | Yes |  |
| `ReportSubmissionDate` | `timestamp` | Yes |  |
| `AbatableSection` | `string` | No |  |
| `triggersectionkey` | `string` | Yes |  |
| `CompletionStatus` | `string` | No |  |
| `DueDate` | `timestamp` | Yes |  |
| `ProgressStatus` | `string` | No |  |
| `RepQtrKey` | `string` | Yes |  |
| `Year` | `bigint` | Yes |  |
| `Quarter` | `string` | Yes |  |
| `BusinessDaysLateinQTR` | `int` | No |  |
| `maxYearQtr` | `string` | Yes |  |
| `minYearQtr` | `string` | Yes |  |
| `PartialDay` | `double` | Yes |  |
| `TotalBusinessDaysLateinQtr` | `double` | Yes |  |
| `AbatementCost` | `double` | Yes |  |
| `AbatementCost_Ceiling` | `decimal(38,1)` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
