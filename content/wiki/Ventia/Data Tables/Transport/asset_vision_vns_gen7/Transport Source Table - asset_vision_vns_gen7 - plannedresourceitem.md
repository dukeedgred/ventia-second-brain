---
type: source-data-table
topic: Ventia
sector: Transport
source-context: asset_vision_vns_gen7
source-catalog: ext_mssql_asset_vision_vns_gen7
source-schema: dbo
table-name: plannedresourceitem
full-name: ext_mssql_asset_vision_vns_gen7.dbo.plannedresourceitem
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, source-table, databricks, asset-vision, asset-vision-vns-gen7, plannedresourceitem]
---

# Transport Source Table - asset_vision_vns_gen7 - plannedresourceitem

## Identity

| Field | Value |
|---|---|
| Table name | `plannedresourceitem` |
| Full name | `ext_mssql_asset_vision_vns_gen7.dbo.plannedresourceitem` |
| Catalog | `ext_mssql_asset_vision_vns_gen7` |
| Schema | `dbo` |
| Source context | `asset_vision_vns_gen7` |
| Table type | FOREIGN |
| Column count | 24 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | resource planning |
| Source system | Asset Vision |
| Source catalog | `ext_mssql_asset_vision_vns_gen7` |
| Source schema | `dbo` |
| Source context | `asset_vision_vns_gen7` |
| Caveats/open questions | Catalog name includes `vns_gen7`; confirm whether this maps to a client/contract, contract group, or environment/version. Do not treat `dbo` as a client or contractor. |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `ID` | `int` | Yes |  |
| `PlannedResourceID` | `int` | Yes |  |
| `DeltaUTC` | `timestamp` | Yes |  |
| `ModifiedUTC` | `timestamp` | Yes |  |
| `ModifiedUser` | `string` | Yes |  |
| `PlannedResourceCreatedDate` | `timestamp` | Yes |  |
| `PlannedResourceCreatedUser` | `string` | Yes |  |
| `SourceTable` | `string` | Yes |  |
| `SourceTableID` | `int` | Yes |  |
| `PlannedResourceTypeName` | `string` | Yes |  |
| `CompanyRateName` | `string` | Yes |  |
| `CompanyRateReference1` | `string` | Yes |  |
| `CompanyRateReference2` | `string` | Yes |  |
| `Hours` | `int` | Yes |  |
| `Minutes` | `int` | Yes |  |
| `Quantity` | `decimal(9,2)` | Yes |  |
| `Multiplier` | `int` | Yes |  |
| `Cost` | `decimal(12,2)` | Yes |  |
| `ResourceCode` | `string` | Yes |  |
| `ResourceName` | `string` | Yes |  |
| `ResourceType` | `string` | Yes |  |
| `StartDate` | `timestamp` | Yes |  |
| `EndDate` | `timestamp` | Yes |  |
| `Deleted` | `boolean` | Yes |  |

## Related Pages

- [[Transport Source Tables - asset_vision_vns_gen7]]
- [[Transport Data Tables]]
- [[Asset Vision]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]


