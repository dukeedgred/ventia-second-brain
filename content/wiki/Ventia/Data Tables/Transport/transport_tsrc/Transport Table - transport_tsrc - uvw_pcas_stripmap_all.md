---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: uvw_pcas_stripmap_all
full-name: transport_dev.transport_tsrc.uvw_pcas_stripmap_all
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - uvw_pcas_stripmap_all

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_pcas_stripmap_all` |
| Full name | `transport_dev.transport_tsrc.uvw_pcas_stripmap_all` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | VIEW |
| Column count | 33 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | capital works / forward works |
| Owner/SME | hui.chen@ventia.com |
| Refresh/freshness | Created: 2024-07-28T22:54:12.516Z; Last altered: 2024-07-31T23:24:52.715Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
WITH pcasunioned AS(
    WITH pcasfull AS (
        WITH assetpivot AS ( 
            WITH assetjoined AS (
            SELECT
                a.`id`,
                a.`code`,
                a.parentassetcode,
                a.parentassetname,
                a.`name` as `assetname`,
                aa.`name` AS Attribute_Name,
                aa.value AS Attribute_Value,
                aa.datatype,
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
            FROM
            ext_mssql_asset_vision_ven_gen7.dbo.asset a
            INNER JOIN ext_mssql_asset_vision_ven_gen7.dbo.assetattribute aa 
	    ON aa.assetid = a.id
            	WHERE
            	contract = 'Toowoomba Second Range Crossing'
            	AND a.assettype = "PCAS 100m Segments"
            	AND a.deleted = 'False'
            	AND a.stage = 'Active'
            	AND aa.deleted = 'False'
            	-- Exclude these as they will be joined in later to pivot
            	AND aa.`name` NOT IN ('Chainage Start','Chainage End','Lane','PCAS Survey Date')
            	--- Filter for only numeric data types
            	-- AND datatype = "Number"
        )
        --- Join in chainages, lane and survey date attribute as its only column to allow pivoting out
        -- Pivot on the pivotcol_name and pivotcol_val column to get chainage and lane data
        SELECT
            b.name AS pivotcol_name,
            b.value AS pivotcol_val,
            a.*
        FROM 
        assetjoined a
        -- join to get lane, start and end chainage to pivot
        LEFT JOIN (SELECT assetid,name,value FROM ext_mssql_asset_vision_ven_gen7.dbo.assetattribute
                    WHERE name IN ('Chainage Start','Chainage End','Lane','PCAS Survey Date')) b
        ON b.assetid = a.id
        )

        -- Select to Re-Arrange the columns
        SELECT
        parentassetcode,
        parentassetname,
        direction,
        CASE WHEN direction = "1 or 2" THEN "Westbound" ELSE "Eastbound" END AS Carriageway,
        `assetname`,
        CAST(`Start Chng` AS INT),
        CAST(`End Chng` AS INT),
        CONCAT(CAST(`Start Chng` AS INT)," - ", CAST(`End Chng` AS INT)) Chainage_Text,
        `Lane`,
        CASE WHEN `Lane` = "L1" THEN "Outer Lane" ELSE "Inner Lane" END AS Lane_Type,
        -- Survey Date
        `Survey Date`,
        CAST(RIGHT(LEFT(`Survey Date`,10),4) AS INT) AS `Survey Year`,
        CONCAT('PCAS - ',RIGHT(LEFT(`Survey Date`,10),4)) AS `Survey_Year_Text`,
        --- Attribute fields
        Attribute_Name,
        Attribute_Value,
        datatype AS Attribute_dtype,
        --- Asset Vision General
        `id` AS `AV_Asset_ID`,
        `code` AS `AV_Asset_Code`,
        deltautc,
        modifiedutc,
        modifieduser,
        contract,
        spatialtype,
        parentassetid,
        parentassettypename,
        stage,
        classification
        FROM assetpivot PIVOT (
        MAX(pivotcol_val)
        --- Pivots out new columns code reads as where value in pivotcol_name is X then name it AS Y
        --- e.g. where value in pivotcol_name is 'Chainage Start' pivot out into a column called `Start Chng`
        FOR pivotcol_name IN ('Lane' AS `Lane`,'Chainage Start' AS `Start Chng`,'Chainage End' AS `End Chng`,'PCAS Survey Date' AS `Survey Date`)
        )
        WHERE Attribute_Value <> '' OR Attribute_Value <> NULL
        ORDER BY code, Attribute_Name
    )
    --- UNION WITH OTHER STRIP MAP TABLES
    SELECT * FROM pcasfull
    --- Union with features
    UNION
    SELECT * FROM transport_dev.transport_tsrc.uvw_pcas_stripmap_ele_feature_singlelane
    --- Union with LPPC Static 1km defects
    UNION
    SELECT DISTINCT parentassetcode, parentassetname, direction, Carriageway, assetname, `Start Chng`,`End Chng`, `Chainage_Text`, Lane, Lane_Type,
                    `Survey Date`, `Survey Year`, CONCAT('PCAS - ',Survey_Year_Text) AS Survey_Year_Text, 'LPPC Defect - Static' AS Attribute_Name, LPPC_Defect_Static AS Attribute_Value,
                    'Text' AS Attribute_dtype, AV_Asset_ID, AV_Asset_Code, deltautc, modifiedutc, modifieduser, contract, spatialtype, parentassetid,
                    parentassettypename, stage, classification
    FROM transport_dev.transport_tsrc.uvw_pcas_numeric_data --- Update this table name
    --- Union with LPPC Static 1km defects excluding remaining life
    UNION
    SELECT DISTINCT parentassetcode, parentassetname, direction, Carriageway, assetname, `Start Chng`,`End Chng`, `Chainage_Text`, Lane, Lane_Type,
                    `Survey Date`, `Survey Year`, CONCAT('PCAS - ',Survey_Year_Text) AS Survey_Year_Text, 
                    'LPPC Defect - Static - Excl. RemLife' AS Attribute_Name, LPPC_Defect_Static_exclRemLife AS Attribute_Value,
                    'Text' AS Attribute_dtype, AV_Asset_ID, AV_Asset_Code, deltautc, modifiedutc, modifieduser, contract, spatialtype, parentassetid,
                    parentassettypename, stage, classification
    FROM transport_dev.transport_tsrc.uvw_pcas_numeric_data --- Update this table name

    --- Union with LPPC Rolling 1km defects
    UNION
    SELECT DISTINCT parentassetcode, parentassetname, direction, Carriageway, assetname, `Start Chng`,`End Chng`, `Chainage_Text`, Lane, Lane_Type,
                    `Survey Date`, `Survey Year`, CONCAT('PCAS - ',Survey_Year_Text) AS Survey_Year_Text, 'LPPC Defect - Rolling' AS Attribute_Name, LPPC_Defect_Rolling AS Attribute_Value,
                    'Text' AS Attribute_dtype, AV_Asset_ID, AV_Asset_Code, deltautc, modifiedutc, modifieduser, contract, spatialtype, parentassetid,
                    parentassettypename, stage, classification
    FROM transport_dev.transport_tsrc.uvw_pcas_numeric_data --- Update this table name
    --- Union with Capital Works
    UNION
    SELECT
        *
    FROM transport_dev.transport_tsrc.uvw_pcas_stripmap_ele_capworks_singlelane
    )

SELECT
    a.*,
    ---- LPPC Defects for filtering
    CASE WHEN a.Survey_Year_Text = 'All' THEN 'Show Static Field' ELSE b.LPPC_Defect_Static END AS LPPC_Defect_Static,
    CASE WHEN a.Survey_Year_Text = 'All' THEN 'Show Static Field' ELSE b.LPPC_Defect_Static_exclRemLife END AS LPPC_Defect_Static_exclRemLife,
    CASE WHEN a.Survey_Year_Text = 'All' THEN 'Show Static Field' ELSE b.LPPC_Defect_Rolling END AS LPPC_Defect_Rolling,
    CASE WHEN a.Survey_Year_Text = 'All' THEN 'Show Static Field' ELSE b.LPPC_Defect_Rolling_exclRemLife END AS LPPC_Defect_Rolling_exclRemLife,
    ---- Capital Works for filtering
    CASE WHEN a.Survey_Year_Text = 'All' THEN 'Show Static Field' ELSE c.Attribute_Name END AS CapWorks_All,
    CASE WHEN a.Survey_Year_Text = 'All' THEN 'Show Static Field' ELSE d.Attribute_Name END AS CapWorks_2023
FROM pcasunioned a
--- Left Join with numeric data pivoted to get the LPPC defect Columns
LEFT JOIN transport_dev.transport_tsrc.uvw_pcas_numeric_data_pivotted b
ON a.assetname = b.assetname AND a.`Survey Year` = b.`Survey Year`
--- Left Join with capital works to bring across the treatments
LEFT JOIN  (SELECT * FROM transport_dev.transport_tsrc.uvw_pcas_stripmap_ele_capworks_singlelane
            WHERE Attribute_Name NOT LIKE '%Length Treated%') c
ON a.assetname = c.assetname AND a.`Survey Year` = c.`Survey Year`
--- Left Join with capital works to bring across the treatments for 2023
LEFT JOIN (SELECT * FROM transport_dev.transport_tsrc.uvw_pcas_stripmap_ele_capworks_singlelane
           WHERE `Survey Year` = 2023 AND Attribute_Name NOT LIKE '%Length Treated%') d
ON a.assetname = d.assetname
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
| `Lane_Type` | `string` | Yes |  |
| `Survey Date` | `string` | Yes |  |
| `Survey Year` | `int` | Yes |  |
| `Survey_Year_Text` | `string` | Yes |  |
| `Attribute_Name` | `string` | Yes |  |
| `Attribute_Value` | `string` | Yes |  |
| `Attribute_dtype` | `string` | Yes |  |
| `AV_Asset_ID` | `int` | Yes |  |
| `AV_Asset_Code` | `string` | Yes |  |
| `deltautc` | `string` | Yes |  |
| `modifiedutc` | `string` | Yes |  |
| `modifieduser` | `string` | Yes |  |
| `contract` | `string` | Yes |  |
| `spatialtype` | `string` | Yes |  |
| `parentassetid` | `int` | Yes |  |
| `parentassettypename` | `string` | Yes |  |
| `stage` | `string` | Yes |  |
| `classification` | `string` | Yes |  |
| `LPPC_Defect_Static` | `string` | Yes |  |
| `LPPC_Defect_Static_exclRemLife` | `string` | Yes |  |
| `LPPC_Defect_Rolling` | `string` | Yes |  |
| `LPPC_Defect_Rolling_exclRemLife` | `string` | Yes |  |
| `CapWorks_All` | `string` | Yes |  |
| `CapWorks_2023` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
