---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: utbl_lane_access_lane_config
full-name: transport_dev.transport_wru.utbl_lane_access_lane_config
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - utbl_lane_access_lane_config

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_lane_access_lane_config` |
| Full name | `transport_dev.transport_wru.utbl_lane_access_lane_config` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | MANAGED |
| Column count | 7 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Business purpose | Created by the file upload UI |
| Data domain | lane access |
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-07-25T00:59:14.905Z; Last altered: 2024-09-24T01:44:41.326Z |
| Source details | Data source format: DELTA |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `NB_ROAD` | `bigint` | Yes |  |
| `RoadName` | `string` | Yes |  |
| `Chainage Direction` | `string` | Yes |  |
| `Start Chainage (SRRS)` | `bigint` | Yes |  |
| `End Chainage (SRRS)` | `bigint` | Yes |  |
| `Length` | `bigint` | Yes |  |
| `Number of Lanes` | `bigint` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
