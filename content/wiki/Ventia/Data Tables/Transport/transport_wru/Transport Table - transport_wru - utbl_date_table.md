---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: utbl_date_table
full-name: transport_dev.transport_wru.utbl_date_table
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-table, databricks, transport-wru, reference-date]
---

# Transport Table - transport_wru - utbl_date_table

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_date_table` |
| Full name | `transport_dev.transport_wru.utbl_date_table` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | MANAGED |
| Column count | 13 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | reference date |
| Source details | Created by the file upload UI |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `date` | `date` | Yes |  |
| `day_of_week` | `string` | Yes |  |
| `week_int` | `bigint` | Yes |  |
| `week_start` | `date` | Yes |  |
| `week_end` | `date` | Yes |  |
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
