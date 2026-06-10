---
type: data-table
topic: Ventia
sector: Transport
contract-schema: stg_enterprise_reporting
table-name: uvw_sap_employee_master_data
full-name: transport_dev.stg_enterprise_reporting.uvw_sap_employee_master_data
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, stg-enterprise-reporting]
---

# Transport Table - stg_enterprise_reporting - uvw_sap_employee_master_data

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_sap_employee_master_data` |
| Full name | `transport_dev.stg_enterprise_reporting.uvw_sap_employee_master_data` |
| Catalog | `transport_dev` |
| Schema | `stg_enterprise_reporting` |
| Contract/schema | `stg_enterprise_reporting` |
| Table type | VIEW |
| Column count | 24 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | commercial / finance |
| Owner/SME | bhupesh.balani@ventia.com |
| Refresh/freshness | Created: 2025-07-01T13:29:54.544Z; Last altered: 2025-07-01T13:29:54.544Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
SELECT 
PERNR as person,
SNAME as last_first_name,
ENAME as employee_name,
BEGDA as start_date,
ENDDA as end_date,
AEDTM as changed_on,
UNAME as changed_by,
BUKRS as company_code,
WERKS as personnel_area,
PERSG as ee_group,
PERSK as ee_subgroup,
VDSK1 as org_key,
GSBER as business_area,
BTRTL as pers_subarea,
ABKRS as payroll_area,
ANSVH as work_contract,
CAST(INT(KOSTL) as STRING) as cost_centre,
LEFT(CAST(INT(KOSTL) as STRING),5) as profit_centre,
ORGEH as org_unit,
PLANS as position,
STELL as job,
otype as object_type,
SBMOD as group,
KOKRS as co_area
from staged.stg_sap_hana_cf_sap_ecc.pa0001
where deleted_in_source=0
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `person` | `string` | Yes | Personnel Number |
| `last_first_name` | `string` | Yes | Employee's Name (Sortable by LAST NAME FIRST NAME) |
| `employee_name` | `string` | Yes | Formatted Name of Employee or Applicant |
| `start_date` | `string` | Yes | Start Date |
| `end_date` | `string` | Yes | End Date |
| `changed_on` | `string` | Yes | Last Changed On |
| `changed_by` | `string` | Yes | Name of Person Who Changed Object |
| `company_code` | `string` | Yes | Company Code |
| `personnel_area` | `string` | Yes | Personnel Area |
| `ee_group` | `string` | Yes | Employee Group |
| `ee_subgroup` | `string` | Yes | Employee Subgroup |
| `org_key` | `string` | Yes | Organizational Key |
| `business_area` | `string` | Yes | Business Area |
| `pers_subarea` | `string` | Yes | Personnel Subarea |
| `payroll_area` | `string` | Yes | Payroll Area |
| `work_contract` | `string` | Yes | Work Contract |
| `cost_centre` | `string` | Yes |  |
| `profit_centre` | `string` | Yes |  |
| `org_unit` | `string` | Yes | Organizational Unit |
| `position` | `string` | Yes | Position |
| `job` | `string` | Yes | Job |
| `object_type` | `string` | Yes | Object Type |
| `group` | `string` | Yes | Administrator Group |
| `co_area` | `string` | Yes | Controlling Area |

## Related Pages

- [[Transport Contract Tables - stg_enterprise_reporting]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
