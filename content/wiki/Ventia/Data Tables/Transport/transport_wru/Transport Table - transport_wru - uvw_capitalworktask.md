---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_capitalworktask
full-name: transport_dev.transport_wru.uvw_capitalworktask
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_capitalworktask

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_capitalworktask` |
| Full name | `transport_dev.transport_wru.uvw_capitalworktask` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 33 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | capital works / forward works |
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-06-14T02:48:20.519Z; Last altered: 2024-09-24T01:42:17.606Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
SELECT
  *
FROM
  ext_mssql_asset_vision_ven_vicroads.dbo.vcapitalworktask
WHERE
  deleted = false
  AND EXISTS (
              SELECT
                1
              FROM
                ext_mssql_asset_vision_ven_vicroads.dbo.capitalwork c
              WHERE
                contract like '%Western Roads Upgrade (WRU)%'
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
| `WKT` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
