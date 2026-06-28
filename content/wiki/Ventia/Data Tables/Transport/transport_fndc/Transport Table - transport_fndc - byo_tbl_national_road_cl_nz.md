---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_fndc
table-name: byo_tbl_national_road_cl_nz
full-name: transport_dev.transport_fndc.byo_tbl_national_road_cl_nz
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-table, databricks, transport-fndc, road-network]
---

# Transport Table - transport_fndc - byo_tbl_national_road_cl_nz

## Identity

| Field | Value |
|---|---|
| Table name | `byo_tbl_national_road_cl_nz` |
| Full name | `transport_dev.transport_fndc.byo_tbl_national_road_cl_nz` |
| Catalog | `transport_dev` |
| Schema | `transport_fndc` |
| Contract/schema | `transport_fndc` |
| Table type | MANAGED |
| Column count | 26 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Business purpose | This table contains data related to the national road centreline network, focusing on road controlling authorities. It includes information about road segments such as their geographic start and end coordinates, road names, classification, and surface types. Traffic data like total volume, heavy vehicle volume, and vehicle kilometres travelled are recorded, along with details about the responsible territorial authority. The data is useful for analyzing road usage, monitoring traffic patterns, planning maintenance, and managing road assets under different controlling authorities. |
| Data domain | road network |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `OBJECTID` | `bigint` | Yes |  |
| `ID` | `bigint` | Yes |  |
| `alphaModifiedDate` | `string` | Yes |  |
| `assetCarriageWayID` | `bigint` | Yes |  |
| `assetCwayEndNZTMX` | `double` | Yes |  |
| `assetCwayEndNZTMY` | `double` | Yes |  |
| `assetCwayStartNZTMX` | `double` | Yes |  |
| `assetCwayStartNZTMY` | `double` | Yes |  |
| `assetRCAID` | `string` | Yes |  |
| `assetRoadID` | `bigint` | Yes |  |
| `carriagewayEnd` | `bigint` | Yes |  |
| `carriagewayStart` | `bigint` | Yes |  |
| `endName` | `string` | Yes |  |
| `fullRoadName` | `string` | Yes |  |
| `geomModifiedDate` | `string` | Yes |  |
| `hvyVehicleTrafficVolume` | `bigint` | Yes |  |
| `hvyVehicleTrafficVolumeP` | `double` | Yes |  |
| `ONRCClass` | `string` | Yes |  |
| `retiredDate` | `string` | Yes |  |
| `startName` | `string` | Yes |  |
| `surfaceType` | `string` | Yes |  |
| `trafficVolume` | `bigint` | Yes |  |
| `vehicleKilometresTravelled` | `bigint` | Yes |  |
| `width` | `double` | Yes |  |
| `TACode` | `bigint` | Yes |  |
| `TAName` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_fndc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
