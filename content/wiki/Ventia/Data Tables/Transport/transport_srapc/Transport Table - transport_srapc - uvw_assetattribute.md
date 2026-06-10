---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_srapc
table-name: uvw_assetattribute
full-name: transport_dev.transport_srapc.uvw_assetattribute
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-srapc]
---

# Transport Table - transport_srapc - uvw_assetattribute

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_assetattribute` |
| Full name | `transport_dev.transport_srapc.uvw_assetattribute` |
| Catalog | `transport_dev` |
| Schema | `transport_srapc` |
| Contract/schema | `transport_srapc` |
| Table type | VIEW |
| Column count | 9 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | asset register / hierarchy |
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2024-07-01T09:41:15.02Z; Last altered: 2024-07-18T20:30:56.886Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
select a.*
from ext_mssql_asset_vision_ven_rms.dbo.assetattribute a
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

- [[Transport Contract Tables - transport_srapc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
