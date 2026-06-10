---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: uvw_capital_work
full-name: transport_dev.transport_tsrc.uvw_capital_work
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - uvw_capital_work

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_capital_work` |
| Full name | `transport_dev.transport_tsrc.uvw_capital_work` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | VIEW |
| Column count | 18 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2024-05-29T04:34:04.032Z; Last altered: 2024-07-18T22:24:40.807Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
select
  cw.id as capitalworkid,
  cw.name as capitalworkname,
  cwt.sortorder as tasksortorder,
  cwt.id as taskid,
  cwt.name as taskdesciption,
  cwt.plannedstart as plannedstart,
  cwt.plannedfinish as plannedfinish,
  cwt.actualstart as actualstart,
  cwt.actualfinish as actualfinish,
  coalesce(cwt.assettypename, cw.assettypename) as assettypename,
  coalesce(cwt.assetid, cw.assetid) as assetid,
  coalesce(cwt.assetcode, cw.assetcode) as assetcode,
  coalesce(cwt.assetname, cw.assetname) as assetname,
  coalesce(cwt.section, cw.section) as section,
  coalesce(cwt.direction, cw.direction) as direction,
  coalesce(cwt.chainagefrom, cw.chainagefrom) as chainagefrom,
  coalesce(cwt.chainageto, cw.chainageto) as chainageto,
  cwt.jobid as associatedjobreference
from
  ext_mssql_asset_vision_ven_gen7.dbo.capitalwork cw
  left join ext_mssql_asset_vision_ven_gen7.dbo.capitalworktask cwt on cwt.capitalworkid = cw.id
  and cwt.deleted = false
where
  cw.deleted = false
  and cw.contract = 'Toowoomba Second Range Crossing'
order by
  cw.id,
  cwt.sortorder
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `capitalworkid` | `int` | Yes |  |
| `capitalworkname` | `string` | Yes |  |
| `tasksortorder` | `int` | Yes |  |
| `taskid` | `int` | Yes |  |
| `taskdesciption` | `string` | Yes |  |
| `plannedstart` | `timestamp` | Yes |  |
| `plannedfinish` | `timestamp` | Yes |  |
| `actualstart` | `timestamp` | Yes |  |
| `actualfinish` | `timestamp` | Yes |  |
| `assettypename` | `string` | Yes |  |
| `assetid` | `int` | Yes |  |
| `assetcode` | `string` | Yes |  |
| `assetname` | `string` | Yes |  |
| `section` | `string` | Yes |  |
| `direction` | `string` | Yes |  |
| `chainagefrom` | `int` | Yes |  |
| `chainageto` | `int` | Yes |  |
| `associatedjobreference` | `int` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
