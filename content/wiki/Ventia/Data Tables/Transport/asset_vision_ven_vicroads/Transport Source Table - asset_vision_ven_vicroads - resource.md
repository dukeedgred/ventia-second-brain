---
type: source-data-table
topic: Ventia
sector: Transport
source-context: asset_vision_ven_vicroads
source-catalog: ext_mssql_asset_vision_ven_vicroads
source-schema: dbo
table-name: resource
full-name: ext_mssql_asset_vision_ven_vicroads.dbo.resource
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, source-table, databricks, asset-vision, asset-vision-ven-vicroads, resource]
---

# Transport Source Table - asset_vision_ven_vicroads - resource

## Identity

| Field | Value |
|---|---|
| Table name | `resource` |
| Full name | `ext_mssql_asset_vision_ven_vicroads.dbo.resource` |
| Catalog | `ext_mssql_asset_vision_ven_vicroads` |
| Schema | `dbo` |
| Source context | `asset_vision_ven_vicroads` |
| Table type | FOREIGN |
| Column count | 21 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | resource |
| Source system | Asset Vision |
| Source catalog | `ext_mssql_asset_vision_ven_vicroads` |
| Source schema | `dbo` |
| Source context | `asset_vision_ven_vicroads` |
| Caveats/open questions | Catalog name includes `ven_vicroads`; confirm whether this maps to a client/contract, contract group, or source environment. Do not treat `dbo` as a client or contractor. |

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

- [[Transport Source Tables - asset_vision_ven_vicroads]]
- [[Transport Data Tables]]
- [[Asset Vision]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]

