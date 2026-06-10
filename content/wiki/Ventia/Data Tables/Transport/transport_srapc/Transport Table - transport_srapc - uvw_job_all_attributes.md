---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_srapc
table-name: uvw_job_all_attributes
full-name: transport_dev.transport_srapc.uvw_job_all_attributes
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-srapc]
---

# Transport Table - transport_srapc - uvw_job_all_attributes

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_job_all_attributes` |
| Full name | `transport_dev.transport_srapc.uvw_job_all_attributes` |
| Catalog | `transport_dev` |
| Schema | `transport_srapc` |
| Contract/schema | `transport_srapc` |
| Table type | VIEW |
| Column count | 78 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | jobs / work orders |
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2026-05-25T00:56:37.053Z; Last altered: 2026-05-25T00:56:37.053Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
WITH latestworkflowstatus AS (
    SELECT
        ROW_NUMBER() OVER (
                PARTITION BY sourcetableid
                ORDER BY sourcetableid, statusdate DESC
            ) AS GroupRowNum,
        sourcetableid,
        statusdate,
        workflowitemcode,
        workflowitemname,
        comment,
        reason
    FROM
        ext_mssql_asset_vision_ven_rms.dbo.workflowstatus
    WHERE
        deleted = FALSE
        AND sourcetable = 'Job'
    ORDER BY
        sourcetableid,
        statusdate
),
lastestjobcomment AS (
    SELECT
        ROW_NUMBER() OVER (PARTITION BY jobid ORDER BY jobid, modifiedutc DESC) AS GroupRowNum,
        jobid,
        modifieduser,
        modifiedutc,
        comment,
        CONCAT(
            modifieduser,
            ' (',
            TO_CHAR(
                CONVERT_TIMEZONE('UTC', 'Australia/Sydney', TO_TIMESTAMP(modifiedutc)),
                'dd/MM/yyyy HH:mm:ss'
            ),
            '): ',
            comment
        ) AS fullcomment
    FROM
        ext_mssql_asset_vision_ven_rms.dbo.jobcomment
    WHERE
        deleted = FALSE
    ORDER BY
        jobid,
        modifiedutc DESC
),
custommodulemappings AS (
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
),
jobspivoted AS (
    WITH jobsunpivioted AS (
        SELECT
            j.id AS `Job ID`,
            TO_TIMESTAMP(j.createddate) AS `Created Date`,
            j.createduser AS `Created User`,
            j.assigneduser AS `Assigned User`,
            j.contract AS `Contract`,
            j.region AS `Region`,
            NVL(aa.value, 'Parkland Zone') AS `Contract Region`,
            j.area AS `Area`,
            j.assettypename AS `Asset Type Name`,
            j.assetid AS `Asset ID`,
            j.assetcode AS `Asset Code`,
            j.assetname AS `Asset Name`,
            j.direction AS `Direction`,
            j.classification AS `Classification`,
            j.referencepointname AS `Reference Point Name`,
            j.chainagefrom AS `Chainage From`,
            j.distancepast AS `Distance Past`,
            j.referencepointtypename AS `Reference Point Type Name`,
            CASE
                WHEN
                    SUBSTRING(j.WKT, 1, 5) = 'POINT'
                THEN
                    SUBSTRING(j.WKT, INSTR(j.WKT, '-'), (INSTR(j.WKT, ')') - INSTR(j.WKT, '-')))
                ELSE SUBSTRING(j.WKT, INSTR(j.WKT, '-'), (INSTR(j.WKT, ', ') - INSTR(j.WKT, '-')))
            END AS latitude,
            CASE
                WHEN
                    SUBSTRING(j.WKT, 1, 5) = 'POINT'
                THEN
                    SUBSTRING(
                        j.WKT,
                        INSTR(j.WKT, '(') + 1,
                        (INSTR(j.WKT, ' -') - INSTR(j.WKT, '(') - 1)
                    )
                ELSE
                    SUBSTRING(
                        j.WKT,
                        INSTR(j.WKT, '((') + 2,
                        (INSTR(j.WKT, ' -') - INSTR(j.WKT, '((') - 2)
                    )
            END AS longitude,
            j.activitytype AS `Activity Type`,
            j.activitycategorycode AS `Activity Category Code`,
            j.activitycategoryname AS `Activity Category Name`,
            j.activitycode AS `Activity Code`,
            j.activityname AS `Activity Name`,
            j.interventioncode AS `Intervention Code`,
            j.interventionname AS `Intervention Name`,
            j.interventionid AS `Intervention ID`,
            j.fullinterventioncode AS `Full Intervention Code`,
            j.priority AS `Priority`,
            j.estimatedquantity AS `Estimated Quantity`,
            j.reference1 AS `WBS`,
            j.reference2 AS `SAP Work Order`,
            TO_TIMESTAMP(j.duedate) AS `Due Date`,
            j.completedstatus AS `Completed Status`,
            TO_TIMESTAMP(j.completeddate) AS `Completed Date`,
            j.completeduser AS `Completed User`,
            j.inspectionid AS `Linked Inspection ID`,
            j.linkedjobid AS `Linked Job ID`,
            NVL(cm.moduleid, '') AS `Linked Customer Request ID`,
            f.name,
            f.value
        FROM
            ext_mssql_asset_vision_ven_rms.dbo.vjob j
                LEFT JOIN custommodulemappings cm
                    ON j.id = cm.sourcetableid
                    AND cm.sourcetablename = 'Job'
                    AND cm.modulename = 'Customer Request (VEN)'
                    AND cm.contract = 'SRAP-C'
                LEFT JOIN ext_mssql_asset_vision_ven_rms.dbo.formfield f
                    ON j.id = f.sourcetableid
                LEFT JOIN ext_mssql_asset_vision_ven_rms.dbo.assetattribute aa
                    ON aa.assetid = j.assetid
                    AND aa.deleted = FALSE
                    AND aa.name = 'Contract Region'
        WHERE
            j.contract = 'SRAP-C'
            AND j.deleted = FALSE
            AND j.MergedJobID IS NULL
            AND f.deleted = FALSE
            AND f.datatype <> 'Label'
            AND f.sourcetable = 'Job'
    )
    SELECT
        *
    FROM
        jobsunpivioted
            PIVOT (
                MAX(value) FOR name IN (
                    'Incident|Asset Configuration Change' AS `Incident - Asset Configuration Change`,
                    'Incident|CRM Number' AS `Incident - CRM Number`,
                    'Incident|If applicable, details of asset damage' AS `Incident - If applicable, details of asset damage`,
                    'Incident|Is there Asset Damage?' AS `Incident - Is there Asset Damage?`,
                    'Incident|Is this an Incident?' AS `Incident - Is this an Incident?`,
                    'Incident|KPI Exemption' AS `Incident - KPI Exemption`,
                    'Incident|KPI Exemption Reason' AS `Incident - KPI Exemption Reason`,
                    'Incident|Please specify detail for asset configuration change' AS `Incident - Please specify detail for asset configuration change`,
                    'Incident|TMC Number' AS `Incident - TMC Number`,
                    'Incident|TNS/Incident permanent repair' AS `Incident - TNS/Incident permanent repair`,
                    'Traffic Management|Have you verified Traffic Control is set up in accordance with the TGS? (Visual check preferred, verbal is acceptable if visual is not practical)' AS `Traffic Management - Have you verified Traffic Control is set up in accordance with the TGS?`,
                    'Traffic Management|Is traffic management to be installed?' AS `Traffic Management - Is traffic management to be installed?`,
                    'Traffic Management|Length of Closure (m)' AS `Traffic Management - Length of Closure (m)`,
                    'Traffic Management|MOU/ROL Number' AS `Traffic Management - MOU/ROL Number`,
                    'Traffic Management|Number Of Lanes Unavailable' AS `Traffic Management - Number Of Lanes Unavailable`,
                    'Traffic Management|TGS Number' AS `Traffic Management - TGS Number`,
                    'Traffic Management|Time of Traffic Devices placed on site' AS `Traffic Management - Time of Traffic Devices placed on site`,
                    'Traffic Management|Time of Traffic Devices removed from site' AS `Traffic Management - Time of Traffic Devices removed from site`,
                    'Asset Management|RMA Number' AS `Asset Management - RMA Number`,
                    'Asset Management|Tactical Project' AS `Asset Management - Tactical Project`,
                    'Asset Management|TfNSW Observation' AS `Asset Management - TfNSW observation`,
                    'Asset Management|Failed KPI' AS `Asset Management - Failed KPI`,
                    'Asset Management|Failed KPI Reason Comments' AS `Asset Management - Failed KPI Reason Comments`,
                    'Environmental|ASEC number/s' AS `Environmental - ASEC number/s`,
                    'Job Data - Civil|Describe activity you are undertaking' AS `Job Data - Describe the Works Performed`,
                    'Follow-Up Work Details|Follow up job details' AS `Follow-Up Work Details - Follow up job details`,
                    'Follow-Up Work Details|Intervention' AS `Follow-Up Work Details - Intervention`,
                    'Follow-Up Work Details|Is follow up work required?' AS `Follow-Up Work Details - Is follow up work required?`,
                    'Follow-Up Work Details|Priority' AS `Follow-Up Work Details - Priority`,
                    'Follow-Up Work Details|Quantity required' AS `Follow-Up Work Details - Quantity required`,
                    'Follow-Up Work Details|Required crew size' AS `Follow-Up Work Details - Required crew size`,
                    'Maintenance Action|Comments' AS `Maintenance Action - Comments`
                )
            )
)
SELECT
    jp.*,
    COALESCE(f1.value, f2.value) AS `Asset Management - TfNSW observation Number`,
    w.workflowitemcode AS `Current Workflow Status Code`,
    w.workflowitemname AS `Current Workflow Status Name`,
    TO_TIMESTAMP(w.statusdate) AS `Current Workflow Status Date`,
    w.reason AS `Current Workflow Reason`,
    jc.fullcomment AS `Latest Comment`
FROM
    jobspivoted jp
        LEFT JOIN latestworkflowstatus w
            ON w.sourcetableid = jp.`Job ID`
        LEFT JOIN lastestjobcomment jc
            ON jc.jobid = jp.`Job ID`
        LEFT JOIN ext_mssql_asset_vision_ven_rms.dbo.formfield f1
            ON  f1.sourcetableid = jp.`Job ID`
            AND f1.deleted = FALSE
            AND f1.sourcetable = 'Job'
            AND f1.name = 'Asset Management|TfNSW observations number'
        LEFT JOIN ext_mssql_asset_vision_ven_rms.dbo.formfield f2
            ON  f2.sourcetableid = jp.`Job ID`
            AND f2.deleted = FALSE
            AND f2.sourcetable = 'Job'
            AND f2.name = 'Asset Management|TfNSW observations'
WHERE
    w.GroupRowNum = 1
    AND jc.GroupRowNum = 1
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Job ID` | `int` | Yes |  |
| `Created Date` | `timestamp` | Yes |  |
| `Created User` | `string` | Yes |  |
| `Assigned User` | `string` | Yes |  |
| `Contract` | `string` | Yes |  |
| `Region` | `string` | Yes |  |
| `Contract Region` | `string` | No |  |
| `Area` | `string` | Yes |  |
| `Asset Type Name` | `string` | Yes |  |
| `Asset ID` | `int` | Yes |  |
| `Asset Code` | `string` | Yes |  |
| `Asset Name` | `string` | Yes |  |
| `Direction` | `string` | Yes |  |
| `Classification` | `string` | Yes |  |
| `Reference Point Name` | `string` | Yes |  |
| `Chainage From` | `int` | Yes |  |
| `Distance Past` | `int` | Yes |  |
| `Reference Point Type Name` | `string` | Yes |  |
| `latitude` | `string` | Yes |  |
| `longitude` | `string` | Yes |  |
| `Activity Type` | `string` | Yes |  |
| `Activity Category Code` | `string` | Yes |  |
| `Activity Category Name` | `string` | Yes |  |
| `Activity Code` | `string` | Yes |  |
| `Activity Name` | `string` | Yes |  |
| `Intervention Code` | `string` | Yes |  |
| `Intervention Name` | `string` | Yes |  |
| `Intervention ID` | `int` | Yes |  |
| `Full Intervention Code` | `string` | Yes |  |
| `Priority` | `string` | Yes |  |
| `Estimated Quantity` | `decimal(10,3)` | Yes |  |
| `WBS` | `string` | Yes |  |
| `SAP Work Order` | `string` | Yes |  |
| `Due Date` | `timestamp` | Yes |  |
| `Completed Status` | `string` | Yes |  |
| `Completed Date` | `timestamp` | Yes |  |
| `Completed User` | `string` | Yes |  |
| `Linked Inspection ID` | `int` | Yes |  |
| `Linked Job ID` | `int` | Yes |  |
| `Linked Customer Request ID` | `string` | No |  |
| `Incident - Asset Configuration Change` | `string` | Yes |  |
| `Incident - CRM Number` | `string` | Yes |  |
| `Incident - If applicable, details of asset damage` | `string` | Yes |  |
| `Incident - Is there Asset Damage?` | `string` | Yes |  |
| `Incident - Is this an Incident?` | `string` | Yes |  |
| `Incident - KPI Exemption` | `string` | Yes |  |
| `Incident - KPI Exemption Reason` | `string` | Yes |  |
| `Incident - Please specify detail for asset configuration change` | `string` | Yes |  |
| `Incident - TMC Number` | `string` | Yes |  |
| `Incident - TNS/Incident permanent repair` | `string` | Yes |  |
| `Traffic Management - Have you verified Traffic Control is set up in accordance with the TGS?` | `string` | Yes |  |
| `Traffic Management - Is traffic management to be installed?` | `string` | Yes |  |
| `Traffic Management - Length of Closure (m)` | `string` | Yes |  |
| `Traffic Management - MOU/ROL Number` | `string` | Yes |  |
| `Traffic Management - Number Of Lanes Unavailable` | `string` | Yes |  |
| `Traffic Management - TGS Number` | `string` | Yes |  |
| `Traffic Management - Time of Traffic Devices placed on site` | `string` | Yes |  |
| `Traffic Management - Time of Traffic Devices removed from site` | `string` | Yes |  |
| `Asset Management - RMA Number` | `string` | Yes |  |
| `Asset Management - Tactical Project` | `string` | Yes |  |
| `Asset Management - TfNSW observation` | `string` | Yes |  |
| `Asset Management - Failed KPI` | `string` | Yes |  |
| `Asset Management - Failed KPI Reason Comments` | `string` | Yes |  |
| `Environmental - ASEC number/s` | `string` | Yes |  |
| `Job Data - Describe the Works Performed` | `string` | Yes |  |
| `Follow-Up Work Details - Follow up job details` | `string` | Yes |  |
| `Follow-Up Work Details - Intervention` | `string` | Yes |  |
| `Follow-Up Work Details - Is follow up work required?` | `string` | Yes |  |
| `Follow-Up Work Details - Priority` | `string` | Yes |  |
| `Follow-Up Work Details - Quantity required` | `string` | Yes |  |
| `Follow-Up Work Details - Required crew size` | `string` | Yes |  |
| `Maintenance Action - Comments` | `string` | Yes |  |
| `Asset Management - TfNSW observation Number` | `string` | Yes |  |
| `Current Workflow Status Code` | `string` | Yes |  |
| `Current Workflow Status Name` | `string` | Yes |  |
| `Current Workflow Status Date` | `timestamp` | Yes |  |
| `Current Workflow Reason` | `string` | Yes |  |
| `Latest Comment` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_srapc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
