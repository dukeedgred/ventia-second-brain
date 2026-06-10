---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport
table-name: uvw_po_history_ekbe
full-name: transport_dev.transport.uvw_po_history_ekbe
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport]
---

# Transport Table - transport - uvw_po_history_ekbe

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_po_history_ekbe` |
| Full name | `transport_dev.transport.uvw_po_history_ekbe` |
| Catalog | `transport_dev` |
| Schema | `transport` |
| Contract/schema | `transport` |
| Table type | VIEW |
| Column count | 17 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | commercial / finance |
| Owner/SME | bhupesh.balani@ventia.com |
| Refresh/freshness | Created: 2025-04-02T15:12:45.269Z; Last altered: 2025-04-02T15:12:45.269Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
Select EBELN as PO_Document, EBELP as Item, BELNR as Material_Document, BWART as Movement_Type, BUDAT as Posting_Date, DMBTR as Amount_in_Loc_curr, WRBTR as Local_currency, WAERS as CURR, LFBNR as Reference_Material_Document, WERKS as Co_Code, MWSKZ as Tax_Code, BEWTP as GR_IR, MENGE as PO_Qty, AREWR as GR_Adjustment_Amount, XBLNR as Reference_Document_Number, SHKZG as Debit_Credit_Indicator, s.ZEKKN as Seq_no
from staged.stg_sap_hana_cf_sap_ecc.ekbe s
inner join transport_dev.transport.uvw_po_header_data_ekko t
ON EBELN = t.PO_Document
where s.deleted_in_source =0
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `PO_Document` | `string` | No | Purchasing Document Number |
| `Item` | `string` | No | Item Number of Purchasing Document |
| `Material_Document` | `string` | No | Number of Material Document |
| `Movement_Type` | `string` | Yes | Movement Type (Inventory Management) |
| `Posting_Date` | `string` | Yes | Posting Date in the Document |
| `Amount_in_Loc_curr` | `decimal(13,2)` | Yes | Amount in local currency |
| `Local_currency` | `decimal(13,2)` | Yes | Amount in document currency |
| `CURR` | `string` | Yes | Currency Key |
| `Reference_Material_Document` | `string` | Yes | Document No. of a Reference Document |
| `Co_Code` | `string` | Yes | Plant |
| `Tax_Code` | `string` | Yes | Tax on Sales/Purchases Code |
| `GR_IR` | `string` | Yes | Purchase Order History Category |
| `PO_Qty` | `decimal(13,3)` | Yes | Quantity |
| `GR_Adjustment_Amount` | `decimal(13,2)` | Yes | GR/IR account clearing value in local currency |
| `Reference_Document_Number` | `string` | Yes | Reference Document Number |
| `Debit_Credit_Indicator` | `string` | Yes | Debit/Credit Indicator |
| `Seq_no` | `string` | No | Sequential Number of Account Assignment |

## Related Pages

- [[Transport Contract Tables - transport]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
