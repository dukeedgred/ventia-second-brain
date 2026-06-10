---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport
table-name: uvw_po_item_data_ekpo
full-name: transport_dev.transport.uvw_po_item_data_ekpo
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport]
---

# Transport Table - transport - uvw_po_item_data_ekpo

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_po_item_data_ekpo` |
| Full name | `transport_dev.transport.uvw_po_item_data_ekpo` |
| Catalog | `transport_dev` |
| Schema | `transport` |
| Contract/schema | `transport` |
| Table type | VIEW |
| Column count | 23 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | commercial / finance |
| Owner/SME | bhupesh.balani@ventia.com |
| Refresh/freshness | Created: 2025-04-02T04:11:42.693Z; Last altered: 2025-04-02T04:11:42.693Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
Select distinct EBELN as PO_Document, EBELP as Item, BEDNR as Tracking_Number, KNTTP as Account_Assignment_Category, TXZ01 as Short_Text, BUKRS as Co_Code, WERKS as Plant, MATKL as Material_Group, MENGE as PO_Qty, MEINS as UOM, NETPR as Net_Price, NETWR as PO_Value, BANFN as Purchasing_Req, AFNAM as Requisitioner, ELIKZ as Delivery_Completed_Indicator, EREKZ as Final_Invoice_Indicator, LOEKZ as Deletion_Indicator, IDNLF as Material_Number_Used_by_Vendor, PACKNO as Package_number, RETPO as Returns_Item, format_string(int(KO_PRCTR)) as Profit_Centre, s.VRTKZ as Distribution_Indicator, s.WEUNB AS GR_NonValuated
from staged.stg_sap_hana_cf_sap_ecc.ekpo s
inner join transport_dev.transport.uvw_po_header_data_ekko t
ON EBELN = t.PO_Document
where s.deleted_in_source =0
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `PO_Document` | `string` | No | Purchasing Document Number |
| `Item` | `string` | No | Item Number of Purchasing Document |
| `Tracking_Number` | `string` | Yes | Requirement Tracking Number |
| `Account_Assignment_Category` | `string` | Yes | Account Assignment Category |
| `Short_Text` | `string` | Yes | Short Text |
| `Co_Code` | `string` | Yes | Company Code |
| `Plant` | `string` | Yes | Plant |
| `Material_Group` | `string` | Yes | Material Group |
| `PO_Qty` | `decimal(13,3)` | Yes | Purchase Order Quantity |
| `UOM` | `string` | Yes | Purchase Order Unit of Measure |
| `Net_Price` | `decimal(11,2)` | Yes | Net Price in Purchasing Document (in Document Currency) |
| `PO_Value` | `decimal(13,2)` | Yes | Net Order Value in PO Currency |
| `Purchasing_Req` | `string` | Yes | Purchase Requisition Number |
| `Requisitioner` | `string` | Yes | Name of requisitioner/requester |
| `Delivery_Completed_Indicator` | `string` | Yes | "Delivery Completed" Indicator |
| `Final_Invoice_Indicator` | `string` | Yes | Final Invoice Indicator |
| `Deletion_Indicator` | `string` | Yes | Deletion Indicator in Purchasing Document |
| `Material_Number_Used_by_Vendor` | `string` | Yes | Material Number Used by Vendor |
| `Package_number` | `string` | Yes | Package number |
| `Returns_Item` | `string` | Yes | Returns Item |
| `Profit_Centre` | `string` | Yes |  |
| `Distribution_Indicator` | `string` | Yes | Distribution indicator for multiple account assignment |
| `GR_NonValuated` | `string` | Yes | Goods Receipt, Non-Valuated |

## Related Pages

- [[Transport Contract Tables - transport]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
