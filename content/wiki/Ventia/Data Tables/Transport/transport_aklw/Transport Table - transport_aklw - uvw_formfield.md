---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_aklw
table-name: uvw_formfield
full-name: transport_dev.transport_aklw.uvw_formfield
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-table, databricks, transport-aklw, form-metadata]
---

# Transport Table - transport_aklw - uvw_formfield

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_formfield` |
| Full name | `transport_dev.transport_aklw.uvw_formfield` |
| Catalog | `transport_dev` |
| Schema | `transport_aklw` |
| Contract/schema | `transport_aklw` |
| Table type | VIEW |
| Column count | 13 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | form metadata |
| Source system | `ext_mssql_asset_vision_vnz_gen7` |

## View Query

```sql
SELECT
  *
FROM
  ext_mssql_asset_vision_vnz_gen7.dbo.formfield
WHERE
  deleted = False
```

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

## Related Pages

- [[Transport Contract Tables - transport_aklw]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
