---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: uvw_pcas_caplentrted_pivotted
full-name: transport_dev.transport_tsrc.uvw_pcas_caplentrted_pivotted
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - uvw_pcas_caplentrted_pivotted

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_pcas_caplentrted_pivotted` |
| Full name | `transport_dev.transport_tsrc.uvw_pcas_caplentrted_pivotted` |
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
| Refresh/freshness | Created: 2024-07-29T06:50:02.642Z; Last altered: 2024-07-31T23:24:50.418Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
    WITH caplentrt_grouped AS(
        WITH caplentrt AS (
            SELECT 
                assetname AS caplen_assetname,
                CONCAT(Attribute_Name,"_",`Survey Year`) AS Attribute_Name_Yr,
                CAST(Attribute_Value AS INT) AS Attribute_Value
            FROM transport_dev.transport_tsrc.uvw_pcas_stripmap_ele_capworks_singlelane
            WHERE Attribute_Name LIKE '%Length Treated%'
        )
        SELECT
            caplen_assetname,
            Attribute_Name_Yr,
            SUM(Attribute_Value) AS LenTrted
        FROM caplentrt
        GROUP BY caplen_assetname, Attribute_Name_Yr
    )

    SELECT
        *
    FROM caplentrt_grouped PIVOT (
        MAX(LenTrted)
        --- Pivots out new columns code reads as where value in pivotcol_name is X then name it AS Y
        --- e.g. where value in pivotcol_name is 'Chainage Start' pivot out into a column called `Start Chng`
        --- NEED TO KEEP ADDING IN YEARS SQL DOESN'T AUTO PIVOT WHATEVER VALUES ARE THERE
        FOR Attribute_Name_Yr IN ('PAVMILFIL - Length Treated_2023' AS `PAVMILFIL - Length Treated_2023`,
                                'PAVTEXWBLAST - Length Treated_2023' AS `PAVTEXWBLAST - Length Treated_2023`,
                                'PAVCRACK - Length Treated_2023' AS `PAVCRACK - Cracking repairs_2023`,
                                --- 2024
                                'PAVMILFIL - Length Treated_2024' AS `PAVMILFIL - Length Treated_2024`,
                                'PAVTEXWBLAST - Length Treated_2024' AS `PAVTEXWBLAST - Length Treated_2024`,
                                'PAVCRACK - Length Treated_2024' AS `PAVCRACK - Cracking repairs_2024`,
                                --- 2025
                                'PAVMILFIL - Length Treated_2025' AS `PAVMILFIL - Length Treated_2025`,
                                'PAVTEXWBLAST - Length Treated_2025' AS `PAVTEXWBLAST - Length Treated_2025`,
                                'PAVCRACK - Length Treated_2025' AS `PAVCRACK - Cracking repairs_2025`,
                                --- 2026
                                'PAVMILFIL - Length Treated_2026' AS `PAVMILFIL - Length Treated_2026`,
                                'PAVTEXWBLAST - Length Treated_2026' AS `PAVTEXWBLAST - Length Treated_2026`,
                                'PAVCRACK - Length Treated_2026' AS `PAVCRACK - Cracking repairs_2026`,
                                --- 2027
                                'PAVMILFIL - Length Treated_2027' AS `PAVMILFIL - Length Treated_2027`,
                                'PAVTEXWBLAST - Length Treated_2027' AS `PAVTEXWBLAST - Length Treated_2027`,
                                'PAVCRACK - Length Treated_2027' AS `PAVCRACK - Cracking repairs_2027`,
                                --- 2028
                                'PAVMILFIL - Length Treated_2028' AS `PAVMILFIL - Length Treated_2028`,
                                'PAVTEXWBLAST - Length Treated_2028' AS `PAVTEXWBLAST - Length Treated_2028`,
                                'PAVCRACK - Length Treated_2028' AS `PAVCRACK - Cracking repairs_2028`
                                )
            )
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `caplen_assetname` | `string` | Yes |  |
| `PAVMILFIL - Length Treated_2023` | `bigint` | Yes |  |
| `PAVTEXWBLAST - Length Treated_2023` | `bigint` | Yes |  |
| `PAVCRACK - Cracking repairs_2023` | `bigint` | Yes |  |
| `PAVMILFIL - Length Treated_2024` | `bigint` | Yes |  |
| `PAVTEXWBLAST - Length Treated_2024` | `bigint` | Yes |  |
| `PAVCRACK - Cracking repairs_2024` | `bigint` | Yes |  |
| `PAVMILFIL - Length Treated_2025` | `bigint` | Yes |  |
| `PAVTEXWBLAST - Length Treated_2025` | `bigint` | Yes |  |
| `PAVCRACK - Cracking repairs_2025` | `bigint` | Yes |  |
| `PAVMILFIL - Length Treated_2026` | `bigint` | Yes |  |
| `PAVTEXWBLAST - Length Treated_2026` | `bigint` | Yes |  |
| `PAVCRACK - Cracking repairs_2026` | `bigint` | Yes |  |
| `PAVMILFIL - Length Treated_2027` | `bigint` | Yes |  |
| `PAVTEXWBLAST - Length Treated_2027` | `bigint` | Yes |  |
| `PAVCRACK - Cracking repairs_2027` | `bigint` | Yes |  |
| `PAVMILFIL - Length Treated_2028` | `bigint` | Yes |  |
| `PAVTEXWBLAST - Length Treated_2028` | `bigint` | Yes |  |
| `PAVCRACK - Cracking repairs_2028` | `bigint` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
