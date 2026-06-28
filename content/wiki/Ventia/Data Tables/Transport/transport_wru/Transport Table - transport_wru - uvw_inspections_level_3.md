---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_inspections_level_3
full-name: transport_dev.transport_wru.uvw_inspections_level_3
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_inspections_level_3

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_inspections_level_3` |
| Full name | `transport_dev.transport_wru.uvw_inspections_level_3` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 9 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | inspection / audit / condition |
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-06-20T07:36:39.093Z; Last altered: 2024-09-24T01:42:54.293Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
SELECT
  id as inspection_id,
  inspection_hyperlink,
  assetid,
  assettypename,
  completed_date,
  scheduled_date,
  inspectiontype,
  completeduser,
  inspection_comments
from
  transport_dev.transport_wru.uvw_inspection_completions
where
  inspectiontype = "Level 3 Inspection"
order by
  assetid,
  completed_date
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `inspection_id` | `int` | Yes |  |
| `inspection_hyperlink` | `string` | Yes |  |
| `assetid` | `int` | Yes |  |
| `assettypename` | `string` | Yes |  |
| `completed_date` | `date` | Yes |  |
| `scheduled_date` | `date` | Yes |  |
| `inspectiontype` | `string` | No |  |
| `completeduser` | `string` | Yes |  |
| `inspection_comments` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
