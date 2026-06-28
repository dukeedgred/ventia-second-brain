---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_tgs_module
full-name: transport_dev.transport_wru.uvw_tgs_module
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_tgs_module

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_tgs_module` |
| Full name | `transport_dev.transport_wru.uvw_tgs_module` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 7 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | forms / modules |
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-06-13T02:03:50.256Z; Last altered: 2024-09-24T01:42:36.481Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
        select x.module_id, x.tgs_name, `TGS Attributes|Description (Works)` as description_works,
        `TGS Attributes|Road Type` as road_type,
        `TGS Attributes|TGS Current` as current_status,
        `TGS Attributes|Work Location` as work_location,
        y.url as TGS_image
from (
select * from (
select a.id as module_id,a.name as tgs_name, b.name, coalesce(b.value,"") as value from module a
join formfield b on a.id = b.sourcetableid
where (b.name in ("TGS Attributes|Description (Works)", 
"TGS Attributes|Road Type",
"TGS Attributes|Work Location"
) or (b.name = "TGS Attributes|TGS Current" and b.value = "Yes")) and a.deleted = false and b.deleted = false 

)
pivot (max(value) for name in ("TGS Attributes|Description (Works)", 
"TGS Attributes|Road Type",
"TGS Attributes|TGS Current",
"TGS Attributes|Work Location"
))
) x
join photo y
on x.module_id = y.sourcetableid
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `module_id` | `int` | Yes |  |
| `tgs_name` | `string` | Yes |  |
| `description_works` | `string` | Yes |  |
| `road_type` | `string` | Yes |  |
| `current_status` | `string` | Yes |  |
| `work_location` | `string` | Yes |  |
| `TGS_image` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
