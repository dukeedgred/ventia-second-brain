---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_sht
table-name: uvw_inspection
full-name: transport_dev.transport_sht.uvw_inspection
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-sht]
---

# Transport Table - transport_sht - uvw_inspection

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_inspection` |
| Full name | `transport_dev.transport_sht.uvw_inspection` |
| Catalog | `transport_dev` |
| Schema | `transport_sht` |
| Contract/schema | `transport_sht` |
| Table type | VIEW |
| Column count | 46 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | inspection / audit / condition |
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2024-06-18T11:35:45.494Z; Last altered: 2024-07-18T20:07:02.21Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |
| Caveats/open questions | This is a curated `transport_sht` Databricks schema table/view; it does not prove the SHT source operational system is Asset Vision. |

## View Query

```sql
select * from ext_mssql_asset_vision_vns_gen7.dbo.inspection
where contract = 'Sydney Harbour Tunnel (SHT)'
  and deleted = false
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `ID` | `int` | Yes |  |
| `DeltaUTC` | `timestamp` | Yes |  |
| `ModifiedUTC` | `timestamp` | Yes |  |
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

## Related Pages

- [[Transport Contract Tables - transport_sht]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
