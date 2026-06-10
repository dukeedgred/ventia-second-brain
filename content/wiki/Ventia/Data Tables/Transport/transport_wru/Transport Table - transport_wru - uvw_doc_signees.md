---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_doc_signees
full-name: transport_dev.transport_wru.uvw_doc_signees
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_doc_signees

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_doc_signees` |
| Full name | `transport_dev.transport_wru.uvw_doc_signees` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 9 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-06-30T23:27:41.748Z; Last altered: 2024-09-24T01:43:03.34Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
with cte as (
select a.moduleid, a.id as form_id, b.name,b.value, c.url as signature_image, int(substring(b.name,25,1)) as signee_no_name, int(substring(b.name,17,1)) as signee_no_signature,
case
  when b.name like "Sign-Off|Signee %" then timestamp(convert_timezone('Australia/Sydney', b.modifiedutc)) 
  else null -- manual date will be joined later on
end as signed_time 
from ext_mssql_asset_vision_ven_vicroads.dbo.inspection a
join ext_mssql_asset_vision_ven_vicroads.dbo.formfield b on a.id = b.sourcetableid
left join ext_mssql_asset_vision_ven_vicroads.dbo.photo c on b.recordid = c.sourcetableid
where a.inspectiontypename = "Document Sign-Off Record" and name like "Sign-Off%"
and coalesce(b.value, c.url) is not null and a.deleted = false
),
cte2 as (
  select to_date(left(value, 10), "dd/MM/yyyy") as value, sourcetableid from ext_mssql_asset_vision_ven_vicroads.dbo.formfield where sourcetable = "Inspection"
  and Name = "Document Type|Date of paper signatures collection:"
) ,
cte3 as (
  select cte.moduleid, form_id, name,cte.value, signature_image,signee_no_name,signee_no_signature , coalesce(cte.signed_time, cte2.value) as signed_time --cte2.value is where manual sign time is input by user
  from cte
  left join cte2 on cte.form_id = cte2.sourcetableid
),
cte4 as (
select a.moduleid as module_id, a.form_id, a.value as signee, b.signature_image,  coalesce(b.signed_time, a.signed_time) as signed_time from cte3 a
left join cte3 b on a.form_id = b.form_id and (a.signee_no_name = b.signee_no_signature)
where a.value is not null and a.value <> ""
),
cte5 as (
  select name, value, sourcetableid 
  from ext_mssql_asset_vision_ven_vicroads.dbo.formfield 
  where name = "Document Type|Is this a record of a paper document?"
),
cte6 as (
select a.*, b.revision_number,  
case 
    when b.revision_number = max(b.revision_number) over (partition by b.document_name) then "#77DD77" --green means up to date record
    else "#F9F992" --yellow indicates the signed record is out of date
end as latest_colour,
'https://vicroads.assetvision.com.au/Inspections/ViewInspection/' || form_id as form_link
from cte4 a
join uvw_documents b on a.module_id = b.module_id
)
select a.*, `Document Type|Is this a record of a paper document?` as physical_upload_record from cte6 a
left join cte5 c on a.form_id = c.sourcetableid
pivot (max(value) for name in ("Document Type|Is this a record of a paper document?"))
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `module_id` | `int` | Yes |  |
| `form_id` | `int` | Yes |  |
| `signee` | `string` | Yes |  |
| `signature_image` | `string` | Yes |  |
| `signed_time` | `timestamp` | Yes |  |
| `revision_number` | `int` | Yes |  |
| `latest_colour` | `string` | No |  |
| `form_link` | `string` | Yes |  |
| `physical_upload_record` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
