---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: utbl_inspection_road_sections
full-name: transport_dev.transport_wru.utbl_inspection_road_sections
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - utbl_inspection_road_sections

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_inspection_road_sections` |
| Full name | `transport_dev.transport_wru.utbl_inspection_road_sections` |
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
| Data domain | inspection / audit / condition |
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-06-18T11:57:39.512Z; Last altered: 2026-01-16T11:10:18.944Z |
| Source details | Data source format: DELTA |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Asset_Type` | `string` | Yes |  |
| `Asset_Code` | `bigint` | Yes |  |
| `Asset_Name` | `string` | Yes |  |
| `Classification` | `string` | Yes |  |
| `Section_Name` | `string` | Yes |  |
| `Section_Desc` | `string` | Yes |  |
| `Forward_Start_Chainage` | `bigint` | Yes |  |
| `Forward_End_Chainage` | `bigint` | Yes |  |
| `Reverse_Start_Chainage` | `bigint` | Yes |  |
| `Reverse_End_Chainage` | `bigint` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
