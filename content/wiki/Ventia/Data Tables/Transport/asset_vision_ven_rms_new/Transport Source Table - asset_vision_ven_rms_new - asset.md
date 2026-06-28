---
type: source-data-table
topic: Ventia
sector: Transport
source-context: asset_vision_ven_rms_new
source-catalog: ext_mssql_asset_vision_ven_rms_new
source-schema: dbo
table-name: asset
full-name: ext_mssql_asset_vision_ven_rms_new.dbo.asset
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, source-table, databricks, asset-vision-ven-rms-new]
---

# Transport Source Table - asset_vision_ven_rms_new - asset

## Identity

| Field | Value |
|---|---|
| Table name | `asset` |
| Full name | `ext_mssql_asset_vision_ven_rms_new.dbo.asset` |
| Catalog | `ext_mssql_asset_vision_ven_rms_new` |
| Schema | `dbo` |
| Source context | `asset_vision_ven_rms_new` |
| Table type | FOREIGN |
| Column count | 55 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | asset register / hierarchy |
| Source system | Asset Vision |
| Source catalog | `ext_mssql_asset_vision_ven_rms_new` |
| Source schema | `dbo` |
| Source context | `asset_vision_ven_rms_new` |
| Owner/SME | kale.skinner@ventia.com |
| Refresh/freshness | Created: 2025-11-25T04:30:42.689Z; Last altered: 2025-12-10T04:56:06.465Z |
| Source details | Data source format: SQLSERVER_FORMAT |
| Caveats/open questions | Preserve `dbo` as source schema metadata; do not treat it as a client or contract. |

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
| `FinancialAsset` | `boolean` | Yes |  |
| `DepreciationMethod` | `string` | Yes |  |
| `ValuationAssetControl` | `string` | Yes |  |
| `UnderCapitalThreshold` | `boolean` | Yes |  |
| `HeldForSale` | `boolean` | Yes |  |
| `AcquisitionMethod` | `string` | Yes |  |
| `DisposalMethod` | `string` | Yes |  |
| `DisposalComments` | `string` | Yes |  |
| `Deleted` | `boolean` | Yes |  |
| `Ref_ModifiedUserID` | `int` | Yes |  |
| `Ref_AssetTypeID` | `int` | Yes |  |
| `Ref_ParentAssetTypeID` | `int` | Yes |  |
| `Ref_AssetCriticalityID` | `int` | Yes |  |
| `Ref_AssetConditionID` | `int` | Yes |  |
| `Ref_AssetRiskID` | `int` | Yes |  |
| `Ref_AssetConditionModelID` | `int` | Yes |  |
| `Ref_ContractIDs` | `varchar(4000)` | Yes |  |
| `Ref_ClassificationIDs` | `varchar(4000)` | Yes |  |
| `Ref_ValuationAssetControlID` | `int` | Yes |  |
| `Ref_AcquisitionMethodID` | `int` | Yes |  |
| `Ref_DisposalMethodID` | `int` | Yes |  |

## Related Pages

- [[Transport Source Tables - asset_vision_ven_rms_new]]
- [[Transport Data Tables]]
- [[Asset Vision]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
