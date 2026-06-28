---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_job
full-name: transport_dev.transport_wru.uvw_job
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_job

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_job` |
| Full name | `transport_dev.transport_wru.uvw_job` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 87 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | jobs / work orders |
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-06-18T13:05:45.38Z; Last altered: 2024-09-24T01:42:57.434Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
with sq1 as (
  with sq as (
    SELECT
      a.id,
      TIMESTAMP(convert_timezone('Australia/Sydney', a.deltautc)) as deltautc,
      TIMESTAMP(convert_timezone('Australia/Sydney', a.modifiedutc)) as modifiedutc,
      a.assetid,
      a.assetcode,
      a.assetname,
      a.section,
      a.contract,
      a.region,
      a.hazarddefectcode,
      a.hazardcode,
      a.activitycategorycode,
      a.activitycategoryname,
      a.activitycode,
      a.activityname,
      a.interventionid,
      a.interventioncode,
      a.fullinterventioncode,
      a.interventionname,
      a.interventionreference1,
      a.interventionreference2,
      TIMESTAMP(a.createddate),
      a.direction,
      a.referencepointname,
      a.estimatedduration,
      a.chainagefrom,
      a.distancepast,
      a.unit,
      a.estimatedquantity,
      a.priority,
      case
        when a.inspectionid = "" then null
        else a.inspectionid
      end as inspectionid,
      timestamp(a.duedate),
      timestamp(a.scheduledstart),
      timestamp(a.scheduledend),
      timestamp(a.completeddate),
      a.assigneduser,
      TIMESTAMP(convert_timezone('Australia/Sydney', a.approvaldate)) as approvaldate,
      a.approvalnumber,
      a.futureworks,
      a.estimatedcost,
      a.area,
      TIMESTAMP(convert_timezone('Australia/Sydney', a.assigneddate)) as assigneddate,
      a.activitytype,
      a.completedstatus,
      a.reference1,
      a.reference2,
      a.referencepointtypename,
      a.compliant,
      a.classification,
      a.comments,
      a.remainingquantity,
      a.actualquantity,
      a.createduser,
      a.approveduser,
      a.completeduser,
      a.externalid,
      a.assettypename,
      a.inspectiontypename,
      a.currentworkflowitemcode,
      a.currentworkflowitemname,
      a.wkt as spatialinfo,
      a.mergedjobid,
      a.crmid,
      a.deleted,
      a.linkedjobid,
      a.madesafe,
      a.crmdescription,
      a.crmfield1,
      a.crmfield2,
      a.crmfield3,
      a.crmfield4,
      a.crmfield5,
      a.crmfield6,
      a.endreferencepointname,
      a.chainageto,
      a.bothdirections,
      a.enddistancepast,
      a.endreferencepointtypename,
      TIMESTAMP(convert_timezone('Australia/Sydney', a.compliancecalculationdate)) as compliancecalculationdate,
      concat("https://vicroads.assetvision.com.au/Maintenance/ViewJob/", string(a.id)) as job_hyperlink,
      case
        when a.activitytype in ("Cyclical", "Routine") then "Cyclical"
        when a.activitytype in ("Preventative",
                                "Provisional",
                                "Pre-Approved Preventative",
                                "Pre-Approved Provisional"
                              ) then "Preventative"
        when a.activitycode = 'RM814' then 'Emergency Response'
        else activitytype
      end as intervention_level,
      timestamp(convert_timezone('Australia/Sydney', b.modifiedutc)) as modified_aest,
      b.comment,
      b.jobid
    FROM
      ext_mssql_asset_vision_ven_vicroads.dbo.vjob a
      left join ext_mssql_asset_vision_ven_vicroads.dbo.jobcomment b on a.id = b.jobid and b.deleted = false 
    WHERE
      a.contract like '%Western Roads Upgrade (WRU)%'
      AND a.deleted = false
  )
  select
    *,
    row_number() over (partition by id order by modified_aest) as rn,
    case
      when comment is null then null
      else replace(replace(string(array_agg("Date: " || modified_aest || " Comment: " || comment) over (partition by jobid)), "["), "]")
    end as job_comments,
    case
      when comment is null then null
      else "<!DOCTYPE html><html><body>" || replace(replace(string(array_agg("<p><br><b>Date: </b>" || modified_aest || "<br><b> Comment: </b>" || comment) over (partition by jobid)), "["), "]") || "</body></html>"
    end as html_job_comments
  from
    sq
  order by
    modified_aest
)
select
  *
from
  sq1
where
  rn = 1
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `id` | `int` | Yes |  |
| `deltautc` | `timestamp` | Yes |  |
| `modifiedutc` | `timestamp` | Yes |  |
| `assetid` | `int` | Yes |  |
| `assetcode` | `string` | Yes |  |
| `assetname` | `string` | Yes |  |
| `section` | `string` | Yes |  |
| `contract` | `string` | Yes |  |
| `region` | `string` | Yes |  |
| `hazarddefectcode` | `string` | Yes |  |
| `hazardcode` | `string` | Yes |  |
| `activitycategorycode` | `string` | Yes |  |
| `activitycategoryname` | `string` | Yes |  |
| `activitycode` | `string` | Yes |  |
| `activityname` | `string` | Yes |  |
| `interventionid` | `int` | Yes |  |
| `interventioncode` | `string` | Yes |  |
| `fullinterventioncode` | `string` | Yes |  |
| `interventionname` | `string` | Yes |  |
| `interventionreference1` | `string` | Yes |  |
| `interventionreference2` | `string` | Yes |  |
| `createddate` | `timestamp` | Yes |  |
| `direction` | `string` | Yes |  |
| `referencepointname` | `string` | Yes |  |
| `estimatedduration` | `decimal(10,2)` | Yes |  |
| `chainagefrom` | `int` | Yes |  |
| `distancepast` | `int` | Yes |  |
| `unit` | `string` | Yes |  |
| `estimatedquantity` | `decimal(10,3)` | Yes |  |
| `priority` | `string` | Yes |  |
| `inspectionid` | `int` | Yes |  |
| `duedate` | `timestamp` | Yes |  |
| `scheduledstart` | `timestamp` | Yes |  |
| `scheduledend` | `timestamp` | Yes |  |
| `completeddate` | `timestamp` | Yes |  |
| `assigneduser` | `string` | Yes |  |
| `approvaldate` | `timestamp` | Yes |  |
| `approvalnumber` | `string` | Yes |  |
| `futureworks` | `boolean` | Yes |  |
| `estimatedcost` | `decimal(18,2)` | Yes |  |
| `area` | `string` | Yes |  |
| `assigneddate` | `timestamp` | Yes |  |
| `activitytype` | `string` | Yes |  |
| `completedstatus` | `string` | Yes |  |
| `reference1` | `string` | Yes |  |
| `reference2` | `string` | Yes |  |
| `referencepointtypename` | `string` | Yes |  |
| `compliant` | `string` | Yes |  |
| `classification` | `string` | Yes |  |
| `comments` | `string` | Yes |  |
| `remainingquantity` | `decimal(38,2)` | Yes |  |
| `actualquantity` | `decimal(38,2)` | Yes |  |
| `createduser` | `string` | Yes |  |
| `approveduser` | `string` | Yes |  |
| `completeduser` | `string` | Yes |  |
| `externalid` | `string` | Yes |  |
| `assettypename` | `string` | Yes |  |
| `inspectiontypename` | `string` | Yes |  |
| `currentworkflowitemcode` | `string` | Yes |  |
| `currentworkflowitemname` | `string` | Yes |  |
| `spatialinfo` | `string` | Yes |  |
| `mergedjobid` | `int` | Yes |  |
| `crmid` | `string` | Yes |  |
| `deleted` | `boolean` | Yes |  |
| `linkedjobid` | `int` | Yes |  |
| `madesafe` | `boolean` | Yes |  |
| `crmdescription` | `string` | Yes |  |
| `crmfield1` | `string` | Yes |  |
| `crmfield2` | `string` | Yes |  |
| `crmfield3` | `string` | Yes |  |
| `crmfield4` | `string` | Yes |  |
| `crmfield5` | `int` | Yes |  |
| `crmfield6` | `timestamp` | Yes |  |
| `endreferencepointname` | `string` | Yes |  |
| `chainageto` | `int` | Yes |  |
| `bothdirections` | `string` | Yes |  |
| `enddistancepast` | `int` | Yes |  |
| `endreferencepointtypename` | `string` | Yes |  |
| `compliancecalculationdate` | `timestamp` | Yes |  |
| `job_hyperlink` | `string` | Yes |  |
| `intervention_level` | `string` | Yes |  |
| `modified_aest` | `timestamp` | Yes |  |
| `comment` | `string` | Yes |  |
| `jobid` | `int` | Yes |  |
| `rn` | `int` | No |  |
| `job_comments` | `string` | Yes |  |
| `html_job_comments` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
