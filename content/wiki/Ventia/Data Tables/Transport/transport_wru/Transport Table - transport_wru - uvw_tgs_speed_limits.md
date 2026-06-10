---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_tgs_speed_limits
full-name: transport_dev.transport_wru.uvw_tgs_speed_limits
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_tgs_speed_limits

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_tgs_speed_limits` |
| Full name | `transport_dev.transport_wru.uvw_tgs_speed_limits` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 2 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-06-13T03:44:19.212Z; Last altered: 2024-09-24T01:42:31.965Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
select a.id as module_id, b.value as speed from module a
  join formfield b on a.id = b.sourcetableid
  where b.name in (
    "TGS Attributes|Applicable Speed Limits (Insert up to 6 speeds)|Speed 1", 
    "TGS Attributes|Applicable Speed Limits (Insert up to 6 speeds)|Speed 2",
    "TGS Attributes|Applicable Speed Limits (Insert up to 6 speeds)|Speed 3",
    "TGS Attributes|Applicable Speed Limits (Insert up to 6 speeds)|Speed 4",
    "TGS Attributes|Applicable Speed Limits (Insert up to 6 speeds)|Speed 5",
    "TGS Attributes|Applicable Speed Limits (Insert up to 6 speeds)|Speed 6"
                  ) and a.deleted = false and b.deleted = false and b.value is not null
  )
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `module_id` | `int` | Yes |  |
| `speed` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
