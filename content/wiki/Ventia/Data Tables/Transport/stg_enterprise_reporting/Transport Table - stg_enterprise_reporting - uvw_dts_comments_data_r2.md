---
type: data-table
topic: Ventia
sector: Transport
contract-schema: stg_enterprise_reporting
table-name: uvw_dts_comments_data_r2
full-name: transport_dev.stg_enterprise_reporting.uvw_dts_comments_data_r2
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, stg-enterprise-reporting]
---

# Transport Table - stg_enterprise_reporting - uvw_dts_comments_data_r2

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_dts_comments_data_r2` |
| Full name | `transport_dev.stg_enterprise_reporting.uvw_dts_comments_data_r2` |
| Catalog | `transport_dev` |
| Schema | `stg_enterprise_reporting` |
| Contract/schema | `stg_enterprise_reporting` |
| Table type | VIEW |
| Column count | 3 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | bhupesh.balani@ventia.com |
| Refresh/freshness | Created: 2025-05-13T04:32:16.913Z; Last altered: 2025-05-13T04:32:16.913Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
select
  array_join(array_sort(collect_set(concat('Sender: ', cast(s.createdby as string), ';Date: ', s.messagedate, ';Body: ', s.messagebody))), '|') as Comment,
  s.CUID_ID,
  s.VERSION
FROM 
  staged_dev.stg_hana_cf_timesheet_db.timesheetservice_timedetailsview s
WHERE
  s.deleted_in_source = 0
  group by s.CUID_ID, s.VERSION
  order by s.CUID_ID, s.VERSION
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Comment` | `string` | No |  |
| `CUID_ID` | `string` | No |  |
| `VERSION` | `int` | No |  |

## Related Pages

- [[Transport Contract Tables - stg_enterprise_reporting]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
