---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_inspection
full-name: transport_dev.transport_wru.uvw_inspection
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_inspection

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_inspection` |
| Full name | `transport_dev.transport_wru.uvw_inspection` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 47 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | inspection / audit / condition |
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-05-15T01:19:42.53Z; Last altered: 2024-09-24T01:42:23.387Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
( 
  SELECT
    case
      when id = "" then null
      else id
    end as id,
    deltautc,
    modifiedutc,
    assettypename,
    case
      when assetid = "" then null
      else assetid
    end as assetid,
    assetcode,
    assetname,
    section,
    classification,
    contract,
    region,
    timestamp(convert_timezone('Australia/Sydney', startdate)) as startdate,
    startreferencepointname,
    chainagefrom,
    startdistancepast,
    endreferencepointname,
    chainageto,
    enddistancepast,
    direction,
    bothdirections,
    otherdirectioninspectionid,
    case
      when inspectionid = "" then null
      else inspectionid
    end as inspectionid,
    case
      when moduleid = "" then null
      else moduleid
    end as moduleid,
    inspectiontypeid,
    inspectiontypename,
    inspectiontypereference1,
    inspectiontypereference2,
    category,
    timestamp(createddate) as createddate,
    createduser,
    assigneduser,
    comments,
    entirelength,
    timestamp(scheduleddate) as scheduleddate,
    currentstatus,
    timestamp(
      convert_timezone('Australia/Sydney', completeddate)
    ) as completeddate,
    completeduser,
    case
      when jobid = "" then null
      else jobid
    end as jobid,
    case
      when capitalworkid = "" then null
      else capitalworkid
    end as capitalworkid,
    inspectionroutename,
    inspectiongroupid,
    reference1,
    reference2,
    estimatedduration,
    deleted,
    case
      when spatialinfo = "" then null
      else spatialinfo
    end as spatialinfo,
    'https://vicroads.assetvision.com.au/Inspections/ViewInspection/' || id as insp_hyperlink
    
  FROM
    ext_mssql_asset_vision_ven_vicroads.dbo.inspection
  WHERE
    contract like '%Western Roads Upgrade (WRU)%'
    AND deleted = False
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `id` | `int` | Yes |  |
| `deltautc` | `timestamp` | Yes |  |
| `modifiedutc` | `timestamp` | Yes |  |
| `assettypename` | `string` | Yes |  |
| `assetid` | `int` | Yes |  |
| `assetcode` | `string` | Yes |  |
| `assetname` | `string` | Yes |  |
| `section` | `string` | Yes |  |
| `classification` | `string` | Yes |  |
| `contract` | `string` | Yes |  |
| `region` | `string` | Yes |  |
| `startdate` | `timestamp` | Yes |  |
| `startreferencepointname` | `string` | Yes |  |
| `chainagefrom` | `int` | Yes |  |
| `startdistancepast` | `int` | Yes |  |
| `endreferencepointname` | `string` | Yes |  |
| `chainageto` | `int` | Yes |  |
| `enddistancepast` | `int` | Yes |  |
| `direction` | `string` | Yes |  |
| `bothdirections` | `string` | Yes |  |
| `otherdirectioninspectionid` | `int` | Yes |  |
| `inspectionid` | `int` | Yes |  |
| `moduleid` | `int` | Yes |  |
| `inspectiontypeid` | `int` | Yes |  |
| `inspectiontypename` | `string` | Yes |  |
| `inspectiontypereference1` | `string` | Yes |  |
| `inspectiontypereference2` | `string` | Yes |  |
| `category` | `string` | Yes |  |
| `createddate` | `timestamp` | Yes |  |
| `createduser` | `string` | Yes |  |
| `assigneduser` | `string` | Yes |  |
| `comments` | `string` | Yes |  |
| `entirelength` | `string` | Yes |  |
| `scheduleddate` | `timestamp` | Yes |  |
| `currentstatus` | `string` | Yes |  |
| `completeddate` | `timestamp` | Yes |  |
| `completeduser` | `string` | Yes |  |
| `jobid` | `int` | Yes |  |
| `capitalworkid` | `int` | Yes |  |
| `inspectionroutename` | `string` | Yes |  |
| `inspectiongroupid` | `int` | Yes |  |
| `reference1` | `string` | Yes |  |
| `reference2` | `string` | Yes |  |
| `estimatedduration` | `decimal(10,2)` | Yes |  |
| `deleted` | `boolean` | Yes |  |
| `spatialinfo` | `binary` | Yes |  |
| `insp_hyperlink` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
