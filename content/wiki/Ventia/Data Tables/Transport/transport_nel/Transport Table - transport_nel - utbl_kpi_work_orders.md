---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_nel
table-name: utbl_kpi_work_orders
full-name: transport_dev.transport_nel.utbl_kpi_work_orders
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-table, databricks, transport-nel, kpi, work-order]
---

# Transport Table - transport_nel - utbl_kpi_work_orders

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_kpi_work_orders` |
| Full name | `transport_dev.transport_nel.utbl_kpi_work_orders` |
| Catalog | `transport_dev` |
| Schema | `transport_nel` |
| Contract/schema | `transport_nel` |
| Table type | MANAGED |
| Column count | 26 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | KPI work order |
| Source details | Created by the file upload UI |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Work Order` | `bigint` | Yes |  |
| `Description` | `string` | Yes |  |
| `Location` | `string` | Yes |  |
| `Asset` | `string` | Yes |  |
| `Site` | `string` | Yes |  |
| `Route` | `string` | Yes |  |
| `Status` | `string` | Yes |  |
| `Priority` | `bigint` | Yes |  |
| `Anywhere Created` | `string` | Yes |  |
| `Work Type` | `string` | Yes |  |
| `Work Group` | `string` | Yes |  |
| `Resource` | `string` | Yes |  |
| `Supervisor` | `string` | Yes |  |
| `Job Plan` | `string` | Yes |  |
| `Owner Group` | `string` | Yes |  |
| `Target Start` | `string` | Yes |  |
| `Target Finish` | `string` | Yes |  |
| `Actual Start` | `string` | Yes |  |
| `Actual Finish` | `string` | Yes |  |
| `Is dynamic` | `string` | Yes |  |
| `Dynamic Job Plan applied` | `string` | Yes |  |
| `Finish No Later Than` | `string` | Yes |  |
| `Reported By` | `string` | Yes |  |
| `Reported Date` | `string` | Yes |  |
| `Occurrence Date` | `string` | Yes |  |
| `Attachment Count` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_nel]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
