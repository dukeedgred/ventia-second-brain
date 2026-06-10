---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: uvw_incident_triggered_report
full-name: transport_dev.transport_tsrc.uvw_incident_triggered_report
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - uvw_incident_triggered_report

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_incident_triggered_report` |
| Full name | `transport_dev.transport_tsrc.uvw_incident_triggered_report` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | VIEW |
| Column count | 17 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | incidents |
| Owner/SME | Helix_readwrite_transport_dev_transport_tsrc |
| Refresh/freshness | Created: 2024-07-25T23:35:50.551Z; Last altered: 2024-10-22T03:46:10.59Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
( 
with TriggerSectionDerived as (

with TriggerSectionUnpivot as (

with TriggerSection as (

with tmp as (select * from utbl_kpi2_road_safety
where InKPI2 = 'Yes')

Select 
AssetName, 
direction, 
ref.`Start`, 
ref.`End`,

--Count of sections in KPI 2 and trigger sections
(
    Select count(1) from tmp
    where tmp.assetname = ref.AssetName and
    tmp.AVDirection = ref.Direction and
    Cast(tmp.ChainageDerived as int) >= ref.`Start` and
    Cast(tmp.ChainageDerived as int) <= ref.`End`
  ) as Count,

 (Select max(id) 
from (select id, row_number() over (order by Cast(tmp.ChainageDerived as int) asc) as rowno 
from tmp 
where tmp.assetname = ref.AssetName and
tmp.AVDirection = ref.Direction and 
Cast(tmp.ChainageDerived as int) >= ref.`Start` and
Cast(tmp.ChainageDerived as int) <= ref.`End` 
)
where rowno = 1
) as minChainageIncidentId,

(Select min(Cast(utbl_kpi2_road_safety.ChainageDerived as int) ) from utbl_kpi2_road_safety
where utbl_kpi2_road_safety.assetname = ref.AssetName and
utbl_kpi2_road_safety.AVDirection = ref.Direction and
utbl_kpi2_road_safety.InKPI2 = 'Yes' and 
Cast(utbl_kpi2_road_safety.ChainageDerived as int) >= ref.`Start` and
Cast(utbl_kpi2_road_safety.ChainageDerived as int) <= ref.`End`
) as minChainage,

(Select max(id) 
from (select id, row_number() over (order by Cast(tmp.ChainageDerived as int) desc) as rowno 
from tmp 
where tmp.assetname = ref.AssetName and
tmp.AVDirection = ref.Direction and 
Cast(tmp.ChainageDerived as int) >= ref.`Start` and
Cast(tmp.ChainageDerived as int) <= ref.`End` 
)
where rowno = 1
) as maxChainageIncidentId,

--Rank 1/Row Number = 1 incident chainage grouped trigger sections 
(Select max(Cast(utbl_kpi2_road_safety.ChainageDerived as int)) 
from utbl_kpi2_road_safety
where utbl_kpi2_road_safety.assetname = ref.AssetName and
utbl_kpi2_road_safety.AVDirection = ref.Direction and 
utbl_kpi2_road_safety.InKPI2 = 'Yes' and 
Cast(utbl_kpi2_road_safety.ChainageDerived as int) >= ref.`Start` and
Cast(utbl_kpi2_road_safety.ChainageDerived as int) <= ref.`End`
) as maxChainage
   
from utbl_ref_section_to_m_mapping_2_km_sections ref

where (Select count(1) from tmp
where tmp.assetname = ref.AssetName and
tmp.AVDirection = ref.Direction and
tmp.InKPI2 = 'Yes' and 
Cast(tmp.ChainageDerived as int) >= ref.`Start` and
Cast(tmp.ChainageDerived as int) <= ref.`End`) >= 2
order by ref.assetname, ref.Direction, ref.`Start`
)

Select ts.*, ts.assetname as AssName, inc.id as AssId, inc.ChainageDerived as IncChain
, case 
when `OccurrenceDateandTimeDerived` is null then createddate
else `OccurrenceDateandTimeDerived`
end as incdate
, inc.assetcode as AssCode 
from TriggerSection ts
Left Join utbl_kpi2_road_safety inc 
where inc.assetname = inc.AssetName and
inc.AVDirection = ts.Direction and
inc.InKPI2 = 'Yes' and 
Cast(inc.ChainageDerived as int) >= ts.`minChainage` and
Cast(inc.ChainageDerived as int) <= ts.`maxChainage`
)

Select distinct dense_rank() over (order by tsu.AssName,tsu.direction,tsu.minChainage,tsu.maxChainage) as TriggerSectionId, tsu.AssCode as assetcode, tsu.AssName as assetname, tsu.direction, tsu.AssId as incidentid, Cast(tsu.IncChain as int) as incidentchainage, to_timestamp(tsu.incdate) as incdate, tsu.Count as count, tsu.minChainage, tsu.maxChainage, (datediff(day, lag(tsu.incdate,1) over (partition by ( dense_rank() over (order by tsu.minChainage,tsu.maxChainage)) order by tsu.incdate asc),tsu.incdate)/365.00) as datediff
from TriggerSectionUnpivot tsu

group by tsu.AssName, tsu.direction, tsu.AssId , Cast(tsu.IncChain as int), tsu.minChainage, tsu.Count, tsu.maxChainage, tsu.incdate, tsu.AssCode
order by (tsu.minChainage, tsu.maxChainage asc)
)

Select tsd.*,
(select max(sumdatediff) from (
with tmp4 as (
select TriggerSectionId, sum(datediff) OVER (partition by TriggerSectionId order by incdate asc rows between 4 preceding and current row) as sumdatediff
from TriggerSectionDerived tsd)
select sumdatediff from tmp4
where tmp4.TriggerSectionId = tsd.TriggerSectionId))
as rolling4sumdatediff,

(select max(count) from (
  with tmp5 as (select TriggerSectionId, sum(count(1)) OVER (partition by TriggerSectionId 
  order by TriggerSectionId asc
  rows between 5 preceding and current row) as count from TriggerSectionDerived tsd
    group by TriggerSectionId)
    select count from tmp5
    where tmp5.TriggerSectionId = tsd.TriggerSectionId
  
)) as rolling5countpertriggersectionid,

case when 
rolling5countpertriggersectionid >= 5 and 
rolling4sumdatediff < 2 
then 'Y' 
else 'N' end 
as abatable,

Cast(chng.Latitude as Decimal(10,7)) as Latitude,
Cast(chng.Longitude as Decimal(10,7)) as Longitude,

to_date(incdate) as `DateKey`

from TriggerSectionDerived tsd
left join utbl_ref_road_chng_10_m chng on 
(floor(tsd.incidentchainage/10)*10) = chng.Chainage and 
tsd.assetcode = chng.`Asset Code` and
((case
    when chng.direction = 'Gazettal' then 'Westbound'
    when chng.direction = 'Anti-Gazettal' then 'Eastbound'
    else null end) = tsd.direction)
order by TriggerSectionId, incdate
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `TriggerSectionId` | `int` | No |  |
| `assetcode` | `string` | Yes |  |
| `assetname` | `string` | Yes |  |
| `direction` | `string` | Yes |  |
| `incidentid` | `int` | Yes |  |
| `incidentchainage` | `int` | Yes |  |
| `incdate` | `timestamp` | Yes |  |
| `count` | `bigint` | Yes |  |
| `minChainage` | `int` | Yes |  |
| `maxChainage` | `int` | Yes |  |
| `datediff` | `decimal(28,6)` | Yes |  |
| `rolling4sumdatediff` | `decimal(38,6)` | Yes |  |
| `rolling5countpertriggersectionid` | `bigint` | Yes |  |
| `abatable` | `string` | No |  |
| `Latitude` | `decimal(10,7)` | Yes |  |
| `Longitude` | `decimal(10,7)` | Yes |  |
| `DateKey` | `date` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
