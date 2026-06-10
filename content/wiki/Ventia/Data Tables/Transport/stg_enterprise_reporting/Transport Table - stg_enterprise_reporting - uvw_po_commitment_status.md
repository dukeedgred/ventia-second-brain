---
type: data-table
topic: Ventia
sector: Transport
contract-schema: stg_enterprise_reporting
table-name: uvw_po_commitment_status
full-name: transport_dev.stg_enterprise_reporting.uvw_po_commitment_status
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, stg-enterprise-reporting]
---

# Transport Table - stg_enterprise_reporting - uvw_po_commitment_status

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_po_commitment_status` |
| Full name | `transport_dev.stg_enterprise_reporting.uvw_po_commitment_status` |
| Catalog | `transport_dev` |
| Schema | `stg_enterprise_reporting` |
| Contract/schema | `stg_enterprise_reporting` |
| Table type | VIEW |
| Column count | 43 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | workflow / status |
| Owner/SME | bhupesh.balani@ventia.com |
| Refresh/freshness | Created: 2025-11-21T02:02:42.785Z; Last altered: 2025-11-21T02:02:42.785Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
WITH Commitment_Status AS(
  SELECT
    s.* EXCEPT (s.Profit_Centre),
    t.Service_PO_Qty,
    zeroifnull(u.GR_Qty) AS GR_Qty,
    zeroifnull(u.IR_Qty) AS IR_Qty,
    zeroifnull(u.MR11_Qty) AS MR11_Qty,
    zeroifnull(u.GR_Amount) AS GR_Amount,
    zeroifnull(u.IR_Amount) AS IR_Amount,
    zeroifnull(u.MR11_Amount) AS MR11_Amount,
    zeroifnull(u.Service_PO_GR_Qty) AS Service_PO_GR_Qty,
    zeroifnull(u.Service_PO_GR_Amount) AS Service_PO_GR_Amount,
    zeroifnull(u.Unapproved_SES) AS Unapproved_SES,
    round(CAST(CASE
      WHEN s.Package_number='0000000000' THEN (zeroifnull(u.GR_Qty)*zeroifnull(s.Net_Price))+zeroifnull(u.MR11_Amount)
        ELSE zeroifnull(u.GR_Amount)-zeroifnull(u.MR11_Amount)
    END AS STRING),2) as GR_Amount_To_Use,
    round(CAST(CASE
      WHEN zeroifnull(s.PO_Qty)<zeroifnull(u.GR_Qty) THEN zeroifnull(u.GR_Qty)-zeroifnull(u.MR11_Qty)
        ELSE zeroifnull(u.GR_Qty)
    END AS STRING),3) as GR_Qty_To_Use,
    round(CAST(CASE
      WHEN s.Package_number='0000000000' THEN
            if(s.Returns_Item='X',-zeroifnull(s.PO_Qty),zeroifnull(s.PO_Qty)) 
        ELSE
            if(s.Returns_Item='X',-zeroifnull(t.Service_PO_Qty),zeroifnull(t.Service_PO_Qty))
    END AS STRING),3) as PO_Qty_To_Use
  from transport_dev.stg_enterprise_reporting.uvw_PO_Header_Item_Data_EKKO_EKPO_Main s
  LEFT JOIN transport_dev.stg_enterprise_reporting.uvw_PO_Service_Entry_Lines_RawData_ESLL t
  on concat(s.PO_Document,'-',s.Item) = concat(t.PO_Document,'-',t.Item)
  LEFT JOIN  transport_dev.stg_enterprise_reporting.uvw_PO_History_EKBE u
  on concat(s.PO_Document,'-',s.Item) = concat(u.PO_Document,'-',u.Item)
)
Select *,
CAST(CASE
      WHEN package_number = '0000000000' THEN
            if(((((PO_Qty_To_Use = GR_Qty_To_Use or Delivery_Completed_Indicator='X') or (Net_Price=0)) or (PO_Qty<GR_Qty_To_Use))) AND Unapproved_SES=0,'Close','Open')
        WHEN PO_Qty_To_Use=0 THEN
            if((((Delivery_Completed_Indicator='X' or GR_Qty_To_Use < IR_Qty) or (PO_Value <= Service_PO_GR_Amount)) or Net_Price=0) AND Unapproved_SES=0,'Close','Open')
                ELSE
                    if(((Delivery_Completed_Indicator='X' OR PO_Qty_To_Use <= GR_Qty) OR ((PO_Value>0) AND (PO_Value <= Service_PO_GR_Amount)) OR (GR_Qty < IR_Qty)) AND Unapproved_SES=0, 'Close', 'Open')
END AS STRING) as Open_Close
FROM Commitment_Status
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
| `PO_Document_Type` | `string` | Yes | Purchasing Document Type |
| `Creation_Date` | `string` | Yes | Record Creation Date |
| `Vendor_Number` | `string` | Yes | Supplier's Account Number |
| `Payment_Terms` | `string` | Yes | Terms of Payment Key |
| `Purchase_Org` | `string` | Yes | Purchasing Organization |
| `Purch_Grp` | `string` | Yes | Purchasing Group |
| `CURR` | `string` | Yes | Currency Key |
| `Document_Date` | `string` | Yes | Purchasing Document Date |
| `OnHold_X` | `string` | Yes | Purchase order not yet complete |
| `Service_PO_Qty` | `decimal(23,3)` | Yes |  |
| `GR_Qty` | `double` | No |  |
| `IR_Qty` | `double` | No |  |
| `MR11_Qty` | `double` | No |  |
| `GR_Amount` | `double` | No |  |
| `IR_Amount` | `double` | No |  |
| `MR11_Amount` | `double` | No |  |
| `Service_PO_GR_Qty` | `double` | No |  |
| `Service_PO_GR_Amount` | `double` | No |  |
| `Unapproved_SES` | `decimal(38,2)` | No |  |
| `GR_Amount_To_Use` | `double` | Yes |  |
| `GR_Qty_To_Use` | `double` | Yes |  |
| `PO_Qty_To_Use` | `double` | Yes |  |
| `Open_Close` | `string` | No |  |

## Related Pages

- [[Transport Contract Tables - stg_enterprise_reporting]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
