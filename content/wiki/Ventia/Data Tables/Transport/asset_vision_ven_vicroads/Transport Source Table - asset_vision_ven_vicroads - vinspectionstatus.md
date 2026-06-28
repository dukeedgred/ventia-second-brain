---
type: source-data-table
topic: Ventia
sector: Transport
source-context: asset_vision_ven_vicroads
source-catalog: ext_mssql_asset_vision_ven_vicroads
source-schema: dbo
table-name: vinspectionstatus
full-name: ext_mssql_asset_vision_ven_vicroads.dbo.vinspectionstatus
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, source-table, databricks, asset-vision, asset-vision-ven-vicroads, vinspectionstatus]
---

# Transport Source Table - asset_vision_ven_vicroads - vinspectionstatus

## Identity

| Field | Value |
|---|---|
| Table name | `vinspectionstatus` |
| Full name | `ext_mssql_asset_vision_ven_vicroads.dbo.vinspectionstatus` |
| Catalog | `ext_mssql_asset_vision_ven_vicroads` |
| Schema | `dbo` |
| Source context | `asset_vision_ven_vicroads` |
| Table type | FOREIGN |
| Column count | 10 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | inspection status |
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
| `ModifiedUser` | `string` | Yes |  |
| `InspectionID` | `int` | Yes |  |
| `Status` | `string` | Yes |  |
| `StatusDateUTC` | `timestamp` | Yes |  |
| `SpatialInfo` | `binary` | Yes |  |
| `Deleted` | `boolean` | Yes |  |
| `WKT` | `string` | Yes |  |

## Related Pages

- [[Transport Source Tables - asset_vision_ven_vicroads]]
- [[Transport Data Tables]]
- [[Asset Vision]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]

