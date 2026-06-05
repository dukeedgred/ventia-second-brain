---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: utbl_aed_incidents_events
full-name: transport_dev.transport_tsrc.utbl_aed_incidents_events
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-table, databricks, transport-tsrc, incident-event]
---

# Transport Table - transport_tsrc - utbl_aed_incidents_events

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_aed_incidents_events` |
| Full name | `transport_dev.transport_tsrc.utbl_aed_incidents_events` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | MANAGED |
| Column count | 6 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | incident event |
| Source details | Created by the file upload UI |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Event ID` | `bigint` | Yes |  |
| `Incident No` | `bigint` | Yes |  |
| `event` | `string` | Yes |  |
| `description` | `string` | Yes |  |
| `OccurredOn` | `timestamp` | Yes |  |
| `Creator` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
