---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport
table-name: uvw_po_service_package_header_data_eslh
full-name: transport_dev.transport.uvw_po_service_package_header_data_eslh
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport]
---

# Transport Table - transport - uvw_po_service_package_header_data_eslh

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_po_service_package_header_data_eslh` |
| Full name | `transport_dev.transport.uvw_po_service_package_header_data_eslh` |
| Catalog | `transport_dev` |
| Schema | `transport` |
| Contract/schema | `transport` |
| Table type | VIEW |
| Column count | 7 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | commercial / finance |
| Owner/SME | bhupesh.balani@ventia.com |
| Refresh/freshness | Created: 2024-07-11T13:03:58.352Z; Last altered: 2024-07-21T19:47:17.135Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
Select distinct PACKNO as Package_Number, DEL as Deletion_Indicator, FPACKNO as Parent_Package_Number, EBELN as PO_Document, EBELP as Item_Number, WAERS as CURR, SUM_NETWR as Net_Value
from staged.stg_sap_hana_cf_sap_ecc.eslh s
inner join transport_dev.transport.uvw_po_header_data_ekko t
ON EBELN = t.PO_Document
where s.deleted_in_source =0
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Package_Number` | `string` | No |  |
| `Deletion_Indicator` | `string` | Yes |  |
| `Parent_Package_Number` | `string` | Yes |  |
| `PO_Document` | `string` | Yes |  |
| `Item_Number` | `string` | Yes |  |
| `CURR` | `string` | Yes |  |
| `Net_Value` | `decimal(15,2)` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
