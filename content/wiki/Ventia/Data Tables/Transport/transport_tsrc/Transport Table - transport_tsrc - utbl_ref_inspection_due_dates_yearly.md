---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: utbl_ref_inspection_due_dates_yearly
full-name: transport_dev.transport_tsrc.utbl_ref_inspection_due_dates_yearly
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - utbl_ref_inspection_due_dates_yearly

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_ref_inspection_due_dates_yearly` |
| Full name | `transport_dev.transport_tsrc.utbl_ref_inspection_due_dates_yearly` |
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
| Owner/SME | Helix_readwrite_transport_dev_transport_tsrc |
| Refresh/freshness | Created: 2024-06-03T07:28:48.026Z; Last altered: 2024-09-25T00:38:10.735Z |
| Source details | Data source format: DELTA |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `DueDate` | `date` | Yes |  |
| `EarliestStartDate-Annual` | `date` | Yes |  |
| `Annually` | `string` | Yes |  |
| `EarliestStartDate->Annual` | `date` | Yes |  |
| `2Yearly` | `string` | Yes |  |
| `5Yearly` | `string` | Yes |  |
| `10Yearly` | `string` | Yes |  |
| `15Yearly` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
