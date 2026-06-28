---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_srapc
table-name: uvw_srapc_assets
full-name: transport_dev.transport_srapc.uvw_srapc_assets
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-srapc]
---

# Transport Table - transport_srapc - uvw_srapc_assets

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_srapc_assets` |
| Full name | `transport_dev.transport_srapc.uvw_srapc_assets` |
| Catalog | `transport_dev` |
| Schema | `transport_srapc` |
| Contract/schema | `transport_srapc` |
| Table type | VIEW |
| Column count | 22 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | asset register / hierarchy |
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2024-06-18T04:44:42.331Z; Last altered: 2024-07-18T20:30:58.495Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
WITH MinLatitudeCTE AS (
  SELECT
    AL.Assetid AS MinLatitude_Assetid,
    MIN(SUBSTRING_INDEX(SUBSTRING_INDEX(AL.WKT, ' -', -1), ')', 1)) AS MinLatitude_For_Filter
  FROM
    ext_mssql_asset_vision_ven_rms.dbo.vassetlocation AL
  GROUP BY
    AL.Assetid
)
SELECT
  SUB.Asset_Table_ID,
  SUB.code,
  SUB.Asset_Location_Table_ID,
  SUB.Assetid,
  SUB.Asset_Spatial_Type,
  SUB.name,
  SUB.assettype,
  SUB.classification,
  SUB.contract,
  SUB.parentassetid,
  SUB.parentassetcode,
  SUB.parentassetname,
  SUB.parentassettypename,
  SUB.direction,
  SUB.chainagefrom,
  SUB.chainageto,
  SUB.Asset_Deleted,
  SUB.Asset_Location_Deleted,
  SUB.Asset_Location_Spatial_Type,
  SUB.spatialinfo,
  SUB.Latitude_For_Filter,
  p.url AS Photo_URL
FROM
  (
    SELECT
      A.ID as Asset_Table_ID,
      A.code,
      AL.ID as Asset_Location_Table_ID,
      AL.Assetid,
      CASE
        WHEN a.spatialtype = 'Polyline' THEN 'LINESTRING'
        WHEN a.spatialtype = 'Point' THEN 'POINT'
        WHEN a.spatialtype = 'Inherited' THEN 'POINT'
        WHEN a.spatialtype = 'MultiLineString' THEN 'MULTILINESTRING'
        ELSE a.spatialtype
      END as Asset_Spatial_Type,
      A.name,
      A.assettype,
      a.classification,
      a.contract,
      a.parentassetid,
      a.parentassetcode,
      a.parentassetname,
      a.parentassettypename,
      a.direction,
      a.chainagefrom,
      a.chainageto,
      a.deleted as Asset_Deleted,
      AL.deleted as Asset_Location_Deleted,
      TRIM(REGEXP_REPLACE(AL.WKT, '\\s*\\(.*$', '')) AS Asset_Location_Spatial_Type,
      AL.WKT AS spatialinfo,
      SUBSTRING_INDEX(SUBSTRING_INDEX(AL.WKT, ' -', -1), ')', 1) AS Latitude_For_Filter,
      ROW_NUMBER() OVER (PARTITION BY A.code ORDER BY AL.ID) AS rn
    FROM
      ext_mssql_asset_vision_ven_rms.dbo.asset A
      JOIN ext_mssql_asset_vision_ven_rms.dbo.vassetlocation AL ON A.id = AL.assetid
    WHERE
      A.contract LIKE 'SRAP-C'
      AND A.deleted = FALSE
      AND AL.deleted = FALSE
      AND (CASE
              WHEN a.spatialtype = 'Polyline' THEN 'LINESTRING'
              WHEN a.spatialtype = 'Point' THEN 'POINT'
              WHEN a.spatialtype = 'Inherited' THEN 'POINT'
              WHEN a.spatialtype = 'MultiLineString' THEN 'MULTILINESTRING'
              ELSE a.spatialtype
        END) = (CASE
                  WHEN TRIM(REGEXP_REPLACE(AL.WKT, '\\s*\\(.*$', '')) = 'Polyline' THEN 'LINESTRING'
                  WHEN TRIM(REGEXP_REPLACE(AL.WKT, '\\s*\\(.*$', '')) = 'Point' THEN 'POINT'
                  WHEN TRIM(REGEXP_REPLACE(AL.WKT, '\\s*\\(.*$', '')) = 'Inherited' THEN 'POINT'
                  WHEN TRIM(REGEXP_REPLACE(AL.WKT, '\\s*\\(.*$', '')) = 'MultiLineString' THEN 'MULTILINESTRING'
                  ELSE TRIM(REGEXP_REPLACE(AL.WKT, '\\s*\\(.*$', ''))
              END)
  ) AS SUB
  JOIN MinLatitudeCTE MLC ON SUB.Assetid = MLC.MinLatitude_Assetid
  LEFT JOIN (
              SELECT
                p1.sourcetableid,
                p1.url,
                ROW_NUMBER() OVER (PARTITION BY p1.sourcetableid ORDER BY p1.sourcetableid) AS photo_rn
              FROM
                ext_mssql_asset_vision_ven_rms.dbo.photo p1
            ) p ON SUB.Asset_Table_ID = p.sourcetableid
            AND p.photo_rn = 1
WHERE
  SUB.rn = 1
ORDER BY
  SUB.Asset_Location_Table_ID,
  SUB.Latitude_For_Filter
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Asset_Table_ID` | `int` | Yes |  |
| `code` | `string` | Yes |  |
| `Asset_Location_Table_ID` | `int` | Yes |  |
| `Assetid` | `int` | Yes |  |
| `Asset_Spatial_Type` | `string` | Yes |  |
| `name` | `string` | Yes |  |
| `assettype` | `string` | Yes |  |
| `classification` | `string` | Yes |  |
| `contract` | `string` | Yes |  |
| `parentassetid` | `int` | Yes |  |
| `parentassetcode` | `string` | Yes |  |
| `parentassetname` | `string` | Yes |  |
| `parentassettypename` | `string` | Yes |  |
| `direction` | `string` | Yes |  |
| `chainagefrom` | `int` | Yes |  |
| `chainageto` | `int` | Yes |  |
| `Asset_Deleted` | `boolean` | Yes |  |
| `Asset_Location_Deleted` | `boolean` | Yes |  |
| `Asset_Location_Spatial_Type` | `string` | Yes |  |
| `spatialinfo` | `string` | Yes |  |
| `Latitude_For_Filter` | `string` | Yes |  |
| `Photo_URL` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_srapc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
