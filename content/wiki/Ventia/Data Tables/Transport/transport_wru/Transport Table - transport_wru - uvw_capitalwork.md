---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_capitalwork
full-name: transport_dev.transport_wru.uvw_capitalwork
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_capitalwork

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_capitalwork` |
| Full name | `transport_dev.transport_wru.uvw_capitalwork` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 27 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | capital works / forward works |
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-06-14T02:43:41.859Z; Last altered: 2024-09-24T01:42:59.044Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
  SELECT
    id,
    deltautc,
    modifiedutc,
    modifieduser,
    name,
    description,
    capitalworktype,
    assettypename,
    case
      when assetid = "" then null
      else assetid
    end as assetid,
    assetcode,
    assetname,
    section,
    direction,
    chainagefrom,
    chainageto,
    contract,
    createduser,
    area,
    plannedstart,
    plannedfinish,
    actualstart,
    actualfinish,
    reference1,
    reference2,
    supervisor,
    WKT as spatialinfo,
    deleted
  FROM
    ext_mssql_asset_vision_ven_vicroads.dbo.vcapitalwork
  WHERE
    contract like '%Western Roads Upgrade (WRU)%'
    AND deleted = FALSE
    
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `id` | `int` | Yes |  |
| `deltautc` | `timestamp` | Yes |  |
| `modifiedutc` | `timestamp` | Yes |  |
| `modifieduser` | `string` | Yes |  |
| `name` | `string` | Yes |  |
| `description` | `string` | Yes |  |
| `capitalworktype` | `string` | Yes |  |
| `assettypename` | `string` | Yes |  |
| `assetid` | `int` | Yes |  |
| `assetcode` | `string` | Yes |  |
| `assetname` | `string` | Yes |  |
| `section` | `string` | Yes |  |
| `direction` | `string` | Yes |  |
| `chainagefrom` | `int` | Yes |  |
| `chainageto` | `int` | Yes |  |
| `contract` | `string` | Yes |  |
| `createduser` | `string` | Yes |  |
| `area` | `decimal(18,2)` | Yes |  |
| `plannedstart` | `timestamp` | Yes |  |
| `plannedfinish` | `timestamp` | Yes |  |
| `actualstart` | `timestamp` | Yes |  |
| `actualfinish` | `timestamp` | Yes |  |
| `reference1` | `string` | Yes |  |
| `reference2` | `string` | Yes |  |
| `supervisor` | `string` | Yes |  |
| `spatialinfo` | `string` | Yes |  |
| `deleted` | `boolean` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
