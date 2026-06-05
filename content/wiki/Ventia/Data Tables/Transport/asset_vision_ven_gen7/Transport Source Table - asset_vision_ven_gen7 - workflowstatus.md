---
type: source-data-table
topic: Ventia
sector: Transport
source-context: asset_vision_ven_gen7
source-catalog: ext_mssql_asset_vision_ven_gen7
source-schema: dbo
table-name: workflowstatus
full-name: ext_mssql_asset_vision_ven_gen7.dbo.workflowstatus
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, source-table, databricks, asset-vision, asset-vision-ven-gen7, workflowstatus]
---

# Transport Source Table - asset_vision_ven_gen7 - workflowstatus

## Identity

| Field | Value |
|---|---|
| Table name | `workflowstatus` |
| Full name | `ext_mssql_asset_vision_ven_gen7.dbo.workflowstatus` |
| Catalog | `ext_mssql_asset_vision_ven_gen7` |
| Schema | `dbo` |
| Source context | `asset_vision_ven_gen7` |
| Table type | FOREIGN |
| Column count | 14 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | workflow status |
| Source system | Asset Vision |
| Source catalog | `ext_mssql_asset_vision_ven_gen7` |
| Source schema | `dbo` |
| Source context | `asset_vision_ven_gen7` |
| Caveats/open questions | Catalog name includes `ven_gen7`; confirm whether this maps to a client/contract, contract group, or environment/version. Do not treat `dbo` as a client or contractor. |

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

## Related Pages

- [[Transport Source Tables - asset_vision_ven_gen7]]
- [[Transport Data Tables]]
- [[Asset Vision]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]

