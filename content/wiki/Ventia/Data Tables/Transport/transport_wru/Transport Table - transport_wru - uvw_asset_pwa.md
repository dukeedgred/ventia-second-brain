---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_asset_pwa
full-name: transport_dev.transport_wru.uvw_asset_pwa
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_asset_pwa

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_asset_pwa` |
| Full name | `transport_dev.transport_wru.uvw_asset_pwa` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 16 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | asset register / hierarchy |
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2025-05-06T22:52:26.794Z; Last altered: 2025-05-07T01:19:52.909Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
  with sq2 as (
    with sq1 as (
      select
        a.id,
        code,
        a.name as assetname,
        case
          when assettype = 'Grass & Landscaping' then 'Grass & Landscaping'
          when assettype = 'Trees' then 'Grass & Landscaping'
          when assettype = 'Kerb and Channel' then 'Open Drainage'
          when assettype = 'Table Drain' then 'Open Drainage'
          when assettype = 'Road' then 'Pavement'
          when assettype = 'Road Shoulder' then 'Pavement'
          when assettype = 'Linemarking' then 'Pavement Marking'
          when assettype = 'Linemarking Symbols' then 'Pavement Marking'
          when assettype = 'Fencing' then 'Roadside Furniture'
          when assettype = 'Minor Sign' then 'Roadside Furniture'
          when assettype = 'Paved Areas' then 'Roadside Furniture'
          when assettype = 'Vehicle Barriers' then 'Roadside Furniture'
          when assettype = 'Parking Areas' then 'Roadside Furniture'
          when assettype = 'Public Art' then 'Roadside Furniture'
          when assettype = 'Pathway' then 'Shared Use Path (SUP)'
          when assettype = 'Bridge/Major Culvert' then 'Structures'
          when assettype = 'Major Sign Structure' then 'Structures'
          when assettype = 'Noise Wall' then 'Structures'
          when assettype = 'Retaining Wall' then 'Structures'
          when assettype = 'Drainage Lines' then 'Underground Drainage'
          when assettype = 'Minor Culverts' then 'Underground Drainage'
          when assettype = 'Pit' then 'Underground Drainage'
          else 'NA'
        end as `assetclass`,
        
        assettype,
        stage,
        spatialtype,
        spatialinfo,
        a.notes,
        case
          when aa.name = 'length' then 'Length'
          when aa.name = 'Length (m)' then 'Length'
          when aa.name = 'Asset Length (M)' then 'Length'
          when aa.name = 'st_area_sh' then 'Area'
          --- Reinstate if Minor Culvert unit of measurement is no longer "No."
          --when aa.name = 'Culvert Length' then 'Length'
          when
            aa.name = 'Actual Asset Length (M)'
          then
            'Length'
          when aa.name = 'Area' then 'Area'
          when aa.name = 'Shoulder Length (m)' then 'Length'
          when aa.name = 'Area (sqm)' then 'Area'
          when aa.name = 'Significant Area' then 'Area'
          when aa.name = 'Length of barrier (m)' then 'Length'
          else aa.name
        end as `name`,
        aa.Value
      from
        uvw_asset a
          left join uvw_assetattribute aa
            on a.id = aa.AssetID
      where
        aa.Name in (
          'Third Party Site',
          'length',
          'Length (m)',
          'Asset Length (M)',
          'st_area_sh',
          'Actual Asset Length (M)',
          'Area',
          'Shoulder Length (m)',
          'Area (sqm)',
          'Length of barrier (m)',
          'Structure Form'
        )-- FILTERED ASSET FOR TESTING
      -- and a.code = 'Sym0924554'

    )
    select
      *
    from
      sq1
        pivot (
          max(value) FOR Name in (
            'Third Party Site' as `thirdpartysite`,
            'Length' as `length`,
            'Area' as `area`,
            'Structure Form' as `Structure Form`
          )
        )
  )
  select
    id,
    code,
    assetname,
    assetclass,
    stage,
    spatialtype,
    spatialinfo,
    notes,
    thirdpartysite,
    `structure form`,
    concat(
        "https://vicroads.assetvision.com.au/Assets/ViewAsset/", string(id)
      ) as asset_hyperlink,
    case
      when assettype = 'Linemarking' then 'Linemarking Lines'
      when assettype = 'Linemarking Symbols' then 'Linemarking Symbols'
      when assettype = 'Vehicle Barriers' then 'New Wire Rope / Safety Barrier'
      when assettype = 'Pathway' then 'Shared Use Path (SUP)'
      when `Structure Form` = 'BRIDGES' then 'Bridges'
      when `Structure Form` = 'MAJOR CULVERTS' then 'Major culverts'
      else `assettype`
    end as `assettype`,
    case
      when notes LIKE '%WRU%' then SUBSTRING(notes, CHARINDEX('WRU', notes), 12)
      when notes LIKE '%PWA%' then SUBSTRING(notes, CHARINDEX('PWA', notes), 12)
    end AS thirdpartysite_derived,
    case
      when
        (
          thirdpartysite is not NULL
          or thirdpartysite <> ''
        )
        and notes like '%New built;%'
      then
        'Newly built'
      when
        notes like '%Removed%'
        or notes like '%removed%'
      then
        'Removed'
      when
        notes like '%Excluded%'
        or notes like '%Existing%'
      then
        'Excluded'
      else "TBC"
    end as `status`,
    coalesce(length, area, 1) as qty,
    case
      when spatialtype = 'Point' then 'No.'
      when spatialtype in ('Polyline', 'MultiLineString') then 'm'
      when spatialtype = 'Polygon' then 'sqm'
    end as `qtyunit`
  from
    sq2
  where
    notes LIKE '%PWA%'
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `id` | `int` | Yes |  |
| `code` | `string` | Yes |  |
| `assetname` | `string` | Yes |  |
| `assetclass` | `string` | No |  |
| `stage` | `string` | Yes |  |
| `spatialtype` | `string` | Yes |  |
| `spatialinfo` | `string` | Yes |  |
| `notes` | `string` | Yes |  |
| `thirdpartysite` | `string` | Yes |  |
| `structure form` | `string` | Yes |  |
| `asset_hyperlink` | `string` | Yes |  |
| `assettype` | `string` | Yes |  |
| `thirdpartysite_derived` | `string` | Yes |  |
| `status` | `string` | No |  |
| `qty` | `string` | No |  |
| `qtyunit` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
