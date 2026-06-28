---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: utbl_ref_section_to_km_mapping
full-name: transport_dev.transport_tsrc.utbl_ref_section_to_km_mapping
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - utbl_ref_section_to_km_mapping

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_ref_section_to_km_mapping` |
| Full name | `transport_dev.transport_tsrc.utbl_ref_section_to_km_mapping` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | MANAGED |
| Column count | 10 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Business purpose | Created by the file upload UI |
| Data domain | reference / mapping |
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2024-06-03T07:28:08.634Z; Last altered: 2024-06-03T07:28:08.634Z |
| Source details | Data source format: DELTA |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `id` | `bigint` | Yes |  |
| `line` | `bigint` | Yes |  |
| `line2` | `bigint` | Yes |  |
| `area` | `bigint` | Yes |  |
| `sectionid` | `string` | Yes |  |
| `interchange` | `string` | Yes |  |
| `chainage_start` | `bigint` | Yes |  |
| `chainage_end` | `bigint` | Yes |  |
| `direction` | `string` | Yes |  |
| `fulllength` | `double` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
