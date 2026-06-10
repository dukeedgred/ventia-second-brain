---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: utbl_ref_corrective_maintenance_compliance
full-name: transport_dev.transport_tsrc.utbl_ref_corrective_maintenance_compliance
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - utbl_ref_corrective_maintenance_compliance

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_ref_corrective_maintenance_compliance` |
| Full name | `transport_dev.transport_tsrc.utbl_ref_corrective_maintenance_compliance` |
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
| Data domain | reference / mapping |
| Owner/SME | Helix_readwrite_transport_dev_transport_tsrc |
| Refresh/freshness | Created: 2024-06-05T01:23:33.381Z; Last altered: 2024-07-17T00:18:43.571Z |
| Source details | Data source format: DELTA |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Spec_ID` | `bigint` | Yes |  |
| `ActivityCategoryCode` | `string` | Yes |  |
| `ActivityCategoryName` | `string` | Yes |  |
| `ActivityCode` | `string` | Yes |  |
| `ActivityName` | `string` | Yes |  |
| `UnitofMeasure` | `string` | Yes |  |
| `InterventionCode` | `string` | Yes |  |
| `Classification` | `timestamp` | Yes |  |
| `ResponseValue_ScheduleInterval` | `bigint` | Yes |  |
| `Response_IntervalUnit` | `string` | Yes |  |
| `ActivityType` | `string` | Yes |  |
| `KPIComplianceRequirement` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
