---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: utbl_ref_date_table
full-name: transport_dev.transport_tsrc.utbl_ref_date_table
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - utbl_ref_date_table

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_ref_date_table` |
| Full name | `transport_dev.transport_tsrc.utbl_ref_date_table` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | MANAGED |
| Column count | 25 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Business purpose | Created by the file upload UI |
| Data domain | reference / mapping |
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2024-06-05T01:38:35.612Z; Last altered: 2026-05-25T03:03:31.413Z |
| Source details | Data source format: DELTA |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Date` | `date` | Yes |  |
| `LongDate` | `string` | Yes |  |
| `Year` | `bigint` | Yes |  |
| `Quarter` | `string` | Yes |  |
| `Week Number` | `bigint` | Yes |  |
| `Month Number` | `bigint` | Yes |  |
| `Month` | `string` | Yes |  |
| `Day of Week` | `string` | Yes |  |
| `Day` | `bigint` | Yes |  |
| `Day Display` | `bigint` | Yes |  |
| `Last Day of Month` | `date` | Yes |  |
| `Days In Month` | `bigint` | Yes |  |
| `Week Commencing` | `date` | Yes |  |
| `DateKey` | `bigint` | Yes |  |
| `YearMonth` | `bigint` | Yes |  |
| `Mmm-YY` | `string` | Yes |  |
| `LQOP Today` | `string` | Yes |  |
| `First Day of Month` | `string` | Yes |  |
| `To Report` | `string` | Yes |  |
| `QtrMonthNo` | `bigint` | Yes |  |
| `YearMonthQtrMonth` | `bigint` | Yes |  |
| `YearQtrMth` | `string` | Yes |  |
| `Weekday` | `string` | Yes |  |
| `PublicHoliday` | `string` | Yes |  |
| `PublicHolidayName` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
