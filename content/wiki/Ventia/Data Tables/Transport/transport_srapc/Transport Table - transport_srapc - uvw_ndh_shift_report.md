---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_srapc
table-name: uvw_ndh_shift_report
full-name: transport_dev.transport_srapc.uvw_ndh_shift_report
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-srapc]
---

# Transport Table - transport_srapc - uvw_ndh_shift_report

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_ndh_shift_report` |
| Full name | `transport_dev.transport_srapc.uvw_ndh_shift_report` |
| Catalog | `transport_dev` |
| Schema | `transport_srapc` |
| Contract/schema | `transport_srapc` |
| Table type | VIEW |
| Column count | 20 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2024-05-28T04:58:19.8Z; Last altered: 2024-07-18T20:30:54.277Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
SELECT
  j.id,
  CASE
    j.activitycategorycode
    WHEN 'ITS' THEN assetid
    ELSE a.code || ", " || a.name
  END AS ReportAssetID,
  j.id || ' - INC: ' || f.value AS ReportJobID,
  CASE
    j.activitycategorycode
    WHEN 'SS' THEN j.completedstatus || ' CIVIL' || " " || j.activitytype
    ELSE j.completedstatus || " " || j.activitycategorycode || " " || j.activitytype
  END AS CompletedJobType,
  CASE
    j.activitycode
    WHEN 'TNS_00' THEN 'Civil Incident'
    ELSE NULL
  END AS HighPriorityJobCivil,
  CASE
    j.activitycategorycode || j.interventioncode
    WHEN 'ITSWD' THEN 'ITS Incident'
    WHEN 'ITSFY' THEN 'ITS Incident'
    WHEN 'ITSAP' THEN 'ITS Incident'
    WHEN 'ITSAC' THEN 'ITS Incident'
    WHEN 'ITSBO' THEN 'ITS Incident'
    WHEN 'ITSPF' THEN 'ITS Incident'
    ELSE NULL
  END AS HighPriorityJobITS,
  j.activitytype,
  j.activitycategorycode,
  j.activitycode,
  j.interventioncode,
  j.completedstatus,
  TO_TIMESTAMP(j.createddate) AS createddate,
  TO_DATE(j.createddate) AS createddate_date,
  DATE_FORMAT(j.createddate, "HH:mm") AS createddate_time,
  CASE
    WHEN (DATE_FORMAT(j.createddate, "HH:mm") >= "17:00")
      OR (DATE_FORMAT(j.createddate, "HH:mm") < "05:00") THEN "AM - 5AM to 5PM"
    WHEN (DATE_FORMAT(j.createddate, "HH:mm") >= "05:00")
      OR (DATE_FORMAT(j.createddate, "HH:mm") < "17:00") THEN "PM - 5PM to 5AM"
  END AS createddate_shift,
  TO_TIMESTAMP(j.completeddate) AS completeddate,
  TO_DATE(j.completeddate) AS completeddate_date,
  DATE_FORMAT(j.completeddate, "HH:mm") AS completeddate_time,
  CASE
    WHEN (DATE_FORMAT(j.completeddate, "HH:mm") >= "17:00")
      OR (DATE_FORMAT(j.completeddate, "HH:mm") < "05:00") THEN "AM - 5AM to 5PM"
    WHEN (DATE_FORMAT(j.completeddate, "HH:mm") >= "05:00")
      OR (DATE_FORMAT(j.completeddate, "HH:mm") < "17:00") THEN "PM - 5PM to 5AM"
  END AS completeddate_shift,
  "" AS summary
FROM
  ext_mssql_asset_vision_ven_rms.dbo.job j
  JOIN ext_mssql_asset_vision_ven_rms.dbo.asset a ON j.assetid = a.id
  left JOIN ext_mssql_asset_vision_ven_rms.dbo.formfield f ON f.sourcetable = 'Job'
            AND f.sourcetableid = j.id
            AND f.name = 'Incident|TMC Number'
            AND f.deleted = false
WHERE
  j.contract = 'SRAP-C'
  AND a.contract = 'SRAP-C' 
  AND j.deleted = false
  AND a.deleted = false
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `id` | `int` | Yes |  |
| `ReportAssetID` | `string` | Yes |  |
| `ReportJobID` | `string` | Yes |  |
| `CompletedJobType` | `string` | Yes |  |
| `HighPriorityJobCivil` | `string` | Yes |  |
| `HighPriorityJobITS` | `string` | Yes |  |
| `activitytype` | `string` | Yes |  |
| `activitycategorycode` | `string` | Yes |  |
| `activitycode` | `string` | Yes |  |
| `interventioncode` | `string` | Yes |  |
| `completedstatus` | `string` | Yes |  |
| `createddate` | `timestamp` | Yes |  |
| `createddate_date` | `date` | Yes |  |
| `createddate_time` | `string` | Yes |  |
| `createddate_shift` | `string` | Yes |  |
| `completeddate` | `timestamp` | Yes |  |
| `completeddate_date` | `date` | Yes |  |
| `completeddate_time` | `string` | Yes |  |
| `completeddate_shift` | `string` | Yes |  |
| `summary` | `string` | No |  |

## Related Pages

- [[Transport Contract Tables - transport_srapc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
