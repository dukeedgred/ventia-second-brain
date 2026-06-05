---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_sht
table-name: utbl_tmp_tvs07_nb
full-name: transport_dev.transport_sht.utbl_tmp_tvs07_nb
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-table, databricks, transport-sht, temporary-staging]
---

# Transport Table - transport_sht - utbl_tmp_tvs07_nb

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_tmp_tvs07_nb` |
| Full name | `transport_dev.transport_sht.utbl_tmp_tvs07_nb` |
| Catalog | `transport_dev` |
| Schema | `transport_sht` |
| Contract/schema | `transport_sht` |
| Table type | MANAGED |
| Column count | 1 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Business purpose | This table contains a temporary dataset created via the file upload interface, with a single string column named 'value'. It appears to serve as a staging or intermediate storage for data before further processing or transformation. Use cases include temporarily holding data imported from external sources for validation, cleansing, or loading into more structured tables. |
| Data domain | temporary staging |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `value` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_sht]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
