---
type: data-table
topic: Ventia
sector: Transport
contract-schema: stg_enterprise_reporting
table-name: uvw_sap_open_commitment_line_items_with_pur_grp
full-name: transport_dev.stg_enterprise_reporting.uvw_sap_open_commitment_line_items_with_pur_grp
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, stg-enterprise-reporting]
---

# Transport Table - stg_enterprise_reporting - uvw_sap_open_commitment_line_items_with_pur_grp

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_sap_open_commitment_line_items_with_pur_grp` |
| Full name | `transport_dev.stg_enterprise_reporting.uvw_sap_open_commitment_line_items_with_pur_grp` |
| Catalog | `transport_dev` |
| Schema | `stg_enterprise_reporting` |
| Contract/schema | `stg_enterprise_reporting` |
| Table type | VIEW |
| Column count | 51 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | commercial / finance |
| Owner/SME | bhupesh.balani@ventia.com |
| Refresh/freshness | Created: 2025-10-22T06:47:41.889Z; Last altered: 2025-10-22T06:47:41.889Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
select s.*, t.KNTTP as Account_Assignment_Category
from corporate_dev.enterprise_reporting.uvw_sap_open_commitment_line_items s
 left join (
  select ebeln, knttp
  from staged.stg_sap_hana_cf_sap_ecc.ekpo
  GROUP by EBELN, KNTTP
) t
on s.reference_document_number=t.EBELN 
where s.reference_document_category='POrd'
and total_value_in_transaction_currency <>0
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `reference_document_category` | `string` | Yes |  |
| `reference_document_number` | `string` | No |  |
| `reference_document_item` | `int` | Yes |  |
| `account_assignment_number` | `int` | Yes |  |
| `deadline_item` | `int` | Yes |  |
| `reference_document_type` | `string` | No | Reference document type |
| `vendor_number` | `string` | No |  |
| `vendor_name` | `string` | Yes | Name 1 |
| `object_number` | `string` | No | Object number |
| `co_key_subnumber` | `int` | Yes |  |
| `service_order` | `string` | No |  |
| `network` | `string` | No |  |
| `cost_centre` | `string` | No |  |
| `wbs_element` | `string` | No |  |
| `profit_centre` | `int` | Yes |  |
| `purchasing_group` | `string` | No |  |
| `reference_procedure` | `string` | No | Reference procedure |
| `fiscal_year` | `int` | Yes |  |
| `value_type` | `int` | Yes |  |
| `value_type_text` | `string` | Yes | Short Text for Fixed Values |
| `cost_element` | `string` | Yes |  |
| `debit_credit_indicator` | `string` | Yes | Debit/credit indicator |
| `user_name` | `string` | Yes | User Name |
| `document_date` | `string` | No |  |
| `expected_debit_date` | `string` | No |  |
| `period` | `int` | Yes |  |
| `company_code` | `string` | Yes | Company Code |
| `controlling_area` | `string` | Yes | Controlling Area |
| `material_number` | `string` | Yes |  |
| `material_group` | `string` | Yes |  |
| `segment_text` | `string` | Yes | Segment text |
| `planned_quantity` | `decimal(15,3)` | Yes | Planned quantity |
| `unit_of_measure` | `string` | Yes | External Unit of Measurement in Commercial Format (3-Char.) |
| `total_quantity` | `decimal(15,3)` | Yes | Total Quantity |
| `exchange_rate` | `decimal(9,5)` | Yes | Exchange Rate |
| `planned_value_in_local_currency` | `decimal(15,2)` | Yes | Planned value in local currency |
| `total_value_in_local_currency` | `decimal(15,2)` | Yes | Total value in local currency |
| `transaction_currency` | `string` | Yes | Transaction Currency |
| `planned_value_in_transaction_currency` | `decimal(15,2)` | Yes | Planned value in transaction currency |
| `total_value_in_transaction_currency` | `decimal(15,2)` | Yes | Total Value in Transaction Currency |
| `controlling_area_currency` | `string` | No |  |
| `planned_value_in_controlling_area_currency` | `decimal(15,2)` | Yes | Planned value in controlling area currency |
| `total_value_in_controlling_area_currency` | `decimal(15,2)` | Yes | Total Value in Controlling Area Currency |
| `planned_value_in_object_currency` | `decimal(15,2)` | Yes | Planned value in object currency |
| `total_value_in_object_currency` | `decimal(15,2)` | Yes | Total Value in Object Currency |
| `planned_value_in_ledger_currency` | `decimal(15,2)` | Yes | Planned value in ledger currency |
| `total_value_in_ledger_currency` | `decimal(15,2)` | Yes | Total value in ledger currency |
| `deletion_indicator` | `string` | Yes | Deletion Indicator in Purchasing Document |
| `hash_nkey` | `string` | Yes |  |
| `SDI_CHANGE_TIME` | `timestamp` | Yes |  |
| `Account_Assignment_Category` | `string` | Yes | Account Assignment Category |

## Related Pages

- [[Transport Contract Tables - stg_enterprise_reporting]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
