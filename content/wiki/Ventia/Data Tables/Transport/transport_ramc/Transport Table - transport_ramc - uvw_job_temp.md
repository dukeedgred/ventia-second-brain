---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_ramc
table-name: uvw_job_temp
full-name: transport_dev.transport_ramc.uvw_job_temp
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-ramc]
---

# Transport Table - transport_ramc - uvw_job_temp

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_job_temp` |
| Full name | `transport_dev.transport_ramc.uvw_job_temp` |
| Catalog | `transport_dev` |
| Schema | `transport_ramc` |
| Contract/schema | `transport_ramc` |
| Table type | VIEW |
| Column count | 41 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | jobs / work orders |
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2025-04-02T00:43:27.25Z; Last altered: 2025-04-02T00:43:27.25Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
SELECT DISTINCT
  j.contract,
  j.region,
  j.id,
  j.reference2 AS sapworkorder,
  j.assetid,
  j.assetcode,
  j.assetname,
  j.section,
  j.chainagefrom,
  j.distancepast,
  j.direction,
  j.referencepointname,
  j.activitytype,
  j.classification,
  j.area AS jobcouncil,
  aa.area AS assetcouncil,
  COALESCE(j.area, aa.area) AS council,
  j.hazardcode,
  j.hazarddefectcode,
  j.activitycategorycode,
  j.activitycategoryname,
  j.activitycode,
  j.activityname,
  j.interventioncode,
  j.interventionname,
  j.priority,
  j.reference1 AS wbs,
  j.estimatedquantity,
  j.unit,
  j.estimatedcost,
  j.actualquantity,
  j.completedstatus,
  j.completeduser,
  j.createddate,
  j.duedate,
  j.completeddate, 
 -- date_format(j.createddate, 'dd/MM/yyyy HH:mm:ss') as createddate,
 -- date_format(j.duedate, 'dd/MM/yyyy HH:mm:ss') as duedate,
 -- date_format(j.completeddate, 'dd/MM/yyyy HH:mm:ss') as completeddate,
  j.inspectionid,
  j.inspectiontypename,
  SUBSTRING(j.WKT, INSTR(j.WKT, '-'), (INSTR(j.WKT, ')') - INSTR(j.WKT, '-'))) AS latitude,
  SUBSTRING(
    j.WKT, INSTR(j.WKT, '(') + 1, (INSTR(j.WKT, ' -') - INSTR(j.WKT, '(') - 1)
  ) AS longitude,
  CONCAT('https://gen7.assetvision.com.au/Maintenance/ViewJob/', j.ID) AS av_url
FROM
  ext_mssql_asset_vision_ven_gen7.dbo.vjob j
    LEFT JOIN ext_mssql_asset_vision_ven_gen7.dbo.assetarea aa
      ON aa.AssetID = j.assetid
      AND aa.Deleted = FALSE
WHERE
  j.contract IN ('RAMC - Gen 2 - 2019-2024', 'RAMC - Gen 2 - North')
  AND j.deleted = FALSE
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `contract` | `string` | Yes |  |
| `region` | `string` | Yes |  |
| `id` | `int` | Yes |  |
| `sapworkorder` | `string` | Yes |  |
| `assetid` | `int` | Yes |  |
| `assetcode` | `string` | Yes |  |
| `assetname` | `string` | Yes |  |
| `section` | `string` | Yes |  |
| `chainagefrom` | `int` | Yes |  |
| `distancepast` | `int` | Yes |  |
| `direction` | `string` | Yes |  |
| `referencepointname` | `string` | Yes |  |
| `activitytype` | `string` | Yes |  |
| `classification` | `string` | Yes |  |
| `jobcouncil` | `string` | Yes |  |
| `assetcouncil` | `string` | Yes |  |
| `council` | `string` | Yes |  |
| `hazardcode` | `string` | Yes |  |
| `hazarddefectcode` | `string` | Yes |  |
| `activitycategorycode` | `string` | Yes |  |
| `activitycategoryname` | `string` | Yes |  |
| `activitycode` | `string` | Yes |  |
| `activityname` | `string` | Yes |  |
| `interventioncode` | `string` | Yes |  |
| `interventionname` | `string` | Yes |  |
| `priority` | `string` | Yes |  |
| `wbs` | `string` | Yes |  |
| `estimatedquantity` | `decimal(10,3)` | Yes |  |
| `unit` | `string` | Yes |  |
| `estimatedcost` | `decimal(18,2)` | Yes |  |
| `actualquantity` | `decimal(38,2)` | Yes |  |
| `completedstatus` | `string` | Yes |  |
| `completeduser` | `string` | Yes |  |
| `createddate` | `timestamp` | Yes |  |
| `duedate` | `timestamp` | Yes |  |
| `completeddate` | `timestamp` | Yes |  |
| `inspectionid` | `int` | Yes |  |
| `inspectiontypename` | `string` | Yes |  |
| `latitude` | `string` | Yes |  |
| `longitude` | `string` | Yes |  |
| `av_url` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_ramc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
