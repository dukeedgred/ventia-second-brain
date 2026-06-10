---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport
table-name: uvw_equipment_nbv_dep_zftm_asseteqip
full-name: transport_dev.transport.uvw_equipment_nbv_dep_zftm_asseteqip
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport]
---

# Transport Table - transport - uvw_equipment_nbv_dep_zftm_asseteqip

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_equipment_nbv_dep_zftm_asseteqip` |
| Full name | `transport_dev.transport.uvw_equipment_nbv_dep_zftm_asseteqip` |
| Catalog | `transport_dev` |
| Schema | `transport` |
| Contract/schema | `transport` |
| Table type | VIEW |
| Column count | 66 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | asset register / hierarchy |
| Owner/SME | bhupesh.balani@ventia.com |
| Refresh/freshness | Created: 2025-03-06T06:37:29.97Z; Last altered: 2025-03-06T06:37:29.97Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
select s.*
from corporate_dev.enterprise_reporting.uvw_sap_zftm_asseteqip s
inner join transport_dev.transport.uvw_pc_masterdata t 
ON s.profit_centre = t.PC_ID
UNION all
SELECT *
from corporate_dev.enterprise_reporting.uvw_sap_zftm_asseteqip s
where s.profit_centre=90240
UNION all
SELECT *
from corporate_dev.enterprise_reporting.uvw_sap_zftm_asseteqip s
where s.profit_centre=90050
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `company_code` | `string` | No |  |
| `asset_class` | `string` | Yes |  |
| `asset_number` | `int` | Yes |  |
| `equipment_number` | `bigint` | Yes |  |
| `original_asset_number` | `int` | Yes |  |
| `asset_description` | `string` | Yes |  |
| `asset_description_2` | `string` | Yes |  |
| `asset_main_no_text` | `string` | Yes |  |
| `vehicle_type` | `string` | Yes |  |
| `profit_centre` | `int` | Yes |  |
| `cost_centre` | `int` | Yes |  |
| `re_key` | `string` | Yes |  |
| `license_plate_no` | `string` | Yes |  |
| `vehicle_license_plate_no` | `string` | Yes |  |
| `object_type` | `string` | Yes |  |
| `inventory_number` | `string` | Yes |  |
| `serial_number` | `string` | Yes |  |
| `planner_group` | `string` | Yes |  |
| `wbs_element` | `string` | Yes |  |
| `lease_payment` | `decimal(13,2)` | Yes |  |
| `lease_start_date` | `date` | Yes |  |
| `notice_date` | `date` | Yes |  |
| `type_name` | `string` | Yes |  |
| `base_value_as_new` | `decimal(13,2)` | Yes |  |
| `asset_capitalization_date` | `date` | Yes |  |
| `account_determination` | `string` | Yes |  |
| `quantity` | `decimal(13,3)` | Yes |  |
| `unit_of_measure` | `string` | Yes |  |
| `standing_order` | `string` | Yes |  |
| `vendor_number` | `string` | Yes |  |
| `vendor_name` | `string` | Yes |  |
| `leasing_company` | `string` | Yes |  |
| `agreement_number` | `string` | Yes |  |
| `agreement_date` | `date` | Yes |  |
| `lease_length_years` | `string` | Yes |  |
| `lease_length_periods` | `string` | Yes |  |
| `leasing_type` | `string` | Yes |  |
| `purchase_price` | `decimal(13,2)` | Yes |  |
| `supplementary_text` | `string` | Yes |  |
| `number_of_lease_payments` | `decimal(5,0)` | Yes |  |
| `payment_cycle` | `string` | Yes |  |
| `leasing_data_text` | `string` | Yes |  |
| `capitalization_date` | `date` | Yes |  |
| `planned_retirement_date` | `date` | Yes |  |
| `deactivation_date` | `date` | Yes |  |
| `aquisition_date` | `date` | Yes |  |
| `depreciation_calculation_start_date` | `date` | Yes |  |
| `depreciation_key` | `string` | Yes |  |
| `useful_life` | `int` | Yes |  |
| `planned_useful_life` | `int` | Yes |  |
| `expired_useful_life_periods` | `int` | Yes |  |
| `expired_useful_life_years` | `int` | Yes |  |
| `acquisition_value_transactions` | `decimal(16,2)` | Yes |  |
| `fy_acquisition_value` | `decimal(17,2)` | Yes |  |
| `ordinary_depreciation_past` | `decimal(13,2)` | Yes |  |
| `ordinary_depreciation_tbp` | `decimal(13,2)` | No |  |
| `current_acquisition_value` | `decimal(22,2)` | Yes |  |
| `book_value_start_of_year` | `decimal(21,2)` | Yes |  |
| `movement_value_adjustment_year` | `decimal(20,2)` | Yes |  |
| `write_up` | `decimal(15,2)` | Yes |  |
| `current_net_book_value` | `decimal(31,2)` | Yes |  |
| `current_ordinary_depreciation` | `decimal(16,2)` | Yes |  |
| `depreciation_year` | `decimal(15,2)` | Yes |  |
| `depreciation_fye` | `decimal(16,2)` | Yes |  |
| `depreciation_fys` | `decimal(16,2)` | Yes |  |
| `depreciation_posted` | `decimal(16,2)` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
