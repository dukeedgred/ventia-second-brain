---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_srapc
table-name: uvw_pbi_master_jobs_export
full-name: transport_dev.transport_srapc.uvw_pbi_master_jobs_export
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-srapc]
---

# Transport Table - transport_srapc - uvw_pbi_master_jobs_export

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_pbi_master_jobs_export` |
| Full name | `transport_dev.transport_srapc.uvw_pbi_master_jobs_export` |
| Catalog | `transport_dev` |
| Schema | `transport_srapc` |
| Contract/schema | `transport_srapc` |
| Table type | VIEW |
| Column count | 33 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | jobs / work orders |
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2024-06-18T04:30:18.882Z; Last altered: 2024-07-18T20:30:59.324Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
SELECT
  j.id as `Job ID`,
  j.classification as `Classification`,
  j.interventioncode as `Intervention`,
  j.interventionname as `Intervention Name`,
  j.activitycategoryname as `Activity Category Name`,
  j.activityname as `Activity Name`,
  j.priority as `Priority`,
  from_utc_timestamp(to_timestamp(j.createddate), 'Australia/Sydney') as `Created Date`,
  from_utc_timestamp(to_timestamp(j.duedate), 'Australia/Sydney') as `Due Date`,
  j.completedstatus as `Status`,
  from_utc_timestamp(
    to_timestamp(j.completeddate),
    'Australia/Sydney'
  ) as `Rectified Date`,
  NVL(f1.value, 'No') as `Traffic Management > Is traffic management to be installed?`,
  f2.value as `Traffic Management > Length of Closure (m)`,
  f3.value as `Traffic Management > Number Of Lanes Unavailable`,
  f4.value as `Traffic Management > MOU/ROL Number`,
  f5.value as `Traffic Management > TGS Number`,
  from_utc_timestamp(f6.value, 'Australia/Sydney') as `Traffic Management > Time of Traffic Devices placed on site`,
  from_utc_timestamp(f7.value, 'Australia/Sydney') as `Traffic Management > Time of Traffic Devices removed from site`,
  NVL(f8.value, 'No') as `Incident > Is this an Incident?`,
  NVL(f9.value, 'No') as `Incident > Is there Asset Damage?`,
  f10.value as `Maintenance Action > Comments`,
  f11.value as `Job Data > Describe the Works Performed`,
  j.createduser as `Created By`,
  (
    select
      c.comment
    from
      ext_mssql_asset_vision_ven_rms.dbo.jobcomment c
    where
      c.JobID = j.id
    order by
      c.id DESC
    limit
      1
  ) as `Latest Comment`,
  j.completeduser as `Completed By`,
  'LGA' as `LGA`,
  substring(
    j.WKT,
    instr(j.WKT, '-'),
    (
      instr(j.WKT, ')') - instr(j.WKT, '-')
    )
  ) as Latitude,
  substring(
    j.WKT,
    instr(j.WKT, '(') + 1,
    (
      instr(j.WKT, ' -') - instr(j.WKT, '(') - 1
    )
  ) as Longitude,
  f12.value as `Incident > KPI Exemption`,
  f13.value as `Incident > KPI Exemption Reason`,
  f14.value as `Incident > If applicable, Details of asset damage`,
  j.currentworkflowitemname as `Current Workflow Status Name`,
  w.reason as `Current Workflow Status Reason`
from
  ext_mssql_asset_vision_ven_rms.dbo.vjob j
  left join ext_mssql_asset_vision_ven_rms.dbo.formfield f1 on f1.sourcetable = 'Job'
  and f1.name = 'Traffic Management|Is traffic management to be installed?'
  and f1.sourcetableid = j.id
  and f1.deleted = false
  left join ext_mssql_asset_vision_ven_rms.dbo.formfield f2 on f2.sourcetable = 'Job'
  and f2.name = 'Traffic Management|Length of Closure (m)'
  and f2.sourcetableid = j.id
  and f2.deleted = false
  left join ext_mssql_asset_vision_ven_rms.dbo.formfield f3 on f3.sourcetable = 'Job'
  and f3.name = 'Traffic Management|Number Of Lanes Unavailable'
  and f3.sourcetableid = j.id
  and f3.deleted = false
  left join ext_mssql_asset_vision_ven_rms.dbo.formfield f4 on f4.sourcetable = 'Job'
  and f4.name = 'Traffic Management|MOU/ROL Number'
  and f4.sourcetableid = j.id
  and f4.deleted = false
  left join ext_mssql_asset_vision_ven_rms.dbo.formfield f5 on f5.sourcetable = 'Job'
  and f5.name = 'Traffic Management|TGS Number'
  and f5.sourcetableid = j.id
  and f5.deleted = false
  left join ext_mssql_asset_vision_ven_rms.dbo.formfield f6 on f6.sourcetable = 'Job'
  and f6.name = 'Traffic Management|Time of Traffic Devices placed on site'
  and f6.sourcetableid = j.id
  and f6.deleted = false
  left join ext_mssql_asset_vision_ven_rms.dbo.formfield f7 on f7.sourcetable = 'Job'
  and f7.name = 'Traffic Management|Time of Traffic Devices removed from site'
  and f7.sourcetableid = j.id
  and f7.deleted = false
  left join ext_mssql_asset_vision_ven_rms.dbo.formfield f8 on f8.sourcetable = 'Job'
  and f8.name = 'Incident|Is this an Incident?'
  and f8.sourcetableid = j.id
  and f8.deleted = false
  left join ext_mssql_asset_vision_ven_rms.dbo.formfield f9 on f9.sourcetable = 'Job'
  and f9.name = 'Incident|Is there Asset Damage?'
  and f9.sourcetableid = j.id
  and f9.deleted = false
  left join ext_mssql_asset_vision_ven_rms.dbo.formfield f10 on f10.sourcetable = 'Job'
  and f10.name = 'Maintenance Action > Comments' -- no relevant field
  and f10.sourcetableid = j.id
  and f10.deleted = false
  left join ext_mssql_asset_vision_ven_rms.dbo.formfield f11 on f11.sourcetable = 'Job' --and f11.name = 'Job Data > Describe the Works Performed'
  and f11.name = 'Job Data - ITS|What works were undertaken to fix this issue'
  and f11.sourcetableid = j.id
  and f11.deleted = false
  left join ext_mssql_asset_vision_ven_rms.dbo.formfield f12 on f12.sourcetable = 'Job'
  and f12.name = 'Incident|KPI Exemption'
  and f12.sourcetableid = j.id
  and f12.deleted = false
  left join ext_mssql_asset_vision_ven_rms.dbo.formfield f13 on f13.sourcetable = 'Job'
  and f13.name = 'Incident|KPI Exemption Reason'
  and f13.sourcetableid = j.id
  and f13.deleted = false
  left join ext_mssql_asset_vision_ven_rms.dbo.formfield f14 on f14.sourcetable = 'Job'
  and f14.name = 'Incident|If applicable, details of asset damage'
  and f14.sourcetableid = j.id
  and f14.deleted = false
  left join ext_mssql_asset_vision_ven_rms.dbo.workflowstatus w on w.sourcetable = 'Job'
  and w.sourcetableid = j.id
  and w.workflowitemname = j.currentworkflowitemname
where
  j.contract = 'SRAP-C'
  and j.deleted = false
order by
  j.id
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Job ID` | `int` | Yes |  |
| `Classification` | `string` | Yes |  |
| `Intervention` | `string` | Yes |  |
| `Intervention Name` | `string` | Yes |  |
| `Activity Category Name` | `string` | Yes |  |
| `Activity Name` | `string` | Yes |  |
| `Priority` | `string` | Yes |  |
| `Created Date` | `timestamp` | Yes |  |
| `Due Date` | `timestamp` | Yes |  |
| `Status` | `string` | Yes |  |
| `Rectified Date` | `timestamp` | Yes |  |
| `Traffic Management > Is traffic management to be installed?` | `string` | No |  |
| `Traffic Management > Length of Closure (m)` | `string` | Yes |  |
| `Traffic Management > Number Of Lanes Unavailable` | `string` | Yes |  |
| `Traffic Management > MOU/ROL Number` | `string` | Yes |  |
| `Traffic Management > TGS Number` | `string` | Yes |  |
| `Traffic Management > Time of Traffic Devices placed on site` | `timestamp` | Yes |  |
| `Traffic Management > Time of Traffic Devices removed from site` | `timestamp` | Yes |  |
| `Incident > Is this an Incident?` | `string` | No |  |
| `Incident > Is there Asset Damage?` | `string` | No |  |
| `Maintenance Action > Comments` | `string` | Yes |  |
| `Job Data > Describe the Works Performed` | `string` | Yes |  |
| `Created By` | `string` | Yes |  |
| `Latest Comment` | `string` | Yes |  |
| `Completed By` | `string` | Yes |  |
| `LGA` | `string` | No |  |
| `Latitude` | `string` | Yes |  |
| `Longitude` | `string` | Yes |  |
| `Incident > KPI Exemption` | `string` | Yes |  |
| `Incident > KPI Exemption Reason` | `string` | Yes |  |
| `Incident > If applicable, Details of asset damage` | `string` | Yes |  |
| `Current Workflow Status Name` | `string` | Yes |  |
| `Current Workflow Status Reason` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_srapc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
