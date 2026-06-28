---
type: data-table
topic: Ventia
sector: Transport
contract-schema: stg_enterprise_reporting
table-name: uvw_po_open_commitment_with_ageing
full-name: transport_dev.stg_enterprise_reporting.uvw_po_open_commitment_with_ageing
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, stg-enterprise-reporting]
---

# Transport Table - stg_enterprise_reporting - uvw_po_open_commitment_with_ageing

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_po_open_commitment_with_ageing` |
| Full name | `transport_dev.stg_enterprise_reporting.uvw_po_open_commitment_with_ageing` |
| Catalog | `transport_dev` |
| Schema | `stg_enterprise_reporting` |
| Contract/schema | `stg_enterprise_reporting` |
| Table type | VIEW |
| Column count | 52 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | commercial / finance |
| Owner/SME | bhupesh.balani@ventia.com |
| Refresh/freshness | Created: 2025-11-20T07:50:20.962Z; Last altered: 2025-11-20T07:50:20.962Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
WITH Open_Commitment_Aging1 AS (
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
        s.Delivery_Completed_Indicator,
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
        datediff(current_date(), to_date(Creation_Date, 'yyyyMMdd')) AS Days_Open
    FROM transport_dev.stg_enterprise_reporting.uvw_po_open_commitment s
    LEFT JOIN corporate_dev.bai.vw_sap_vendor t
        ON s.Vendor_Number = t.sap_vendor_id
)
SELECT 
    *,
    IF(
        AND(Days_Open >= 0, Days_Open <= 90), 
        "0-90 Days",
        IF(
            AND(Days_Open > 90, Days_Open <= 180), 
            "91-180 Days",
            IF(
                AND(Days_Open > 180, Days_Open <= 270), 
                "181-270 Days",
                IF(
                    AND(Days_Open > 270, Days_Open <= 365), 
                    "271-365 Days", 
                    ">365 Days"
                )
            )
        )
    ) AS Days_Aging,
    IF(AND(Days_Open >= 0, Days_Open <= 90), Still_to_be_delivered_Value, 0) AS `0-90 Days`,
    IF(AND(Days_Open > 90, Days_Open <= 180), Still_to_be_delivered_Value, 0) AS `91-180 Days`,
    IF(AND(Days_Open > 180, Days_Open <= 270), Still_to_be_delivered_Value, 0) AS `181-270 Days`,
    IF(AND(Days_Open > 270, Days_Open <= 365), Still_to_be_delivered_Value, 0) AS `271-365 Days`,
    IF(Days_Open > 365, Still_to_be_delivered_Value, 0) AS `>365 Days`,
    IF(
        AND(Days_Open >= 0, Days_Open <= 90), 
        1,
        IF(
            AND(Days_Open > 90, Days_Open <= 180), 
            2,
            IF(
                AND(Days_Open > 180, Days_Open <= 270), 
                3,
                IF(
                    AND(Days_Open > 270, Days_Open <= 365), 
                    4, 
                    5
                )
            )
        )
    ) AS Aging_Sort
FROM Open_Commitment_Aging1
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
| `Profit_Centre` | `string` | Yes |  |
| `Cost_Object` | `string` | Yes |  |
| `Still_to_be_delivered_Qty` | `double` | Yes |  |
| `Still_to_be_delivered_Value` | `double` | Yes |  |
| `Still_to_be_invoiced_Qty` | `double` | Yes |  |
| `Still_to_be_invoiced_Value` | `double` | Yes |  |
| `Vendor_Name` | `string` | Yes |  |
| `Days_Open` | `int` | Yes |  |
| `Days_Aging` | `string` | No |  |
| `0-90 Days` | `double` | Yes |  |
| `91-180 Days` | `double` | Yes |  |
| `181-270 Days` | `double` | Yes |  |
| `271-365 Days` | `double` | Yes |  |
| `>365 Days` | `double` | Yes |  |
| `Aging_Sort` | `int` | No |  |

## Related Pages

- [[Transport Contract Tables - stg_enterprise_reporting]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
