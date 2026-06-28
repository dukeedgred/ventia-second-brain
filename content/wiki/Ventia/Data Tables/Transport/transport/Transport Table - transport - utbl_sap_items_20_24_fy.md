---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport
table-name: utbl_sap_items_20_24_fy
full-name: transport_dev.transport.utbl_sap_items_20_24_fy
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport]
---

# Transport Table - transport - utbl_sap_items_20_24_fy

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_sap_items_20_24_fy` |
| Full name | `transport_dev.transport.utbl_sap_items_20_24_fy` |
| Catalog | `transport_dev` |
| Schema | `transport` |
| Contract/schema | `transport` |
| Table type | MANAGED |
| Column count | 22 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Business purpose | Created by the file upload UI |
| Data domain | commercial / finance |
| Owner/SME | hui.chen@ventia.com |
| Refresh/freshness | Created: 2024-08-01T05:01:18.79Z; Last altered: 2026-06-08T23:47:28.297Z |
| Source details | Data source format: DELTA |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Contract` | `string` | Yes |  |
| `Document Date` | `date` | Yes |  |
| `Posting Date` | `date` | Yes |  |
| `Ref. document number` | `string` | Yes |  |
| `UserID` | `string` | Yes |  |
| `GL Mapping` | `string` | Yes |  |
| `Cost Element` | `bigint` | Yes |  |
| `Cost Element Description` | `string` | Yes |  |
| `Document Header Text` | `string` | Yes |  |
| `Text` | `string` | Yes |  |
| `Vendor Name` | `string` | Yes |  |
| `PO` | `double` | Yes |  |
| `PO Item` | `double` | Yes |  |
| `Employee No` | `double` | Yes |  |
| `Employee Name` | `string` | Yes |  |
| `Quantity` | `double` | Yes |  |
| `UOM` | `string` | Yes |  |
| `Amount` | `double` | Yes |  |
| `CURR` | `string` | Yes |  |
| `Cost Object` | `string` | Yes |  |
| `Cost Object Name` | `string` | Yes |  |
| `Document Type` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
