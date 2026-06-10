---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_srapc
table-name: uvw_photos_unique
full-name: transport_dev.transport_srapc.uvw_photos_unique
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-srapc]
---

# Transport Table - transport_srapc - uvw_photos_unique

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_photos_unique` |
| Full name | `transport_dev.transport_srapc.uvw_photos_unique` |
| Catalog | `transport_dev` |
| Schema | `transport_srapc` |
| Contract/schema | `transport_srapc` |
| Table type | VIEW |
| Column count | 12 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | documents / evidence |
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2025-05-28T03:38:30.323Z; Last altered: 2025-05-28T03:38:30.323Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
SELECT
  *
FROM
  (
    SELECT
      *,
      ROW_NUMBER() OVER (PARTITION BY SourceTable, SourceTableID, Stage ORDER BY ID ASC) AS rn
    FROM
      ext_mssql_asset_vision_ven_rms.dbo.photo
    WHERE
      deleted = false
  ) t
WHERE
  t.rn = 1
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `ID` | `int` | Yes |  |
| `DeltaUTC` | `timestamp` | Yes |  |
| `ModifiedUTC` | `timestamp` | Yes |  |
| `CreatedDate` | `timestamp` | Yes |  |
| `CreatedUser` | `string` | Yes |  |
| `SourceTable` | `string` | Yes |  |
| `SourceTableID` | `int` | Yes |  |
| `URL` | `string` | Yes |  |
| `ThumbnailURL` | `string` | Yes |  |
| `Stage` | `string` | Yes |  |
| `Deleted` | `boolean` | Yes |  |
| `rn` | `int` | No |  |

## Related Pages

- [[Transport Contract Tables - transport_srapc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
