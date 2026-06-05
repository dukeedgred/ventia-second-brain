---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_sht
table-name: utbl_tmp_nps04_nb
full-name: transport_dev.transport_sht.utbl_tmp_nps04_nb
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-table, databricks, transport-sht, temporary-staging]
---

# Transport Table - transport_sht - utbl_tmp_nps04_nb

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_tmp_nps04_nb` |
| Full name | `transport_dev.transport_sht.utbl_tmp_nps04_nb` |
| Catalog | `transport_dev` |
| Schema | `transport_sht` |
| Contract/schema | `transport_sht` |
| Table type | MANAGED |
| Column count | 1 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Business purpose | This table contains temporary data related to Net Promoter Score (NPS) or similar customer feedback metrics, stored as string values in a single column. It appears to be created via a file upload interface, likely for intermediate or temporary use during data import or processing. It may be useful for quick analysis or transformation tasks before integrating the data into permanent reporting tables. |
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
