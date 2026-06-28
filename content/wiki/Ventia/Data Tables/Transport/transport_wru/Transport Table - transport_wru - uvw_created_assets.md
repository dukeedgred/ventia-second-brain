---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_created_assets
full-name: transport_dev.transport_wru.uvw_created_assets
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_created_assets

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_created_assets` |
| Full name | `transport_dev.transport_wru.uvw_created_assets` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 6 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | asset register / hierarchy |
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-06-20T07:20:40.956Z; Last altered: 2024-09-24T01:42:24.965Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
  with sq as (
    select
      id,
      code,
      stage as new_stage,
      lag(stage) over (partition by id order by modifiedutc) AS old_stage,
      date(convert_timezone('Australia/Sydney', modifiedutc)) as change_date,
      case
        when stage = "Active" then '#FF5733' --red
        when stage = "Disposed" then '#C1E1C1' --green
        when stage = "Inactive" then "#808080" --grey
        when stage = "Planned" then "#FFC300" --yellow
      end as colour
    from
      transport_dev.transport_wru.uvw_asset
  )
  select 
    *
  from
    sq
  where
    new_stage <> old_stage
    or old_stage is null
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `id` | `int` | Yes |  |
| `code` | `string` | Yes |  |
| `new_stage` | `string` | Yes |  |
| `old_stage` | `string` | Yes |  |
| `change_date` | `date` | Yes |  |
| `colour` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
