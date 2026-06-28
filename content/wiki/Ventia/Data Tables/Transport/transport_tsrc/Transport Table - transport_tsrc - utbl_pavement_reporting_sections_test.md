---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: utbl_pavement_reporting_sections_test
full-name: transport_dev.transport_tsrc.utbl_pavement_reporting_sections_test
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - utbl_pavement_reporting_sections_test

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_pavement_reporting_sections_test` |
| Full name | `transport_dev.transport_tsrc.utbl_pavement_reporting_sections_test` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | MANAGED |
| Column count | 12 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Business purpose | Created by the file upload UI |
| Data domain | capital works / forward works |
| Owner/SME | huy.nguyen@ventia.com |
| Refresh/freshness | Created: 2026-03-04T04:53:45.943Z; Last altered: 2026-03-04T05:46:55.105Z |
| Source details | Data source format: DELTA |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `PavementReportingSection` | `string` | Yes |  |
| `Name` | `string` | Yes |  |
| `RoadName` | `string` | Yes |  |
| `Direction` | `string` | Yes |  |
| `ReportingSectionType` | `string` | Yes |  |
| `FromDesc` | `string` | Yes |  |
| `ToDesc` | `string` | Yes |  |
| `StartChainage` | `bigint` | Yes |  |
| `EndChainage` | `bigint` | Yes |  |
| `Length` | `bigint` | Yes |  |
| `From` | `bigint` | Yes |  |
| `To` | `bigint` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
