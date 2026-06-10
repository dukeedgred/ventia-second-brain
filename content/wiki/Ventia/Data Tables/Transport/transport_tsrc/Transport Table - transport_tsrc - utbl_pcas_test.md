---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: utbl_pcas_test
full-name: transport_dev.transport_tsrc.utbl_pcas_test
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - utbl_pcas_test

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_pcas_test` |
| Full name | `transport_dev.transport_tsrc.utbl_pcas_test` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | MANAGED |
| Column count | 17 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Business purpose | Created by the file upload UI |
| Data domain | capital works / forward works |
| Owner/SME | huy.nguyen@ventia.com |
| Refresh/freshness | Created: 2026-03-04T04:43:37.732Z; Last altered: 2026-06-09T05:40:05.508Z |
| Source details | Data source format: DELTA |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `WKT` | `string` | Yes |  |
| `SurveyYear` | `bigint` | Yes |  |
| `PavementSectionID` | `string` | Yes |  |
| `fid` | `bigint` | Yes |  |
| `location` | `string` | Yes |  |
| `shape_Leng` | `double` | Yes |  |
| `RoadName` | `string` | Yes |  |
| `lane` | `bigint` | Yes |  |
| `direction` | `string` | Yes |  |
| `x_start` | `double` | Yes |  |
| `y_start` | `double` | Yes |  |
| `x_end` | `double` | Yes |  |
| `y_end` | `double` | Yes |  |
| `chainage_start` | `bigint` | Yes |  |
| `chainage_end` | `bigint` | Yes |  |
| `IRI_O` | `double` | Yes |  |
| `IRI_I` | `double` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
