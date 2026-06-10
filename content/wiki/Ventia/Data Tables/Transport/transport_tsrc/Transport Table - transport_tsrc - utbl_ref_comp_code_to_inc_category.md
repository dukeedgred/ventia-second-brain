---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: utbl_ref_comp_code_to_inc_category
full-name: transport_dev.transport_tsrc.utbl_ref_comp_code_to_inc_category
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - utbl_ref_comp_code_to_inc_category

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_ref_comp_code_to_inc_category` |
| Full name | `transport_dev.transport_tsrc.utbl_ref_comp_code_to_inc_category` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | MANAGED |
| Column count | 6 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Business purpose | Created by the file upload UI |
| Data domain | reference / mapping |
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2024-05-29T04:48:10.963Z; Last altered: 2024-05-29T04:49:34.919Z |
| Source details | Data source format: DELTA |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `id` | `bigint` | Yes |  |
| `completion_code` | `string` | Yes |  |
| `completion_value` | `string` | Yes |  |
| `parent_category_code` | `string` | Yes |  |
| `parent_category_value` | `string` | Yes |  |
| `parent_category` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
