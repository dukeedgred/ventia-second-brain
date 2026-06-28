---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: uvw_incident_closures
full-name: transport_dev.transport_tsrc.uvw_incident_closures
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - uvw_incident_closures

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_incident_closures` |
| Full name | `transport_dev.transport_tsrc.uvw_incident_closures` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | VIEW |
| Column count | 6 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | traffic counts / closures |
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2024-06-05T01:42:30.927Z; Last altered: 2024-07-18T22:23:37.322Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
  with tmp as (
    select
      f.name,
      f.value,
      m.parentsourcetableid
    from
      ext_mssql_asset_vision_ven_gen7.dbo.formfield f
      inner join ext_mssql_asset_vision_ven_gen7.dbo.module m on f.sourcetableid = m.id
    where
      f.deleted = false
      and m.deleted = false
      and m.contract = 'Toowoomba Second Range Crossing'
      and m.modulename in ('Incident Closure')
  )
  select
    *
  from
    tmp pivot (
      max(value) FOR name in (
        'Incident Closure details|TGS' as `IncidentClosureDetails-TGS`,
        'Incident Closure details|Closure Purpose' as `IncidentClosureDetails-ClosurePurpose`,
        'Incident Closure details|Closure Type' as `IncidentClosureDetails-ClosureType`,
        'Incident Closure details|Section' as `IncidentClosureDetails-Section`,
        'Incident Closure details|Applied by' as `IncidentClosureDetails-Appliedby`
      )
    )
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `parentsourcetableid` | `int` | Yes |  |
| `IncidentClosureDetails-TGS` | `string` | Yes |  |
| `IncidentClosureDetails-ClosurePurpose` | `string` | Yes |  |
| `IncidentClosureDetails-ClosureType` | `string` | Yes |  |
| `IncidentClosureDetails-Section` | `string` | Yes |  |
| `IncidentClosureDetails-Appliedby` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
