---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: uvw_inspection
full-name: transport_dev.transport_tsrc.uvw_inspection
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - uvw_inspection

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_inspection` |
| Full name | `transport_dev.transport_tsrc.uvw_inspection` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | VIEW |
| Column count | 54 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | inspection / audit / condition |
| Owner/SME | Helix_readwrite_transport_dev_transport_tsrc |
| Refresh/freshness | Created: 2024-09-23T22:54:25.936Z; Last altered: 2024-10-22T03:46:18.903Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(

select
    i.*,
    f1.value as DueDate,
    f2.value as EarlyStartDate,
    f3.value as PlannedScheduledDate,
    -- To update inspection name that contains commas
    case
when `inspectiontypename` =  'Arrestor Bed, 6M' then 'Arrestor Bed - 12 Monthly'
when `inspectiontypename` =  'Bridge Inspection, 3 Monthly' then 'Bridge Inspection - Routine 3 Monthly'
when `inspectiontypename` =  'Bridge Inspection, Level 1' then 'Bridge Inspection - Level 1'
when `inspectiontypename` =  'Building & Air Conditioning System, 12 Monthly' then 'Building - Air Conditioning System - 12 Monthly'
when `inspectiontypename` =  'Building Air Conditioning System - 3 monthly' then 'Building - Air Conditioning System - 3 monthly'
when `inspectiontypename` =  'CCTV System, 3 Monthly' then 'CCTV System - 3 Monthly'
when `inspectiontypename` =  'CCTV System, 6 Monthly' then 'CCTV System - 6 Monthly'
when `inspectiontypename` =  'Major Culvert, Level 1' then 'Major Culvert - Level 1'
when `inspectiontypename` =  'Culvert Major, Level 1' then 'Major Culvert - Level 1'
when `inspectiontypename` =  'Minor Culvert, Yearly' then 'Minor Culverts - Inspect and Clean - Yearly'
when `inspectiontypename` =  'Culverts Minor, Yearly' then 'Minor Culverts - Inspect and Clean - Yearly'
when `inspectiontypename` =  'Fencing and Gates, 6 Monthly' then 'Fences - Routine Inspection 6 Monthly'
when `inspectiontypename` =  'Fencing and Gates - 6 Monthly' then 'Fences - Routine Inspection 6 Monthly'
when `inspectiontypename` =  'Field Cabinet, yearly' then 'Field Cabinet - Yearly'
when `inspectiontypename` =  'Field Cabinet - yearly' then 'Field Cabinet - Yearly'
when `inspectiontypename` =  'Gantry Structure, 12 Monthly' then 'Major Sign Structures - Level 2'
when `inspectiontypename` =  'Kerb and Channel, 6 Monthly' then 'Kerb and Channel - 6 Monthly'
when `inspectiontypename` =  'Line Marking And Symbols, 6 Monthly' then 'Line Marking And Symbols - 6 Monthly'
when `inspectiontypename` =  'Maintenance Track Inspection, 12 Monthly' then 'Maintenance Track Inspection - 12 Monthly'
when `inspectiontypename` =  'Motorway Lighting (Weekly)' then 'Motorway Lighting - Weekly'
when `inspectiontypename` =  'Parking, 6 Monthly' then 'Parking - 12 Monthly'
when `inspectiontypename` =  'Retaining Walls, 6 Monthly' then 'Retaining Walls - 6 Monthly'
when `inspectiontypename` =  'Road Signs and Guide Posts, 1 Monthly' then 'Road Signs and Guide Posts - 1 Monthly'
when `inspectiontypename` =  'Road Weather Monitoring System, 1 monthly' then 'Road Weather Monitoring System - Monthly'
when `inspectiontypename` =  'Road Weather Monitoring System - 1 monthly' then 'Road Weather Monitoring System - Monthly'
when `inspectiontypename` =  'Road Weather Monitoring System, 12 Month' then 'Road Weather Monitoring System - 12 Monthly'
when `inspectiontypename` =  'Road Weather Monitoring System - 12 Month' then 'Road Weather Monitoring System - 12 Monthly'
when `inspectiontypename` =  'Safety Barriers and Terminal Ends, 6 Monthly' then 'Safety Barriers and Terminal Ends - 6 Monthly'
when `inspectiontypename` =  'Sedimentation Basin, 12 Monthly' then 'Water Quality Infrastructure - 12 Monthly'
when `inspectiontypename` =  'Slopes, 12 Monthly' then 'Slopes - Level 1 - 12 Monthly'
when `inspectiontypename` =  'Subsoil Drains, 12 monthly' then 'Subsoil Drains - 12 monthly'
when `inspectiontypename` =  'Table Drains, yearly' then 'Table Drains - Yearly'
when `inspectiontypename` =  'Table Drains - 6 Monthly' or `inspectiontypename` = 'Table Drains 6 Monthly' then 'Table Drains - High Risk - 6 Monthly'
when `inspectiontypename` =  'Traffic Management Devices, 3 Monthly' then 'Traffic Management Devices - 12 Monthly'
when `inspectiontypename` =  'UPS, 12 Monthly' then 'UPS - 12 Monthly'
when `inspectiontypename` =  'UPS, 3 Monthly' then 'UPS - 3 Monthly'
when `inspectiontypename` =  'Variable Message Sign, 3 Monthly' then 'Variable Message Sign - 3 Monthly'
when `inspectiontypename` =  'Variable Message Sign, 6 Monthly' then 'Variable Message Sign - 6 Monthly'
when `inspectiontypename` =  'Vehicle Detection System, 6 Monthly' then 'Vehicle Detection System - 6 Monthly'
when `inspectiontypename` =  'VMS Ladders - Access Point Inspection, 12 Monthly' then 'VMS Ladders - Access Point Inspection - 12 Monthly'
else `inspectiontypename`
    end as inspectiontypenamederived
  from
    ext_mssql_asset_vision_ven_gen7.dbo.vinspection i
    left join ext_mssql_asset_vision_ven_gen7.dbo.formfield f1 on i.id = f1.sourcetableid
    and f1.sourcetable = 'Inspection'
    and f1.name = 'Scheduling Details|Due Date'
    and f1.deleted = false
    left join ext_mssql_asset_vision_ven_gen7.dbo.formfield f2 on i.id = f2.sourcetableid
    and f2.sourcetable = 'Inspection'
    and f2.name = 'Scheduling Details|Earliest Start Date'
    and f2.deleted = false
    left join ext_mssql_asset_vision_ven_gen7.dbo.formfield f3 on i.id = f3.sourcetableid
    and f3.sourcetable = 'Inspection'
    and f3.name = 'Scheduling Details|Scheduled Date'
    and f3.deleted = false
  where
    i.contract = 'Toowoomba Second Range Crossing'
    and i.deleted = false
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `ID` | `int` | Yes |  |
| `DeltaUTC` | `timestamp` | Yes |  |
| `ModifiedUTC` | `timestamp` | Yes |  |
| `ModifiedUser` | `string` | Yes |  |
| `AssetTypeName` | `string` | Yes |  |
| `AssetID` | `int` | Yes |  |
| `AssetCode` | `string` | Yes |  |
| `AssetName` | `string` | Yes |  |
| `Section` | `string` | Yes |  |
| `Classification` | `string` | Yes |  |
| `Contract` | `string` | Yes |  |
| `Region` | `string` | Yes |  |
| `StartDate` | `timestamp` | Yes |  |
| `StartReferencePointName` | `string` | Yes |  |
| `ChainageFrom` | `int` | Yes |  |
| `StartDistancePast` | `int` | Yes |  |
| `EndReferencePointName` | `string` | Yes |  |
| `ChainageTo` | `int` | Yes |  |
| `EndDistancePast` | `int` | Yes |  |
| `Direction` | `string` | Yes |  |
| `BothDirections` | `string` | Yes |  |
| `OtherDirectionInspectionID` | `int` | Yes |  |
| `InspectionTypeID` | `int` | Yes |  |
| `InspectionTypeName` | `string` | Yes |  |
| `InspectionTypeReference1` | `string` | Yes |  |
| `InspectionTypeReference2` | `string` | Yes |  |
| `Category` | `string` | Yes |  |
| `CreatedDate` | `timestamp` | Yes |  |
| `CreatedUser` | `string` | Yes |  |
| `AssignedUser` | `string` | Yes |  |
| `Comments` | `string` | Yes |  |
| `EntireLength` | `string` | Yes |  |
| `ScheduledDate` | `timestamp` | Yes |  |
| `ScheduledDateFrom` | `timestamp` | Yes |  |
| `ScheduledDateTo` | `timestamp` | Yes |  |
| `CurrentStatus` | `string` | Yes |  |
| `CompletedDate` | `timestamp` | Yes |  |
| `CompletedUser` | `string` | Yes |  |
| `JobID` | `int` | Yes |  |
| `CapitalWorkID` | `int` | Yes |  |
| `InspectionRouteName` | `string` | Yes |  |
| `InspectionGroupID` | `int` | Yes |  |
| `Reference1` | `string` | Yes |  |
| `Reference2` | `string` | Yes |  |
| `EstimatedDuration` | `decimal(10,2)` | Yes |  |
| `SpatialInfo` | `binary` | Yes |  |
| `InspectionID` | `int` | Yes |  |
| `ModuleID` | `int` | Yes |  |
| `Deleted` | `boolean` | Yes |  |
| `WKT` | `string` | Yes |  |
| `DueDate` | `string` | Yes |  |
| `EarlyStartDate` | `string` | Yes |  |
| `PlannedScheduledDate` | `string` | Yes |  |
| `inspectiontypenamederived` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
