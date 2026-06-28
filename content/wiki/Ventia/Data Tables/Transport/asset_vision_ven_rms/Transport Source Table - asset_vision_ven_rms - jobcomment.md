---
type: source-data-table
topic: Ventia
sector: Transport
source-context: asset_vision_ven_rms
source-catalog: ext_mssql_asset_vision_ven_rms
source-schema: dbo
table-name: jobcomment
full-name: ext_mssql_asset_vision_ven_rms.dbo.jobcomment
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, source-table, databricks, asset-vision, asset-vision-ven-rms, jobcomment]
---

# Transport Source Table - asset_vision_ven_rms - jobcomment

## Identity

| Field | Value |
|---|---|
| Table name | `jobcomment` |
| Full name | `ext_mssql_asset_vision_ven_rms.dbo.jobcomment` |
| Catalog | `ext_mssql_asset_vision_ven_rms` |
| Schema | `dbo` |
| Source context | `asset_vision_ven_rms` |
| Table type | FOREIGN |
| Column count | 8 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | job comment |
| Source system | Asset Vision |
| Source catalog | `ext_mssql_asset_vision_ven_rms` |
| Source schema | `dbo` |
| Source context | `asset_vision_ven_rms` |
| Caveats/open questions | Catalog name includes `ven_rms`; confirm whether this maps to a client/contract, contract group, or environment/version. Do not treat `dbo` as a client or contractor. |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `ID` | `int` | Yes |  |
| `DeltaUTC` | `timestamp` | Yes |  |
| `ModifiedUTC` | `timestamp` | Yes |  |
| `ModifiedUser` | `string` | Yes |  |
| `JobID` | `int` | Yes |  |
| `Comment` | `string` | Yes |  |
| `Deleted` | `boolean` | Yes |  |
| `Ref_ModifiedUserID` | `int` | Yes |  |

## Related Pages

- [[Transport Source Tables - asset_vision_ven_rms]]
- [[Transport Data Tables]]
- [[Asset Vision]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]

