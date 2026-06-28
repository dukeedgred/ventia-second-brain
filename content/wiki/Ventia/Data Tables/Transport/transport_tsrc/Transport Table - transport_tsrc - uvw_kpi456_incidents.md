---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: uvw_kpi456_incidents
full-name: transport_dev.transport_tsrc.uvw_kpi456_incidents
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - uvw_kpi456_incidents

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_kpi456_incidents` |
| Full name | `transport_dev.transport_tsrc.uvw_kpi456_incidents` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | VIEW |
| Column count | 23 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | KPI / reporting |
| Owner/SME | hui.chen@ventia.com |
| Refresh/freshness | Created: 2024-10-22T22:24:32.07Z; Last altered: 2024-10-22T22:24:32.07Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
WITH abatementcost AS (
  WITH kpifailed AS (
    WITH incidentstagedatetime AS (
      SELECT 
        id,
        CONCAT('https://gen7.assetvision.com.au/Inspections/ViewContainer/',id) as `id_link`,
        SectionID,
        sec.Section,
        IncidentGroup,
        date(OccurrenceDateandTime) as `DateKey`,
        OccurrenceDateandTime,
        DetectedDateTime,
        InitiatedDateTime,
        to_timestamp(`Travel-ArrivalOnSiteTime`,'d/M/yyyy H:m:s') as ArrivalOnSiteDateTime,
        IncidentStatus,
        sec.`KPI 4` as `KPI4 Target`,
        sec.`KPI 5` as `KPI5 Target`,
        sec.`KPI-6` as `KPI6 Target`
      FROM transport_dev.transport_tsrc.utbl_kpi2_road_safety inc
      LEFT JOIN transport_dev.transport_tsrc.utbl_ref_sections_kpi sec 
        ON sec.`Section No` = inc.SectionID
    )

    SELECT 
      isdt.*,
      --KPI4
      CASE WHEN datediff(minute, OccurrenceDateandTime, DetectedDateTime) < 0 THEN 0
          ELSE datediff(minute, OccurrenceDateandTime, DetectedDateTime) 
      END AS `IncidentDetectionDuration`,

      --KPI5
      CASE WHEN datediff(minute, DetectedDateTime, InitiatedDateTime) < 0 THEN 0
          ELSE datediff(minute, DetectedDateTime, InitiatedDateTime)
      END AS `InitialResponseDuration`,

      --KPI6
      CASE WHEN datediff(minute, DetectedDateTime, ArrivalOnSiteDateTime) < 0 THEN 0
          ELSE datediff(minute, DetectedDateTime, ArrivalOnSiteDateTime)
      END AS `ActualResponseDuration`
    FROM incidentstagedatetime isdt
  )
  SELECT
    kpi.*,
    --KPI4
    case when `KPI4 Target` = 'N/A'  then 'No'
         when `IncidentDetectionDuration` is NULL then 'Missing Date Time Data'
         when `KPI4 Target` is NULL then 'Missing Section ID'
         when `IncidentDetectionDuration` is NULL and `KPI4 Target` is not NULL then 'Imcomplete Data'
         when `KPI4 Target` < `IncidentDetectionDuration` then 'Yes'
         else 'No' 
    end as `KPI4Failed`,

    --KPI5
    case when `KPI5 Target` = 'N/A'  then 'No'
         when `InitialResponseDuration` is NULL then 'Missing Date Time Data'
         when `KPI5 Target` is NULL then 'Missing Section ID'
         when `InitialResponseDuration` is NULL and `KPI5 Target` is not NULL then 'Imcomplete Data'
         when `KPI4 Target` < `InitialResponseDuration` then 'Yes'
         else 'No'
    end as `KPI5Failed`,

    --KPI6
    case when `KPI6 Target` = 'N/A'  then 'No'
         when `ActualResponseDuration` is NULL then 'Missing Date Time Data'
         when `KPI6 Target` is NULL then 'Missing Section ID'
         when `ActualResponseDuration` is NULL and `KPI6 Target` is not NULL then 'Imcomplete Data'
         when `KPI6 Target` < `ActualResponseDuration` then 'Yes'
         else 'No'
    end as `KPI6Failed`

    FROM kpifailed kpi
)

SELECT
  ac.*,
  --KPI4 abatement cost
  coalesce((case when `KPI4Failed` = 'Yes' then (CEILING((`IncidentDetectionDuration` - `KPI4 Target`)/5,0))*200.0 
                 else NULL 
  end),0) KPI4AbatementCost,

  --KPI5 abatement cost
  coalesce((case when `KPI5Failed` = 'Yes' and SectionID = '1' then (CEILING((`InitialResponseDuration` - 5)/5,0))*750.0
                 when `KPI5Failed` = 'Yes' and (SectionID in ('2','3','4','5','6','7','8','9')) then (CEILING((`InitialResponseDuration` - 5)/5,0))*150.0
                 else NULL
  end),0) KPI5AbatementCost,

  --KPI6 abatement cost
  coalesce((case when `KPI6Failed` = 'Yes' and SectionID = '1' then (CEILING((`ActualResponseDuration`- 60)/15,0))*2250.0
                 when `KPI6Failed` = 'Yes' and (SectionID in ('2','3','4','5','6','7','8','9')) then (CEILING((`ActualResponseDuration`- 60)/15,0))*450.0
                 else NULL
  end),0) KPI6AbatementCost
FROM abatementcost ac
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `id` | `int` | Yes |  |
| `id_link` | `string` | Yes |  |
| `SectionID` | `int` | Yes |  |
| `Section` | `string` | Yes |  |
| `IncidentGroup` | `string` | Yes |  |
| `DateKey` | `date` | Yes |  |
| `OccurrenceDateandTime` | `timestamp` | Yes |  |
| `DetectedDateTime` | `timestamp` | Yes |  |
| `InitiatedDateTime` | `timestamp` | Yes |  |
| `ArrivalOnSiteDateTime` | `timestamp` | Yes |  |
| `IncidentStatus` | `string` | Yes |  |
| `KPI4 Target` | `string` | Yes |  |
| `KPI5 Target` | `bigint` | Yes |  |
| `KPI6 Target` | `bigint` | Yes |  |
| `IncidentDetectionDuration` | `bigint` | Yes |  |
| `InitialResponseDuration` | `bigint` | Yes |  |
| `ActualResponseDuration` | `bigint` | Yes |  |
| `KPI4Failed` | `string` | No |  |
| `KPI5Failed` | `string` | No |  |
| `KPI6Failed` | `string` | No |  |
| `KPI4AbatementCost` | `decimal(21,1)` | No |  |
| `KPI5AbatementCost` | `decimal(21,1)` | No |  |
| `KPI6AbatementCost` | `decimal(22,1)` | No |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
