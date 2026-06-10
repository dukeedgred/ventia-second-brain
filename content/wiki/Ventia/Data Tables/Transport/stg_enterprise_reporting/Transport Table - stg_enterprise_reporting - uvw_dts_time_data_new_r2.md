---
type: data-table
topic: Ventia
sector: Transport
contract-schema: stg_enterprise_reporting
table-name: uvw_dts_time_data_new_r2
full-name: transport_dev.stg_enterprise_reporting.uvw_dts_time_data_new_r2
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, stg-enterprise-reporting]
---

# Transport Table - stg_enterprise_reporting - uvw_dts_time_data_new_r2

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_dts_time_data_new_r2` |
| Full name | `transport_dev.stg_enterprise_reporting.uvw_dts_time_data_new_r2` |
| Catalog | `transport_dev` |
| Schema | `stg_enterprise_reporting` |
| Contract/schema | `stg_enterprise_reporting` |
| Table type | VIEW |
| Column count | 53 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | bhupesh.balani@ventia.com |
| Refresh/freshness | Created: 2025-05-01T01:42:11.203Z; Last altered: 2025-05-01T01:42:11.203Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
SELECT DISTINCT 
  s.CREATEDAT, s.CREATEDBY, s.MODIFIEDAT, s.MODIFIEDBY, s.CUID_ID, s.PERNR, s.PAYROLL_AREA, 
  s.TIMESHEET_DATE, s.VERSION, s.TIMEIN, s.TIMEOUT, s.ATT_ABS_CODE, s.ATT_ABS_DESC, 
  s.ATTABS_TYPE, s.DAY, s.HOURS_REC, s.CO_TYPE, s.CO_CODE, s.CO_DESC, s.CO_CODE2, 
  s.CO_DESC2, s.CAUSE_CODE, s.CAUSE_DESC, s.IS_HIGHER_DUTY, s.PREV_DAY, s.EMPL_FULLNAME, 
  s.TIME_SLICE_STATUS, s.LINE_MGR_APPROVER, s.LINE_MGR_FULLNAME, s.DEL_MGR_APPROVER, 
  s.DEL_MGR_FULLNAME, s.ESCALATION_MGR, s.ESCALATION_MGR_FULLNAME, s.POSTING_STATUS, 
  s.PLANNEDHOURS, s.PLANNEDBREAKSTART, s.PLANNEDBREAKEND, s.PROFIT_CENTRE, s.SUBMITTEDON, 
  s.SUBMITTEDBY, s.APPROVEDON, s.APPROVEDBY, s.UNIQUEKEY, s.PST_PSA, s.PST_PSA_DESC, 
  s.EMPLOYEE_SUBGROUP, s.POSTING_STATUS_REASON, s.SHORTTEXT, s.ISRETRO, s.ISONBEHALF, s.deleted_in_source, 
  CONCAT(S.CUID_ID, s.VERSION) as LookUp, 
  CASE 
    WHEN CONCAT(s.CUID_ID, s.VERSION) = Max_Version.LookUp THEN True 
    ELSE False 
  END AS LatestRecord
FROM 
  staged_dev.stg_hana_cf_timesheet_db.timesheetservice_timedetailsview s
LEFT JOIN (
  SELECT 
    t.CUID_ID, MAX(t.VERSION) as MaxVersion, 
    CONCAT(t.CUID_ID, MAX(t.VERSION)) as LookUp
  FROM 
    staged_dev.stg_hana_cf_timesheet_db.timesheetservice_timedetailsview t
  WHERE 
    t.deleted_in_source = 0
  GROUP BY 
    t.CUID_ID
) AS Max_Version
ON 
  CONCAT(s.CUID_ID, s.VERSION) = Max_Version.LookUp
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

## Related Pages

- [[Transport Contract Tables - stg_enterprise_reporting]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
