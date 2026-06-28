---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport
table-name: uvw_po_account_assignment_ekkn
full-name: transport_dev.transport.uvw_po_account_assignment_ekkn
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport]
---

# Transport Table - transport - uvw_po_account_assignment_ekkn

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_po_account_assignment_ekkn` |
| Full name | `transport_dev.transport.uvw_po_account_assignment_ekkn` |
| Catalog | `transport_dev` |
| Schema | `transport` |
| Contract/schema | `transport` |
| Table type | VIEW |
| Column count | 15 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | commercial / finance |
| Owner/SME | bhupesh.balani@ventia.com |
| Refresh/freshness | Created: 2025-04-04T06:35:11.21Z; Last altered: 2025-04-04T06:35:11.21Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
Select distinct EBELN as PO_Document, EBELP as Item, format_string(int(SAKTO)) as GL_Account, format_string(int(KOSTL)) as Cost_Centre, format_string(int(PRCTR)) as Profit_Centre, AUFPL_ORD as Service_Order, APLZL_ORD as Activity, format_string(int(PS_PSP_PNR)) as WBS_Element_Key, format_string(int(NPLNR)) as Network_Number, format_string(int(AUFNR)) as Order_Number, VPROZ as Distribution_Percentage, s.MENGE as Distribution_Qty, s.ZEKKN as Seq_no, u.Distribution_Indicator, v_TDQ.Total_Distribution_Qty
from staged.stg_sap_hana_cf_sap_ecc.ekkn s
inner join transport_dev.transport.uvw_po_header_data_ekko t
ON EBELN = t.PO_Document
left join transport_dev.transport.uvw_po_item_data_ekpo u
on concat(s.EBELN,'-',s.ebelp) = concat(u.PO_Document,'-',u.item)
left join(
  select concat(v.ebeln,'-',v.ebelp) as LookUp, sum(v.MENGE) as Total_Distribution_Qty
  from staged.stg_sap_hana_cf_sap_ecc.ekkn v
  where v.deleted_in_source=0
  group by
    concat(v.ebeln,'-',v.ebelp)
) as v_TDQ
on concat(s.EBELN,'-',s.ebelp)=v_TDQ.LookUp
where s.deleted_in_source =0
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `PO_Document` | `string` | No | Purchasing Document Number |
| `Item` | `string` | No | Item Number of Purchasing Document |
| `GL_Account` | `string` | Yes |  |
| `Cost_Centre` | `string` | Yes |  |
| `Profit_Centre` | `string` | Yes |  |
| `Service_Order` | `string` | Yes | Routing number of operations in the order |
| `Activity` | `string` | Yes | General counter for order |
| `WBS_Element_Key` | `string` | Yes |  |
| `Network_Number` | `string` | Yes |  |
| `Order_Number` | `string` | Yes |  |
| `Distribution_Percentage` | `decimal(3,1)` | Yes | Distribution percentage in the case of multiple acct assgt |
| `Distribution_Qty` | `decimal(13,3)` | Yes | Quantity |
| `Seq_no` | `string` | No | Sequential Number of Account Assignment |
| `Distribution_Indicator` | `string` | Yes | Distribution indicator for multiple account assignment |
| `Total_Distribution_Qty` | `decimal(23,3)` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
