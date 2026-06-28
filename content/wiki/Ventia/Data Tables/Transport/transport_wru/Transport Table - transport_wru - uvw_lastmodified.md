---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_lastmodified
full-name: transport_dev.transport_wru.uvw_lastmodified
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_lastmodified

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_lastmodified` |
| Full name | `transport_dev.transport_wru.uvw_lastmodified` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 2 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-09-10T02:26:46.136Z; Last altered: 2024-09-24T01:42:30.949Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(

Select 
convert_timezone('UTC', 'Australia/Melbourne', max(modifiedutc)) as lastmodifieddatetime, 
'asset' as source_table 
FROM ext_mssql_asset_vision_ven_vicroads.dbo.asset

union

Select 
convert_timezone('UTC', 'Australia/Melbourne', max(modifiedutc)) as lastmodifieddatetime, 
'assetattribute' as source_table 
FROM ext_mssql_asset_vision_ven_vicroads.dbo.assetattribute

union

Select 
convert_timezone('UTC', 'Australia/Melbourne', max(modifiedutc)) as lastmodifieddatetime, 
'capitalwork' as source_table 
from ext_mssql_asset_vision_ven_vicroads.dbo.capitalwork

union

Select 
convert_timezone('UTC', 'Australia/Melbourne', max(modifiedutc)) as lastmodifieddatetime, 
'capitalworktask' as source_table 
from ext_mssql_asset_vision_ven_vicroads.dbo.capitalworktask

union

Select 
convert_timezone('UTC', 'Australia/Melbourne', max(modifiedutc)) as lastmodifieddatetime, 
'custommoduleitem' as source_table 
from ext_mssql_asset_vision_ven_vicroads.dbo.custommoduleitem

union

Select 
convert_timezone('UTC', 'Australia/Melbourne', max(modifiedutc)) as lastmodifieddatetime, 
'formfield' as source_table 
from ext_mssql_asset_vision_ven_vicroads.dbo.formfield

union

Select 
convert_timezone('UTC', 'Australia/Melbourne', max(modifiedutc)) as lastmodifieddatetime, 
'inspection' as source_table 
from ext_mssql_asset_vision_ven_vicroads.dbo.inspection

union

Select 
convert_timezone('UTC', 'Australia/Melbourne', max(modifiedutc)) as lastmodifieddatetime, 
'job' as source_table 
from ext_mssql_asset_vision_ven_vicroads.dbo.job

union

Select 
convert_timezone('UTC', 'Australia/Melbourne', max(modifiedutc)) as lastmodifieddatetime, 
'module' as source_table 
from ext_mssql_asset_vision_ven_vicroads.dbo.module
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `lastmodifieddatetime` | `timestamp_ntz` | Yes |  |
| `source_table` | `string` | No |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
