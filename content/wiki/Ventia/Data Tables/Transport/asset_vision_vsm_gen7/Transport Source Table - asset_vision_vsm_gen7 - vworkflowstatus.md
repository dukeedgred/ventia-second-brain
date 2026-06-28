---
type: source-data-table
topic: Ventia
sector: Transport
source-context: asset_vision_vsm_gen7
source-catalog: ext_mssql_asset_vision_vsm_gen7
source-schema: dbo
table-name: vworkflowstatus
full-name: ext_mssql_asset_vision_vsm_gen7.dbo.vworkflowstatus
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, source-table, databricks, asset-vision, asset-vision-vsm-gen7, vworkflowstatus]
---

# Transport Source Table - asset_vision_vsm_gen7 - vworkflowstatus

## Identity

| Field | Value |
|---|---|
| Table name | `vworkflowstatus` |
| Full name | `ext_mssql_asset_vision_vsm_gen7.dbo.vworkflowstatus` |
| Catalog | `ext_mssql_asset_vision_vsm_gen7` |
| Schema | `dbo` |
| Source context | `asset_vision_vsm_gen7` |
| Table type | FOREIGN |
| Column count | 15 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | workflow status |
| Source system | Asset Vision |
| Source catalog | `ext_mssql_asset_vision_vsm_gen7` |
| Source schema | `dbo` |
| Source context | `asset_vision_vsm_gen7` |
| Caveats/open questions | Catalog name includes `vsm_gen7`; confirm whether this maps to a client/contract, contract group, or environment/version. Do not treat `dbo` as a client or contractor. |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `ID` | `int` | Yes |  |
| `RecordID` | `int` | Yes |  |
| `DeltaUTC` | `timestamp` | Yes |  |
| `ModifiedUTC` | `timestamp` | Yes |  |
| `ModifiedUser` | `string` | Yes |  |
| `WorkflowItemCode` | `string` | Yes |  |
| `WorkflowItemName` | `string` | Yes |  |
| `SourceTable` | `string` | Yes |  |
| `SourceTableID` | `int` | Yes |  |
| `StatusDate` | `timestamp` | Yes |  |
| `Comment` | `string` | Yes |  |
| `Reason` | `string` | Yes |  |
| `SpatialInfo` | `binary` | Yes |  |
| `Deleted` | `boolean` | Yes |  |
| `WKT` | `string` | Yes |  |

## Related Pages

- [[Transport Source Tables - asset_vision_vsm_gen7]]
- [[Transport Data Tables]]
- [[Asset Vision]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]



