---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_srapc
table-name: uvw_srapc_tfnsw_monthly_report_defect_intervention
full-name: transport_dev.transport_srapc.uvw_srapc_tfnsw_monthly_report_defect_intervention
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-srapc]
---

# Transport Table - transport_srapc - uvw_srapc_tfnsw_monthly_report_defect_intervention

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_srapc_tfnsw_monthly_report_defect_intervention` |
| Full name | `transport_dev.transport_srapc.uvw_srapc_tfnsw_monthly_report_defect_intervention` |
| Catalog | `transport_dev` |
| Schema | `transport_srapc` |
| Contract/schema | `transport_srapc` |
| Table type | VIEW |
| Column count | 11 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | defects / hazards / failures |
| Owner/SME | conor.murphy@ventia.com |
| Refresh/freshness | Created: 2025-07-01T04:41:07.977Z; Last altered: 2025-07-01T04:41:07.977Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
SELECT
ID AS `Unique_Reference_No`,
ActivityName AS `Asset_Class`,
InterventionName AS `Defect_Type`,
date_format(CreatedDate, 'EEEE, MMMM dd yyyy, hh:mm:ss a') AS Date_Recorded,
--date_format(DueDate, 'EEEE, MMMM dd yyyy, hh:mm:ss a') AS Date_Due,
DATE_FORMAT(CreatedDate, 'yyyy-MM') AS Month_Date_Recorded,  -- New column for month start
CONCAT(
    FLOOR(TIMESTAMPDIFF(SECOND, CreatedDate, DueDate) / 86400), ' days ',
    FLOOR(MOD(TIMESTAMPDIFF(SECOND, CreatedDate, DueDate), 86400) / 3600), ' hours'
) AS Intervention_Period,
Priority AS `Priority`,
CASE
    WHEN priority = 'High' OR priority = 'Urgent' THEN 'Reactive'
    WHEN priority = 'Low' OR priority = 'Medium' THEN 'Planned'
    ELSE 'Unknown'
  END AS priority_type,
WKT AS `Geographic Coordinates`,
REGEXP_EXTRACT(WKT, 'POINT \\(([-+]?\\d*\\.\\d+)', 1) AS Longitude,
REGEXP_EXTRACT(WKT, 'POINT \\([-+]?\\d*\\.\\d+ ([-+]?\\d*\\.\\d+)', 1) AS Latitude
FROM transport_dev.transport_srapc.uvw_job
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Unique_Reference_No` | `int` | Yes |  |
| `Asset_Class` | `string` | Yes |  |
| `Defect_Type` | `string` | Yes |  |
| `Date_Recorded` | `string` | Yes |  |
| `Month_Date_Recorded` | `string` | Yes |  |
| `Intervention_Period` | `string` | Yes |  |
| `Priority` | `string` | Yes |  |
| `priority_type` | `string` | No |  |
| `Geographic Coordinates` | `string` | Yes |  |
| `Longitude` | `string` | Yes |  |
| `Latitude` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_srapc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
