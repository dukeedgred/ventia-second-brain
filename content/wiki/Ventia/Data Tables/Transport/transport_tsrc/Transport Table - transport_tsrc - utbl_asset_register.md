---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: utbl_asset_register
full-name: transport_dev.transport_tsrc.utbl_asset_register
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - utbl_asset_register

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_asset_register` |
| Full name | `transport_dev.transport_tsrc.utbl_asset_register` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | MANAGED |
| Column count | 66 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Business purpose | Created by the file upload UI |
| Data domain | asset register / hierarchy |
| Owner/SME | huy.nguyen@ventia.com |
| Refresh/freshness | Created: 2026-04-13T23:26:43.946Z; Last altered: 2026-05-13T05:21:40.544Z |
| Source details | Data source format: DELTA |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Unique Key` | `bigint` | Yes |  |
| `Asset` | `string` | Yes |  |
| `Asset Name` | `string` | Yes |  |
| `Asset Type` | `string` | Yes |  |
| `Asset ID` | `string` | Yes |  |
| `Asset Description` | `string` | Yes |  |
| `Design Package` | `bigint` | Yes |  |
| `Actively Maintained` | `string` | Yes |  |
| `Asset Modelled` | `string` | Yes |  |
| `ID` | `string` | Yes |  |
| `OMParentAssetID` | `string` | Yes |  |
| `ParentAssetID` | `string` | Yes |  |
| `CJVAssetCode` | `string` | Yes |  |
| `HighLevelDiscipline` | `string` | Yes |  |
| `Discipline` | `string` | Yes |  |
| `Component` | `string` | Yes |  |
| `ElementType` | `string` | Yes |  |
| `Phase` | `string` | Yes |  |
| `Sequence` | `bigint` | Yes |  |
| `Description` | `string` | Yes |  |
| `DrawingTag` | `string` | Yes |  |
| `FileName` | `string` | Yes |  |
| `Returned Asset Owner` | `string` | Yes |  |
| `ReturnedAssetOwnerAssetID` | `string` | Yes |  |
| `UniclassPRCode` | `string` | Yes |  |
| `UniclassPRDescription` | `string` | Yes |  |
| `UniclassSSCode` | `string` | Yes |  |
| `UniclassSSDescription` | `string` | Yes |  |
| `ConstructionPackageID` | `string` | Yes |  |
| `Construction Date` | `string` | Yes |  |
| `Condition Rating` | `bigint` | Yes |  |
| `Pre-Condition` | `string` | Yes |  |
| `Access - Confined Space` | `string` | Yes |  |
| `Access - Working at Heights` | `string` | Yes |  |
| `Design Life` | `string` | Yes |  |
| `Earthquake Rating` | `string` | Yes |  |
| `Fire Rating` | `string` | Yes |  |
| `Inspection and Testing` | `string` | Yes |  |
| `Maintenance Frequencies` | `string` | Yes |  |
| `Photo Capture` | `string` | Yes |  |
| `Material` | `string` | Yes |  |
| `Coating System` | `string` | Yes |  |
| `Supplier` | `string` | Yes |  |
| `SystemType` | `string` | Yes |  |
| `Length` | `string` | Yes |  |
| `Width` | `string` | Yes |  |
| `Height` | `string` | Yes |  |
| `Thickness` | `string` | Yes |  |
| `Overall Length` | `string` | Yes |  |
| `Overall Height` | `string` | Yes |  |
| `Location ID` | `string` | Yes |  |
| `Location Name` | `string` | Yes |  |
| `Road ID` | `string` | Yes |  |
| `ChainageStart` | `string` | Yes |  |
| `ChainageEnd` | `string` | Yes |  |
| `LevelName` | `string` | Yes |  |
| `RoomName` | `string` | Yes |  |
| `RoomNo` | `string` | Yes |  |
| `X coordinate end` | `string` | Yes |  |
| `X coordinate start` | `string` | Yes |  |
| `Y coordinate end` | `string` | Yes |  |
| `Y coordinate start` | `string` | Yes |  |
| `Z coordinate end` | `string` | Yes |  |
| `Z coordinate start` | `string` | Yes |  |
| `Data Date` | `string` | Yes |  |
| `Collected By` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
