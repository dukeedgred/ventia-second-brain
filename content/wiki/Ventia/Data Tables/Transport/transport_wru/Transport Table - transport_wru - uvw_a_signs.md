---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_a_signs
full-name: transport_dev.transport_wru.uvw_a_signs
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_a_signs

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_a_signs` |
| Full name | `transport_dev.transport_wru.uvw_a_signs` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 31 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-06-12T05:14:04.511Z; Last altered: 2024-09-24T01:42:29.887Z |
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
      assettype = "Major Sign Structure"
      and stage <> "Disposed"
  )
  SELECT
    *
  FROM
    assetregister PIVOT (
      max(value) for name in (
        'Feature Crossed' feature_crossed,
        'Structure Type' structure_type,
        'Melway Map Reference' melway_map_reference,
        'Local Road Name' local_road_name,
        'Federral Classification' federral_classification,
        'Local Government Area' local_government_area,
        'Min Clearance (m)' min_clearance_m,
        'Overall Width (m)' overall_width_m,
        'Traffic Width (m)' traffic_width_m,
        'Date of Last Level 2 Inspection' date_of_last_level_2_inspection,
        'Asset Owner' asset_owner,
        'Maintenance Responsible' maintenance_responsible,
        'Last Updated from RAS' last_updated_from_ras,
        'Project',
        'Date Asset was Identified' date_asset_was_identified,
        'As-built Drawings (IFC)' as_built_drawings_ifc,
        'Design Life (Yrs)' design_life_yrs,
        'Design Life Expiry (Estimated)' design_life_expiry_estimated,
        'Existing Height Clearance (m)' existing_height_clearance_m,
        'Residual Life (Yrs)' residual_life_yrs
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
| `feature_crossed` | `string` | Yes |  |
| `structure_type` | `string` | Yes |  |
| `melway_map_reference` | `string` | Yes |  |
| `local_road_name` | `string` | Yes |  |
| `federral_classification` | `string` | Yes |  |
| `local_government_area` | `string` | Yes |  |
| `min_clearance_m` | `string` | Yes |  |
| `overall_width_m` | `string` | Yes |  |
| `traffic_width_m` | `string` | Yes |  |
| `date_of_last_level_2_inspection` | `string` | Yes |  |
| `asset_owner` | `string` | Yes |  |
| `maintenance_responsible` | `string` | Yes |  |
| `last_updated_from_ras` | `string` | Yes |  |
| `Project` | `string` | Yes |  |
| `date_asset_was_identified` | `string` | Yes |  |
| `as_built_drawings_ifc` | `string` | Yes |  |
| `design_life_yrs` | `string` | Yes |  |
| `design_life_expiry_estimated` | `string` | Yes |  |
| `existing_height_clearance_m` | `string` | Yes |  |
| `residual_life_yrs` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
