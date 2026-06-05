---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_timesheetitem
full-name: transport_dev.transport_wru.uvw_timesheetitem
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-table, databricks, transport-wru, timesheet]
---

# Transport Table - transport_wru - uvw_timesheetitem

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_timesheetitem` |
| Full name | `transport_dev.transport_wru.uvw_timesheetitem` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 29 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | timesheet |
| Related tables/reports | `ext_mssql_asset_vision_ven_vicroads.dbo.timesheetitem`, `ext_mssql_asset_vision_ven_vicroads.dbo.resource`, `ext_mssql_asset_vision_ven_vicroads.dbo.resourceaudit` |

## View Query

```sql
WITH resourceregister as(
  select 
    r.id,
    r.code,
    r.name,
    r.resourcetype,
    r.stage,
    r.quantity,
    r.unit,
    r.parentresourceid,
    r.parentresourcecode,
    r.parentresourcename,
    r.parentresourcetypename,
    a1.Modified as effective_from,
    a2.Modified as effective_to,
    row_number() over(partition by r.id, a1.Modified, a2.Modified order by r.id, a1.Modified, a2.Modified) as rn
  from
    ext_mssql_asset_vision_ven_vicroads.dbo.resource r
    left join ext_mssql_asset_vision_ven_vicroads.dbo.resourceaudit a1 on r.id = a1.ResourceID and a1.DisplayName = 'Record Created'
    left join ext_mssql_asset_vision_ven_vicroads.dbo.resourceaudit a2 on r.id = a2.ResourceID and a2.DisplayName = 'Stage' and a2.NewValue = 'Inactive'
)
select
  a.id,
  timesheetid,
  timestamp(convert_timezone('Australia/Sydney', a.deltautc)) as deltautc,
  timestamp(convert_timezone('Australia/Sydney', a.modifiedutc)) as modifiedutc,
  a.modifieduser,
  timestamp(convert_timezone('Australia/Sydney', timesheetcreateddate)) as timesheetcreateddate,
  timesheetcreateduser,
  sourcetable,
  sourcetableid,
  timesheettypename,
  companyratename,
  companyratereference1,
  companyratereference2,
  hours,
  minutes,
  case
    when a.resourcetype in ('Employees', 'Plant & Equipment', 'Subcontractors') then double(hours + minutes / 60)
    else double(a.quantity)
  end as quantity_used,
  b.name,
  b.code,
  b.quantity as stock_quantity,
  multiplier,
  a.cost,
  resourcecode,
  resourcename,
  a.resourcetype,
  startdate,
  enddate,
  b.effective_from,
  b.effective_to,
  b.unit
from
  ext_mssql_asset_vision_ven_vicroads.dbo.timesheetitem a
  join resourceregister b on a.resourcecode = b.code
  and date(a.timesheetcreateddate) >= date(b.effective_from)
  and (date(a.timesheetcreateddate) <= date(b.effective_to) or b.effective_to is null)
where
  a.deleted = "False"
  and year(a.modifiedutc) >= 2023
  and stage = "Active"
  and b.rn = 1
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `id` | `int` | Yes |  |
| `timesheetid` | `int` | Yes |  |
| `deltautc` | `timestamp` | Yes |  |
| `modifiedutc` | `timestamp` | Yes |  |
| `modifieduser` | `string` | Yes |  |
| `timesheetcreateddate` | `timestamp` | Yes |  |
| `timesheetcreateduser` | `string` | Yes |  |
| `sourcetable` | `string` | Yes |  |
| `sourcetableid` | `int` | Yes |  |
| `timesheettypename` | `string` | Yes |  |
| `companyratename` | `string` | Yes |  |
| `companyratereference1` | `string` | Yes |  |
| `companyratereference2` | `string` | Yes |  |
| `hours` | `int` | Yes |  |
| `minutes` | `int` | Yes |  |
| `quantity_used` | `double` | Yes |  |
| `name` | `string` | Yes |  |
| `code` | `string` | Yes |  |
| `stock_quantity` | `decimal(9,2)` | Yes |  |
| `multiplier` | `int` | Yes |  |
| `cost` | `decimal(12,2)` | Yes |  |
| `resourcecode` | `string` | Yes |  |
| `resourcename` | `string` | Yes |  |
| `resourcetype` | `string` | Yes |  |
| `startdate` | `timestamp` | Yes |  |
| `enddate` | `timestamp` | Yes |  |
| `effective_from` | `timestamp` | Yes |  |
| `effective_to` | `timestamp` | Yes |  |
| `unit` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
