---
type: source-data-table
topic: Ventia
sector: Transport
source-context: asset_vision_ven_vicroads
source-catalog: ext_mssql_asset_vision_ven_vicroads
source-schema: dbo
table-name: laneaccess
full-name: ext_mssql_asset_vision_ven_vicroads.dbo.laneaccess
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, source-table, databricks, asset-vision, asset-vision-ven-vicroads, laneaccess]
---

# Transport Source Table - asset_vision_ven_vicroads - laneaccess

## Identity

| Field | Value |
|---|---|
| Table name | `laneaccess` |
| Full name | `ext_mssql_asset_vision_ven_vicroads.dbo.laneaccess` |
| Catalog | `ext_mssql_asset_vision_ven_vicroads` |
| Schema | `dbo` |
| Source context | `asset_vision_ven_vicroads` |
| Table type | FOREIGN |
| Column count | 56 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | lane access |
| Source system | Asset Vision |
| Source catalog | `ext_mssql_asset_vision_ven_vicroads` |
| Source schema | `dbo` |
| Source context | `asset_vision_ven_vicroads` |
| Caveats/open questions | Catalog name includes `ven_vicroads`; confirm whether this maps to a client/contract, contract group, or source environment. Do not treat `dbo` as a client or contractor. |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Record ID` | `int` | Yes |  |
| `Contract` | `string` | Yes |  |
| `CreatedUser` | `string` | Yes |  |
| `CompletedUser` | `string` | Yes |  |
| `InspectionTypeName` | `string` | Yes |  |
| `AssetCode` | `string` | Yes |  |
| `AssetName` | `string` | Yes |  |
| `CreatedDate` | `timestamp` | Yes |  |
| `StartDate` | `timestamp` | Yes |  |
| `CompletedDate` | `timestamp` | Yes |  |
| `CurrentStatus` | `string` | Yes |  |
| `JobID` | `int` | Yes |  |
| `AssignedUser` | `string` | Yes |  |
| `ScheduledDate` | `timestamp` | Yes |  |
| `CapitalWorkID` | `int` | Yes |  |
| `CapitalWorkName` | `string` | Yes |  |
| `InspectionID` | `int` | Yes |  |
| `Comments` | `string` | Yes |  |
| `EstimatedDuration` | `decimal(10,2)` | Yes |  |
| `Reference1` | `string` | Yes |  |
| `Reference2` | `string` | Yes |  |
| `Timesheets` | `int` | Yes |  |
| `ChainageFrom` | `int` | Yes |  |
| `ChainageTo` | `int` | Yes |  |
| `Direction` | `string` | Yes |  |
| `Associated Recod Latitude` | `double` | Yes |  |
| `Associated Record longitude` | `double` | Yes |  |
| `ActivityCategoryCode` | `string` | Yes |  |
| `ActivityCode` | `string` | Yes |  |
| `InterventionCode` | `string` | Yes |  |
| `InterventionKPI` | `string` | Yes |  |
| `ETSID` | `string` | Yes |  |
| `MoA RWE Number` | `string` | Yes |  |
| `Form Work Description` | `string` | Yes |  |
| `Is Job Hazard` | `string` | Yes |  |
| `Traffic Management Required` | `string` | Yes |  |
| `Reason for TM Not Required` | `string` | Yes |  |
| `TMP TGS Number` | `decimal(16,6)` | Yes |  |
| `Is Mobile Works` | `string` | Yes |  |
| `Lane Access Type` | `string` | Yes |  |
| `Length of Worksite` | `decimal(16,6)` | Yes |  |
| `Closure Type` | `string` | Yes |  |
| `Number of Lane Closed` | `string` | Yes |  |
| `Is Speed Reduction Applied` | `string` | Yes |  |
| `Number of Lane Speed Reduced` | `string` | Yes |  |
| `Normal Speed` | `string` | Yes |  |
| `Reduced Speed` | `string` | Yes |  |
| `Is One Lane Open Is Same Direction` | `string` | Yes |  |
| `First Sign Photo` | `string` | Yes |  |
| `First Sign Location` | `string` | Yes |  |
| `First Sign placed Date Time` | `string` | Yes |  |
| `Last Sign Photo` | `string` | Yes |  |
| `Last Sign Location` | `string` | Yes |  |
| `Last Sign placed Date Time` | `string` | Yes |  |
| `Lead Traffic Controller Name` | `string` | Yes |  |
| `Lead Traffic Controller Contact` | `string` | Yes |  |

## Related Pages

- [[Transport Source Tables - asset_vision_ven_vicroads]]
- [[Transport Data Tables]]
- [[Asset Vision]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]

