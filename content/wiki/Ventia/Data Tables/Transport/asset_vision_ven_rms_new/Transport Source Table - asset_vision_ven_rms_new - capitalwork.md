---
type: source-data-table
topic: Ventia
sector: Transport
source-context: asset_vision_ven_rms_new
source-catalog: ext_mssql_asset_vision_ven_rms_new
source-schema: dbo
table-name: capitalwork
full-name: ext_mssql_asset_vision_ven_rms_new.dbo.capitalwork
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, source-table, databricks, asset-vision-ven-rms-new]
---

# Transport Source Table - asset_vision_ven_rms_new - capitalwork

## Identity

| Field | Value |
|---|---|
| Table name | `capitalwork` |
| Full name | `ext_mssql_asset_vision_ven_rms_new.dbo.capitalwork` |
| Catalog | `ext_mssql_asset_vision_ven_rms_new` |
| Schema | `dbo` |
| Source context | `asset_vision_ven_rms_new` |
| Table type | FOREIGN |
| Column count | 35 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | capital works / forward works |
| Source system | Asset Vision |
| Source catalog | `ext_mssql_asset_vision_ven_rms_new` |
| Source schema | `dbo` |
| Source context | `asset_vision_ven_rms_new` |
| Owner/SME | kale.skinner@ventia.com |
| Refresh/freshness | Created: 2025-12-09T22:03:24.272Z; Last altered: 2026-06-02T01:04:27.913Z |
| Source details | Data source format: SQLSERVER_FORMAT |
| Caveats/open questions | Preserve `dbo` as source schema metadata; do not treat it as a client or contract. |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `ID` | `int` | Yes |  |
| `DeltaUTC` | `timestamp` | Yes |  |
| `ModifiedUTC` | `timestamp` | Yes |  |
| `ModifiedUser` | `string` | Yes |  |
| `Name` | `string` | Yes |  |
| `Description` | `string` | Yes |  |
| `CapitalWorkType` | `string` | Yes |  |
| `AssetTypeName` | `string` | Yes |  |
| `AssetID` | `int` | Yes |  |
| `AssetCode` | `string` | Yes |  |
| `AssetName` | `string` | Yes |  |
| `Section` | `string` | Yes |  |
| `Direction` | `string` | Yes |  |
| `ChainageFrom` | `int` | Yes |  |
| `ChainageTo` | `int` | Yes |  |
| `BothDirections` | `string` | Yes |  |
| `Contract` | `string` | Yes |  |
| `CreatedUser` | `string` | Yes |  |
| `Area` | `decimal(18,2)` | Yes |  |
| `PlannedStart` | `timestamp` | Yes |  |
| `PlannedFinish` | `timestamp` | Yes |  |
| `ActualStart` | `timestamp` | Yes |  |
| `ActualFinish` | `timestamp` | Yes |  |
| `Reference1` | `string` | Yes |  |
| `Reference2` | `string` | Yes |  |
| `Supervisor` | `string` | Yes |  |
| `SpatialInfo` | `binary` | Yes |  |
| `Deleted` | `boolean` | Yes |  |
| `Ref_ModifiedUserID` | `int` | Yes |  |
| `Ref_CapitalWorkTypeID` | `int` | Yes |  |
| `Ref_AssetTypeID` | `int` | Yes |  |
| `Ref_ContractRoadID` | `int` | Yes |  |
| `Ref_ContractID` | `int` | Yes |  |
| `Ref_CreatedUserID` | `int` | Yes |  |
| `Ref_SupervisorID` | `int` | Yes |  |

## Related Pages

- [[Transport Source Tables - asset_vision_ven_rms_new]]
- [[Transport Data Tables]]
- [[Asset Vision]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
