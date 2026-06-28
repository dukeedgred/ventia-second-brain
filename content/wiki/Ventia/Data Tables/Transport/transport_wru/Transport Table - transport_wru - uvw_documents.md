---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_documents
full-name: transport_dev.transport_wru.uvw_documents
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_documents

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_documents` |
| Full name | `transport_dev.transport_wru.uvw_documents` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 13 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | documents / evidence |
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-06-30T23:57:48.6Z; Last altered: 2024-09-24T01:43:00.731Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
  with cte as (
      select a.id as module_id, a.name as module_name, a.createduser, a.comments, b.name, b.value, timestamp(convert_timezone('Australia/Sydney', a.createddate)) as module_item_created_date from ext_mssql_asset_vision_ven_vicroads.dbo.module a 
      join ext_mssql_asset_vision_ven_vicroads.dbo.formfield b on a.id = b.sourcetableid
      where modulename = "Signed Document" and a.deleted = false and b.deleted = false and a.contract like "%WRU%"
  )
select module_id, module_name, createduser, comments, module_item_created_date, "https://vicroads.assetvision.com.au/Inspections/ViewContainer/" || module_id as module_link,
`Document Sign Off Information|Document Type` as document_type, int(`Document Sign Off Information|Revision Number`) as revision_number, `Document Sign Off Information|Site Specific SWMS Name` as site_specific_swms_name, 

case
  when `Document Sign Off Information|SWMS Name/Code` = "Site Specific" then site_specific_swms_name
  else coalesce(`Document Sign Off Information|SOP Name`, `Document Sign Off Information|SWMS Name/Code`)
end as document_name,
"Rev " || revision_number as revision_title,
case 
    when int(`Document Sign Off Information|Revision Number`) = max(int(`Document Sign Off Information|Revision Number`)) over (partition by coalesce(`Document Sign Off Information|SOP Name`, `Document Sign Off Information|SWMS Name/Code`)) then "Yes"
    else "No" -- if revision number = max(revision number) then it is the latest version
end as latest_version,
case 
  when site_specific_swms_name is null and document_type = "SWMS (Safe Work Method Statement)" then "Generic"
  when site_specific_swms_name is not null and document_type = "SWMS (Safe Work Method Statement)" then "Site Specific"
  else null
end as swms_type

from cte
pivot (max(value) for name in ("Document Sign Off Information|Document Type", "Document Sign Off Information|Revision Number", "Document Sign Off Information|Site Specific SWMS Name", 
"Document Sign Off Information|SOP Name", "Document Sign Off Information|SWMS Name/Code"))
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `module_id` | `int` | Yes |  |
| `module_name` | `string` | Yes |  |
| `createduser` | `string` | Yes |  |
| `comments` | `string` | Yes |  |
| `module_item_created_date` | `timestamp` | Yes |  |
| `module_link` | `string` | Yes |  |
| `document_type` | `string` | Yes |  |
| `revision_number` | `int` | Yes |  |
| `site_specific_swms_name` | `string` | Yes |  |
| `document_name` | `string` | Yes |  |
| `revision_title` | `string` | Yes |  |
| `latest_version` | `string` | No |  |
| `swms_type` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
