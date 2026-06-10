---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_srapc
table-name: uvw_asset_all_data_withphoto
full-name: transport_dev.transport_srapc.uvw_asset_all_data_withphoto
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-srapc]
---

# Transport Table - transport_srapc - uvw_asset_all_data_withphoto

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_asset_all_data_withphoto` |
| Full name | `transport_dev.transport_srapc.uvw_asset_all_data_withphoto` |
| Catalog | `transport_dev` |
| Schema | `transport_srapc` |
| Contract/schema | `transport_srapc` |
| Table type | VIEW |
| Column count | 56 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | asset register / hierarchy |
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2026-05-05T05:31:55.965Z; Last altered: 2026-05-05T05:31:55.965Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
WITH assetphoto AS (
  WITH assetallphoto AS (
    WITH latestinsp AS (
      SELECT
        contract,
        id,
        assettypename,
        assetid,
        assetcode,
        assetid,
        ROW_NUMBER() OVER (
            PARTITION BY assettypename, assetid
            ORDER BY assettypename, assetid, completeddate DESC
          ) AS rownum
      FROM
        ext_mssql_asset_vision_ven_rms.dbo.inspection
      WHERE
        category = 'Inspection'
        AND currentstatus = 'Completed'
        AND deleted = false
      ORDER BY
        assettypename,
        assetid,
        rownum
    )
    SELECT
      id,
      sourcetable,
      sourcetableid,
      url,
      stage
    FROM
      ext_mssql_asset_vision_ven_rms.dbo.photo
    WHERE
      sourcetable = 'Asset'
      AND deleted = false
    UNION ALL
    SELECT
      p.id,
      'Asset' AS sourcetable,
      i.assetid AS sourcetableid,
      p.url,
      p.stage
    FROM
      ext_mssql_asset_vision_ven_rms.dbo.photo p
        JOIN latestinsp i
          ON i.id = p.sourcetableid
    WHERE
      p.sourcetable = 'Job'
      AND p.deleted = false
      AND p.stage = 'Job After'
      AND i.rownum = 1
  )
  SELECT
    *,
    ROW_NUMBER() OVER (PARTITION BY sourcetableid ORDER BY sourcetableid) AS rownum
  FROM
    assetallphoto
  ORDER BY
    sourcetableid
)
SELECT
  a.id AS `Asset_ID`,
  a.assettype AS `Asset_Type`,
  a.code AS `Asset_Code`,
  a.name AS `Asset_Name`,
  a.direction AS `Direction`,
  a.chainagefrom AS `Chainage_From`,
  a.chainageto AS `Chainage_To`,
  a.assetcriticality AS `Criticality`,
  a.assetcondition AS `Condition`,
  a.assetrisk AS `Risk`,
  a.classification AS `Classification`,
  a.contract AS `District`,
  NVL(aa4.value, 'Parkland Zone') AS `Contract_Region`,
  a.spatialtype AS `Spatial_Type`,
  al.spatialinfo AS `Spatial_Info`,
  CAST(regexp_extract(al.WKT, '(-?\\d+\\.?\\d*)\\s+(-?\\d+\\.?\\d*)', 2) AS DOUBLE) AS `Latitude`,
  CAST(regexp_extract(al.WKT, '(-?\\d+\\.?\\d*)\\s+(-?\\d+\\.?\\d*)', 1) AS DOUBLE) AS `Longitude`,
  a.parentassetid AS `Parent_Asset_ID`,
  a.parentassetcode AS `Parent_Asset_Code`,
  a.parentassetname AS `Parent_Asset_Name`,
  a.parentassettypename AS `Parent_Asset_Type`,
  a.parentassetposition AS `Parent_Asset_Position`,
  a.notes AS `Notes`,
  a.alertnotes AS `Alert_Notes`,
  a.offsetmetres AS `Offset_Metres`,
  a.offsetside AS `Offset_Side`,
  CONVERT_TIMEZONE('UTC', 'Australia/Sydney', a.modifiedutc) AS `Last_Modified`,
  a.modifieduser AS `Last_Modified_User`,
  a.stage AS `Asset_Stage`,
  TO_TIMESTAMP(a.constructiondate) AS `Construction_Date`,
  a.constructioncost AS `Construction_Cost`,
  TO_TIMESTAMP(a.conditiondate) AS `Condition Date`,
  a.usefullife AS `Useful_Life_In_Years`,
  '' AS `Service_Level_Condition`,
  '' AS `Barcode`,
  aa1.value AS `ARL`,
  aa2.value AS `ConOps_Score`,
  CAST(aa3.value AS NUMERIC) AS `ConOps_Rank`,
  ni.id AS `Next_Inspection_ID`,
  TO_TIMESTAMP(ni.scheduleddate) AS `Next_Inspection_Scheduled`,
  ni.inspectiontypename AS `Next_Inspection_Type`,
  li.id AS `Last_Inspection_ID`,
  li.inspectiontypename AS `Last_Inspection_Type`,
  TO_TIMESTAMP(li.completeddate) AS `Last_Inspection_Completed`,
  li.comments AS `Last_Inspection_Comment`,
  (
    SELECT
      COUNT(1)
    FROM
      ext_mssql_asset_vision_ven_rms.dbo.job j
    where
      j.contract = 'SRAP-C'
      AND j.assetid = a.id
      and j.deleted = false
      AND j.completedstatus = 'Open'
      AND j.assettypename = a.assettype
  ) AS `Open_Maintenance_Jobs`,
  ap1.url as Photo_1,
  ap2.url as Photo_2,
  ap3.url as Photo_3,
  ap4.url as Photo_4,
  ap5.url as Photo_5,
  ap6.url as Photo_6,
  ap7.url as Photo_7,
  ap8.url as Photo_8,
  ap9.url as Photo_9,
  ap10.url as Photo_10
FROM
  ext_mssql_asset_vision_ven_rms.dbo.asset a
    LEFT JOIN ext_mssql_asset_vision_ven_rms.dbo.vassetlocation al
      ON al.assetid = a.id
      AND al.deleted = false
    LEFT JOIN ext_mssql_asset_vision_ven_rms.dbo.assetattribute aa1
      ON aa1.assetid = a.id
      AND aa1.deleted = false
      AND aa1.name = 'arl'
    LEFT JOIN ext_mssql_asset_vision_ven_rms.dbo.assetattribute aa2
      ON aa2.assetid = a.id
      AND aa2.deleted = false
      AND aa2.name = 'ConOps_Score'
    LEFT JOIN ext_mssql_asset_vision_ven_rms.dbo.assetattribute aa3
      ON aa3.assetid = a.id
      AND aa3.deleted = false
      AND aa3.name in ('Conops_Rank', 'Conops Rank')
    LEFT JOIN ext_mssql_asset_vision_ven_rms.dbo.assetattribute aa4
      ON aa4.assetid = a.id
      AND aa4.deleted = false
      AND aa4.name = 'Contract Region'
    LEFT JOIN (
      SELECT
        i.id,
        i.assettypename,
        i.assetid,
        i.inspectiontypeid,
        i.inspectiontypename,
        i.comments,
        i.scheduleddate,
        i.completeddate,
        i.completeduser,
        ROW_NUMBER() OVER (
            PARTITION BY i.assettypename, i.assetid
            ORDER BY i.assettypename, i.assetid, i.completeddate DESC
          ) AS rownum
      FROM
        ext_mssql_asset_vision_ven_rms.dbo.inspection AS i
      WHERE
        i.contract = 'SRAP-C'
        AND i.deleted = false
        AND i.category = 'Inspection'
        AND i.currentstatus = 'Completed'
      ORDER BY
        i.assettypename,
        i.assetid,
        i.completeddate
    ) li
      ON li.assetid = a.id
      AND a.assettype = li.assettypename
      and li.rownum = 1
    LEFT JOIN (
      SELECT
        i.id,
        i.assettypename,
        i.assetid,
        i.inspectiontypeid,
        i.inspectiontypename,
        i.comments,
        i.scheduleddate,
        i.completeddate,
        i.completeduser,
        ROW_NUMBER() OVER (
            PARTITION BY i.assettypename, i.assetid
            ORDER BY i.assettypename, i.assetid, i.scheduleddate
          ) AS rownum
      FROM
        ext_mssql_asset_vision_ven_rms.dbo.inspection AS i
      WHERE
        i.contract = 'SRAP-C'
        AND i.deleted = false
        AND i.category = 'Inspection'
        AND i.currentstatus <> 'Completed'
        AND date(i.scheduleddate) >= current_date()
      ORDER BY
        i.assettypename,
        i.assetid,
        i.scheduleddate
    ) ni
      ON ni.assetid = a.id
      AND a.assettype = ni.assettypename
      and ni.rownum = 1
    LEFT JOIN assetphoto ap1
      ON a.id = ap1.sourcetableid
      and ap1.rownum = 1
    LEFT JOIN assetphoto ap2
      ON a.id = ap2.sourcetableid
      and ap2.rownum = 2
    LEFT JOIN assetphoto ap3
      ON a.id = ap3.sourcetableid
      and ap3.rownum = 3
    LEFT JOIN assetphoto ap4
      ON a.id = ap4.sourcetableid
      and ap4.rownum = 4
    LEFT JOIN assetphoto ap5
      ON a.id = ap5.sourcetableid
      and ap5.rownum = 5
    LEFT JOIN assetphoto ap6
      ON a.id = ap6.sourcetableid
      and ap6.rownum = 6
    LEFT JOIN assetphoto ap7
      ON a.id = ap7.sourcetableid
      and ap7.rownum = 7
    LEFT JOIN assetphoto ap8
      ON a.id = ap8.sourcetableid
      and ap8.rownum = 8
    LEFT JOIN assetphoto ap9
      ON a.id = ap9.sourcetableid
      and ap9.rownum = 9
    LEFT JOIN assetphoto ap10
      ON a.id = ap10.sourcetableid
      and ap10.rownum = 10
WHERE
  a.contract = 'SRAP-C'
  AND a.deleted = false
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Asset_ID` | `int` | Yes |  |
| `Asset_Type` | `string` | Yes |  |
| `Asset_Code` | `string` | Yes |  |
| `Asset_Name` | `string` | Yes |  |
| `Direction` | `string` | Yes |  |
| `Chainage_From` | `int` | Yes |  |
| `Chainage_To` | `int` | Yes |  |
| `Criticality` | `string` | Yes |  |
| `Condition` | `string` | Yes |  |
| `Risk` | `string` | Yes |  |
| `Classification` | `string` | Yes |  |
| `District` | `string` | Yes |  |
| `Contract_Region` | `string` | No |  |
| `Spatial_Type` | `string` | Yes |  |
| `Spatial_Info` | `binary` | Yes |  |
| `Latitude` | `double` | Yes |  |
| `Longitude` | `double` | Yes |  |
| `Parent_Asset_ID` | `int` | Yes |  |
| `Parent_Asset_Code` | `string` | Yes |  |
| `Parent_Asset_Name` | `string` | Yes |  |
| `Parent_Asset_Type` | `string` | Yes |  |
| `Parent_Asset_Position` | `string` | Yes |  |
| `Notes` | `string` | Yes |  |
| `Alert_Notes` | `string` | Yes |  |
| `Offset_Metres` | `int` | Yes |  |
| `Offset_Side` | `string` | Yes |  |
| `Last_Modified` | `timestamp_ntz` | Yes |  |
| `Last_Modified_User` | `string` | Yes |  |
| `Asset_Stage` | `string` | Yes |  |
| `Construction_Date` | `timestamp` | Yes |  |
| `Construction_Cost` | `decimal(12,2)` | Yes |  |
| `Condition Date` | `timestamp` | Yes |  |
| `Useful_Life_In_Years` | `decimal(6,2)` | Yes |  |
| `Service_Level_Condition` | `string` | No |  |
| `Barcode` | `string` | No |  |
| `ARL` | `string` | Yes |  |
| `ConOps_Score` | `string` | Yes |  |
| `ConOps_Rank` | `decimal(10,0)` | Yes |  |
| `Next_Inspection_ID` | `int` | Yes |  |
| `Next_Inspection_Scheduled` | `timestamp` | Yes |  |
| `Next_Inspection_Type` | `string` | Yes |  |
| `Last_Inspection_ID` | `int` | Yes |  |
| `Last_Inspection_Type` | `string` | Yes |  |
| `Last_Inspection_Completed` | `timestamp` | Yes |  |
| `Last_Inspection_Comment` | `string` | Yes |  |
| `Open_Maintenance_Jobs` | `bigint` | Yes |  |
| `Photo_1` | `string` | Yes |  |
| `Photo_2` | `string` | Yes |  |
| `Photo_3` | `string` | Yes |  |
| `Photo_4` | `string` | Yes |  |
| `Photo_5` | `string` | Yes |  |
| `Photo_6` | `string` | Yes |  |
| `Photo_7` | `string` | Yes |  |
| `Photo_8` | `string` | Yes |  |
| `Photo_9` | `string` | Yes |  |
| `Photo_10` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_srapc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
