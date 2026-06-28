---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: uvw_pcas_all_attributes
full-name: transport_dev.transport_tsrc.uvw_pcas_all_attributes
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - uvw_pcas_all_attributes

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_pcas_all_attributes` |
| Full name | `transport_dev.transport_tsrc.uvw_pcas_all_attributes` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | VIEW |
| Column count | 103 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | capital works / forward works |
| Owner/SME | Helix_readwrite_transport_dev_transport_tsrc |
| Refresh/freshness | Created: 2024-09-06T01:23:56.64Z; Last altered: 2024-10-22T03:47:43.639Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(


    WITH pcas_vals AS(
        SELECT 
            parentassetcode,
            parentassetname,
            direction,
            Carriageway,
            assetname,
            `Start Chng`,
            `End Chng`,
            Chainage_Text,
            Lane,
            Lane_Type,
            `Surface Type`,
            `Speed Limit`,
            DnC_Defect,
            `Network Group`,
            `Survey Date`,
            `Survey Year`,
            Survey_Year_Text,
            Attribute_Name,
            Attribute_Value,
            Attribute_dtype,
            AV_Asset_ID,
            AV_Asset_Code,
            Static_1km_Start,
            Static_1km_End
        FROM transport_dev.transport_tsrc.uvw_pcas_numeric_data --- Update the table 
        WHERE Attribute_Name IN (
'Comment',
'Crack Sealing present',
'Crack treatment failed',
'Cracking present on site',
'Cracking Validation Comments',
'Crocodile Cracking (%)',
'D&C Control or Defect',
'Def_N0',
'Def_N1500',
'Def_N200',
'Def_N900',
'Deflection Air Temperature (Celsius)',
'Deflection Surface Temperature (Celsius)',
'dTIMS Model Treatment',
'dTIMS Treatment Year',
'Geometric Feature',
'Geometric Feature - Description',
'Historical Works - Comments',
'Historical Works Present',
'Left Shoulder Width (m)',
'Length (m)',
'Longitudinal Cracking - LPPC Result',
'Longitudinal Cracking (m)',
'Overall Treatment',
'Overall Treatment - Comment',
'Pavement Type - Intermediate Layers',
'Pavement Type Code',
'PCAS Defect',
'PCAS Survey Date',
'Ravelling - LPPC Result',
'Ravelling (%)',
'Ravelling present on site',
'Ravelling Validation Comments',
'Remaining Life - Alternate',
'Remaining Life - Confirming',
'Remaining Life - Conforming',
'Remaining Life - LPPC Result',
'Right Shoulder Width (m)',
'Roughness - LPPC Result',
'Roughness (NAASRA/km)',
'Roughness present on site',
'Roughness Validation Comments',
'Route ID',
'Rutting (Driver) 80th Percentile (mm)',
'Rutting (Passenger) 80th Percentile (mm)',
'Rutting Driver - LPPC Result',
'Rutting Passenger - LPPC Result',
'Rutting present on site',
'Rutting Validation Comments',
'SFC - LPPC Result',
'SFC (Driver)',
'SFC (Passenger)',
'Site Feature - Comment',
'Site Feature Affecting Condition',
'SNC',
'Surfacing Material Type',
'Testing Required Post Validation',
'Texture - LPPC Result',
'Texture (Center) (SPTD) (mm)',
'Texture (Driver) (SPTD) (mm)',
'Texture (Passenger) (SPTD) (mm)',
'Texture or Skid present on site',
'Texture or Skid Validation Comments',
'Total Cracking - LPPC Result',
'Total Cracking (%)',
'Wearing Surface Thickness (mm)',
'WS1 Aggregate Size (mm)',
'WS1 Aggregate Spread Rate (m2/m3)',
'WS1 Binder Application Rate (L/m2)',
'WS1 Binder Type',
'WS1 Type',
'WS2 Aggregate Size (mm)',
'WS2 Aggregate Spread Rate (m2/m3)',
'WS2 Binder Application Rate (L/m2)',
'WS2 Binder Type',
'WS2 Type',
'WS3 Aggregate Size (mm)',
'WS3 Aggregate Spread Rate (m2/m3)',
'WS3 Binder Application Rate (L/m2)',
'WS3 Binder Type',
'WS3 Type')
        )

        SELECT
            *
        FROM pcas_vals PIVOT (
            AVG(Attribute_Value)
            --- Pivots out new columns code reads as where value in pivotcol_name is X then name it AS Y
            --- e.g. where value in pivotcol_name is 'Chainage Start' pivot out into a column called `Start Chng`
            FOR Attribute_Name IN (
'Comment' as `Comment`,
'Crack Sealing present' as `Crack Sealing present`,
'Crack treatment failed' as `Crack treatment failed`,
'Cracking present on site' as `Cracking present on site`,
'Cracking Validation Comments' as `Cracking Validation Comments`,
'Crocodile Cracking (%)' as `Crocodile Cracking (%)`,
'D&C Control or Defect' as `D&C Control or Defect`,
'Def_N0' as `Def_N0`,
'Def_N1500' as `Def_N1500`,
'Def_N200' as `Def_N200`,
'Def_N900' as `Def_N900`,
'Deflection Air Temperature (Celsius)' as `Deflection Air Temperature (Celsius)`,
'Deflection Surface Temperature (Celsius)' as `Deflection Surface Temperature (Celsius)`,
'dTIMS Model Treatment' as `dTIMS Model Treatment`,
'dTIMS Treatment Year' as `dTIMS Treatment Year`,
'Geometric Feature' as `Geometric Feature`,
'Geometric Feature - Description' as `Geometric Feature - Description`,
'Historical Works - Comments' as `Historical Works - Comments`,
'Historical Works Present' as `Historical Works Present`,
'Left Shoulder Width (m)' as `Left Shoulder Width (m)`,
'Length (m)' as `Length (m)`,
'Longitudinal Cracking - LPPC Result' as `Longitudinal Cracking - LPPC Result`,
'Longitudinal Cracking (m)' as `Longitudinal Cracking (m)`,
'Overall Treatment' as `Overall Treatment`,
'Overall Treatment - Comment' as `Overall Treatment - Comment`,
'Pavement Type - Intermediate Layers' as `Pavement Type - Intermediate Layers`,
'Pavement Type Code' as `Pavement Type Code`,
'PCAS Defect' as `PCAS Defect`,
'PCAS Survey Date' as `PCAS Survey Date`,
'Ravelling - LPPC Result' as `Ravelling - LPPC Result`,
'Ravelling (%)' as `Ravelling (%)`,
'Ravelling present on site' as `Ravelling present on site`,
'Ravelling Validation Comments' as `Ravelling Validation Comments`,
'Remaining Life - Alternate' as `Remaining Life - Alternate`,
'Remaining Life - Confirming' as `Remaining Life - Confirming`,
'Remaining Life - Conforming' as `Remaining Life - Conforming`,
'Remaining Life - LPPC Result' as `Remaining Life - LPPC Result`,
'Right Shoulder Width (m)' as `Right Shoulder Width (m)`,
'Roughness - LPPC Result' as `Roughness - LPPC Result`,
'Roughness (NAASRA/km)' as `Roughness (NAASRA/km)`,
'Roughness present on site' as `Roughness present on site`,
'Roughness Validation Comments' as `Roughness Validation Comments`,
'Route ID' as `Route ID`,
'Rutting (Driver) 80th Percentile (mm)' as `Rutting (Driver) 80th Percentile (mm)`,
'Rutting (Passenger) 80th Percentile (mm)' as `Rutting (Passenger) 80th Percentile (mm)`,
'Rutting Driver - LPPC Result' as `Rutting Driver - LPPC Result`,
'Rutting Passenger - LPPC Result' as `Rutting Passenger - LPPC Result`,
'Rutting present on site' as `Rutting present on site`,
'Rutting Validation Comments' as `Rutting Validation Comments`,
'SFC - LPPC Result' as `SFC - LPPC Result`,
'SFC (Driver)' as `SFC (Driver)`,
'SFC (Passenger)' as `SFC (Passenger)`,
'Site Feature - Comment' as `Site Feature - Comment`,
'Site Feature Affecting Condition' as `Site Feature Affecting Condition`,
'SNC' as `SNC`,
'Surfacing Material Type' as `Surfacing Material Type`,
'Testing Required Post Validation' as `Testing Required Post Validation`,
'Texture - LPPC Result' as `Texture - LPPC Result`,
'Texture (Center) (SPTD) (mm)' as `Texture (Center) (SPTD) (mm)`,
'Texture (Driver) (SPTD) (mm)' as `Texture (Driver) (SPTD) (mm)`,
'Texture (Passenger) (SPTD) (mm)' as `Texture (Passenger) (SPTD) (mm)`,
'Texture or Skid present on site' as `Texture or Skid present on site`,
'Texture or Skid Validation Comments' as `Texture or Skid Validation Comments`,
'Total Cracking - LPPC Result' as `Total Cracking - LPPC Result`,
'Total Cracking (%)' as `Total Cracking (%)`,
'Wearing Surface Thickness (mm)' as `Wearing Surface Thickness (mm)`,
'WS1 Aggregate Size (mm)' as `WS1 Aggregate Size (mm)`,
'WS1 Aggregate Spread Rate (m2/m3)' as `WS1 Aggregate Spread Rate (m2/m3)`,
'WS1 Binder Application Rate (L/m2)' as `WS1 Binder Application Rate (L/m2)`,
'WS1 Binder Type' as `WS1 Binder Type`,
'WS1 Type' as `WS1 Type`,
'WS2 Aggregate Size (mm)' as `WS2 Aggregate Size (mm)`,
'WS2 Aggregate Spread Rate (m2/m3)' as `WS2 Aggregate Spread Rate (m2/m3)`,
'WS2 Binder Application Rate (L/m2)' as `WS2 Binder Application Rate (L/m2)`,
'WS2 Binder Type' as `WS2 Binder Type`,
'WS2 Type' as `WS2 Type`,
'WS3 Aggregate Size (mm)' as `WS3 Aggregate Size (mm)`,
'WS3 Aggregate Spread Rate (m2/m3)' as `WS3 Aggregate Spread Rate (m2/m3)`,
'WS3 Binder Application Rate (L/m2)' as `WS3 Binder Application Rate (L/m2)`,
'WS3 Binder Type' as `WS3 Binder Type`,
'WS3 Type' as `WS3 Type`)
            )
            
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `parentassetcode` | `string` | Yes |  |
| `parentassetname` | `string` | Yes |  |
| `direction` | `string` | Yes |  |
| `Carriageway` | `string` | No |  |
| `assetname` | `string` | Yes |  |
| `Start Chng` | `int` | Yes |  |
| `End Chng` | `int` | Yes |  |
| `Chainage_Text` | `string` | Yes |  |
| `Lane` | `string` | Yes |  |
| `Lane_Type` | `string` | No |  |
| `Surface Type` | `string` | Yes |  |
| `Speed Limit` | `string` | Yes |  |
| `DnC_Defect` | `string` | Yes |  |
| `Network Group` | `string` | Yes |  |
| `Survey Date` | `string` | Yes |  |
| `Survey Year` | `int` | Yes |  |
| `Survey_Year_Text` | `string` | Yes |  |
| `Attribute_dtype` | `string` | Yes |  |
| `AV_Asset_ID` | `int` | Yes |  |
| `AV_Asset_Code` | `string` | Yes |  |
| `Static_1km_Start` | `decimal(11,0)` | Yes |  |
| `Static_1km_End` | `decimal(11,0)` | Yes |  |
| `Comment` | `double` | Yes |  |
| `Crack Sealing present` | `double` | Yes |  |
| `Crack treatment failed` | `double` | Yes |  |
| `Cracking present on site` | `double` | Yes |  |
| `Cracking Validation Comments` | `double` | Yes |  |
| `Crocodile Cracking (%)` | `double` | Yes |  |
| `D&C Control or Defect` | `double` | Yes |  |
| `Def_N0` | `double` | Yes |  |
| `Def_N1500` | `double` | Yes |  |
| `Def_N200` | `double` | Yes |  |
| `Def_N900` | `double` | Yes |  |
| `Deflection Air Temperature (Celsius)` | `double` | Yes |  |
| `Deflection Surface Temperature (Celsius)` | `double` | Yes |  |
| `dTIMS Model Treatment` | `double` | Yes |  |
| `dTIMS Treatment Year` | `double` | Yes |  |
| `Geometric Feature` | `double` | Yes |  |
| `Geometric Feature - Description` | `double` | Yes |  |
| `Historical Works - Comments` | `double` | Yes |  |
| `Historical Works Present` | `double` | Yes |  |
| `Left Shoulder Width (m)` | `double` | Yes |  |
| `Length (m)` | `double` | Yes |  |
| `Longitudinal Cracking - LPPC Result` | `double` | Yes |  |
| `Longitudinal Cracking (m)` | `double` | Yes |  |
| `Overall Treatment` | `double` | Yes |  |
| `Overall Treatment - Comment` | `double` | Yes |  |
| `Pavement Type - Intermediate Layers` | `double` | Yes |  |
| `Pavement Type Code` | `double` | Yes |  |
| `PCAS Defect` | `double` | Yes |  |
| `PCAS Survey Date` | `double` | Yes |  |
| `Ravelling - LPPC Result` | `double` | Yes |  |
| `Ravelling (%)` | `double` | Yes |  |
| `Ravelling present on site` | `double` | Yes |  |
| `Ravelling Validation Comments` | `double` | Yes |  |
| `Remaining Life - Alternate` | `double` | Yes |  |
| `Remaining Life - Confirming` | `double` | Yes |  |
| `Remaining Life - Conforming` | `double` | Yes |  |
| `Remaining Life - LPPC Result` | `double` | Yes |  |
| `Right Shoulder Width (m)` | `double` | Yes |  |
| `Roughness - LPPC Result` | `double` | Yes |  |
| `Roughness (NAASRA/km)` | `double` | Yes |  |
| `Roughness present on site` | `double` | Yes |  |
| `Roughness Validation Comments` | `double` | Yes |  |
| `Route ID` | `double` | Yes |  |
| `Rutting (Driver) 80th Percentile (mm)` | `double` | Yes |  |
| `Rutting (Passenger) 80th Percentile (mm)` | `double` | Yes |  |
| `Rutting Driver - LPPC Result` | `double` | Yes |  |
| `Rutting Passenger - LPPC Result` | `double` | Yes |  |
| `Rutting present on site` | `double` | Yes |  |
| `Rutting Validation Comments` | `double` | Yes |  |
| `SFC - LPPC Result` | `double` | Yes |  |
| `SFC (Driver)` | `double` | Yes |  |
| `SFC (Passenger)` | `double` | Yes |  |
| `Site Feature - Comment` | `double` | Yes |  |
| `Site Feature Affecting Condition` | `double` | Yes |  |
| `SNC` | `double` | Yes |  |
| `Surfacing Material Type` | `double` | Yes |  |
| `Testing Required Post Validation` | `double` | Yes |  |
| `Texture - LPPC Result` | `double` | Yes |  |
| `Texture (Center) (SPTD) (mm)` | `double` | Yes |  |
| `Texture (Driver) (SPTD) (mm)` | `double` | Yes |  |
| `Texture (Passenger) (SPTD) (mm)` | `double` | Yes |  |
| `Texture or Skid present on site` | `double` | Yes |  |
| `Texture or Skid Validation Comments` | `double` | Yes |  |
| `Total Cracking - LPPC Result` | `double` | Yes |  |
| `Total Cracking (%)` | `double` | Yes |  |
| `Wearing Surface Thickness (mm)` | `double` | Yes |  |
| `WS1 Aggregate Size (mm)` | `double` | Yes |  |
| `WS1 Aggregate Spread Rate (m2/m3)` | `double` | Yes |  |
| `WS1 Binder Application Rate (L/m2)` | `double` | Yes |  |
| `WS1 Binder Type` | `double` | Yes |  |
| `WS1 Type` | `double` | Yes |  |
| `WS2 Aggregate Size (mm)` | `double` | Yes |  |
| `WS2 Aggregate Spread Rate (m2/m3)` | `double` | Yes |  |
| `WS2 Binder Application Rate (L/m2)` | `double` | Yes |  |
| `WS2 Binder Type` | `double` | Yes |  |
| `WS2 Type` | `double` | Yes |  |
| `WS3 Aggregate Size (mm)` | `double` | Yes |  |
| `WS3 Aggregate Spread Rate (m2/m3)` | `double` | Yes |  |
| `WS3 Binder Application Rate (L/m2)` | `double` | Yes |  |
| `WS3 Binder Type` | `double` | Yes |  |
| `WS3 Type` | `double` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
