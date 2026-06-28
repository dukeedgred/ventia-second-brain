---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: uvw_kpi_10_cctv_requests
full-name: transport_dev.transport_tsrc.uvw_kpi_10_cctv_requests
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - uvw_kpi_10_cctv_requests

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_kpi_10_cctv_requests` |
| Full name | `transport_dev.transport_tsrc.uvw_kpi_10_cctv_requests` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | VIEW |
| Column count | 16 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | KPI / reporting |
| Owner/SME | hui.chen@ventia.com |
| Refresh/freshness | Created: 2024-07-25T12:07:35.141Z; Last altered: 2024-07-25T19:05:20.188Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
  WITH cctvreqpivot_assess(
      WITH cctvreqpivot_mod AS (
          WITH cctvreqpivot AS (
              SELECT
              m.id,
	            CONCAT("https://gen7.assetvision.com.au/Inspections/ViewContainer/",m.id) AS AV_Url,
              m.deltautc,
              m.modifiedutc,
              m.contract,
              m.region,
              m.completeddate,
              m.modulename,
              m.name AS cctvrequestname,
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
              m.spatialinfo,
              m.ParentSourceTableName,
              m.ParentSourceTableID,
              m.deleted,
              f.name,
              f.value
              FROM
              ext_mssql_asset_vision_ven_gen7.dbo.formfield f
              INNER JOIN ext_mssql_asset_vision_ven_gen7.dbo.module m 
              ON f.sourcetableid = m.id
              WHERE
                f.deleted = false
                AND m.deleted = false
                AND m.contract = 'Toowoomba Second Range Crossing'
                AND m.modulename = 'CCTV Footage Requests'
          )
          SELECT
              *,
              -- Calculate assessment date
              CASE WHEN completeddate IS NULL THEN convert_timezone('Australia/Queensland', getdate())
                   ELSE TO_TIMESTAMP(completeddate)
              END AS KPI_10_Assess_DateTime,
              TO_TIMESTAMP(
                  CONCAT(RIGHT(LEFT(RequestDate,10),4),"-",
                         RIGHT(LEFT(RequestDate,5),2),"-",
                         LEFT(RequestDate,2),
                         RIGHT(RequestDate,9))
                      )
              AS Request_DateTime
          FROM
              cctvreqpivot PIVOT (
              max(value) FOR NAME IN (
                  'Request Information|TMR Request ID/Ref. (Teambinder/Email etc.)' AS `TMRRequestIDRef`,
                  'Request Information|Reqeuest Date' AS `RequestDate`,
                  'Request Information|KPI Information: Project Co must make available within 2 Business Days of a request by the State CCTV data collected over the 21 day period immediately preceding the relevant request.' as `KPIInformation`
              )
              )
          )
          SELECT
              id,
              AV_Url,
              assetid,
              assetcode,
              assetname,
              createddate,
              createduser,
              assigneduser,
              cctvrequestname,
              TMRRequestIDRef,
              RequestDate,
              completeddate,
              Request_DateTime,
              (SELECT MAX(`Date`) FROM (SELECT `Date` FROM transport_dev.transport_tsrc.utbl_ref_date_table 
               WHERE Weekday ="Yes" AND PublicHoliday ="No" AND `Date` > a.Request_DateTime ORDER BY `Date` LIMIT 2)) 
              AS KPI_10_DueDate,
              KPI_10_Assess_DateTime
          FROM cctvreqpivot_mod a
  )

  SELECT
      *,
      CASE WHEN (completeddate IS NULL) AND KPI_10_Assess_DateTime > KPI_10_DueDate THEN "Overdue"
          WHEN (completeddate IS NULL) AND KPI_10_Assess_DateTime <= KPI_10_DueDate THEN "Open"
          WHEN KPI_10_Assess_DateTime > KPI_10_DueDate THEN "Late"
          ELSE "Compliant"
      END AS KPI_10_Status
  FROM cctvreqpivot_assess
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `id` | `int` | Yes |  |
| `AV_Url` | `string` | Yes |  |
| `assetid` | `int` | Yes |  |
| `assetcode` | `string` | Yes |  |
| `assetname` | `string` | Yes |  |
| `createddate` | `timestamp` | Yes |  |
| `createduser` | `string` | Yes |  |
| `assigneduser` | `string` | Yes |  |
| `cctvrequestname` | `string` | Yes |  |
| `TMRRequestIDRef` | `string` | Yes |  |
| `RequestDate` | `string` | Yes |  |
| `completeddate` | `timestamp` | Yes |  |
| `Request_DateTime` | `timestamp` | Yes |  |
| `KPI_10_DueDate` | `date` | Yes |  |
| `KPI_10_Assess_DateTime` | `timestamp` | Yes |  |
| `KPI_10_Status` | `string` | No |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
