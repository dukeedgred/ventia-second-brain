---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: utbl_monthly_bins
full-name: transport_dev.transport_wru.utbl_monthly_bins
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - utbl_monthly_bins

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_monthly_bins` |
| Full name | `transport_dev.transport_wru.utbl_monthly_bins` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | MANAGED |
| Column count | 9 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Business purpose | Created by the file upload UI |
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-09-18T06:18:41.31Z; Last altered: 2024-09-24T01:44:04.747Z |
| Source details | Data source format: DELTA |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `reporting_ID` | `bigint` | Yes |  |
| `month_start` | `date` | Yes |  |
| `month_end` | `date` | Yes |  |
| `year` | `bigint` | Yes |  |
| `quarter` | `bigint` | Yes |  |
| `month_int` | `bigint` | Yes |  |
| `month_name` | `string` | Yes |  |
| `fy` | `string` | Yes |  |
| `fy_quarter` | `bigint` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
