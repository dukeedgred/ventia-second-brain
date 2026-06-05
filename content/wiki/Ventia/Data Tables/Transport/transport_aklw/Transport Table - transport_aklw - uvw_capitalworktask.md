---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_aklw
table-name: uvw_capitalworktask
full-name: transport_dev.transport_aklw.uvw_capitalworktask
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-table, databricks, transport-aklw, capital-work, asset]
---

# Transport Table - transport_aklw - uvw_capitalworktask

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_capitalworktask` |
| Full name | `transport_dev.transport_aklw.uvw_capitalworktask` |
| Catalog | `transport_dev` |
| Schema | `transport_aklw` |
| Contract/schema | `transport_aklw` |
| Table type | VIEW |
| Column count | 32 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Contract name | Auckland West Transport |
| Data domain | capital work |
| Source system | `ext_mssql_asset_vision_vnz_gen7` |

## View Query

```sql
SELECT
  *
FROM
  ext_mssql_asset_vision_vnz_gen7.dbo.capitalworktask
WHERE
  deleted = False
  AND EXISTS (
    SELECT
      1
    FROM
      ext_mssql_asset_vision_vnz_gen7.dbo.capitalwork c
    WHERE
      contract = 'Auckland West Transport'
      AND c.id = capitalworkid
  )
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `ID` | `int` | Yes |  |
| `DeltaUTC` | `timestamp` | Yes |  |
| `ModifiedUTC` | `timestamp` | Yes |  |
| `ModifiedUser` | `string` | Yes |  |
| `CapitalWorkID` | `int` | Yes |  |
| `SortOrder` | `int` | Yes |  |
| `Name` | `string` | Yes |  |
| `Description` | `string` | Yes |  |
| `PlannedStart` | `timestamp` | Yes |  |
| `PlannedFinish` | `timestamp` | Yes |  |
| `ActualStart` | `timestamp` | Yes |  |
| `ActualFinish` | `timestamp` | Yes |  |
| `EstimatedQuantity` | `decimal(10,3)` | Yes |  |
| `ActualQuantity` | `decimal(10,3)` | Yes |  |
| `Unit` | `string` | Yes |  |
| `EstimatedCost` | `decimal(18,2)` | Yes |  |
| `ActualCost` | `decimal(18,2)` | Yes |  |
| `Reference1` | `string` | Yes |  |
| `Reference2` | `string` | Yes |  |
| `Comments` | `string` | Yes |  |
| `AssetTypeName` | `string` | Yes |  |
| `AssetID` | `int` | Yes |  |
| `AssetCode` | `string` | Yes |  |
| `AssetName` | `string` | Yes |  |
| `Section` | `string` | Yes |  |
| `Direction` | `string` | Yes |  |
| `ChainageFrom` | `int` | Yes |  |
| `ChainageTo` | `int` | Yes |  |
| `BothDirections` | `string` | Yes |  |
| `SpatialInfo` | `binary` | Yes |  |
| `JobID` | `int` | Yes |  |
| `Deleted` | `boolean` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_aklw]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
