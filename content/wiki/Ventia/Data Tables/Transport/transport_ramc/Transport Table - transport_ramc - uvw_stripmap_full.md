---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_ramc
table-name: uvw_stripmap_full
full-name: transport_dev.transport_ramc.uvw_stripmap_full
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-ramc]
---

# Transport Table - transport_ramc - uvw_stripmap_full

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_stripmap_full` |
| Full name | `transport_dev.transport_ramc.uvw_stripmap_full` |
| Catalog | `transport_dev` |
| Schema | `transport_ramc` |
| Contract/schema | `transport_ramc` |
| Table type | VIEW |
| Column count | 25 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | hui.chen@ventia.com |
| Refresh/freshness | Created: 2025-04-07T03:42:20.871Z; Last altered: 2025-04-07T03:42:20.871Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
WITH unioned AS (
    WITH pcasfull AS (
        WITH assetpivot AS (
            WITH assetjoined AS (
                SELECT
                    a.`ID`,
                    a.`code`,
                    a.parentassetcode,
                    a.parentassetname,
                    a.ChainageFrom,
                    a.ChainageTo,
                    a.`name` as `assetname`,
                    -- May need to transform this data first to the correct renames
                    b.`name` AS Attribute_Name,
                    b.value AS Attribute_Value,
                    b.datatype,
                    a.deltautc,
                    a.modifiedutc,
                    a.modifieduser,
                    a.contract,
                    a.spatialtype,
                    a.parentassetid,
                    a.parentassettypename,
                    a.direction,
                    a.stage,
                    a.classification
                FROM ext_mssql_asset_vision_ven_gen7.dbo.asset a
                INNER JOIN ext_mssql_asset_vision_ven_gen7.dbo.assetattribute b
                ON b.AssetID = a.`ID`
                    WHERE
                    contract LIKE '%RAMC - Gen 2 - 2019-2024%'
                    AND a.assettype = 'Segment'
                    AND a.deleted = 'False'
                    AND a.stage = 'Active'
                    AND b.deleted = 'False'
                    -- Enter in any attributes below to exclude if you need to join them in for pivotting so that it applies to all rows
                    AND b.`name` NOT IN ('Survey Date') -- Place Holder Attribute Name - TBD on what this attribute will be called
                    --- Filter for only numeric data types
            )
            -- Join in fields you want to pivot out to apply for all data rows. This is for filtering
            -- Pivot on the pivotcol_name and pivotcol_val column to get the data out
            SELECT
                b.name AS pivotcol_name,
                b.value AS pivotcol_val,
                a.*
            FROM 
            assetjoined a
            -- Select the values you want to pivot out
            LEFT JOIN (SELECT assetid,`name`,value FROM ext_mssql_asset_vision_ven_gen7.dbo.assetattribute
                        WHERE name IN ('Survey Date', 'Carriageway_Text')) b
            ON b.assetid = a.id
        )

        -- Select to Re-Arrange the columns
        SELECT
            --- Segment Asset Table Data
            `id` AS `AV_Asset_ID`,
            `code` AS `AV_Asset_Code`,
            -99 AS JobID,
            `assetname`,
            ChainageFrom,
            ChainageTo,
            CONCAT(CAST(ChainageFrom AS INT)," - ", CAST(`ChainageTo` AS INT)) Chainage_Text,
            --- Parent Asset Data
            parentassetid,
            parentassetcode,
            parentassetname,
            parentassettypename,
            direction,
            --classification,
            ------- Pivotted Out Columns -------
            CAST(TO_DATE(`Survey Date`, 'dd/MM/yyyy HH:mm:ss') AS DATE) AS `Survey Date`,
            CAST(RIGHT(LEFT(`Survey Date`,10),4) AS INT) AS `Survey Year`,
            `Carriageway`,
            --- Attribute fields
            Attribute_Name,
            Attribute_Value,
            datatype AS Attribute_dtype,
            --- Attribute filter types or levels --------------
            -- Level 1 - PavCon + Year
            CONCAT(`id`,"_",'PavCon - ',RIGHT(LEFT(`Survey Date`,10),4)) AS `Attribute_FilterTypeID`,
            CONCAT('PavCon - ',RIGHT(LEFT(`Survey Date`,10),4)) AS `Attribute_FilterType`,
            -- Level 2 - Information Categories
            CASE WHEN Attribute_Name IN ('Billing Classification','Carriageway_Text','CWAY Lanes','CWAY Width') THEN 'Road Information'
                 WHEN Attribute_Name IN ('Pavement Width','Pav_Base_Type','Pav_Seal_Type','Surface Details','Pavement_Age','Year Constructed','Year Last Pavement Renewal', 'Year Last Rehab','Year Last Surfaced') THEN 'Pavement Information'
                 WHEN Attribute_Name IN ('MT_AADT','Year_AADT','Speed Limit','Tier') THEN 'Traffic Information'
                 WHEN Attribute_Name IN ('Year Condition','Transverse Cracking %','Crocodile Cracking %','Seal_Age','Roughness NRM','RoughnessClass','Rut Depth','RuttingClass','RideQualityClass') THEN 'Pavement Condition'
                 ELSE 'General'
            END AS `Attribute_FilterType_lvl2`,
            -- Level 3 - Information Sub-Categories
            CASE WHEN Attribute_Name IN ('Transverse Cracking %','Crocodile Cracking %','Seal_Age') THEN 'E17'
                 WHEN Attribute_Name IN ('Roughness NRM','RoughnessClass','Rut Depth','RuttingClass','RideQualityClass') THEN 'E18'
                 ELSE 'General'
            END AS `Attribute_FilterType_lvl3`
            --- Asset Vision General
            --deltautc,
            --modifiedutc,
            --modifieduser,
            --spatialtype,
            --stage
        FROM assetpivot PIVOT (
        MAX(pivotcol_val)
        --- Pivots out new columns - code reads as where value in pivotcol_name is X then name it AS Y
        --- e.g. where value in pivotcol_name is 'Chainage Start' pivot out into a column called `Start Chng`
        FOR pivotcol_name IN ('Survey Date' AS `Survey Date`, 'Carriageway_Text' AS `Carriageway`)
        )
        WHERE Attribute_Value <> '' OR Attribute_Value <> NULL
        ORDER BY code, Attribute_Name
    )
    --- UNION WITH OTHER STRIP MAP TABLES
    SELECT
        *
    FROM pcasfull

    UNION
    --- Distinct Job codes to display in strip map
    SELECT 
    DISTINCT 
        AV_Asset_ID,
        AV_Asset_Code,
        JobID,
        assetname,
        ChainageFrom,
        ChainageTo,
        Chainage_Text,
        parentassetid,
        parentassetcode,
        parentassetname,
        parentassettypename,
        direction,
        `Survey Date`,
        `Survey Year`,
        b.Value AS Carriageway,
        Attribute_Name,
        Attribute_Value,
        Attribute_dtype,
        Attribute_FilterTypeID,
        Attribute_FilterType,
        Attribute_FilterType_lvl2,
        Attribute_FilterType_lvl3
    FROM transport_dev.transport_ramc.uvw_stripmap_jobs a
    LEFT JOIN -- Join to get the carriageway text from the segments table
    (SELECT * FROM ext_mssql_asset_vision_ven_gen7.dbo.assetattribute
    WHERE Name = 'Carriageway_Text') b
    ON a.AV_Asset_ID = b.AssetID
    ORDER BY AV_Asset_ID
    )
SELECT
    *,
    -- Setup Param Ordering -- Level 2
    CASE WHEN Attribute_FilterType_lvl2 = 'General' THEN 1
         WHEN Attribute_FilterType_lvl2 = 'Road Information' THEN 2
         WHEN Attribute_FilterType_lvl2 = 'Pavement Information' THEN 3
         WHEN Attribute_FilterType_lvl2 = 'Traffic Information' THEN 4
         WHEN Attribute_FilterType_lvl2 = 'Pavement Condition' THEN 5
         ELSE 99
    END AS Lvl2_Order,
    -- Setup Param Ordering -- Level 3
    CASE WHEN Attribute_FilterType_lvl3 = 'General' THEN 1
         WHEN Attribute_FilterType_lvl3 = 'E17' THEN 2
         WHEN Attribute_FilterType_lvl3 = 'E18' THEN 3
         WHEN Attribute_FilterType_lvl3 = 'Open' THEN 4
         WHEN Attribute_FilterType_lvl3 = 'Complete' THEN 5
         WHEN Attribute_FilterType_lvl3 = 'No Action Required' THEN 6
         ELSE 99
    END AS Lvl3_Order,
    -- Setup Param Ordering -- Param
    CASE WHEN Attribute_Name = 'Billing Classification' THEN 1
         WHEN Attribute_Name = 'Carriageway_Text' THEN 2
         WHEN Attribute_Name = 'CWAY Lanes' THEN 3
         WHEN Attribute_Name = 'CWAY Width' THEN 4
         WHEN Attribute_Name = 'Pavement Width' THEN 5
         WHEN Attribute_Name = 'Pav_Base_Type' THEN 6
         WHEN Attribute_Name = 'Pav_Seal_Type' THEN 7
         WHEN Attribute_Name = 'Surface Details' THEN 8
         WHEN Attribute_Name = 'Pavement_Age' THEN 9
         WHEN Attribute_Name = 'Year Constructed' THEN 10
         WHEN Attribute_Name = 'Year Last Pavement Renewal' THEN 11
         WHEN Attribute_Name = 'Year Last Rehab' THEN 12
         WHEN Attribute_Name = 'Year Last Surfaced' THEN 13
         WHEN Attribute_Name = 'MT_AADT' THEN 14
         WHEN Attribute_Name = 'Year_AADT' THEN 15
         WHEN Attribute_Name = 'Speed Limit' THEN 16
         WHEN Attribute_Name = 'Tier' THEN 17
         WHEN Attribute_Name = 'Year Condition' THEN 18
         WHEN Attribute_Name = 'Transverse Cracking %' THEN 19
         WHEN Attribute_Name = 'Crocodile Cracking %' THEN 20
         WHEN Attribute_Name = 'Seal_Age' THEN 21
         WHEN Attribute_Name = 'Roughness NRM' THEN 22
         WHEN Attribute_Name = 'RoughnessClass' THEN 23
         WHEN Attribute_Name = 'Rut Depth' THEN 24
         WHEN Attribute_Name = 'RuttingClass' THEN 25
         WHEN Attribute_Name = 'RideQualityClass' THEN 26
         ELSE 99
    END AS Param_Order

FROM unioned
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `AV_Asset_ID` | `int` | Yes |  |
| `AV_Asset_Code` | `string` | Yes |  |
| `JobID` | `int` | Yes |  |
| `assetname` | `string` | Yes |  |
| `ChainageFrom` | `int` | Yes |  |
| `ChainageTo` | `int` | Yes |  |
| `Chainage_Text` | `string` | Yes |  |
| `parentassetid` | `int` | Yes |  |
| `parentassetcode` | `string` | Yes |  |
| `parentassetname` | `string` | Yes |  |
| `parentassettypename` | `string` | Yes |  |
| `direction` | `string` | Yes |  |
| `Survey Date` | `date` | Yes |  |
| `Survey Year` | `int` | Yes |  |
| `Carriageway` | `string` | Yes |  |
| `Attribute_Name` | `string` | Yes |  |
| `Attribute_Value` | `string` | Yes |  |
| `Attribute_dtype` | `string` | Yes |  |
| `Attribute_FilterTypeID` | `string` | Yes |  |
| `Attribute_FilterType` | `string` | Yes |  |
| `Attribute_FilterType_lvl2` | `string` | No |  |
| `Attribute_FilterType_lvl3` | `string` | Yes |  |
| `Lvl2_Order` | `int` | No |  |
| `Lvl3_Order` | `int` | No |  |
| `Param_Order` | `int` | No |  |

## Related Pages

- [[Transport Contract Tables - transport_ramc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
