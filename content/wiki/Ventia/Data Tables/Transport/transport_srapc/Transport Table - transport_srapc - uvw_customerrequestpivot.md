---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_srapc
table-name: uvw_customerrequestpivot
full-name: transport_dev.transport_srapc.uvw_customerrequestpivot
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-srapc]
---

# Transport Table - transport_srapc - uvw_customerrequestpivot

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_customerrequestpivot` |
| Full name | `transport_dev.transport_srapc.uvw_customerrequestpivot` |
| Catalog | `transport_dev` |
| Schema | `transport_srapc` |
| Contract/schema | `transport_srapc` |
| Table type | VIEW |
| Column count | 5 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | john.galea@ventia.com |
| Refresh/freshness | Created: 2025-10-29T02:11:57.081Z; Last altered: 2025-10-29T02:11:57.081Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
SELECT
  m.ID AS ModuleID,
  m.ModuleName,
  MAX(
    CASE
      WHEN f.Name = 'Field1' THEN f.Value
    END
  ) AS Field1,
  MAX(
    CASE
      WHEN f.Name = 'Field2' THEN f.Value
    END
  ) AS Field2,
  MAX(
    CASE
      WHEN f.Name = 'Field3' THEN f.Value
    END
  ) AS Field3
FROM
  ext_mssql_asset_vision_ven_rms.dbo.module m
    JOIN ext_mssql_asset_vision_ven_rms.dbo.formfield f
      ON m.ID = f.SourceTableID
WHERE
  m.ModuleName = 'Customer Request (VEN)'
  AND m.Deleted = false
GROUP BY
  m.ID,
  m.ModuleName,
  m.Deleted
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `ModuleID` | `int` | Yes |  |
| `ModuleName` | `string` | Yes |  |
| `Field1` | `string` | Yes |  |
| `Field2` | `string` | Yes |  |
| `Field3` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_srapc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
