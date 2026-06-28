---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_asset_register
full-name: transport_dev.transport_wru.uvw_asset_register
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_asset_register

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_asset_register` |
| Full name | `transport_dev.transport_wru.uvw_asset_register` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 13 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | asset register / hierarchy |
| Owner/SME | rui.luan@ventia.com |
| Refresh/freshness | Created: 2024-09-24T04:14:56.321Z; Last altered: 2024-09-24T04:14:56.321Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
with sq2 as (
  with sq1 as (
    select
      a.id,
      a.code as structure_ID,
      a.name as structure_name,
      a.assettype as assettype_temp,
      a.stage,
      a.parentassetname as road_name,
      a.parentassetcode as road_number,
      a.notes,
      a.alertnotes,
      b.value,
      b.name
    from
      transport_wru.uvw_asset a
      join transport_wru.uvw_assetattribute b on a.id = b.assetid
    WHERE
      a.assettype in (
                        'Retaining Wall',
                        'Major Sign Structure',
                        'Noise Wall',
                        'Bridge/Major Culvert' --'Bridge' no value in assettype = 'Bridge'
                     )
  )
  select
    *
  from
    sq1 pivot (
      max(value) for name in (
                                'Structure Form',
                                'Bridge Function',
                                'Structure Type'
                             )
    )
)
select
  a.id,
  a.structure_ID,
  a.structure_name,
  a.stage,
  a.road_name,
  a.road_number,
  a.notes,
  a.alertnotes,
  b.wkt as spatialinfo,
  a.assettype_temp as asset_class,
  case
    when assettype_temp = 'Bridge/Major Culvert' 
    then case
            when `Structure Form` = 'BRIDGES' then 'Bridge'
            when `Structure Form` = 'MAJOR CULVERTS' and `Bridge Function` <> 'Pedestrian Underpass' then 'Major Culvert'
            when `Bridge Function` = 'Pedestrian Underpass' then 'Underpass'
        end
    when assettype_temp = 'Major Sign Structure' 
    then case
            when `Structure Type` = 'CANTILEVER SIGN' then 'Cantilever Sign'
            when `Structure Type` = "GANTRY SIGN" then 'Gantry Sign'
        end
    else assettype_temp
  end as asset_subclass,
  case
    when a.assettype_temp = "Bridge/Major Culvert" 
    then case
            when `Structure Form` = "BRIDGES" then "Bridge"
            when `Structure Form` = "MAJOR CULVERTS" then "Major Culvert"
        end
    else a.assettype_temp
  end as assettype,
  case
    when assettype in ("Bridge", "Major Culvert") then `Bridge Function`
    else assettype
  end as bridge_function
from
  sq2 a
  join  (
      select * from (
      select row_number() over(partition by assetID order by modifiedUTC desc) rn ,assetid, direction,chainagefrom, chainageto, wkt from ext_mssql_asset_vision_ven_vicroads.dbo.vassetlocation where deleted is false
      ) where rn = 1
    ) 
   b on a.id = b.assetid
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `id` | `int` | Yes |  |
| `structure_ID` | `string` | Yes |  |
| `structure_name` | `string` | Yes |  |
| `stage` | `string` | Yes |  |
| `road_name` | `string` | Yes |  |
| `road_number` | `string` | Yes |  |
| `notes` | `string` | Yes |  |
| `alertnotes` | `string` | Yes |  |
| `spatialinfo` | `string` | Yes |  |
| `asset_class` | `string` | Yes |  |
| `asset_subclass` | `string` | Yes |  |
| `assettype` | `string` | Yes |  |
| `bridge_function` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
