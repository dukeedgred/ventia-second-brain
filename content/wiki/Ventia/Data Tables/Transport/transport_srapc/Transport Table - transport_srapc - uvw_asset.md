---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_srapc
table-name: uvw_asset
full-name: transport_dev.transport_srapc.uvw_asset
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-srapc]
---

# Transport Table - transport_srapc - uvw_asset

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_asset` |
| Full name | `transport_dev.transport_srapc.uvw_asset` |
| Catalog | `transport_dev` |
| Schema | `transport_srapc` |
| Contract/schema | `transport_srapc` |
| Table type | VIEW |
| Column count | 38 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | asset register / hierarchy |
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2024-09-11T00:01:42.411Z; Last altered: 2024-09-11T01:34:54.876Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
select ID, 	DeltaUTC, 	ModifiedUTC, 	ExportDateUTC, 	ModifiedUser, 	Code, 	Name, 	Contract, 	AssetType, 	SpatialType, 	ParentAssetID, 	ParentAssetCode, 	ParentAssetName, 	ParentAssetTypeName, 	Direction, 	ChainageFrom, 	ChainageTo, 	ParentAssetPosition, 	Stage, 	ConstructionDate, 	ConstructionCost, 	DisposalDate, 	DisposalCost, 	UsefulLife, 	AssetCriticality, 	AssetCondition, 	AssetRisk, 	AssetConditionModel, 	ConditionDate, 	Classification, 	Notes, 	AlertNotes, 	OffsetSide, 	OffsetMetres, 	Deleted, 	GeomType, 	first(WKT) as WKT, 	first(WKTValue) as WKTValue
from 
( 
select
  a.*,
  replace(left(b.wkt, instr(b.wkt, '(') - 1), ' ', '') as GeomType,
  b.WKT,
  trim(
    REPLACE(
      REPLACE(
        replace(
          replace(
            replace(
              replace(b.wkt, 'MULTILINESTRING', ''),
              'LINESTRING',
              ''
            ),
            'MULTIPOINT',
            ''
          ),
          'POINT',
          ''
        ),
        ')',
        ''
      ),
      '(',
      ''
    )
  ) as WKTValue
from
  ext_mssql_asset_vision_ven_rms.dbo.asset a
  left join ext_mssql_asset_vision_ven_rms.dbo.vassetlocation b on a.id = b.AssetID
)
group by ID, 	DeltaUTC, 	ModifiedUTC, 	ExportDateUTC, 	ModifiedUser, 	Code, 	Name, 	Contract, 	AssetType, 	SpatialType, 	ParentAssetID, 	ParentAssetCode, 	ParentAssetName, 	ParentAssetTypeName, 	Direction, 	ChainageFrom, 	ChainageTo, 	ParentAssetPosition, 	Stage, 	ConstructionDate, 	ConstructionCost, 	DisposalDate, 	DisposalCost, 	UsefulLife, 	AssetCriticality, 	AssetCondition, 	AssetRisk, 	AssetConditionModel, 	ConditionDate, 	Classification, 	Notes, 	AlertNotes, 	OffsetSide, 	OffsetMetres, 	Deleted, 	GeomType
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
| `GeomType` | `string` | Yes |  |
| `WKT` | `string` | Yes |  |
| `WKTValue` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_srapc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
