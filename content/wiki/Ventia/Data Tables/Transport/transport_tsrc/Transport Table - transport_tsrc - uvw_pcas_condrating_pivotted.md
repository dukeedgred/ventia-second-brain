---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: uvw_pcas_condrating_pivotted
full-name: transport_dev.transport_tsrc.uvw_pcas_condrating_pivotted
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - uvw_pcas_condrating_pivotted

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_pcas_condrating_pivotted` |
| Full name | `transport_dev.transport_tsrc.uvw_pcas_condrating_pivotted` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | VIEW |
| Column count | 14 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | capital works / forward works |
| Owner/SME | hui.chen@ventia.com |
| Refresh/freshness | Created: 2024-07-29T01:20:27.73Z; Last altered: 2024-07-31T23:24:49.293Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
    WITH pcas_condrating AS (
        SELECT 
            Attribute_Name,
            Condition_Rating,
            AV_Asset_ID AS AV_Asset_ID_CondRating
        FROM transport_dev.transport_tsrc.uvw_pcas_numeric_data --- Table to be updated
        WHERE Attribute_Name IN ('Longitudinal Cracking (m)','Ravelling (%)','Remaining Life - Alternate', 'Remaining Life - Conforming','Roughness (NAASRA/km)',
                                'Rutting (Driver) 80th Percentile (mm)','Rutting (Passenger) 80th Percentile (mm)','Total Cracking (%)','Longitudinal Cracking (m)',
                                'Texture (Center) (SPTD) (mm)', 'Texture (Driver) (SPTD) (mm)', 'Texture (Passenger) (SPTD) (mm)',
                                'SFC (Driver)','SFC (Passenger)')
    )

    SELECT
        *
    FROM pcas_condrating PIVOT (
        MAX(Condition_Rating)
        --- Pivots out new columns code reads as where value in pivotcol_name is X then name it AS Y
        --- e.g. where value in pivotcol_name is 'Chainage Start' pivot out into a column called `Start Chng`
        FOR Attribute_Name IN ('Roughness (NAASRA/km)' AS `Roughness (NAASRA/km)-CondRating`,
                                'Rutting (Driver) 80th Percentile (mm)' AS `Rutting (Driver) 80th Percentile (mm)-CondRating`,
                                'Rutting (Passenger) 80th Percentile (mm)' AS `Rutting (Passenger) 80th Percentile (mm)-CondRating`,
                                'Total Cracking (%)' AS `Total Cracking (%)-CondRating`,
                                'Longitudinal Cracking (m)' AS `Longitudinal Cracking (m)-CondRating`,
                                'Texture (Center) (SPTD) (mm)' AS `Texture (Center) (SPTD) (mm)-CondRating`,
                                'Texture (Driver) (SPTD) (mm)' AS `Texture (Driver) (SPTD) (mm)-CondRating`,
                                'Texture (Passenger) (SPTD) (mm)' AS `Texture (Passenger) (SPTD) (mm)-CondRating`,
                                'SFC (Driver)' AS `SFC (Driver)-CondRating`,
                                'SFC (Passenger)' AS `SFC (Passenger)-CondRating`,
                                'Ravelling (%)' AS `Ravelling (%)-CondRating`,
                                'Remaining Life - Alternate' AS `Remaining Life - Alternate-CondRating`,
                                'Remaining Life - Conforming' AS `Remaining Life - Conforming-CondRating`)
        )
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
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

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
