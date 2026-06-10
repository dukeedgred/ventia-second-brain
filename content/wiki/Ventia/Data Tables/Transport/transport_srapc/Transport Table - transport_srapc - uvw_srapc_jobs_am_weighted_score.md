---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_srapc
table-name: uvw_srapc_jobs_am_weighted_score
full-name: transport_dev.transport_srapc.uvw_srapc_jobs_am_weighted_score
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-srapc]
---

# Transport Table - transport_srapc - uvw_srapc_jobs_am_weighted_score

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_srapc_jobs_am_weighted_score` |
| Full name | `transport_dev.transport_srapc.uvw_srapc_jobs_am_weighted_score` |
| Catalog | `transport_dev` |
| Schema | `transport_srapc` |
| Contract/schema | `transport_srapc` |
| Table type | VIEW |
| Column count | 21 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | jobs / work orders |
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2024-06-18T05:03:09.081Z; Last altered: 2024-07-18T20:31:03.433Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
SELECT 
    id,
    assetcode,
    priority,
    activitycategorycode,
    activityname,
    interventionname,
    createddate,
    duedate,
    completeddate,
    completedstatus,
    inspectiontypename,
    inspectionid,
    WKT as spatialinfo,
    mergedjobid,
    substring(WKT, instr(WKT, '-'), ( instr(WKT, ')') - instr(WKT, '-') )) as Latitude,
    substring(WKT, instr(WKT, '(') + 1, ( instr(WKT, ' -') - instr(WKT, '(') - 1 )) as Longitude,
    -- Priority Weighted Score Calculation
    CASE 
        WHEN priority = 'Low' THEN 0.6 * 0
        WHEN priority = 'Medium' THEN 0.6 * 25
        WHEN priority = 'High' THEN 0.6 * 50
        WHEN priority = 'Urgent' THEN 0.6 * 100
        ELSE 0
    END AS priority_score,
    -- Overdue Weighted Score Calculation
    CASE 
        WHEN GETDATE() > duedate THEN 0.25 * 100
        ELSE 0
    END AS overdue_score,
    -- Customer Requests Weighted Score Calculation
    CASE 
        WHEN inspectiontypename LIKE 'Customer Request (VEN)' THEN 0.1 * 100
        ELSE 0
    END AS customer_request_score,
    -- Age Weighted Score Calculation
    CASE 
        WHEN DATEDIFF(day, createddate, GETDATE()) >= 365 THEN 0.05 * 100
        WHEN DATEDIFF(day, createddate, GETDATE()) >= 182 AND DATEDIFF(day, createddate, GETDATE()) < 365 THEN 0.05 * 80
        WHEN DATEDIFF(day, createddate, GETDATE()) >= 90 AND DATEDIFF(day, createddate, GETDATE()) < 182 THEN 0.05 * 60
        WHEN DATEDIFF(day, createddate, GETDATE()) >= 60 AND DATEDIFF(day, createddate, GETDATE()) < 90 THEN 0.05 * 40
        WHEN DATEDIFF(day, createddate, GETDATE()) >= 30  AND DATEDIFF(day, createddate, GETDATE()) < 60 THEN 0.05 * 20
        ELSE 0
    END AS age_score,
    -- Total Weighted Suitability Score Calculation
    (priority_score + overdue_score + customer_request_score + age_score) AS weighted_suitability_score
FROM 
    transport_dev.transport_srapc.uvw_job
WHERE 
    completedstatus = 'Open'
    AND (MergedJobID = "" or MergedJobID is null)
ORDER BY 
    weighted_suitability_score DESC
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `id` | `int` | Yes |  |
| `assetcode` | `string` | Yes |  |
| `priority` | `string` | Yes |  |
| `activitycategorycode` | `string` | Yes |  |
| `activityname` | `string` | Yes |  |
| `interventionname` | `string` | Yes |  |
| `createddate` | `timestamp` | Yes |  |
| `duedate` | `timestamp` | Yes |  |
| `completeddate` | `timestamp` | Yes |  |
| `completedstatus` | `string` | Yes |  |
| `inspectiontypename` | `string` | Yes |  |
| `inspectionid` | `int` | Yes |  |
| `spatialinfo` | `string` | Yes |  |
| `mergedjobid` | `int` | Yes |  |
| `Latitude` | `string` | Yes |  |
| `Longitude` | `string` | Yes |  |
| `priority_score` | `decimal(11,1)` | Yes |  |
| `overdue_score` | `decimal(12,2)` | Yes |  |
| `customer_request_score` | `decimal(11,1)` | Yes |  |
| `age_score` | `decimal(12,2)` | Yes |  |
| `weighted_suitability_score` | `decimal(15,2)` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_srapc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
