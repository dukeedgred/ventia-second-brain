---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport
table-name: uvw_equipment_master_data_ie36
full-name: transport_dev.transport.uvw_equipment_master_data_ie36
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport]
---

# Transport Table - transport - uvw_equipment_master_data_ie36

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_equipment_master_data_ie36` |
| Full name | `transport_dev.transport.uvw_equipment_master_data_ie36` |
| Catalog | `transport_dev` |
| Schema | `transport` |
| Contract/schema | `transport` |
| Table type | VIEW |
| Column count | 73 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | bhupesh.balani@ventia.com |
| Refresh/freshness | Created: 2025-04-07T06:02:52.491Z; Last altered: 2025-04-07T06:02:52.491Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
SELECT int(left(cost_centre,5)) as PC_ID,  s.*
from corporate_dev.enterprise_reporting.uvw_sap_vehicles_list_ie36 s
inner join transport_dev.transport.uvw_pc_masterdata t 
ON int(left(s.cost_centre,5)) = t.PC_ID
UNION all
SELECT int(left(s.cost_centre,5)) as PC_ID,  *
from corporate_dev.enterprise_reporting.uvw_sap_vehicles_list_ie36 s
where int(left(s.cost_centre,5))=90240
UNION all
Select int(left(s.cost_centre,5)) as PC_ID,  *
from corporate_dev.enterprise_reporting.uvw_sap_vehicles_list_ie36 s
where int(left(s.cost_centre,5))=90050
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `PC_ID` | `int` | Yes |  |
| `equipment_no` | `int` | Yes |  |
| `asset_no` | `int` | Yes |  |
| `asset_sub_no` | `int` | Yes |  |
| `OBJNR` | `string` | Yes | Object number |
| `valid_from_date` | `date` | Yes |  |
| `valid_to_date` | `date` | Yes |  |
| `vehicle_type` | `string` | Yes | Vehicle Type |
| `fleet_object_number` | `string` | Yes | Identification number for fleet object |
| `license_plate` | `string` | Yes | License plate number |
| `vehichle_vin` | `string` | Yes | Manufacturer Vehicle Identification Number for Fleet Object |
| `equipment_description` | `string` | Yes | Description of Technical Object |
| `superordinate_equipment` | `int` | Yes |  |
| `technical_identification_no` | `string` | Yes | Technical identification number |
| `inventory_number` | `string` | Yes | Inventory number |
| `expiry_date` | `date` | Yes |  |
| `location` | `string` | Yes |  |
| `company_code` | `string` | Yes | Company Code |
| `business_area` | `string` | Yes | Business Area |
| `cost_centre` | `string` | Yes |  |
| `functional_location` | `string` | Yes | Functional Location Label |
| `functional_location_description` | `string` | Yes | Description of functional location |
| `wbs_element` | `string` | Yes | Work Breakdown Structure Element (WBS Element) Edited |
| `controlling_area` | `string` | Yes | Controlling Area |
| `planning_plant` | `string` | Yes | Maintenance Planning Plant |
| `planner_group` | `string` | Yes | Planner Group for Customer Service and Plant Maintenance |
| `work_centre` | `string` | Yes |  |
| `main_work_centre` | `string` | Yes | Work Center |
| `usage_indicator` | `string` | Yes | Usage indicator |
| `list_name` | `string` | Yes | Name 1 |
| `standing_order` | `string` | Yes |  |
| `manufacturer` | `string` | Yes | Manufacturer of asset |
| `serial_number` | `string` | Yes | Manufacturer serial number |
| `engine_type` | `string` | Yes | Engine type |
| `model_number` | `string` | Yes | Manufacturer model number |
| `year_of_construction` | `string` | Yes | Year of construction |
| `month_of_construction` | `string` | Yes | Month of construction |
| `maximum_load_weight` | `decimal(13,3)` | Yes | Maximum load weight |
| `unit_of_weight` | `string` | Yes | Unit of weight |
| `gross_weight` | `decimal(13,3)` | Yes | Weight of object |
| `total_weight_allowed` | `decimal(13,3)` | Yes | Total Weight Allowed |
| `system_status` | `string` | Yes | Individual status of an object (short form) |
| `created_on` | `date` | Yes |  |
| `created_by` | `string` | Yes | Name of Person Responsible for Creating the Object |
| `modified_on` | `date` | Yes |  |
| `modified_by` | `string` | Yes | Name of Person Who Changed Object |
| `OBJEK` | `string` | Yes |  |
| `Annual Inspection date` | `string` | Yes |  |
| `Annual Roadworthy Check` | `string` | Yes |  |
| `Compliance Date` | `string` | Yes |  |
| `Engine Manufacturer` | `string` | Yes |  |
| `Engine Model Number` | `string` | Yes |  |
| `Equipment Class` | `string` | Yes |  |
| `Equipment Discipline` | `string` | Yes |  |
| `Equipment Sub Category` | `string` | Yes |  |
| `Fitout` | `string` | Yes |  |
| `IVMS` | `string` | Yes |  |
| `IVMS Product` | `string` | Yes |  |
| `LP Fleet Admin Product Suite` | `string` | Yes |  |
| `Maintenance Compliance Class` | `string` | Yes |  |
| `Maintenance Status` | `string` | Yes |  |
| `Major Structural Insp Date` | `string` | Yes |  |
| `Modified FBT` | `string` | Yes |  |
| `Ownership Type` | `string` | Yes |  |
| `Plant Fuel Card Type` | `string` | Yes |  |
| `Plant Risk Assessment Category` | `string` | Yes |  |
| `Previous Licence Plate` | `string` | Yes |  |
| `Referenced in Plant Assessor` | `string` | Yes |  |
| `Search Term 01` | `string` | Yes |  |
| `State of Registration` | `string` | Yes |  |
| `Supplier Lease ID` | `string` | Yes |  |
| `Type of Technical Object` | `string` | Yes |  |
| `Underutilised Asset Exemption` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
