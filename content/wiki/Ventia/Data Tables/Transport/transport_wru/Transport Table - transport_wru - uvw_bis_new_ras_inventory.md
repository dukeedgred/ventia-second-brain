---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_bis_new_ras_inventory
full-name: transport_dev.transport_wru.uvw_bis_new_ras_inventory
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_bis_new_ras_inventory

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_bis_new_ras_inventory` |
| Full name | `transport_dev.transport_wru.uvw_bis_new_ras_inventory` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 46 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | inventory / materials |
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-06-12T06:16:47.983Z; Last altered: 2024-09-24T01:42:40.137Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
select
  ID_STRUCTURE,
  OBEAM_CU,
  OLEN_CU,
  OSPAN_CU,
  OWID_CU,
  TOTALWC,
  WL1C_H,
  WL1C_L,
  WL1C_N,
  WL1C_W,
  WL2C_H,
  WL2C_L,
  WL2C_N,
  WL2C_W,
  WL2_B,
  WL2_L,
  WL2_S,
  WL2_W,
  WR1C_H,
  WR1C_L,
  WR1C_N,
  WR1C_W,
  WR2C_H,
  WR2C_L,
  WR2C_N,
  WR2C_W,
  WR2_B,
  WR2_L,
  WR2_S,
  WR2_W,
  LEFT(DATE_I, 10) as DATE_I,
  INSP_1,
  OBEAM_BR,
  OLEN_BR,
  OSPAN_BR,
  OWID_BR,
  TOTALW,
  WL1_B,
  WL1_L,
  WL1_S,
  WL1_W,
  WR1_B,
  WR1_L,
  WR1_S,
  WR1_W,
  StructureForm
from
  (
    select
      *
    from
      (
        select
          ass.code as ID_STRUCTURE,
          aa.name,
          value,
          null as OBEAM_CU,
          null as OLEN_CU,
          null as OSPAN_CU,
          null as OWID_CU,
          null as TOTALWC,
          null as WL1C_H,
          null as WL1C_L,
          null as WL1C_N,
          null as WL1C_W,
          null as WL2C_H,
          null as WL2C_L,
          null as WL2C_N,
          null as WL2C_W,
          null as WL2_B,
          null as WL2_L,
          null as WL2_S,
          null as WL2_W,
          null as WR1C_H,
          null as WR1C_L,
          null as WR1C_N,
          null as WR1C_W,
          null as WR2C_H,
          null as WR2C_L,
          null as WR2C_N,
          null as WR2C_W,
          null as WR2_B,
          null as WR2_L,
          null as WR2_S,
          null as WR2_W
        from
          transport_dev.transport_wru.uvw_assetattribute aa
          inner join transport_dev.transport_wru.uvw_asset ass on ass.id = aa.assetid
      ) pivot(
        max(value) FOR name in (
          'Date of Last Level 2 Inspection' as `DATE_I`,
          'Inspector Name' as `INSP_1`,
          'Original Structure No. of Beams' as `OBEAM_BR`,
          'Overall Length (m)' as `OLEN_BR`,
          'No. Spans' as `OSPAN_BR`,
          'Original Bridge Width (m)' as `OWID_BR`,
          'Overall Width (m)' as `TOTALW`,
          'Widening Left 1 - Bridge Beams/Culvert Cell (No.)' as `WL1_B`,
          'Widening Left 1 - Bridge/Culvert Length (m)' as `WL1_L`,
          'Widening Left 1 - Bridge Spans/Cell Height' as `WL1_S`,
          'Widening Left 1 - Bridge/Culvert Width (m)' as `WL1_W`,
          'Widening Right 1 - Bridge Beams/Culvert Cell (No.)' as `WR1_B`,
          'Widening Right 1 - Bridge/Culvert Length (m)' as `WR1_L`,
          'Widening Right 1 - Bridge Spans/Cell Height' as `WR1_S`,
          'Widening Right 1 - Bridge/Culvert Width (m)' as `WR1_W`,
          'Structure Form' as `StructureForm`
        )
      )
  )
where
  StructureForm = 'BRIDGES'
union
  --Major Culverts
select
  ID_STRUCTURE,
  OBEAM_CU,
  OLEN_CU,
  OSPAN_CU,
  OWID_CU,
  TOTALWC,
  WL1C_H,
  WL1C_L,
  WL1C_N,
  WL1C_W,
  WL2C_H,
  WL2C_L,
  WL2C_N,
  WL2C_W,
  WL2_B,
  WL2_L,
  WL2_S,
  WL2_W,
  WR1C_H,
  WR1C_L,
  WR1C_N,
  WR1C_W,
  WR2C_H,
  WR2C_L,
  WR2C_N,
  WR2C_W,
  WR2_B,
  WR2_L,
  WR2_S,
  WR2_W,
  LEFT(DATE_I, 10) as DATE_I,
  INSP_1,
  OBEAM_BR,
  OLEN_BR,
  OSPAN_BR,
  OWID_BR,
  TOTALW,
  WL1_B,
  WL1_L,
  WL1_S,
  WL1_W,
  WR1_B,
  WR1_L,
  WR1_S,
  WR1_W,
  StructureForm
from
  (
    select
      *
    from
      (
        select
          ass.code as ID_STRUCTURE,
          aa.name,
          value,
          null as OBEAM_BR,
          null as OLEN_BR,
          null as OSPAN_BR,
          null as OWID_BR,
          null as TOTALW,
          null as WL1_S,
          null as WL1_L,
          null as WL1_B,
          null as WL1_W,
          null as WL2C_H,
          null as WL2C_L,
          null as WL2C_N,
          null as WL2C_W,
          null as WL2_B,
          null as WL2_L,
          null as WL2_S,
          null as WL2_W,
          null as WR1_S,
          null as WR1_L,
          null as WR1_B,
          null as WR1_W,
          null as WR2C_H,
          null as WR2C_L,
          null as WR2C_N,
          null as WR2C_W,
          null as WR2_B,
          null as WR2_L,
          null as WR2_S,
          null as WR2_W
        from
          transport_dev.transport_wru.uvw_assetattribute aa
          inner join transport_dev.transport_wru.uvw_asset ass on ass.id = aa.assetid
      ) pivot(
        max(value) FOR name in (
          'Date of Last Level 2 Inspection' as `DATE_I`,
          'Inspector Name' as `INSP_1`,
          'No. Spans' as `OBEAM_CU`,
          'Overall Length (m)' as `OLEN_CU`,
          'Original Culvert Width (m)' as `OWID_CU`,
          'Overall Width (m)' as `TOTALWC`,
          'Culvert Cell Height (m)' as `OSPAN_CU`,
          'Widening Left 1 - Bridge Beams/Culvert Cell (No.)' as `WL1C_N`,
          'Widening Left 1 - Bridge/Culvert Length (m)' as `WL1C_L`,
          'Widening Left 1 - Bridge Spans/Cell Height' as `WL1C_H`,
          'Widening Left 1 - Bridge/Culvert Width (m)' as `WL1C_W`,
          'Widening Right 1 - Bridge Beams/Culvert Cell (No.)' as `WR1C_N`,
          'Widening Right 1 - Bridge/Culvert Length (m)' as `WR1C_L`,
          'Widening Right 1 - Bridge Spans/Cell Height' as `WR1C_H`,
          'Widening Right 1 - Bridge/Culvert Width (m)' as `WR1C_W`,
          'Structure Form' as `StructureForm`
        )
      )
  )
where
  StructureForm = 'MAJOR CULVERTS'
order by
  ID_STRUCTURE
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `ID_STRUCTURE` | `string` | Yes |  |
| `OBEAM_CU` | `string` | Yes |  |
| `OLEN_CU` | `string` | Yes |  |
| `OSPAN_CU` | `string` | Yes |  |
| `OWID_CU` | `string` | Yes |  |
| `TOTALWC` | `string` | Yes |  |
| `WL1C_H` | `string` | Yes |  |
| `WL1C_L` | `string` | Yes |  |
| `WL1C_N` | `string` | Yes |  |
| `WL1C_W` | `string` | Yes |  |
| `WL2C_H` | `void` | Yes |  |
| `WL2C_L` | `void` | Yes |  |
| `WL2C_N` | `void` | Yes |  |
| `WL2C_W` | `void` | Yes |  |
| `WL2_B` | `void` | Yes |  |
| `WL2_L` | `void` | Yes |  |
| `WL2_S` | `void` | Yes |  |
| `WL2_W` | `void` | Yes |  |
| `WR1C_H` | `string` | Yes |  |
| `WR1C_L` | `string` | Yes |  |
| `WR1C_N` | `string` | Yes |  |
| `WR1C_W` | `string` | Yes |  |
| `WR2C_H` | `void` | Yes |  |
| `WR2C_L` | `void` | Yes |  |
| `WR2C_N` | `void` | Yes |  |
| `WR2C_W` | `void` | Yes |  |
| `WR2_B` | `void` | Yes |  |
| `WR2_L` | `void` | Yes |  |
| `WR2_S` | `void` | Yes |  |
| `WR2_W` | `void` | Yes |  |
| `DATE_I` | `string` | Yes |  |
| `INSP_1` | `string` | Yes |  |
| `OBEAM_BR` | `string` | Yes |  |
| `OLEN_BR` | `string` | Yes |  |
| `OSPAN_BR` | `string` | Yes |  |
| `OWID_BR` | `string` | Yes |  |
| `TOTALW` | `string` | Yes |  |
| `WL1_B` | `string` | Yes |  |
| `WL1_L` | `string` | Yes |  |
| `WL1_S` | `string` | Yes |  |
| `WL1_W` | `string` | Yes |  |
| `WR1_B` | `string` | Yes |  |
| `WR1_L` | `string` | Yes |  |
| `WR1_S` | `string` | Yes |  |
| `WR1_W` | `string` | Yes |  |
| `StructureForm` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
