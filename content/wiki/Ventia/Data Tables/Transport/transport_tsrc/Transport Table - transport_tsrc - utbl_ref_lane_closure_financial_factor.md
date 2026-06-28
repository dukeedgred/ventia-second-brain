---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: utbl_ref_lane_closure_financial_factor
full-name: transport_dev.transport_tsrc.utbl_ref_lane_closure_financial_factor
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - utbl_ref_lane_closure_financial_factor

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_ref_lane_closure_financial_factor` |
| Full name | `transport_dev.transport_tsrc.utbl_ref_lane_closure_financial_factor` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | MANAGED |
| Column count | 3 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Business purpose | Created by the file upload UI |
| Data domain | traffic counts / closures |
| Owner/SME | Helix_readwrite_transport_dev_transport_tsrc |
| Refresh/freshness | Created: 2024-06-05T00:48:40.337Z; Last altered: 2025-01-19T22:28:04.086Z |
| Source details | Data source format: DELTA |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Date` | `date` | Yes |  |
| `QIFq` | `double` | Yes |  |
| `BQSPq` | `double` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
