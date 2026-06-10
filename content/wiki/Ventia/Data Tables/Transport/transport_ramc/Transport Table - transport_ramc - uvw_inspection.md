---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_ramc
table-name: uvw_inspection
full-name: transport_dev.transport_ramc.uvw_inspection
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-ramc]
---

# Transport Table - transport_ramc - uvw_inspection

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_inspection` |
| Full name | `transport_dev.transport_ramc.uvw_inspection` |
| Catalog | `transport_dev` |
| Schema | `transport_ramc` |
| Contract/schema | `transport_ramc` |
| Table type | VIEW |
| Column count | 36 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | inspection / audit / condition |
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2024-05-27T01:16:17.993Z; Last altered: 2024-07-18T19:57:21.655Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
SELECT
  id,
  contract,
  region,
  assettypename,
  assetid,
  assetcode,
  assetname,
  section,
  classification,
  startreferencepointname,
  chainagefrom,
  startdistancepast,
  endreferencepointname,
  chainageto,
  enddistancepast,
  direction,
  bothdirections,
  otherdirectioninspectionid,
  inspectiontypeid,
  inspectiontypename,
  category,
  assigneduser,
  entirelength,
  createddate,
  scheduleddate,
  startdate,
  completeddate,
  completeduser,
  currentstatus,
  jobid,
  capitalworkid,
  inspectionroutename,
  inspectiongroupid,
  reference1 as wbs,
  reference2 as sapworkorder,
  estimatedduration
FROM
  ext_mssql_asset_vision_ven_gen7.dbo.inspection
WHERE
  (contract = 'RAMC - Gen 2 - 2019-2024'
    OR contract = 'RAMC - Gen 2 - North')
  AND deleted = false
  AND category = 'Inspection'
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `id` | `int` | Yes |  |
| `contract` | `string` | Yes |  |
| `region` | `string` | Yes |  |
| `assettypename` | `string` | Yes |  |
| `assetid` | `int` | Yes |  |
| `assetcode` | `string` | Yes |  |
| `assetname` | `string` | Yes |  |
| `section` | `string` | Yes |  |
| `classification` | `string` | Yes |  |
| `startreferencepointname` | `string` | Yes |  |
| `chainagefrom` | `int` | Yes |  |
| `startdistancepast` | `int` | Yes |  |
| `endreferencepointname` | `string` | Yes |  |
| `chainageto` | `int` | Yes |  |
| `enddistancepast` | `int` | Yes |  |
| `direction` | `string` | Yes |  |
| `bothdirections` | `string` | Yes |  |
| `otherdirectioninspectionid` | `int` | Yes |  |
| `inspectiontypeid` | `int` | Yes |  |
| `inspectiontypename` | `string` | Yes |  |
| `category` | `string` | Yes |  |
| `assigneduser` | `string` | Yes |  |
| `entirelength` | `string` | Yes |  |
| `createddate` | `timestamp` | Yes |  |
| `scheduleddate` | `timestamp` | Yes |  |
| `startdate` | `timestamp` | Yes |  |
| `completeddate` | `timestamp` | Yes |  |
| `completeduser` | `string` | Yes |  |
| `currentstatus` | `string` | Yes |  |
| `jobid` | `int` | Yes |  |
| `capitalworkid` | `int` | Yes |  |
| `inspectionroutename` | `string` | Yes |  |
| `inspectiongroupid` | `int` | Yes |  |
| `wbs` | `string` | Yes |  |
| `sapworkorder` | `string` | Yes |  |
| `estimatedduration` | `decimal(10,2)` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_ramc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
