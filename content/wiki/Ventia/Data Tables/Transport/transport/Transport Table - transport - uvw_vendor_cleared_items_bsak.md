---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport
table-name: uvw_vendor_cleared_items_bsak
full-name: transport_dev.transport.uvw_vendor_cleared_items_bsak
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-table, databricks, vendor, finance, sap]
---

# Transport Table - transport - uvw_vendor_cleared_items_bsak

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_vendor_cleared_items_bsak` |
| Full name | `transport_dev.transport.uvw_vendor_cleared_items_bsak` |
| Catalog | `transport_dev` |
| Schema | `transport` |
| Contract/schema | `transport` |
| Table type | VIEW |
| Column count | 16 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | vendor finance |
| Source system | SAP |
| Related tables/reports | `staged.stg_sap_hana_cf_sap_ecc.bsak`, `transport_dev.transport.uvw_po_history_ekbe` |

## View Query

```sql
Select distinct BUKRS as Co_Code, LIFNR as Vendor_No, AUGDT as Clearing_Date, AUGBL as Clearing_Document_No, BELNR as Document_No, BUDAT as Posting_Date, BLDAT as Document_Date, XBLNR as Ref_Document_No, BLART as Document_Type, SHKZG as Debit_Credit_Indicator, DMBTR as Amt_Loc_CURR, WRBTR as Amt_Doc_CURR, SGTXT as Item_Text, EBELN as PO_Document, EBELP as Item, int(PRCTR) as PC_ID
from staged.stg_sap_hana_cf_sap_ecc.bsak s
inner join transport_dev.transport.uvw_po_history_ekbe t 
ON BELNR = t.Material_Document
where s.deleted_in_source =0 and int(left(BUDAT,6))>=202401
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Co_Code` | `string` | No |  |
| `Vendor_No` | `string` | No |  |
| `Clearing_Date` | `string` | No |  |
| `Clearing_Document_No` | `string` | No |  |
| `Document_No` | `string` | No |  |
| `Posting_Date` | `string` | Yes |  |
| `Document_Date` | `string` | Yes |  |
| `Ref_Document_No` | `string` | Yes |  |
| `Document_Type` | `string` | Yes |  |
| `Debit_Credit_Indicator` | `string` | Yes |  |
| `Amt_Loc_CURR` | `decimal(13,2)` | Yes |  |
| `Amt_Doc_CURR` | `decimal(13,2)` | Yes |  |
| `Item_Text` | `string` | Yes |  |
| `PO_Document` | `string` | Yes |  |
| `Item` | `string` | Yes |  |
| `PC_ID` | `int` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
