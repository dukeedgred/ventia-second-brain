---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_srapc
table-name: uvw_inspection_all_attributes
full-name: transport_dev.transport_srapc.uvw_inspection_all_attributes
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-srapc]
---

# Transport Table - transport_srapc - uvw_inspection_all_attributes

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_inspection_all_attributes` |
| Full name | `transport_dev.transport_srapc.uvw_inspection_all_attributes` |
| Catalog | `transport_dev` |
| Schema | `transport_srapc` |
| Contract/schema | `transport_srapc` |
| Table type | VIEW |
| Column count | 41 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | inspection / audit / condition |
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2026-03-19T03:15:23.19Z; Last altered: 2026-03-19T03:15:23.19Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
SELECT
    i.id AS `Inspection ID`,
    i.AssetTypeName,
    i.contract AS `District`,
    i.createduser AS `Created User`,
    i.assigneduser AS `User Assigned To`,
    i.completeduser AS `Completed User`,
    i.inspectiontypeid AS `Inspection Type Code`,
    i.inspectiontypename AS `Inspection Type`,
    i.inspectiontypereference1 AS `Reference 1`,
    i.inspectiontypereference1 AS `Reference 2`,
    i.assettypename AS `Asset Type Name`,
    i.assetcode AS `Asset Code`,
    i.assetname AS `Asset Name`,
    f1.Name AS FieldName,
    f1.value AS ConditionRating,
    COALESCE(aa.Value, 'Parkland Zone') AS `Contract Region`,
    i.classification AS `Classification`,
    TO_TIMESTAMP(i.scheduleddate) AS `Scheduled Date`,
    TO_TIMESTAMP(i.createddate) AS `Created Date`,
    TO_TIMESTAMP(i.startdate) AS `Start Date`,
    TO_TIMESTAMP(i.completeddate) AS `Completed Date`,
    i.currentstatus AS `Status`,
    i.comments AS `Comments`,
    (
        SELECT
            COUNT(1)
        FROM
            ext_mssql_asset_vision_ven_rms.dbo.job j
        WHERE
            j.inspectionid = i.id
            AND j.deleted = FALSE
            AND j.contract = 'SRAP-C'
    ) AS `Jobs`,
    i.reference1 AS `WBS`,
    i.reference2 AS `Sap Work Order No`,
    i.jobid AS `Job ID`,
    i.capitalworkid AS `Captial Work ID`,
    c.name AS `Capital Work Name`,
    i.inspectionroutename AS `Inspection Route Name`,
    i.inspectiongroupid AS `Inspection Group ID`,
    i.estimatedduration AS `Estimated Duration`,
    (
        SELECT
            COUNT(DISTINCT timesheetid)
        FROM
            ext_mssql_asset_vision_ven_rms.dbo.timesheetitem t
        WHERE
            i.id = t.sourcetableid
            AND t.deleted = FALSE
            AND t.sourcetable = 'Inspection'
    ) AS `Timesheets`,
    '' AS `Forms Record ID`,
    i.inspectionid AS `Asset Inspection ID`,
    i.moduleid AS `Module ID`,
    i.section AS `Section`,
    'No' AS `AutoPilot`,
    NVL(cm.moduleid, '') AS `Customer Request (VEN)`,
    CAST(regexp_extract(i.WKT, '(-?\\d+\\.?\\d*)\\s+(-?\\d+\\.?\\d*)', 2) AS DOUBLE) AS `Latitude`,
    CAST(regexp_extract(i.WKT, '(-?\\d+\\.?\\d*)\\s+(-?\\d+\\.?\\d*)', 1) AS DOUBLE) AS `Longitude`
FROM
    ext_mssql_asset_vision_ven_rms.dbo.vinspection i
        LEFT JOIN ext_mssql_asset_vision_ven_rms.dbo.capitalwork c
            ON i.capitalworkid = c.id
            AND c.contract = 'SRAP-C'
            AND c.deleted = FALSE
        LEFT JOIN ext_mssql_asset_vision_ven_rms.dbo.assetattribute aa
            ON aa.AssetID = i.AssetID
            AND aa.Deleted = FALSE
            AND aa.Name = 'Contract Region'
        LEFT JOIN (
            SELECT
                cm.id,
                m1.contract AS contract,
                cm.moduleid,
                m1.modulename AS modulename,
                m1.name AS modulerecordname,
                cm.sourcetable,
                CASE
                    WHEN
                        cm.sourcetable = 'Module'
                        OR cm.sourcetable = 'Container'
                    THEN
                        m2.modulename
                    ELSE cm.sourcetable
                END AS sourcetablename,
                cm.sourcetableid,
                cm.sortorder
            FROM
                ext_mssql_asset_vision_ven_rms.dbo.custommoduleitem cm
                    LEFT JOIN ext_mssql_asset_vision_ven_rms.dbo.module m1
                        ON cm.moduleid = m1.id
                        AND m1.deleted = FALSE
                    LEFT JOIN ext_mssql_asset_vision_ven_rms.dbo.module m2
                        ON cm.sourcetableid = m2.id
                        AND m1.deleted = FALSE
                        AND m1.contract = m2.contract
            WHERE
                cm.deleted = FALSE
            ORDER BY
                m1.contract,
                cm.moduleid
        ) cm
            ON i.id = cm.sourcetableid
            AND cm.sourcetablename = 'Inspection'
            AND cm.modulename = 'Customer Request (VEN)'
            AND cm.contract = 'SRAP-C'
        LEFT JOIN ext_mssql_asset_vision_ven_rms.dbo.formfield f1
            ON i.id = f1.SourceTableID
            AND f1.SourceTable = 'Inspection'
            AND f1.Deleted = FALSE
            AND f1.Name = 'Inspection|Condition Rating'
WHERE
    i.contract = 'SRAP-C'
    AND i.deleted = FALSE
    AND i.category = 'Inspection'
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Inspection ID` | `int` | Yes |  |
| `AssetTypeName` | `string` | Yes |  |
| `District` | `string` | Yes |  |
| `Created User` | `string` | Yes |  |
| `User Assigned To` | `string` | Yes |  |
| `Completed User` | `string` | Yes |  |
| `Inspection Type Code` | `int` | Yes |  |
| `Inspection Type` | `string` | Yes |  |
| `Reference 1` | `string` | Yes |  |
| `Reference 2` | `string` | Yes |  |
| `Asset Type Name` | `string` | Yes |  |
| `Asset Code` | `string` | Yes |  |
| `Asset Name` | `string` | Yes |  |
| `FieldName` | `string` | Yes |  |
| `ConditionRating` | `string` | Yes |  |
| `Contract Region` | `string` | No |  |
| `Classification` | `string` | Yes |  |
| `Scheduled Date` | `timestamp` | Yes |  |
| `Created Date` | `timestamp` | Yes |  |
| `Start Date` | `timestamp` | Yes |  |
| `Completed Date` | `timestamp` | Yes |  |
| `Status` | `string` | Yes |  |
| `Comments` | `string` | Yes |  |
| `Jobs` | `bigint` | Yes |  |
| `WBS` | `string` | Yes |  |
| `Sap Work Order No` | `string` | Yes |  |
| `Job ID` | `int` | Yes |  |
| `Captial Work ID` | `int` | Yes |  |
| `Capital Work Name` | `string` | Yes |  |
| `Inspection Route Name` | `string` | Yes |  |
| `Inspection Group ID` | `int` | Yes |  |
| `Estimated Duration` | `decimal(10,2)` | Yes |  |
| `Timesheets` | `bigint` | Yes |  |
| `Forms Record ID` | `string` | No |  |
| `Asset Inspection ID` | `int` | Yes |  |
| `Module ID` | `int` | Yes |  |
| `Section` | `string` | Yes |  |
| `AutoPilot` | `string` | No |  |
| `Customer Request (VEN)` | `string` | No |  |
| `Latitude` | `double` | Yes |  |
| `Longitude` | `double` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_srapc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
