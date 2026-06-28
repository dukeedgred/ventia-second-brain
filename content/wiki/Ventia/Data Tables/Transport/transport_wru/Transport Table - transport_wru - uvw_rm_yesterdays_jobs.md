---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_rm_yesterdays_jobs
full-name: transport_dev.transport_wru.uvw_rm_yesterdays_jobs
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_rm_yesterdays_jobs

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_rm_yesterdays_jobs` |
| Full name | `transport_dev.transport_wru.uvw_rm_yesterdays_jobs` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 5 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | jobs / work orders |
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-06-11T22:37:19.299Z; Last altered: 2024-09-24T01:42:50.95Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
select x.assetcode, createddate, LEFT(activitycode, 5) as rm_code, id as job_id, activitytype from ext_mssql_asset_vision_ven_vicroads.dbo.job x
join
(
(select distinct assetcode as assetcode1 from ext_mssql_asset_vision_ven_vicroads.dbo.job
where date(createddate) =  date(dateadd(day, -1, timestamp(convert_timezone('Australia/Sydney', current_timestamp()))))
and assettypename <> "Road") a
join
(select distinct assetcode as assetcode2 from ext_mssql_asset_vision_ven_vicroads.dbo.job
where date(createddate) >=  date(dateadd(day, -365, timestamp(convert_timezone('Australia/Sydney', current_timestamp()))))
group by assetcode having count(assetcode)>1) b
on a.assetcode1 = b.assetcode2
) y
on x.assetcode = y.assetcode1
where date(x.createddate) >=  date(dateadd(day, -365, timestamp(convert_timezone('Australia/Sydney', current_timestamp()))))
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `assetcode` | `string` | Yes |  |
| `createddate` | `timestamp` | Yes |  |
| `rm_code` | `string` | Yes |  |
| `job_id` | `int` | Yes |  |
| `activitytype` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
