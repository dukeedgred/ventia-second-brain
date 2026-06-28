---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: uvw_job
full-name: transport_dev.transport_tsrc.uvw_job
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - uvw_job

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_job` |
| Full name | `transport_dev.transport_tsrc.uvw_job` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | VIEW |
| Column count | 64 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | jobs / work orders |
| Owner/SME | Helix_readwrite_transport_dev_transport_tsrc |
| Refresh/freshness | Created: 2024-05-29T07:15:44.874Z; Last altered: 2024-07-18T22:23:43.838Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
select
  j.id,
  j.assetid,
  j.assetcode,
  j.assetname,
  j.assettypename,
  j.section,
  j.region,
  j.activitytype,
  j.classification,
  j.activitycategorycode,
  j.activitycategoryname,
  j.activitycode,
  j.activityname,
  j.interventionid,
  j.interventioncode,
  j.interventionname,
  j.fullinterventioncode,
  j.hazardcode,
  j.hazarddefectcode,
  j.reference1,
  j.reference2,
  j.direction,
  j.referencepointname,
  j.chainagefrom,
  j.chainageto,
  j.distancepast,
  j.unit,
  j.estimatedquantity,
  j.priority,
  j.inspectionid,
  i.inspectiontypename,
  cm.moduleid as workpackid,
  cm.modulerecordname as workpackname,
  j.createddate,
  j.createduser,
  convert_timezone('UTC', 'Australia/Sydney', j.modifiedutc) as lastmodified,
  j.duedate,
  j.scheduledstart,
  j.scheduledend,
  j.completeddate,
  j.completeduser,
  j.approvaldate,
  j.approvalnumber,
  j.futureworks,
  j.assigneduser,
  j.assigneddate,
  j.completedstatus,
  j.compliant,
  j.currentworkflowitemcode,
  j.currentworkflowitemname,
  f1.value as WorkOrderType,
  f2.value as kpi25compliance,
  f3.value as kpi25comments,
  f4.value as FindAndFixWorks,
  f6.value as TrafficControlReqd,
  f7.value as NightWorks,
  f8.value as RequiredPlant,
  f5.value as LocationSelect,
  f9.value as LocationConfirmation,
  j.spatialinfo,
  (
    select
      count(1)
    from
      ext_mssql_asset_vision_ven_gen7.dbo.photo
    where
      sourcetable = 'Job'
      and sourcetableid = j.id
      and stage = 'Job Before'
      and deleted = False
  ) as photobefore,
  (
    select
      count(1)
    from
      ext_mssql_asset_vision_ven_gen7.dbo.photo
    where
      sourcetable = 'Job'
      and sourcetableid = j.id
      and stage = 'Job During'
      and deleted = False
  ) as photoduring,
  (
    select
      count(1)
    from
      ext_mssql_asset_vision_ven_gen7.dbo.photo
    where
      sourcetable = 'Job'
      and sourcetableid = j.id
      and stage = 'Job After'
      and deleted = False
  ) as photoafter,
  (
    select
      count(distinct timesheetid)
    from
      ext_mssql_asset_vision_ven_gen7.dbo.timesheetitem
    where
      sourcetable = 'Job'
      and sourcetableid = j.id
      and deleted = False
  ) as timesheetcount
from
  ext_mssql_asset_vision_ven_gen7.dbo.job j
  left join ext_mssql_asset_vision_ven_gen7.dbo.formfield f1 on j.id = f1.sourcetableid
            and f1.sourcetable = 'Job'
            and f1.name = 'Job Details|Work Order Type'
            and f1.deleted = false
  left join ext_mssql_asset_vision_ven_gen7.dbo.formfield f2 on j.id = f2.sourcetableid
            and f2.sourcetable = 'Job'
            and f2.name = 'Job Compliance|KPI 25 Compliant'
            and f2.deleted = false
  left join ext_mssql_asset_vision_ven_gen7.dbo.formfield f3 on j.id = f3.sourcetableid
            and f3.sourcetable = 'Job'
            and f3.name = 'Job Compliance|KPI Compliance Comment'
            and f3.deleted = false
  left join ext_mssql_asset_vision_ven_gen7.dbo.formfield f4 on j.id = f4.sourcetableid
            and f4.sourcetable = 'Job'
            and f4.name = 'Maintenance Jobs Information|Find and Fix - Corrective and Preventative Works'
            and f4.deleted = false
  left join ext_mssql_asset_vision_ven_gen7.dbo.formfield f5 on j.id = f5.sourcetableid
            and f5.sourcetable = 'Job'
            and f5.name = 'Maintenance Jobs Information|Location Select'
            and f5.deleted = false
  left join ext_mssql_asset_vision_ven_gen7.dbo.formfield f6 on j.id = f6.sourcetableid
            and f6.sourcetable = 'Job'
            and f6.name = 'Maintenance Jobs Information|Traffic Control Required'
            and f6.deleted = false
  left join ext_mssql_asset_vision_ven_gen7.dbo.formfield f7 on j.id = f7.sourcetableid
            and f7.sourcetable = 'Job'
            and f7.name = 'Maintenance Jobs Information|Night Works'
            and f7.deleted = false
  left join ext_mssql_asset_vision_ven_gen7.dbo.formfield f8 on j.id = f8.sourcetableid
            and f8.sourcetable = 'Job'
            and f8.name = 'Maintenance Jobs Information|Required Plant'
            and f8.deleted = false
  left join ext_mssql_asset_vision_ven_gen7.dbo.formfield f9 on j.id = f9.sourcetableid
            and f9.sourcetable = 'Job'
            and f9.name = 'Maintenance Jobs Information|Location Confirmation'
            and f9.deleted = false
  left join ext_mssql_asset_vision_ven_gen7.dbo.inspection i on j.inspectionid = i.id
            and i.deleted = false
            and i.contract = 'Toowoomba Second Range Crossing'
  left join (
              SELECT
                c.id,
                m1.contract as contract,
                c.moduleid,
                m1.modulename as modulename,
                m1.name as modulerecordname,
                c.sourcetable,
                CASE
                  WHEN c.sourcetable = 'Module'
                  or c.sourcetable = 'Container' THEN m2.modulename
                  ELSE c.sourcetable
                END as sourcetablename,
                c.sourcetableid,
                c.sortorder
              FROM
                ext_mssql_asset_vision_ven_gen7.dbo.custommoduleitem c
                LEFT JOIN ext_mssql_asset_vision_ven_gen7.dbo.module m1 ON c.moduleid = m1.id
                AND m1.deleted = False
                LEFT JOIN ext_mssql_asset_vision_ven_gen7.dbo.module m2 ON c.sourcetableid = m2.id
                AND m1.deleted = False
                AND m1.contract = m2.contract
              WHERE
                c.deleted = False
              ORDER BY
                m1.contract,
                c.moduleid
          ) cm on j.id = cm.sourcetableid
            and cm.sourcetablename = 'Job'
            and cm.modulename = 'Work Packs'
            and cm.contract = 'Toowoomba Second Range Crossing'
where
  j.contract = 'Toowoomba Second Range Crossing'
  and j.deleted = false
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `id` | `int` | Yes |  |
| `assetid` | `int` | Yes |  |
| `assetcode` | `string` | Yes |  |
| `assetname` | `string` | Yes |  |
| `assettypename` | `string` | Yes |  |
| `section` | `string` | Yes |  |
| `region` | `string` | Yes |  |
| `activitytype` | `string` | Yes |  |
| `classification` | `string` | Yes |  |
| `activitycategorycode` | `string` | Yes |  |
| `activitycategoryname` | `string` | Yes |  |
| `activitycode` | `string` | Yes |  |
| `activityname` | `string` | Yes |  |
| `interventionid` | `int` | Yes |  |
| `interventioncode` | `string` | Yes |  |
| `interventionname` | `string` | Yes |  |
| `fullinterventioncode` | `string` | Yes |  |
| `hazardcode` | `string` | Yes |  |
| `hazarddefectcode` | `string` | Yes |  |
| `reference1` | `string` | Yes |  |
| `reference2` | `string` | Yes |  |
| `direction` | `string` | Yes |  |
| `referencepointname` | `string` | Yes |  |
| `chainagefrom` | `int` | Yes |  |
| `chainageto` | `int` | Yes |  |
| `distancepast` | `int` | Yes |  |
| `unit` | `string` | Yes |  |
| `estimatedquantity` | `decimal(10,3)` | Yes |  |
| `priority` | `string` | Yes |  |
| `inspectionid` | `int` | Yes |  |
| `inspectiontypename` | `string` | Yes |  |
| `workpackid` | `int` | Yes |  |
| `workpackname` | `string` | Yes |  |
| `createddate` | `timestamp` | Yes |  |
| `createduser` | `string` | Yes |  |
| `lastmodified` | `timestamp_ntz` | Yes |  |
| `duedate` | `timestamp` | Yes |  |
| `scheduledstart` | `timestamp` | Yes |  |
| `scheduledend` | `timestamp` | Yes |  |
| `completeddate` | `timestamp` | Yes |  |
| `completeduser` | `string` | Yes |  |
| `approvaldate` | `timestamp` | Yes |  |
| `approvalnumber` | `string` | Yes |  |
| `futureworks` | `boolean` | Yes |  |
| `assigneduser` | `string` | Yes |  |
| `assigneddate` | `timestamp` | Yes |  |
| `completedstatus` | `string` | Yes |  |
| `compliant` | `string` | Yes |  |
| `currentworkflowitemcode` | `string` | Yes |  |
| `currentworkflowitemname` | `string` | Yes |  |
| `WorkOrderType` | `string` | Yes |  |
| `kpi25compliance` | `string` | Yes |  |
| `kpi25comments` | `string` | Yes |  |
| `FindAndFixWorks` | `string` | Yes |  |
| `TrafficControlReqd` | `string` | Yes |  |
| `NightWorks` | `string` | Yes |  |
| `RequiredPlant` | `string` | Yes |  |
| `LocationSelect` | `string` | Yes |  |
| `LocationConfirmation` | `string` | Yes |  |
| `spatialinfo` | `binary` | Yes |  |
| `photobefore` | `bigint` | Yes |  |
| `photoduring` | `bigint` | Yes |  |
| `photoafter` | `bigint` | Yes |  |
| `timesheetcount` | `bigint` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
