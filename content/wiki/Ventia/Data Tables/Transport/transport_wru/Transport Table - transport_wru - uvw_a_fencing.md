---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_a_fencing
full-name: transport_dev.transport_wru.uvw_a_fencing
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_a_fencing

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_a_fencing` |
| Full name | `transport_dev.transport_wru.uvw_a_fencing` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 26 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-06-12T04:46:48.504Z; Last altered: 2024-09-24T01:42:28.199Z |
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
      assettype = "Fencing" --and stage <> "Disposed"
  )
  SELECT
    *
  FROM
    assetregister PIVOT (
      max(value) for name in (
        'RMC',
        'Township',
        'Additional Length (m)' Additional_length_metres,
        'Material',
        'Asset Height/Depth (M)' Height_or_depth_metres,
        'Responsible Authority' Responsible_authority,
        'Fence Function' Fence_function,
        'Asset Support Type' Asset_support_type,
        'Fence Side Location' Fence_side_location,
        'Fence Type' Fence_type,
        'Asset Offset to Traffic Lane (Start)' offset_to_traffic_lane,
        'Asset Width (M)' Width_metres,
        'Asset Length (M)' Length_metres,
        'Asset Age' Asset_age,
        'Warranty/Defect Liability Date' Warranty
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
| `RMC` | `string` | Yes |  |
| `Township` | `string` | Yes |  |
| `Additional_length_metres` | `string` | Yes |  |
| `Material` | `string` | Yes |  |
| `Height_or_depth_metres` | `string` | Yes |  |
| `Responsible_authority` | `string` | Yes |  |
| `Fence_function` | `string` | Yes |  |
| `Asset_support_type` | `string` | Yes |  |
| `Fence_side_location` | `string` | Yes |  |
| `Fence_type` | `string` | Yes |  |
| `offset_to_traffic_lane` | `string` | Yes |  |
| `Width_metres` | `string` | Yes |  |
| `Length_metres` | `string` | Yes |  |
| `Asset_age` | `string` | Yes |  |
| `Warranty` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
