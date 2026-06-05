---
type: source-data-table
topic: Ventia
sector: Transport
source-context: asset_vision_ven_rms
source-catalog: ext_mssql_asset_vision_ven_rms
source-schema: dbo
table-name: formfield
full-name: ext_mssql_asset_vision_ven_rms.dbo.formfield
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, source-table, databricks, asset-vision, asset-vision-ven-rms, formfield]
---

# Transport Source Table - asset_vision_ven_rms - formfield

## Identity

| Field | Value |
|---|---|
| Table name | `formfield` |
| Full name | `ext_mssql_asset_vision_ven_rms.dbo.formfield` |
| Catalog | `ext_mssql_asset_vision_ven_rms` |
| Schema | `dbo` |
| Source context | `asset_vision_ven_rms` |
| Table type | FOREIGN |
| Column count | 15 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | form metadata |
| Source system | Asset Vision |
| Source catalog | `ext_mssql_asset_vision_ven_rms` |
| Source schema | `dbo` |
| Source context | `asset_vision_ven_rms` |
| Caveats/open questions | Catalog name includes `ven_rms`; confirm whether this maps to a client/contract, contract group, or environment/version. Do not treat `dbo` as a client or contractor. |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `ID` | `int` | Yes |  |
| `RecordID` | `int` | Yes |  |
| `DeltaUTC` | `timestamp` | Yes |  |
| `ModifiedUTC` | `timestamp` | Yes |  |
| `Name` | `string` | Yes |  |
| `Value` | `string` | Yes |  |
| `DataType` | `string` | Yes |  |
| `SortOrder` | `int` | Yes |  |
| `ModifiedUser` | `string` | Yes |  |
| `SourceTable` | `string` | Yes |  |
| `SourceTableID` | `int` | Yes |  |
| `UniqueID` | `int` | Yes |  |
| `Deleted` | `boolean` | Yes |  |
| `Ref_ReferenceItemIDs` | `varchar(4000)` | Yes |  |
| `Ref_ModifiedUserID` | `int` | Yes |  |

## Related Pages

- [[Transport Source Tables - asset_vision_ven_rms]]
- [[Transport Data Tables]]
- [[Asset Vision]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]

