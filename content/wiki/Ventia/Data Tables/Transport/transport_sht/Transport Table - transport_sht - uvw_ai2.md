---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_sht
table-name: uvw_ai2
full-name: transport_dev.transport_sht.uvw_ai2
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-sht]
---

# Transport Table - transport_sht - uvw_ai2

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_ai2` |
| Full name | `transport_dev.transport_sht.uvw_ai2` |
| Catalog | `transport_dev` |
| Schema | `transport_sht` |
| Contract/schema | `transport_sht` |
| Table type | VIEW |
| Column count | 17 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2024-12-05T04:43:14.035Z; Last altered: 2024-12-05T04:43:14.035Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |
| Caveats/open questions | This is a curated `transport_sht` Databricks schema table/view; it does not prove the SHT source operational system is Asset Vision. |

## View Query

```sql
SELECT
  j.id AS Job_ID,
  j.createddate AS Created_Date,
  j.assigneduser AS Assign_To,
  j.assetname AS Asset_Name,
  j.activityname AS Activity_Name,
  j.activitycategoryname AS Activity_Gategory_Name,
  j.interventionname AS Intervention_Name,
  j.priority AS Priority,
  j.activitytype AS Job_Type,
  j.duedate AS Due_Date,
  j.completedstatus AS Status,
  j.completeduser AS Completed_User,
  j.completeddate AS Completed_Date,
  SUBSTRING(
    j.spatialinfo
    FROM
      (CHARINDEX(' ', j.spatialinfo, 8) + 1) FOR (
        CHARINDEX(')', j.spatialinfo) - CHARINDEX(' ', j.spatialinfo, 8) - 2
      )
  ) AS Latitude,
  SUBSTRING(
    j.spatialinfo
    FROM
      8 FOR (CHARINDEX(' ', j.spatialinfo, 8) - 9)
  ) AS Longitude,
  j.assetcode AS Asset_Code,
  f.value AS WorkDescription
FROM
  ext_mssql_asset_vision_vns_gen7.dbo.job j
  LEFT JOIN ext_mssql_asset_vision_vns_gen7.dbo.formfield f on j.id = f.sourcetableid
  AND f.sourcetable = 'Job'
  AND f.name = 'Work Requirements & Planning Details|Work Description'
  AND f.deleted = false
WHERE
  j.contract = 'Sydney Harbour Tunnel (SHT)'
  AND j.deleted = false
  AND (SUBSTRING(f.value from 1 for 2) <> '1.'
       OR f.Value IS NULL)
ORDER BY
  j.id
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Job_ID` | `int` | Yes |  |
| `Created_Date` | `timestamp` | Yes |  |
| `Assign_To` | `string` | Yes |  |
| `Asset_Name` | `string` | Yes |  |
| `Activity_Name` | `string` | Yes |  |
| `Activity_Gategory_Name` | `string` | Yes |  |
| `Intervention_Name` | `string` | Yes |  |
| `Priority` | `string` | Yes |  |
| `Job_Type` | `string` | Yes |  |
| `Due_Date` | `timestamp` | Yes |  |
| `Status` | `string` | Yes |  |
| `Completed_User` | `string` | Yes |  |
| `Completed_Date` | `timestamp` | Yes |  |
| `Latitude` | `binary` | Yes |  |
| `Longitude` | `binary` | Yes |  |
| `Asset_Code` | `string` | Yes |  |
| `WorkDescription` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_sht]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
