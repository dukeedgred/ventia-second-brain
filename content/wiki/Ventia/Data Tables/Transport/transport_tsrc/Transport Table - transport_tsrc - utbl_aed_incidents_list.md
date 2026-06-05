---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: utbl_aed_incidents_list
full-name: transport_dev.transport_tsrc.utbl_aed_incidents_list
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-table, databricks, transport-tsrc, incident]
---

# Transport Table - transport_tsrc - utbl_aed_incidents_list

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_aed_incidents_list` |
| Full name | `transport_dev.transport_tsrc.utbl_aed_incidents_list` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | MANAGED |
| Column count | 11 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | incident |
| Source details | Created by the file upload UI |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Incident Id` | `bigint` | Yes |  |
| `Incident` | `string` | Yes |  |
| `IncidentType` | `string` | Yes |  |
| `Status` | `string` | Yes |  |
| `StatusDate` | `timestamp` | Yes |  |
| `section` | `string` | Yes |  |
| `IncidentLocation` | `string` | Yes |  |
| `TrafficDirection` | `string` | Yes |  |
| `SeverityDescription` | `string` | Yes |  |
| `DetectionMethod` | `string` | Yes |  |
| `DetectionReference` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
