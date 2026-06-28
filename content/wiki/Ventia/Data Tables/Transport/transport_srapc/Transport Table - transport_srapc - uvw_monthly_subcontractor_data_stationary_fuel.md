---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_srapc
table-name: uvw_monthly_subcontractor_data_stationary_fuel
full-name: transport_dev.transport_srapc.uvw_monthly_subcontractor_data_stationary_fuel
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-srapc]
---

# Transport Table - transport_srapc - uvw_monthly_subcontractor_data_stationary_fuel

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_monthly_subcontractor_data_stationary_fuel` |
| Full name | `transport_dev.transport_srapc.uvw_monthly_subcontractor_data_stationary_fuel` |
| Catalog | `transport_dev` |
| Schema | `transport_srapc` |
| Contract/schema | `transport_srapc` |
| Table type | VIEW |
| Column count | 18 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2025-10-27T02:08:33.687Z; Last altered: 2025-10-27T02:08:33.687Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
select
  m.ABN AS `ABN`,
  m.submittedFormID AS `Form ID`,
  m.formText_3 AS `Name of Aboriginal vendor (sub subcontracted)`,
  m.formNumber_1 AS `Number of Employees 20+`,
  m.Period AS `Reporting period`,
  m.Subcontractor AS `Subcontractor`,
  m.email AS `Subcontractor email`,
  to_date(m.Date, 'dd MMM yyyy') AS Submission_Date,
  m.formDropdown_12 AS `Main Type of Works`,
  m.formText_2 AS `Contractor Representative Name`,
  f.formDropdown_13 AS `Type of equipment`,
  f.Diesel_Stationary AS `Diesel_Stationary`,
  f.Petrol_stationary AS `Petrol_stationary`,
  f.E10_Stationary AS `E10_Stationary`,
  f.Biodiesel_Stationary AS `Biodiesel_Stationary`,
  f.LPG_Stationary AS `LPG_Stationary`,
  f.Hydrogen_Stationary AS `Hydrogen_Stationary`,
  f.Electricity_stationary AS `Electricity_stationary`
from
  transport_dev.formitize_srapc.srapc_monthly_subcontractor_data_capture_portal_fuel_stationary f
    left join transport_dev.formitize_srapc.srapc_monthly_subcontractor_data_capture_portal m
      on m.submittedFormID = f.submittedFormID
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `ABN` | `string` | Yes |  |
| `Form ID` | `int` | Yes |  |
| `Name of Aboriginal vendor (sub subcontracted)` | `string` | Yes |  |
| `Number of Employees 20+` | `string` | Yes |  |
| `Reporting period` | `string` | Yes |  |
| `Subcontractor` | `string` | Yes |  |
| `Subcontractor email` | `string` | Yes |  |
| `Submission_Date` | `date` | Yes |  |
| `Main Type of Works` | `string` | Yes |  |
| `Contractor Representative Name` | `string` | Yes |  |
| `Type of equipment` | `string` | Yes |  |
| `Diesel_Stationary` | `string` | Yes |  |
| `Petrol_stationary` | `string` | Yes |  |
| `E10_Stationary` | `string` | Yes |  |
| `Biodiesel_Stationary` | `string` | Yes |  |
| `LPG_Stationary` | `string` | Yes |  |
| `Hydrogen_Stationary` | `string` | Yes |  |
| `Electricity_stationary` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_srapc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
