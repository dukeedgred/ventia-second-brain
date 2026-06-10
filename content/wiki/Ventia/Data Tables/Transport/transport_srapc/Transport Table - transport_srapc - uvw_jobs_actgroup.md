---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_srapc
table-name: uvw_jobs_actgroup
full-name: transport_dev.transport_srapc.uvw_jobs_actgroup
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-srapc]
---

# Transport Table - transport_srapc - uvw_jobs_actgroup

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_jobs_actgroup` |
| Full name | `transport_dev.transport_srapc.uvw_jobs_actgroup` |
| Catalog | `transport_dev` |
| Schema | `transport_srapc` |
| Contract/schema | `transport_srapc` |
| Table type | VIEW |
| Column count | 15 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | jobs / work orders |
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2024-06-18T03:15:32.678Z; Last altered: 2024-07-18T20:30:52.87Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
SELECT
  vjob.id as `Job ID`,
  CASE
    WHEN activityname = 'Cycleways' THEN 'Pavement'
    WHEN activityname = 'Drainage - Culvert' THEN 'Drainage'
    WHEN activityname = 'Drainage - Open' THEN 'Drainage'
    WHEN activityname = 'Drainage - Pits' THEN 'Drainage'
    WHEN activityname = 'Footbridge' THEN 'Bridge and Tunnel'
    WHEN activityname = 'Kerb and Gutter' THEN 'Drainage'
    WHEN activityname = 'Longitudinal Linemarking' THEN 'Pavement'
    WHEN activityname = 'Median' THEN 'Drainage'
    WHEN activityname = 'Motorist Emergency Telephone Systems' THEN 'Traffic Facilities'
    WHEN activityname = 'Noise Walls' THEN 'Roadside Assets'
    WHEN activityname = 'Non-Pavement Delineators' THEN 'Pavement'
    WHEN activityname = 'Over Height Detection Systems' THEN 'Traffic Facilities'
    WHEN activityname = 'Over Speed Detection Systems' THEN 'Traffic Facilities'
    WHEN activityname = 'Overbridge' THEN 'Bridge and Tunnel'
    WHEN activityname = 'Pavement Marking' THEN 'Pavement'
    WHEN activityname = 'Rest Areas and Carparks' THEN 'Roadside Assets'
    WHEN activityname = 'Road Lighting' THEN 'Traffic Facilities'
    WHEN activityname = 'Road Related Bus Assets' THEN 'Traffic Facilities'
    WHEN activityname = 'Roads - Flexible Pavements' THEN 'Pavement'
    WHEN activityname = 'Roads - Rigid Pavements' THEN 'Pavement'
    WHEN activityname = 'Roadside Landscaping' THEN 'Vegetation Control'
    WHEN activityname = 'Safety Barriers' THEN 'Roadside Assets'
    WHEN activityname = 'School Zone Signs' THEN 'Traffic Facilities'
    WHEN activityname = 'Signs' THEN 'Roadside Assets'
    WHEN activityname = 'Slopes and Batters' THEN 'Slope Stability'
    WHEN activityname = 'Traffic Control Signals' THEN 'Traffic Facilities'
    WHEN activityname = 'Traffic Monitoring Units' THEN 'Traffic Facilities'
    WHEN activityname = 'Transport Network Support' THEN 'Incident'
    WHEN activityname = 'Vacant Land' THEN 'Vegetation Control'
    WHEN activityname = 'Variable Message Signs' THEN 'Traffic Facilities'
    ELSE 'Other'
  END AS `Asset Group`,
  activitycode AS `TMP Number`,
  interventionname,
  activityname as `Activity Name`,
  priority as `Priority`,
  substring(
    WKT,
    instr(WKT, '-'),
    (instr(WKT, ')') - instr(WKT, '-'))
  ) as Latitude, -- to be fixed later after Databricks issue resolution
  substring(
    WKT,
    instr(WKT, '(') + 1,
    (instr(WKT, ' -') - instr(WKT, '(') - 1)
  ) as Longitude,  -- to be fixed later after Databricks issue resolution
  from_utc_timestamp(to_timestamp(createddate), 'Australia/Sydney') as `Created Date`,
  CONCAT(
    substring(
      from_utc_timestamp(to_timestamp(createddate), 'Australia/Sydney'),
      1,
      4
    ),
    '.',
    substring(
      from_utc_timestamp(to_timestamp(createddate), 'Australia/Sydney'),
      6,
      2
    )
  ) as `Created Month`,
  from_utc_timestamp(to_timestamp(duedate), 'Australia/Sydney') as `Due Date`,
  completedstatus as `Status`,
  from_utc_timestamp(to_timestamp(completeddate), 'Australia/Sydney') as `Rectified Date`,
  currentworkflowitemname as `Current Workflow Status Name`,
  from_utc_timestamp(to_timestamp(duedate), 'Australia/Sydney') as `DueDate`
FROM
  ext_mssql_asset_vision_ven_rms.dbo.vjob
where
  contract = 'SRAP-C'
order by
  vjob.id
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Job ID` | `int` | Yes |  |
| `Asset Group` | `string` | No |  |
| `TMP Number` | `string` | Yes |  |
| `interventionname` | `string` | Yes |  |
| `Activity Name` | `string` | Yes |  |
| `Priority` | `string` | Yes |  |
| `Latitude` | `string` | Yes |  |
| `Longitude` | `string` | Yes |  |
| `Created Date` | `timestamp` | Yes |  |
| `Created Month` | `string` | Yes |  |
| `Due Date` | `timestamp` | Yes |  |
| `Status` | `string` | Yes |  |
| `Rectified Date` | `timestamp` | Yes |  |
| `Current Workflow Status Name` | `string` | Yes |  |
| `DueDate` | `timestamp` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_srapc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
