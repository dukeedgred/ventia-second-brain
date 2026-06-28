---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: utbl_aed_inspection_requirements
full-name: transport_dev.transport_tsrc.utbl_aed_inspection_requirements
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - utbl_aed_inspection_requirements

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_aed_inspection_requirements` |
| Full name | `transport_dev.transport_tsrc.utbl_aed_inspection_requirements` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | MANAGED |
| Column count | 8 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Business purpose | Created by the file upload UI |
| Data domain | inspection / audit / condition |
| Owner/SME | Helix_readwrite_corporate_dev |
| Refresh/freshness | Created: 2024-09-23T02:46:30.314Z; Last altered: 2024-10-22T03:43:06.773Z |
| Source details | Data source format: DELTA |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Id` | `bigint` | Yes |  |
| `Code` | `string` | Yes |  |
| `Name` | `string` | Yes |  |
| `Description` | `string` | Yes |  |
| `Frequency` | `bigint` | Yes |  |
| `Freq. Unit` | `string` | Yes |  |
| `Next due date` | `date` | Yes |  |
| `Is Active` | `boolean` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
