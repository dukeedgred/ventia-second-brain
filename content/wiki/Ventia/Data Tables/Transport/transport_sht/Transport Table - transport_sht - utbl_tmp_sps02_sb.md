---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_sht
table-name: utbl_tmp_sps02_sb
full-name: transport_dev.transport_sht.utbl_tmp_sps02_sb
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-table, databricks, transport-sht, temporary-staging]
---

# Transport Table - transport_sht - utbl_tmp_sps02_sb

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_tmp_sps02_sb` |
| Full name | `transport_dev.transport_sht.utbl_tmp_sps02_sb` |
| Catalog | `transport_dev` |
| Schema | `transport_sht` |
| Contract/schema | `transport_sht` |
| Table type | MANAGED |
| Column count | 1 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Business purpose | This table contains data imported through a file upload interface. It includes a single column labeled 'value' which stores string entries. The table is suitable for temporary or intermediary storage of textual data during data processing or integration workflows in transportation-related projects. |
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
