---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport
table-name: uvw_po_header_data_ekko
full-name: transport_dev.transport.uvw_po_header_data_ekko
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport]
---

# Transport Table - transport - uvw_po_header_data_ekko

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_po_header_data_ekko` |
| Full name | `transport_dev.transport.uvw_po_header_data_ekko` |
| Catalog | `transport_dev` |
| Schema | `transport` |
| Contract/schema | `transport` |
| Table type | VIEW |
| Column count | 11 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | commercial / finance |
| Owner/SME | bhupesh.balani@ventia.com |
| Refresh/freshness | Created: 2024-07-26T03:12:35.635Z; Last altered: 2024-07-26T03:12:35.635Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
Select distinct EBELN as PO_Document, BSART as PO_Document_Type, BUKRS as Co_Code, AEDAT as Creation_Date, LIFNR as Vendor_Number, ZTERM as Payment_Terms, EKORG as Purchase_Org, EKGRP as Purch_Grp, WAERS as CURR, BEDAT as Document_Date, MEMORY as OnHold_X_
from staged.stg_sap_hana_cf_sap_ecc.ekko s
inner join transport_dev.transport.uvw_purgrp_masterdata_uniquelist t
ON EKGRP = t.PUR_GRP_FROM
where s.deleted_in_source =0
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `PO_Document` | `string` | No |  |
| `PO_Document_Type` | `string` | Yes |  |
| `Co_Code` | `string` | Yes |  |
| `Creation_Date` | `string` | Yes |  |
| `Vendor_Number` | `string` | Yes |  |
| `Payment_Terms` | `string` | Yes |  |
| `Purchase_Org` | `string` | Yes |  |
| `Purch_Grp` | `string` | Yes |  |
| `CURR` | `string` | Yes |  |
| `Document_Date` | `string` | Yes |  |
| `OnHold_X_` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
