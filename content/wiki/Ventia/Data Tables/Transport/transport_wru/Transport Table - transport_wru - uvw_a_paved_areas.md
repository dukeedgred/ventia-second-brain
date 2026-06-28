---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_a_paved_areas
full-name: transport_dev.transport_wru.uvw_a_paved_areas
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_a_paved_areas

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_a_paved_areas` |
| Full name | `transport_dev.transport_wru.uvw_a_paved_areas` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 20 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-06-12T04:59:00.311Z; Last altered: 2024-09-24T01:42:33.59Z |
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
      assettype = "Paved Areas"
      and stage <> "Disposed"
  )
  SELECT
    *
  FROM
    assetregister PIVOT (
      max(value) for name in (
        'Warranty/Defect Liability Date' warranty_defect_liability_date,
        'Tactile Unit Material' tactile_unit_material,
        'Perimeter',
        'Fence Code' fence_code,
        'Pedestrian Zone' pedestrian_zone,
        'Tactile Unit Type' tactile_unit_type,
        'Area',
        'Fence Present' fence_present,
        'Safety Rail Present' safety_rail_present
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
| `warranty_defect_liability_date` | `string` | Yes |  |
| `tactile_unit_material` | `string` | Yes |  |
| `Perimeter` | `string` | Yes |  |
| `fence_code` | `string` | Yes |  |
| `pedestrian_zone` | `string` | Yes |  |
| `tactile_unit_type` | `string` | Yes |  |
| `Area` | `string` | Yes |  |
| `fence_present` | `string` | Yes |  |
| `safety_rail_present` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
