---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_ramc
table-name: uvw_stripmap_wkt
full-name: transport_dev.transport_ramc.uvw_stripmap_wkt
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-table, databricks, transport-ramc, stripmap, gis]
---

# Transport Table - transport_ramc - uvw_stripmap_wkt

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_stripmap_wkt` |
| Full name | `transport_dev.transport_ramc.uvw_stripmap_wkt` |
| Catalog | `transport_dev` |
| Schema | `transport_ramc` |
| Contract/schema | `transport_ramc` |
| Table type | VIEW |
| Column count | 11 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | stripmap GIS |
| Related tables/reports | `transport_dev.transport_ramc.uvw_stripmap_jobs`, `transport_dev.transport_ramc.uvw_stripmap_full`, `ext_mssql_asset_vision_ven_gen7.dbo.vjob`, `ext_mssql_asset_vision_ven_gen7.dbo.vassetlocation` |

## View Query

```sql
(
WITH unioned AS (
    --- Create WKT table for Jobs
    SELECT 
      a.AV_Asset_ID,
      a.JobID,
      a.completedstatus AS `JobStatus`,
      a.activitytype AS `JobActivityType`,
      a.Attribute_Name AS `JobCategory`,
      'NA' AS RoughnessClass,
      'NA' AS RuttingClass,
      'NA' AS RideQualityClass,
      b.WKT
    FROM transport_dev.transport_ramc.uvw_stripmap_jobs a
    -- Join for Job WKT
    LEFT JOIN ext_mssql_asset_vision_ven_gen7.dbo.vjob b
    ON a.JobID = b.ID

    UNION --- Union with Asset WKTs

    --- Create WKT table for Assets
    SELECT 
      DISTINCT 
      a.AV_Asset_ID,
      -99 AS JobID,
      'NA' AS `JobStatus`,
      'NA' AS `JobActivityType`,
      'NA' AS `JobCategory`,
      c.Attribute_Value AS RoughnessClass,
      d.Attribute_Value AS RuttingClass,
      e.Attribute_Value AS RideQualityClass,
      b.WKT
    FROM transport_dev.transport_ramc.uvw_stripmap_full a
    LEFT JOIN ext_mssql_asset_vision_ven_gen7.dbo.vassetlocation b
    ON a.AV_Asset_ID = b.AssetID
    -- Left Join to get the condition class
    LEFT JOIN
    (SELECT AV_Asset_ID, Attribute_Value FROM transport_dev.transport_ramc.uvw_stripmap_full
     WHERE Attribute_Name = 'RoughnessClass') as c
    ON a.AV_Asset_ID = c.AV_Asset_ID
    -- Rutting Class
    LEFT JOIN
    (SELECT AV_Asset_ID, Attribute_Value FROM transport_dev.transport_ramc.uvw_stripmap_full
     WHERE Attribute_Name = 'RuttingClass') as d
    ON a.AV_Asset_ID = d.AV_Asset_ID
    -- Ridequality Class
    LEFT JOIN
    (SELECT AV_Asset_ID, Attribute_Value FROM transport_dev.transport_ramc.uvw_stripmap_full
     WHERE Attribute_Name = 'RideQualityClass') as e
    ON a.AV_Asset_ID = e.AV_Asset_ID
)
SELECT
  ROW_NUMBER() OVER(ORDER BY AV_Asset_ID, JobID) AS WKT_Object_ID,
  AV_Asset_ID,
  JobID,
  RoughnessClass,
  RuttingClass,
  RideQualityClass,
  JobStatus,
  JobActivityType,
  JobCategory,
  WKT,
  CASE WHEN WKT LIKE '%GEOMETRYCOLLECTION%' 
        THEN SUBSTRING(WKT,CHARINDEX('POINT',WKT),LEN(WKT)-CHARINDEX('POINT',WKT))
        ELSE WKT END AS `WKT_Fixed`
FROM unioned
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `WKT_Object_ID` | `int` | No |  |
| `AV_Asset_ID` | `int` | Yes |  |
| `JobID` | `int` | Yes |  |
| `RoughnessClass` | `string` | Yes |  |
| `RuttingClass` | `string` | Yes |  |
| `RideQualityClass` | `string` | Yes |  |
| `JobStatus` | `string` | Yes |  |
| `JobActivityType` | `string` | Yes |  |
| `JobCategory` | `string` | Yes |  |
| `WKT` | `string` | Yes |  |
| `WKT_Fixed` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_ramc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
