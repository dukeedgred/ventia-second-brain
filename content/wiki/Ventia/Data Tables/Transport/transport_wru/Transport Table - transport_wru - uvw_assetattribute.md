---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_assetattribute
full-name: transport_dev.transport_wru.uvw_assetattribute
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_assetattribute

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_assetattribute` |
| Full name | `transport_dev.transport_wru.uvw_assetattribute` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 9 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | asset register / hierarchy |
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-06-12T05:25:18.098Z; Last altered: 2024-09-24T01:42:53.481Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
SELECT
  *
from
  ext_mssql_asset_vision_ven_vicroads.dbo.assetattribute
where
  deleted = false
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `ID` | `int` | Yes |  |
| `AssetID` | `int` | Yes |  |
| `DeltaUTC` | `timestamp` | Yes |  |
| `ModifiedUTC` | `timestamp` | Yes |  |
| `ModifiedUser` | `string` | Yes |  |
| `Name` | `string` | Yes |  |
| `Value` | `string` | Yes |  |
| `DataType` | `string` | Yes |  |
| `Deleted` | `boolean` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
