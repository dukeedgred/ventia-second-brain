---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport
table-name: uvw_po_open_commitment_with_ageing_transport
full-name: transport_dev.transport.uvw_po_open_commitment_with_ageing_transport
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport]
---

# Transport Table - transport - uvw_po_open_commitment_with_ageing_transport

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_po_open_commitment_with_ageing_transport` |
| Full name | `transport_dev.transport.uvw_po_open_commitment_with_ageing_transport` |
| Catalog | `transport_dev` |
| Schema | `transport` |
| Contract/schema | `transport` |
| Table type | VIEW |
| Column count | 52 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | commercial / finance |
| Owner/SME | bhupesh.balani@ventia.com |
| Refresh/freshness | Created: 2025-11-20T08:02:12.871Z; Last altered: 2025-11-20T08:02:12.871Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
SELECT 
    s.* EXCEPT (
        s.Still_to_be_delivered_Qty, 
        s.Still_to_be_delivered_Value, 
        s.Still_to_be_invoiced_Qty, 
        s.Still_to_be_invoiced_Value, 
        s.Days_Aging,
        s.Vendor_Name,
        s.Profit_Centre
    ),
    s.Still_to_be_delivered_Qty AS `Still to be delivered (qty)`,
    s.Still_to_be_delivered_Value AS `Still to be delivered (value)`,
    s.Still_to_be_invoiced_Qty AS `Still to be invoiced (qty)`,
    s.Still_to_be_invoiced_Value AS `Still to be invoiced (value)`,
    s.Days_Aging AS `Days Aging`,
    s.Vendor_Name AS `Vendor Name`,
    s.Profit_Centre AS PC_ID
FROM 
    transport_dev.stg_enterprise_reporting.uvw_PO_Open_Commitment_With_Ageing s
INNER JOIN 
    transport_dev.transport.uvw_pc_masterdata t
    ON s.Profit_Centre = t.PC_ID

UNION ALL

SELECT 
    s.* EXCEPT (
        s.Still_to_be_delivered_Qty, 
        s.Still_to_be_delivered_Value, 
        s.Still_to_be_invoiced_Qty, 
        s.Still_to_be_invoiced_Value, 
        s.Days_Aging,
        s.Vendor_Name,
        s.Profit_Centre
    ),
    s.Still_to_be_delivered_Qty AS `Still to be delivered (qty)`,
    s.Still_to_be_delivered_Value AS `Still to be delivered (value)`,
    s.Still_to_be_invoiced_Qty AS `Still to be invoiced (qty)`,
    s.Still_to_be_invoiced_Value AS `Still to be invoiced (value)`,
    s.Days_Aging AS `Days Aging`,
    s.Vendor_Name AS `Vendor Name`,
    s.Profit_Centre AS PC_ID
FROM 
    transport_dev.stg_enterprise_reporting.uvw_PO_Open_Commitment_With_Ageing s
    WHERE s.Profit_Centre = '90240'

UNION ALL

SELECT 
    s.* EXCEPT (
        s.Still_to_be_delivered_Qty, 
        s.Still_to_be_delivered_Value, 
        s.Still_to_be_invoiced_Qty, 
        s.Still_to_be_invoiced_Value, 
        s.Days_Aging,
        s.Vendor_Name,
        s.Profit_Centre
    ),
    s.Still_to_be_delivered_Qty AS `Still to be delivered (qty)`,
    s.Still_to_be_delivered_Value AS `Still to be delivered (value)`,
    s.Still_to_be_invoiced_Qty AS `Still to be invoiced (qty)`,
    s.Still_to_be_invoiced_Value AS `Still to be invoiced (value)`,
    s.Days_Aging AS `Days Aging`,
    s.Vendor_Name AS `Vendor Name`,
    s.Profit_Centre AS PC_ID
FROM 
    transport_dev.stg_enterprise_reporting.uvw_PO_Open_Commitment_With_Ageing s
    WHERE s.Profit_Centre = '90050'
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
| `Delivery_Completed_Indicator` | `string` | Yes | "Delivery Completed" Indicator |
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
| `GR_Qty` | `double` | Yes |  |
| `IR_Qty` | `double` | Yes |  |
| `PO_Qty` | `double` | Yes |  |
| `PO_Value` | `double` | Yes |  |
| `GR_Amount` | `double` | Yes |  |
| `IR_Amount` | `double` | Yes |  |
| `GL_Account` | `string` | Yes |  |
| `Cost_Object` | `string` | Yes |  |
| `Days_Open` | `int` | Yes |  |
| `0-90 Days` | `double` | Yes |  |
| `91-180 Days` | `double` | Yes |  |
| `181-270 Days` | `double` | Yes |  |
| `271-365 Days` | `double` | Yes |  |
| `>365 Days` | `double` | Yes |  |
| `Aging_Sort` | `int` | No |  |
| `Still to be delivered (qty)` | `double` | Yes |  |
| `Still to be delivered (value)` | `double` | Yes |  |
| `Still to be invoiced (qty)` | `double` | Yes |  |
| `Still to be invoiced (value)` | `double` | Yes |  |
| `Days Aging` | `string` | No |  |
| `Vendor Name` | `string` | Yes |  |
| `PC_ID` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
