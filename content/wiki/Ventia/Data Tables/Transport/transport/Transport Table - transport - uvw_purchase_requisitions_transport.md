---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport
table-name: uvw_purchase_requisitions_transport
full-name: transport_dev.transport.uvw_purchase_requisitions_transport
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport]
---

# Transport Table - transport - uvw_purchase_requisitions_transport

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_purchase_requisitions_transport` |
| Full name | `transport_dev.transport.uvw_purchase_requisitions_transport` |
| Catalog | `transport_dev` |
| Schema | `transport` |
| Contract/schema | `transport` |
| Table type | VIEW |
| Column count | 67 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | commercial / finance |
| Owner/SME | bhupesh.balani@ventia.com |
| Refresh/freshness | Created: 2026-01-30T03:01:47.369Z; Last altered: 2026-01-30T03:01:47.369Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
select u.* except(u.hash_nkey, u.sdi_change_time)
from corporate_dev.edw.uvw_sap_purchase_requisitions u
inner join(
select purchase_requisition, profit_centre
from corporate_dev.edw.uvw_sap_purchase_requisition_account_assignments s
inner join transport_dev.transport.uvw_pc_masterdata t
on s.profit_centre=t.PC_ID
where deletion_indicator=false
union all
select distinct purchase_requisition, profit_centre
from corporate_dev.edw.uvw_sap_purchase_requisition_account_assignments s
where deletion_indicator=false
and s.profit_centre='90240'
union all
select distinct purchase_requisition, profit_centre
from corporate_dev.edw.uvw_sap_purchase_requisition_account_assignments s
where deletion_indicator=false
and s.profit_centre='90050'
group by
purchase_requisition, profit_centre
) as sector_PR
on u.purchase_requisition=sector_pr.purchase_requisition
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `purchase_requisition` | `string` | No | Unique identifier for a purchase requisition represented as a string. |
| `purchase_requisition_item` | `int` | Yes | Represents the sequential item number associated with a purchase requisition. |
| `requisition_document_type` | `string` | No | Represents the type classification of a purchase requisition document. |
| `requisition_document_category` | `string` | No | Indicates the category classification of a purchase requisition document. |
| `requisition_document_type_text` | `string` | No | Text description or label for the type classification of a purchase requisition document. |
| `deletion_indicator` | `string` | No | Indicates if the purchase requisition item is flagged for deletion. |
| `processing_status` | `string` | No | Represents the current state or progress level of processing associated with the purchase requisition item. |
| `processing_status_text` | `string` | Yes | Descriptive text providing details or explanation about the current processing status of the purchase requisition item. |
| `creation_indicator` | `string` | No | Represents a flag or marker indicating the creation status or origin of the purchase requisition item. |
| `creation_indicator_text` | `string` | Yes | Provides a detailed explanation or text description of the flag indicating the creation status or origin of the purchase requisition item. |
| `release_indicator` | `string` | No | Flag indicating the release status of the purchase requisition. |
| `release_state` | `string` | No | Denotes the current approval or release status of the purchase requisition, indicating whether it is pending, approved, or rejected. |
| `release_strategy` | `string` | No | Represents the strategy or method applied for determining the release or approval process of the purchase requisition. |
| `purchasing_group` | `string` | No | Represents the group or team responsible for procurement activities associated with the purchase requisition. |
| `purchasing_group_name` | `string` | Yes | Name or description of the group responsible for managing purchasing activities. |
| `created_by` | `string` | No | Represents the user or system responsible for initiating the creation of the purchase requisition. |
| `changed_on` | `date` | No | Represents the date when the purchase requisition was last modified or updated. |
| `requester_name` | `string` | No | Represents the name of the individual or entity requesting the purchase requisition. |
| `tracking_number` | `string` | No | Represents a unique identifier used for tracking and referencing the purchase requisition. |
| `requisition_short_text` | `string` | No | Short description or label providing concise details about the purchase requisition item. |
| `material_number` | `string` | No | Represents the unique identifier assigned to a specific material within the context of the purchase requisition. |
| `manufacturing_part_material_number` | `string` | No | Represents the unique material identification number associated with the manufacturing part. |
| `vendor_material_number` | `string` | No | Represents the unique identifier assigned by the vendor for a specific material. |
| `plant` | `string` | No | No information provided about this column; unable to generate a relevant comment. |
| `storage_location` | `string` | No | Represents the physical or virtual location where items associated with the purchase requisition are stored. |
| `material_group` | `string` | No | Represents the classification or grouping of materials associated with the purchase requisition item. |
| `supllying_plant` | `string` | No | No description available for the column 'supllying_plant'. Please provide further details or clarify. |
| `quantity` | `decimal(13,3)` | Yes | Represents the quantity requested for the purchase requisition item. |
| `unit_of_measure` | `string` | Yes | Commercial representation of the unit of measure |
| `price` | `decimal(11,2)` | Yes | Represents the monetary value associated with the purchase requisition item. |
| `request_date` | `date` | No | Indicates the date when the purchase requisition was formally requested or initiated. |
| `delivery_date` | `date` | No | Represents the date on which the purchase requisition item is scheduled or expected to be delivered. |
| `release_date` | `date` | No | Represents the date when the purchase requisition was approved or released. |
| `item_category` | `string` | Yes | Represents the classification or type of the item associated with the purchase requisition. |
| `account_assignment_category` | `string` | No | Represents the classification used to determine how costs or assets are allocated for a purchase requisition. |
| `account_assignment_category_description` | `string` | Yes | Text description providing details about the account assignment category associated with the purchase requisition. |
| `distribution` | `string` | No | No information provided for this column; unable to generate a comment. |
| `gl_account` | `string` | Yes | Represents the General Ledger account associated with the purchase requisition. |
| `controlling_area` | `string` | Yes |  |
| `cost_centre` | `string` | Yes | Represents the financial cost center associated with the purchase requisition for tracking expenses. |
| `service_order` | `string` | Yes |  |
| `wbs_element` | `string` | No | Represents the Work Breakdown Structure (WBS) element, used to identify and manage individual components of a project or task within the purchase requisition. |
| `main_asset_number` | `string` | Yes | No relevant column data or information available in the provided table schema for generating a specific description. |
| `partial_invoice_indicator` | `string` | No | Represents a flag indicating whether the purchase requisition item is subject to partial invoicing. |
| `goods_receipt_indicator` | `string` | No | Flag indicating whether goods receipt is required or has been completed for the purchase requisition. |
| `goods_receipt_non_valuated_indicator` | `string` | No | Indicates whether the receipt of goods for the purchase requisition is recorded without a valuation impact. |
| `invoice_receipt_indicator` | `string` | No | Flag indicating whether the invoice receipt process is completed for the purchase requisition item. |
| `desired_vendor` | `string` | No | Represents the vendor preferred or desired for fulfilling the purchase requisition. |
| `fixed_vendor` | `string` | No | Represents the vendor explicitly assigned to fulfill the purchase requisition. |
| `purchasing_organization` | `string` | No | Represents the organizational unit responsible for procurement activities within a purchasing process. |
| `purchase_order` | `string` | No | Represents a unique identifier associated with a purchase order. |
| `purchase_order_item` | `string` | No | Sequential item number associated with a purchase order, used for identification or reference. |
| `purchase_order_date` | `date` | No | Represents the date when the purchase order related to the requisition was created or issued. |
| `principle_purchase_agreement` | `string` | No | Represents the primary purchase agreement associated with the purchase requisition. |
| `principle_purchase_agreement_item` | `string` | No | No details provided for this column in the table schema or prompt. Please clarify or provide additional context. |
| `purchasing_info_record` | `string` | No | Represents a record containing supplier-specific details about the procurement of materials or services. |
| `reservation_number` | `string` | No | Represents a unique identifier associated with a reservation in the context of the purchase requisition. |
| `package_number` | `string` | No |  |
| `release_group` | `string` | No | Represents the classification or grouping used to manage or categorize the release strategy for the purchase requisition. |
| `release_not_completed` | `string` | No | Indicates the status of purchase requisitions where the release process is incomplete or pending. |
| `delivery_address_number` | `string` | No | Represents the specific identifier associated with the delivery address for purchase requisition items. |
| `delivery_name1` | `string` | Yes | Represents the name or identifier associated with the delivery details. |
| `delivery_name2` | `string` | Yes | Represents the name or identifier associated with the delivery details. |
| `delivery_street` | `string` | Yes | Represents the street address associated with the delivery location for the purchase requisition. |
| `delivery_postcode` | `string` | Yes | Represents the postal code associated with the delivery address of the purchase requisition. |
| `delivery_city` | `string` | Yes | City name indicating the destination for delivery related to the purchase requisition. |
| `delivery_country` | `string` | Yes | Represents the country designated for the delivery of the purchase requisition items. |

## Related Pages

- [[Transport Contract Tables - transport]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
