---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: uvw_pcas_numeric_data_pivotted
full-name: transport_dev.transport_tsrc.uvw_pcas_numeric_data_pivotted
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - uvw_pcas_numeric_data_pivotted

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_pcas_numeric_data_pivotted` |
| Full name | `transport_dev.transport_tsrc.uvw_pcas_numeric_data_pivotted` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | VIEW |
| Column count | 41 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | capital works / forward works |
| Owner/SME | hui.chen@ventia.com |
| Refresh/freshness | Created: 2024-07-23T23:38:30.453Z; Last altered: 2024-07-31T23:24:51.543Z |
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
            Static_1km_End,
            Defect_100m,
            Defect_100m_exclRemLife,
            LPPC_Defect_Static,
            LPPC_Defect_Static_exclRemLife,
            LPPC_Defect_Rolling,
            LPPC_Defect_Rolling_exclRemLife
        FROM transport_dev.transport_tsrc.uvw_pcas_numeric_data --- Update the table 
        WHERE Attribute_Name IN ('Longitudinal Cracking (m)','Ravelling (%)','Remaining Life - Alternate', 'Remaining Life - Conforming','Roughness (NAASRA/km)',
                                'Rutting (Driver) 80th Percentile (mm)','Rutting (Passenger) 80th Percentile (mm)','Total Cracking (%)','Longitudinal Cracking (m)',
                                'Texture (Center) (SPTD) (mm)', 'Texture (Driver) (SPTD) (mm)', 'Texture (Passenger) (SPTD) (mm)',
                                'SFC (Driver)','SFC (Passenger)')
        )

        SELECT
            *
        FROM pcas_vals PIVOT (
            AVG(Attribute_Value)
            --- Pivots out new columns code reads as where value in pivotcol_name is X then name it AS Y
            --- e.g. where value in pivotcol_name is 'Chainage Start' pivot out into a column called `Start Chng`
            FOR Attribute_Name IN ('Roughness (NAASRA/km)' AS `Roughness (NAASRA/km)`,
                                   'Rutting (Driver) 80th Percentile (mm)' AS `Rutting (Driver) 80th Percentile (mm)`,
                                   'Rutting (Passenger) 80th Percentile (mm)' AS `Rutting (Passenger) 80th Percentile (mm)`,
                                   'Total Cracking (%)' AS `Total Cracking (%)`,'Longitudinal Cracking (m)' AS `Longitudinal Cracking (m)`,
                                   'Texture (Center) (SPTD) (mm)' AS `Texture (Center) (SPTD) (mm)`, 
                                   'Texture (Driver) (SPTD) (mm)' AS `Texture (Driver) (SPTD) (mm)`,
                                   'Texture (Passenger) (SPTD) (mm)' AS `Texture (Passenger) (SPTD) (mm)`,
                                   'SFC (Driver)' AS `SFC (Driver)`,'SFC (Passenger)' AS `SFC (Passenger)`,
                                   'Ravelling (%)' AS `Ravelling (%)`,
                                   'Remaining Life - Alternate' AS `Remaining Life - Alternate`, 'Remaining Life - Conforming' AS `Remaining Life - Conforming`)
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
| `Defect_100m` | `string` | No |  |
| `Defect_100m_exclRemLife` | `string` | No |  |
| `LPPC_Defect_Static` | `string` | No |  |
| `LPPC_Defect_Static_exclRemLife` | `string` | No |  |
| `LPPC_Defect_Rolling` | `string` | No |  |
| `LPPC_Defect_Rolling_exclRemLife` | `string` | No |  |
| `Roughness (NAASRA/km)` | `double` | Yes |  |
| `Rutting (Driver) 80th Percentile (mm)` | `double` | Yes |  |
| `Rutting (Passenger) 80th Percentile (mm)` | `double` | Yes |  |
| `Total Cracking (%)` | `double` | Yes |  |
| `Longitudinal Cracking (m)` | `double` | Yes |  |
| `Texture (Center) (SPTD) (mm)` | `double` | Yes |  |
| `Texture (Driver) (SPTD) (mm)` | `double` | Yes |  |
| `Texture (Passenger) (SPTD) (mm)` | `double` | Yes |  |
| `SFC (Driver)` | `double` | Yes |  |
| `SFC (Passenger)` | `double` | Yes |  |
| `Ravelling (%)` | `double` | Yes |  |
| `Remaining Life - Alternate` | `double` | Yes |  |
| `Remaining Life - Conforming` | `double` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
