---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport
table-name: utbl_jobs_formfield_allcontract
full-name: transport_dev.transport.utbl_jobs_formfield_allcontract
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport]
---

# Transport Table - transport - utbl_jobs_formfield_allcontract

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_jobs_formfield_allcontract` |
| Full name | `transport_dev.transport.utbl_jobs_formfield_allcontract` |
| Catalog | `transport_dev` |
| Schema | `transport` |
| Contract/schema | `transport` |
| Table type | MANAGED |
| Column count | 14 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | jobs / work orders |
| Owner/SME | hui.chen@ventia.com |
| Refresh/freshness | Created: 2024-08-02T11:10:40.317Z; Last altered: 2026-06-05T02:05:05.115Z |
| Source details | Data source format: DELTA |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `ID` | `int` | Yes |  |
| `RecordID` | `int` | Yes |  |
| `DeltaUTC` | `timestamp` | Yes |  |
| `ModifiedUTC` | `timestamp` | Yes |  |
| `Name` | `string` | Yes |  |
| `Value` | `string` | Yes |  |
| `DataType` | `string` | Yes |  |
| `SortOrder` | `int` | Yes |  |
| `ModifiedUser` | `string` | Yes |  |
| `SourceTable` | `string` | Yes |  |
| `SourceTableID` | `int` | Yes |  |
| `UniqueID` | `int` | Yes |  |
| `Deleted` | `boolean` | Yes |  |
| `source_database_name` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
