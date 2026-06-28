---
type: data-table
topic: Ventia
sector: Transport
contract-schema: formitize_srapc
table-name: srapc_monthly_subcontractor_data_capture_portal_fuel_stationary
full-name: transport_dev.formitize_srapc.srapc_monthly_subcontractor_data_capture_portal_fuel_stationary
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, formitize-srapc]
---

# Transport Table - formitize_srapc - srapc_monthly_subcontractor_data_capture_portal_fuel_stationary

## Identity

| Field | Value |
|---|---|
| Table name | `srapc_monthly_subcontractor_data_capture_portal_fuel_stationary` |
| Full name | `transport_dev.formitize_srapc.srapc_monthly_subcontractor_data_capture_portal_fuel_stationary` |
| Catalog | `transport_dev` |
| Schema | `formitize_srapc` |
| Contract/schema | `formitize_srapc` |
| Table type | MANAGED |
| Column count | 14 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | bd8c9950-d6b9-496b-95eb-be4d7211e1e9 |
| Refresh/freshness | Created: 2025-03-20T07:18:30.04Z; Last altered: 2025-10-15T03:51:00.919Z |
| Source details | Data source format: DELTA |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `submittedFormID` | `int` | No |  |
| `formID` | `int` | Yes |  |
| `version` | `int` | Yes |  |
| `sub_level` | `int` | No |  |
| `Biodiesel_Stationary` | `string` | Yes |  |
| `Diesel_Stationary` | `string` | Yes |  |
| `E10_Stationary` | `string` | Yes |  |
| `Electricity_stationary` | `string` | Yes |  |
| `Hydrogen_Stationary` | `string` | Yes |  |
| `LPG_Stationary` | `string` | Yes |  |
| `Petrol_stationary` | `string` | Yes |  |
| `formDropdown_13` | `string` | Yes |  |
| `row_updated_exec_id` | `string` | Yes |  |
| `row_updated_timestamp` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - formitize_srapc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
