---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: uvw_incident_report
full-name: transport_dev.transport_tsrc.uvw_incident_report
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - uvw_incident_report

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_incident_report` |
| Full name | `transport_dev.transport_tsrc.uvw_incident_report` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | VIEW |
| Column count | 25 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | incidents |
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2024-06-03T07:19:14.775Z; Last altered: 2024-07-18T22:24:37.088Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
select distinct
  cast(m.id as int) as id,
  m.createddate as CreatedDate,
  m.name as IncidentDescription,
  COALESCE(f14.value, f19.value) as Severity,
  f15.value as IncidentStatus,
  m.assetname as RoadName,
  m.chainagefrom as ChainageFrom,
  m.chainageto as ChainageTo,
  CASE WHEN f12.value <> '' and f12.value <> null 
      THEN f12.value 
      ELSE CASE WHEN f16.value <> '' and f16.value <> null  
               THEN f16.value
               ELSE m.chainagefrom
            END
  END AS Chainage,
  f13.value as TrafficDirection,
  case
    when m.direction = '1 or 2' then 'Westbound'
    when m.direction = '3' then 'Eastbound'
    else null
  end as AVDirection,
  f10.value as Section,
  case
    when f10.value = 'Warrego Highway (East) to Mort Street (including Arrester Beds)' then 1
    when f10.value = 'Mort Street to Warrego (West)' then 3
    when f10.value = 'Warrego (West) to Cecil Plains Road to Gore Highway' then 4
    when f10.value = 'Warrego East Interchange' then 5
    when f10.value = 'Mort Street Interchange' then 6
    when f10.value = 'Warrego West Interchange' then 7
    when f10.value = 'Cecil Plains Interchange' then 8
    when f10.value = 'Gore Highway Interchange' then 9
    when f10.value = 'Tollroad' then 10
    else null
  end as SectionID,
  to_timestamp(f1.value, 'd/M/yyyy H:m:s') as OccurrenceDateTime,
  f2.value as IncidentType,
  to_timestamp(COALESCE(f18.value, f3.value), 'd/M/yyyy H:m:s') as DetectedDateTime,
  to_timestamp(f4.value, 'd/M/yyyy H:m:s') as InitialResponse,
  to_timestamp(f5.value, 'd/M/yyyy H:m:s') as EndDateTime,
  to_timestamp(f17.value, 'd/M/yyyy H:m:s') as ArriveOnSiteTime,
  f11.value As CompletionCode,
  r.parent_category as IncidentGroup,
  f6.value as TowingReqd,
  f7.value as TowType,
  f8.value as TowingArrangement,
  f9.value as TowingCompany
from
  ext_mssql_asset_vision_ven_gen7.dbo.module m
  left join ext_mssql_asset_vision_ven_gen7.dbo.formfield f1 on m.id = f1.sourcetableid
  and f1.sourcetable = 'Module'
  and f1.name = 'Occurrence|Occurrence Date and Time'
  and f1.deleted = false
  left join ext_mssql_asset_vision_ven_gen7.dbo.formfield f2 on m.id = f2.sourcetableid
  and f2.sourcetable = 'Module'
  and f2.name like 'Details|Details (1)|Incident Type'
  and f2.deleted = false
  left join ext_mssql_asset_vision_ven_gen7.dbo.formfield f3 on m.id = f3.sourcetableid
  and f3.sourcetable = 'Module'
  and f3.name = 'Initiation|Initiation (1)|Detected_DateTime' 
  and f3.deleted = false
  left join ext_mssql_asset_vision_ven_gen7.dbo.formfield f4 on m.id = f4.sourcetableid
  and f4.sourcetable = 'Module'
  and f4.name like 'Initiation|%|Initiated Date'
  and f4.deleted = false
  left join ext_mssql_asset_vision_ven_gen7.dbo.formfield f5 on m.id = f5.sourcetableid
  and f5.sourcetable = 'Module'
  and f5.name like 'Rectification|Rectification (1)|End Time'
  and f5.deleted = false
  left join ext_mssql_asset_vision_ven_gen7.dbo.formfield f6 on m.id = f6.sourcetableid
  and f6.sourcetable = 'Module'
  and f6.name like 'Details|Details (5)|Towing Required?'
  and f6.deleted = false
  left join ext_mssql_asset_vision_ven_gen7.dbo.formfield f7 on m.id = f7.sourcetableid
  and f7.sourcetable = 'Module'
  and f7.name like 'Details|Details (5)|Tow Type'
  and f7.deleted = false
  left join ext_mssql_asset_vision_ven_gen7.dbo.formfield f8 on m.id = f8.sourcetableid
  and f8.sourcetable = 'Module'
  and f8.name = 'Details|Details (5)|Towing Arrangement'
  and f8.deleted = false
  left join ext_mssql_asset_vision_ven_gen7.dbo.formfield f9 on m.id = f9.sourcetableid
  and f9.sourcetable = 'Module'
  and f9.name = 'Details|Details (5)|Towing Company'
  and f9.deleted = false
  left join ext_mssql_asset_vision_ven_gen7.dbo.formfield f10 on m.id = f10.sourcetableid
  and f10.sourcetable = 'Module'
  and f10.name = 'Overview|Section'
  and f10.deleted = false
  left join ext_mssql_asset_vision_ven_gen7.dbo.formfield f11 on m.id = f11.sourcetableid
  and f11.sourcetable = 'Module'
  and f11.name = 'Rectification|Rectification (2)|Completion Code'
  and f11.deleted = false
  left join ext_mssql_asset_vision_ven_gen7.dbo.formfield f12 on m.id = f12.sourcetableid
  and f12.sourcetable = 'Module'
  and f12.name = 'Details|Details (1)|Chainage'
  and f12.deleted = false
  left join ext_mssql_asset_vision_ven_gen7.dbo.formfield f13 on m.id = f13.sourcetableid
  and f13.sourcetable = 'Module'
  and f13.name = 'Details|Details (2)|Direction'
  and f13.deleted = false
  left join ext_mssql_asset_vision_ven_gen7.dbo.formfield f14 on m.id = f14.sourcetableid
  and f14.sourcetable = 'Module'
  and f14.name = 'Overview|Severity'
  and f14.UniqueID = 49002
  and f14.deleted = false
  left join ext_mssql_asset_vision_ven_gen7.dbo.formfield f15 on m.id = f15.sourcetableid
  and f15.sourcetable = 'Module'
  and f15.name = 'Overview|Status'
  and f15.deleted = false
  left join ext_mssql_asset_vision_ven_gen7.dbo.formfield f16 on m.id = f16.sourcetableid
  and f16.sourcetable = 'Module'
  and f16.name = 'Overview|Chainage'
  and f16.deleted = false  
  left join ext_mssql_asset_vision_ven_gen7.dbo.formfield f17 on m.id = f17.sourcetableid
  and f17.sourcetable = 'Module'
  and f17.name like 'Travel|%|Arrival On Site Time'
  and f17.deleted = false  
  left join ext_mssql_asset_vision_ven_gen7.dbo.formfield f18 on m.id = f18.sourcetableid
  and f18.sourcetable = 'Module'
  and f18.name = 'Initiation|Detected Time'
  and f18.deleted = false
  left join ext_mssql_asset_vision_ven_gen7.dbo.formfield f19 on m.id = f19.sourcetableid
  and f19.sourcetable = 'Module'
  and f19.name = 'Overview|Severity'
  and f14.UniqueID = 45035
  and f19.deleted = false
  left join transport_dev.transport_tsrc.utbl_ref_comp_code_to_inc_category r on r.completion_code = substring(f11.value from 1 for (charindex(' ', f11.value) - 1))
where
  m.contract = 'Toowoomba Second Range Crossing'
  and m.modulename = 'Incident'
  and m.deleted = false
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `id` | `int` | Yes |  |
| `CreatedDate` | `timestamp` | Yes |  |
| `IncidentDescription` | `string` | Yes |  |
| `Severity` | `string` | Yes |  |
| `IncidentStatus` | `string` | Yes |  |
| `RoadName` | `string` | Yes |  |
| `ChainageFrom` | `int` | Yes |  |
| `ChainageTo` | `int` | Yes |  |
| `Chainage` | `string` | Yes |  |
| `TrafficDirection` | `string` | Yes |  |
| `AVDirection` | `string` | Yes |  |
| `Section` | `string` | Yes |  |
| `SectionID` | `int` | Yes |  |
| `OccurrenceDateTime` | `timestamp` | Yes |  |
| `IncidentType` | `string` | Yes |  |
| `DetectedDateTime` | `timestamp` | Yes |  |
| `InitialResponse` | `timestamp` | Yes |  |
| `EndDateTime` | `timestamp` | Yes |  |
| `ArriveOnSiteTime` | `timestamp` | Yes |  |
| `CompletionCode` | `string` | Yes |  |
| `IncidentGroup` | `string` | Yes |  |
| `TowingReqd` | `string` | Yes |  |
| `TowType` | `string` | Yes |  |
| `TowingArrangement` | `string` | Yes |  |
| `TowingCompany` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
