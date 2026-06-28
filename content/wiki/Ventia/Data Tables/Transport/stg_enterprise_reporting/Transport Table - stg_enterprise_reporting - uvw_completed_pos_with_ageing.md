---
type: data-table
topic: Ventia
sector: Transport
contract-schema: stg_enterprise_reporting
table-name: uvw_completed_pos_with_ageing
full-name: transport_dev.stg_enterprise_reporting.uvw_completed_pos_with_ageing
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, stg-enterprise-reporting]
---

# Transport Table - stg_enterprise_reporting - uvw_completed_pos_with_ageing

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_completed_pos_with_ageing` |
| Full name | `transport_dev.stg_enterprise_reporting.uvw_completed_pos_with_ageing` |
| Catalog | `transport_dev` |
| Schema | `stg_enterprise_reporting` |
| Contract/schema | `stg_enterprise_reporting` |
| Table type | VIEW |
| Column count | 52 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | bhupesh.balani@ventia.com |
| Refresh/freshness | Created: 2025-11-20T07:36:07.113Z; Last altered: 2025-11-20T07:36:07.113Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
SELECT 
        s.PO_Document,
        s.Item,
        s.Tracking_Number,
        s.Account_Assignment_Category,
        s.Short_Text,
        s.Co_Code,
        s.Plant,
        s.Material_Group,
        s.UOM,
        s.Net_Price,
        s.Purchasing_Req,
        s.Requisitioner,
        s.Final_Invoice_Indicator,
        s.Material_Number_Used_by_Vendor,
        s.PO_Document_Type,
        s.Creation_Date,
        s.Vendor_Number,
        s.Payment_Terms,
        s.Purchase_Org,
        s.Purch_Grp,
        s.CURR,
        s.Document_Date,
        s.Delivery_Date,
        s.Delivery_Due,
        s.MR11_Qty,
        s.MR11_Amount,
        s.Service_PO_GR_Qty,
        s.Service_PO_GR_Amount,
        s.Unapproved_SES,
        s.Delivery_Completed_Indicator,
        s.GR_Qty,
        s.IR_Qty,
        s.PO_Qty,
        s.PO_Value,
        s.GR_Amount,
        s.IR_Amount,
        s.GL_Account,
        s.Profit_Centre,
        s.Cost_Object,
        s.Still_to_be_delivered_Qty,
        s.Still_to_be_delivered_Value,
        s.Still_to_be_invoiced_Qty,
        s.Still_to_be_invoiced_Value,
        t.sap_vendor_name AS Vendor_Name,
        0 AS Days_Open,
        0 AS Days_Aging,
        0 AS `0-90 Days`,
        0 AS `91-180 Days`,
        0 AS `181-270 Days`,
        0 AS `271-365 Days`,
        0 AS `>365 Days`,
        99 AS Aging_Sort 
    FROM transport_dev.stg_enterprise_reporting.uvw_Completed_PO s
    LEFT JOIN corporate_dev.bai.vw_sap_vendor t
        ON s.Vendor_Number = t.sap_vendor_id
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
| `UOM` | `string` | Yes | Purchase Order Unit of Measure |
| `Net_Price` | `decimal(17,8)` | Yes |  |
| `Purchasing_Req` | `string` | Yes | Purchase Requisition Number |
| `Requisitioner` | `string` | Yes | Name of requisitioner/requester |
| `Final_Invoice_Indicator` | `string` | Yes | Final Invoice Indicator |
| `Material_Number_Used_by_Vendor` | `string` | Yes | Material Number Used by Vendor |
| `PO_Document_Type` | `string` | Yes | Purchasing Document Type |
| `Creation_Date` | `string` | Yes | Record Creation Date |
| `Vendor_Number` | `string` | Yes | Supplier's Account Number |
| `Payment_Terms` | `string` | Yes | Terms of Payment Key |
| `Purchase_Org` | `string` | Yes | Purchasing Organization |
| `Purch_Grp` | `string` | Yes | Purchasing Group |
| `CURR` | `string` | Yes | Currency Key |
| `Document_Date` | `string` | Yes | Purchasing Document Date |
| `Delivery_Date` | `string` | Yes | Item Delivery Date |
| `Delivery_Due` | `string` | Yes |  |
| `MR11_Qty` | `double` | No |  |
| `MR11_Amount` | `double` | No |  |
| `Service_PO_GR_Qty` | `double` | No |  |
| `Service_PO_GR_Amount` | `double` | No |  |
| `Unapproved_SES` | `decimal(38,2)` | No |  |
| `Delivery_Completed_Indicator` | `string` | Yes | "Delivery Completed" Indicator |
| `GR_Qty` | `double` | Yes |  |
| `IR_Qty` | `double` | Yes |  |
| `PO_Qty` | `double` | Yes |  |
| `PO_Value` | `double` | Yes |  |
| `GR_Amount` | `double` | Yes |  |
| `IR_Amount` | `double` | Yes |  |
| `GL_Account` | `string` | Yes |  |
| `Profit_Centre` | `string` | Yes |  |
| `Cost_Object` | `string` | Yes |  |
| `Still_to_be_delivered_Qty` | `double` | Yes |  |
| `Still_to_be_delivered_Value` | `double` | Yes |  |
| `Still_to_be_invoiced_Qty` | `double` | Yes |  |
| `Still_to_be_invoiced_Value` | `double` | Yes |  |
| `Vendor_Name` | `string` | Yes |  |
| `Days_Open` | `int` | No |  |
| `Days_Aging` | `int` | No |  |
| `0-90 Days` | `int` | No |  |
| `91-180 Days` | `int` | No |  |
| `181-270 Days` | `int` | No |  |
| `271-365 Days` | `int` | No |  |
| `>365 Days` | `int` | No |  |
| `Aging_Sort` | `int` | No |  |

## Related Pages

- [[Transport Contract Tables - stg_enterprise_reporting]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
