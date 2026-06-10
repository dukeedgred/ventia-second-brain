---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_inspection_completions
full-name: transport_dev.transport_wru.uvw_inspection_completions
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_inspection_completions

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_inspection_completions` |
| Full name | `transport_dev.transport_wru.uvw_inspection_completions` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 16 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | inspection / audit / condition |
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-06-19T04:20:17.31Z; Last altered: 2024-09-24T01:42:37.309Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
with selection as (
    with inspection_typesnormalised AS (
        SELECT 
          id, 
          assettypename, 
          assetid, 
          date(convert_timezone('Australia/Sydney', completeddate)) as completed_date,
          date(scheduleddate) as scheduled_date, -- comparing to AV, completeddate is stored as UTC but scheduleddate is stored as aest.
          completeduser, 
          jobid,
          CASE 
            when inspectiontypename like "%Level 1 Inspection" then "Level 1 Inspection"
            when inspectiontypename like "%Level 2 Inspection" then if(comments like "%Complex%", "Complex Level 2 Inspection", "Level 2 Inspection")
            when inspectiontypename like "%Level 3 Inspection" then "Level 3 Inspection"
            else IFNULL(inspectiontypename,'')
          END as inspectiontype, 
          comments
        FROM transport_dev.transport_wru.uvw_inspection
        WHERE completeduser <> "VicRoads" and assettypename in ('Retaining Wall', 'Major Sign Structure', 'Noise Wall', 'Bridge/Major Culvert', 'Bridge')--and completeduser is not null
      )
    SELECT 
      row_number() over (PARTITION BY assetid, inspectiontype ORDER BY if(completed_date = '' or completed_date is null,1,0),completed_date asc, scheduled_date asc)as rn, 
      (lead(scheduled_date) over (PARTITION BY assetid, inspectiontype ORDER BY if(completed_date = '' or completed_date is null,1,0),completed_date)) as leaddate,
      (lag(completed_date) over (PARTITION BY assetid, inspectiontype ORDER BY if(completed_date = '' or completed_date is null,1,0),completed_date)) as lagdate,
      CASE
        when inspectiontype = "Level 1 Inspection" then if(lagdate is null, completed_date, add_months(lagdate,6))
        when inspectiontype = "Level 2 Inspection" then if(lagdate is null, completed_date, add_months(lagdate,36))
        when inspectiontype = "Cathodic Protection" then if(lagdate is null, completed_date, add_months(lagdate,12))
      end as due_date_temp,
      CASE
        when inspectiontype = "Level 2 Inspection" and quarter(due_date_temp) = 1 then date(concat(string(year(due_date_temp)), '-3-31'))
        when inspectiontype = "Level 2 Inspection" and quarter(due_date_temp) = 2 then date(concat(string(year(due_date_temp)), '-6-30'))
        when inspectiontype = "Level 2 Inspection" and quarter(due_date_temp) = 3 then date(concat(string(year(due_date_temp)), '-9-30'))
        when inspectiontype = "Level 2 Inspection" and quarter(due_date_temp) = 4 then date(concat(string(year(due_date_temp)), '-12-31'))
        else due_date_temp
      END as due_date,
      case
        when inspectiontype = "Level 1 Inspection" then add_months(completed_date,6)
        when inspectiontype = "Level 2 Inspection" then date(concat(string(year(completed_date)+3), '-06-30'))
        when inspectiontype = "Cathodic Protection" then add_months(completed_date,12)
      end as next_due_date,
      if(completed_date<=due_date, "Inspected on time", concat(string(datediff(completed_date,due_date)), " day(s) late")) as inspection_punctuality,
      id, 
      assettypename, 
      assetid, 
      completed_date, 
      completeduser, 
      inspectiontype,
      if(scheduled_date IS NULL and (quarter(leaddate) = quarter(completed_date)) and (year(leaddate) = year(completed_date)), leaddate, scheduled_date) as scheduled_date,
      comments as inspection_comments, 
      jobid 
    from inspection_typesnormalised
)
SELECT
  rn,
  selection.id,
  concat("https://vicroads.assetvision.com.au/Inspections/ViewInspection/", string(selection.id)) as inspection_hyperlink,
  assettypename,
  assetid,
  completed_date,
  scheduled_date,
  completeduser,
  inspectiontype,
  due_date,
  inspection_punctuality,
  next_due_date,
  uvw_asset_register.structure_ID as code,
  selection.inspection_comments,
  lagdate,
  jobid
from
  selection
  join transport_dev.transport_wru.uvw_asset_register on uvw_asset_register.id = selection.assetid
where
  not(completed_date is null and (quarter(scheduled_date) = quarter(lagdate) and year(scheduled_date) = year(lagdate)))
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `rn` | `int` | No |  |
| `id` | `int` | Yes |  |
| `inspection_hyperlink` | `string` | Yes |  |
| `assettypename` | `string` | Yes |  |
| `assetid` | `int` | Yes |  |
| `completed_date` | `date` | Yes |  |
| `scheduled_date` | `date` | Yes |  |
| `completeduser` | `string` | Yes |  |
| `inspectiontype` | `string` | No |  |
| `due_date` | `date` | Yes |  |
| `inspection_punctuality` | `string` | Yes |  |
| `next_due_date` | `date` | Yes |  |
| `code` | `string` | Yes |  |
| `inspection_comments` | `string` | Yes |  |
| `lagdate` | `date` | Yes |  |
| `jobid` | `int` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
