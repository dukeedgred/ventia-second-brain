---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: uvw_pcas_lppc_defects_pivotted
full-name: transport_dev.transport_tsrc.uvw_pcas_lppc_defects_pivotted
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - uvw_pcas_lppc_defects_pivotted

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_pcas_lppc_defects_pivotted` |
| Full name | `transport_dev.transport_tsrc.uvw_pcas_lppc_defects_pivotted` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | VIEW |
| Column count | 110 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | defects / hazards / failures |
| Owner/SME | hui.chen@ventia.com |
| Refresh/freshness | Created: 2024-08-06T03:36:37.333Z; Last altered: 2024-08-06T04:41:40.739Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
    WITH pcas_pass_fail_pivot AS (
        WITH pcas_pass_fail AS (
            SELECT 
                Attribute_Name,
                PCAS_Pass_Fail,
                AV_Asset_ID AS AV_Asset_ID_Pass_Fail
            FROM transport_dev.transport_tsrc.uvw_pcas_numeric_data --- Table to be updated
            WHERE Attribute_Name IN ('Longitudinal Cracking (m)','Ravelling (%)','Remaining Life - Alternate', 'Remaining Life - Conforming','Roughness (NAASRA/km)',
                                    'Rutting (Driver) 80th Percentile (mm)','Rutting (Passenger) 80th Percentile (mm)','Total Cracking (%)','Longitudinal Cracking (m)',
                                    'Texture (Center) (SPTD) (mm)', 'Texture (Driver) (SPTD) (mm)', 'Texture (Passenger) (SPTD) (mm)',
                                    'SFC (Driver)','SFC (Passenger)')
            )

            SELECT
                *
            FROM pcas_pass_fail PIVOT (
                MAX(PCAS_Pass_Fail)
                --- Pivots out new columns code reads as where value in pivotcol_name is X then name it AS Y
                --- e.g. where value in pivotcol_name is 'Chainage Start' pivot out into a column called `Start Chng`
                FOR Attribute_Name IN ('Roughness (NAASRA/km)' AS `Roughness (NAASRA/km)-PassFail`,
                                    'Rutting (Driver) 80th Percentile (mm)' AS `Rutting (Driver) 80th Percentile (mm)-PassFail`,
                                    'Rutting (Passenger) 80th Percentile (mm)' AS `Rutting (Passenger) 80th Percentile (mm)-PassFail`,
                                    'Total Cracking (%)' AS `Total Cracking (%)-PassFail`,'Longitudinal Cracking (m)' AS `Longitudinal Cracking (m)-PassFail`,
                                    'Texture (Center) (SPTD) (mm)' AS `Texture (Center) (SPTD) (mm)-PassFail`,
                                    'Texture (Driver) (SPTD) (mm)' AS `Texture (Driver) (SPTD) (mm)-PassFail`,
                                    'Texture (Passenger) (SPTD) (mm)' AS `Texture (Passenger) (SPTD) (mm)-PassFail`,
                                    'SFC (Driver)' AS `SFC (Driver)-PassFail`,'SFC (Passenger)' AS `SFC (Passenger)-PassFail`,
                                    'Ravelling (%)' AS `Ravelling (%)-PassFail`,
                                    'Remaining Life - Alternate' AS `Remaining Life - Alternate-PassFail`, 'Remaining Life - Conforming' AS `Remaining Life - Conforming-PassFail`)
                )
    )

    ------  Join it with the numeric pivotted data
    SELECT
        a.*,
        b.*,
        c.*,
        CASE WHEN f.DnC_Defect IS NULL OR f.DnC_Defect='' THEN 'No' ELSE f.DnC_Defect END AS DnC_Defect_Latest,
        CASE WHEN c.`Rutting (Driver) 80th Percentile (mm)-CondRating` = 'Failed' OR c.`Rutting (Passenger) 80th Percentile (mm)-CondRating` = 'Failed' THEN 'Failed'
             WHEN c.`Rutting (Driver) 80th Percentile (mm)-CondRating` = 'Fair' OR c.`Rutting (Passenger) 80th Percentile (mm)-CondRating` = 'Fair' THEN 'Fair'
             WHEN c.`Rutting (Driver) 80th Percentile (mm)-CondRating` = 'Good' OR c.`Rutting (Passenger) 80th Percentile (mm)-CondRating` = 'Good' THEN 'Good'
             WHEN c.`Rutting (Driver) 80th Percentile (mm)-CondRating` = 'Very Good' OR c.`Rutting (Passenger) 80th Percentile (mm)-CondRating` = 'Very Good' THEN 'Very Good'
        ELSE 'No Data'
        END AS Rutting_Overall_Rating,
        CASE WHEN c.`Longitudinal Cracking (m)-CondRating` = 'Failed' OR c.`Total Cracking (%)-CondRating` = 'Failed' THEN 'Failed'
             WHEN c.`Longitudinal Cracking (m)-CondRating` = 'Fair' OR c.`Total Cracking (%)-CondRating` = 'Fair' THEN 'Fair'
             WHEN c.`Longitudinal Cracking (m)-CondRating` = 'Good' OR c.`Total Cracking (%)-CondRating` = 'Good' THEN 'Good'
             WHEN c.`Longitudinal Cracking (m)-CondRating` = 'Very Good' OR c.`Total Cracking (%)-CondRating` = 'Very Good' THEN 'Very Good'
        ELSE 'No Data'
        END AS Crk_Overall_Rating,
        CASE WHEN c.`SFC (Driver)-CondRating` = 'Failed' OR c.`SFC (Passenger)-CondRating` = 'Failed' THEN 'Failed'
             WHEN c.`SFC (Driver)-CondRating` = 'Fair' OR c.`SFC (Passenger)-CondRating` = 'Fair' THEN 'Fair'
             WHEN c.`SFC (Driver)-CondRating` = 'Good' OR c.`SFC (Passenger)-CondRating` = 'Good' THEN 'Good'
             WHEN c.`SFC (Driver)-CondRating` = 'Very Good' OR c.`SFC (Passenger)-CondRating` = 'Very Good' THEN 'Very Good'
        ELSE 'No Data'
        END AS SFC_Overall_Rating,
        CASE WHEN c.`Texture (Center) (SPTD) (mm)-CondRating` = 'Failed' OR c.`Texture (Driver) (SPTD) (mm)-CondRating` = 'Failed' OR c.`Texture (Passenger) (SPTD) (mm)-CondRating` = 'Failed' THEN 'Failed'
             WHEN c.`Texture (Center) (SPTD) (mm)-CondRating` = 'Fair' OR c.`Texture (Driver) (SPTD) (mm)-CondRating` = 'Fair' OR c.`Texture (Passenger) (SPTD) (mm)-CondRating` = 'Fair' THEN 'Fair'
             WHEN c.`Texture (Center) (SPTD) (mm)-CondRating` = 'Good' OR c.`Texture (Driver) (SPTD) (mm)-CondRating` = 'Good' OR c.`Texture (Passenger) (SPTD) (mm)-CondRating` = 'Good' THEN 'Good'
             WHEN c.`Texture (Center) (SPTD) (mm)-CondRating` = 'Very Good' OR c.`Texture (Driver) (SPTD) (mm)-CondRating` = 'Very Good' OR c.`Texture (Passenger) (SPTD) (mm)-CondRating` = 'Very Good' THEN 'Very Good'
        ELSE 'No Data'
        END AS Texture_Overall_Rating,

        ---- Treatments
        CASE WHEN ISNULL(d.PAVMILFIL_2023) THEN 'Not Treated' ELSE d.PAVMILFIL_2023 END AS PAVMILFIL_2023,
        CASE WHEN ISNULL(d.PAVMILFIL_2024) THEN 'Not Treated' ELSE d.PAVMILFIL_2024 END AS PAVMILFIL_2024,
        CASE WHEN ISNULL(d.PAVMILFIL_2025) THEN 'Not Treated' ELSE d.PAVMILFIL_2025 END AS PAVMILFIL_2025,
        CASE WHEN ISNULL(d.PAVMILFIL_2026) THEN 'Not Treated' ELSE d.PAVMILFIL_2026 END AS PAVMILFIL_2026,
        CASE WHEN ISNULL(d.PAVMILFIL_2027) THEN 'Not Treated' ELSE d.PAVMILFIL_2027 END AS PAVMILFIL_2027,
        CASE WHEN ISNULL(d.PAVMILFIL_2028) THEN 'Not Treated' ELSE d.PAVMILFIL_2028 END AS PAVMILFIL_2028,

        CASE WHEN ISNULL(d.PAVTEXWBLAST_2023) THEN 'Not Treated' ELSE d.PAVTEXWBLAST_2023 END AS PAVTEXWBLAST_2023,
        CASE WHEN ISNULL(d.PAVTEXWBLAST_2024) THEN 'Not Treated' ELSE d.PAVTEXWBLAST_2024 END AS PAVTEXWBLAST_2024,
        CASE WHEN ISNULL(d.PAVTEXWBLAST_2025) THEN 'Not Treated' ELSE d.PAVTEXWBLAST_2025 END AS PAVTEXWBLAST_2025,
        CASE WHEN ISNULL(d.PAVTEXWBLAST_2026) THEN 'Not Treated' ELSE d.PAVTEXWBLAST_2026 END AS PAVTEXWBLAST_2026,
        CASE WHEN ISNULL(d.PAVTEXWBLAST_2027) THEN 'Not Treated' ELSE d.PAVTEXWBLAST_2027 END AS PAVTEXWBLAST_2027,
        CASE WHEN ISNULL(d.PAVTEXWBLAST_2028) THEN 'Not Treated' ELSE d.PAVTEXWBLAST_2028 END AS PAVTEXWBLAST_2028,
        
        CASE WHEN ISNULL(d.PAVCRACK_2023) THEN 'Not Treated' ELSE d.PAVCRACK_2023 END AS PAVCRACK_2023,
        CASE WHEN ISNULL(d.PAVCRACK_2024) THEN 'Not Treated' ELSE d.PAVCRACK_2024 END AS PAVCRACK_2024,
        CASE WHEN ISNULL(d.PAVCRACK_2025) THEN 'Not Treated' ELSE d.PAVCRACK_2025 END AS PAVCRACK_2025,
        CASE WHEN ISNULL(d.PAVCRACK_2026) THEN 'Not Treated' ELSE d.PAVCRACK_2026 END AS PAVCRACK_2026,
        CASE WHEN ISNULL(d.PAVCRACK_2027) THEN 'Not Treated' ELSE d.PAVCRACK_2027 END AS PAVCRACK_2027,
        CASE WHEN ISNULL(d.PAVCRACK_2028) THEN 'Not Treated' ELSE d.PAVCRACK_2028 END AS PAVCRACK_2028,

        ---- Treatments Length affected
        CASE WHEN ISNULL(e.`PAVMILFIL - Length Treated_2023`) THEN 0 ELSE e.`PAVMILFIL - Length Treated_2023` END AS `PAVMILFIL - Length Treated_2023`,
        CASE WHEN ISNULL(e.`PAVMILFIL - Length Treated_2024`) THEN 0 ELSE e.`PAVMILFIL - Length Treated_2024` END AS `PAVMILFIL - Length Treated_2024`,
        CASE WHEN ISNULL(e.`PAVMILFIL - Length Treated_2025`) THEN 0 ELSE e.`PAVMILFIL - Length Treated_2025` END AS `PAVMILFIL - Length Treated_2025`,
        CASE WHEN ISNULL(e.`PAVMILFIL - Length Treated_2026`) THEN 0 ELSE e.`PAVMILFIL - Length Treated_2026` END AS `PAVMILFIL - Length Treated_2026`,
        CASE WHEN ISNULL(e.`PAVMILFIL - Length Treated_2027`) THEN 0 ELSE e.`PAVMILFIL - Length Treated_2027` END AS `PAVMILFIL - Length Treated_2027`,
        CASE WHEN ISNULL(e.`PAVMILFIL - Length Treated_2028`) THEN 0 ELSE e.`PAVMILFIL - Length Treated_2028` END AS `PAVMILFIL - Length Treated_2028`,

        CASE WHEN ISNULL(e.`PAVTEXWBLAST - Length Treated_2023`) THEN 0 ELSE e.`PAVTEXWBLAST - Length Treated_2023` END AS `PAVTEXWBLAST - Length Treated_2023`,
        CASE WHEN ISNULL(e.`PAVTEXWBLAST - Length Treated_2024`) THEN 0 ELSE e.`PAVTEXWBLAST - Length Treated_2024` END AS `PAVTEXWBLAST - Length Treated_2024`,
        CASE WHEN ISNULL(e.`PAVTEXWBLAST - Length Treated_2025`) THEN 0 ELSE e.`PAVTEXWBLAST - Length Treated_2025` END AS `PAVTEXWBLAST - Length Treated_2025`,
        CASE WHEN ISNULL(e.`PAVTEXWBLAST - Length Treated_2026`) THEN 0 ELSE e.`PAVTEXWBLAST - Length Treated_2026` END AS `PAVTEXWBLAST - Length Treated_2026`,
        CASE WHEN ISNULL(e.`PAVTEXWBLAST - Length Treated_2027`) THEN 0 ELSE e.`PAVTEXWBLAST - Length Treated_2027` END AS `PAVTEXWBLAST - Length Treated_2027`,
        CASE WHEN ISNULL(e.`PAVTEXWBLAST - Length Treated_2028`) THEN 0 ELSE e.`PAVTEXWBLAST - Length Treated_2028` END AS `PAVTEXWBLAST - Length Treated_2028`,
        
        CASE WHEN ISNULL(e.`PAVCRACK - Cracking repairs_2023`) THEN 0 ELSE e.`PAVCRACK - Cracking repairs_2023` END AS `PAVCRACK - Cracking repairs_2023`,
        CASE WHEN ISNULL(e.`PAVCRACK - Cracking repairs_2024`) THEN 0 ELSE e.`PAVCRACK - Cracking repairs_2024` END AS `PAVCRACK - Cracking repairs_2024`,
        CASE WHEN ISNULL(e.`PAVCRACK - Cracking repairs_2025`) THEN 0 ELSE e.`PAVCRACK - Cracking repairs_2025` END AS `PAVCRACK - Cracking repairs_2025`,
        CASE WHEN ISNULL(e.`PAVCRACK - Cracking repairs_2026`) THEN 0 ELSE e.`PAVCRACK - Cracking repairs_2026` END AS `PAVCRACK - Cracking repairs_2026`,
        CASE WHEN ISNULL(e.`PAVCRACK - Cracking repairs_2027`) THEN 0 ELSE e.`PAVCRACK - Cracking repairs_2027` END AS `PAVCRACK - Cracking repairs_2027`,
        CASE WHEN ISNULL(e.`PAVCRACK - Cracking repairs_2028`) THEN 0 ELSE e.`PAVCRACK - Cracking repairs_2028` END AS `PAVCRACK - Cracking repairs_2028`

    --- Numeric values
    FROM transport_dev.transport_tsrc.uvw_pcas_numeric_data_pivotted a
    --- PCAS pass fail
    LEFT JOIN pcas_pass_fail_pivot b 
    ON a.AV_Asset_ID = b.AV_Asset_ID_Pass_Fail
    --- Condition Rating
    LEFT JOIN transport_dev.transport_tsrc.uvw_pcas_condrating_pivotted c
    ON a.AV_Asset_ID = c.AV_Asset_ID_CondRating
    --- Capworks done
    LEFT JOIN transport_dev.transport_tsrc.uvw_pcas_capdone_pivotted d
    ON a.assetname = d.cap_assetname
    --- Capwork Length Treated
    LEFT JOIN transport_dev.transport_tsrc.uvw_pcas_caplentrted_pivotted e
    ON a.assetname = e.caplen_assetname
    --- DnC Defect
    LEFT JOIN 
    (SELECT DISTINCT assetname, DnC_Defect FROM transport_dev.transport_tsrc.uvw_pcas_numeric_data
    where DnC_Defect = "Yes" AND `Survey Year` = 2024) f
    ON a.assetname = f.assetname
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
| `AV_Asset_ID_Pass_Fail` | `int` | Yes |  |
| `Roughness (NAASRA/km)-PassFail` | `string` | Yes |  |
| `Rutting (Driver) 80th Percentile (mm)-PassFail` | `string` | Yes |  |
| `Rutting (Passenger) 80th Percentile (mm)-PassFail` | `string` | Yes |  |
| `Total Cracking (%)-PassFail` | `string` | Yes |  |
| `Longitudinal Cracking (m)-PassFail` | `string` | Yes |  |
| `Texture (Center) (SPTD) (mm)-PassFail` | `string` | Yes |  |
| `Texture (Driver) (SPTD) (mm)-PassFail` | `string` | Yes |  |
| `Texture (Passenger) (SPTD) (mm)-PassFail` | `string` | Yes |  |
| `SFC (Driver)-PassFail` | `string` | Yes |  |
| `SFC (Passenger)-PassFail` | `string` | Yes |  |
| `Ravelling (%)-PassFail` | `string` | Yes |  |
| `Remaining Life - Alternate-PassFail` | `string` | Yes |  |
| `Remaining Life - Conforming-PassFail` | `string` | Yes |  |
| `AV_Asset_ID_CondRating` | `int` | Yes |  |
| `Roughness (NAASRA/km)-CondRating` | `string` | Yes |  |
| `Rutting (Driver) 80th Percentile (mm)-CondRating` | `string` | Yes |  |
| `Rutting (Passenger) 80th Percentile (mm)-CondRating` | `string` | Yes |  |
| `Total Cracking (%)-CondRating` | `string` | Yes |  |
| `Longitudinal Cracking (m)-CondRating` | `string` | Yes |  |
| `Texture (Center) (SPTD) (mm)-CondRating` | `string` | Yes |  |
| `Texture (Driver) (SPTD) (mm)-CondRating` | `string` | Yes |  |
| `Texture (Passenger) (SPTD) (mm)-CondRating` | `string` | Yes |  |
| `SFC (Driver)-CondRating` | `string` | Yes |  |
| `SFC (Passenger)-CondRating` | `string` | Yes |  |
| `Ravelling (%)-CondRating` | `string` | Yes |  |
| `Remaining Life - Alternate-CondRating` | `string` | Yes |  |
| `Remaining Life - Conforming-CondRating` | `string` | Yes |  |
| `DnC_Defect_Latest` | `string` | Yes |  |
| `Rutting_Overall_Rating` | `string` | No |  |
| `Crk_Overall_Rating` | `string` | No |  |
| `SFC_Overall_Rating` | `string` | No |  |
| `Texture_Overall_Rating` | `string` | No |  |
| `PAVMILFIL_2023` | `string` | Yes |  |
| `PAVMILFIL_2024` | `string` | Yes |  |
| `PAVMILFIL_2025` | `string` | Yes |  |
| `PAVMILFIL_2026` | `string` | Yes |  |
| `PAVMILFIL_2027` | `string` | Yes |  |
| `PAVMILFIL_2028` | `string` | Yes |  |
| `PAVTEXWBLAST_2023` | `string` | Yes |  |
| `PAVTEXWBLAST_2024` | `string` | Yes |  |
| `PAVTEXWBLAST_2025` | `string` | Yes |  |
| `PAVTEXWBLAST_2026` | `string` | Yes |  |
| `PAVTEXWBLAST_2027` | `string` | Yes |  |
| `PAVTEXWBLAST_2028` | `string` | Yes |  |
| `PAVCRACK_2023` | `string` | Yes |  |
| `PAVCRACK_2024` | `string` | Yes |  |
| `PAVCRACK_2025` | `string` | Yes |  |
| `PAVCRACK_2026` | `string` | Yes |  |
| `PAVCRACK_2027` | `string` | Yes |  |
| `PAVCRACK_2028` | `string` | Yes |  |
| `PAVMILFIL - Length Treated_2023` | `bigint` | Yes |  |
| `PAVMILFIL - Length Treated_2024` | `bigint` | Yes |  |
| `PAVMILFIL - Length Treated_2025` | `bigint` | Yes |  |
| `PAVMILFIL - Length Treated_2026` | `bigint` | Yes |  |
| `PAVMILFIL - Length Treated_2027` | `bigint` | Yes |  |
| `PAVMILFIL - Length Treated_2028` | `bigint` | Yes |  |
| `PAVTEXWBLAST - Length Treated_2023` | `bigint` | Yes |  |
| `PAVTEXWBLAST - Length Treated_2024` | `bigint` | Yes |  |
| `PAVTEXWBLAST - Length Treated_2025` | `bigint` | Yes |  |
| `PAVTEXWBLAST - Length Treated_2026` | `bigint` | Yes |  |
| `PAVTEXWBLAST - Length Treated_2027` | `bigint` | Yes |  |
| `PAVTEXWBLAST - Length Treated_2028` | `bigint` | Yes |  |
| `PAVCRACK - Cracking repairs_2023` | `bigint` | Yes |  |
| `PAVCRACK - Cracking repairs_2024` | `bigint` | Yes |  |
| `PAVCRACK - Cracking repairs_2025` | `bigint` | Yes |  |
| `PAVCRACK - Cracking repairs_2026` | `bigint` | Yes |  |
| `PAVCRACK - Cracking repairs_2027` | `bigint` | Yes |  |
| `PAVCRACK - Cracking repairs_2028` | `bigint` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
