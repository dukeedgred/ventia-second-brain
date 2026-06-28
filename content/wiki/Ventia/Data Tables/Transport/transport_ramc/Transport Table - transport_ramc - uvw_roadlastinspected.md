---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_ramc
table-name: uvw_roadlastinspected
full-name: transport_dev.transport_ramc.uvw_roadlastinspected
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-ramc]
---

# Transport Table - transport_ramc - uvw_roadlastinspected

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_roadlastinspected` |
| Full name | `transport_dev.transport_ramc.uvw_roadlastinspected` |
| Catalog | `transport_dev` |
| Schema | `transport_ramc` |
| Contract/schema | `transport_ramc` |
| Table type | VIEW |
| Column count | 12 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2025-04-09T01:37:26.65Z; Last altered: 2025-04-09T01:37:26.65Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
WITH latestinspection (
  SELECT
    Contract,
    AssetTypeName,
    AssetID,
    AssetCode,
    AssetName,
    ID AS InspectionID,
    InspectionTypeName,
    Direction,
    BothDirections,
    CompletedDate,
    CompletedUser,
    ROW_NUMBER() OVER (
        PARTITION BY AssetTypeName, AssetCode, Direction
        ORDER BY AssetTypeName, AssetCode, Direction, ID DESC
      ) AS rownum
  FROM
    ext_mssql_asset_vision_ven_gen7.dbo.vinspection
  WHERE
    contract = 'RAMC - Gen 2 - 2019-2024'
    AND deleted = false
    AND CurrentStatus = 'Completed'
    AND AssetTypeName = 'Road'
  ORDER BY
    AssetTypeName,
    AssetCode,
    Direction,
    rownum
)
SELECT 
  i.Contract,
  i.AssetTypeName,
  i.AssetID,
  i.AssetCode,
  i.AssetName,
  i.InspectionID,
  i.InspectionTypeName,
  i.Direction,
  i.BothDirections,
  CONVERT_TIMEZONE('UTC', 'Australia/Brisbane', i.CompletedDate) AS CompletedDate,
  i.CompletedUser,
  a.Stage
FROM 
  latestinspection i
LEFT JOIN ext_mssql_asset_vision_ven_gen7.dbo.asset a
  ON a.ID = i.AssetID
  AND a.Deleted = False
WHERE
  i.rownum = 1
  AND a.Stage = 'Active'
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Contract` | `string` | Yes |  |
| `AssetTypeName` | `string` | Yes |  |
| `AssetID` | `int` | Yes |  |
| `AssetCode` | `string` | Yes |  |
| `AssetName` | `string` | Yes |  |
| `InspectionID` | `int` | Yes |  |
| `InspectionTypeName` | `string` | Yes |  |
| `Direction` | `string` | Yes |  |
| `BothDirections` | `string` | Yes |  |
| `CompletedDate` | `timestamp_ntz` | Yes |  |
| `CompletedUser` | `string` | Yes |  |
| `Stage` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_ramc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
