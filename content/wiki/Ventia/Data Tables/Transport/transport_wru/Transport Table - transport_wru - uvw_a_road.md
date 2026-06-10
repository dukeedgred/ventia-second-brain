---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_a_road
full-name: transport_dev.transport_wru.uvw_a_road
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_a_road

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_a_road` |
| Full name | `transport_dev.transport_wru.uvw_a_road` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 11 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-06-12T05:12:17.978Z; Last altered: 2024-09-24T01:42:52.715Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
select
  *
from
  (
    select
      a.id as assetID,
      a.code as RdNo,
      a.name,
      a.stage,
      a.classification,
      a.notes,
      a.alertnotes,
      case
        when b.direction = 'Outbound' then 'Forward'
        when b.direction = 'Inbound' then 'Reverse'
        else b.direction
      end direction,
      b.chainagefrom,
      b.chainageto
    from
      ext_mssql_asset_vision_ven_vicroads.dbo.asset a
      join ext_mssql_asset_vision_ven_vicroads.dbo.assetlocation b on a.id = b.assetid
    where
      a.assettype = 'Road'
      and a.deleted = false
      and b.deleted = false
  ) pivot(
    min(chainagefrom) as Start_Chainage,
    min(chainageto) as End_Chainage FOR direction in ('Forward', 'Reverse')
  )
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `assetID` | `int` | Yes |  |
| `RdNo` | `string` | Yes |  |
| `name` | `string` | Yes |  |
| `stage` | `string` | Yes |  |
| `classification` | `string` | Yes |  |
| `notes` | `string` | Yes |  |
| `alertnotes` | `string` | Yes |  |
| `Forward_Start_Chainage` | `int` | Yes |  |
| `Forward_End_Chainage` | `int` | Yes |  |
| `Reverse_Start_Chainage` | `int` | Yes |  |
| `Reverse_End_Chainage` | `int` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
