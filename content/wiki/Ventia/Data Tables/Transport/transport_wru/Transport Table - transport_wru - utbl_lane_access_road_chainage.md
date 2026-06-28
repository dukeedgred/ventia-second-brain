---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: utbl_lane_access_road_chainage
full-name: transport_dev.transport_wru.utbl_lane_access_road_chainage
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - utbl_lane_access_road_chainage

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_lane_access_road_chainage` |
| Full name | `transport_dev.transport_wru.utbl_lane_access_road_chainage` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | MANAGED |
| Column count | 5 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Business purpose | Created by the file upload UI |
| Data domain | lane access |
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-07-25T00:59:56.733Z; Last altered: 2024-09-24T01:44:31.576Z |
| Source details | Data source format: DELTA |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Road_No` | `bigint` | Yes |  |
| `Direction` | `string` | Yes |  |
| `Start` | `bigint` | Yes |  |
| `End` | `bigint` | Yes |  |
| `Divided Section` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
