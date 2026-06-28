---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_inspection_settlement_monitoring
full-name: transport_dev.transport_wru.uvw_inspection_settlement_monitoring
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_inspection_settlement_monitoring

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_inspection_settlement_monitoring` |
| Full name | `transport_dev.transport_wru.uvw_inspection_settlement_monitoring` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 8 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | inspection / audit / condition |
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-06-18T14:25:49.788Z; Last altered: 2024-09-24T01:42:27.403Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
SELECT
  id as inspection_id,
  inspection_hyperlink,
  assettypename,
  assetid,
  completed_date,
  scheduled_date,
  completeduser,
  code as structure_id
from
  transport_dev.transport_wru.uvw_inspection_completions
where
  inspectiontype = 'Settlement Monitoring – B&MC'
order by
  assetid,
  completed_date
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `inspection_id` | `int` | Yes |  |
| `inspection_hyperlink` | `string` | Yes |  |
| `assettypename` | `string` | Yes |  |
| `assetid` | `int` | Yes |  |
| `completed_date` | `date` | Yes |  |
| `scheduled_date` | `date` | Yes |  |
| `completeduser` | `string` | Yes |  |
| `structure_id` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
