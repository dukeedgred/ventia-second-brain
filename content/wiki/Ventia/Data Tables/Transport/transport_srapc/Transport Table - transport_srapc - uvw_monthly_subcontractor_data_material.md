---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_srapc
table-name: uvw_monthly_subcontractor_data_material
full-name: transport_dev.transport_srapc.uvw_monthly_subcontractor_data_material
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-srapc]
---

# Transport Table - transport_srapc - uvw_monthly_subcontractor_data_material

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_monthly_subcontractor_data_material` |
| Full name | `transport_dev.transport_srapc.uvw_monthly_subcontractor_data_material` |
| Catalog | `transport_dev` |
| Schema | `transport_srapc` |
| Contract/schema | `transport_srapc` |
| Table type | VIEW |
| Column count | 28 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | inventory / materials |
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2025-10-27T02:11:11.833Z; Last altered: 2025-10-27T02:11:11.833Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
SELECT
  -- Admin --
  --  AccountID  AS `AccountID`,
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
  -- Material --
  formNumber_30 AS `Aggregrate consumption (tonne)`,
  formNumber_45 AS `Recycled Aggregrate consumption (tonne)`,
  formText_11 AS `Aggregrate supplier`,
  formText_10 AS `Asphalt supplier`,
  formNumber_51 AS `Asphalt consumption (tonne)`,
  formNumber_95 AS `Recycled asphalt (RAP) consumption (tonne) `,
  formNumber_46 AS `Concrete consumption_tonnes`,
  formText_12 AS `Concrete supplier`,
  formNumber_7 AS `Recovered glass_generated_tonnes`,
  formText_13 AS `Glass supplier`,
  formText_17 AS `other material name`,
  formNumber_8 AS `other material quantity`,
  formDropdown_26 AS `other material UoM`,
  NotPotableWater_description_1 AS `Water (Not potable) description`,
  formNumber_53 AS `Water (Not potable) kilolitres (kl)`,
  PotableWater_description AS `Water (potable) description`,
  formNumber_52 AS `Water (Potable) kilolitres (kL)`,
  formNumber_54 AS `Electricity consumption kWh`
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
| `Aggregrate consumption (tonne)` | `string` | Yes |  |
| `Recycled Aggregrate consumption (tonne)` | `string` | Yes |  |
| `Aggregrate supplier` | `string` | Yes |  |
| `Asphalt supplier` | `string` | Yes |  |
| `Asphalt consumption (tonne)` | `string` | Yes |  |
| `Recycled asphalt (RAP) consumption (tonne) ` | `string` | Yes |  |
| `Concrete consumption_tonnes` | `string` | Yes |  |
| `Concrete supplier` | `string` | Yes |  |
| `Recovered glass_generated_tonnes` | `string` | Yes |  |
| `Glass supplier` | `string` | Yes |  |
| `other material name` | `string` | Yes |  |
| `other material quantity` | `string` | Yes |  |
| `other material UoM` | `string` | Yes |  |
| `Water (Not potable) description` | `string` | Yes |  |
| `Water (Not potable) kilolitres (kl)` | `string` | Yes |  |
| `Water (potable) description` | `string` | Yes |  |
| `Water (Potable) kilolitres (kL)` | `string` | Yes |  |
| `Electricity consumption kWh` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_srapc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
