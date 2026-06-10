---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_inspection_kpi_1_dashboard
full-name: transport_dev.transport_wru.uvw_inspection_kpi_1_dashboard
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_inspection_kpi_1_dashboard

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_inspection_kpi_1_dashboard` |
| Full name | `transport_dev.transport_wru.uvw_inspection_kpi_1_dashboard` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 30 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | KPI / reporting |
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-06-18T13:36:32.374Z; Last altered: 2024-09-24T01:42:47.747Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
select
  case
    when b.DateUID is null then 'Compliant'
    when b.DateUID is not null then 'Non Compliant'
  end as Compliant_Status, 
  case
    when b.DateUID is null then 'N/A'
    when b.DateUID is not null then b.Non_Compliant_Comments
  end as Non_Compliant_Comments,
  a.*
from
  transport_dev.transport_wru.uvw_inspection_kpi_1_series a
  left join transport_dev.transport_wru.uvw_kpi_1_noncompliant b on a.dateuid = b.dateuid
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Compliant_Status` | `string` | Yes |  |
| `Non_Compliant_Comments` | `string` | Yes |  |
| `Compliant_Timing` | `string` | No |  |
| `completedTime` | `timestamp` | Yes |  |
| `Previous_InspDate` | `timestamp` | Yes |  |
| `Previous_InspDay` | `string` | Yes |  |
| `Days_Since_LastInsp` | `int` | Yes |  |
| `dateuid` | `string` | Yes |  |
| `RdNo` | `string` | Yes |  |
| `RdName` | `string` | Yes |  |
| `section_name` | `string` | Yes |  |
| `Section_Desc` | `string` | Yes |  |
| `Rd_Desc` | `string` | Yes |  |
| `InspRunType` | `string` | Yes |  |
| `Forward_Start_Chainage` | `bigint` | Yes |  |
| `Forward_End_Chainage` | `bigint` | Yes |  |
| `Reverse_Start_Chainage` | `bigint` | Yes |  |
| `Reverse_End_Chainage` | `bigint` | Yes |  |
| `Inspection_Type` | `string` | Yes |  |
| `type` | `string` | No |  |
| `completeddate` | `string` | Yes |  |
| `completedDay` | `string` | Yes |  |
| `classification` | `string` | Yes |  |
| `KPI_Reference` | `string` | Yes |  |
| `Reporting_ID` | `string` | Yes |  |
| `section_Reporting_ID` | `string` | Yes |  |
| `F_Insp` | `int` | Yes |  |
| `R_Insp` | `int` | Yes |  |
| `F_Insp_AV_LInk` | `string` | Yes |  |
| `R_Insp_AV_LInk` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
