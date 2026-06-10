---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: utbl_raw_data_march
full-name: transport_dev.transport_wru.utbl_raw_data_march
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - utbl_raw_data_march

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_raw_data_march` |
| Full name | `transport_dev.transport_wru.utbl_raw_data_march` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | MANAGED |
| Column count | 6 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Business purpose | Created by the file upload UI |
| Owner/SME | rui.luan@ventia.com |
| Refresh/freshness | Created: 2024-09-24T23:02:55.858Z; Last altered: 2026-06-09T06:23:32.227Z |
| Source details | Data source format: DELTA |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `SiteID` | `bigint` | Yes |  |
| `Direction` | `string` | Yes |  |
| `Lane` | `bigint` | Yes |  |
| `Date_` | `date` | Yes |  |
| `Time` | `timestamp` | Yes |  |
| `vclass` | `bigint` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
