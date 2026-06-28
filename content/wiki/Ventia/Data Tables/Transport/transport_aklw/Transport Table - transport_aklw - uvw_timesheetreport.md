---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_aklw
table-name: uvw_timesheetreport
full-name: transport_dev.transport_aklw.uvw_timesheetreport
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-table, databricks, transport-aklw, timesheet]
---

# Transport Table - transport_aklw - uvw_timesheetreport

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_timesheetreport` |
| Full name | `transport_dev.transport_aklw.uvw_timesheetreport` |
| Catalog | `transport_dev` |
| Schema | `transport_aklw` |
| Contract/schema | `transport_aklw` |
| Table type | VIEW |
| Column count | 31 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Contract name | Auckland West Transport |
| Data domain | timesheet |
| Source system | `ext_mssql_asset_vision_vnz_gen7` |

## View Query

```sql
SELECT
  t.sourcetable AS Activity,
  CAST(t.sourcetableid AS INT) AS RecordID,
  t.timesheettypename AS TimesheetType,
  DATE_FORMAT(t.timesheetcreateddate, 'dd/MM/yyyy HH:mm:ss') AS TimesheetDate,
  t.timesheetcreateddate as TimesheetDateUnformatted,
  (
    CAST(t.hours AS INT) + CAST(t.minutes AS INT) / 60
  ) AS DurationInDecimal,
  CAST(t.hours AS INT) AS Hours,
  CAST(t.minutes AS INT) AS Minutes,
  DATE_FORMAT(t.startdate, 'dd/MM/yyyy HH:mm:ss') AS TimeStart,
  DATE_FORMAT(t.enddate, 'dd/MM/yyyy HH:mm:ss') AS TimeEnd,
  CAST(t.quantity AS DECIMAL) AS Quantity,
  '' AS UnitOfMeasure,
  r.unit AS ResourceUnit,
  t.resourcecode AS ResourceCode,
  t.resourcename AS ResourceName,
  CAST(r.cost AS DECIMAL) AS ResourceRate,
  CASE
    WHEN r.cost = '' THEN null
    ELSE CASE
      WHEN t.resourcetype = 'Materials' THEN (
        CAST(t.quantity AS DECIMAL) * CAST(r.cost AS DECIMAL)
      )
      ELSE (
        (
          CAST(t.hours AS INT) + CAST(t.minutes AS INT) / 60
        ) * CAST(r.cost AS DECIMAL)
      )
    END
  END AS ResourceCost,
  t.resourcetype AS ResourceType,
  j.activitycategoryname AS ActivityCategory,
  j.activityname AS ActivityCode,
  j.interventionname AS InterventionCode,
  j.classification AS Classification,
  j.reference1 AS VentiaWBSNumber,
  j.reference2 AS SAPWorkOrder,
  f2.value AS SWONumber,
  j.externalid AS RAMMDispatchID,
  f.value AS HouseNumber,
  j.assetcode AS RoadID,
  j.assetname AS RoadName,
  t.companyratename AS CompanyRate,
  j.contract AS Contract
FROM
  ext_mssql_asset_vision_vnz_gen7.dbo.timesheetitem t
  LEFT JOIN ext_mssql_asset_vision_vnz_gen7.dbo.job j ON j.id = t.sourcetableid
  LEFT JOIN ext_mssql_asset_vision_vnz_gen7.dbo.resource r ON t.resourcecode = r.code
  LEFT JOIN ext_mssql_asset_vision_vnz_gen7.dbo.formfield f ON j.id = f.sourcetableid
  AND f.sourcetable = 'Job'
  AND f.deleted = false
  AND f.name = 'DISPATCH DETAILS|House Number'
  LEFT JOIN ext_mssql_asset_vision_vnz_gen7.dbo.formfield f2 ON j.id = f2.sourcetableid
  AND f2.sourcetable = 'Job'
  AND f2.deleted = false
  AND f2.name = 'GENERAL DETAILS|SWO Number'
WHERE
  t.deleted = false
  AND j.deleted = false
  AND j.contract = 'Auckland West Transport'
  AND r.contract LIKE '%Auckland West Transport%' -- AND r.stage = 'Active'
  AND r.deleted = false
  --AND r.current_indicator = 1
  --AND t.timesheetcreateddate >= '2023-02-10 00:00:00.000'
  --AND t.timesheetcreateddate< '2023-02-18 00:00:00.000'
  --AND j.interventionname LIKE  '%Emergency%'
ORDER BY
  t.timesheetcreateddate DESC
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Activity` | `string` | Yes |  |
| `RecordID` | `int` | Yes |  |
| `TimesheetType` | `string` | Yes |  |
| `TimesheetDate` | `string` | Yes |  |
| `TimesheetDateUnformatted` | `timestamp` | Yes |  |
| `DurationInDecimal` | `double` | Yes |  |
| `Hours` | `int` | Yes |  |
| `Minutes` | `int` | Yes |  |
| `TimeStart` | `string` | Yes |  |
| `TimeEnd` | `string` | Yes |  |
| `Quantity` | `decimal(10,0)` | Yes |  |
| `UnitOfMeasure` | `string` | No |  |
| `ResourceUnit` | `string` | Yes |  |
| `ResourceCode` | `string` | Yes |  |
| `ResourceName` | `string` | Yes |  |
| `ResourceRate` | `decimal(10,0)` | Yes |  |
| `ResourceCost` | `double` | Yes |  |
| `ResourceType` | `string` | Yes |  |
| `ActivityCategory` | `string` | Yes |  |
| `ActivityCode` | `string` | Yes |  |
| `InterventionCode` | `string` | Yes |  |
| `Classification` | `string` | Yes |  |
| `VentiaWBSNumber` | `string` | Yes |  |
| `SAPWorkOrder` | `string` | Yes |  |
| `SWONumber` | `string` | Yes |  |
| `RAMMDispatchID` | `string` | Yes |  |
| `HouseNumber` | `string` | Yes |  |
| `RoadID` | `string` | Yes |  |
| `RoadName` | `string` | Yes |  |
| `CompanyRate` | `string` | Yes |  |
| `Contract` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_aklw]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
