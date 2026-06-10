---
type: data-table
topic: Ventia
sector: Transport
contract-schema: stg_enterprise_reporting
table-name: uvw_completed_po
full-name: transport_dev.stg_enterprise_reporting.uvw_completed_po
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, stg-enterprise-reporting]
---

# Transport Table - stg_enterprise_reporting - uvw_completed_po

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_completed_po` |
| Full name | `transport_dev.stg_enterprise_reporting.uvw_completed_po` |
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
| Refresh/freshness | Created: 2025-11-19T07:58:27.563Z; Last altered: 2025-11-19T07:58:27.563Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
WITH Open_Commitment_2 AS (
  WITH Open_Commitment_1 AS (
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
      s.Package_number,
      s.Delivery_Completed_Indicator,
      s.Returns_Item,
      s.PO_Document_Type,
      s.Creation_Date,
      s.Vendor_Number,
      s.Payment_Terms,
      s.Purchase_Org,
      s.Purch_Grp,
      s.CURR,
      s.Document_Date,
      date_format(current_date(), 'yyyyMMdd') AS Today_Date,
      u.Distribution_Indicator,
      u.Distribution_Percentage,
      u.Distribution_Qty,
      u.Total_Distribution_Qty,
      u.MultipleAccountAssignment,
      u.Total_Distribution_Percent,
      w.Delivery_Date,
      w.Delivery_Due,
      zeroifnull(t.MR11_Qty) AS MR11_Qty,
      zeroifnull(t.MR11_Amount) AS MR11_Amount,
      zeroifnull(t.Service_PO_GR_Qty) AS Service_PO_GR_Qty,
      zeroifnull(t.Service_PO_GR_Amount) AS Service_PO_GR_Amount,
      s.Unapproved_SES,
      CAST(
        CASE 
          WHEN u.MultipleAccountAssignment = 'Yes' THEN
            IF(
              Distribution_Indicator = 1,
              ROUND(zeroifnull(s.GR_Qty_To_Use) * zeroifnull(Distribution_Qty) / zeroifnull(Total_Distribution_Qty), 3),
              ROUND(zeroifnull(s.GR_Qty_To_Use) * zeroifnull(Distribution_Percentage) / zeroifnull(Total_Distribution_Percent), 3)
            )
          ELSE ROUND(zeroifnull(s.GR_Qty_To_Use), 3)
        END AS DOUBLE
      ) AS GR_Qty,
      CAST(
        CASE 
          WHEN MultipleAccountAssignment = 'Yes' THEN
            IF(
              Distribution_Indicator = 1,
              ROUND(zeroifnull(s.IR_Qty) * zeroifnull(Distribution_Qty) / zeroifnull(Total_Distribution_Qty), 3),
              ROUND(zeroifnull(s.IR_Qty) * zeroifnull(Distribution_Percentage) / zeroifnull(Total_Distribution_Percent), 3)
            )
          ELSE ROUND(zeroifnull(s.IR_Qty), 3)
        END AS DOUBLE
      ) AS IR_Qty,
      CAST(
        CASE 
          WHEN u.MultipleAccountAssignment = 'Yes' THEN
            IF(
              Package_number <> '0000000000',
              ROUND(
                IF(u.MultipleAccountAssignment = 'Yes', zeroifnull(t.IR_Qty), zeroifnull(s.GR_Qty)) +
                IF(
                  u.Distribution_Indicator = '1',
                  (zeroifnull(s.PO_Qty_To_Use)) * zeroifnull(u.Distribution_Qty) / zeroifnull(u.Total_Distribution_Qty),
                  ((zeroifnull(s.PO_Qty_To_Use)) * zeroifnull(u.Distribution_Percentage)) / zeroifnull(u.Total_Distribution_Percent)
                ),
                3
              ),
              IF(
                u.Distribution_Indicator = '1',
                ROUND((zeroifnull(s.PO_Qty_To_Use)) * zeroifnull(u.Distribution_Qty) / zeroifnull(u.Total_Distribution_Qty), 3),
                ROUND(((zeroifnull(s.PO_Qty_To_Use)) * zeroifnull(u.Distribution_Percentage)) / zeroifnull(u.Total_Distribution_Percent), 3)
              )
            )
          ELSE zeroifnull(s.PO_Qty)
        END AS DOUBLE
      ) AS PO_Qty,
      CAST(
        CASE 
          WHEN u.MultipleAccountAssignment = 'Yes' THEN
            IF(
              u.Distribution_Indicator = 1,
              ROUND(zeroifnull(s.PO_Value) * zeroifnull(u.Distribution_Qty) / zeroifnull(u.Total_Distribution_Qty), 2),
              ROUND(zeroifnull(s.PO_Value) * zeroifnull(u.Distribution_Percentage) / zeroifnull(u.Total_Distribution_Percent), 2)
            )
          ELSE ROUND(zeroifnull(s.PO_Value), 2)
        END AS DOUBLE
      ) AS PO_Value,
      CAST(
        CASE 
          WHEN u.MultipleAccountAssignment = 'Yes' THEN
            IF(
              u.Distribution_Indicator = 1,
              ROUND(zeroifnull(s.GR_Amount_To_Use) * zeroifnull(u.Distribution_Qty) / zeroifnull(u.Total_Distribution_Qty), 2),
              ROUND(zeroifnull(s.GR_Amount_To_Use) * zeroifnull(u.Distribution_Percentage) / zeroifnull(u.Total_Distribution_Percent), 2)
            )
          ELSE ROUND(zeroifnull(s.GR_Amount_To_Use), 2)
        END AS DOUBLE
      ) AS GR_Amount,
      CAST(
        CASE 
          WHEN u.MultipleAccountAssignment = 'Yes' THEN
            IF(
              u.Distribution_Indicator = 1,
              ROUND(zeroifnull(s.IR_Amount) * zeroifnull(u.Distribution_Qty) / zeroifnull(u.Total_Distribution_Qty), 2),
              ROUND(zeroifnull(s.IR_Amount) * zeroifnull(u.Distribution_Percentage) / zeroifnull(u.Total_Distribution_Percent), 2)
            )
          ELSE ROUND(zeroifnull(s.IR_Amount), 2)
        END AS DOUBLE
      ) AS IR_Amount,
      u.GL_Account AS GL_Account,
      u.Profit_Centre AS Profit_Centre,
      u.Cost_Object AS Cost_Object
    FROM transport_dev.stg_enterprise_reporting.uvw_PO_Commitment_Status s
    LEFT JOIN transport_dev.stg_enterprise_reporting.uvw_PO_Account_Assignment_EKKN u
      ON CONCAT(s.PO_Document, '-', s.Item) = CONCAT(u.PO_Document, '-', u.Item)
    LEFT JOIN transport_dev.stg_enterprise_reporting.uvw_PO_History_EKBE_Open_Commitment t
      ON CONCAT(s.PO_Document, '-', s.Item, '-', u.Seq_no) = CONCAT(t.PO_Document, '-', t.Item, '-', t.Seq_no)
    LEFT JOIN transport_dev.stg_enterprise_reporting.uvw_PO_Delivery_Dates_EKET w
      ON CONCAT(s.PO_Document, '-', s.Item) = CONCAT(w.PO_Document, '-', w.Item)
    WHERE s.Open_Close = 'Close'
      AND (startswith(s.Co_Code, '7') OR startswith(s.Co_Code, '9'))
  )
  SELECT 
    *,
    CAST(
      CASE 
        WHEN Package_number = '0000000000' THEN ROUND((PO_Qty - GR_Qty), 3) 
        ELSE 0 
      END AS DOUBLE
    ) AS Still_to_be_delivered_Qty
  FROM Open_Commitment_1
)
SELECT 
  *,
  CAST(
    CASE 
      WHEN Package_number = '0000000000' THEN ROUND(Still_to_be_delivered_Qty * Net_Price,2)
      ELSE ROUND((IF(Unapproved_SES=0, IF(PO_Value > GR_Amount, PO_Value - GR_Amount, 0), IF((PO_Value - GR_Amount)>Unapproved_SES,PO_Value - GR_Amount,Unapproved_SES))), 2)
    END AS DOUBLE
  ) AS Still_to_be_delivered_Value,
  CAST(
    CASE 
      WHEN Package_number = '0000000000' THEN ROUND((PO_Qty - IR_Qty - MR11_Qty), 3) 
      ELSE 0 
    END AS DOUBLE
  ) AS Still_to_be_invoiced_Qty,
  CAST(
    CASE 
      WHEN Package_number = '0000000000' THEN ROUND((PO_Qty - IR_Qty - MR11_Qty) * Net_Price,2)
      ELSE ROUND((IF(Unapproved_SES=0, IF(PO_Value > (IR_Amount + MR11_Amount), PO_Value - IR_Amount - MR11_Amount, 0), IF((PO_Value - IR_Amount - MR11_Amount)> Unapproved_SES,PO_Value - IR_Amount - MR11_Amount,Unapproved_SES))), 2)
    END AS DOUBLE
  ) AS Still_to_be_invoiced_Value
FROM Open_Commitment_2
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
| `Package_number` | `string` | Yes | Package number |
| `Delivery_Completed_Indicator` | `string` | Yes | "Delivery Completed" Indicator |
| `Returns_Item` | `string` | Yes | Returns Item |
| `PO_Document_Type` | `string` | Yes | Purchasing Document Type |
| `Creation_Date` | `string` | Yes | Record Creation Date |
| `Vendor_Number` | `string` | Yes | Supplier's Account Number |
| `Payment_Terms` | `string` | Yes | Terms of Payment Key |
| `Purchase_Org` | `string` | Yes | Purchasing Organization |
| `Purch_Grp` | `string` | Yes | Purchasing Group |
| `CURR` | `string` | Yes | Currency Key |
| `Document_Date` | `string` | Yes | Purchasing Document Date |
| `Today_Date` | `string` | No |  |
| `Distribution_Indicator` | `string` | Yes | Distribution indicator for multiple account assignment |
| `Distribution_Percentage` | `decimal(3,1)` | Yes | Distribution percentage in the case of multiple acct assgt |
| `Distribution_Qty` | `decimal(13,3)` | Yes | Quantity |
| `Total_Distribution_Qty` | `decimal(23,3)` | Yes |  |
| `MultipleAccountAssignment` | `string` | Yes |  |
| `Total_Distribution_Percent` | `decimal(13,1)` | Yes |  |
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

## Related Pages

- [[Transport Contract Tables - stg_enterprise_reporting]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
