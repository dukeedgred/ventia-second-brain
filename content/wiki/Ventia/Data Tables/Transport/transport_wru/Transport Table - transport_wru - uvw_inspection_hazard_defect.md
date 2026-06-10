---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_inspection_hazard_defect
full-name: transport_dev.transport_wru.uvw_inspection_hazard_defect
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_inspection_hazard_defect

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_inspection_hazard_defect` |
| Full name | `transport_dev.transport_wru.uvw_inspection_hazard_defect` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 50 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | defects / hazards / failures |
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-09-23T23:21:15.105Z; Last altered: 2024-09-24T01:32:59Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
select * from 
(

select 
  row_number() over(partition by a.dateuid, a.direction order by a.startdate) as InspOrder
  ,case
    when row_number() over(partition by a.dateuid, a.direction, inspectiontypename order by a.startdate) = 1 then 'Scheduled Run'
    when row_number() over(partition by a.dateuid, a.direction order by a.startdate) > 1 then concat('Supplementary Run - ', row_number() over(partition by a.dateuid, a.direction order by a.startdate) - 1)
  end as InspRunType
  ,a.*
  ,case
    when completedday = 'Wed' and classification = 'RMC 2' and inspectiontypename = 'Hazard Inspection (Day)'  then 'Yes'
  else
    'No'
  end as Not_Valid_COMS_Insp
from (

select 
  concat(a.assetcode, '_',c.section_name,'_','KPI 1.1','_' ,inspectiontypename,'_',date_format(completeddate,'yyyy-MM-dd')) as DateUID
  ,concat(a.assetcode, '_',c.section_name,'_','KPI 1.1','_' ,inspectiontypename,'_',date_format(completeddate,'yyyy-MM-dd'),'_',inspectiongroupid) as InspUID
  ,row_number() over(partition by concat(a.assetcode, '_',c.section_name,'_',a.inspectiontypereference1,'_' ,a.inspectiontypename,'_',date_format(completeddate,'yyyy-MM-dd'),'_',inspectiongroupid, direction) order by datediff(minute,  startdate, completeddate) desc) as rn
  ,a.id as inspection_ID, assettypename, a.assetid, a.assetcode, assetname
  ,c.Asset_Name, c.Section_Name,concat(a.assetcode, ' - ',c.Asset_Name)  as Rd_Desc
  ,c.Section_Desc, c.Forward_Start_Chainage, c.Forward_End_Chainage, c.Reverse_Start_Chainage, c.Reverse_End_Chainage
  ,startreferencepointname, endreferencepointname, a.chainagefrom, a.chainageto
  ,case
    when a.direction = 'Outbound' then 'Forward'
    when a.direction = 'Inbound' then 'Reverse'
  else 
    a.direction
  end as direction
  ,a.entirelength
  ,bothdirections, inspectiontypeid, inspectiontypename
  ,if(inspectiontypename like '%Night%', 'Night', 'Day') as Type
  ,completeddate as completed_time_Full
  ,date_format(startdate,'yyyy-MM-dd') as startdate
  ,date_format(completeddate,'yyyy-MM-dd') as completeddate
  ,date_format(completeddate,'E'  ) as completedDay
  ,date_format(startdate,'hh:mm a') as startTime
  ,date_format(completeddate,'hh:mm a') as completedTime
  ,datediff(minute,  startdate, completeddate) as Duration
  ,date_format(scheduleddate,'yyyy-MM-dd') as scheduleddate
  ,date_format(createddate,'yyyy-MM-dd') as createddate
  ,d.week_int as WeekNo
  ,createduser
  ,completeduser
  ,inspectiongroupid
  ,inspectionroutename
  ,case 
    when a.otherdirectioninspectionid = '' then 'Yes'
    when a.otherdirectioninspectionid is null then 'Yes'
    when a.id > otherdirectioninspectionid then 'No'
    else
      'Yes'
  end as primary_inspection
    ,otherdirectioninspectionid
  ,case
    when a.classification = 'RMC 2, RMC 3' and a.section like '%2%' then 'RMC 2'
    when a.classification = 'RMC 2, RMC 3' and a.section like '%3%' then 'RMC 3'
    when a.classification = 'RMC 3, RMC 4' then 'RMC 3'
  else
    a.classification
  end classification
  ,inspectiontypereference1 as KPI_Reference
  ,comments
  ,if(comments like'Test%' or comments like 'test%','Yes','No') as Test_Data
  ,concat('https://vicroads.assetvision.com.au/Inspections/ViewInspection/', a.id ) as AV_Link
from transport_wru.uvw_inspection a
join transport_wru.uvw_a_road b on a.assetid = b.assetID
join transport_wru.utbl_inspection_road_sections c on c.Section_Desc = concat(b.name,' - ', if(a.section = '' or a.section is null,upper(b.name), upper(a.section)) )
join transport_wru.utbl_date_table d on date_format(a.completeddate,'yyyy-MM-dd') = d.date
where (inspectiontypereference1 = 'KPI 1.2' or inspectiontypereference1 = 'KPI 1.1')
and case 
    when a.otherdirectioninspectionid = '' then 'Yes'
    when a.otherdirectioninspectionid is null then 'Yes'
    when a.id > otherdirectioninspectionid then 'No'
    else
      'Yes'
  end = 'Yes'
and a.completeduser <> 'VicRoads'


union

select 
  concat(a.assetcode, '_',c.section_name,'_','KPI 1.1','_' ,'Hazard Inspection (Day)','_',date_format(completeddate,'yyyy-MM-dd')) as DateUID
  ,concat(a.assetcode, '_',c.section_name,'_','KPI 1.1','_' ,'Hazard Inspection (Day)','_',date_format(completeddate,'yyyy-MM-dd'),'_',inspectiongroupid) as InspUID
  ,row_number() over(partition by concat(a.assetcode, '_',c.section_name,'_',a.inspectiontypereference1,'_' ,a.inspectiontypename,'_',date_format(completeddate,'yyyy-MM-dd'),'_',inspectiongroupid) order by datediff(minute,  startdate, completeddate) desc) as rn
  ,a.id as inspection_ID, assettypename, a.assetid, a.assetcode, assetname
  ,c.Asset_Name, c.Section_Name,concat(a.assetcode, ' - ',c.Asset_Name)  as Rd_Desc
  ,c.Section_Desc, c.Forward_Start_Chainage, c.Forward_End_Chainage, c.Reverse_Start_Chainage, c.Reverse_End_Chainage
  ,startreferencepointname, endreferencepointname, a.chainagefrom, a.chainageto
  ,case
    when a.direction = 'Outbound' then 'Forward'
    when a.direction = 'Inbound' then 'Reverse'
  else 
    a.direction
  end as direction
  ,a.entirelength
  , bothdirections, inspectiontypeid
  ,'Hazard Inspection (Day)' as inspectiontypename
  ,if(inspectiontypename like '%Night%', 'Night', 'Day') as Type
  , timestamp(date_format( completeddate, 'yyyy-MM-dd HH:mm') ) as completed_time_Full
  ,date_format(startdate,'yyyy-MM-dd') as startdate
  ,date_format(completeddate,'yyyy-MM-dd') as completeddate
  ,date_format(completeddate,'E'  ) as completedDay
  ,date_format(startdate,'hh:mm a') as startTime
  ,date_format(completeddate,'hh:mm a') as completedTime
  ,datediff(minute,  startdate, completeddate) as Duration
  ,date_format(scheduleddate,'yyyy-MM-dd') as scheduleddate
  ,date_format(createddate,'yyyy-MM-dd') as createddate
  ,d.week_int as WeekNo
  ,createduser
  ,completeduser
  ,inspectiongroupid
  ,inspectionroutename
  ,case 
    when a.otherdirectioninspectionid = '' then 'Yes'
    when a.otherdirectioninspectionid is null then 'Yes'
    when a.id > otherdirectioninspectionid then 'No'
    else
      'Yes'
  end as primary_inspection
    ,otherdirectioninspectionid
  ,case
    when a.classification = 'RMC 2, RMC 3' and a.section like '%2%' then 'RMC 2'
    when a.classification = 'RMC 2, RMC 3' and a.section like '%3%' then 'RMC 3'
    when a.classification = 'RMC 3, RMC 4' then 'RMC 3'
  else
    a.classification
  end classification
  ,'KPI 1.1' as KPI_Reference
  ,comments
  ,if(comments like'Test%' or comments like 'test%','Yes','No') as Test_Data
  ,concat('https://vicroads.assetvision.com.au/Inspections/ViewInspection/', a.id ) as AV_Link
from transport_wru.uvw_inspection a
join transport_wru.uvw_a_road b on a.assetid = b.assetID
join transport_wru.utbl_inspection_road_sections c on c.Section_Desc = concat(b.name,' - ', if(a.section = '' or a.section is null,upper(b.name), upper(a.section)) )
join transport_wru.utbl_date_table d on date_format(a.completeddate,'yyyy-MM-dd') = d.date
where (inspectiontypereference1 = 'KPI 1.1‡KPI 1.2')
and case 
    when a.otherdirectioninspectionid = '' then 'Yes'
    when a.otherdirectioninspectionid is null then 'Yes'
    when a.id > otherdirectioninspectionid then 'No'
    else
      'Yes'
  end = 'Yes'
and a.completeduser <> 'VicRoads'

union

select 
  concat(a.assetcode, '_',c.section_name,'_','KPI 1.2','_' ,'Defect Inspection','_',date_format(completeddate,'yyyy-MM-dd')) as DateUID
  ,concat(a.assetcode, '_',c.section_name,'_','KPI 1.2','_' ,'Defect Inspection)','_',date_format(completeddate,'yyyy-MM-dd'),'_',inspectiongroupid) as InspUID
  ,row_number() over(partition by concat(a.assetcode, '_',c.section_name,'_',a.inspectiontypereference1,'_' ,a.inspectiontypename,'_',date_format(completeddate,'yyyy-MM-dd'),'_',inspectiongroupid) order by datediff(minute,  startdate, completeddate) desc) as rn
  ,a.id as inspection_ID, assettypename, a.assetid, a.assetcode, assetname
  ,c.Asset_Name, c.Section_Name,concat(a.assetcode, ' - ',c.Asset_Name)  as Rd_Desc
  ,c.Section_Desc, c.Forward_Start_Chainage, c.Forward_End_Chainage, c.Reverse_Start_Chainage, c.Reverse_End_Chainage
  ,startreferencepointname, endreferencepointname, a.chainagefrom, a.chainageto
  ,case
    when a.direction = 'Outbound' then 'Forward'
    when a.direction = 'Inbound' then 'Reverse'
  else 
    a.direction
  end as direction
  ,a.entirelength
  , bothdirections, inspectiontypeid
  ,'Defect Inspection' as inspectiontypename
  ,if(inspectiontypename like '%Night%', 'Night', 'Day') as Type
  ,completeddate as completed_time_Full
  ,date_format(startdate,'yyyy-MM-dd') as startdate
  ,date_format(completeddate,'yyyy-MM-dd') as completeddate
  ,date_format(completeddate,'E'  ) as completedDay
  ,date_format(startdate,'hh:mm a') as startTime
  ,date_format(completeddate,'hh:mm a') as completedTime
  ,datediff(minute,  startdate, completeddate) as Duration
  ,date_format(scheduleddate,'yyyy-MM-dd') as scheduleddate
  ,date_format(createddate,'yyyy-MM-dd') as createddate
  ,d.week_int as WeekNo
  ,createduser
  ,completeduser
  ,inspectiongroupid
  ,inspectionroutename
  ,case 
    when a.otherdirectioninspectionid = '' then 'Yes'
    when a.otherdirectioninspectionid is null then 'Yes'
    when a.id > otherdirectioninspectionid then 'No'
    else
      'Yes'
  end as primary_inspection
    ,otherdirectioninspectionid
  ,case
    when a.classification = 'RMC 2, RMC 3' and a.section like '%2%' then 'RMC 2'
    when a.classification = 'RMC 2, RMC 3' and a.section like '%3%' then 'RMC 3'
    when a.classification = 'RMC 3, RMC 4' then 'RMC 3'
  else
    a.classification
  end classification
  ,'KPI 1.2' as KPI_Reference
  ,comments
  ,if(comments like'Test%' or comments like 'test%','Yes','No') as Test_Data
  ,concat('https://vicroads.assetvision.com.au/Inspections/ViewInspection/', a.id ) as AV_Link
from transport_wru.uvw_inspection a
join transport_wru.uvw_a_road b on a.assetid = b.assetID
join transport_wru.utbl_inspection_road_sections c on c.Section_Desc = concat(b.name,' - ', if(a.section = '' or a.section is null,upper(b.name), upper(a.section)) )
join transport_wru.utbl_date_table d on date_format(a.completeddate,'yyyy-MM-dd') = d.date
where (inspectiontypereference1 = 'KPI 1.1‡KPI 1.2')
and case 
    when a.otherdirectioninspectionid = '' then 'Yes'
    when a.otherdirectioninspectionid is null then 'Yes'
    when a.id > otherdirectioninspectionid then 'No'
    else
      'Yes'
  end = 'Yes'
and a.completeduser <> 'VicRoads'
) a
where a.test_data = 'No'
and a.completeddate >= '2021-01-01' 
and a.rn = 1
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `InspOrder` | `int` | No |  |
| `InspRunType` | `string` | Yes |  |
| `DateUID` | `string` | Yes |  |
| `InspUID` | `string` | Yes |  |
| `rn` | `int` | No |  |
| `inspection_ID` | `int` | Yes |  |
| `assettypename` | `string` | Yes |  |
| `assetid` | `int` | Yes |  |
| `assetcode` | `string` | Yes |  |
| `assetname` | `string` | Yes |  |
| `Asset_Name` | `string` | Yes |  |
| `Section_Name` | `string` | Yes |  |
| `Rd_Desc` | `string` | Yes |  |
| `Section_Desc` | `string` | Yes |  |
| `Forward_Start_Chainage` | `bigint` | Yes |  |
| `Forward_End_Chainage` | `bigint` | Yes |  |
| `Reverse_Start_Chainage` | `bigint` | Yes |  |
| `Reverse_End_Chainage` | `bigint` | Yes |  |
| `startreferencepointname` | `string` | Yes |  |
| `endreferencepointname` | `string` | Yes |  |
| `chainagefrom` | `int` | Yes |  |
| `chainageto` | `int` | Yes |  |
| `direction` | `string` | Yes |  |
| `entirelength` | `string` | Yes |  |
| `bothdirections` | `string` | Yes |  |
| `inspectiontypeid` | `int` | Yes |  |
| `inspectiontypename` | `string` | Yes |  |
| `Type` | `string` | No |  |
| `completed_time_Full` | `timestamp` | Yes |  |
| `startdate` | `string` | Yes |  |
| `completeddate` | `string` | Yes |  |
| `completedDay` | `string` | Yes |  |
| `startTime` | `string` | Yes |  |
| `completedTime` | `string` | Yes |  |
| `Duration` | `bigint` | Yes |  |
| `scheduleddate` | `string` | Yes |  |
| `createddate` | `string` | Yes |  |
| `WeekNo` | `bigint` | Yes |  |
| `createduser` | `string` | Yes |  |
| `completeduser` | `string` | Yes |  |
| `inspectiongroupid` | `int` | Yes |  |
| `inspectionroutename` | `string` | Yes |  |
| `primary_inspection` | `string` | No |  |
| `otherdirectioninspectionid` | `int` | Yes |  |
| `classification` | `string` | Yes |  |
| `KPI_Reference` | `string` | Yes |  |
| `comments` | `string` | Yes |  |
| `Test_Data` | `string` | No |  |
| `AV_Link` | `string` | Yes |  |
| `Not_Valid_COMS_Insp` | `string` | No |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
