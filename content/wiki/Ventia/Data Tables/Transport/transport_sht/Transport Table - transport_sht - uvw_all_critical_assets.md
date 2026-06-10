---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_sht
table-name: uvw_all_critical_assets
full-name: transport_dev.transport_sht.uvw_all_critical_assets
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-sht]
---

# Transport Table - transport_sht - uvw_all_critical_assets

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_all_critical_assets` |
| Full name | `transport_dev.transport_sht.uvw_all_critical_assets` |
| Catalog | `transport_dev` |
| Schema | `transport_sht` |
| Contract/schema | `transport_sht` |
| Table type | VIEW |
| Column count | 21 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | asset register / hierarchy |
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2024-10-14T00:45:23.942Z; Last altered: 2024-10-14T00:45:23.942Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |
| Caveats/open questions | This is a curated `transport_sht` Databricks schema table/view; it does not prove the SHT source operational system is Asset Vision. |

## View Query

```sql
SELECT
  a.ID,
  a.ModifiedUser,
  convert_timezone('UTC', 'Australia/Sydney', a.ModifiedUTC) as ModifiedDate,
  a.Contract,
  a.Code as AssetCode,
  a.Name as AssetName,
  a.AssetType,
  a.SpatialType,
  a.ParentAssetID,
  a.ParentAssetCode,
  a.ParentAssetName,
  a.Direction,
  a.ChainageFrom,
  a.Stage,
  case
    substring(a.AssetCriticality from 5)
    when 'Very High' then '1 - Very High'
    when 'High'      then '2 - High'
    when 'Medium'    then '3 - Medium'
    when 'Low'       then '4 - Low'
    when 'Very Low'  then '5 - Very Low'
    else null
  end as AssetCriticality,
  a.AssetCondition,
  a.ConditionDate,
  a.AssetRisk,
  a.Classification,
  aa.Value as MinimumCondition,
  j.ID as OpenCMID
FROM
  ext_mssql_asset_vision_vns_gen7.dbo.asset a
  left join ext_mssql_asset_vision_vns_gen7.dbo.assetattribute aa on a.ID = aa.AssetID
      and aa.Deleted = false
      and aa.Name = 'Minimum Condition'
  left join (
              select
                *
              from
                ext_mssql_asset_vision_vns_gen7.dbo.job
              where
                CompletedStatus = 'Open'
                and Deleted = false
                and ActivityType = 'Corrective'
            ) j on j.AssetID = a.ID
WHERE
  a.Contract = 'Sydney Harbour Tunnel (SHT)'
  AND a.Deleted = false
  AND a.Stage = 'Active'
  AND a.AssetCriticality IS NOT NULL
  AND a.AssetCriticality <> ''
  AND a.ID <> 322581
ORDER BY
  a.Code
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `ID` | `int` | Yes |  |
| `ModifiedUser` | `string` | Yes |  |
| `ModifiedDate` | `timestamp_ntz` | Yes |  |
| `Contract` | `string` | Yes |  |
| `AssetCode` | `string` | Yes |  |
| `AssetName` | `string` | Yes |  |
| `AssetType` | `string` | Yes |  |
| `SpatialType` | `string` | Yes |  |
| `ParentAssetID` | `int` | Yes |  |
| `ParentAssetCode` | `string` | Yes |  |
| `ParentAssetName` | `string` | Yes |  |
| `Direction` | `string` | Yes |  |
| `ChainageFrom` | `int` | Yes |  |
| `Stage` | `string` | Yes |  |
| `AssetCriticality` | `string` | Yes |  |
| `AssetCondition` | `string` | Yes |  |
| `ConditionDate` | `timestamp` | Yes |  |
| `AssetRisk` | `string` | Yes |  |
| `Classification` | `string` | Yes |  |
| `MinimumCondition` | `string` | Yes |  |
| `OpenCMID` | `int` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_sht]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
