---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: utbl_counts_by_lane
full-name: transport_dev.transport_wru.utbl_counts_by_lane
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-table, databricks, transport-wru, traffic-count]
---

# Transport Table - transport_wru - utbl_counts_by_lane

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_counts_by_lane` |
| Full name | `transport_dev.transport_wru.utbl_counts_by_lane` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | MANAGED |
| Column count | 25 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | traffic count |
| Source details | Created by the file upload UI |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `SiteID` | `bigint` | Yes |  |
| `Direction` | `string` | Yes |  |
| `Lane` | `bigint` | Yes |  |
| `Date_` | `date` | Yes |  |
| `Counted` | `string` | Yes |  |
| `filename` | `string` | Yes |  |
| `CL_1` | `bigint` | Yes |  |
| `CL_2` | `bigint` | Yes |  |
| `CL_3` | `bigint` | Yes |  |
| `CL_4` | `bigint` | Yes |  |
| `CL_5` | `bigint` | Yes |  |
| `CL_6` | `bigint` | Yes |  |
| `CL_7` | `bigint` | Yes |  |
| `CL_8` | `bigint` | Yes |  |
| `CL_9` | `bigint` | Yes |  |
| `CL_10` | `bigint` | Yes |  |
| `CL_11` | `bigint` | Yes |  |
| `CL_12` | `bigint` | Yes |  |
| `CL_13` | `bigint` | Yes |  |
| `CL_14` | `bigint` | Yes |  |
| `CL_15` | `bigint` | Yes |  |
| `HCV` | `bigint` | Yes |  |
| `LV` | `bigint` | Yes |  |
| `total_count` | `bigint` | Yes |  |
| `qc` | `double` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
