---
type: data-table
topic: Ventia
sector: Transport
contract-schema: formitize_srapc
table-name: srapc_monthly_subcontractor_data_capture_portal
full-name: transport_dev.formitize_srapc.srapc_monthly_subcontractor_data_capture_portal
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, formitize-srapc]
---

# Transport Table - formitize_srapc - srapc_monthly_subcontractor_data_capture_portal

## Identity

| Field | Value |
|---|---|
| Table name | `srapc_monthly_subcontractor_data_capture_portal` |
| Full name | `transport_dev.formitize_srapc.srapc_monthly_subcontractor_data_capture_portal` |
| Catalog | `transport_dev` |
| Schema | `formitize_srapc` |
| Contract/schema | `formitize_srapc` |
| Table type | MANAGED |
| Column count | 291 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | bd8c9950-d6b9-496b-95eb-be4d7211e1e9 |
| Refresh/freshness | Created: 2025-03-20T07:18:10.616Z; Last altered: 2026-06-09T05:40:05.082Z |
| Source details | Data source format: DELTA |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `submittedFormID` | `int` | No |  |
| `formID` | `int` | Yes |  |
| `version` | `int` | Yes |  |
| `ABN` | `string` | Yes |  |
| `Acid_sulfate_soils` | `string` | Yes |  |
| `Acid_sulfate_soils_Provider` | `string` | Yes |  |
| `Acid_sulfate_soils_generated_tonnes` | `string` | Yes |  |
| `AsphaltWasteMilledAsphalt` | `string` | Yes |  |
| `Biodiesel_transport` | `string` | Yes |  |
| `Biodiesel_transport_Litres` | `string` | Yes |  |
| `Date` | `string` | Yes |  |
| `Diesel_Generator` | `string` | Yes |  |
| `Diesel_Generator_Litres` | `string` | Yes |  |
| `Diesel_Generator_Over` | `string` | Yes |  |
| `Diesel_Generator_Over_Litres` | `string` | Yes |  |
| `Diesel_Transport_Litres` | `string` | Yes |  |
| `Diesel_transport` | `string` | Yes |  |
| `E1_Transport` | `string` | Yes |  |
| `E1_Transport_Litres` | `string` | Yes |  |
| `Electric_transport` | `string` | Yes |  |
| `Electric_transport_1` | `string` | Yes |  |
| `Grease` | `string` | Yes |  |
| `Grease_Litres` | `string` | Yes |  |
| `LPG_transport` | `string` | Yes |  |
| `LPG_transport_Litres` | `string` | Yes |  |
| `Lighting_towers` | `string` | Yes |  |
| `NotPotableWater_description_1` | `string` | Yes |  |
| `Othe_generator` | `string` | Yes |  |
| `Other_generator_fuel` | `string` | Yes |  |
| `Period` | `string` | Yes |  |
| `Petrol_transport` | `string` | Yes |  |
| `Petrol_transport_Litres` | `string` | Yes |  |
| `PotableWater_description` | `string` | Yes |  |
| `Regular_oil_` | `string` | Yes |  |
| `Regular_oil_1` | `string` | Yes |  |
| `Regular_oil_Litres` | `string` | Yes |  |
| `Regular_oil_Stationary` | `string` | Yes |  |
| `Stationary_consumption` | `string` | Yes |  |
| `Subcontractor` | `string` | Yes |  |
| `Sustainabilityinitiatives` | `string` | Yes |  |
| `email` | `string` | Yes |  |
| `formButton_1` | `string` | Yes |  |
| `formButton_10` | `string` | Yes |  |
| `formButton_11` | `string` | Yes |  |
| `formButton_12` | `string` | Yes |  |
| `formButton_13` | `string` | Yes |  |
| `formButton_14` | `string` | Yes |  |
| `formButton_15` | `string` | Yes |  |
| `formButton_16` | `string` | Yes |  |
| `formButton_17` | `string` | Yes |  |
| `formButton_18` | `string` | Yes |  |
| `formButton_19` | `string` | Yes |  |
| `formButton_2` | `string` | Yes |  |
| `formButton_20` | `string` | Yes |  |
| `formButton_21` | `string` | Yes |  |
| `formButton_22` | `string` | Yes |  |
| `formButton_23` | `string` | Yes |  |
| `formButton_24` | `string` | Yes |  |
| `formButton_25` | `string` | Yes |  |
| `formButton_26` | `string` | Yes |  |
| `formButton_28` | `string` | Yes |  |
| `formButton_29` | `string` | Yes |  |
| `formButton_3` | `string` | Yes |  |
| `formButton_30` | `string` | Yes |  |
| `formButton_31` | `string` | Yes |  |
| `formButton_32` | `string` | Yes |  |
| `formButton_33` | `string` | Yes |  |
| `formButton_34` | `string` | Yes |  |
| `formButton_35` | `string` | Yes |  |
| `formButton_36` | `string` | Yes |  |
| `formButton_37` | `string` | Yes |  |
| `formButton_38` | `string` | Yes |  |
| `formButton_39` | `string` | Yes |  |
| `formButton_4` | `string` | Yes |  |
| `formButton_40` | `string` | Yes |  |
| `formButton_41` | `string` | Yes |  |
| `formButton_42` | `string` | Yes |  |
| `formButton_44` | `string` | Yes |  |
| `formButton_45` | `string` | Yes |  |
| `formButton_46` | `string` | Yes |  |
| `formButton_47` | `string` | Yes |  |
| `formButton_48` | `string` | Yes |  |
| `formButton_5` | `string` | Yes |  |
| `formButton_6` | `string` | Yes |  |
| `formButton_7` | `string` | Yes |  |
| `formButton_70` | `string` | Yes |  |
| `formButton_8` | `string` | Yes |  |
| `formButton_9` | `string` | Yes |  |
| `formCheckbox_1` | `string` | Yes |  |
| `formCheckbox_5` | `string` | Yes |  |
| `formCurrency_1` | `string` | Yes |  |
| `formCurrency_2` | `string` | Yes |  |
| `formCurrency_3` | `string` | Yes |  |
| `formDate_1` | `string` | Yes |  |
| `formDate_2` | `string` | Yes |  |
| `formDate_3` | `string` | Yes |  |
| `formDropdown_1` | `string` | Yes |  |
| `formDropdown_10` | `string` | Yes |  |
| `formDropdown_11` | `string` | Yes |  |
| `formDropdown_12` | `string` | Yes |  |
| `formDropdown_2` | `string` | Yes |  |
| `formDropdown_26` | `string` | Yes |  |
| `formDropdown_3` | `string` | Yes |  |
| `formDropdown_4` | `string` | Yes |  |
| `formDropdown_5` | `string` | Yes |  |
| `formDropdown_6` | `string` | Yes |  |
| `formDropdown_7` | `string` | Yes |  |
| `formDropdown_8` | `string` | Yes |  |
| `formDropdown_9` | `string` | Yes |  |
| `formEmail_1` | `string` | Yes |  |
| `formNumber_1` | `string` | Yes |  |
| `formNumber_10` | `string` | Yes |  |
| `formNumber_100` | `string` | Yes |  |
| `formNumber_101` | `string` | Yes |  |
| `formNumber_11` | `string` | Yes |  |
| `formNumber_12` | `string` | Yes |  |
| `formNumber_13` | `string` | Yes |  |
| `formNumber_14` | `string` | Yes |  |
| `formNumber_15` | `string` | Yes |  |
| `formNumber_17` | `string` | Yes |  |
| `formNumber_18` | `string` | Yes |  |
| `formNumber_19` | `string` | Yes |  |
| `formNumber_2` | `string` | Yes |  |
| `formNumber_20` | `string` | Yes |  |
| `formNumber_21` | `string` | Yes |  |
| `formNumber_22` | `string` | Yes |  |
| `formNumber_23` | `string` | Yes |  |
| `formNumber_24` | `string` | Yes |  |
| `formNumber_25` | `string` | Yes |  |
| `formNumber_26` | `string` | Yes |  |
| `formNumber_27` | `string` | Yes |  |
| `formNumber_28` | `string` | Yes |  |
| `formNumber_29` | `string` | Yes |  |
| `formNumber_3` | `string` | Yes |  |
| `formNumber_30` | `string` | Yes |  |
| `formNumber_31` | `string` | Yes |  |
| `formNumber_32` | `string` | Yes |  |
| `formNumber_33` | `string` | Yes |  |
| `formNumber_34` | `string` | Yes |  |
| `formNumber_35` | `string` | Yes |  |
| `formNumber_36` | `string` | Yes |  |
| `formNumber_37` | `string` | Yes |  |
| `formNumber_38` | `string` | Yes |  |
| `formNumber_39` | `string` | Yes |  |
| `formNumber_4` | `string` | Yes |  |
| `formNumber_40` | `string` | Yes |  |
| `formNumber_41` | `string` | Yes |  |
| `formNumber_42` | `string` | Yes |  |
| `formNumber_43` | `string` | Yes |  |
| `formNumber_44` | `string` | Yes |  |
| `formNumber_45` | `string` | Yes |  |
| `formNumber_46` | `string` | Yes |  |
| `formNumber_47` | `string` | Yes |  |
| `formNumber_48` | `string` | Yes |  |
| `formNumber_49` | `string` | Yes |  |
| `formNumber_5` | `string` | Yes |  |
| `formNumber_50` | `string` | Yes |  |
| `formNumber_51` | `string` | Yes |  |
| `formNumber_52` | `string` | Yes |  |
| `formNumber_53` | `string` | Yes |  |
| `formNumber_54` | `string` | Yes |  |
| `formNumber_55` | `string` | Yes |  |
| `formNumber_56` | `string` | Yes |  |
| `formNumber_57` | `string` | Yes |  |
| `formNumber_58` | `string` | Yes |  |
| `formNumber_59` | `string` | Yes |  |
| `formNumber_6` | `string` | Yes |  |
| `formNumber_60` | `string` | Yes |  |
| `formNumber_61` | `string` | Yes |  |
| `formNumber_62` | `string` | Yes |  |
| `formNumber_63` | `string` | Yes |  |
| `formNumber_64` | `string` | Yes |  |
| `formNumber_7` | `string` | Yes |  |
| `formNumber_71` | `string` | Yes |  |
| `formNumber_72` | `string` | Yes |  |
| `formNumber_73` | `string` | Yes |  |
| `formNumber_74` | `string` | Yes |  |
| `formNumber_75` | `string` | Yes |  |
| `formNumber_76` | `string` | Yes |  |
| `formNumber_77` | `string` | Yes |  |
| `formNumber_78` | `string` | Yes |  |
| `formNumber_79` | `string` | Yes |  |
| `formNumber_8` | `string` | Yes |  |
| `formNumber_80` | `string` | Yes |  |
| `formNumber_81` | `string` | Yes |  |
| `formNumber_82` | `string` | Yes |  |
| `formNumber_83` | `string` | Yes |  |
| `formNumber_84` | `string` | Yes |  |
| `formNumber_85` | `string` | Yes |  |
| `formNumber_86` | `string` | Yes |  |
| `formNumber_87` | `string` | Yes |  |
| `formNumber_88` | `string` | Yes |  |
| `formNumber_89` | `string` | Yes |  |
| `formNumber_9` | `string` | Yes |  |
| `formNumber_90` | `string` | Yes |  |
| `formNumber_91` | `string` | Yes |  |
| `formNumber_92` | `string` | Yes |  |
| `formNumber_93` | `string` | Yes |  |
| `formNumber_94` | `string` | Yes |  |
| `formNumber_95` | `string` | Yes |  |
| `formNumber_96` | `string` | Yes |  |
| `formNumber_97` | `string` | Yes |  |
| `formNumber_98` | `string` | Yes |  |
| `formNumber_99` | `string` | Yes |  |
| `formRadio_10` | `string` | Yes |  |
| `formRadio_11` | `string` | Yes |  |
| `formRadio_12` | `string` | Yes |  |
| `formRadio_13` | `string` | Yes |  |
| `formRadio_14` | `string` | Yes |  |
| `formRadio_15` | `string` | Yes |  |
| `formRadio_17` | `string` | Yes |  |
| `formRadio_18` | `string` | Yes |  |
| `formRadio_2` | `string` | Yes |  |
| `formRadio_20` | `string` | Yes |  |
| `formRadio_21` | `string` | Yes |  |
| `formRadio_22` | `string` | Yes |  |
| `formRadio_23` | `string` | Yes |  |
| `formRadio_24` | `string` | Yes |  |
| `formRadio_3` | `string` | Yes |  |
| `formRadio_4` | `string` | Yes |  |
| `formRadio_5` | `string` | Yes |  |
| `formRadio_6` | `string` | Yes |  |
| `formRadio_7` | `string` | Yes |  |
| `formRadio_8` | `string` | Yes |  |
| `formRadio_9` | `string` | Yes |  |
| `formText_1` | `string` | Yes |  |
| `formText_10` | `string` | Yes |  |
| `formText_11` | `string` | Yes |  |
| `formText_12` | `string` | Yes |  |
| `formText_13` | `string` | Yes |  |
| `formText_14` | `string` | Yes |  |
| `formText_15` | `string` | Yes |  |
| `formText_16` | `string` | Yes |  |
| `formText_17` | `string` | Yes |  |
| `formText_18` | `string` | Yes |  |
| `formText_19` | `string` | Yes |  |
| `formText_2` | `string` | Yes |  |
| `formText_20` | `string` | Yes |  |
| `formText_21` | `string` | Yes |  |
| `formText_22` | `string` | Yes |  |
| `formText_23` | `string` | Yes |  |
| `formText_24` | `string` | Yes |  |
| `formText_25` | `string` | Yes |  |
| `formText_26` | `string` | Yes |  |
| `formText_27` | `string` | Yes |  |
| `formText_28` | `string` | Yes |  |
| `formText_29` | `string` | Yes |  |
| `formText_3` | `string` | Yes |  |
| `formText_30` | `string` | Yes |  |
| `formText_31` | `string` | Yes |  |
| `formText_32` | `string` | Yes |  |
| `formText_33` | `string` | Yes |  |
| `formText_34` | `string` | Yes |  |
| `formText_35` | `string` | Yes |  |
| `formText_36` | `string` | Yes |  |
| `formText_37` | `string` | Yes |  |
| `formText_38` | `string` | Yes |  |
| `formText_39` | `string` | Yes |  |
| `formText_4` | `string` | Yes |  |
| `formText_40` | `string` | Yes |  |
| `formText_41` | `string` | Yes |  |
| `formText_42` | `string` | Yes |  |
| `formText_43` | `string` | Yes |  |
| `formText_44` | `string` | Yes |  |
| `formText_46` | `string` | Yes |  |
| `formText_47` | `string` | Yes |  |
| `formText_48` | `string` | Yes |  |
| `formText_49` | `string` | Yes |  |
| `formText_5` | `string` | Yes |  |
| `formText_6` | `string` | Yes |  |
| `formText_7` | `string` | Yes |  |
| `formText_8` | `string` | Yes |  |
| `formText_9` | `string` | Yes |  |
| `row_updated_exec_id` | `string` | Yes |  |
| `row_updated_timestamp` | `string` | Yes |  |
| `Diesel_Stationary` | `string` | Yes |  |
| `Diesel_Stationary_Litres` | `string` | Yes |  |
| `E10_Stationary` | `string` | Yes |  |
| `E10_Stationary_Litres` | `string` | Yes |  |
| `LPG_Stationary` | `string` | Yes |  |
| `LPG_Stationary_Kg` | `string` | Yes |  |
| `Petrol_stationary` | `string` | Yes |  |
| `Petrol_stationary_Litres` | `string` | Yes |  |
| `Project_name` | `string` | Yes |  |
| `Project_names` | `string` | Yes |  |
| `formRadio_16` | `string` | Yes |  |
| `formRadio_19` | `string` | Yes |  |
| `formText_45` | `string` | Yes |  |
| `formRadio_1` | `string` | Yes |  |
| `Aboriginal_spendon_subcontractors` | `string` | Yes |  |
| `Aboriginal_employee` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - formitize_srapc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
