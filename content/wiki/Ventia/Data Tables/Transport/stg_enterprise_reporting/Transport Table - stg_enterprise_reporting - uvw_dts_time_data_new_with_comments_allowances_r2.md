---
type: data-table
topic: Ventia
sector: Transport
contract-schema: stg_enterprise_reporting
table-name: uvw_dts_time_data_new_with_comments_allowances_r2
full-name: transport_dev.stg_enterprise_reporting.uvw_dts_time_data_new_with_comments_allowances_r2
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, stg-enterprise-reporting]
---

# Transport Table - stg_enterprise_reporting - uvw_dts_time_data_new_with_comments_allowances_r2

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_dts_time_data_new_with_comments_allowances_r2` |
| Full name | `transport_dev.stg_enterprise_reporting.uvw_dts_time_data_new_with_comments_allowances_r2` |
| Catalog | `transport_dev` |
| Schema | `stg_enterprise_reporting` |
| Contract/schema | `stg_enterprise_reporting` |
| Table type | VIEW |
| Column count | 55 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | bhupesh.balani@ventia.com |
| Refresh/freshness | Created: 2025-05-13T04:37:09.926Z; Last altered: 2025-05-13T04:37:09.926Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
SELECT DISTINCT 
  s.*,
  t.allowances,
  u.comment
FROM 
  transport_dev.stg_enterprise_reporting.uvw_DTS_Time_Data_New_R2 s
LEFT JOIN (
    transport_dev.stg_enterprise_reporting.uvw_DTS_Allowances_Data_r2 t
  )  ON 
    concat(s.CUID_ID, s.VERSION) = concat(t.CUID_ID, t.VERSION)
LEFT JOIN (
    transport_dev.stg_enterprise_reporting.uvw_dts_comments_data_R2 u
  )  ON 
    concat(s.CUID_ID, s.VERSION) = concat(u.CUID_ID, u.VERSION)
WHERE 
  s.deleted_in_source = 0
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `CREATEDAT` | `timestamp` | Yes |  |
| `CREATEDBY` | `string` | Yes |  |
| `MODIFIEDAT` | `timestamp` | Yes |  |
| `MODIFIEDBY` | `string` | Yes |  |
| `CUID_ID` | `string` | No |  |
| `PERNR` | `string` | No |  |
| `PAYROLL_AREA` | `string` | Yes |  |
| `TIMESHEET_DATE` | `date` | No |  |
| `VERSION` | `int` | No |  |
| `TIMEIN` | `timestamp` | Yes |  |
| `TIMEOUT` | `timestamp` | Yes |  |
| `ATT_ABS_CODE` | `string` | Yes |  |
| `ATT_ABS_DESC` | `string` | Yes |  |
| `ATTABS_TYPE` | `string` | Yes |  |
| `DAY` | `string` | Yes |  |
| `HOURS_REC` | `timestamp` | Yes |  |
| `CO_TYPE` | `string` | Yes |  |
| `CO_CODE` | `string` | Yes |  |
| `CO_DESC` | `string` | Yes |  |
| `CO_CODE2` | `string` | Yes |  |
| `CO_DESC2` | `string` | Yes |  |
| `CAUSE_CODE` | `string` | Yes |  |
| `CAUSE_DESC` | `string` | Yes |  |
| `IS_HIGHER_DUTY` | `boolean` | Yes |  |
| `PREV_DAY` | `boolean` | Yes |  |
| `EMPL_FULLNAME` | `string` | Yes |  |
| `TIME_SLICE_STATUS` | `string` | Yes |  |
| `LINE_MGR_APPROVER` | `string` | Yes |  |
| `LINE_MGR_FULLNAME` | `string` | Yes |  |
| `DEL_MGR_APPROVER` | `string` | Yes |  |
| `DEL_MGR_FULLNAME` | `string` | Yes |  |
| `ESCALATION_MGR` | `string` | Yes |  |
| `ESCALATION_MGR_FULLNAME` | `string` | Yes |  |
| `POSTING_STATUS` | `string` | Yes |  |
| `PLANNEDHOURS` | `timestamp` | Yes |  |
| `PLANNEDBREAKSTART` | `timestamp` | Yes |  |
| `PLANNEDBREAKEND` | `timestamp` | Yes |  |
| `PROFIT_CENTRE` | `string` | Yes |  |
| `SUBMITTEDON` | `timestamp` | Yes |  |
| `SUBMITTEDBY` | `string` | Yes |  |
| `APPROVEDON` | `timestamp` | Yes |  |
| `APPROVEDBY` | `string` | Yes |  |
| `UNIQUEKEY` | `string` | Yes |  |
| `PST_PSA` | `string` | Yes |  |
| `PST_PSA_DESC` | `string` | Yes |  |
| `EMPLOYEE_SUBGROUP` | `string` | Yes |  |
| `POSTING_STATUS_REASON` | `string` | Yes |  |
| `SHORTTEXT` | `string` | Yes |  |
| `ISRETRO` | `boolean` | Yes |  |
| `ISONBEHALF` | `boolean` | Yes |  |
| `deleted_in_source` | `int` | Yes |  |
| `LookUp` | `string` | No |  |
| `LatestRecord` | `boolean` | No |  |
| `allowances` | `string` | Yes |  |
| `comment` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - stg_enterprise_reporting]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
