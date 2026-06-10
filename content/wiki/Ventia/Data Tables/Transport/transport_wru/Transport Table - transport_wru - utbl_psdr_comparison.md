---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: utbl_psdr_comparison
full-name: transport_dev.transport_wru.utbl_psdr_comparison
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - utbl_psdr_comparison

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_psdr_comparison` |
| Full name | `transport_dev.transport_wru.utbl_psdr_comparison` |
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
| Refresh/freshness | Created: 2024-09-24T22:44:13.527Z; Last altered: 2024-09-24T22:44:13.527Z |
| Source details | Data source format: DELTA |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Date_` | `date` | Yes |  |
| `PSDR_projections` | `bigint` | Yes |  |
| `Year_` | `bigint` | Yes |  |
| `HCV` | `double` | Yes |  |
| `HCV_backfilled` | `double` | Yes |  |
| `percent_working_sensor` | `double` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
