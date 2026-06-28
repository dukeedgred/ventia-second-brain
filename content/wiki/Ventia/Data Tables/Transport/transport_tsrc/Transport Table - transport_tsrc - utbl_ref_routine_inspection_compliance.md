---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: utbl_ref_routine_inspection_compliance
full-name: transport_dev.transport_tsrc.utbl_ref_routine_inspection_compliance
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - utbl_ref_routine_inspection_compliance

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_ref_routine_inspection_compliance` |
| Full name | `transport_dev.transport_tsrc.utbl_ref_routine_inspection_compliance` |
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
| Data domain | inspection / audit / condition |
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2024-06-05T03:49:00.717Z; Last altered: 2024-09-12T06:18:43.149Z |
| Source details | Data source format: DELTA |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `COMS Section` | `double` | Yes |  |
| `COMS Asset Name` | `string` | Yes |  |
| `Activity Name` | `string` | Yes |  |
| `Frequency` | `string` | Yes |  |
| `AV Asset Name` | `string` | Yes |  |
| `AV Inspection Name` | `string` | Yes |  |
| `Asset Raised Against` | `string` | Yes |  |
| `Asset Type` | `string` | Yes |  |
| `Planned/Unplanned` | `string` | Yes |  |
| `Duplicate` | `string` | Yes |  |
| `Date Valid From` | `date` | Yes |  |
| `Date Valid To` | `date` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
