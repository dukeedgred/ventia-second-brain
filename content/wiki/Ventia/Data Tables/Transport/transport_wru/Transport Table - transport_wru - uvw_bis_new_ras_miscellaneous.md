---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_bis_new_ras_miscellaneous
full-name: transport_dev.transport_wru.uvw_bis_new_ras_miscellaneous
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_bis_new_ras_miscellaneous

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_bis_new_ras_miscellaneous` |
| Full name | `transport_dev.transport_wru.uvw_bis_new_ras_miscellaneous` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 16 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | lane access |
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-06-12T06:21:10.268Z; Last altered: 2024-09-24T01:43:04.919Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
select
  concat(extract(Day from ass.conditiondate), '/', extract(Month from ass.conditiondate), '/', extract(Year from ass.conditiondate)) as DATE_M,
  ass.parentassetcode as ID_STRUCTURE,
  NULL as CONS_DATE_ORG,
  NULL as CONS_DATE_WIDE,
  NULL as CONS_DATE_LIMIT,
  NULL as DESIGN_LOAD_ORG,
  NULL as DESIGN_LOAD_WIDE,
  NULL as BEAM_TYPE,
  NULL as BEAM_SPACE,
  NULL as BEAM_DEPTH,
  NULL as BEAM_LENGTH,
  NULL as DECK_TYPE,
  min(case aa.name when 'Inspection Weather' then value end) WEATHER,
  min(case aa.name when 'Inspection Temperature' then value end) TEMPERATURE,
  NULL as EXISTING_POST_LIMIT,
  NULL as EXISTING_CLEARANCE_HEIGHT
from
  transport_dev.transport_wru.uvw_assetattribute aa
  inner join transport_dev.transport_wru.uvw_asset ass on ass.id = aa.assetid
where
  assettype = 'Structure Components'
  and ass.stage = 'Active'
group by
  ass.name,
  ass.conditiondate,
  ass.parentassetcode
order by
  ID_STRUCTURE,
  DATE_M
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `DATE_M` | `string` | Yes |  |
| `ID_STRUCTURE` | `string` | Yes |  |
| `CONS_DATE_ORG` | `void` | Yes |  |
| `CONS_DATE_WIDE` | `void` | Yes |  |
| `CONS_DATE_LIMIT` | `void` | Yes |  |
| `DESIGN_LOAD_ORG` | `void` | Yes |  |
| `DESIGN_LOAD_WIDE` | `void` | Yes |  |
| `BEAM_TYPE` | `void` | Yes |  |
| `BEAM_SPACE` | `void` | Yes |  |
| `BEAM_DEPTH` | `void` | Yes |  |
| `BEAM_LENGTH` | `void` | Yes |  |
| `DECK_TYPE` | `void` | Yes |  |
| `WEATHER` | `string` | Yes |  |
| `TEMPERATURE` | `string` | Yes |  |
| `EXISTING_POST_LIMIT` | `void` | Yes |  |
| `EXISTING_CLEARANCE_HEIGHT` | `void` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
