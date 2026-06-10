---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: utbl_ref_road_chng_10_m
full-name: transport_dev.transport_tsrc.utbl_ref_road_chng_10_m
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - utbl_ref_road_chng_10_m

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_ref_road_chng_10_m` |
| Full name | `transport_dev.transport_tsrc.utbl_ref_road_chng_10_m` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | MANAGED |
| Column count | 7 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Business purpose | Created by the file upload UI |
| Data domain | reference / mapping |
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2024-06-05T02:29:09.184Z; Last altered: 2026-06-09T05:40:05.347Z |
| Source details | Data source format: DELTA |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Asset Type` | `string` | Yes |  |
| `Asset Code` | `string` | Yes |  |
| `Direction` | `string` | Yes |  |
| `Chainage` | `bigint` | Yes |  |
| `Latitude` | `double` | Yes |  |
| `Longitude` | `double` | Yes |  |
| `Direction_AV` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
