---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport
table-name: uvw_pc_masterdata
full-name: transport_dev.transport.uvw_pc_masterdata
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport]
---

# Transport Table - transport - uvw_pc_masterdata

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_pc_masterdata` |
| Full name | `transport_dev.transport.uvw_pc_masterdata` |
| Catalog | `transport_dev` |
| Schema | `transport` |
| Contract/schema | `transport` |
| Table type | VIEW |
| Column count | 29 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | bhupesh.balani@ventia.com |
| Refresh/freshness | Created: 2024-07-08T23:15:11.532Z; Last altered: 2024-07-21T19:47:18.322Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
Select *, right(Base_Profit_Centre_Key, len(Base_Profit_Centre_Key)-3) as PC_ID
from ext_mssql_srcreplsqlprd_ventia_corporate_finance_bpc.dbo.hierarchy_profit_centre
where `PROFITCENTRE.Level_03` ="Transport" AND  left(Base_Profit_Centre_Key,3) ="PC_"
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `ods_id` | `char(36)` | Yes |  |
| `processing_id` | `bigint` | Yes |  |
| `processing_id_item` | `bigint` | Yes |  |
| `ods_created_by` | `varchar(250)` | Yes |  |
| `ods_created_on` | `timestamp` | Yes |  |
| `ods_updated_by` | `varchar(250)` | Yes |  |
| `ods_updated_on` | `timestamp` | Yes |  |
| `ods_is_deleted` | `boolean` | Yes |  |
| `businesskey_01` | `varchar(250)` | Yes |  |
| `PROFITCENTRE.Level_01` | `varchar(255)` | Yes |  |
| `PROFITCENTRE.Level_01.Key` | `varchar(255)` | Yes |  |
| `PROFITCENTRE.Level_02` | `varchar(255)` | Yes |  |
| `PROFITCENTRE.Level_02.Key` | `varchar(255)` | Yes |  |
| `PROFITCENTRE.Level_03` | `varchar(255)` | Yes |  |
| `PROFITCENTRE.Level_03.Key` | `varchar(255)` | Yes |  |
| `PROFITCENTRE.Level_04` | `varchar(255)` | Yes |  |
| `PROFITCENTRE.Level_04.Key` | `varchar(255)` | Yes |  |
| `PROFITCENTRE.Level_05` | `varchar(255)` | Yes |  |
| `PROFITCENTRE.Level_05.Key` | `varchar(255)` | Yes |  |
| `PROFITCENTRE.Level_06` | `varchar(255)` | Yes |  |
| `PROFITCENTRE.Level_06.Key` | `varchar(255)` | Yes |  |
| `PROFITCENTRE.Level_07` | `varchar(255)` | Yes |  |
| `PROFITCENTRE.Level_07.Key` | `varchar(255)` | Yes |  |
| `Base_Profit_Centre` | `varchar(255)` | Yes |  |
| `Base_Profit_Centre_Key` | `varchar(255)` | Yes |  |
| `Index` | `varchar(255)` | Yes |  |
| `archive_ready_for_deletion` | `boolean` | Yes |  |
| `archive_delete_schedule_datetime_AEST` | `timestamp` | Yes |  |
| `PC_ID` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
