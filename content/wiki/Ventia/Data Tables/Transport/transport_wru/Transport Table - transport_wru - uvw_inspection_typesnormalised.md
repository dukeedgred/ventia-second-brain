---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_inspection_typesnormalised
full-name: transport_dev.transport_wru.uvw_inspection_typesnormalised
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_inspection_typesnormalised

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_inspection_typesnormalised` |
| Full name | `transport_dev.transport_wru.uvw_inspection_typesnormalised` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 8 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | inspection / audit / condition |
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-06-18T15:20:38.474Z; Last altered: 2024-09-24T01:42:24.152Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
SELECT
  id,
  assettypename,
  assetid,
  date(convert_timezone('Australia/Sydney', completeddate)) as completed_date,
  -- comparing to AV, completeddate is stored as UTC but scheduleddate is stored as aest.
  date(scheduleddate) as scheduled_date,
  completeduser,
  CASE
    when inspectiontypename like "%Level 1 Inspection" then "Level 1 Inspection"
    when inspectiontypename like "%Level 2 Inspection" then if(comments like "%Complex%", "Complex Level 2 Inspection", "Level 2 Inspection")
    when inspectiontypename like "%Level 3 Inspection" then "Level 3 Inspection"
    else inspectiontypename
  END as inspectiontype,
  comments
FROM
  transport_dev.transport_wru.uvw_inspection
where
  completeduser <> "VicRoads"
  and assettypename in (
                          'Retaining Wall',
                          'Major Sign Structure',
                          'Noise Wall',
                          'Bridge/Major Culvert',
                          'Bridge'
                        )
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `id` | `int` | Yes |  |
| `assettypename` | `string` | Yes |  |
| `assetid` | `int` | Yes |  |
| `completed_date` | `date` | Yes |  |
| `scheduled_date` | `date` | Yes |  |
| `completeduser` | `string` | Yes |  |
| `inspectiontype` | `string` | Yes |  |
| `comments` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
