---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_a_kerb_and_channels
full-name: transport_dev.transport_wru.uvw_a_kerb_and_channels
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_a_kerb_and_channels

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_a_kerb_and_channels` |
| Full name | `transport_dev.transport_wru.uvw_a_kerb_and_channels` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 13 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-06-12T04:51:28.399Z; Last altered: 2024-09-24T01:42:34.918Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
  WITH assetregister as (
    SELECT
      asset.id,
      asset.code,
      asset.name as asset_name,
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
      assettype = "Kerb and Channel" --and stage <> "Disposed"
  )
  SELECT
    *
  FROM
    assetregister PIVOT (
      max(value) for name in (
        'Length (m)' Length_metres,
        'Width (m)' Width_metres,
        'Type',
        'Material',
        'Warranty/Defect Liability Date' Warranty,
        'Responsible Authority' Responsible_authority
      )
    )
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `id` | `int` | Yes |  |
| `code` | `string` | Yes |  |
| `asset_name` | `string` | Yes |  |
| `notes` | `string` | Yes |  |
| `alertnotes` | `string` | Yes |  |
| `assetcondition` | `string` | Yes |  |
| `assetcondition_int` | `int` | Yes |  |
| `Length_metres` | `string` | Yes |  |
| `Width_metres` | `string` | Yes |  |
| `Type` | `string` | Yes |  |
| `Material` | `string` | Yes |  |
| `Warranty` | `string` | Yes |  |
| `Responsible_authority` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
