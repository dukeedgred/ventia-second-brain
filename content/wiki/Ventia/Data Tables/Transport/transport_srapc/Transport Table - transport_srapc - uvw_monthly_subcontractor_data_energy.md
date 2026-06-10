---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_srapc
table-name: uvw_monthly_subcontractor_data_energy
full-name: transport_dev.transport_srapc.uvw_monthly_subcontractor_data_energy
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-srapc]
---

# Transport Table - transport_srapc - uvw_monthly_subcontractor_data_energy

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_monthly_subcontractor_data_energy` |
| Full name | `transport_dev.transport_srapc.uvw_monthly_subcontractor_data_energy` |
| Catalog | `transport_dev` |
| Schema | `transport_srapc` |
| Contract/schema | `transport_srapc` |
| Table type | VIEW |
| Column count | 37 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2025-10-27T02:09:57.97Z; Last altered: 2025-10-27T02:09:57.97Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
SELECT
  -- Admin --
  --AccountID  AS `AccountID`,
  ABN AS `ABN`,
  submittedFormID AS `Form ID`,
  formText_3 AS `Name of Aboriginal vendor (sub subcontracted)`,
  formNumber_1 AS `Number of Employees 20+`,
  Period AS `Reporting period`,
  Subcontractor AS `Subcontractor`,
  email AS `Subcontractor email`,
  to_date(Date, 'dd MMM yyyy') AS Submission_Date,
  formDropdown_12 AS `Main Type of Works`,
  formText_2 AS `Contractor Representative Name`,
  -- Energy --
  -- Does not exist -- Biodiesel_Stationary AS `BioDiesel used in Litres (L)_stationary`,
  Biodiesel_transport_Litres AS `Biodiesel_transport_Litres`,
  formNumber_5 AS `Diesel consumed_lighting equipment`,
  Diesel_Generator_Litres AS `Diesel_Generator_Litres`,
  Diesel_Generator_Over_Litres AS `Diesel_Generator_Over_Litres`,
  Diesel_Stationary_Litres AS `Diesel_Stationary_Litres`,
  Diesel_Transport_Litres AS `Diesel_Transport_Litres`,
  E1_Transport_Litres AS `E10_Transport_Litres`,
  E10_Stationary_Litres AS `E10_Stationary_Litres`,
  Electric_transport_1 AS `Electric_transport_1`,
  formNumber_54 AS `Electricity consumption in Kilowatts hour (kWh)`,
  -- Does not exist -- Electricity_Stationary AS `Electricity used in kWh (kWh)_stationary`,
  Grease_Litres AS `Grease_Litres`,
  -- Does not exist -- Hydrogen_Stationary AS `Hydrogen used in kilograms (kg)_stationary`,
  LPG_Stationary_Kg AS `LPG_Stationary_Kg`,
  LPG_transport_Litres AS `LPG_transport_Litres`,
  Other_generator_fuel AS `Other_generator_fuel`,
  Petrol_stationary_Litres AS `Petrol_stationary_Litres`,
  Petrol_transport_Litres AS `Petrol_transport_Litres`,
  Regular_oil_Litres AS `Regular_oil_Litres`,
  Regular_oil_1 AS `Regular_oil_staionary`,
  Diesel_Stationary_Litres AS `Stationary Diesel Consumption  (Litres)`,
  E10_Stationary AS `Stationary E10 Consumption (Litres)`,
  LPG_Stationary AS `Stationary LPG consumption (kg)`,
  Petrol_stationary AS `Stationary Petrol Consumption (Litres)`,
  formNumber_13 AS `formNumber_13`,
  -- Does not exist -- formRow_1 AS `What is the consumption of fuel for each type of plant and equipment? (add a row for each piece of equipment)`,
  formText_49 AS `Type of generator`,
  formDropdown_26 AS `Other Material Unit of measurement`,
  formDropdown_2 AS `Additional Material Unit of measurement`,
  formText_46 AS `Unit of Measurement (UoM) for other generator`
FROM
  transport_dev.formitize_srapc.srapc_monthly_subcontractor_data_capture_portal
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `ABN` | `string` | Yes |  |
| `Form ID` | `int` | No |  |
| `Name of Aboriginal vendor (sub subcontracted)` | `string` | Yes |  |
| `Number of Employees 20+` | `string` | Yes |  |
| `Reporting period` | `string` | Yes |  |
| `Subcontractor` | `string` | Yes |  |
| `Subcontractor email` | `string` | Yes |  |
| `Submission_Date` | `date` | Yes |  |
| `Main Type of Works` | `string` | Yes |  |
| `Contractor Representative Name` | `string` | Yes |  |
| `Biodiesel_transport_Litres` | `string` | Yes |  |
| `Diesel consumed_lighting equipment` | `string` | Yes |  |
| `Diesel_Generator_Litres` | `string` | Yes |  |
| `Diesel_Generator_Over_Litres` | `string` | Yes |  |
| `Diesel_Stationary_Litres` | `string` | Yes |  |
| `Diesel_Transport_Litres` | `string` | Yes |  |
| `E10_Transport_Litres` | `string` | Yes |  |
| `E10_Stationary_Litres` | `string` | Yes |  |
| `Electric_transport_1` | `string` | Yes |  |
| `Electricity consumption in Kilowatts hour (kWh)` | `string` | Yes |  |
| `Grease_Litres` | `string` | Yes |  |
| `LPG_Stationary_Kg` | `string` | Yes |  |
| `LPG_transport_Litres` | `string` | Yes |  |
| `Other_generator_fuel` | `string` | Yes |  |
| `Petrol_stationary_Litres` | `string` | Yes |  |
| `Petrol_transport_Litres` | `string` | Yes |  |
| `Regular_oil_Litres` | `string` | Yes |  |
| `Regular_oil_staionary` | `string` | Yes |  |
| `Stationary Diesel Consumption  (Litres)` | `string` | Yes |  |
| `Stationary E10 Consumption (Litres)` | `string` | Yes |  |
| `Stationary LPG consumption (kg)` | `string` | Yes |  |
| `Stationary Petrol Consumption (Litres)` | `string` | Yes |  |
| `formNumber_13` | `string` | Yes |  |
| `Type of generator` | `string` | Yes |  |
| `Other Material Unit of measurement` | `string` | Yes |  |
| `Additional Material Unit of measurement` | `string` | Yes |  |
| `Unit of Measurement (UoM) for other generator` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_srapc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
