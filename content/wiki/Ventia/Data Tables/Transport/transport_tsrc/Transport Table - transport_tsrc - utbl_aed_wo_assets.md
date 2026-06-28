---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: utbl_aed_wo_assets
full-name: transport_dev.transport_tsrc.utbl_aed_wo_assets
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - utbl_aed_wo_assets

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_aed_wo_assets` |
| Full name | `transport_dev.transport_tsrc.utbl_aed_wo_assets` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | MANAGED |
| Column count | 6 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Business purpose | Created by the file upload UI |
| Data domain | asset register / hierarchy |
| Owner/SME | Helix_readwrite_corporate_dev |
| Refresh/freshness | Created: 2024-09-20T06:17:10.517Z; Last altered: 2024-10-22T03:43:13.898Z |
| Source details | Data source format: DELTA |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `WO_Asset_Id` | `bigint` | Yes |  |
| `WorkOrderId` | `bigint` | Yes |  |
| `AssetId` | `bigint` | Yes |  |
| `Name` | `string` | Yes |  |
| `Description` | `string` | Yes |  |
| `AssetTag` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
