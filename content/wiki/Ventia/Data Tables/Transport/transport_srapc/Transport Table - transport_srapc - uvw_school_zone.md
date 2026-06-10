---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_srapc
table-name: uvw_school_zone
full-name: transport_dev.transport_srapc.uvw_school_zone
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-srapc]
---

# Transport Table - transport_srapc - uvw_school_zone

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_school_zone` |
| Full name | `transport_dev.transport_srapc.uvw_school_zone` |
| Catalog | `transport_dev` |
| Schema | `transport_srapc` |
| Contract/schema | `transport_srapc` |
| Table type | VIEW |
| Column count | 3 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2024-05-28T05:27:28.413Z; Last altered: 2024-07-18T20:30:56.042Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
SELECT
  i.id,
  p.sourcetableid,
  p.URL
FROM
  ext_mssql_asset_vision_ven_rms.dbo.inspection i
  LEFT JOIN ext_mssql_asset_vision_ven_rms.dbo.photo p ON i.id = p.sourcetableid
WHERE
  i.contract LIKE '%SRAP-C%'
  AND i.assetname = 'School Zone'
  AND i.deleted = false
  AND p.deleted = false
ORDER BY
  i.id ASC
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `id` | `int` | Yes |  |
| `sourcetableid` | `int` | Yes |  |
| `URL` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_srapc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
