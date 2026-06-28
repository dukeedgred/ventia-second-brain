---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_exportdate
full-name: transport_dev.transport_wru.uvw_exportdate
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_exportdate

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_exportdate` |
| Full name | `transport_dev.transport_wru.uvw_exportdate` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 5 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | reference / mapping |
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-05-10T02:02:12.594Z; Last altered: 2024-09-24T01:42:20.777Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
    select *, timestamp(convert_timezone('Australia/Sydney', lastexported)) as aest_last_export from ext_mssql_asset_vision_ven_vicroads.dbo.exportdate
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `ID` | `int` | Yes |  |
| `DeltaUTC` | `timestamp` | Yes |  |
| `Name` | `string` | Yes |  |
| `LastExported` | `timestamp` | Yes |  |
| `aest_last_export` | `timestamp` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
