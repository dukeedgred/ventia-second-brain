---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: uvw_kpi_7_to_14_its_jobs
full-name: transport_dev.transport_tsrc.uvw_kpi_7_to_14_its_jobs
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - uvw_kpi_7_to_14_its_jobs

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_kpi_7_to_14_its_jobs` |
| Full name | `transport_dev.transport_tsrc.uvw_kpi_7_to_14_its_jobs` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | VIEW |
| Column count | 33 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | KPI / reporting |
| Owner/SME | hui.chen@ventia.com |
| Refresh/freshness | Created: 2024-07-25T11:52:38.989Z; Last altered: 2024-07-25T19:05:19.016Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
    SELECT
        id,
        CONCAT("https://gen7.assetvision.com.au/Maintenance/ViewJob/",`id`)AS `AV_Link`,
        a.assettypename,
        a.assetcode,
        a.assetname,
        a.activitycategorycode,
        a.activitycode,
        a.activityname,
        a.activitytype,
        a.interventioncode,
        a.fullinterventioncode,
        a.interventionname,
        a.interventionreference1,
        a.interventionreference2,
        --- The dates are stored in text convert them to times and date stamps
        to_timestamp(a.createddate) AS createddate_time,
        to_timestamp(a.duedate) AS duedate_time,
        to_timestamp(a.completeddate) AS completeddate_time,
        to_date(a.createddate) AS createddate,
        to_date(a.duedate) AS duedate,
        to_date(a.completeddate) AS completeddate,
        a.completedstatus,
        c.Date,
        c.DateKey,
        c.`Day of Week`,
        c.Year,
        c.Quarter,
        c.`Week Number`,
        a.priority,
        b.KPIComplianceRequirement AS `KPI_Criticality`,
        b.`ResponseValue_ScheduleInterval`,
        b.`Response_IntervalUnit`,
        a.`QAReview-DidJobResultinITSassettobedown`,
        DECIMAL(a.`QAReview-TotalHoursDown`) AS Total_Down_Time_Hrs
    FROM transport_dev.transport_tsrc.uvw_jobs_all_attributes a
    --- Join All jobs with the compliance spec
    LEFT JOIN transport_dev.transport_tsrc.utbl_ref_corrective_maintenance_compliance b
        ON b.ActivityCategoryCode = a.activitycategorycode AND b.ActivityCode = a.activitycode AND b.InterventionCode = a.interventioncode
    LEFT JOIN transport_dev.transport_tsrc.utbl_ref_date_table c
        ON c.`Date` = a.completeddate
    --- Filter out for only where the asset exists in the KPI asset up time table
    WHERE a.assetcode IN (SELECT DISTINCT `code` FROM transport_dev.transport_tsrc.uvw_kpi_7_to_14_its_asset_uptime)
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `id` | `int` | Yes |  |
| `AV_Link` | `string` | Yes |  |
| `assettypename` | `string` | Yes |  |
| `assetcode` | `string` | Yes |  |
| `assetname` | `string` | Yes |  |
| `activitycategorycode` | `string` | Yes |  |
| `activitycode` | `string` | Yes |  |
| `activityname` | `string` | Yes |  |
| `activitytype` | `string` | Yes |  |
| `interventioncode` | `string` | Yes |  |
| `fullinterventioncode` | `string` | Yes |  |
| `interventionname` | `string` | Yes |  |
| `interventionreference1` | `string` | Yes |  |
| `interventionreference2` | `string` | Yes |  |
| `createddate_time` | `timestamp` | Yes |  |
| `duedate_time` | `timestamp` | Yes |  |
| `completeddate_time` | `timestamp` | Yes |  |
| `createddate` | `date` | Yes |  |
| `duedate` | `date` | Yes |  |
| `completeddate` | `date` | Yes |  |
| `completedstatus` | `string` | Yes |  |
| `Date` | `date` | Yes |  |
| `DateKey` | `bigint` | Yes |  |
| `Day of Week` | `string` | Yes |  |
| `Year` | `bigint` | Yes |  |
| `Quarter` | `string` | Yes |  |
| `Week Number` | `bigint` | Yes |  |
| `priority` | `string` | Yes |  |
| `KPI_Criticality` | `string` | Yes |  |
| `ResponseValue_ScheduleInterval` | `bigint` | Yes |  |
| `Response_IntervalUnit` | `string` | Yes |  |
| `QAReview-DidJobResultinITSassettobedown` | `string` | Yes |  |
| `Total_Down_Time_Hrs` | `decimal(10,0)` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
