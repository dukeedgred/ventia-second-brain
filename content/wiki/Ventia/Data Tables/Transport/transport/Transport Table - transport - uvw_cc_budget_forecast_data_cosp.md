---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport
table-name: uvw_cc_budget_forecast_data_cosp
full-name: transport_dev.transport.uvw_cc_budget_forecast_data_cosp
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport]
---

# Transport Table - transport - uvw_cc_budget_forecast_data_cosp

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_cc_budget_forecast_data_cosp` |
| Full name | `transport_dev.transport.uvw_cc_budget_forecast_data_cosp` |
| Catalog | `transport_dev` |
| Schema | `transport` |
| Contract/schema | `transport` |
| Table type | VIEW |
| Column count | 22 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | weather |
| Owner/SME | bhupesh.balani@ventia.com |
| Refresh/freshness | Created: 2025-02-17T05:58:08.08Z; Last altered: 2025-02-17T05:58:08.08Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
select BUKRS as Co_Code,  OBJNR as Object_Number, GJAHR as Fiscal_Year, VERSN as VERSION, int(KSTAR) as Cost_Element, BEKNZ as Debit_Credit_Indicator, TWAER as CURR, WTG001 as Jan, WTG002 as Feb, WTG003 as Mar, WTG004 as Apr, WTG005 as May, WTG006 as Jun, WTG007 as Jul, WTG008 as Aug, WTG009 as Sep, WTG010 as Oct, WTG011 as Nov, WTG012 as Dec, t.PC_ID, t.Cost_Object, s.SDI_CHANGE_TIME as Entry_Date
from staged.stg_sap_hana_cf_sap_ecc.cosp s
inner join transport_dev.transport.uvw_cc_master_data_csks t
on s.OBJNR=t.Object_Number
where s.deleted_in_source =0 and s.VERSN!="000"
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Co_Code` | `string` | Yes |  |
| `Object_Number` | `string` | No |  |
| `Fiscal_Year` | `string` | No |  |
| `VERSION` | `string` | No |  |
| `Cost_Element` | `int` | Yes |  |
| `Debit_Credit_Indicator` | `string` | No |  |
| `CURR` | `string` | No |  |
| `Jan` | `decimal(15,2)` | Yes |  |
| `Feb` | `decimal(15,2)` | Yes |  |
| `Mar` | `decimal(15,2)` | Yes |  |
| `Apr` | `decimal(15,2)` | Yes |  |
| `May` | `decimal(15,2)` | Yes |  |
| `Jun` | `decimal(15,2)` | Yes |  |
| `Jul` | `decimal(15,2)` | Yes |  |
| `Aug` | `decimal(15,2)` | Yes |  |
| `Sep` | `decimal(15,2)` | Yes |  |
| `Oct` | `decimal(15,2)` | Yes |  |
| `Nov` | `decimal(15,2)` | Yes |  |
| `Dec` | `decimal(15,2)` | Yes |  |
| `PC_ID` | `int` | Yes |  |
| `Cost_Object` | `string` | No |  |
| `Entry_Date` | `timestamp` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
