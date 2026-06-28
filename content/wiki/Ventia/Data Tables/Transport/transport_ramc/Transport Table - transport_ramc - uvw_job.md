---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_ramc
table-name: uvw_job
full-name: transport_dev.transport_ramc.uvw_job
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-ramc]
---

# Transport Table - transport_ramc - uvw_job

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_job` |
| Full name | `transport_dev.transport_ramc.uvw_job` |
| Catalog | `transport_dev` |
| Schema | `transport_ramc` |
| Contract/schema | `transport_ramc` |
| Table type | VIEW |
| Column count | 45 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | jobs / work orders |
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2025-04-04T01:47:01.216Z; Last altered: 2025-04-04T01:47:01.216Z |
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
  f3.value as jobtype,
  case 
    when substring(j.ActivityCode from (charindex('-', j.ActivityCode)+1) for 5) = '10500' then 'Potholes'
    when substring(j.ActivityCode from (charindex('-', j.ActivityCode)+1) for 5) = '10800' then 'Edge Break/Drop Off'
    when substring(j.ActivityCode from (charindex('-', j.ActivityCode)+1) for 5) = '11032' then 'Pavement (Non Pothole)'
    when substring(j.ActivityCode from (charindex('-', j.ActivityCode)+1) for 5) = '11041' then 'Pavement (Non Pothole)'
    when substring(j.ActivityCode from (charindex('-', j.ActivityCode)+1) for 5) = '12000' then 'Pavement (Non Pothole)'
    when substring(j.ActivityCode from (charindex('-', j.ActivityCode)+1) for 5) = '12700' then 'Potholes'
    when substring(j.ActivityCode from (charindex('-', j.ActivityCode)+1) for 5) = '13900' then 'Pavement (Non Pothole)'
    when substring(j.ActivityCode from (charindex('-', j.ActivityCode)+1) for 5) = '15821' then 'Pavement (Non Pothole)'
    when substring(j.ActivityCode from (charindex('-', j.ActivityCode)+1) for 5) = '15831' then 'Pavement (Non Pothole)'
    when substring(j.ActivityCode from (charindex('-', j.ActivityCode)+1) for 5) = '15841' then 'Pavement (Non Pothole)'
    when substring(j.ActivityCode from (charindex('-', j.ActivityCode)+1) for 5) = '17021' then 'Pavement (Non Pothole)'
    when substring(j.ActivityCode from (charindex('-', j.ActivityCode)+1) for 5) = '17031' then 'Pavement (Non Pothole)'
    when substring(j.ActivityCode from (charindex('-', j.ActivityCode)+1) for 5) = '17041' then 'Pavement (Non Pothole)'
    when substring(j.ActivityCode from (charindex('-', j.ActivityCode)+1) for 5) = '17051' then 'Pavement (Non Pothole)'
    when substring(j.ActivityCode from (charindex('-', j.ActivityCode)+1) for 5) = '17061' then 'Pavement (Non Pothole)'
    when substring(j.ActivityCode from (charindex('-', j.ActivityCode)+1) for 5) = '17071' then 'Pavement (Non Pothole)'
    when substring(j.ActivityCode from (charindex('-', j.ActivityCode)+1) for 5) = '21500' then 'Pavement (Non Pothole)'
    when substring(j.ActivityCode from (charindex('-', j.ActivityCode)+1) for 5) = '21600' then 'Pavement (Non Pothole)'
    when substring(j.ActivityCode from (charindex('-', j.ActivityCode)+1) for 5) = '22000' then 'Potholes'
    when substring(j.ActivityCode from (charindex('-', j.ActivityCode)+1) for 5) = '30500' then 'Drainage'
    when substring(j.ActivityCode from (charindex('-', j.ActivityCode)+1) for 5) = '31900' then 'Drainage'
    when substring(j.ActivityCode from (charindex('-', j.ActivityCode)+1) for 5) = '32200' then 'Drainage'
    when substring(j.ActivityCode from (charindex('-', j.ActivityCode)+1) for 5) = '32201' then 'Drainage'
    when substring(j.ActivityCode from (charindex('-', j.ActivityCode)+1) for 5) = '32900' then 'Drainage'
    when substring(j.ActivityCode from (charindex('-', j.ActivityCode)+1) for 5) = '33400' then 'Drainage'
    when substring(j.ActivityCode from (charindex('-', j.ActivityCode)+1) for 5) = '45300' then 'Incident'
    when substring(j.ActivityCode from (charindex('-', j.ActivityCode)+1) for 5) = '74000' then 'Pavement (Non Pothole)'
    when substring(j.ActivityCode from (charindex('-', j.ActivityCode)+1) for 5) = '74001' then 'Pavement (Non Pothole)'
    else 'Unassigned'
  end as type,
  j.priority,
  j.reference1 AS wbs,
  COALESCE(j.estimatedquantity, 0.00) as estimatedquantity,
  j.unit,
  COALESCE(j.estimatedcost, 0.00) as estimatedcost,
  COALESCE(j.actualquantity, 0.00) as actualquantity,
  j.completedstatus,
  j.completeduser,
  date_trunc('SECOND', j.createddate) as createddate,
  date_trunc('SECOND', j.duedate) as duedate,
  date_trunc('SECOND', j.completeddate) as completeddate,
  f2.value as IsClaimed,
  f1.Value as ClaimedMonth,
  j.inspectionid,
  j.inspectiontypename,
  CASE WHEN SUBSTRING(j.WKT,1,5) = 'POINT'
    THEN SUBSTRING(j.WKT, INSTR(j.WKT, '-'), (INSTR(j.WKT, ')') - INSTR(j.WKT, '-'))) 
    ELSE SUBSTRING(j.WKT, INSTR(j.WKT, '-'), (INSTR(j.WKT, ', ') - INSTR(j.WKT, '-')))
  END AS latitude,
  CASE WHEN SUBSTRING(j.WKT,1,5) = 'POINT'
    THEN SUBSTRING(j.WKT, INSTR(j.WKT, '(') + 1, (INSTR(j.WKT, ' -') - INSTR(j.WKT, '(') - 1))
    ELSE SUBSTRING(j.WKT, INSTR(j.WKT, '((') + 2, (INSTR(j.WKT, ' -') - INSTR(j.WKT, '((') - 2))
  END AS longitude,
  CONCAT('https://gen7.assetvision.com.au/Maintenance/ViewJob/', j.ID) AS av_url
FROM
  ext_mssql_asset_vision_ven_gen7.dbo.vjob j
    LEFT JOIN ext_mssql_asset_vision_ven_gen7.dbo.assetarea aa
      ON aa.AssetID = j.assetid
      AND j.ChainageFrom BETWEEN aa.ChainageFrom AND aa.ChainageTo
      AND aa.Deleted = FALSE
    LEFT JOIN ext_mssql_asset_vision_ven_gen7.dbo.formfield f1 
      ON f1.Name = 'Job Data|Claimed Month (yyyy-mm)'
      AND f1.SourceTableID = j.id
      AND f1.SourceTable = 'Job'
      AND f1.Deleted = false
    LEFT JOIN ext_mssql_asset_vision_ven_gen7.dbo.formfield f2 
      ON f2.Name = 'Job Data|Claimed'
      AND f2.SourceTableID = j.id
      AND f2.SourceTable = 'Job'
      AND f2.Deleted = false
    LEFT JOIN ext_mssql_asset_vision_ven_gen7.dbo.formfield f3 
      ON f2.Name = 'Job Data|Job Type Name'
      AND f2.SourceTableID = j.id
      AND f2.SourceTable = 'Job'
      AND f2.Deleted = false
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
| `jobtype` | `string` | Yes |  |
| `type` | `string` | No |  |
| `priority` | `string` | Yes |  |
| `wbs` | `string` | Yes |  |
| `estimatedquantity` | `decimal(10,3)` | No |  |
| `unit` | `string` | Yes |  |
| `estimatedcost` | `decimal(18,2)` | No |  |
| `actualquantity` | `decimal(38,2)` | No |  |
| `completedstatus` | `string` | Yes |  |
| `completeduser` | `string` | Yes |  |
| `createddate` | `timestamp` | Yes |  |
| `duedate` | `timestamp` | Yes |  |
| `completeddate` | `timestamp` | Yes |  |
| `IsClaimed` | `string` | Yes |  |
| `ClaimedMonth` | `string` | Yes |  |
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
