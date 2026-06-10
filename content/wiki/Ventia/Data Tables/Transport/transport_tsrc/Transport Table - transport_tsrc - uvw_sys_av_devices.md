---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: uvw_sys_av_devices
full-name: transport_dev.transport_tsrc.uvw_sys_av_devices
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - uvw_sys_av_devices

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_sys_av_devices` |
| Full name | `transport_dev.transport_tsrc.uvw_sys_av_devices` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | VIEW |
| Column count | 12 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | huy.nguyen@ventia.com |
| Refresh/freshness | Created: 2026-04-15T05:08:07.637Z; Last altered: 2026-04-15T05:08:07.637Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
SELECT
wo.Asset
, CASE 
WHEN wo.Asset = 'TIM' THEN 'Tunnel Information Sign'
WHEN wo.Asset = 'VSL' THEN 'Variable Speed Limit Sign'
WHEN wo.Asset = 'LUM' THEN 'Lane Use Signs'
WHEN wo.Asset = 'VMS' THEN 'Variable Message Sign'
ELSE ar.`Asset Type`
END as AssetType
, CASE 
WHEN AssetType = 'Tunnel Information Sign' THEN 35
WHEN AssetType = 'Variable Speed Limit Sign' THEN 35
WHEN AssetType = 'Lane Use Signs' THEN 35
WHEN AssetType =  'Variable Message Sign' THEN 36
END as `KPI_No`
, wo.Description
, `Work Type`
, `Actual Start`
, `Actual Finish`
, TO_TIMESTAMP(`Actual Start`, 'd/M/yyyy H:m') as actual_start_timestamp
, TO_TIMESTAMP(`Actual Finish`, 'd/M/yyyy H:m') as actual_finish_timestamp
, DATE_FORMAT(actual_finish_timestamp, 'dMMyyyy') as start_datekey
, CASE WHEN `Work Type` = 'PM' 
THEN DATEDIFF(minute, actual_start_timestamp, actual_finish_timestamp) 
END as Planned_Downtime
, CASE WHEN `Work Type` = 'CM' 
THEN DATEDIFF(minute, actual_start_timestamp, actual_finish_timestamp) 
END as Unplanned_Downtime
FROM utbl_work_order wo
LEFT JOIN utbl_asset_register ar 
ON wo.Asset = ar.Asset
WHERE Status = 'COMP'
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Asset` | `string` | Yes |  |
| `AssetType` | `string` | Yes |  |
| `KPI_No` | `int` | Yes |  |
| `Description` | `string` | Yes |  |
| `Work Type` | `string` | Yes |  |
| `Actual Start` | `string` | Yes |  |
| `Actual Finish` | `string` | Yes |  |
| `actual_start_timestamp` | `timestamp` | Yes |  |
| `actual_finish_timestamp` | `timestamp` | Yes |  |
| `start_datekey` | `string` | Yes |  |
| `Planned_Downtime` | `bigint` | Yes |  |
| `Unplanned_Downtime` | `bigint` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
