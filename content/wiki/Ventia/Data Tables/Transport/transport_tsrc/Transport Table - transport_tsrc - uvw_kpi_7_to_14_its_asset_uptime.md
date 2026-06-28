---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: uvw_kpi_7_to_14_its_asset_uptime
full-name: transport_dev.transport_tsrc.uvw_kpi_7_to_14_its_asset_uptime
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - uvw_kpi_7_to_14_its_asset_uptime

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_kpi_7_to_14_its_asset_uptime` |
| Full name | `transport_dev.transport_tsrc.uvw_kpi_7_to_14_its_asset_uptime` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | VIEW |
| Column count | 45 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | KPI / reporting |
| Owner/SME | hui.chen@ventia.com |
| Refresh/freshness | Created: 2024-07-25T12:53:07.726Z; Last altered: 2024-07-25T19:05:20.797Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
    WITH assetstble AS (
        SELECT 
        *,
        TO_DATE(constructiondate) AS constructiondate_date,
        --- Create Date which asset begins to be evaluated under this KPI
        CASE WHEN constructiondate <=date("2023-01-01") THEN date("2023-01-01") ELSE TO_DATE(constructiondate)
        END AS `evaluation_start_date`,
        --- Create Date which assets stops being evaluated under this KPI
        CASE WHEN disposaldate IS NULL THEN TO_DATE(convert_timezone('Australia/Queensland',getdate())) ELSE TO_DATE(disposaldate)
        END AS `evaluation_end_date` 
        FROM ext_mssql_asset_vision_ven_gen7.dbo.asset
        WHERE
        deleted = FALSE
        AND stage <> "Inactive"
        AND
        assettype IN ("ITS - Vehicle Detector and Classifier",   -- KPI 7 Assets
                        "ITS - Bluetooth Device",
                        "ITS - CCTV",
                        "ITS - Conduits",
                        "ITS - Elec & Coms Pits",
                        "ITS - Field Cabinet",                
                        "ITS - Road Weather Monitoring System",
                        "ITS - Switchboard",
                        "ITS - UPS",
                        "ITS - Variable Message Sign",
                        "ITS - Vehicle Detector and Classifier",
                        "ITS - Webcam",
                        "TCC Server Room",                        -- KPI 8,9 and 14 Assets
                        "ITS - Tolling Point",                    -- KPI 11 Assets
                        "ITS - QPS Camera")                       -- KPI 12 Assets
    )

    SELECT
        a.*,
        b.Date,
        b.`Day of Week`,
        b.Year,
        b.Quarter,
        b.`Week Number`,
        24 AS Uptime,
        c.WKT as `WKT`
    FROM assetstble a
    LEFT JOIN transport_dev.transport_tsrc.utbl_ref_date_table b
        ON b.Date >= a.evaluation_start_date AND b.Date <= a.evaluation_end_date
    LEFT JOIN ext_mssql_asset_vision_ven_gen7.dbo.vassetlocation c
        ON c.assetid = a. id
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `ID` | `int` | Yes |  |
| `DeltaUTC` | `timestamp` | Yes |  |
| `ModifiedUTC` | `timestamp` | Yes |  |
| `ExportDateUTC` | `timestamp` | Yes |  |
| `ModifiedUser` | `string` | Yes |  |
| `Code` | `string` | Yes |  |
| `Name` | `string` | Yes |  |
| `Contract` | `string` | Yes |  |
| `AssetType` | `string` | Yes |  |
| `SpatialType` | `string` | Yes |  |
| `ParentAssetID` | `int` | Yes |  |
| `ParentAssetCode` | `string` | Yes |  |
| `ParentAssetName` | `string` | Yes |  |
| `ParentAssetTypeName` | `string` | Yes |  |
| `Direction` | `string` | Yes |  |
| `ChainageFrom` | `int` | Yes |  |
| `ChainageTo` | `int` | Yes |  |
| `ParentAssetPosition` | `string` | Yes |  |
| `Stage` | `string` | Yes |  |
| `ConstructionDate` | `timestamp` | Yes |  |
| `ConstructionCost` | `decimal(12,2)` | Yes |  |
| `DisposalDate` | `timestamp` | Yes |  |
| `DisposalCost` | `decimal(12,2)` | Yes |  |
| `UsefulLife` | `decimal(6,2)` | Yes |  |
| `AssetCriticality` | `string` | Yes |  |
| `AssetCondition` | `string` | Yes |  |
| `AssetRisk` | `string` | Yes |  |
| `AssetConditionModel` | `string` | Yes |  |
| `ConditionDate` | `timestamp` | Yes |  |
| `Classification` | `string` | Yes |  |
| `Notes` | `string` | Yes |  |
| `AlertNotes` | `string` | Yes |  |
| `OffsetSide` | `string` | Yes |  |
| `OffsetMetres` | `int` | Yes |  |
| `Deleted` | `boolean` | Yes |  |
| `constructiondate_date` | `date` | Yes |  |
| `evaluation_start_date` | `date` | Yes |  |
| `evaluation_end_date` | `date` | Yes |  |
| `Date` | `date` | Yes |  |
| `Day of Week` | `string` | Yes |  |
| `Year` | `bigint` | Yes |  |
| `Quarter` | `string` | Yes |  |
| `Week Number` | `bigint` | Yes |  |
| `Uptime` | `int` | No |  |
| `WKT` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
