---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_bis_new_ras_bridge
full-name: transport_dev.transport_wru.uvw_bis_new_ras_bridge
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_bis_new_ras_bridge

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_bis_new_ras_bridge` |
| Full name | `transport_dev.transport_wru.uvw_bis_new_ras_bridge` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 14 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-06-14T02:29:57.91Z; Last altered: 2024-09-24T01:43:04.137Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
select
  ass.code as ID_STRUCTURE,
    min( 
   case
      aa.name
      when 'Date of Last Level 2 Inspection' then left(value,10)
    end
  ) DATEINSP,

  '0' as CONDL1,
  '0' as CONDL2,
  '0' as CONDR1,
  '0' as CONDR2,
  min(
    case
      aa.name
      when 'Inspector Name' then value
    end
  ) INSP,
  min(
    case
      aa.name
      when 'Original Structure Condition' then value
    end
  ) OCOND,
  min(
    case
      aa.name
      when 'Traffic Width (m)' then value
    end
  ) TRAF_WIDTH,
  min(
    case
      aa.name
      when 'Current L2 Inspection Status' then value
    end
  ) L2INSPECTION,
  min(
    case
      aa.name
      when 'Latest Bridge/Culvert Rating' then value
    end
  ) QT_BCR,
  min(
    case
      aa.name
      when 'Condition Origin' then value
    end
  ) CondOrig,

  min(
    SUBSTRING(spatialinfo, CHARINDEX('-', spatialinfo), LEN(spatialinfo) - CHARINDEX('-', spatialinfo))
  ) LAT,
  min(
    SUBSTRING(spatialinfo,LEN(LEFT(spatialinfo,CHARINDEX('(', spatialinfo)+1)),LEN(spatialinfo) - LEN(LEFT(spatialinfo,CHARINDEX('(', spatialinfo))) - LEN(RIGHT(spatialinfo,CHARINDEX('-', (REVERSE(spatialinfo))))))
  ) LONG
from
  transport_dev.transport_wru.uvw_assetattribute aa
  inner join transport_dev.transport_wru.uvw_asset ass on ass.id = assetid
where
  ass.assettype in (
    'Major Sign Structure',
    'Bridge/Major Culvert',
    'Noise Wall',
    'Retaining Wall'
  )
  and ass.stage = 'Active'
  
Group By
  ass.code,
  ass.conditiondate
Order by
  ID_STRUCTURE
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `ID_STRUCTURE` | `string` | Yes |  |
| `DATEINSP` | `string` | Yes |  |
| `CONDL1` | `string` | No |  |
| `CONDL2` | `string` | No |  |
| `CONDR1` | `string` | No |  |
| `CONDR2` | `string` | No |  |
| `INSP` | `string` | Yes |  |
| `OCOND` | `string` | Yes |  |
| `TRAF_WIDTH` | `string` | Yes |  |
| `L2INSPECTION` | `string` | Yes |  |
| `QT_BCR` | `string` | Yes |  |
| `CondOrig` | `string` | Yes |  |
| `LAT` | `string` | Yes |  |
| `LONG` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
