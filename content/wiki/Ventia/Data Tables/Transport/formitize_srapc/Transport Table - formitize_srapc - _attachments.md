---
type: data-table
topic: Ventia
sector: Transport
contract-schema: formitize_srapc
table-name: _attachments
full-name: transport_dev.formitize_srapc._attachments
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, formitize-srapc]
---

# Transport Table - formitize_srapc - _attachments

## Identity

| Field | Value |
|---|---|
| Table name | `_attachments` |
| Full name | `transport_dev.formitize_srapc._attachments` |
| Catalog | `transport_dev` |
| Schema | `formitize_srapc` |
| Contract/schema | `formitize_srapc` |
| Table type | MANAGED |
| Column count | 9 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | documents / evidence |
| Owner/SME | bd8c9950-d6b9-496b-95eb-be4d7211e1e9 |
| Refresh/freshness | Created: 2025-03-20T07:19:11.155Z; Last altered: 2025-08-26T01:26:39.334Z |
| Source details | Data source format: DELTA |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `submittedFormID` | `int` | No |  |
| `formID` | `int` | Yes |  |
| `version` | `int` | Yes |  |
| `attachment_id` | `double` | No |  |
| `name` | `string` | Yes |  |
| `type` | `string` | Yes |  |
| `url` | `string` | Yes |  |
| `row_updated_exec_id` | `string` | Yes |  |
| `row_updated_timestamp` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - formitize_srapc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
