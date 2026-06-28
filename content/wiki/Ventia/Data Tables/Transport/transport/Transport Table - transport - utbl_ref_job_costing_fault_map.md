---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport
table-name: utbl_ref_job_costing_fault_map
full-name: transport_dev.transport.utbl_ref_job_costing_fault_map
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport]
---

# Transport Table - transport - utbl_ref_job_costing_fault_map

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_ref_job_costing_fault_map` |
| Full name | `transport_dev.transport.utbl_ref_job_costing_fault_map` |
| Catalog | `transport_dev` |
| Schema | `transport` |
| Contract/schema | `transport` |
| Table type | MANAGED |
| Column count | 4 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Business purpose | Created by the file upload UI |
| Data domain | jobs / work orders |
| Owner/SME | hui.chen@ventia.com |
| Refresh/freshness | Created: 2024-08-01T00:39:41.62Z; Last altered: 2024-08-01T00:39:41.62Z |
| Source details | Data source format: DELTA |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Fault` | `string` | Yes |  |
| `Contract` | `string` | Yes |  |
| `Code Type` | `string` | Yes |  |
| `Code` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
