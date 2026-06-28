---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: uvw_kpi_22_23_pcas_test
full-name: transport_dev.transport_tsrc.uvw_kpi_22_23_pcas_test
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - uvw_kpi_22_23_pcas_test

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_kpi_22_23_pcas_test` |
| Full name | `transport_dev.transport_tsrc.uvw_kpi_22_23_pcas_test` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | VIEW |
| Column count | 15 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | KPI / reporting |
| Owner/SME | huy.nguyen@ventia.com |
| Refresh/freshness | Created: 2026-03-17T23:56:14Z; Last altered: 2026-03-17T23:56:14Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
  WITH tmp2 as (
    ---Pulls only the neccesary fields
    WITH tmp as (
      SELECT
        fid,
        SurveyYear,
        `PavementSectionID`,
        repsec.ReportingSectionType,
        pcas.RoadName,
        lane,
        chainage_start,
        chainage_end,
        WKT,
        CASE
          WHEN ReportingSectionType = 'carriageway' THEN 2.9
          WHEN ReportingSectionType = 'ramp' THEN 3.6
          ELSE ''
        END as pavement_performance_target,
        CASE
          WHEN ReportingSectionType = 'carriageway' THEN 3
          WHEN ReportingSectionType = 'ramp' THEN 3.5
          ELSE ''
        END as penalty_points,
        CEIL(IRI_I, 1) as ROUNDED_IRI,
        `IRI_I`
      FROM
        `transport_dev`.`transport_tsrc`.`utbl_pcas_test` pcas
          INNER JOIN transport_dev.transport_tsrc.utbl_pavement_reporting_sections_test repsec
            ON pcas.PavementSectionID = repsec.PavementReportingSection
      ORDER BY
        `PavementSectionID`
    )
    ---Calculates kpi incidents
    SELECT
      tmp.*,
      CASE
        WHEN
          IRI_I - pavement_performance_target > 0
        THEN
          CEIL((IRI_I - pavement_performance_target), 1) / 0.1
        ELSE null
      END as kpi_incidents
    FROM
      tmp
  )
  ---Calculates penalty points
  SELECT
    tmp2.*,
    kpi_incidents * penalty_points as penalty_points_incurred
  FROM
    tmp2
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `fid` | `bigint` | Yes |  |
| `SurveyYear` | `bigint` | Yes |  |
| `PavementSectionID` | `string` | Yes |  |
| `ReportingSectionType` | `string` | Yes |  |
| `RoadName` | `string` | Yes |  |
| `lane` | `bigint` | Yes |  |
| `chainage_start` | `bigint` | Yes |  |
| `chainage_end` | `bigint` | Yes |  |
| `WKT` | `string` | Yes |  |
| `pavement_performance_target` | `string` | No |  |
| `penalty_points` | `string` | No |  |
| `ROUNDED_IRI` | `decimal(17,1)` | Yes |  |
| `IRI_I` | `double` | Yes |  |
| `kpi_incidents` | `decimal(23,6)` | Yes |  |
| `penalty_points_incurred` | `double` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
