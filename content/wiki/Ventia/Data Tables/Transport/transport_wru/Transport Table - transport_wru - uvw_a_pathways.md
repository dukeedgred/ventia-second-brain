---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_a_pathways
full-name: transport_dev.transport_wru.uvw_a_pathways
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_a_pathways

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_a_pathways` |
| Full name | `transport_dev.transport_wru.uvw_a_pathways` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 30 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-06-12T04:56:57.106Z; Last altered: 2024-09-24T01:42:56.59Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
  WITH assetregister as (
  SELECT
    a.id as Asset_ID,
    a.stage,
    a.code as Asset_Code,
    a.name as Asset_Name,
    a.parentassetid as Road_No,
    a.parentassetname as Road_Name,
    if(a.direction = 'Outbound', 'Forward', 'Reverse') as direction,
    a.assetcondition,
    a.conditiondate,
    b.name,
    b.value,
    a.notes,
    a.alertnotes
  FROM
    ext_mssql_asset_vision_ven_vicroads.dbo.asset a
    INNER JOIN ext_mssql_asset_vision_ven_vicroads.dbo.assetattribute b ON a.id = b.assetid
  WHERE
    assettype = "Pathway"
    and stage <> "Disposed"
)
SELECT
  *
FROM
  assetregister PIVOT (
    max(value) for name in (
      'Local Name' local_name,
      'Basetype',
      'Depth Pathway (mm)' depth_pathway_mm,
      'Rail type' rail_type,
      'Sub base depth (mm)' sub_base_depth_mm,
      'Obstruction type' obstruction_type,
      'Crossing Material' crossing_material,
      'Material Pathway' material_pathway,
      'Treatment',
      'Width (m)' width_m,
      'Base Depth (mm)' base_depth_mm,
      'Depth Crossing (mm)' depth_crossing_mm,
      'Number of steps' num_steps,
      'Pathway is reinforced' pathway_reinforced,
      'Sub base type' sub_base_type,
      'Rail material' rail_material,
      'Crossing Type - Bevelled' crossing_type_bevelled,
      'Pathway type' pathway_type,
      'Instruction'
    )
  )
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Asset_ID` | `int` | Yes |  |
| `stage` | `string` | Yes |  |
| `Asset_Code` | `string` | Yes |  |
| `Asset_Name` | `string` | Yes |  |
| `Road_No` | `int` | Yes |  |
| `Road_Name` | `string` | Yes |  |
| `direction` | `string` | No |  |
| `assetcondition` | `string` | Yes |  |
| `conditiondate` | `timestamp` | Yes |  |
| `notes` | `string` | Yes |  |
| `alertnotes` | `string` | Yes |  |
| `local_name` | `string` | Yes |  |
| `Basetype` | `string` | Yes |  |
| `depth_pathway_mm` | `string` | Yes |  |
| `rail_type` | `string` | Yes |  |
| `sub_base_depth_mm` | `string` | Yes |  |
| `obstruction_type` | `string` | Yes |  |
| `crossing_material` | `string` | Yes |  |
| `material_pathway` | `string` | Yes |  |
| `Treatment` | `string` | Yes |  |
| `width_m` | `string` | Yes |  |
| `base_depth_mm` | `string` | Yes |  |
| `depth_crossing_mm` | `string` | Yes |  |
| `num_steps` | `string` | Yes |  |
| `pathway_reinforced` | `string` | Yes |  |
| `sub_base_type` | `string` | Yes |  |
| `rail_material` | `string` | Yes |  |
| `crossing_type_bevelled` | `string` | Yes |  |
| `pathway_type` | `string` | Yes |  |
| `Instruction` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
