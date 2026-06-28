---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_job_geom
full-name: transport_dev.transport_wru.uvw_job_geom
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_job_geom

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_job_geom` |
| Full name | `transport_dev.transport_wru.uvw_job_geom` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 5 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | jobs / work orders |
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-08-12T00:20:30.002Z; Last altered: 2024-09-24T01:42:39.137Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
select 
    id,wkt 
    ,trim(left(wkt, charindex('(',wkt) - 1)) as wkt_Type
    ,case when trim(left(wkt, charindex('(',wkt) - 1)) = 'POINT' then
        cast(substring(left(wkt,charindex(' ',wkt,charindex('(',wkt))), charindex('(',wkt)+1) as float)
    else 
        null
    end  as start_longitude
    ,case when trim(left(wkt, charindex('(',wkt) - 1)) = 'POINT' then
        cast(left(substring(wkt,charindex(' ',wkt, charindex('(',wkt))), len(substring(wkt,charindex(' ',wkt, charindex('(',wkt))))-1) as float)
    else
        null
    end  as start_latitude
from ext_mssql_asset_vision_ven_vicroads.dbo.vjob
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `id` | `int` | Yes |  |
| `wkt` | `string` | Yes |  |
| `wkt_Type` | `string` | Yes |  |
| `start_longitude` | `float` | Yes |  |
| `start_latitude` | `float` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
