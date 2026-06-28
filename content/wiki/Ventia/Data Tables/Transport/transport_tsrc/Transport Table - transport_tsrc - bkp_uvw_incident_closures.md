---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: bkp_uvw_incident_closures
full-name: transport_dev.transport_tsrc.bkp_uvw_incident_closures
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-table, databricks, transport-tsrc, incident-closure]
---

# Transport Table - transport_tsrc - bkp_uvw_incident_closures

## Identity

| Field | Value |
|---|---|
| Table name | `bkp_uvw_incident_closures` |
| Full name | `transport_dev.transport_tsrc.bkp_uvw_incident_closures` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | MANAGED |
| Column count | 6 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | incident closure |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `parentsourcetableid` | `int` | Yes |  |
| `IncidentClosureDetails-TGS` | `string` | Yes |  |
| `IncidentClosureDetails-ClosurePurpose` | `string` | Yes |  |
| `IncidentClosureDetails-ClosureType` | `string` | Yes |  |
| `IncidentClosureDetails-Section` | `string` | Yes |  |
| `IncidentClosureDetails-Appliedby` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
