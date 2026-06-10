---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_srapc
table-name: uvw_monthly_subcontractor_data_waste
full-name: transport_dev.transport_srapc.uvw_monthly_subcontractor_data_waste
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-srapc]
---

# Transport Table - transport_srapc - uvw_monthly_subcontractor_data_waste

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_monthly_subcontractor_data_waste` |
| Full name | `transport_dev.transport_srapc.uvw_monthly_subcontractor_data_waste` |
| Catalog | `transport_dev` |
| Schema | `transport_srapc` |
| Contract/schema | `transport_srapc` |
| Table type | VIEW |
| Column count | 75 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2025-10-27T02:13:08.376Z; Last altered: 2025-10-27T02:13:08.376Z |
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
  -- Waste --
  Acid_sulfate_soils_generated_tonnes AS `Acid_sulfate_soils_generated_tonnes`,
  Acid_sulfate_soils_Provider AS `Acid_sulfate_soils_Provider`,
  formNumber_78 AS `Acid_sulfate_soils_recycled_tonnes`,
  formNumber_12 AS `Aggregatewaste_generated_tonnes`,
  formNumber_79 AS `Aggregatewaste_recycled_tonnes`,
  formText_15 AS `Aggregate_ServiceProvider`,
  formNumber_44 AS `Concrete_generated_tonnes`,
  formNumber_81 AS `Concrete_recycled_tonnes`,
  formText_18 AS `Concrete_ServiceProvider`,
  formNumber_22 AS `C&D_generated_tonnes`,
  formNumber_80 AS `C&D_recycled_tonnes`,
  formButton_5 AS `C&D_waste  dockets`,
  formText_19 AS `C&D_waste_ServiceProvider`,
  formDate_1 AS `Date of special waste removal from site`,
  formText_9 AS `Description other C&D types`,
  formNumber_23 AS `Excavated Natural Material (ENM)_generated_tonnes`,
  formNumber_83 AS `Excavated Natural Material (ENM)_recycled_tonnes`,
  formText_20 AS `Excavated Natural Material (ENM)_ServiceProvider`,
  formNumber_24 AS `Excavated Public Road Materials (EPRM)_generated_tonnes`,
  formNumber_84 AS `Excavated Public Road Materials (EPRM)_recycled_tonnes`,
  formText_21 AS `Excavated Public Road Materials (EPRM)_ServiceProvider`,
  formNumber_48 AS `Ferrous metal_generated_tonnes`,
  formNumber_49 AS `Ferrous metal_recycled_tonnes`,
  formText_25 AS `Ferrous metal_ServiceProvider`,
  formNumber_41 AS `General waste_generated_tonnes`,
  formNumber_93 AS `General waste_recycled_tonnes`,
  formNumber_25 AS `Glass waste_generated_tonnes`,
  formNumber_85 AS `Glass waste_recycled_tonnes`,
  formText_36 AS `Glass waste_ServiceProvider`,
  formNumber_27 AS `Hazardous waste_generated_tonnes`,
  formText_23 AS `Hazardous waste_ServiceProvider`,
  formNumber_96 AS `Light fixture_generated_tonnes`,
  formNumber_97 AS `Light fixture_recycled_tonnes`,
  formNumber_26 AS `Liquid waste_generated_kl`,
  formNumber_86 AS `Liquid waste_recycled_kl`,
  formText_22 AS `Liquid Waste_ServiceProvider`,
  formNumber_82 AS `Milled Asphalt recycled_tonnes`,
  formNumber_21 AS `Milled Asphalt_generated_tonnes`,
  formText_16 AS `Milled_Asphalt_ServiceProvider`,
  formNumber_28 AS `Mulch_generated_tonnes`,
  formNumber_87 AS `Mulch_recycled_tonnes`,
  formText_24 AS `Mulch_ServiceProvider`,
  formNumber_29 AS `Non-ferrous metal_generated_tonnes`,
  formNumber_88 AS `Non-ferrous metal_recycled_tonnes`,
  formText_26 AS `Non-ferrous metal_ServiceProvider`,
  formNumber_43 AS `Other Waste Generated`,
  formNumber_101 AS `Other Waste recycled_tonnes`,
  formText_8 AS `Name of other waste`,
  formNumber_42 AS `Paper and cardboard_generated_tonnes`,
  formNumber_94 AS `Paper and cardboard_recycled_tonnes`,
  formNumber_7 AS `Recovered Glass Sand Consumption_tonnes`,
  formNumber_35 AS `Restricted solid waste generated_tonnes`,
  formNumber_36 AS `Special waste (Asbestos) generated_tonnes`,
  formText_39 AS `Special waste (Asbestos)_disposal facility`,
  formNumber_99 AS `Street_sweepings_generated_tonnes`,
  formNumber_100 AS `Street_sweepings_recycled_tonnes`,
  formText_41 AS `Street_sweepings_ServiceProvider`,
  formNumber_37 AS `Timber waste_generated_tonnes`,
  formNumber_89 AS `Timber waste_recycled_tonnes`,
  formNumber_38 AS `Vegetation (green waste)_generated_tonnes`,
  formNumber_90 AS `Vegetation (green waste)_recycled_tonnes`,
  formNumber_39 AS `VENM_generated_tonnes`,
  formNumber_91 AS `VENM_recycled_tonnes`,
  formNumber_40 AS `E-waste_generated_tonnes`,
  formNumber_92 AS `E-waste_recycled_tonnes`
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
| `Acid_sulfate_soils_generated_tonnes` | `string` | Yes |  |
| `Acid_sulfate_soils_Provider` | `string` | Yes |  |
| `Acid_sulfate_soils_recycled_tonnes` | `string` | Yes |  |
| `Aggregatewaste_generated_tonnes` | `string` | Yes |  |
| `Aggregatewaste_recycled_tonnes` | `string` | Yes |  |
| `Aggregate_ServiceProvider` | `string` | Yes |  |
| `Concrete_generated_tonnes` | `string` | Yes |  |
| `Concrete_recycled_tonnes` | `string` | Yes |  |
| `Concrete_ServiceProvider` | `string` | Yes |  |
| `C&D_generated_tonnes` | `string` | Yes |  |
| `C&D_recycled_tonnes` | `string` | Yes |  |
| `C&D_waste  dockets` | `string` | Yes |  |
| `C&D_waste_ServiceProvider` | `string` | Yes |  |
| `Date of special waste removal from site` | `string` | Yes |  |
| `Description other C&D types` | `string` | Yes |  |
| `Excavated Natural Material (ENM)_generated_tonnes` | `string` | Yes |  |
| `Excavated Natural Material (ENM)_recycled_tonnes` | `string` | Yes |  |
| `Excavated Natural Material (ENM)_ServiceProvider` | `string` | Yes |  |
| `Excavated Public Road Materials (EPRM)_generated_tonnes` | `string` | Yes |  |
| `Excavated Public Road Materials (EPRM)_recycled_tonnes` | `string` | Yes |  |
| `Excavated Public Road Materials (EPRM)_ServiceProvider` | `string` | Yes |  |
| `Ferrous metal_generated_tonnes` | `string` | Yes |  |
| `Ferrous metal_recycled_tonnes` | `string` | Yes |  |
| `Ferrous metal_ServiceProvider` | `string` | Yes |  |
| `General waste_generated_tonnes` | `string` | Yes |  |
| `General waste_recycled_tonnes` | `string` | Yes |  |
| `Glass waste_generated_tonnes` | `string` | Yes |  |
| `Glass waste_recycled_tonnes` | `string` | Yes |  |
| `Glass waste_ServiceProvider` | `string` | Yes |  |
| `Hazardous waste_generated_tonnes` | `string` | Yes |  |
| `Hazardous waste_ServiceProvider` | `string` | Yes |  |
| `Light fixture_generated_tonnes` | `string` | Yes |  |
| `Light fixture_recycled_tonnes` | `string` | Yes |  |
| `Liquid waste_generated_kl` | `string` | Yes |  |
| `Liquid waste_recycled_kl` | `string` | Yes |  |
| `Liquid Waste_ServiceProvider` | `string` | Yes |  |
| `Milled Asphalt recycled_tonnes` | `string` | Yes |  |
| `Milled Asphalt_generated_tonnes` | `string` | Yes |  |
| `Milled_Asphalt_ServiceProvider` | `string` | Yes |  |
| `Mulch_generated_tonnes` | `string` | Yes |  |
| `Mulch_recycled_tonnes` | `string` | Yes |  |
| `Mulch_ServiceProvider` | `string` | Yes |  |
| `Non-ferrous metal_generated_tonnes` | `string` | Yes |  |
| `Non-ferrous metal_recycled_tonnes` | `string` | Yes |  |
| `Non-ferrous metal_ServiceProvider` | `string` | Yes |  |
| `Other Waste Generated` | `string` | Yes |  |
| `Other Waste recycled_tonnes` | `string` | Yes |  |
| `Name of other waste` | `string` | Yes |  |
| `Paper and cardboard_generated_tonnes` | `string` | Yes |  |
| `Paper and cardboard_recycled_tonnes` | `string` | Yes |  |
| `Recovered Glass Sand Consumption_tonnes` | `string` | Yes |  |
| `Restricted solid waste generated_tonnes` | `string` | Yes |  |
| `Special waste (Asbestos) generated_tonnes` | `string` | Yes |  |
| `Special waste (Asbestos)_disposal facility` | `string` | Yes |  |
| `Street_sweepings_generated_tonnes` | `string` | Yes |  |
| `Street_sweepings_recycled_tonnes` | `string` | Yes |  |
| `Street_sweepings_ServiceProvider` | `string` | Yes |  |
| `Timber waste_generated_tonnes` | `string` | Yes |  |
| `Timber waste_recycled_tonnes` | `string` | Yes |  |
| `Vegetation (green waste)_generated_tonnes` | `string` | Yes |  |
| `Vegetation (green waste)_recycled_tonnes` | `string` | Yes |  |
| `VENM_generated_tonnes` | `string` | Yes |  |
| `VENM_recycled_tonnes` | `string` | Yes |  |
| `E-waste_generated_tonnes` | `string` | Yes |  |
| `E-waste_recycled_tonnes` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_srapc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
