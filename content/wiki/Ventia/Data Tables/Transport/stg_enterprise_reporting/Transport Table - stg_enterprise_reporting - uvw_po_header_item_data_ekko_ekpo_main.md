---
type: data-table
topic: Ventia
sector: Transport
contract-schema: stg_enterprise_reporting
table-name: uvw_po_header_item_data_ekko_ekpo_main
full-name: transport_dev.stg_enterprise_reporting.uvw_po_header_item_data_ekko_ekpo_main
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, stg-enterprise-reporting]
---

# Transport Table - stg_enterprise_reporting - uvw_po_header_item_data_ekko_ekpo_main

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_po_header_item_data_ekko_ekpo_main` |
| Full name | `transport_dev.stg_enterprise_reporting.uvw_po_header_item_data_ekko_ekpo_main` |
| Catalog | `transport_dev` |
| Schema | `stg_enterprise_reporting` |
| Contract/schema | `stg_enterprise_reporting` |
| Table type | VIEW |
| Column count | 30 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | commercial / finance |
| Owner/SME | bhupesh.balani@ventia.com |
| Refresh/freshness | Created: 2025-10-31T06:48:50.455Z; Last altered: 2025-10-31T06:48:50.455Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
SELECT
--(Excluding POs on hold and Deleted Items)
    s.EBELN AS PO_Document, 
    s.EBELP AS Item, 
    s.BEDNR AS Tracking_Number, 
    s.KNTTP AS Account_Assignment_Category, 
    s.TXZ01 AS Short_Text, 
    s.BUKRS AS Co_Code, 
    s.WERKS AS Plant, 
    s.MATKL AS Material_Group, 
    s.MENGE AS PO_Qty, 
    s.MEINS AS UOM, 
    (s.NETPR/s.PEINH) AS Net_Price, 
    s.NETWR AS PO_Value, 
    s.BANFN AS Purchasing_Req, 
    s.AFNAM AS Requisitioner, 
    s.ELIKZ AS Delivery_Completed_Indicator, 
    s.EREKZ AS Final_Invoice_Indicator, 
    s.LOEKZ AS Deletion_Indicator, 
    s.IDNLF AS Material_Number_Used_by_Vendor, 
    s.PACKNO AS Package_number, 
    s.RETPO AS Returns_Item, 
    CAST(CAST(s.KO_PRCTR AS INT) AS STRING) AS Profit_Centre,
    t.BSART AS PO_Document_Type, 
    t.AEDAT AS Creation_Date, 
    t.LIFNR AS Vendor_Number, 
    t.ZTERM AS Payment_Terms, 
    t.EKORG AS Purchase_Org, 
    t.EKGRP AS Purch_Grp, 
    t.WAERS AS CURR, 
    t.BEDAT AS Document_Date, 
    t.MEMORY AS OnHold_X
FROM staged.stg_sap_hana_cf_sap_ecc.ekpo s
LEFT JOIN staged.stg_sap_hana_cf_sap_ecc.ekko t 
ON s.EBELN = t.EBELN
WHERE s.deleted_in_source = 0
and s.LOEKZ = ""  -- excluding Deleted Items
--and t.BSART<>"ZCP" -- excluding Capex POs
and t.MEMORY= ""
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
| `Net_Price` | `decimal(17,8)` | Yes |  |
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
| `PO_Document_Type` | `string` | Yes | Purchasing Document Type |
| `Creation_Date` | `string` | Yes | Record Creation Date |
| `Vendor_Number` | `string` | Yes | Supplier's Account Number |
| `Payment_Terms` | `string` | Yes | Terms of Payment Key |
| `Purchase_Org` | `string` | Yes | Purchasing Organization |
| `Purch_Grp` | `string` | Yes | Purchasing Group |
| `CURR` | `string` | Yes | Currency Key |
| `Document_Date` | `string` | Yes | Purchasing Document Date |
| `OnHold_X` | `string` | Yes | Purchase order not yet complete |

## Related Pages

- [[Transport Contract Tables - stg_enterprise_reporting]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
