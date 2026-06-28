---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: utbl_ref_inspection_due_dates_weekly
full-name: transport_dev.transport_tsrc.utbl_ref_inspection_due_dates_weekly
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - utbl_ref_inspection_due_dates_weekly

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_ref_inspection_due_dates_weekly` |
| Full name | `transport_dev.transport_tsrc.utbl_ref_inspection_due_dates_weekly` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | MANAGED |
| Column count | 5 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Business purpose | Created by the file upload UI |
| Data domain | inspection / audit / condition |
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2024-06-03T07:29:19.839Z; Last altered: 2024-06-03T07:29:19.839Z |
| Source details | Data source format: DELTA |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `DueDate` | `date` | Yes |  |
| `EarliestStartDate-Weekly` | `date` | Yes |  |
| `Weekly` | `string` | Yes |  |
| `EarliestStartDate-Fortnightly` | `date` | Yes |  |
| `Fornightly` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
