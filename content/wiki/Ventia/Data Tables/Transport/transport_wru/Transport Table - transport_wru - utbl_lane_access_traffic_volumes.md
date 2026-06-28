---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: utbl_lane_access_traffic_volumes
full-name: transport_dev.transport_wru.utbl_lane_access_traffic_volumes
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - utbl_lane_access_traffic_volumes

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_lane_access_traffic_volumes` |
| Full name | `transport_dev.transport_wru.utbl_lane_access_traffic_volumes` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | MANAGED |
| Column count | 10 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Business purpose | Created by the file upload UI |
| Data domain | traffic counts / closures |
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-07-25T01:00:50.5Z; Last altered: 2024-09-24T01:44:22.716Z |
| Source details | Data source format: DELTA |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Road_ID` | `bigint` | Yes |  |
| `Road_Name` | `string` | Yes |  |
| `Direction` | `string` | Yes |  |
| `Chainage_S` | `bigint` | Yes |  |
| `Chainage_E` | `bigint` | Yes |  |
| `Annual Increasing Rate` | `double` | Yes |  |
| `DOW` | `bigint` | Yes |  |
| `Period` | `bigint` | Yes |  |
| `Year` | `bigint` | Yes |  |
| `Traffic_Vol` | `bigint` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
