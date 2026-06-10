---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport
table-name: utbl_resource_allcontract
full-name: transport_dev.transport.utbl_resource_allcontract
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport]
---

# Transport Table - transport - utbl_resource_allcontract

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_resource_allcontract` |
| Full name | `transport_dev.transport.utbl_resource_allcontract` |
| Catalog | `transport_dev` |
| Schema | `transport` |
| Contract/schema | `transport` |
| Table type | MANAGED |
| Column count | 22 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | resources / timesheets |
| Owner/SME | hui.chen@ventia.com |
| Refresh/freshness | Created: 2024-08-01T04:20:48.522Z; Last altered: 2026-06-08T23:47:27.975Z |
| Source details | Data source format: DELTA |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `ID` | `int` | Yes |  |
| `DeltaUTC` | `timestamp` | Yes |  |
| `ModifiedUTC` | `timestamp` | Yes |  |
| `ExportDateUTC` | `timestamp` | Yes |  |
| `ModifiedUser` | `string` | Yes |  |
| `Code` | `string` | Yes |  |
| `Name` | `string` | Yes |  |
| `Contract` | `string` | Yes |  |
| `ResourceType` | `string` | Yes |  |
| `ResourceGroup` | `string` | Yes |  |
| `ParentResourceID` | `int` | Yes |  |
| `ParentResourceCode` | `string` | Yes |  |
| `ParentResourceName` | `string` | Yes |  |
| `ParentResourceTypeName` | `string` | Yes |  |
| `Stage` | `string` | Yes |  |
| `Cost` | `decimal(12,2)` | Yes |  |
| `Notes` | `string` | Yes |  |
| `Quantity` | `decimal(9,2)` | Yes |  |
| `Unit` | `string` | Yes |  |
| `AlertNotes` | `string` | Yes |  |
| `Deleted` | `boolean` | Yes |  |
| `source_database_name` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
