---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_srapc
table-name: uvw_inspections_all
full-name: transport_dev.transport_srapc.uvw_inspections_all
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-srapc]
---

# Transport Table - transport_srapc - uvw_inspections_all

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_inspections_all` |
| Full name | `transport_dev.transport_srapc.uvw_inspections_all` |
| Catalog | `transport_dev` |
| Schema | `transport_srapc` |
| Contract/schema | `transport_srapc` |
| Table type | VIEW |
| Column count | 42 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | inspection / audit / condition |
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2025-05-01T05:50:39.72Z; Last altered: 2025-05-01T05:50:39.72Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
SELECT
  i.id as `Inspection ID`,
  i.AssetTypeName,
  i.contract as `District`,
  i.createduser as `Created User`,
  i.assigneduser as `User Assigned To`,
  i.completeduser as `Completed User`,
  i.inspectiontypeid as `Inspection Type Code`,
  i.inspectiontypename as `Inspection Type`,
  i.inspectiontypereference1 as `Reference 1`,
  i.inspectiontypereference1 as `Reference 2`,
  CASE
    WHEN
      i.assettypename IN (
        'Bridge',
        'Bridge Size Culvert',
        'Culvert',
        'Cycleway',
        'Flood Route Signs',
        'Lift Bridges',
        'Link Carriageway',
        'Minor Sign',
        'Noise Wall',
        'Offroad Paved Area',
        'Open Drainage',
        'Rest Area',
        'Road',
        'Roadside Landscaping',
        'Safety Barrier',
        'Safety Ramp',
        'School Zone',
        'Segment',
        'Slope',
        'Stormwater Quality Improvement',
        'Support Structure',
        'SZ 40 Patch',
        'SZ Dragons Teeth',
        'SZ Raised Zebra Crossing',
        'SZ Static Sign',
        'Tunnel Structure'
      )
    THEN
      'CIVIL'
    WHEN
      i.assettypename IN (
        'AP - Access Points',
        'AWS - Advanced Warning Signs',
        'CMS - Changeable Message Signs',
        'ISLUS - Integrated Speed Limit & Lane Usage Sign',
        'METS - Emergency Phones',
        'OHDS - Over Height Detection Systems',
        'OSDS - Over Speed Detection Systems',
        'Pump Station',
        'RC1 - Electronic Signs',
        'RC2 - Flasher Signs',
        'RC3 - Electronic message signs (VMS type A)',
        'RC4 - Electronic Regulatory Signs',
        'RMCS - Ramp Metering Control Signals',
        'Streetlight',
        'SZAS - School Zone Signs',
        'TCS - Traffic Control Signals',
        'TCS (Lanterns)',
        'TCS (Loops)',
        'TCS (Post)',
        'TIRTL - Infra Red Traffic Logger',
        'TMU - Traffic Monitoring Unit',
        'VDCS - Vehicle Detection & Classification System',
        'VMS - Variable Message Signs',
        'VSLS - Variable Speed Limit Signs',
        'WIM - Weigh in Motion'
      )
    THEN
      'ITS'
    ELSE 'MISC'
  END AS `Asset Type Category`,
  i.assettypename as `Asset Type Name`,
  i.assetcode as `Asset Code`,
  i.assetname as `Asset Name`,
  f1.Name as FieldName,
  f1.value as ConditionRating,
  COALESCE(aa.Value, 'Parkland Zone') AS `Contract Region`,
  i.classification as `Classification`,
  TO_TIMESTAMP(i.scheduleddate) as `Scheduled Date`,
  TO_TIMESTAMP(i.createddate) as `Created Date`,
  TO_TIMESTAMP(i.startdate) as `Start Date`,
  TO_TIMESTAMP(i.completeddate) as `Completed Date`,
  i.currentstatus as `Status`,
  i.comments as `Comments`,
  f2.Value as `Follow-up Work Reqd`,
  (
    SELECT
      COUNT(1)
    FROM
      ext_mssql_asset_vision_ven_rms.dbo.job j
    WHERE
      j.inspectionid = i.id
      AND j.deleted = false
      AND j.contract = 'SRAP-C'
  ) as `Jobs`,
  i.reference1 as `WBS`,
  i.reference2 as `Sap Work Order No`,
  i.jobid as `Job ID`,
  i.capitalworkid as `Captial Work ID`,
  c.name as `Capital Work Name`,
  i.inspectionroutename as `Inspection Route Name`,
  i.inspectiongroupid as `Inspection Group ID`,
  i.estimatedduration as `Estimated Duration`,
  (
    SELECT
      COUNT(DISTINCT timesheetid)
    FROM
      ext_mssql_asset_vision_ven_rms.dbo.timesheetitem t
    WHERE
      i.id = t.sourcetableid
      AND t.deleted = false
      and t.sourcetable = 'Inspection'
  ) as `Timesheets`,
  '' as `Forms Record ID`,
  i.inspectionid as `Asset Inspection ID`,
  i.moduleid as `Module ID`,
  i.section as `Section`,
  'No' as `AutoPilot`,
  COALESCE(cm.moduleid, '') as `Customer Request (VEN)`,
  CONCAT('https://rms.assetvision.com.au/Inspections/ViewInspection/', i.ID) as Inspection_URL
FROM
  ext_mssql_asset_vision_ven_rms.dbo.inspection i
    LEFT JOIN ext_mssql_asset_vision_ven_rms.dbo.capitalwork c
      ON i.capitalworkid = c.id
      AND c.contract = 'SRAP-C'
      AND c.deleted = false
    LEFT JOIN ext_mssql_asset_vision_ven_rms.dbo.assetattribute aa
      ON aa.AssetID = i.AssetID
      AND aa.Deleted = false
      AND aa.Name = 'Contract Region'
    LEFT JOIN (
      SELECT
        cm.id,
        m1.contract as contract,
        cm.moduleid,
        m1.modulename as modulename,
        m1.name as modulerecordname,
        cm.sourcetable,
        CASE
          WHEN
            cm.sourcetable = 'Module'
            OR cm.sourcetable = 'Container'
          THEN
            m2.modulename
          ELSE cm.sourcetable
        END as sourcetablename,
        cm.sourcetableid,
        cm.sortorder
      FROM
        ext_mssql_asset_vision_ven_rms.dbo.custommoduleitem cm
          LEFT JOIN ext_mssql_asset_vision_ven_rms.dbo.module m1
            ON cm.moduleid = m1.id
            AND m1.deleted = False
          LEFT JOIN ext_mssql_asset_vision_ven_rms.dbo.module m2
            ON cm.sourcetableid = m2.id
            AND m1.deleted = False
            AND m1.contract = m2.contract
      WHERE
        cm.deleted = False
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
      AND f1.Deleted = False
      AND f1.Name = 'Inspection|Condition Rating'
    LEFT JOIN ext_mssql_asset_vision_ven_rms.dbo.formfield f2
      ON i.id = f2.SourceTableID
      AND f2.SourceTable = 'Inspection'
      AND f2.Deleted = False
      AND f2.Name = 'Follow-Up Work Details|Is follow up work required?'
WHERE
  i.contract = 'SRAP-C'
  AND i.deleted = False
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
| `Asset Type Category` | `string` | No |  |
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
| `Follow-up Work Reqd` | `string` | Yes |  |
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
| `Inspection_URL` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_srapc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
