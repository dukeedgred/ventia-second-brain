---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: vw_job_export_final
full-name: transport_dev.transport_wru.vw_job_export_final
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-table, databricks, transport-wru, job-export]
---

# Transport Table - transport_wru - vw_job_export_final

## Identity

| Field | Value |
|---|---|
| Table name | `vw_job_export_final` |
| Full name | `transport_dev.transport_wru.vw_job_export_final` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 32 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | job export |
| Related tables/reports | `ext_mssql_asset_vision_ven_vicroads.dbo.job`, `ext_mssql_asset_vision_ven_vicroads.dbo.asset`, `ext_mssql_asset_vision_ven_vicroads.dbo.vjob`, `ext_mssql_asset_vision_ven_vicroads.dbo.formfield`, `ext_mssql_asset_vision_ven_vicroads.dbo.photo` |

## View Query

```sql
SELECT 
  -- Standard Job Fields
  j.ID as `Job ID`,
  j.InspectionID as `Inspection ID`,
  j.MergedJobID as `Merged Into Job ID`,
  j.LinkedJobID as `Linked Job ID`,
  CONCAT('https://au1.assetvision.com.au/Maintenance/ViewJob/', j.ID) as `Job URL`,
  j.ActivityType as `Activity Type`,
  j.ActivityCode as `Activity Code`,
  -- Standardize Activity Category Code: if it doesn't end with '00', use first 3 chars of Activity Code + '00'
  CASE 
    WHEN vj.ActivityCategoryCode LIKE '%00' THEN vj.ActivityCategoryCode
    ELSE CONCAT(SUBSTRING(j.ActivityCode, 1, 3), '00')
  END as `Activity Category Code`,
  vj.ActivityCategoryName as `Activity Category Name`,
  j.InterventionCode as `Intervention Code`,
  j.FullInterventionCode as `Intervention`,
  j.AssetName as `Asset Name`,
  COALESCE(a.ParentAssetName, j.AssetName) as `Parent Asset Name`,
  a.ParentAssetName as `Parent Asset Name Original`,
  j.Classification,
  j.CreatedDate as `Created Date`,
  j.ModifiedUTC as `Last Modified`,
  j.CreatedUser as `Created User`,
  j.AssignedUser as `Assigned To`,
  j.DueDate as `Due Date`,
  j.ScheduledStart as `Scheduled Start`,
  j.ScheduledEnd as `Scheduled End`,
  j.CompletedDate as `Completed Date`,
  j.CompletedStatus as `Status`,
  j.Comments as `Latest Comment`,
  COUNT(DISTINCT p.ID) as `Before Photos`,
  
  -- Custom FormField Columns
  MAX(CASE WHEN f.Name = 'Job Data|Third Party Works Hazard' THEN f.Value END) as `Third Party Works Hazard`,
  MAX(CASE WHEN f.Name = 'Job Data|Job Origin' THEN f.Value END) as `Job Origin`,
  COALESCE(
    NULLIF(COALESCE(
      MAX(CASE WHEN f.Name = 'Finish Work On Site|F&F (Find and Fix)' THEN f.Value END),
      MAX(CASE WHEN f.Name = 'Job Data|F&F (Find and Fix)' THEN f.Value END)
    ), ''),
    'No'
  ) as `F&F (Find and Fix)`,
  MAX(CASE WHEN f.Name = 'Quality Assurance|Job Details Quality' THEN f.Value END) as `Job Details Quality`,
  
  -- Location Coordinates - Extracted from WKT (Well-Known Text)
  -- WKT format: "POINT (longitude latitude)" - note space after POINT
  TRY_CAST(SPLIT(REGEXP_EXTRACT(vj.WKT, 'POINT \\(([^)]+)\\)', 1), ' ')[1] AS DOUBLE) as `Start Latitude`,
  TRY_CAST(SPLIT(REGEXP_EXTRACT(vj.WKT, 'POINT \\(([^)]+)\\)', 1), ' ')[0] AS DOUBLE) as `Start Longitude`
  
FROM ext_mssql_asset_vision_ven_vicroads.dbo.job j
  LEFT JOIN ext_mssql_asset_vision_ven_vicroads.dbo.asset a
    ON j.AssetID = a.ID
  LEFT JOIN ext_mssql_asset_vision_ven_vicroads.dbo.vjob vj
    ON j.ID = vj.ID
    AND vj.Deleted = false
  LEFT JOIN ext_mssql_asset_vision_ven_vicroads.dbo.formfield f
    ON f.SourceTable = 'Job'
    AND f.SourceTableID = j.ID
    AND f.Deleted = false
  LEFT JOIN ext_mssql_asset_vision_ven_vicroads.dbo.photo p
    ON p.SourceTable = 'Job'
    AND p.SourceTableID = j.ID
    AND p.Stage = 'Job Before'
    AND p.Deleted = false
WHERE j.Deleted = false
GROUP BY 
  j.ID, j.InspectionID, j.MergedJobID, j.LinkedJobID, j.ActivityType, j.ActivityCode, vj.ActivityCategoryCode, vj.ActivityCategoryName, j.InterventionCode, j.FullInterventionCode, j.AssetName,
  a.ParentAssetName, j.Classification, j.CreatedDate, j.ModifiedUTC, 
  j.CreatedUser, j.AssignedUser, j.DueDate, j.ScheduledStart, 
  j.ScheduledEnd, j.CompletedDate, j.CompletedStatus, j.Comments,
  vj.WKT
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Job ID` | `int` | Yes |  |
| `Inspection ID` | `int` | Yes |  |
| `Merged Into Job ID` | `int` | Yes |  |
| `Linked Job ID` | `int` | Yes |  |
| `Job URL` | `string` | Yes |  |
| `Activity Type` | `string` | Yes |  |
| `Activity Code` | `string` | Yes |  |
| `Activity Category Code` | `string` | Yes |  |
| `Activity Category Name` | `string` | Yes |  |
| `Intervention Code` | `string` | Yes |  |
| `Intervention` | `string` | Yes |  |
| `Asset Name` | `string` | Yes |  |
| `Parent Asset Name` | `string` | Yes |  |
| `Parent Asset Name Original` | `string` | Yes |  |
| `Classification` | `string` | Yes |  |
| `Created Date` | `timestamp` | Yes |  |
| `Last Modified` | `timestamp` | Yes |  |
| `Created User` | `string` | Yes |  |
| `Assigned To` | `string` | Yes |  |
| `Due Date` | `timestamp` | Yes |  |
| `Scheduled Start` | `timestamp` | Yes |  |
| `Scheduled End` | `timestamp` | Yes |  |
| `Completed Date` | `timestamp` | Yes |  |
| `Status` | `string` | Yes |  |
| `Latest Comment` | `string` | Yes |  |
| `Before Photos` | `bigint` | No |  |
| `Third Party Works Hazard` | `string` | Yes |  |
| `Job Origin` | `string` | Yes |  |
| `F&F (Find and Fix)` | `string` | No |  |
| `Job Details Quality` | `string` | Yes |  |
| `Start Latitude` | `double` | Yes |  |
| `Start Longitude` | `double` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
