---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: uvw_customer_requests_report
full-name: transport_dev.transport_tsrc.uvw_customer_requests_report
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - uvw_customer_requests_report

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_customer_requests_report` |
| Full name | `transport_dev.transport_tsrc.uvw_customer_requests_report` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | VIEW |
| Column count | 8 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2024-06-05T01:29:15.87Z; Last altered: 2024-07-18T22:24:36.698Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
select
  cast(m.id as int) as ID,
  m.createddate as CreatedDate,
  coalesce(m.comments, f5.value, m.name) as Summary,
  to_timestamp(f1.value, 'd/M/yyyy H:m:s') as EventDate,
  f2.value as Stakeholders,
  f3.value as EventType,
  f4.value as EventClassification,
  concat(f3.value, ' - ', f4.value) as EventTypeCombined
from
  ext_mssql_asset_vision_ven_gen7.dbo.module m
  left join ext_mssql_asset_vision_ven_gen7.dbo.formfield f1 on m.id = f1.sourcetableid
  and f1.sourcetable = 'Module'
  and f1.name = 'Event|Date_Event_Occured'
  and f1.deleted = false
  left join ext_mssql_asset_vision_ven_gen7.dbo.formfield f2 on m.id = f2.sourcetableid
  and f2.sourcetable = 'Module'
  and f2.name like 'Event|Contact_Name'
  and f2.deleted = false
  left join ext_mssql_asset_vision_ven_gen7.dbo.formfield f3 on m.id = f3.sourcetableid
  and f3.sourcetable = 'Module'
  and f3.name like 'Event|Event Type'
  and f3.deleted = false
  left join ext_mssql_asset_vision_ven_gen7.dbo.formfield f4 on m.id = f4.sourcetableid
  and f4.sourcetable = 'Module'
  and f4.name like 'Event|Event Classification'
  and f4.deleted = false
  left join ext_mssql_asset_vision_ven_gen7.dbo.formfield f5 on m.id = f5.sourcetableid
  and f5.sourcetable = 'Module'
  and f5.name like 'Event|Topic'
  and f5.deleted = false
where
  m.contract = 'Toowoomba Second Range Crossing'
  and m.modulename = 'Customer Requests'
  and m.deleted = false
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `ID` | `int` | Yes |  |
| `CreatedDate` | `timestamp` | Yes |  |
| `Summary` | `string` | Yes |  |
| `EventDate` | `timestamp` | Yes |  |
| `Stakeholders` | `string` | Yes |  |
| `EventType` | `string` | Yes |  |
| `EventClassification` | `string` | Yes |  |
| `EventTypeCombined` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
