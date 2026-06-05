---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: uvw_traffic_volume
full-name: transport_dev.transport_tsrc.uvw_traffic_volume
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-table, databricks, transport-tsrc, traffic-volume]
---

# Transport Table - transport_tsrc - uvw_traffic_volume

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_traffic_volume` |
| Full name | `transport_dev.transport_tsrc.uvw_traffic_volume` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | VIEW |
| Column count | 10 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | traffic volume |
| Related tables/reports | `ext_mssql_asset_vision_ven_gen7.dbo.module`, `ext_mssql_asset_vision_ven_gen7.dbo.formfield` |

## View Query

```sql
select
  cast(m.id as int) as id,
  m.createddate,
  COALESCE(to_date(f1.value, 'd/M/yyyy H:m:s'), date_add(m.createddate, -1)) as trafficdate,
  to_timestamp(f1.value, 'd/M/yyyy H:m:s') as trafficvolumedate,
  m.comments,
  f.name,
  substring(f.name, 23, charindex('|', f.name, 23) -23) as roadname,
  substring(f.name, charindex('|', f.name, 23) + 1, 15) as sectionname,
  case
    when charindex('EB', f.name) > 0 
    then 'Eastbound'
    else 'Westbound'
  end as direction,
  coalesce(cast(f.value as int), 0) as trafficvolume
from
  ext_mssql_asset_vision_ven_gen7.dbo.module m
  left join ext_mssql_asset_vision_ven_gen7.dbo.formfield f on m.id = f.sourcetableid
  left join ext_mssql_asset_vision_ven_gen7.dbo.formfield f1 on m.id = f1.sourcetableid
where
  m.contract = 'Toowoomba Second Range Crossing'
  and m.modulename = 'Traffic Volumes'
  and m.deleted = false
  and f.sourcetable = 'Module'
  and f.name <> 'Daily Traffic Volumes|Traffic Volume Date'
  and f.deleted = false
  and f1.sourcetable = 'Module'
  and f1.name = 'Daily Traffic Volumes|Traffic Volume Date'
  and f1.deleted = false
order by
  m.id
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `id` | `int` | Yes |  |
| `createddate` | `timestamp` | Yes |  |
| `trafficdate` | `date` | Yes |  |
| `trafficvolumedate` | `timestamp` | Yes |  |
| `comments` | `string` | Yes |  |
| `name` | `string` | Yes |  |
| `roadname` | `string` | Yes |  |
| `sectionname` | `string` | Yes |  |
| `direction` | `string` | No |  |
| `trafficvolume` | `int` | No |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
