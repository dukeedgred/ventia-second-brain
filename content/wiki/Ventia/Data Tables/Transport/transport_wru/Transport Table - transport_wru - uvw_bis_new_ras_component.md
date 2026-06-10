---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_bis_new_ras_component
full-name: transport_dev.transport_wru.uvw_bis_new_ras_component
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_bis_new_ras_component

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_bis_new_ras_component` |
| Full name | `transport_dev.transport_wru.uvw_bis_new_ras_component` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 22 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-06-12T06:13:33.465Z; Last altered: 2024-09-24T01:42:19.043Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
select 
  concat(extract(Day from ass.conditiondate), '/' ,extract(Month from ass.conditiondate), '/' ,extract(Year from ass.conditiondate)) as DATE_C,
  ass.parentassetcode as ID_STRUCTURE,   
  min(case aa.name when 'Component Code' then value end) COMP_C,
  min(case aa.name when 'Exposure Class' then left(value,1) end) EX,
  min(case aa.name when 'UnitOfMeasure' then value end)  UNIT,
  min(case aa.name when 'Quantity' then value end) QUANTITY,
  min(case aa.name when 'c1' then value end) PC1,
  min(case aa.name when 'c2' then value end) PC2,
  min(case aa.name when 'c3' then value end) PC3,
  min(case aa.name when 'c4' then value end) PC4,
  min(case aa.name when 'Condition Comments' then value end) INFO_C,
  min(case aa.name when 'Inspector Name' then value end)  INSP_C,
  left(min(case aa.name when 'Widening Side' then value end),1) WLR, 
  min(case aa.name when 'Widening Sequence' then value end) WS,
  min(case aa.name when 'Defect Description' then value end) DESC_C,
  min(case aa.name when 'Defect Location' then value end) LOC,
  min(case aa.name when 'Component Condition 3 Defect Treatment Option' then value end) COND3_OPTION,
  left(min(case aa.name when 'Component Condition 3 Defect 2006 Treatment Code' then value end),CHARINDEX('-', min(case aa.name when 'Component Condition 3 Defect 2006 Treatment Code' then value end)) - 1) COND3_CODE,
  min(case aa.name when 'Component Condition 3 Defect Treatment Urgency' then value end) COND3_URGENCY,
  min(case aa.name when 'Component Condition 4 Defect Treatment Option' then value end) COND4_OPTION,
  left(min(case aa.name when 'Component Condition 4 Defect 2006 Treatment Code' then value end),CHARINDEX('-', min(case aa.name when 'Component Condition 4 Defect 2006 Treatment Code' then value end)) - 1) COND4_CODE,
  min(case aa.name when 'Component Condition 4 Defect Treatment Urgency' then value end) COND4_URGENCY
from transport_dev.transport_wru.uvw_assetattribute aa
  inner join transport_dev.transport_wru.uvw_asset ass on ass.id = aa.assetid
where ass.assettype = 'Structure Components' 
  and ass.stage = 'Active'
group by 
  ass.name, 
  ass.conditiondate, 
  ass.parentassetcode
order by 
  ID_STRUCTURE, 
  DATE_C
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `DATE_C` | `string` | Yes |  |
| `ID_STRUCTURE` | `string` | Yes |  |
| `COMP_C` | `string` | Yes |  |
| `EX` | `string` | Yes |  |
| `UNIT` | `string` | Yes |  |
| `QUANTITY` | `string` | Yes |  |
| `PC1` | `string` | Yes |  |
| `PC2` | `string` | Yes |  |
| `PC3` | `string` | Yes |  |
| `PC4` | `string` | Yes |  |
| `INFO_C` | `string` | Yes |  |
| `INSP_C` | `string` | Yes |  |
| `WLR` | `string` | Yes |  |
| `WS` | `string` | Yes |  |
| `DESC_C` | `string` | Yes |  |
| `LOC` | `string` | Yes |  |
| `COND3_OPTION` | `string` | Yes |  |
| `COND3_CODE` | `string` | Yes |  |
| `COND3_URGENCY` | `string` | Yes |  |
| `COND4_OPTION` | `string` | Yes |  |
| `COND4_CODE` | `string` | Yes |  |
| `COND4_URGENCY` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
