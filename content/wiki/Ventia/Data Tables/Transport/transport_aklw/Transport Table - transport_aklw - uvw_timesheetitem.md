---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_aklw
table-name: uvw_timesheetitem
full-name: transport_dev.transport_aklw.uvw_timesheetitem
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-table, databricks, transport-aklw, timesheet]
---

# Transport Table - transport_aklw - uvw_timesheetitem

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_timesheetitem` |
| Full name | `transport_dev.transport_aklw.uvw_timesheetitem` |
| Catalog | `transport_dev` |
| Schema | `transport_aklw` |
| Contract/schema | `transport_aklw` |
| Table type | VIEW |
| Column count | 27 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | timesheet |
| Source system | `ext_mssql_asset_vision_vnz_gen7` |

## View Query

```sql
SELECT a.id,
        timesheetid,
        Timestamp(Convert_timezone('Australia/Sydney', a.deltautc)) AS deltautc,
        Timestamp(Convert_timezone('Australia/Sydney', a.modifiedutc)) AS modifiedutc,
        a.modifieduser,
        Timestamp(Convert_timezone('Australia/Sydney', timesheetcreateddate)) AS timesheetcreateddate,
        timesheetcreateduser,
        sourcetable,
        sourcetableid,
        timesheettypename,
        companyratename,
        companyratereference1,
        companyratereference2,
        hours,
        minutes,
        CASE
          WHEN a.resourcetype IN ( "employees", "plant & equipment",
                                   "subcontractors" )
        THEN DOUBLE(hours + minutes / 60)
          ELSE DOUBLE(a.quantity)
        END AS quantity_used,
        b.NAME,
        b.code,
        b.quantity AS stock_quantity,
        multiplier,
        a.cost,
        resourcecode,
        resourcename,
        a.resourcetype,
        startdate,
        enddate,
 --       b.effective_from,
 --       b.effective_to,
        b.unit
 FROM   ext_mssql_asset_vision_vnz_gen7.dbo.timesheetitem a
        JOIN ext_mssql_asset_vision_vnz_gen7.dbo.resource b
          ON a.resourcecode = b.code
 --            AND Date(a.timesheetcreateddate) >= Timestamp(Convert_timezone('Australia/Sydney', b.effective_from))
 --            AND Date(a.timesheetcreateddate) <= Timestamp(Convert_timezone('Australia/Sydney', b.effective_to))
 WHERE  a.deleted = "false"
        AND Year(a.modifiedutc) >= 2022
        AND stage = "active"
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
| `NAME` | `string` | Yes |  |
| `code` | `string` | Yes |  |
| `stock_quantity` | `decimal(9,2)` | Yes |  |
| `multiplier` | `int` | Yes |  |
| `cost` | `decimal(12,2)` | Yes |  |
| `resourcecode` | `string` | Yes |  |
| `resourcename` | `string` | Yes |  |
| `resourcetype` | `string` | Yes |  |
| `startdate` | `timestamp` | Yes |  |
| `enddate` | `timestamp` | Yes |  |
| `unit` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_aklw]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
