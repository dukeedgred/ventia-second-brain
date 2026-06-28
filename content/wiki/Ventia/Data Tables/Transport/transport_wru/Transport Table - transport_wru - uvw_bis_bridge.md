---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_bis_bridge
full-name: transport_dev.transport_wru.uvw_bis_bridge
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_bis_bridge

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_bis_bridge` |
| Full name | `transport_dev.transport_wru.uvw_bis_bridge` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 23 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-06-12T06:05:06.271Z; Last altered: 2024-09-24T01:42:59.84Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
select
  *
from
  (
    select
      '0' as BridgeID,
      ass.code as StrucIdentNo,
      ass.parentassetcode as RoadNumber,
      ass.parentassetname as RoadName,
      ass.chainagefrom as Location,
      null as MapDescription,
      null as MapFileLocation,
      null as MapImage,
      null as MapLastUpdated,
      null as BridgeThumbnail,
      date_format(ass.constructiondate, 'dd/mm/yyyy') as ConstructionDate_Original,
      null as ConstructionDate_Widening,
      null as DesignLoading_Widening,
      null as MaximumSpanLength,
      null as Beam_Slab_Type,
      null as Beam_Slab_Depth,
      null as Beam_Slab_Spacing,
      null as DeckType,
      aa.name,
      value
    from
      transport_dev.transport_wru.uvw_assetattribute aa
      inner join transport_dev.transport_wru.uvw_asset ass on ass.id = aa.AssetID --need to revise this to be able to define list of structures that need to be included in the extract
    where
      ass.assettype in (
                            'Major Sign Structure',
                            'Bridge/Major Culvert',
                            'Noise Wall',
                            'Retaining Wall'    
                        )
      and ass.stage = 'Active'
  ) pivot(
    max(value) FOR name in (
      'DoT Region Name' as `Region`,
      'Local Government Area' as `MunicipalityCode`,
      'Feature Crossed' as `Crossing`,
      'Design Load' as `DesignLoading_Original`,
      'Existing Posted Load Limit (Tonnes)' as `PostedLoadLimitInStruct`
    )
  )
order by
  StrucIdentNo
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `BridgeID` | `string` | No |  |
| `StrucIdentNo` | `string` | Yes |  |
| `RoadNumber` | `string` | Yes |  |
| `RoadName` | `string` | Yes |  |
| `Location` | `int` | Yes |  |
| `MapDescription` | `void` | Yes |  |
| `MapFileLocation` | `void` | Yes |  |
| `MapImage` | `void` | Yes |  |
| `MapLastUpdated` | `void` | Yes |  |
| `BridgeThumbnail` | `void` | Yes |  |
| `ConstructionDate_Original` | `string` | Yes |  |
| `ConstructionDate_Widening` | `void` | Yes |  |
| `DesignLoading_Widening` | `void` | Yes |  |
| `MaximumSpanLength` | `void` | Yes |  |
| `Beam_Slab_Type` | `void` | Yes |  |
| `Beam_Slab_Depth` | `void` | Yes |  |
| `Beam_Slab_Spacing` | `void` | Yes |  |
| `DeckType` | `void` | Yes |  |
| `Region` | `string` | Yes |  |
| `MunicipalityCode` | `string` | Yes |  |
| `Crossing` | `string` | Yes |  |
| `DesignLoading_Original` | `string` | Yes |  |
| `PostedLoadLimitInStruct` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
