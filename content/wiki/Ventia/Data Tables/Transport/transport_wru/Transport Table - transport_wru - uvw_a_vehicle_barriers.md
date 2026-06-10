---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_a_vehicle_barriers
full-name: transport_dev.transport_wru.uvw_a_vehicle_barriers
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_a_vehicle_barriers

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_a_vehicle_barriers` |
| Full name | `transport_dev.transport_wru.uvw_a_vehicle_barriers` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 35 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | rui.luan@ventia.com |
| Refresh/freshness | Created: 2025-05-14T01:22:39.039Z; Last altered: 2025-05-14T01:22:39.039Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
  WITH assetregister as (
    SELECT
      a.id as Asset_ID,
      a.stage,
      a.code as Asset_Code,
      a.name as Asset_Name,
      a.parentassetid as Road_No,
      a.parentassetname as Road_Name,
      if(a.direction = 'Outbound', 'Forward', 'Reverse') as direction,
      a.assetcondition,
      a.conditiondate,
      b.name,
      b.value,
      a.notes,
      a.alertnotes,
       concat(
      "https://vicroads.assetvision.com.au/Assets/ViewAsset/", string(a.id)
    ) as asset_hyperlink
    FROM
      ext_mssql_asset_vision_ven_vicroads.dbo.asset a
        INNER JOIN ext_mssql_asset_vision_ven_vicroads.dbo.assetattribute b
          ON a.id = b.assetid
    WHERE
        assettype = "Vehicle Barriers"
        and stage <> "Disposed"
        and a.deleted = 'false'
        and b.deleted = 'false'
  )
  SELECT
    *
  FROM
    assetregister
      PIVOT (
        max(value) for name in (
            'Longitudinal Barrier Type' as Barrier_Type,
            'Length of barrier (m)' as Barrier_Length,
            'Barrier number of posts' as No_of_Posts,

            'Terminal A Type' as Terminal_A_Type,
            'Terminal A Compliance' as Terminal_A_Compliance,
            'Terminal A Condition Rating' as Terminal_A_Condition_Rating,
            'Terminal A Product Name'  as Terminal_A_Product_Name,
            'Terminal A Serial Number' as Terminal_A_Serial_Number ,
            'Terminal A Comments' as Terminal_A_Comments,

            'Terminal B Type' as Terminal_B_Type,
            'Terminal B Compliance' as Terminal_B_Compliance,
            'Terminal B Condition Rating' as Terminal_B_Condition_Rating,
            'Terminal B Product Name' as Terminal_B_Product_Name,
            'Terminal B Serial Number' as Terminal_B_Serial_Number,
            'Terminal B Comments' as Terminal_B_Comments,

            'Length of barrier in Condition Rating 1 (m)' as Condition_1_Length,
            'Length of barrier in Condition Rating 2 (m)' as Condition_2_Length,
            'Length of barrier in Condition Rating 3 (m)' as Condition_3_Length,
            'Length of barrier in Condition Rating 4 (m)' as Condition_4_Length,
            'Length of barrier in Condition Rating 5 (m)' as Condition_5_Length,

            'Ambient Temperature (Degree Celsius)' as Ambient_Temp,
            'Tension Output (N)' as Tension_Output,

            'Third Party Site' as Third_Party_Site

        )
      )
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Asset_ID` | `int` | Yes |  |
| `stage` | `string` | Yes |  |
| `Asset_Code` | `string` | Yes |  |
| `Asset_Name` | `string` | Yes |  |
| `Road_No` | `int` | Yes |  |
| `Road_Name` | `string` | Yes |  |
| `direction` | `string` | No |  |
| `assetcondition` | `string` | Yes |  |
| `conditiondate` | `timestamp` | Yes |  |
| `notes` | `string` | Yes |  |
| `alertnotes` | `string` | Yes |  |
| `asset_hyperlink` | `string` | Yes |  |
| `Barrier_Type` | `string` | Yes |  |
| `Barrier_Length` | `string` | Yes |  |
| `No_of_Posts` | `string` | Yes |  |
| `Terminal_A_Type` | `string` | Yes |  |
| `Terminal_A_Compliance` | `string` | Yes |  |
| `Terminal_A_Condition_Rating` | `string` | Yes |  |
| `Terminal_A_Product_Name` | `string` | Yes |  |
| `Terminal_A_Serial_Number` | `string` | Yes |  |
| `Terminal_A_Comments` | `string` | Yes |  |
| `Terminal_B_Type` | `string` | Yes |  |
| `Terminal_B_Compliance` | `string` | Yes |  |
| `Terminal_B_Condition_Rating` | `string` | Yes |  |
| `Terminal_B_Product_Name` | `string` | Yes |  |
| `Terminal_B_Serial_Number` | `string` | Yes |  |
| `Terminal_B_Comments` | `string` | Yes |  |
| `Condition_1_Length` | `string` | Yes |  |
| `Condition_2_Length` | `string` | Yes |  |
| `Condition_3_Length` | `string` | Yes |  |
| `Condition_4_Length` | `string` | Yes |  |
| `Condition_5_Length` | `string` | Yes |  |
| `Ambient_Temp` | `string` | Yes |  |
| `Tension_Output` | `string` | Yes |  |
| `Third_Party_Site` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
