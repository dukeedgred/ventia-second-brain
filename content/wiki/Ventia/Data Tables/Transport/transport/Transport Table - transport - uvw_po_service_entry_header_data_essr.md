---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport
table-name: uvw_po_service_entry_header_data_essr
full-name: transport_dev.transport.uvw_po_service_entry_header_data_essr
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport]
---

# Transport Table - transport - uvw_po_service_entry_header_data_essr

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_po_service_entry_header_data_essr` |
| Full name | `transport_dev.transport.uvw_po_service_entry_header_data_essr` |
| Catalog | `transport_dev` |
| Schema | `transport` |
| Contract/schema | `transport` |
| Table type | VIEW |
| Column count | 18 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | commercial / finance |
| Owner/SME | bhupesh.balani@ventia.com |
| Refresh/freshness | Created: 2024-07-11T12:46:44.448Z; Last altered: 2024-07-21T19:47:17.51Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
Select distinct LBLNI as Entry_Sheet_Number, LBLNE as External_Entry_Sheet_Number, ERNAM as Name_of_Person_created_the_object, ERDAT as Created_Date, AEDAT as Changed_On, LZVON as Period, LWERT as Value_of_Services, WAERS as CURR, PACKNO as Package_Number, TXZ01 as Short_Text, EBELN as PO_Document, EBELP as Item_Number, LOEKZ as Deletion_Indicator, BLDAT as Document_Date, BUDAT as Posting_Date, XBLNR as Reference_Document_Number, BKTXT as Document_Header_Text, KNTTP as Account_Assignment_Catergory
from staged.stg_sap_hana_cf_sap_ecc.essr s
inner join transport_dev.transport.uvw_po_header_data_ekko t
ON EBELN = t.PO_Document
where s.deleted_in_source =0
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Entry_Sheet_Number` | `string` | No |  |
| `External_Entry_Sheet_Number` | `string` | Yes |  |
| `Name_of_Person_created_the_object` | `string` | Yes |  |
| `Created_Date` | `string` | Yes |  |
| `Changed_On` | `string` | Yes |  |
| `Period` | `string` | Yes |  |
| `Value_of_Services` | `decimal(11,2)` | Yes |  |
| `CURR` | `string` | Yes |  |
| `Package_Number` | `string` | Yes |  |
| `Short_Text` | `string` | Yes |  |
| `PO_Document` | `string` | Yes |  |
| `Item_Number` | `string` | Yes |  |
| `Deletion_Indicator` | `string` | Yes |  |
| `Document_Date` | `string` | Yes |  |
| `Posting_Date` | `string` | Yes |  |
| `Reference_Document_Number` | `string` | Yes |  |
| `Document_Header_Text` | `string` | Yes |  |
| `Account_Assignment_Catergory` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
