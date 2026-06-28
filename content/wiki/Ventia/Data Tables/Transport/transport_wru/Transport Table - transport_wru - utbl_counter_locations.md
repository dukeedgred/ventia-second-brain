---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: utbl_counter_locations
full-name: transport_dev.transport_wru.utbl_counter_locations
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-table, databricks, transport-wru, traffic-counter]
---

# Transport Table - transport_wru - utbl_counter_locations

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_counter_locations` |
| Full name | `transport_dev.transport_wru.utbl_counter_locations` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | MANAGED |
| Column count | 24 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | traffic counter |
| Source details | Created by the file upload UI |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `TMS_Code` | `string` | Yes |  |
| `Metrocount ID` | `bigint` | Yes |  |
| `Name` | `string` | Yes |  |
| `Parent_Asset_Code` | `bigint` | Yes |  |
| `Parent_Asset_Name` | `string` | Yes |  |
| `Parent_Direction` | `string` | Yes |  |
| `Parent_TDI` | `bigint` | Yes |  |
| `Criticality` | `string` | Yes |  |
| `Condition` | `string` | Yes |  |
| `Risk` | `string` | Yes |  |
| `Classification` | `string` | Yes |  |
| `Alert_Notes` | `string` | Yes |  |
| `Parent_Asset_Type` | `string` | Yes |  |
| `Last_Modified` | `string` | Yes |  |
| `Latitude` | `double` | Yes |  |
| `Longitude` | `double` | Yes |  |
| `Contract` | `string` | Yes |  |
| `Area` | `string` | Yes |  |
| `Locations` | `string` | Yes |  |
| `Site_Name` | `string` | Yes |  |
| `Existing_Lanes` | `bigint` | Yes |  |
| `Speed_Zone` | `string` | Yes |  |
| `WKT` | `string` | Yes |  |
| `Colour code` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
