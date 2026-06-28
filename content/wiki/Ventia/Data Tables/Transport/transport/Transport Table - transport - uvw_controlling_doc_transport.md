---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport
table-name: uvw_controlling_doc_transport
full-name: transport_dev.transport.uvw_controlling_doc_transport
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport]
---

# Transport Table - transport - uvw_controlling_doc_transport

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_controlling_doc_transport` |
| Full name | `transport_dev.transport.uvw_controlling_doc_transport` |
| Catalog | `transport_dev` |
| Schema | `transport` |
| Contract/schema | `transport` |
| Table type | VIEW |
| Column count | 56 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | bhupesh.balani@ventia.com |
| Refresh/freshness | Created: 2026-02-11T07:19:58.866Z; Last altered: 2026-02-11T07:19:58.866Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
with sap_controlling_doc_data_transport as(
select *
from corporate_dev.bai.uvw_sap_controlling_doc_updates s
inner join transport_dev.transport.uvw_pc_masterdata t 
ON s.profit_centre = t.PC_ID
UNION all
select *
from corporate_dev.bai.uvw_sap_controlling_doc_updates s
inner join transport_dev.transport.uvw_pc_masterdata t 
ON s.profit_centre = '90240'
UNION all
select *
from corporate_dev.bai.uvw_sap_controlling_doc_updates s
inner join transport_dev.transport.uvw_pc_masterdata t 
ON s.profit_centre = '90050'
)
select *
from sap_controlling_doc_data_transport
where posting_date>='2026-01-01'
and posting_date<='2026-01-31'
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `company_code` | `string` | Yes | Company Code |
| `profit_centre` | `string` | Yes |  |
| `cost_centre` | `string` | Yes |  |
| `wbs_element` | `string` | Yes |  |
| `order_number` | `string` | Yes |  |
| `network_number` | `string` | Yes |  |
| `activity_number` | `string` | Yes |  |
| `document_date` | `date` | Yes |  |
| `posting_date` | `date` | Yes |  |
| `document_number` | `string` | No | Document Number |
| `reference_document_number` | `string` | Yes | Reference Document Number |
| `cost_element` | `string` | Yes |  |
| `line_item_number` | `string` | No |  |
| `total_quantity` | `decimal(15,3)` | Yes | Total quantity entered |
| `amount_in_object_currency` | `decimal(15,2)` | Yes | Total Value in Object Currency |
| `total_value_in_transaction_currency` | `decimal(15,2)` | Yes | Total Value in Transaction Currency |
| `transaction_currency` | `string` | Yes | Transaction Currency |
| `unit_of_measure` | `string` | Yes | Unit of Measure |
| `purchase_order` | `string` | Yes | Purchasing Document Number |
| `purchase_order_line_item` | `string` | Yes |  |
| `employee_number` | `string` | Yes |  |
| `document_header_text` | `string` | Yes | Document Header Text |
| `document_text` | `string` | Yes | Segment text |
| `Document_type_FI_reference_document` | `string` | Yes | Document type of FI reference document |
| `user_name` | `string` | Yes | User Name |
| `document_creation_date` | `date` | Yes |  |
| `system_date_time` | `timestamp` | Yes |  |
| `ods_id` | `char(36)` | Yes |  |
| `processing_id` | `bigint` | Yes |  |
| `processing_id_item` | `bigint` | Yes |  |
| `ods_created_by` | `varchar(250)` | Yes |  |
| `ods_created_on` | `timestamp` | Yes |  |
| `ods_updated_by` | `varchar(250)` | Yes |  |
| `ods_updated_on` | `timestamp` | Yes |  |
| `ods_is_deleted` | `boolean` | Yes |  |
| `businesskey_01` | `varchar(250)` | Yes |  |
| `PROFITCENTRE.Level_01` | `varchar(255)` | Yes |  |
| `PROFITCENTRE.Level_01.Key` | `varchar(255)` | Yes |  |
| `PROFITCENTRE.Level_02` | `varchar(255)` | Yes |  |
| `PROFITCENTRE.Level_02.Key` | `varchar(255)` | Yes |  |
| `PROFITCENTRE.Level_03` | `varchar(255)` | Yes |  |
| `PROFITCENTRE.Level_03.Key` | `varchar(255)` | Yes |  |
| `PROFITCENTRE.Level_04` | `varchar(255)` | Yes |  |
| `PROFITCENTRE.Level_04.Key` | `varchar(255)` | Yes |  |
| `PROFITCENTRE.Level_05` | `varchar(255)` | Yes |  |
| `PROFITCENTRE.Level_05.Key` | `varchar(255)` | Yes |  |
| `PROFITCENTRE.Level_06` | `varchar(255)` | Yes |  |
| `PROFITCENTRE.Level_06.Key` | `varchar(255)` | Yes |  |
| `PROFITCENTRE.Level_07` | `varchar(255)` | Yes |  |
| `PROFITCENTRE.Level_07.Key` | `varchar(255)` | Yes |  |
| `Base_Profit_Centre` | `varchar(255)` | Yes |  |
| `Base_Profit_Centre_Key` | `varchar(255)` | Yes |  |
| `Index` | `varchar(255)` | Yes |  |
| `archive_ready_for_deletion` | `boolean` | Yes |  |
| `archive_delete_schedule_datetime_AEST` | `timestamp` | Yes |  |
| `PC_ID` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
