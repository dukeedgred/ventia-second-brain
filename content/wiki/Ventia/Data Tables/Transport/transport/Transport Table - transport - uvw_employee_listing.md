---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport
table-name: uvw_employee_listing
full-name: transport_dev.transport.uvw_employee_listing
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport]
---

# Transport Table - transport - uvw_employee_listing

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_employee_listing` |
| Full name | `transport_dev.transport.uvw_employee_listing` |
| Catalog | `transport_dev` |
| Schema | `transport` |
| Contract/schema | `transport` |
| Table type | VIEW |
| Column count | 15 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | bhupesh.balani@ventia.com |
| Refresh/freshness | Created: 2025-05-06T02:31:44.982Z; Last altered: 2025-05-06T02:31:44.982Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
SELECT PERNR as Personnel_Number, ENAME as Employee_Name, ENDDA as End_Date, BEGDA as Start_Date, AEDTM as Changed_On, UNAME as Changed_By, BUKRS as Co_Code, WERKS as Personnel_Area, PERSG as Employee_Group, PERSK as Employee_Subgroup, ABKRS as Payroll_Area, string(int(KOSTL)) as Cost_Centre_ID, left(int(KOSTL),5) as PC_ID, PLANS as Position, STELL as Job
from staged.stg_sap_hana_cf_sap_ecc.pa0001 s
inner join transport_dev.transport.uvw_pc_masterdata t 
ON left(int(KOSTL),5) = t.PC_ID
where s.deleted_in_source =0
UNION ALL
SELECT PERNR as Personnel_Number, ENAME as Employee_Name, ENDDA as End_Date, BEGDA as Start_Date, AEDTM as Changed_On, UNAME as Changed_By, BUKRS as Co_Code, WERKS as Personnel_Area, PERSG as Employee_Group, PERSK as Employee_Subgroup, ABKRS as Payroll_Area, string(int(KOSTL)) as Cost_Centre_ID, left(int(KOSTL),5) as PC_ID, PLANS as Position, STELL as Job
from staged.stg_sap_hana_cf_sap_ecc.pa0001 s
where left(int(KOSTL),5)=90240 and s.deleted_in_source =0
UNION ALL
SELECT PERNR as Personnel_Number, ENAME as Employee_Name, ENDDA as End_Date, BEGDA as Start_Date, AEDTM as Changed_On, UNAME as Changed_By, BUKRS as Co_Code, WERKS as Personnel_Area, PERSG as Employee_Group, PERSK as Employee_Subgroup, ABKRS as Payroll_Area, string(int(KOSTL)) as Cost_Centre_ID, left(int(KOSTL),5) as PC_ID, PLANS as Position, STELL as Job
from staged.stg_sap_hana_cf_sap_ecc.pa0001 s
where left(int(KOSTL),5)=90050 and s.deleted_in_source =0
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Personnel_Number` | `string` | No | Personnel Number |
| `Employee_Name` | `string` | Yes | Formatted Name of Employee or Applicant |
| `End_Date` | `string` | No | End Date |
| `Start_Date` | `string` | No | Start Date |
| `Changed_On` | `string` | Yes | Last Changed On |
| `Changed_By` | `string` | Yes | Name of Person Who Changed Object |
| `Co_Code` | `string` | Yes | Company Code |
| `Personnel_Area` | `string` | Yes | Personnel Area |
| `Employee_Group` | `string` | Yes | Employee Group |
| `Employee_Subgroup` | `string` | Yes | Employee Subgroup |
| `Payroll_Area` | `string` | Yes | Payroll Area |
| `Cost_Centre_ID` | `string` | Yes |  |
| `PC_ID` | `string` | Yes |  |
| `Position` | `string` | Yes | Position |
| `Job` | `string` | Yes | Job |

## Related Pages

- [[Transport Contract Tables - transport]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
