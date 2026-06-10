---
type: source-data-table
topic: Ventia
sector: Transport
source-context: asset_vision_ven_rms_new
source-catalog: ext_mssql_asset_vision_ven_rms_new
source-schema: dbo
table-name: plannedresourceitem
full-name: ext_mssql_asset_vision_ven_rms_new.dbo.plannedresourceitem
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, source-table, databricks, asset-vision-ven-rms-new]
---

# Transport Source Table - asset_vision_ven_rms_new - plannedresourceitem

## Identity

| Field | Value |
|---|---|
| Table name | `plannedresourceitem` |
| Full name | `ext_mssql_asset_vision_ven_rms_new.dbo.plannedresourceitem` |
| Catalog | `ext_mssql_asset_vision_ven_rms_new` |
| Schema | `dbo` |
| Source context | `asset_vision_ven_rms_new` |
| Table type | FOREIGN |
| Column count | 30 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | resources / timesheets |
| Source system | Asset Vision |
| Source catalog | `ext_mssql_asset_vision_ven_rms_new` |
| Source schema | `dbo` |
| Source context | `asset_vision_ven_rms_new` |
| Owner/SME | kale.skinner@ventia.com |
| Refresh/freshness | Created: 2025-12-09T22:03:24.421Z; Last altered: 2026-05-28T07:34:24.776Z |
| Source details | Data source format: SQLSERVER_FORMAT |
| Caveats/open questions | Preserve `dbo` as source schema metadata; do not treat it as a client or contract. |

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
| `Ref_ModifiedUserID` | `int` | Yes |  |
| `Ref_CreatedUserID` | `int` | Yes |  |
| `Ref_PlannedResourceTypeID` | `int` | Yes |  |
| `Ref_CompanyRateID` | `int` | Yes |  |
| `Ref_ResourceID` | `int` | Yes |  |
| `Ref_ResourceTypeID` | `int` | Yes |  |

## Related Pages

- [[Transport Source Tables - asset_vision_ven_rms_new]]
- [[Transport Data Tables]]
- [[Asset Vision]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
