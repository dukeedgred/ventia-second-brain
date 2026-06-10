---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport
table-name: uvw_po_delivery_dates_eket
full-name: transport_dev.transport.uvw_po_delivery_dates_eket
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport]
---

# Transport Table - transport - uvw_po_delivery_dates_eket

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_po_delivery_dates_eket` |
| Full name | `transport_dev.transport.uvw_po_delivery_dates_eket` |
| Catalog | `transport_dev` |
| Schema | `transport` |
| Contract/schema | `transport` |
| Table type | VIEW |
| Column count | 4 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | commercial / finance |
| Owner/SME | bhupesh.balani@ventia.com |
| Refresh/freshness | Created: 2024-07-29T01:44:18.765Z; Last altered: 2024-07-29T01:44:18.765Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
Select distinct EBELN as PO_Document, EBELP as Item, EINDT as Delivery_Date, if(int(left(EINDT,6))<int(date_format(now(), 'yyyyMM')),'Prior Month', if(int(left(EINDT,6))=int(date_format(now(), 'yyyyMM')),'Current Month','Future Month')) as Due
from staged.stg_sap_hana_cf_sap_ecc.eket s
inner join transport_dev.transport.uvw_po_header_data_ekko t
ON EBELN = t.PO_Document
where s.deleted_in_source =0
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `PO_Document` | `string` | No |  |
| `Item` | `string` | No |  |
| `Delivery_Date` | `string` | Yes |  |
| `Due` | `string` | No |  |

## Related Pages

- [[Transport Contract Tables - transport]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
