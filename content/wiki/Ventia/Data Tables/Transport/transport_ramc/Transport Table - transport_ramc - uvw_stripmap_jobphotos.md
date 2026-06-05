---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_ramc
table-name: uvw_stripmap_jobphotos
full-name: transport_dev.transport_ramc.uvw_stripmap_jobphotos
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-table, databricks, transport-ramc, stripmap, photo]
---

# Transport Table - transport_ramc - uvw_stripmap_jobphotos

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_stripmap_jobphotos` |
| Full name | `transport_dev.transport_ramc.uvw_stripmap_jobphotos` |
| Catalog | `transport_dev` |
| Schema | `transport_ramc` |
| Contract/schema | `transport_ramc` |
| Table type | VIEW |
| Column count | 4 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | stripmap photo |
| Related tables/reports | `transport_dev.transport_ramc.uvw_stripmap_jobs`, `ext_mssql_asset_vision_ven_gen7.dbo.photo` |

## View Query

```sql
(
  SELECT 
    a.JobID,
    b.ID AS Photo_ID,
    b.URL,
    b.Stage
  FROM transport_dev.transport_ramc.uvw_stripmap_jobs a
  -- Join with Photos
  LEFT JOIN 
  (SELECT * FROM ext_mssql_asset_vision_ven_gen7.dbo.photo
  WHERE SourceTable = 'Job') b
  ON a.JobID = b.SourceTableID
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `JobID` | `int` | Yes |  |
| `Photo_ID` | `int` | Yes |  |
| `URL` | `string` | Yes |  |
| `Stage` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_ramc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
