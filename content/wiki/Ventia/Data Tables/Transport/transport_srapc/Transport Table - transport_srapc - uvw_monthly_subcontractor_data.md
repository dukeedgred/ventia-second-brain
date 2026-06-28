---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_srapc
table-name: uvw_monthly_subcontractor_data
full-name: transport_dev.transport_srapc.uvw_monthly_subcontractor_data
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-srapc]
---

# Transport Table - transport_srapc - uvw_monthly_subcontractor_data

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_monthly_subcontractor_data` |
| Full name | `transport_dev.transport_srapc.uvw_monthly_subcontractor_data` |
| Catalog | `transport_dev` |
| Schema | `transport_srapc` |
| Contract/schema | `transport_srapc` |
| Table type | VIEW |
| Column count | 282 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | Helix_readwrite_transport_dev_transport_srapc |
| Refresh/freshness | Created: 2025-03-24T23:36:13.698Z; Last altered: 2025-07-09T05:03:56.114Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
SELECT
  ABN AS `ABN`,
--  AccountID  AS `AccountID`,
  Acid_sulfate_soils AS `Acid_sulfate_soils`,
  Acid_sulfate_soils_generated_tonnes AS `Acid_sulfate_soils_generated_tonnes`,
  Acid_sulfate_soils_Provider AS `Acid_sulfate_soils_Provider`,
  AsphaltWasteMilledAsphalt AS `Asphalt Waste -  Milled Asphalt`,
  Biodiesel_transport AS `Biodiesel_transport`,
  Biodiesel_transport_Litres AS `Biodiesel_transport_Litres`,
  Date AS `Submission Date`,
  Diesel_Generator AS `Diesel consumption for electrical generators`,
  Diesel_Generator_Litres AS `Diesel_Generator_Litres`,
  Diesel_Generator_Over AS `electrical generator fuel consumption`,
  Diesel_Generator_Over_Litres AS `Diesel_Generator_Over_Litres`,
  Diesel_Stationary AS `Stationary Diesel Consumption  (Litres)`,
  Diesel_Stationary_Litres AS `Diesel_Stationary_Litres`,
  Diesel_transport AS `Diesel Consumption`,
  Diesel_Transport_Litres AS `Diesel_Transport_Litres`,
  E1_Transport AS `E1_Transport`,
  E1_Transport_Litres AS `E10_Transport_Litres`,
  E10_Stationary AS `Stationary E10 Consumption (Litres)`,
  E10_Stationary_Litres AS `E10_Stationary_Litres`,
  Electric_transport AS `Electric Transport consumption`,
  Electric_transport_1 AS `Electric_transport_1`,
  email AS `Subcontractor email`,
  formButton_1 AS `Reported spend on Aboriginal employees`,
  formButton_10 AS `formButton_10`,
  formButton_11 AS `formButton_11`,
  formButton_12 AS `formButton_12`,
  formButton_13 AS `formButton_13`,
  formButton_14 AS `formButton_14`,
  formButton_15 AS `formButton_15`,
  formButton_16 AS `Aggregate Waste`,
  formButton_17 AS `formButton_17`,
  formButton_18 AS `Concrete Waste`,
  formButton_19 AS `Other construction and demolition (C&D) waste`,
  formButton_2 AS `Local Content Value`,
  formButton_20 AS `Excavated Natural Material (ENM) Waste`,
  formButton_21 AS `Excavated Public Road Materials (EPRM) Waste`,
  formButton_22 AS `Glass Waste`,
  formButton_23 AS `Liquid Waste`,
  formButton_24 AS `Hazardous Waste`,
  formButton_25 AS `Mulch Waste`,
  formButton_26 AS `Non-ferrous Metal Waste`,
 -- formButton_27 AS `formButton_27`,
  formButton_28 AS `Restricted Solid Waste`,
  formButton_29 AS `Special Waste (Asbestos)`,
  formButton_3 AS `Excavated Natural Material (ENM) Reused at TfNSW site`,
  formButton_30 AS `Timber Waste`,
  formButton_31 AS `Vegetation (Green Waste)`,
  formButton_32 AS `Virgin Excavated Natural Material (VENM)`,
  formButton_33 AS `Electronic Waste (E-waste)`,
  formButton_34 AS `General waste`,
  formButton_35 AS `Paper and Cardboard Waste`,
  formButton_36 AS `Other Waste Generated Type`,
  formButton_37 AS `Aggregate consumption`,
  formButton_38 AS `Concrete consumption`,
  formButton_39 AS `Ferrous Metals Waste - Steel`,
  formButton_4 AS `VENM_material used`,
  formButton_40 AS `other additional materials consumed`,
  formButton_41 AS `other materials consumed`,
  formButton_42 AS `Street sweepings waste`,
  formButton_44 AS `Recovered Glass Sand Consumption`,
  formButton_45 AS `Asphalt consumption`,
  formButton_46 AS `Potable water consumed from main`,
  formButton_47 AS `Non-potbale water consumed from main`,
  formButton_48 AS `Electricity consumed_SRAPC only`,
 -- formButton_49 AS `formButton_49`,
  formButton_5 AS `Excavated Public Road Materials (EPRM) Reused at TfNSW site`,
 -- formButton_50 AS `formButton_50`,
  --formButton_51 AS `formButton_51`,
  --formButton_52 AS `formButton_52`,
  --formButton_53 AS `formButton_53`,
  formButton_6 AS `Engagement of Aboriginal-owned subcontractors`,
  formButton_7 AS `Amount $ relates to Aboriginal-owned subcontractors`,
  formButton_70 AS `Light Fixtures Waste`,
  formButton_8 AS `formButton_8`,
  formButton_9 AS `formButton_9`,
  formCheckbox_1 AS `Integrity acknowledgement`,
  --formCheckbox_3 AS `formCheckbox_3`,
 -- formCheckbox_4 AS `formCheckbox_4`,
  formCheckbox_5 AS `Waste dockets_forwarded`,
  formCurrency_1 AS `Current claim $AUD`,
  formCurrency_2 AS `Month Claim Value`,
  formCurrency_3 AS `Aboriginal spend $AUD`,
  formDate_1 AS `Date of special waste removal from site`,
  formDate_2 AS `formDate_2`,
  formDate_3 AS `Date of special waste disposal at licensed facility`,
  formDropdown_1 AS `Aboriginal Employees in Claim / Invoice_trades`,
  formDropdown_10 AS `Total number of Trade Positions`,
  formDropdown_11 AS `Number of subcontractor employees`,
  formDropdown_12 AS `Type of Works`,
  formDropdown_2 AS `Additional Material Unit of measurement`,
  formDropdown_26 AS `Other Material Unit of measurement`,
  formDropdown_3 AS `Total number of Learning Workers`,
  formDropdown_4 AS `Aborignal owned`,
  formDropdown_5 AS `Aboriginal Employees in Claim / Invoice_non-trades`,
  formDropdown_6 AS `Total number of Trade Positions for Apprentices`,
  formDropdown_7 AS `Total number of Women in Trades Positions`,
  --formDropdown_7_1 AS `formDropdown_7_1`,
  formDropdown_8 AS `Total number of Employees under 25 Years of Age`,
  formDropdown_9 AS `Category of business`,
  formEmail_1 AS `formEmail_1`,
  formNumber_1 AS `Number of Employees 20+`,
  formNumber_10 AS `formNumber_10`,
  formNumber_100 AS `Street sweepings recycled tonnes`,
  formNumber_101 AS `Waste recycled (tonnes)`,
  formNumber_11 AS `formNumber_11`,
  formNumber_12 AS `Aggregate waste generated tonnes`,
  formNumber_13 AS `formNumber_13`,
  formNumber_14 AS `Numerical % of your claim_aboriginal`,
  formNumber_15 AS `Spend amount $AUD_aboriginal`,
  formNumber_17 AS `formNumber_17`,
  formNumber_18 AS `formNumber_18`,
  formNumber_19 AS `formNumber_19`,
  formNumber_2 AS `Subcontractor number`,
  formNumber_20 AS `formNumber_20`,
  formNumber_21 AS `MilledAsphalt_generated_tonnes`,
  formNumber_22 AS `C&D_generated_tonnes`,
  formNumber_23 AS `Excavated Natural Material (ENM)_generated_tonnes`,
  formNumber_24 AS `Excavated Public Road Materials (EPRM)_generated_tonnes`,
  formNumber_25 AS `Glass generated_tonnes`,
  formNumber_26 AS `Liquid waste_generated_kl`,
  formNumber_27 AS `Hazardous waste_generated_tonnes`,
  formNumber_28 AS `Mulch_generated_tonnes`,
  formNumber_29 AS `Non-ferrous metal_generated_tonnes`,
  formNumber_3 AS `Numerical %  claim (Aboriginal sub-subcontractors)`,
  formNumber_30 AS `Aggregate_generated_tonnes`,
  formNumber_31 AS `formNumber_31`,
  formNumber_32 AS `formNumber_32`,
  formNumber_33 AS `formNumber_33`,
  formNumber_34 AS `formNumber_34`,
  formNumber_35 AS `Restricted solid waste generated_tonnes`,
  formNumber_36 AS `Special waste (Asbestos) generated_tonnes`,
  formNumber_37 AS `Timber waste_generated_tonnes`,
  formNumber_38 AS `Vegetation (green waste)_generated_tonnes`,
  formNumber_39 AS `VENM generated tonnes`,
  formNumber_4 AS `formNumber_4`,
  formNumber_40 AS `E-waste generated generated tonnes`,
  formNumber_41 AS `General waste generated_tonnes`,
  formNumber_42 AS `Paper and cardboard_generated_tonnes`,
  formNumber_43 AS `Other materials_generated_tonnes`,
  formNumber_44 AS `Concrete_generated_tonnes`,
  formNumber_45 AS `Aggregate waste recycled tonnes`,
  formNumber_46 AS `Concrete consumption_tonnes`,
  formNumber_47 AS `formNumber_47`,
  formNumber_48 AS `Ferrous metal_generated_tonnes`,
  formNumber_49 AS `Ferrous metal_recycled_tonnes`,
  formNumber_5 AS `Diesel consumed_lighting equipment`,
  formNumber_50 AS `formNumber_50`,
  formNumber_51 AS `Asphalt consumption (tonne)`,
  formNumber_52 AS `Water (Potable) kilolitres (kL)`,
  formNumber_53 AS `Water (Not potable) kilolitres (kl)`,
  formNumber_54 AS `Electricity consumption in Kilowatts hour (kWh)`,
  formNumber_55 AS `formNumber_55`,
  formNumber_56 AS `formNumber_56`,
  formNumber_57 AS `Number of chain of responsibility heavy vehicle inspections conducted`,
  formNumber_58 AS `Total number of Health and Safety Hazards reported`,
  formNumber_59 AS `formNumber_59`,
  formNumber_6 AS `Total worker on foot hours (wage hours on site) within total staff hours`,
  formNumber_60 AS `Number of safety inspections undertaken`,
  formNumber_61 AS `formNumber_61`,
  formNumber_62 AS `Total staff hours (salary+hours) worked`,
  formNumber_63 AS `formNumber_63`,
  formNumber_64 AS `Number of Health and Safety regulatory vists`,
  formNumber_7 AS `Recovered Glass Sand Consumption_tonnes`,
  formNumber_71 AS `formNumber_71`,
  formNumber_72 AS `formNumber_72`,
  formNumber_73 AS `formNumber_73`,
  formNumber_74 AS `formNumber_74`,
  formNumber_75 AS `formNumber_75`,
  formNumber_76 AS `formNumber_76`,
  formNumber_77 AS `formNumber_77`,
  formNumber_78 AS `Acid_sulfate_soils_recycled_tonnes`,
  formNumber_79 AS `Aggregate_recycled_tonnes`,
  formNumber_8 AS `Quantity`,
  formNumber_80 AS `C&D_recycled_tonnes`,
  formNumber_81 AS `Concrete_recycled_tonnes`,
  formNumber_82 AS `Milled Asphalt recycled in tonnes (tonne)`,
  formNumber_83 AS `Excavated Natural Material (ENM)_recycled_tonnes`,
  formNumber_84 AS `Excavated Public Road Materials (EPRM)_recycled_tonnes`,
  formNumber_85 AS `Glass Waste_recycled_tonnes`,
  formNumber_86 AS `Liquid waste_recycled_kl`,
  formNumber_87 AS `Mulch_recycled_tonnes`,
  formNumber_88 AS `Non-ferrous metal_recycled_tonnes`,
  formNumber_89 AS `Timber waste_recycled_tonnes`,
  formNumber_9 AS `formNumber_9`,
  formNumber_90 AS `Vegetation (green waste)_recycled_tonnes`,
  formNumber_91 AS `VENM_recycled_tonnes`,
  formNumber_92 AS `E-waste_recycled_tonnes`,
  formNumber_93 AS `General waste_recycled_tonnes`,
  formNumber_94 AS `Paper and cardboard_recycled_tonnes`,
  formNumber_95 AS `Recycled asphalt (RAP) consumption in tonnes (tonne)`,
  formNumber_96 AS `Light fixture_generated_tonnes`,
  formNumber_97 AS `Light fixture_recycled_tonnes`,
  formNumber_98 AS `Additional Material Quantity`,
  formNumber_99 AS `Street sweepings_generated_tonnes`,
  formRadio_1 AS `Acid_sulfate_soils_recycled`,
  formRadio_10 AS `Mulch waste_recycled`,
  formRadio_11 AS `Ferrous metals_recycled`,
  formRadio_12 AS `Non-ferrous metals_recycled`,
  formRadio_13 AS `Timber waste_recycled`,
  formRadio_14 AS `Green waste_recycled`,
  formRadio_15 AS `VENM waste_recycled`,
  formRadio_16 AS `Aggregate Waste Type`,
  formRadio_17 AS `General waste_recycled`,
  formRadio_18 AS `Paper-and metals_recycled`,
  formRadio_19 AS `Light fixture_recycled`,
  formRadio_2 AS `Aggregate waste recycled`,
  formRadio_20 AS `Streetsweeper_recycled_tonnes`,
  formRadio_21 AS `Any recycled waste`,
  formRadio_22 AS `Waste Generation Applicability`,
  formRadio_23 AS `Consumption of_Consumption`,
  formRadio_24 AS `Fuel consumption applicability`,
  formRadio_3 AS `Milled asphalt_recycled`,
  formRadio_4 AS `Concrete_recycled`,
  formRadio_5 AS `C&D_recycled`,
  formRadio_6 AS `Excavated natural material waste_recycled`,
  formRadio_7 AS `EPRM waste was recycled/reused`,
  formRadio_8 AS `glass waste_recycled`,
  formRadio_9 AS `Liquid waste_recycled`,
  formText_1 AS `Other category of business`,
  formText_10 AS `Aspahlt supplier`,
  formText_11 AS `Aggregrate supplier`,
  formText_12 AS `Concrete supplier`,
  formText_13 AS `Glass Sand supplier`,
  formText_14 AS `Improved Design initaives to reduce material use`,
  formText_15 AS `Aggregate_ServiceProvider`,
  formText_16 AS `MilledAsphalt_ServiceProvider`,
  formText_17 AS `other material name`,
  formText_18 AS `Concrete_ServiceProvider`,
  formText_19 AS `C&D_waste_ServiceProvider`,
  formText_2 AS `Contractor Representative Name`,
  formText_20 AS `ENM_ServiceProvider`,
  formText_21 AS `EPRM_ServiceProvider`,
  formText_22 AS `Liquid waste_ServiceProvider`,
  formText_23 AS `Hazardous waste_ServiceProvider`,
  formText_24 AS `Mulch_ServiceProvider`,
  formText_25 AS `Ferrous/steel waste_ServiceProvider`,
  formText_26 AS `Non-ferrous metal_recycled`,
  formText_27 AS `Restricted waste_ServiceProvider`,
  formText_28 AS `Special waste_ServiceProvider`,
  formText_29 AS `VNM_ServiceProvider`,
  formText_3 AS `Name of Aboriginal vendor (sub subcontracted)`,
  formText_30 AS `E-waste_ServiceProvider`,
  formText_31 AS `Paper/cardboard waste_ServiceProvider`,
  formText_32 AS `Light Fixture_ServiceProvider`,
  formText_33 AS `General waste_ServiceProvider`,
  formText_34 AS `Green waste_ServiceProvider`,
  formText_35 AS `Timber_ServiceProvider`,
  formText_36 AS `glass waste_ServiceProvider`,
  formText_37 AS `Waste_ServiceProvider`,
  formText_38 AS `Additional Material Supplier name`,
  formText_39 AS `Name of special waste disposal facility`,
  formText_4 AS `Initatives to increase recycled material in asphalt mixes`,
  formText_40 AS `Licence (EPL) number for waste disposal facility`,
  formText_41 AS `Streetsweeper_ServiceProvider`,
  formText_42 AS `Initiatives to reduce materials consumed during construction`,
  formText_43 AS `Initatives to reutilise materials on site`,
  formText_44 AS `Climate related risk management considerations of projects`,
  formText_45 AS `formText_45`,
  formText_46 AS `Unit of Measurement (UoM) for other generator`,
  formText_47 AS `Other Work Type`,
  formText_48 AS `Project Name`,
  formText_49 AS `Type of generator`,
  formText_5 AS `Additional Material Name`,
  formText_6 AS `Feedback for improvement`,
  formText_7 AS `Other Material Supplier name`,
  formText_8 AS `other waste generated`,
  formText_9 AS `Description other C&D types`,
  Grease AS `Grease consumption`,
  Grease_Litres AS `Grease_Litres`,
  Lighting_towers AS `Lighting_towers`,
  LPG_Stationary AS `Stationary LPG consumption (kg)`,
  LPG_Stationary_Kg AS `LPG_Stationary_Kg`,
  LPG_transport AS `LPG_transport`,
  LPG_transport_Litres AS `LPG_transport_Litres`,
  Other_generator_fuel AS `Other_generator_fuel`,
  Period AS `Reporting period`,
  Petrol_stationary AS `Stationary Petrol Consumption (Litres)`,
  Petrol_stationary_Litres AS `Petrol_stationary_Litres`,
  Petrol_transport AS `Petrol_transport`,
  Petrol_transport_Litres AS `Petrol_transport_Litres`,
  Project_name AS `Project_name`,
  Project_names AS `Project_names`,
  --Project_percetntage AS `Project_percetntage`,
  --Project_type AS `Project_type`,
  Regular_oil_ AS `Stationaries Regular Oil consumption`,
  Regular_oil_1 AS `Regular_oil_staionary`,
  Regular_oil_Litres AS `Regular_oil_Litres`,
  Regular_oil_Stationary AS `Regular_oil_Stationary`,
  Stationary_consumption AS `Stationary Fuel Consumption`,
  Subcontractor AS `Subcontractor`,
  submittedFormID AS `Form ID`,
  Sustainabilityinitiatives AS `Sustainability_initiatives`--,
  --Updated AS `Updated`
FROM
  transport_dev.formitize_srapc.monthly_subcontractor_data_capture_portal
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `ABN` | `string` | Yes |  |
| `Acid_sulfate_soils` | `string` | Yes |  |
| `Acid_sulfate_soils_generated_tonnes` | `string` | Yes |  |
| `Acid_sulfate_soils_Provider` | `string` | Yes |  |
| `Asphalt Waste -  Milled Asphalt` | `string` | Yes |  |
| `Biodiesel_transport` | `string` | Yes |  |
| `Biodiesel_transport_Litres` | `string` | Yes |  |
| `Submission Date` | `string` | Yes |  |
| `Diesel consumption for electrical generators` | `string` | Yes |  |
| `Diesel_Generator_Litres` | `string` | Yes |  |
| `electrical generator fuel consumption` | `string` | Yes |  |
| `Diesel_Generator_Over_Litres` | `string` | Yes |  |
| `Stationary Diesel Consumption  (Litres)` | `string` | Yes |  |
| `Diesel_Stationary_Litres` | `string` | Yes |  |
| `Diesel Consumption` | `string` | Yes |  |
| `Diesel_Transport_Litres` | `string` | Yes |  |
| `E1_Transport` | `string` | Yes |  |
| `E10_Transport_Litres` | `string` | Yes |  |
| `Stationary E10 Consumption (Litres)` | `string` | Yes |  |
| `E10_Stationary_Litres` | `string` | Yes |  |
| `Electric Transport consumption` | `string` | Yes |  |
| `Electric_transport_1` | `string` | Yes |  |
| `Subcontractor email` | `string` | Yes |  |
| `Reported spend on Aboriginal employees` | `string` | Yes |  |
| `formButton_10` | `string` | Yes |  |
| `formButton_11` | `string` | Yes |  |
| `formButton_12` | `string` | Yes |  |
| `formButton_13` | `string` | Yes |  |
| `formButton_14` | `string` | Yes |  |
| `formButton_15` | `string` | Yes |  |
| `Aggregate Waste` | `string` | Yes |  |
| `formButton_17` | `string` | Yes |  |
| `Concrete Waste` | `string` | Yes |  |
| `Other construction and demolition (C&D) waste` | `string` | Yes |  |
| `Local Content Value` | `string` | Yes |  |
| `Excavated Natural Material (ENM) Waste` | `string` | Yes |  |
| `Excavated Public Road Materials (EPRM) Waste` | `string` | Yes |  |
| `Glass Waste` | `string` | Yes |  |
| `Liquid Waste` | `string` | Yes |  |
| `Hazardous Waste` | `string` | Yes |  |
| `Mulch Waste` | `string` | Yes |  |
| `Non-ferrous Metal Waste` | `string` | Yes |  |
| `Restricted Solid Waste` | `string` | Yes |  |
| `Special Waste (Asbestos)` | `string` | Yes |  |
| `Excavated Natural Material (ENM) Reused at TfNSW site` | `string` | Yes |  |
| `Timber Waste` | `string` | Yes |  |
| `Vegetation (Green Waste)` | `string` | Yes |  |
| `Virgin Excavated Natural Material (VENM)` | `string` | Yes |  |
| `Electronic Waste (E-waste)` | `string` | Yes |  |
| `General waste` | `string` | Yes |  |
| `Paper and Cardboard Waste` | `string` | Yes |  |
| `Other Waste Generated Type` | `string` | Yes |  |
| `Aggregate consumption` | `string` | Yes |  |
| `Concrete consumption` | `string` | Yes |  |
| `Ferrous Metals Waste - Steel` | `string` | Yes |  |
| `VENM_material used` | `string` | Yes |  |
| `other additional materials consumed` | `string` | Yes |  |
| `other materials consumed` | `string` | Yes |  |
| `Street sweepings waste` | `string` | Yes |  |
| `Recovered Glass Sand Consumption` | `string` | Yes |  |
| `Asphalt consumption` | `string` | Yes |  |
| `Potable water consumed from main` | `string` | Yes |  |
| `Non-potbale water consumed from main` | `string` | Yes |  |
| `Electricity consumed_SRAPC only` | `string` | Yes |  |
| `Excavated Public Road Materials (EPRM) Reused at TfNSW site` | `string` | Yes |  |
| `Engagement of Aboriginal-owned subcontractors` | `string` | Yes |  |
| `Amount $ relates to Aboriginal-owned subcontractors` | `string` | Yes |  |
| `Light Fixtures Waste` | `string` | Yes |  |
| `formButton_8` | `string` | Yes |  |
| `formButton_9` | `string` | Yes |  |
| `Integrity acknowledgement` | `string` | Yes |  |
| `Waste dockets_forwarded` | `string` | Yes |  |
| `Current claim $AUD` | `string` | Yes |  |
| `Month Claim Value` | `string` | Yes |  |
| `Aboriginal spend $AUD` | `string` | Yes |  |
| `Date of special waste removal from site` | `string` | Yes |  |
| `formDate_2` | `string` | Yes |  |
| `Date of special waste disposal at licensed facility` | `string` | Yes |  |
| `Aboriginal Employees in Claim / Invoice_trades` | `string` | Yes |  |
| `Total number of Trade Positions` | `string` | Yes |  |
| `Number of subcontractor employees` | `string` | Yes |  |
| `Type of Works` | `string` | Yes |  |
| `Additional Material Unit of measurement` | `string` | Yes |  |
| `Other Material Unit of measurement` | `string` | Yes |  |
| `Total number of Learning Workers` | `string` | Yes |  |
| `Aborignal owned` | `string` | Yes |  |
| `Aboriginal Employees in Claim / Invoice_non-trades` | `string` | Yes |  |
| `Total number of Trade Positions for Apprentices` | `string` | Yes |  |
| `Total number of Women in Trades Positions` | `string` | Yes |  |
| `Total number of Employees under 25 Years of Age` | `string` | Yes |  |
| `Category of business` | `string` | Yes |  |
| `formEmail_1` | `string` | Yes |  |
| `Number of Employees 20+` | `string` | Yes |  |
| `formNumber_10` | `string` | Yes |  |
| `Street sweepings recycled tonnes` | `string` | Yes |  |
| `Waste recycled (tonnes)` | `string` | Yes |  |
| `formNumber_11` | `string` | Yes |  |
| `Aggregate waste generated tonnes` | `string` | Yes |  |
| `formNumber_13` | `string` | Yes |  |
| `Numerical % of your claim_aboriginal` | `string` | Yes |  |
| `Spend amount $AUD_aboriginal` | `string` | Yes |  |
| `formNumber_17` | `string` | Yes |  |
| `formNumber_18` | `string` | Yes |  |
| `formNumber_19` | `string` | Yes |  |
| `Subcontractor number` | `string` | Yes |  |
| `formNumber_20` | `string` | Yes |  |
| `MilledAsphalt_generated_tonnes` | `string` | Yes |  |
| `C&D_generated_tonnes` | `string` | Yes |  |
| `Excavated Natural Material (ENM)_generated_tonnes` | `string` | Yes |  |
| `Excavated Public Road Materials (EPRM)_generated_tonnes` | `string` | Yes |  |
| `Glass generated_tonnes` | `string` | Yes |  |
| `Liquid waste_generated_kl` | `string` | Yes |  |
| `Hazardous waste_generated_tonnes` | `string` | Yes |  |
| `Mulch_generated_tonnes` | `string` | Yes |  |
| `Non-ferrous metal_generated_tonnes` | `string` | Yes |  |
| `Numerical %  claim (Aboriginal sub-subcontractors)` | `string` | Yes |  |
| `Aggregate_generated_tonnes` | `string` | Yes |  |
| `formNumber_31` | `string` | Yes |  |
| `formNumber_32` | `string` | Yes |  |
| `formNumber_33` | `string` | Yes |  |
| `formNumber_34` | `string` | Yes |  |
| `Restricted solid waste generated_tonnes` | `string` | Yes |  |
| `Special waste (Asbestos) generated_tonnes` | `string` | Yes |  |
| `Timber waste_generated_tonnes` | `string` | Yes |  |
| `Vegetation (green waste)_generated_tonnes` | `string` | Yes |  |
| `VENM generated tonnes` | `string` | Yes |  |
| `formNumber_4` | `string` | Yes |  |
| `E-waste generated generated tonnes` | `string` | Yes |  |
| `General waste generated_tonnes` | `string` | Yes |  |
| `Paper and cardboard_generated_tonnes` | `string` | Yes |  |
| `Other materials_generated_tonnes` | `string` | Yes |  |
| `Concrete_generated_tonnes` | `string` | Yes |  |
| `Aggregate waste recycled tonnes` | `string` | Yes |  |
| `Concrete consumption_tonnes` | `string` | Yes |  |
| `formNumber_47` | `string` | Yes |  |
| `Ferrous metal_generated_tonnes` | `string` | Yes |  |
| `Ferrous metal_recycled_tonnes` | `string` | Yes |  |
| `Diesel consumed_lighting equipment` | `string` | Yes |  |
| `formNumber_50` | `string` | Yes |  |
| `Asphalt consumption (tonne)` | `string` | Yes |  |
| `Water (Potable) kilolitres (kL)` | `string` | Yes |  |
| `Water (Not potable) kilolitres (kl)` | `string` | Yes |  |
| `Electricity consumption in Kilowatts hour (kWh)` | `string` | Yes |  |
| `formNumber_55` | `string` | Yes |  |
| `formNumber_56` | `string` | Yes |  |
| `Number of chain of responsibility heavy vehicle inspections conducted` | `string` | Yes |  |
| `Total number of Health and Safety Hazards reported` | `string` | Yes |  |
| `formNumber_59` | `string` | Yes |  |
| `Total worker on foot hours (wage hours on site) within total staff hours` | `string` | Yes |  |
| `Number of safety inspections undertaken` | `string` | Yes |  |
| `formNumber_61` | `string` | Yes |  |
| `Total staff hours (salary+hours) worked` | `string` | Yes |  |
| `formNumber_63` | `string` | Yes |  |
| `Number of Health and Safety regulatory vists` | `string` | Yes |  |
| `Recovered Glass Sand Consumption_tonnes` | `string` | Yes |  |
| `formNumber_71` | `string` | Yes |  |
| `formNumber_72` | `string` | Yes |  |
| `formNumber_73` | `string` | Yes |  |
| `formNumber_74` | `string` | Yes |  |
| `formNumber_75` | `string` | Yes |  |
| `formNumber_76` | `string` | Yes |  |
| `formNumber_77` | `string` | Yes |  |
| `Acid_sulfate_soils_recycled_tonnes` | `string` | Yes |  |
| `Aggregate_recycled_tonnes` | `string` | Yes |  |
| `Quantity` | `string` | Yes |  |
| `C&D_recycled_tonnes` | `string` | Yes |  |
| `Concrete_recycled_tonnes` | `string` | Yes |  |
| `Milled Asphalt recycled in tonnes (tonne)` | `string` | Yes |  |
| `Excavated Natural Material (ENM)_recycled_tonnes` | `string` | Yes |  |
| `Excavated Public Road Materials (EPRM)_recycled_tonnes` | `string` | Yes |  |
| `Glass Waste_recycled_tonnes` | `string` | Yes |  |
| `Liquid waste_recycled_kl` | `string` | Yes |  |
| `Mulch_recycled_tonnes` | `string` | Yes |  |
| `Non-ferrous metal_recycled_tonnes` | `string` | Yes |  |
| `Timber waste_recycled_tonnes` | `string` | Yes |  |
| `formNumber_9` | `string` | Yes |  |
| `Vegetation (green waste)_recycled_tonnes` | `string` | Yes |  |
| `VENM_recycled_tonnes` | `string` | Yes |  |
| `E-waste_recycled_tonnes` | `string` | Yes |  |
| `General waste_recycled_tonnes` | `string` | Yes |  |
| `Paper and cardboard_recycled_tonnes` | `string` | Yes |  |
| `Recycled asphalt (RAP) consumption in tonnes (tonne)` | `string` | Yes |  |
| `Light fixture_generated_tonnes` | `string` | Yes |  |
| `Light fixture_recycled_tonnes` | `string` | Yes |  |
| `Additional Material Quantity` | `string` | Yes |  |
| `Street sweepings_generated_tonnes` | `string` | Yes |  |
| `Acid_sulfate_soils_recycled` | `string` | Yes |  |
| `Mulch waste_recycled` | `string` | Yes |  |
| `Ferrous metals_recycled` | `string` | Yes |  |
| `Non-ferrous metals_recycled` | `string` | Yes |  |
| `Timber waste_recycled` | `string` | Yes |  |
| `Green waste_recycled` | `string` | Yes |  |
| `VENM waste_recycled` | `string` | Yes |  |
| `Aggregate Waste Type` | `string` | Yes |  |
| `General waste_recycled` | `string` | Yes |  |
| `Paper-and metals_recycled` | `string` | Yes |  |
| `Light fixture_recycled` | `string` | Yes |  |
| `Aggregate waste recycled` | `string` | Yes |  |
| `Streetsweeper_recycled_tonnes` | `string` | Yes |  |
| `Any recycled waste` | `string` | Yes |  |
| `Waste Generation Applicability` | `string` | Yes |  |
| `Consumption of_Consumption` | `string` | Yes |  |
| `Fuel consumption applicability` | `string` | Yes |  |
| `Milled asphalt_recycled` | `string` | Yes |  |
| `Concrete_recycled` | `string` | Yes |  |
| `C&D_recycled` | `string` | Yes |  |
| `Excavated natural material waste_recycled` | `string` | Yes |  |
| `EPRM waste was recycled/reused` | `string` | Yes |  |
| `glass waste_recycled` | `string` | Yes |  |
| `Liquid waste_recycled` | `string` | Yes |  |
| `Other category of business` | `string` | Yes |  |
| `Aspahlt supplier` | `string` | Yes |  |
| `Aggregrate supplier` | `string` | Yes |  |
| `Concrete supplier` | `string` | Yes |  |
| `Glass Sand supplier` | `string` | Yes |  |
| `Improved Design initaives to reduce material use` | `string` | Yes |  |
| `Aggregate_ServiceProvider` | `string` | Yes |  |
| `MilledAsphalt_ServiceProvider` | `string` | Yes |  |
| `other material name` | `string` | Yes |  |
| `Concrete_ServiceProvider` | `string` | Yes |  |
| `C&D_waste_ServiceProvider` | `string` | Yes |  |
| `Contractor Representative Name` | `string` | Yes |  |
| `ENM_ServiceProvider` | `string` | Yes |  |
| `EPRM_ServiceProvider` | `string` | Yes |  |
| `Liquid waste_ServiceProvider` | `string` | Yes |  |
| `Hazardous waste_ServiceProvider` | `string` | Yes |  |
| `Mulch_ServiceProvider` | `string` | Yes |  |
| `Ferrous/steel waste_ServiceProvider` | `string` | Yes |  |
| `Non-ferrous metal_recycled` | `string` | Yes |  |
| `Restricted waste_ServiceProvider` | `string` | Yes |  |
| `Special waste_ServiceProvider` | `string` | Yes |  |
| `VNM_ServiceProvider` | `string` | Yes |  |
| `Name of Aboriginal vendor (sub subcontracted)` | `string` | Yes |  |
| `E-waste_ServiceProvider` | `string` | Yes |  |
| `Paper/cardboard waste_ServiceProvider` | `string` | Yes |  |
| `Light Fixture_ServiceProvider` | `string` | Yes |  |
| `General waste_ServiceProvider` | `string` | Yes |  |
| `Green waste_ServiceProvider` | `string` | Yes |  |
| `Timber_ServiceProvider` | `string` | Yes |  |
| `glass waste_ServiceProvider` | `string` | Yes |  |
| `Waste_ServiceProvider` | `string` | Yes |  |
| `Additional Material Supplier name` | `string` | Yes |  |
| `Name of special waste disposal facility` | `string` | Yes |  |
| `Initatives to increase recycled material in asphalt mixes` | `string` | Yes |  |
| `Licence (EPL) number for waste disposal facility` | `string` | Yes |  |
| `Streetsweeper_ServiceProvider` | `string` | Yes |  |
| `Initiatives to reduce materials consumed during construction` | `string` | Yes |  |
| `Initatives to reutilise materials on site` | `string` | Yes |  |
| `Climate related risk management considerations of projects` | `string` | Yes |  |
| `formText_45` | `string` | Yes |  |
| `Unit of Measurement (UoM) for other generator` | `string` | Yes |  |
| `Other Work Type` | `string` | Yes |  |
| `Project Name` | `string` | Yes |  |
| `Type of generator` | `string` | Yes |  |
| `Additional Material Name` | `string` | Yes |  |
| `Feedback for improvement` | `string` | Yes |  |
| `Other Material Supplier name` | `string` | Yes |  |
| `other waste generated` | `string` | Yes |  |
| `Description other C&D types` | `string` | Yes |  |
| `Grease consumption` | `string` | Yes |  |
| `Grease_Litres` | `string` | Yes |  |
| `Lighting_towers` | `string` | Yes |  |
| `Stationary LPG consumption (kg)` | `string` | Yes |  |
| `LPG_Stationary_Kg` | `string` | Yes |  |
| `LPG_transport` | `string` | Yes |  |
| `LPG_transport_Litres` | `string` | Yes |  |
| `Other_generator_fuel` | `string` | Yes |  |
| `Reporting period` | `string` | Yes |  |
| `Stationary Petrol Consumption (Litres)` | `string` | Yes |  |
| `Petrol_stationary_Litres` | `string` | Yes |  |
| `Petrol_transport` | `string` | Yes |  |
| `Petrol_transport_Litres` | `string` | Yes |  |
| `Project_name` | `string` | Yes |  |
| `Project_names` | `string` | Yes |  |
| `Stationaries Regular Oil consumption` | `string` | Yes |  |
| `Regular_oil_staionary` | `string` | Yes |  |
| `Regular_oil_Litres` | `string` | Yes |  |
| `Regular_oil_Stationary` | `string` | Yes |  |
| `Stationary Fuel Consumption` | `string` | Yes |  |
| `Subcontractor` | `string` | Yes |  |
| `Form ID` | `int` | No |  |
| `Sustainability_initiatives` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_srapc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
