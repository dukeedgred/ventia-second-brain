---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: utbl_ref_inspection_due_dates_monthly
full-name: transport_dev.transport_tsrc.utbl_ref_inspection_due_dates_monthly
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - utbl_ref_inspection_due_dates_monthly

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_ref_inspection_due_dates_monthly` |
| Full name | `transport_dev.transport_tsrc.utbl_ref_inspection_due_dates_monthly` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | MANAGED |
| Column count | 7 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Business purpose | Created by the file upload UI |
| Data domain | inspection / audit / condition |
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2024-06-03T07:29:51.871Z; Last altered: 2024-06-03T07:29:51.871Z |
| Source details | Data source format: DELTA |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `DueDate` | `date` | Yes |  |
| `EarliestStartDate-Monthly` | `date` | Yes |  |
| `Monthly` | `string` | Yes |  |
| `EarliestStartDate-3Monthly` | `date` | Yes |  |
| `3Monthly` | `string` | Yes |  |
| `EarliestStartDate-6Monthly` | `date` | Yes |  |
| `6Monthly` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
