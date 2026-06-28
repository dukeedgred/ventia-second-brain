---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_ramc
table-name: uvw_stripmap_jobs
full-name: transport_dev.transport_ramc.uvw_stripmap_jobs
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-table, databricks, transport-ramc, stripmap, job]
---

# Transport Table - transport_ramc - uvw_stripmap_jobs

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_stripmap_jobs` |
| Full name | `transport_dev.transport_ramc.uvw_stripmap_jobs` |
| Catalog | `transport_dev` |
| Schema | `transport_ramc` |
| Contract/schema | `transport_ramc` |
| Table type | VIEW |
| Column count | 56 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | stripmap job |
| Related tables/reports | `transport_dev.transport_ramc.uvw_job`, `ext_mssql_asset_vision_ven_gen7.dbo.asset` |

## View Query

```sql
(
  WITH jobsandasset AS (
    SELECT
      -- Get Segment Asset fields
      CASE
        WHEN b.id IS NULL THEN c.ID
        ELSE b.id
      END AS `AV_Asset_ID`,
      CASE
        WHEN b.Code IS NULL THEN c.Code
        ELSE b.Code
      END AS `AV_Asset_Code`,
      CASE
        WHEN b.Name IS NULL THEN c.Name
        ELSE b.Name
      END AS `assetname`,
      --- Chainage information
      CASE
        WHEN b.ChainageFrom IS NULL THEN c.ChainageFrom
        ELSE b.ChainageFrom
      END AS ChainageFrom,
      CASE
        WHEN b.ChainageTo IS NULL THEN c.ChainageTo
        ELSE b.ChainageTo
      END AS ChainageTo,
      CONCAT(
        CAST(
          CASE
            WHEN b.ChainageFrom IS NULL THEN c.ChainageFrom
            ELSE b.ChainageFrom
          END AS INT
        ),
        " - ",
        CAST(
          CASE
            WHEN b.ChainageTo IS NULL THEN c.ChainageTo
            ELSE b.ChainageTo
          END AS INT
        )
      ) AS Chainage_Text,
      CASE
        WHEN CASE
          WHEN b.Direction IS NULL THEN c.Direction
          ELSE b.Direction
        END = "1 or 2" THEN "Forward"
        ELSE "Reverse"
      END AS Carriageway,
      --- Parent Asset Data
      CASE
        WHEN b.id IS NULL THEN c.ParentAssetID
        ELSE b.ParentAssetID
      END AS parentassetid,
      CASE
        WHEN b.id IS NULL THEN c.ParentAssetCode
        ELSE b.ParentAssetCode
      END AS parentassetcode,
      CASE
        WHEN b.id IS NULL THEN c.ParentAssetName
        ELSE b.ParentAssetName
      END AS parentassetname,
      CASE
        WHEN b.id IS NULL THEN c.ParentAssetTypeName
        ELSE b.ParentAssetTypeName
      END AS parentassettypename,
      CASE
        WHEN b.Direction IS NULL THEN c.Direction
        ELSE b.Direction
      END AS direction,
      --a.classification,
      --- Attribute Data
      date('2000-01-01') AS `Survey Date`,
      2000 AS `Survey Year`,
      CASE
        WHEN a.`type` IS NULL THEN 'Unassigned'
        WHEN a.activitytype = 'Safety'
        AND a.`type` = 'Pavement (Non Pothole)' THEN CONCAT(a.`type`, " - ", a.activitytype)
        WHEN a.activitytype = 'Hazard'
        AND a.`type` = 'Pavement (Non Pothole)' THEN CONCAT(a.`type`, " - ", a.activitytype)
        WHEN a.activitytype = 'Notification'
        AND a.`type` = 'Pavement (Non Pothole)' THEN CONCAT(a.`type`, " - ", a.activitytype)
        ELSE a.`type`
      END AS `Attribute_Name`,
      0 AS `Attribute_Value`,
      'Number' AS `Attribute_dtype`,
      --- Filters
      CONCAT(
        CASE
          WHEN b.id IS NULL THEN c.ID
          ELSE b.id
        END,
        "_",CASE
          WHEN a.`Type` IS NULL THEN 'Unassigned'
          ELSE a.`Type`
        END
      ) AS Attribute_FilterTypeID,
      -- Level 1 - Maintenance Job
      'Maintenance Jobs' AS Attribute_FilterType,
      -- Level 2 - Not Used
      'General' AS Attribute_FilterType_lvl2,
      -- Level 3 - Completion status
      a.completedstatus AS Attribute_FilterType_lvl3,
      --- Other data
      a.region,
      a.jobcouncil,
      a.assetcouncil,
      a.council,
      a.id AS `JobID`,
      a.sapworkorder,
      a.section,
      a.chainagefrom AS Job_Chainage,
      a.distancepast,
      a.referencepointname,
      a.jobtype,
      a.activitytype,
      a.hazardcode,
      a.hazarddefectcode,
      a.activitycategorycode,
      a.activitycategoryname,
      a.activitycode,
      a.activityname,
      a.interventioncode,
      a.interventionname,
      a.priority,
      a.wbs,
      a.estimatedquantity,
      a.unit,
      a.estimatedcost,
      a.actualquantity,
      a.completedstatus,
      a.completeduser,
      a.createddate,
      -- Column for Financial year it was created in
      CASE WHEN MONTH(a.createddate) <=6 THEN CONCAT(YEAR(a.createddate)-1,'-',RIGHT(CAST(YEAR(a.createddate) AS STRING),2))
           ELSE CONCAT(YEAR(a.createddate),'-',RIGHT(CAST(YEAR(a.createddate)+1 AS STRING),2))
      END AS Created_Date_FY, 
      a.duedate,
      a.completeddate,
      a.inspectionid,
      a.inspectiontypename,
      a.av_url
    FROM
      transport_dev.transport_ramc.uvw_job a --- Initiate join to asset table
      LEFT JOIN -- Join on Parent Asset ID to get jobs raised on the parent road asset and
      --- SELECT statement to get the segment asset table
      (
        SELECT
          *
        FROM
          ext_mssql_asset_vision_ven_gen7.dbo.asset
        WHERE
          contract = 'RAMC - Gen 2 - 2019-2024'
          AND assettype = 'Segment'
          AND deleted = 'False'
          AND stage = 'Active'
      ) b ON a.assetid = b.ParentAssetID
      AND a.direction = b.Direction
      AND a.chainagefrom >= b.ChainageFrom
      AND a.chainagefrom <= b.ChainageTo
      LEFT JOIN -- Join on Segment Asset to get jobs raised on the Segment asset itself
      --- SELECT statement to get the segment asset table
      (
        SELECT
          *
        FROM
          ext_mssql_asset_vision_ven_gen7.dbo.asset
        WHERE
          contract = 'RAMC - Gen 2 - 2019-2024'
          AND assettype = 'Segment'
          AND deleted = 'False'
          AND stage = 'Active'
      ) c ON a.assetid = c.ID
  ) --- Group by to get aggregate jobs for the segments
  SELECT
    *
  FROM
    jobsandasset
  WHERE
    AV_Asset_Code IS NOT NULL
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `AV_Asset_ID` | `int` | Yes |  |
| `AV_Asset_Code` | `string` | Yes |  |
| `assetname` | `string` | Yes |  |
| `ChainageFrom` | `int` | Yes |  |
| `ChainageTo` | `int` | Yes |  |
| `Chainage_Text` | `string` | Yes |  |
| `Carriageway` | `string` | No |  |
| `parentassetid` | `int` | Yes |  |
| `parentassetcode` | `string` | Yes |  |
| `parentassetname` | `string` | Yes |  |
| `parentassettypename` | `string` | Yes |  |
| `direction` | `string` | Yes |  |
| `Survey Date` | `date` | Yes |  |
| `Survey Year` | `int` | No |  |
| `Attribute_Name` | `string` | Yes |  |
| `Attribute_Value` | `int` | No |  |
| `Attribute_dtype` | `string` | No |  |
| `Attribute_FilterTypeID` | `string` | Yes |  |
| `Attribute_FilterType` | `string` | No |  |
| `Attribute_FilterType_lvl2` | `string` | No |  |
| `Attribute_FilterType_lvl3` | `string` | Yes |  |
| `region` | `string` | Yes |  |
| `jobcouncil` | `string` | Yes |  |
| `assetcouncil` | `string` | Yes |  |
| `council` | `string` | Yes |  |
| `JobID` | `int` | Yes |  |
| `sapworkorder` | `string` | Yes |  |
| `section` | `string` | Yes |  |
| `Job_Chainage` | `int` | Yes |  |
| `distancepast` | `int` | Yes |  |
| `referencepointname` | `string` | Yes |  |
| `jobtype` | `string` | Yes |  |
| `activitytype` | `string` | Yes |  |
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
| `estimatedquantity` | `decimal(10,3)` | No |  |
| `unit` | `string` | Yes |  |
| `estimatedcost` | `decimal(18,2)` | No |  |
| `actualquantity` | `decimal(38,2)` | No |  |
| `completedstatus` | `string` | Yes |  |
| `completeduser` | `string` | Yes |  |
| `createddate` | `timestamp` | Yes |  |
| `Created_Date_FY` | `string` | Yes |  |
| `duedate` | `timestamp` | Yes |  |
| `completeddate` | `timestamp` | Yes |  |
| `inspectionid` | `int` | Yes |  |
| `inspectiontypename` | `string` | Yes |  |
| `av_url` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_ramc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
