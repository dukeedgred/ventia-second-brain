---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: utbl_work_order
full-name: transport_dev.transport_tsrc.utbl_work_order
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - utbl_work_order

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_work_order` |
| Full name | `transport_dev.transport_tsrc.utbl_work_order` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | MANAGED |
| Column count | 26 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Business purpose | Created by the file upload UI |
| Data domain | jobs / work orders |
| Owner/SME | huy.nguyen@ventia.com |
| Refresh/freshness | Created: 2026-04-14T23:50:51.511Z; Last altered: 2026-04-15T05:32:12.903Z |
| Source details | Data source format: DELTA |

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
| `Attachment Count` | `bigint` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
