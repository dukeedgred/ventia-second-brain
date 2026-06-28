---
type: source-data-table
topic: Ventia
sector: Transport
source-context: asset_vision_vnz_gen7
source-catalog: ext_mssql_asset_vision_vnz_gen7
source-schema: dbo
table-name: contractreference
full-name: ext_mssql_asset_vision_vnz_gen7.dbo.contractreference
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, source-table, databricks, asset-vision, asset-vision-vnz-gen7, contractreference]
---

# Transport Source Table - asset_vision_vnz_gen7 - contractreference

## Identity

| Field | Value |
|---|---|
| Table name | `contractreference` |
| Full name | `ext_mssql_asset_vision_vnz_gen7.dbo.contractreference` |
| Catalog | `ext_mssql_asset_vision_vnz_gen7` |
| Schema | `dbo` |
| Source context | `asset_vision_vnz_gen7` |
| Table type | FOREIGN |
| Column count | 15 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | contract reference |
| Source system | Asset Vision |
| Source catalog | `ext_mssql_asset_vision_vnz_gen7` |
| Source schema | `dbo` |
| Source context | `asset_vision_vnz_gen7` |
| Caveats/open questions | Catalog name includes `vnz_gen7`; confirm whether this maps to a client/contract, contract group, or environment/version. Do not treat `dbo` as a client or contractor. |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `ID` | `int` | Yes |  |
| `DeltaUTC` | `timestamp` | Yes |  |
| `ModifiedUTC` | `timestamp` | Yes |  |
| `ModifiedUser` | `string` | Yes |  |
| `Contract` | `string` | Yes |  |
| `InterventionID` | `int` | Yes |  |
| `InspectionTypeID` | `int` | Yes |  |
| `Reference1` | `string` | Yes |  |
| `Reference2` | `string` | Yes |  |
| `EstimatedDuration` | `decimal(10,2)` | Yes |  |
| `AssetID` | `int` | Yes |  |
| `EstimatedCost` | `decimal(10,2)` | Yes |  |
| `AssetAttributeName` | `string` | Yes |  |
| `AssetAttributeValue` | `string` | Yes |  |
| `Deleted` | `boolean` | Yes |  |

## Related Pages

- [[Transport Source Tables - asset_vision_vnz_gen7]]
- [[Transport Data Tables]]
- [[Asset Vision]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]



