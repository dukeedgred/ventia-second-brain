---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_a_drainage
full-name: transport_dev.transport_wru.uvw_a_drainage
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_a_drainage

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_a_drainage` |
| Full name | `transport_dev.transport_wru.uvw_a_drainage` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 21 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-06-12T04:42:21.016Z; Last altered: 2024-09-24T01:42:46.137Z |
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
      assettype in ('Drainage Lines') --and stage <> "Disposed"
  )
  SELECT
    *
  FROM
    assetregister PIVOT (
      MAX(value) for name in (
        'built',
        'diameter',
        'form',
        'material',
        'ref',
        'sys_attr_l',
        'Warranty/Defect Liability Date' Warranty,
        'Carrying',
        'dnstr_pit',
        'mat_desc',
        'operator',
        'length' Length_metres,
        'globalid',
        'Pit To Code' Pit_to_code,
        'Pit From Code' Pit_from_code
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
| `built` | `string` | Yes |  |
| `diameter` | `string` | Yes |  |
| `form` | `string` | Yes |  |
| `material` | `string` | Yes |  |
| `ref` | `string` | Yes |  |
| `sys_attr_l` | `string` | Yes |  |
| `Warranty` | `string` | Yes |  |
| `Carrying` | `string` | Yes |  |
| `dnstr_pit` | `string` | Yes |  |
| `mat_desc` | `string` | Yes |  |
| `operator` | `string` | Yes |  |
| `Length_metres` | `string` | Yes |  |
| `globalid` | `string` | Yes |  |
| `Pit_to_code` | `string` | Yes |  |
| `Pit_from_code` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
