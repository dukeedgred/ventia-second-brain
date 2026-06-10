---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_srapc
table-name: uvw_customerrequest
full-name: transport_dev.transport_srapc.uvw_customerrequest
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-srapc]
---

# Transport Table - transport_srapc - uvw_customerrequest

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_customerrequest` |
| Full name | `transport_dev.transport_srapc.uvw_customerrequest` |
| Catalog | `transport_dev` |
| Schema | `transport_srapc` |
| Contract/schema | `transport_srapc` |
| Table type | VIEW |
| Column count | 28 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | john.galea@ventia.com |
| Refresh/freshness | Created: 2025-10-28T06:14:52.367Z; Last altered: 2025-10-28T06:14:52.367Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
SELECT *
FROM ext_mssql_asset_vision_ven_rms.dbo.module m
WHERE m.ModuleName = 'Customer Request (VEN)' 
  AND m.Deleted = false
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `ID` | `int` | Yes |  |
| `DeltaUTC` | `timestamp` | Yes |  |
| `ModifiedUTC` | `timestamp` | Yes |  |
| `ModifiedUser` | `string` | Yes |  |
| `Contract` | `string` | Yes |  |
| `Region` | `string` | Yes |  |
| `CompletedDate` | `timestamp` | Yes |  |
| `ModuleName` | `string` | Yes |  |
| `Name` | `string` | Yes |  |
| `CreatedDate` | `timestamp` | Yes |  |
| `CreatedUser` | `string` | Yes |  |
| `AssignedUser` | `string` | Yes |  |
| `Comments` | `string` | Yes |  |
| `AssetID` | `int` | Yes |  |
| `AssetCode` | `string` | Yes |  |
| `AssetName` | `string` | Yes |  |
| `EntireLength` | `string` | Yes |  |
| `Direction` | `varchar(50)` | Yes |  |
| `StartPointName` | `string` | Yes |  |
| `ChainageFrom` | `int` | Yes |  |
| `StartDistancePast` | `int` | Yes |  |
| `EndPointName` | `string` | Yes |  |
| `ChainageTo` | `int` | Yes |  |
| `EndDistancePast` | `int` | Yes |  |
| `SpatialInfo` | `binary` | Yes |  |
| `ParentSourceTableName` | `string` | Yes |  |
| `ParentSourceTableID` | `int` | Yes |  |
| `Deleted` | `boolean` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_srapc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
