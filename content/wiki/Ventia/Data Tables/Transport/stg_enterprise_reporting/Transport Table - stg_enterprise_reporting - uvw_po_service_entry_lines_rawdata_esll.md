---
type: data-table
topic: Ventia
sector: Transport
contract-schema: stg_enterprise_reporting
table-name: uvw_po_service_entry_lines_rawdata_esll
full-name: transport_dev.stg_enterprise_reporting.uvw_po_service_entry_lines_rawdata_esll
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, stg-enterprise-reporting]
---

# Transport Table - stg_enterprise_reporting - uvw_po_service_entry_lines_rawdata_esll

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_po_service_entry_lines_rawdata_esll` |
| Full name | `transport_dev.stg_enterprise_reporting.uvw_po_service_entry_lines_rawdata_esll` |
| Catalog | `transport_dev` |
| Schema | `stg_enterprise_reporting` |
| Contract/schema | `stg_enterprise_reporting` |
| Table type | VIEW |
| Column count | 3 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | commercial / finance |
| Owner/SME | bhupesh.balani@ventia.com |
| Refresh/freshness | Created: 2025-09-12T07:18:54.672Z; Last altered: 2025-09-12T07:18:54.672Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
WITH Service_PO_Qty AS (
Select
  sum(s.MENGE) as Service_PO_Qty,   
  t.EBELN as PO_Document,
  t.EBELP as Item
from staged.stg_sap_hana_cf_sap_ecc.esll s
left join staged.stg_sap_hana_cf_sap_ecc.eslh t
ON s.packno = t.PACKNO
where s.deleted_in_source =0
group by
 t.EBELN, t.EBELP
)
Select *
FROM Service_PO_Qty
WHERE startswith(PO_Document,4)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Service_PO_Qty` | `decimal(23,3)` | Yes |  |
| `PO_Document` | `string` | Yes | Purchasing Document Number |
| `Item` | `string` | Yes | Item Number of Purchasing Document |

## Related Pages

- [[Transport Contract Tables - stg_enterprise_reporting]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
