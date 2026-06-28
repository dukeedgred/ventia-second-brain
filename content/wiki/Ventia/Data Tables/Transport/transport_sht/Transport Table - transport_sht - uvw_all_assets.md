---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_sht
table-name: uvw_all_assets
full-name: transport_dev.transport_sht.uvw_all_assets
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-sht]
---

# Transport Table - transport_sht - uvw_all_assets

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_all_assets` |
| Full name | `transport_dev.transport_sht.uvw_all_assets` |
| Catalog | `transport_dev` |
| Schema | `transport_sht` |
| Contract/schema | `transport_sht` |
| Table type | VIEW |
| Column count | 35 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | asset register / hierarchy |
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2024-05-27T03:15:33.636Z; Last altered: 2024-07-18T20:07:03.695Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |
| Caveats/open questions | This is a curated `transport_sht` Databricks schema table/view; it does not prove the SHT source operational system is Asset Vision. |

## View Query

```sql
SELECT
  *
FROM
  ext_mssql_asset_vision_vns_gen7.dbo.asset
WHERE
  contract = 'Sydney Harbour Tunnel (SHT)'
  AND deleted = false
  AND stage = 'Active'
  AND id <> 322581
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `ID` | `int` | Yes |  |
| `DeltaUTC` | `timestamp` | Yes |  |
| `ModifiedUTC` | `timestamp` | Yes |  |
| `ExportDateUTC` | `timestamp` | Yes |  |
| `ModifiedUser` | `string` | Yes |  |
| `Code` | `string` | Yes |  |
| `Name` | `string` | Yes |  |
| `Contract` | `string` | Yes |  |
| `AssetType` | `string` | Yes |  |
| `SpatialType` | `string` | Yes |  |
| `ParentAssetID` | `int` | Yes |  |
| `ParentAssetCode` | `string` | Yes |  |
| `ParentAssetName` | `string` | Yes |  |
| `ParentAssetTypeName` | `string` | Yes |  |
| `Direction` | `string` | Yes |  |
| `ChainageFrom` | `int` | Yes |  |
| `ChainageTo` | `int` | Yes |  |
| `ParentAssetPosition` | `string` | Yes |  |
| `Stage` | `string` | Yes |  |
| `ConstructionDate` | `timestamp` | Yes |  |
| `ConstructionCost` | `decimal(12,2)` | Yes |  |
| `DisposalDate` | `timestamp` | Yes |  |
| `DisposalCost` | `decimal(12,2)` | Yes |  |
| `UsefulLife` | `decimal(6,2)` | Yes |  |
| `AssetCriticality` | `string` | Yes |  |
| `AssetCondition` | `string` | Yes |  |
| `AssetRisk` | `string` | Yes |  |
| `AssetConditionModel` | `string` | Yes |  |
| `ConditionDate` | `timestamp` | Yes |  |
| `Classification` | `string` | Yes |  |
| `Notes` | `string` | Yes |  |
| `AlertNotes` | `string` | Yes |  |
| `OffsetSide` | `string` | Yes |  |
| `OffsetMetres` | `int` | Yes |  |
| `Deleted` | `boolean` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_sht]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
