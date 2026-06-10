---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_bis_new_ras_status
full-name: transport_dev.transport_wru.uvw_bis_new_ras_status
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_bis_new_ras_status

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_bis_new_ras_status` |
| Full name | `transport_dev.transport_wru.uvw_bis_new_ras_status` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 5 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | workflow / status |
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-06-14T02:39:04.058Z; Last altered: 2024-09-24T01:42:45.215Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
select
  ass.code as StrucIdentNo,
  -1 as ValidFlag,
  0 as HoldFlag,
  0 as ExportFlag,
  0 as StatusOverAll
from
  transport_dev.transport_wru.uvw_assetattribute aa
  inner join transport_dev.transport_wru.uvw_asset ass on ass.id = aa.assetid
Where
  ass.assettype in (
                      'Major Sign Structure',
                      'Bridge/Major Culvert',
                      'Noise Wall',
                      'Retaining Wall'
                    )
  and ass.stage = 'Active'
order by
  StrucIdentNo
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `StrucIdentNo` | `string` | Yes |  |
| `ValidFlag` | `int` | No |  |
| `HoldFlag` | `int` | No |  |
| `ExportFlag` | `int` | No |  |
| `StatusOverAll` | `int` | No |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
