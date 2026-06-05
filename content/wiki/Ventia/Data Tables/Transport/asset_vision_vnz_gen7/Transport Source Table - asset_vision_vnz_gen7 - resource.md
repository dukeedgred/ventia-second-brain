---
type: source-data-table
topic: Ventia
sector: Transport
source-context: asset_vision_vnz_gen7
source-catalog: ext_mssql_asset_vision_vnz_gen7
source-schema: dbo
table-name: resource
full-name: ext_mssql_asset_vision_vnz_gen7.dbo.resource
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, source-table, databricks, asset-vision, asset-vision-vnz-gen7, resource]
---

# Transport Source Table - asset_vision_vnz_gen7 - resource

## Identity

| Field | Value |
|---|---|
| Table name | `resource` |
| Full name | `ext_mssql_asset_vision_vnz_gen7.dbo.resource` |
| Catalog | `ext_mssql_asset_vision_vnz_gen7` |
| Schema | `dbo` |
| Source context | `asset_vision_vnz_gen7` |
| Table type | FOREIGN |
| Column count | 21 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | resource |
| Source system | Asset Vision |
| Source catalog | `ext_mssql_asset_vision_vnz_gen7` |
| Source schema | `dbo` |
| Source context | `asset_vision_vnz_gen7` |
| Caveats/open questions | Catalog name includes `vnz_gen7`; confirm whether this maps to a client/contract, contract group, or environment/version. Do not treat `dbo` as a client or contractor. |

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

## Related Pages

- [[Transport Source Tables - asset_vision_vnz_gen7]]
- [[Transport Data Tables]]
- [[Asset Vision]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]



