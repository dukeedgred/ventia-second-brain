---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: uvw_kpi_20_21_pcas_test
full-name: transport_dev.transport_tsrc.uvw_kpi_20_21_pcas_test
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - uvw_kpi_20_21_pcas_test

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_kpi_20_21_pcas_test` |
| Full name | `transport_dev.transport_tsrc.uvw_kpi_20_21_pcas_test` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | VIEW |
| Column count | 9 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | KPI / reporting |
| Owner/SME | huy.nguyen@ventia.com |
| Refresh/freshness | Created: 2026-03-10T22:19:00.099Z; Last altered: 2026-03-10T22:19:00.099Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
WITH tmp2 as (
---Calcaulates the average/mean IRI grouped by the pavement reporting section
WITH tmp as(
  SELECT 
  SurveyYear, 
  `PavementSectionID`,
  repsec.ReportingSectionType,
  CASE 
  WHEN ReportingSectionType = 'carriageway' 
  THEN 2.2
  WHEN ReportingSectionType = 'ramp' 
  THEN 2.6
  ELSE ''
  END as pavement_performance_target,
  CASE 
  WHEN ReportingSectionType = 'carriageway' 
  THEN 3
  WHEN ReportingSectionType = 'ramp' 
  THEN 3.5
  ELSE ''
  END as penalty_points,
  AVG(`IRI_I`) as mean_IRI,
  CEIL(AVG(`IRI_I`),1) as rounded_mean_IRI_I

FROM `transport_dev`.`transport_tsrc`.`utbl_pcas_test` pcas
INNER JOIN transport_dev.transport_tsrc.utbl_pavement_reporting_sections_test repsec
ON pcas.PavementSectionID = repsec.PavementReportingSection
GROUP BY `PavementSectionID`, ReportingSectionType, SurveyYear
ORDER BY `PavementSectionID`
)
---Calculates kpi incidents
SELECT 
tmp.*,
CASE 
WHEN rounded_mean_IRI_I - pavement_performance_target > 0 
THEN CEIL((rounded_mean_IRI_I - pavement_performance_target),1)/0.1
ELSE null
END as kpi_incidents
FROM tmp
)
---Calculates penalty points
SELECT 
tmp2.*,
kpi_incidents * penalty_points as penalty_points_incurred 
FROM tmp2
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `SurveyYear` | `bigint` | Yes |  |
| `PavementSectionID` | `string` | Yes |  |
| `ReportingSectionType` | `string` | Yes |  |
| `pavement_performance_target` | `string` | No |  |
| `penalty_points` | `string` | No |  |
| `mean_IRI` | `double` | Yes |  |
| `rounded_mean_IRI_I` | `decimal(17,1)` | Yes |  |
| `kpi_incidents` | `decimal(23,6)` | Yes |  |
| `penalty_points_incurred` | `double` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
