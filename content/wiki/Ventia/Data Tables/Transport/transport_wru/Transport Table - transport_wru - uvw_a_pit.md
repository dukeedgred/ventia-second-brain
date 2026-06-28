---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_a_pit
full-name: transport_dev.transport_wru.uvw_a_pit
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_a_pit

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_a_pit` |
| Full name | `transport_dev.transport_wru.uvw_a_pit` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 20 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-06-12T05:08:33.725Z; Last altered: 2024-09-24T01:42:19.902Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
  select
    *
  from
    (
      select
        a.id as Asset_ID,
        a.stage,
        a.code as Asset_Code,
        a.name as Asset_Name,
        a.parentassetid as Road_No,
        a.parentassetname as Road_Name,
        if(a.direction = 'Outbound', 'Forward', 'Reverse') as direction,
        a.assetcondition,
        a.conditiondate,
        b.name,
        b.value,
        a.notes,
        a.alertnotes
      from
        ext_mssql_asset_vision_ven_vicroads.dbo.asset a
        join ext_mssql_asset_vision_ven_vicroads.dbo.assetattribute b on a.id = b.assetid
      where
        a.assettype = 'Pit'
        and a.deleted = false
        and a.contract like '%Western Roads Upgrade (WRU)%'
        and a.stage in ('Active', 'Planned')
    ) PIVOT (
      max(value) FOR name in (
        'Asset Sub-Type',
        'Drainage Class Risk Classification',
        'Pit Shape',
        'Pit Diameter/Width (mm)',
        'Pit Depth (mm)',
        'Pit Length (mm)',
        'Material',
        'Pit Lid Type',
        'Pit Lid Shape'
      )
    )
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Asset_ID` | `int` | Yes |  |
| `stage` | `string` | Yes |  |
| `Asset_Code` | `string` | Yes |  |
| `Asset_Name` | `string` | Yes |  |
| `Road_No` | `int` | Yes |  |
| `Road_Name` | `string` | Yes |  |
| `direction` | `string` | No |  |
| `assetcondition` | `string` | Yes |  |
| `conditiondate` | `timestamp` | Yes |  |
| `notes` | `string` | Yes |  |
| `alertnotes` | `string` | Yes |  |
| `Asset Sub-Type` | `string` | Yes |  |
| `Drainage Class Risk Classification` | `string` | Yes |  |
| `Pit Shape` | `string` | Yes |  |
| `Pit Diameter/Width (mm)` | `string` | Yes |  |
| `Pit Depth (mm)` | `string` | Yes |  |
| `Pit Length (mm)` | `string` | Yes |  |
| `Material` | `string` | Yes |  |
| `Pit Lid Type` | `string` | Yes |  |
| `Pit Lid Shape` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
