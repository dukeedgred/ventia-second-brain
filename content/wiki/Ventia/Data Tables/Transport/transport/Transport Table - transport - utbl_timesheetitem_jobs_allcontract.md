---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport
table-name: utbl_timesheetitem_jobs_allcontract
full-name: transport_dev.transport.utbl_timesheetitem_jobs_allcontract
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport]
---

# Transport Table - transport - utbl_timesheetitem_jobs_allcontract

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_timesheetitem_jobs_allcontract` |
| Full name | `transport_dev.transport.utbl_timesheetitem_jobs_allcontract` |
| Catalog | `transport_dev` |
| Schema | `transport` |
| Contract/schema | `transport` |
| Table type | MANAGED |
| Column count | 25 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | jobs / work orders |
| Owner/SME | hui.chen@ventia.com |
| Refresh/freshness | Created: 2024-08-01T04:05:27.822Z; Last altered: 2026-06-08T23:42:29.786Z |
| Source details | Data source format: DELTA |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `ID` | `int` | Yes |  |
| `TimesheetID` | `int` | Yes |  |
| `DeltaUTC` | `timestamp` | Yes |  |
| `ModifiedUTC` | `timestamp` | Yes |  |
| `ModifiedUser` | `string` | Yes |  |
| `TimesheetCreatedDate` | `timestamp` | Yes |  |
| `TimesheetCreatedUser` | `string` | Yes |  |
| `SourceTable` | `string` | Yes |  |
| `SourceTableID` | `int` | Yes |  |
| `TimesheetTypeName` | `string` | Yes |  |
| `CompanyRateName` | `string` | Yes |  |
| `CompanyRateReference1` | `string` | Yes |  |
| `CompanyRateReference2` | `string` | Yes |  |
| `Hours` | `int` | Yes |  |
| `Minutes` | `int` | Yes |  |
| `Quantity` | `decimal(9,2)` | Yes |  |
| `Multiplier` | `int` | Yes |  |
| `Cost` | `decimal(12,2)` | Yes |  |
| `ResourceCode` | `string` | Yes |  |
| `ResourceName` | `string` | Yes |  |
| `ResourceType` | `string` | Yes |  |
| `StartDate` | `timestamp` | Yes |  |
| `EndDate` | `timestamp` | Yes |  |
| `Deleted` | `boolean` | Yes |  |
| `source_database_name` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
