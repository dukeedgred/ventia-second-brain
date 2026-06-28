---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport
table-name: uvw_po_service_entry_lines_rawdata_esll
full-name: transport_dev.transport.uvw_po_service_entry_lines_rawdata_esll
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport]
---

# Transport Table - transport - uvw_po_service_entry_lines_rawdata_esll

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_po_service_entry_lines_rawdata_esll` |
| Full name | `transport_dev.transport.uvw_po_service_entry_lines_rawdata_esll` |
| Catalog | `transport_dev` |
| Schema | `transport` |
| Contract/schema | `transport` |
| Table type | VIEW |
| Column count | 12 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | commercial / finance |
| Owner/SME | bhupesh.balani@ventia.com |
| Refresh/freshness | Created: 2024-07-11T13:05:39.979Z; Last altered: 2024-07-21T19:47:15.682Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
Select distinct PACKNO as Package_Number, INTROW as Line_Number, DEL as Deletion_Indicator, MENGE as Qty, MEINS as UoM, PEINH as Price_Unit, TBTWR as Gross_Price, NETWR as Net_Price, KTEXT1 as Short_Text, ACT_MENGE as PO_Entered_Qty, ACT_WERT as PO_Entered_Value, SRVPOS as PO_Service_Number
from staged.stg_sap_hana_cf_sap_ecc.esll s
inner join transport_dev.transport.uvw_po_service_package_header_data_eslh t
ON PACKNO = t.Package_Number
where s.deleted_in_source =0
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Package_Number` | `string` | No |  |
| `Line_Number` | `string` | No |  |
| `Deletion_Indicator` | `string` | Yes |  |
| `Qty` | `decimal(13,3)` | Yes |  |
| `UoM` | `string` | Yes |  |
| `Price_Unit` | `decimal(5,0)` | Yes |  |
| `Gross_Price` | `decimal(11,2)` | Yes |  |
| `Net_Price` | `decimal(11,2)` | Yes |  |
| `Short_Text` | `string` | Yes |  |
| `PO_Entered_Qty` | `decimal(13,3)` | Yes |  |
| `PO_Entered_Value` | `decimal(11,2)` | Yes |  |
| `PO_Service_Number` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
