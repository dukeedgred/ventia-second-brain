---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: utbl_aed_incidents_sr
full-name: transport_dev.transport_tsrc.utbl_aed_incidents_sr
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - utbl_aed_incidents_sr

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_aed_incidents_sr` |
| Full name | `transport_dev.transport_tsrc.utbl_aed_incidents_sr` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | MANAGED |
| Column count | 14 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Business purpose | Created by the file upload UI |
| Data domain | incidents |
| Owner/SME | Helix_readwrite_corporate_dev |
| Refresh/freshness | Created: 2024-09-20T06:22:33.116Z; Last altered: 2024-10-22T03:42:50.492Z |
| Source details | Data source format: DELTA |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Line` | `bigint` | Yes |  |
| `Id` | `bigint` | Yes |  |
| `Service` | `string` | Yes |  |
| `Description` | `string` | Yes |  |
| `Reporter` | `string` | Yes |  |
| `ReportedDate` | `timestamp` | Yes |  |
| `Asset` | `string` | Yes |  |
| `Status` | `string` | Yes |  |
| `StatusDate` | `timestamp` | Yes |  |
| `SRState` | `string` | Yes |  |
| `WONum` | `bigint` | Yes |  |
| `WODesc` | `string` | Yes |  |
| `WOCreate` | `timestamp` | Yes |  |
| `WOStatus` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
