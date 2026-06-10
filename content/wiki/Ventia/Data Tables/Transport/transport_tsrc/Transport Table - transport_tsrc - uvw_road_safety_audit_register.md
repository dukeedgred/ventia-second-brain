---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: uvw_road_safety_audit_register
full-name: transport_dev.transport_tsrc.uvw_road_safety_audit_register
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - uvw_road_safety_audit_register

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_road_safety_audit_register` |
| Full name | `transport_dev.transport_tsrc.uvw_road_safety_audit_register` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | VIEW |
| Column count | 35 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | inspection / audit / condition |
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2024-06-05T00:22:08.487Z; Last altered: 2024-07-18T22:23:41.853Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
  WITH RSAKey as (
    WITH RoadSafetyAuditRegPivot as (
      select
        f.name,
        f.value,
        m.id,
        m.deltautc,
        m.modifiedutc,
        m.contract,
        m.region,
        m.completeddate,
        m.modulename,
        m.name as rsaname,
        m.createddate,
        m.createduser,
        m.assigneduser,
        m.comments,
        m.assetid,
        m.assetcode,
        m.assetname,
        m.entirelength,
        m.direction,
        m.startpointname,
        m.chainagefrom,
        m.startdistancepast,
        m.endpointname,
        m.chainageto,
        m.enddistancepast,
        m.deleted,
        m.spatialinfo,
        m.parentsourcetablename,
        m.parentsourcetableid
      from
        ext_mssql_asset_vision_ven_gen7.dbo.formfield f
        inner join ext_mssql_asset_vision_ven_gen7.dbo.module m on f.sourcetableid = m.id
      where
        f.deleted = false
        and m.deleted = false
        and m.contract = 'Toowoomba Second Range Crossing'
        and m.modulename = 'Road Safety Audits Register'
    )
    Select
      *
    from
      RoadSafetyAuditRegPivot rsa pivot (
        max(value) FOR name in (
          'KPI 2 - Initiated - Triggered Section Details|End Date' as `TriggeredSectionDetails-EndDate`,
          'Report Details|TMR Teambinder/Submission Reference ID.' as `TMRTeambinderSubmissionReferenceID`,
          'Report Details|Was this report initiated by a KPI 02 event?' as `InitiatedbyaKPI02event`,
          'KPI 2 - Initiated - Triggered Section Details|Start Date' as `TriggeredSectionDetails-StartDate`,
          'Report Details|Consultant/Contractor' as `ConsultantContractor`,
          'Report Details|Report Submission Date' as `ReportSubmissionDate`
        )
      )
  )
  select
    *,
    concat(
          assetcode,
          assetname,
          (case
              when direction = '1 or 2' then 'Westbound'
              when direction = '3' then 'Eastbound'
              else null
          end),
          chainagefrom,
          chainageto,
          to_date(
            to_timestamp(
              `TriggeredSectionDetails-StartDate`,
              'd/M/yyyy H:m:s'
            )
          ),
          --to_date(to_timestamp(`TriggeredSectionDetails-EndDate`, 'd/M/yyyy H:m:s'))
          'N/A'
    ) as triggersectionkey,
    to_timestamp(ReportSubmissionDate, 'd/M/yyyy H:m:s') as `ReportSubmissionDateTime`
  from
    RSAKey
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `id` | `int` | Yes |  |
| `deltautc` | `timestamp` | Yes |  |
| `modifiedutc` | `timestamp` | Yes |  |
| `contract` | `string` | Yes |  |
| `region` | `string` | Yes |  |
| `completeddate` | `timestamp` | Yes |  |
| `modulename` | `string` | Yes |  |
| `rsaname` | `string` | Yes |  |
| `createddate` | `timestamp` | Yes |  |
| `createduser` | `string` | Yes |  |
| `assigneduser` | `string` | Yes |  |
| `comments` | `string` | Yes |  |
| `assetid` | `int` | Yes |  |
| `assetcode` | `string` | Yes |  |
| `assetname` | `string` | Yes |  |
| `entirelength` | `string` | Yes |  |
| `direction` | `varchar(50)` | Yes |  |
| `startpointname` | `string` | Yes |  |
| `chainagefrom` | `int` | Yes |  |
| `startdistancepast` | `int` | Yes |  |
| `endpointname` | `string` | Yes |  |
| `chainageto` | `int` | Yes |  |
| `enddistancepast` | `int` | Yes |  |
| `deleted` | `boolean` | Yes |  |
| `spatialinfo` | `binary` | Yes |  |
| `parentsourcetablename` | `string` | Yes |  |
| `parentsourcetableid` | `int` | Yes |  |
| `TriggeredSectionDetails-EndDate` | `string` | Yes |  |
| `TMRTeambinderSubmissionReferenceID` | `string` | Yes |  |
| `InitiatedbyaKPI02event` | `string` | Yes |  |
| `TriggeredSectionDetails-StartDate` | `string` | Yes |  |
| `ConsultantContractor` | `string` | Yes |  |
| `ReportSubmissionDate` | `string` | Yes |  |
| `triggersectionkey` | `string` | Yes |  |
| `ReportSubmissionDateTime` | `timestamp` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
