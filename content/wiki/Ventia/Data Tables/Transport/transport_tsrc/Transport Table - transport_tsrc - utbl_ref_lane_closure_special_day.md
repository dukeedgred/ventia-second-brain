---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: utbl_ref_lane_closure_special_day
full-name: transport_dev.transport_tsrc.utbl_ref_lane_closure_special_day
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - utbl_ref_lane_closure_special_day

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_ref_lane_closure_special_day` |
| Full name | `transport_dev.transport_tsrc.utbl_ref_lane_closure_special_day` |
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
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2024-06-05T00:31:49.448Z; Last altered: 2024-08-23T00:46:34.006Z |
| Source details | Data source format: DELTA |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Day` | `date` | Yes |  |
| `Factor` | `bigint` | Yes |  |
| `Day_Description` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
