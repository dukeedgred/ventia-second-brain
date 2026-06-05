---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_nel
table-name: uvw_kpi_sys_av_devices
full-name: transport_dev.transport_nel.uvw_kpi_sys_av_devices
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-table, databricks, transport-nel, kpi, asset, device]
---

# Transport Table - transport_nel - uvw_kpi_sys_av_devices

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_kpi_sys_av_devices` |
| Full name | `transport_dev.transport_nel.uvw_kpi_sys_av_devices` |
| Catalog | `transport_dev` |
| Schema | `transport_nel` |
| Contract/schema | `transport_nel` |
| Table type | VIEW |
| Column count | 12 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | KPI asset/device |
| Related tables/reports | `utbl_kpi_work_orders`, `utbl_kpi_assets` |

## View Query

```sql
(
SELECT
  wo.Asset,
  CASE
    WHEN wo.Asset = 'TIM' THEN 'Tunnel Information Sign'
    WHEN wo.Asset = 'VSL' THEN 'Variable Speed Limit Sign'
    WHEN wo.Asset = 'LUM' THEN 'Lane Use Signs'
    WHEN wo.Asset = 'VMS' THEN 'Variable Message Sign'
    ELSE ar.`Asset Type`
  END as AssetType,
  CASE
    WHEN AssetType = 'Tunnel Information Sign' THEN 35
    WHEN AssetType = 'Variable Speed Limit Sign' THEN 35
    WHEN AssetType = 'Lane Use Signs' THEN 35
    WHEN AssetType = 'Variable Message Sign' THEN 36
  END as `KPI_No`,
  wo.Description,
  `Work Type`,
  `Actual Start`,
  `Actual Finish`,
  TO_TIMESTAMP(`Actual Start`, 'd/M/yyyy H:m') as actual_start_timestamp,
  TO_TIMESTAMP(`Actual Finish`, 'd/M/yyyy H:m') as actual_finish_timestamp,
  DATE_FORMAT(actual_finish_timestamp, 'dMMyyyy') as start_datekey,
  CASE
    WHEN `Work Type` = 'PM' THEN DATEDIFF(minute, actual_start_timestamp, actual_finish_timestamp)
  END as Planned_Downtime,
  CASE
    WHEN `Work Type` = 'CM' THEN DATEDIFF(minute, actual_start_timestamp, actual_finish_timestamp)
  END as Unplanned_Downtime
FROM
  utbl_kpi_work_orders wo
    LEFT JOIN utbl_kpi_assets ar
      ON wo.Asset = ar.Asset
WHERE
  Status = 'COMP')
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

- [[Transport Contract Tables - transport_nel]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
