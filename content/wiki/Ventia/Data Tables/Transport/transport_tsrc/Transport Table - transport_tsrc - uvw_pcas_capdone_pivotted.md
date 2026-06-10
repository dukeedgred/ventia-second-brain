---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: uvw_pcas_capdone_pivotted
full-name: transport_dev.transport_tsrc.uvw_pcas_capdone_pivotted
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - uvw_pcas_capdone_pivotted

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_pcas_capdone_pivotted` |
| Full name | `transport_dev.transport_tsrc.uvw_pcas_capdone_pivotted` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | VIEW |
| Column count | 19 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | capital works / forward works |
| Owner/SME | hui.chen@ventia.com |
| Refresh/freshness | Created: 2024-07-29T03:19:31.859Z; Last altered: 2024-07-31T23:24:51.918Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
    WITH captrt_grouped AS(
        WITH captrt AS (
            SELECT 
                assetname AS cap_assetname,
                CONCAT(LEFT(Attribute_Name,CHARINDEX("-",Attribute_Name)-2),"_",`Survey Year`) AS Attribute_Name_Yr,
                'Treated' AS Attribute_Value
            FROM transport_dev.transport_tsrc.uvw_pcas_stripmap_ele_capworks_singlelane
            WHERE Attribute_Name NOT LIKE '%Length Treated%'
        )
        SELECT
            cap_assetname,
            Attribute_Name_Yr,
            MAX(Attribute_Value) AS Trt_Name
        FROM captrt
        GROUP BY cap_assetname, Attribute_Name_Yr
    )

    SELECT
        *
    FROM captrt_grouped PIVOT (
        CASE WHEN MAX(Trt_Name) IS NULL THEN 'Not Treated' ELSE MAX(Trt_Name) END
        --- Pivots out new columns code reads as where value in pivotcol_name is X then name it AS Y
        --- e.g. where value in pivotcol_name is 'Chainage Start' pivot out into a column called `Start Chng`
        --- NEED TO KEEP ADDING IN YEARS SQL DOESN'T AUTO PIVOT WHATEVER VALUES ARE THERE
        FOR Attribute_Name_Yr IN (
                                'PAVMILFIL_2023' AS `PAVMILFIL_2023`,
                                'PAVTEXWBLAST_2023' AS `PAVTEXWBLAST_2023`,
                                'PAVCRACK_2023' AS `PAVCRACK_2023`,
                                --- 2024
                                'PAVMILFIL_2024' AS `PAVMILFIL_2024`,
                                'PAVTEXWBLAST_2024' AS `PAVTEXWBLAST_2024`,
                                'PAVCRACK_2024' AS `PAVCRACK_2024`,
                                --- 2025
                                'PAVMILFIL_2025' AS `PAVMILFIL_2025`,
                                'PAVTEXWBLAST_2025' AS `PAVTEXWBLAST_2025`,
                                'PAVCRACK_2025' AS `PAVCRACK_2025`,
                                --- 2026
                                'PAVMILFIL_2026' AS `PAVMILFIL_2026`,
                                'PAVTEXWBLAST_2026' AS `PAVTEXWBLAST_2026`,
                                'PAVCRACK_2026' AS `PAVCRACK_2026`,
                                --- 2027
                                'PAVMILFIL_2027' AS `PAVMILFIL_2027`,
                                'PAVTEXWBLAST_2027' AS `PAVTEXWBLAST_2027`,
                                'PAVCRACK_2027' AS `PAVCRACK_2027`,
                                --- 2028
                                'PAVMILFIL_2028' AS `PAVMILFIL_2028`,
                                'PAVTEXWBLAST_2028' AS `PAVTEXWBLAST_2028`,
                                'PAVCRACK_2028' AS `PAVCRACK_2028`
                                )
            )
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `cap_assetname` | `string` | Yes |  |
| `PAVMILFIL_2023` | `string` | Yes |  |
| `PAVTEXWBLAST_2023` | `string` | Yes |  |
| `PAVCRACK_2023` | `string` | Yes |  |
| `PAVMILFIL_2024` | `string` | Yes |  |
| `PAVTEXWBLAST_2024` | `string` | Yes |  |
| `PAVCRACK_2024` | `string` | Yes |  |
| `PAVMILFIL_2025` | `string` | Yes |  |
| `PAVTEXWBLAST_2025` | `string` | Yes |  |
| `PAVCRACK_2025` | `string` | Yes |  |
| `PAVMILFIL_2026` | `string` | Yes |  |
| `PAVTEXWBLAST_2026` | `string` | Yes |  |
| `PAVCRACK_2026` | `string` | Yes |  |
| `PAVMILFIL_2027` | `string` | Yes |  |
| `PAVTEXWBLAST_2027` | `string` | Yes |  |
| `PAVCRACK_2027` | `string` | Yes |  |
| `PAVMILFIL_2028` | `string` | Yes |  |
| `PAVTEXWBLAST_2028` | `string` | Yes |  |
| `PAVCRACK_2028` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
