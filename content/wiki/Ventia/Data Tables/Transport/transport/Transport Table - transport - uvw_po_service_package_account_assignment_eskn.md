---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport
table-name: uvw_po_service_package_account_assignment_eskn
full-name: transport_dev.transport.uvw_po_service_package_account_assignment_eskn
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport]
---

# Transport Table - transport - uvw_po_service_package_account_assignment_eskn

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_po_service_package_account_assignment_eskn` |
| Full name | `transport_dev.transport.uvw_po_service_package_account_assignment_eskn` |
| Catalog | `transport_dev` |
| Schema | `transport` |
| Contract/schema | `transport` |
| Table type | VIEW |
| Column count | 14 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | commercial / finance |
| Owner/SME | bhupesh.balani@ventia.com |
| Refresh/freshness | Created: 2025-04-04T12:15:49.666Z; Last altered: 2025-04-04T12:15:49.666Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
Select distinct PACKNO as Entry_Sheet_Number, LOEKZ as Deletion_Indicator, AEDAT as Created_Date, format_string(int(SAKTO)) as GL_Account, format_string(int(KOSTL)) as Cost_Centre, format_string(int(AUFNR)) as Order_Number, EREKZ as Final_Invoice_Indicator, format_string(int(PRCTR)) as Profit_Centre, format_string(int(PS_PSP_PNR)) as WBS_Element, format_string(int(NPLNR)) as Network_Number, WPROZ as Distribution_Percentage, s.ZEKKN as Seq_no, u.PO_Document, u.Item_Number
from staged.stg_sap_hana_cf_sap_ecc.eskn s
inner join transport_dev.transport.uvw_pc_masterdata t
ON format_string(int(PRCTR)) = t.PC_ID
left join transport_dev.transport.uvw_po_service_entry_header_data_essr u
on s.PACKNO=u.Entry_Sheet_Number
where s.deleted_in_source =0
UNION all
Select distinct PACKNO as Entry_Sheet_Number, LOEKZ as Deletion_Indicator, AEDAT as Created_Date, format_string(int(SAKTO)) as GL_Account, format_string(int(KOSTL)) as Cost_Centre, format_string(int(AUFNR)) as Order_Number, EREKZ as Final_Invoice_Indicator, format_string(int(PRCTR)) as Profit_Centre, format_string(int(PS_PSP_PNR)) as WBS_Element, format_string(int(NPLNR)) as Network_Number, WPROZ as Distribution_Percentage, s.ZEKKN as Seq_no, u.PO_Document, u.Item_Number
from staged.stg_sap_hana_cf_sap_ecc.eskn s
left join transport_dev.transport.uvw_po_service_entry_header_data_essr u
on s.PACKNO=u.Entry_Sheet_Number
where int(PRCTR)=90240 and s.deleted_in_source =0
UNION all
Select distinct PACKNO as Entry_Sheet_Number, LOEKZ as Deletion_Indicator, AEDAT as Created_Date, format_string(int(SAKTO)) as GL_Account, format_string(int(KOSTL)) as Cost_Centre, format_string(int(AUFNR)) as Order_Number, EREKZ as Final_Invoice_Indicator, format_string(int(PRCTR)) as Profit_Centre, format_string(int(PS_PSP_PNR)) as WBS_Element, format_string(int(NPLNR)) as Network_Number, WPROZ as Distribution_Percentage, s.ZEKKN as Seq_no, u.PO_Document, u.Item_Number
from staged.stg_sap_hana_cf_sap_ecc.eskn s
left join transport_dev.transport.uvw_po_service_entry_header_data_essr u
on s.PACKNO=u.Entry_Sheet_Number
where int(PRCTR)=90050 and s.deleted_in_source =0
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Entry_Sheet_Number` | `string` | No | Package number |
| `Deletion_Indicator` | `string` | Yes | Deletion Indicator: Purchasing Document Account Assignment |
| `Created_Date` | `string` | Yes | Record Creation Date |
| `GL_Account` | `string` | Yes |  |
| `Cost_Centre` | `string` | Yes |  |
| `Order_Number` | `string` | Yes |  |
| `Final_Invoice_Indicator` | `string` | Yes | Final Invoice Indicator |
| `Profit_Centre` | `string` | Yes |  |
| `WBS_Element` | `string` | Yes |  |
| `Network_Number` | `string` | Yes |  |
| `Distribution_Percentage` | `decimal(4,1)` | Yes | Percentage for Account Assignment Value Distribution |
| `Seq_no` | `string` | No | Sequential Number of Account Assignment |
| `PO_Document` | `string` | Yes |  |
| `Item_Number` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
