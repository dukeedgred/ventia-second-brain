---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_asset
full-name: transport_dev.transport_wru.uvw_asset
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_asset

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_asset` |
| Full name | `transport_dev.transport_wru.uvw_asset` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 33 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | asset register / hierarchy |
| Owner/SME | rui.luan@ventia.com |
| Refresh/freshness | Created: 2026-06-05T00:58:51.853Z; Last altered: 2026-06-05T00:58:51.853Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
  select
    *
  from
    (
      SELECT
        a.id,
        a.deltautc,
        a.modifiedutc,
        a.modifieduser,
        code,
        name,
        contract,
        assettype,
        spatialtype,
        parentassetid,
        parentassetcode,
        parentassetname,
        parentassettypename,
        parentassetposition,
        stage,
        constructiondate,
        constructioncost,
        disposaldate,
        disposalcost,
        usefullife,
        assetcriticality,
        assetcondition,
        assetrisk,
        assetconditionmodel,
        conditiondate,
        classification,
        notes,
        alertnotes,
        concat(
          "https://vicroads.assetvision.com.au/Assets/ViewAsset/",
          string(a.id)
        ) as asset_hyperlink,
        b.WKT as spatialinfo,
        case
          when assettype = "Road" then if(b.direction = '', null, b.direction)
          else if(a.direction = '', null, a.direction)
        end as direction,
        case
          when assettype = "Road" then b.chainagefrom
          else a.chainagefrom
        end as chainagefrom,
        case
          when assettype = "Road" then b.chainageto
          else a.chainageto
        end as chainageto
      FROM
        ext_mssql_asset_vision_ven_vicroads.dbo.asset a
          LEFT JOIN (
            select
              *
            from
              (
                select
                  row_number() over (partition by assetID order by modifiedUTC desc) rn,
                  assetid,
                  direction,
                  chainagefrom,
                  chainageto,
                  wkt
                from
                  ext_mssql_asset_vision_ven_vicroads.dbo.vassetlocation
                where
                  deleted is false
              )
            where
              rn = 1
          ) b
            ON a.id = b.assetid
      WHERE
        a.contract LIKE '%Western Roads Upgrade (WRU)%'
        and a.code not in (
          'SS0616',
          'SS0821',
          'SS0922',
          'SS1275',
          'SN9633',
          'SN0681',
          'SN0751',
          'SN0806',
          'SN6189',
          'SN6215',
          'SN6567',
          'SN7043',
          'SN7892',
          'SN9463',
          'SN9483',
          'SN9628',
          'SN2654',
          'SN2655',
          'SN2678',
          'SN2758',
          'SN1645',
          'SN1845',
          'SN6214',
          'SN7916',
          'SN7917',
          'SN7918',
          'SN7919',
          'SN1991',
          'SN2068',
          'SN2154',
          'SN2173',
          'SN9213',
          'SN1729',
          'SN2077',
          'SN2076',
          'SN2662',
          'SN8725',
          'SN8728',
          'SR0761',
          'SN1379',
          'SN1999',
          'SN2036',
          'SN9632'
        )
        AND a.deleted = false
    )
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
| `name` | `string` | Yes |  |
| `contract` | `string` | Yes |  |
| `assettype` | `string` | Yes |  |
| `spatialtype` | `string` | Yes |  |
| `parentassetid` | `int` | Yes |  |
| `parentassetcode` | `string` | Yes |  |
| `parentassetname` | `string` | Yes |  |
| `parentassettypename` | `string` | Yes |  |
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
| `asset_hyperlink` | `string` | Yes |  |
| `spatialinfo` | `string` | Yes |  |
| `direction` | `string` | Yes |  |
| `chainagefrom` | `int` | Yes |  |
| `chainageto` | `int` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
