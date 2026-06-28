---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_a_embankments
full-name: transport_dev.transport_wru.uvw_a_embankments
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_a_embankments

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_a_embankments` |
| Full name | `transport_dev.transport_wru.uvw_a_embankments` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 11 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-06-12T04:44:31.033Z; Last altered: 2024-09-24T01:42:22.559Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
  WITH assetregister as (
    SELECT
      asset.id,
      asset.code,
      asset.notes,
      asset.alertnotes,
      asset.assetcondition,
      int(left(asset.assetcondition, 1)) as assetcondition_int,
      assetattribute.name,
      assetattribute.value
    FROM
      ext_mssql_asset_vision_ven_vicroads.dbo.asset
      INNER JOIN ext_mssql_asset_vision_ven_vicroads.dbo.assetattribute ON asset.id = assetattribute.assetid
    WHERE
      assettype in ('Embankments') --and stage <> "Disposed"
  )
  SELECT
    *
  FROM
    assetregister PIVOT (
      max(value) for name in (
        'Material',
        'Width (m)' Width_metres,
        'Volume (m3)' Volume_metres3,
        'Length (m)' Length_metres,
        'Height' Height_metres
      )
    )
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `id` | `int` | Yes |  |
| `code` | `string` | Yes |  |
| `notes` | `string` | Yes |  |
| `alertnotes` | `string` | Yes |  |
| `assetcondition` | `string` | Yes |  |
| `assetcondition_int` | `int` | Yes |  |
| `Material` | `string` | Yes |  |
| `Width_metres` | `string` | Yes |  |
| `Volume_metres3` | `string` | Yes |  |
| `Length_metres` | `string` | Yes |  |
| `Height_metres` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
