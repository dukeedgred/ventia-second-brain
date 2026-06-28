---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_srapc
table-name: utbl_monthly_report
full-name: transport_dev.transport_srapc.utbl_monthly_report
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-table, databricks, transport-srapc, monthly-reporting]
---

# Transport Table - transport_srapc - utbl_monthly_report

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_monthly_report` |
| Full name | `transport_dev.transport_srapc.utbl_monthly_report` |
| Catalog | `transport_dev` |
| Schema | `transport_srapc` |
| Contract/schema | `transport_srapc` |
| Table type | MANAGED |
| Column count | 12 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | monthly reporting |
| Source details | Created by the file upload UI |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `date_key` | `bigint` | Yes |  |
| `date` | `date` | Yes |  |
| `full_date` | `string` | Yes |  |
| `month` | `bigint` | Yes |  |
| `month_name` | `string` | Yes |  |
| `quarter` | `bigint` | Yes |  |
| `quarter_name` | `string` | Yes |  |
| `year` | `bigint` | Yes |  |
| `year_name` | `string` | Yes |  |
| `month_year` | `string` | Yes |  |
| `mmyyyy` | `bigint` | Yes |  |
| `is_weekday` | `boolean` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_srapc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
