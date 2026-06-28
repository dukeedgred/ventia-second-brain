---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: uvw_assets
full-name: transport_dev.transport_tsrc.uvw_assets
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - uvw_assets

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_assets` |
| Full name | `transport_dev.transport_tsrc.uvw_assets` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | VIEW |
| Column count | 37 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | asset register / hierarchy |
| Owner/SME | Helix_readwrite_transport_dev_transport_tsrc |
| Refresh/freshness | Created: 2024-09-19T23:45:14.294Z; Last altered: 2024-10-22T03:45:45.309Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
with assetconsolidate as (
with assetspivot as (
SELECT 
a.`id`
, a.deltautc
, a.modifiedutc
, a.modifieduser
, a.`code`
, a.`name` as `assetname`
, a.contract
, a.assettype
, a.spatialtype
, a.parentassetid
, a.parentassetcode
, a.parentassetname
, a.parentassettypename
, a.direction
, a.chainagefrom
, a.chainageto
, a.parentassetposition
, a.stage
, a.constructiondate
, a.constructioncost
, a.disposaldate
, a.disposalcost
, a.usefullife
, a.assetcriticality
, a.assetcondition
, a.assetrisk
, a.assetconditionmodel
, a.conditiondate
, a.classification
, a.notes
, a.alertnotes
, a.deleted
, aa.`name`
, aa.value
FROM ext_mssql_asset_vision_ven_gen7.dbo.asset a
inner join ext_mssql_asset_vision_ven_gen7.dbo.assetattribute aa on aa.assetid = a.id
where contract = 'Toowoomba Second Range Crossing'
and a.deleted = 'False'
and a.stage in ('Active', 'Disposed')
and aa.deleted = 'False'
)
select * 
from 
assetspivot 
pivot (
 max(value) FOR name in (
'Drainage Risk Rating' as `DrainageRiskRating`,
'Electrical Asset Type' as `ElectricalAssetType`, 
'Mechanical Asset Type' as `MechanicalAssetType`,
'Fire System Type' as `FireSystemType`,
'Equipment Asset Type' as `EquipmentAssetType`,
'UPS Component Type' as `UPSComponentType`,
'WAH Points' as `WAHPoints`,
'Road Section' as `Road Section`,
'road_section' as `Road Section 2`,
'Section' as `Road Section 3`,
'Inspection Zone' as `Inspection Zone`
))
)
Select 
`id`,
`deltautc`,
`modifiedutc`,
`modifieduser`,
`code`,
`assetname`,
`contract`,
`assettype`,
`spatialtype`,
`parentassetid`,
`parentassetcode`,
`parentassetname`,
`parentassettypename`,
`direction`,
`chainagefrom`,
`chainageto`,
`parentassetposition`,
`stage`,
`constructiondate`,
`constructioncost`,
`disposaldate`,
`disposalcost`,
`usefullife`,
`assetcriticality`,
`assetcondition`,
`assetrisk`,
`assetconditionmodel`,
`conditiondate`,
`classification`,
`notes`,
`alertnotes`,
`deleted`,
`DrainageRiskRating`,
COALESCE(`ElectricalAssetType`,
`MechanicalAssetType`,
`FireSystemType`,
`EquipmentAssetType`,
`UPSComponentType`,
case when `WAHPoints` = 'Yes' then 'WAH Points' end,
case when assettype = 'Table Drain (TSRC)' then COALESCE(`DrainageRiskRating`, 'Standard drainage asset') else '' end
) 
as `AssetSubType`,
`WAHPoints`,
`Inspection Zone`,
COALESCE(`Road Section`,
`Road Section 2`,
`Road Section 3`)
as `Road Section`
from assetconsolidate ac
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `id` | `int` | Yes |  |
| `deltautc` | `timestamp` | Yes |  |
| `modifiedutc` | `timestamp` | Yes |  |
| `modifieduser` | `string` | Yes |  |
| `code` | `string` | Yes |  |
| `assetname` | `string` | Yes |  |
| `contract` | `string` | Yes |  |
| `assettype` | `string` | Yes |  |
| `spatialtype` | `string` | Yes |  |
| `parentassetid` | `int` | Yes |  |
| `parentassetcode` | `string` | Yes |  |
| `parentassetname` | `string` | Yes |  |
| `parentassettypename` | `string` | Yes |  |
| `direction` | `string` | Yes |  |
| `chainagefrom` | `int` | Yes |  |
| `chainageto` | `int` | Yes |  |
| `parentassetposition` | `string` | Yes |  |
| `stage` | `string` | Yes |  |
| `constructiondate` | `timestamp` | Yes |  |
| `constructioncost` | `decimal(12,2)` | Yes |  |
| `disposaldate` | `timestamp` | Yes |  |
| `disposalcost` | `decimal(12,2)` | Yes |  |
| `usefullife` | `decimal(6,2)` | Yes |  |
| `assetcriticality` | `string` | Yes |  |
| `assetcondition` | `string` | Yes |  |
| `assetrisk` | `string` | Yes |  |
| `assetconditionmodel` | `string` | Yes |  |
| `conditiondate` | `timestamp` | Yes |  |
| `classification` | `string` | Yes |  |
| `notes` | `string` | Yes |  |
| `alertnotes` | `string` | Yes |  |
| `deleted` | `boolean` | Yes |  |
| `DrainageRiskRating` | `string` | Yes |  |
| `AssetSubType` | `string` | No |  |
| `WAHPoints` | `string` | Yes |  |
| `Inspection Zone` | `string` | Yes |  |
| `Road Section` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
