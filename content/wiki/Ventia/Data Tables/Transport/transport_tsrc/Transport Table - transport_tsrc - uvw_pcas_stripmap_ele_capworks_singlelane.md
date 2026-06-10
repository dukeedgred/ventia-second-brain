---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: uvw_pcas_stripmap_ele_capworks_singlelane
full-name: transport_dev.transport_tsrc.uvw_pcas_stripmap_ele_capworks_singlelane
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - uvw_pcas_stripmap_ele_capworks_singlelane

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_pcas_stripmap_ele_capworks_singlelane` |
| Full name | `transport_dev.transport_tsrc.uvw_pcas_stripmap_ele_capworks_singlelane` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | VIEW |
| Column count | 27 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | lane access |
| Owner/SME | hui.chen@ventia.com |
| Refresh/freshness | Created: 2024-07-30T00:43:31.443Z; Last altered: 2024-07-31T23:24:49.699Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
WITH cw_union_distinct AS (
    WITH cwjoined_singlelane_pivotted_len AS (
        WITH cwjoined_singlelane_pivotted AS (
            WITH cwjoined_singlelane AS (
                SELECT
                a.id AS `Parent_Task_ID`,
                a.name AS `Parent_Task_Name`,
                a.description AS `Parent_Task_Desc`,
                a.capitalworktype AS `Parent_Task_Type`,
                a.WKT AS `Parent_Task_WKT`,
                b.id AS `Child_Task_ID`,
                b.name AS `Child_Task_Name`,
                b.description AS `Child_Task_Desc`,
                to_timestamp(b.actualstart) AS `Task_StartDate`,
                to_timestamp(b.actualfinish) AS `Task_EndDate`,
                b.assetid,
                b.assetcode,
                b.assetname,
                b.direction,
                CASE WHEN b.direction = '1 or 2' THEN 'Westbound'
                    WHEN b.direction = '3' THEN 'Eastbound'
                    ELSE 'Westbound'
                END AS Carriageway,
                b.chainagefrom,
                b.chainageto,
                b.WKT AS `Child_Task_WKT`,
                c.name AS `Form_Field_Name`,
                c.value AS `Form_Field_Value`
                FROM
                --- Select statement for Parent capital work task as main table
                (SELECT
                * 
                FROM ext_mssql_asset_vision_ven_gen7.dbo.vcapitalwork
                WHERE Contract = 'Toowoomba Second Range Crossing'
                    AND capitalworktype = 'Pavement Lifecycle Works'
                    AND deleted = FALSE) a
                LEFT JOIN 
                --- Select statement for Child tasks to join to main table
                (SELECT
                *
                FROM ext_mssql_asset_vision_ven_gen7.dbo.vcapitalworktask
                Where deleted = FALSE
                    AND actualfinish IS NOT NULL) b
                ON a.id = b.capitalworkid
                --- Select statement Child task form fields to join to main table
                LEFT JOIN 
                (SELECT
                *
                FROM ext_mssql_asset_vision_ven_gen7.dbo.formfield
                WHERE sourcetable = 'CapitalWorkTask'
                    AND deleted = FALSE
                    AND name IN ('Work Summary|Road Lane','Work Summary|PCAS Year')
                    AND value NOT IN ('Both Lanes','Left Shoulder','Right Shoulder','Chevron')) c
                ON c.sourcetableid = b.id

            )   -------- END FIRST TMP TABLE

            SELECT
                *,
                --- Convert the pivotted lane column into standardised naming
                CASE WHEN Lane = 'L1 - Outer Lane (Pick this for Single)' THEN 'L1'
                     WHEN Lane = 'L2 - Inner Lane' THEN 'L2'
                     ELSE 'No Data'
                END AS Lane_Join,
                CAST(`PCAS Year` AS INT) AS `PCAS_Year_Int`
            --- Pivots the lane and year out 
            FROM cwjoined_singlelane PIVOT (
            MAX(Form_Field_Value)
            --- Pivots out new columns code reads as where value in pivotcol_name is X then name it AS Y
            --- e.g. where value in pivotcol_name is 'Chainage Start' pivot out into a column called `Start Chng`
            FOR Form_Field_Name IN ('Work Summary|Road Lane' AS `Lane`, 'Work Summary|PCAS Year' AS `PCAS Year`)
            )
        )

        --- Merge with 100m segments and calculate total length treated
        SELECT 
        a.*,
        d.assetname AS Seg_100m_assetname,
        d.`Start Chng`,
        d.`End Chng`,
        d.Chainage_Text,
        d.Lane_Type,
        CASE WHEN a.chainagefrom <= d.`Start Chng` AND a.chainageto >= d.`End Chng` THEN d.`End Chng` - d.`Start Chng` -- when treatment covers the whole 100m segment
             WHEN a.chainagefrom <= d.`Start Chng` AND a.chainageto <= d.`End Chng` THEN a.chainageto - d.`Start Chng` -- treatment starts outside and ends inside the 100m segment
             WHEN a.chainagefrom >= d.`Start Chng` AND a.chainageto >= d.`End Chng` THEN d.`End Chng` - a.chainagefrom -- treatment starts inside and ends outside the 100m segment
             WHEN a.chainagefrom >= d.`Start Chng` AND a.chainageto <= d.`End Chng` THEN a.chainageto - a.chainagefrom -- treatment is within the 100m segment
             ELSE 0
        END AS len_treated
        FROM cwjoined_singlelane_pivotted a 
        --- Left joined against the PCAS Numbers Strip Map
        LEFT JOIN (SELECT DISTINCT parentassetcode, direction, assetname, `Start Chng`, `End Chng`, Chainage_Text,Lane, Lane_Type
                    FROM transport_dev.transport_tsrc.uvw_pcas_numeric_data) d --- Need to update table
        ON a.assetcode = d.parentassetcode AND a.direction = d.direction AND a.Lane_Join = d.Lane AND d.`Start Chng` < a.chainageto AND  d.`End Chng` > a.chainagefrom
        WHERE d.assetname IS NOT NULL
    )
    --- Table that shows all unique task names done on the network
    SELECT
        assetcode AS parentassetcode,
        assetname AS parentassetname,
        direction,
        Carriageway,
        Seg_100m_assetname AS assetname,
        `Start Chng`,
        `End Chng`,
        Chainage_Text,
        Lane_Join AS Lane,
        Lane_Type,
        Task_EndDate AS `Survey Date`,
        PCAS_Year_Int AS `Survey Year`,
        CONCAT('CapWorks - ',`PCAS Year`,'/',CAST(PCAS_Year_Int+1 AS STRING)) AS `Survey_Year_Text`,
        -- Main Variables to change
        Child_Task_Name AS Attribute_Name,
        Child_Task_Name AS Attribute_Value, -- Update to Child_Task_Desc once updates
        -- Hardcoded fields
        'Text' AS Attribute_dtype,
        assetid AS AV_Asset_ID,
        assetcode AS AV_Asset_Code,
        '1/09/1900 00:00:00' AS deltautc,
        '1/09/1900 00:00:00' AS modifiedutc,
        'VEN - None' AS modifieduser,
        'Toowoomba Second Range Crossing' AS contract,
        'Polyline' AS spatialtype,
        assetid AS parentassetid,
        'Road' AS parentassettypename,
        'Active' AS stage,
        'T7' AS classification
    FROM cwjoined_singlelane_pivotted_len

    --- Get Capital Works Parent IDs
    UNION

    SELECT
        assetcode AS parentassetcode,
        assetname AS parentassetname,
        direction,
        Carriageway,
        Seg_100m_assetname AS assetname,
        `Start Chng`,
        `End Chng`,
        Chainage_Text,
        Lane_Join AS Lane,
        Lane_Type,
        Task_EndDate AS `Survey Date`,
        PCAS_Year_Int AS `Survey Year`,
        CONCAT('CapWorks - ',`PCAS Year`,'/',CAST(PCAS_Year_Int+1 AS STRING)) AS `Survey_Year_Text`,
        -- Main Variables to change
        CONCAT(Child_Task_Name,'_Link') AS Attribute_Name,
        CONCAT('https://gen7.assetvision.com.au/CapitalWorks/ViewCapitalWork/',Parent_Task_ID) AS Attribute_Value, -- Update to Child_Task_Desc once updates
        -- Hardcoded fields
        'Text' AS Attribute_dtype,
        assetid AS AV_Asset_ID,
        assetcode AS AV_Asset_Code,
        '1/09/1900 00:00:00' AS deltautc,
        '1/09/1900 00:00:00' AS modifiedutc,
        'VEN - None' AS modifieduser,
        'Toowoomba Second Range Crossing' AS contract,
        'Polyline' AS spatialtype,
        assetid AS parentassetid,
        'Road' AS parentassettypename,
        'Active' AS stage,
        'T7' AS classification
    FROM cwjoined_singlelane_pivotted_len

    --- Get Capital Works Child Task IDs
    UNION

    SELECT
        assetcode AS parentassetcode,
        assetname AS parentassetname,
        direction,
        Carriageway,
        Seg_100m_assetname AS assetname,
        `Start Chng`,
        `End Chng`,
        Chainage_Text,
        Lane_Join AS Lane,
        Lane_Type,
        Task_EndDate AS `Survey Date`,
        PCAS_Year_Int AS `Survey Year`,
        CONCAT('CapWorks - ',`PCAS Year`,'/',CAST(PCAS_Year_Int+1 AS STRING)) AS `Survey_Year_Text`,
        -- Main Variables to change
        CONCAT(Child_Task_Name,'_ChildID') AS Attribute_Name,
        Child_Task_ID AS Attribute_Value, -- Update to Child_Task_Desc once updates
        -- Hardcoded fields
        'Text' AS Attribute_dtype,
        assetid AS AV_Asset_ID,
        assetcode AS AV_Asset_Code,
        '1/09/1900 00:00:00' AS deltautc,
        '1/09/1900 00:00:00' AS modifiedutc,
        'VEN - None' AS modifieduser,
        'Toowoomba Second Range Crossing' AS contract,
        'Polyline' AS spatialtype,
        assetid AS parentassetid,
        'Road' AS parentassettypename,
        'Active' AS stage,
        'T7' AS classification
    FROM cwjoined_singlelane_pivotted_len
    --- Union with Capital Works that gets length treated for : PAVMILFIL - Pavement Repairs - Mill and Fill
    UNION

    SELECT
        assetcode AS parentassetcode,
        assetname AS parentassetname,
        direction,
        Carriageway,
        Seg_100m_assetname AS assetname,
        `Start Chng`,
        `End Chng`,
        Chainage_Text,
        Lane_Join AS Lane,
        Lane_Type,
        Task_EndDate AS `Survey Date`,
        PCAS_Year_Int AS `Survey Year`,
        CONCAT('CapWorks - ',`PCAS Year`,'/',CAST(PCAS_Year_Int+1 AS STRING)) AS `Survey_Year_Text`,
        -- Main Variables to change
        'PAVMILFIL - Length Treated' AS Attribute_Name,
        (SELECT SUM(len_treated) FROM cwjoined_singlelane_pivotted_len 
        WHERE Seg_100m_assetname = a.Seg_100m_assetname 
            AND PCAS_Year_Int = a.PCAS_Year_Int
            AND Child_Task_Name = a.Child_Task_Name) AS Attribute_Value,
        -- Hardcoded fields
        'Number' AS Attribute_dtype,
        assetid AS AV_Asset_ID,
        assetcode AS AV_Asset_Code,
        '1/09/1900 00:00:00' AS deltautc,
        '1/09/1900 00:00:00' AS modifiedutc,
        'VEN - None' AS modifieduser,
        'Toowoomba Second Range Crossing' AS contract,
        'Polyline' AS spatialtype,
        assetid AS parentassetid,
        'Road' AS parentassettypename,
        'Active' AS stage,
        'T7' AS classification
    FROM cwjoined_singlelane_pivotted_len a
    WHERE a.Child_Task_Name = 'PAVMILFIL - Pavement Repairs - Mill and Fill'

    ---Union with Capital Works that gets length treated for : PAVTEXWBLAST - Retexturising - Water Blasting
    UNION

    SELECT
        assetcode AS parentassetcode,
        assetname AS parentassetname,
        direction,
        Carriageway,
        Seg_100m_assetname AS assetname,
        `Start Chng`,
        `End Chng`,
        Chainage_Text,
        Lane_Join AS Lane,
        Lane_Type,
        Task_EndDate AS `Survey Date`,
        PCAS_Year_Int AS `Survey Year`,
        CONCAT('CapWorks - ',`PCAS Year`,'/',CAST(PCAS_Year_Int+1 AS STRING)) AS `Survey_Year_Text`,
        -- Main Variables to change
        'PAVTEXWBLAST - Length Treated' AS Attribute_Name,
        (SELECT SUM(len_treated) FROM cwjoined_singlelane_pivotted_len 
        WHERE Seg_100m_assetname = a.Seg_100m_assetname 
            AND PCAS_Year_Int = a.PCAS_Year_Int
            AND Child_Task_Name = a.Child_Task_Name) AS Attribute_Value,
        -- Hardcoded fields
        'Number' AS Attribute_dtype,
        assetid AS AV_Asset_ID,
        assetcode AS AV_Asset_Code,
        '1/09/1900 00:00:00' AS deltautc,
        '1/09/1900 00:00:00' AS modifiedutc,
        'VEN - None' AS modifieduser,
        'Toowoomba Second Range Crossing' AS contract,
        'Polyline' AS spatialtype,
        assetid AS parentassetid,
        'Road' AS parentassettypename,
        'Active' AS stage,
        'T7' AS classification
    FROM cwjoined_singlelane_pivotted_len a
    WHERE a.Child_Task_Name = 'PAVTEXWBLAST - Retexturising - Water Blasting'

    --- Union with Capital Works that gets length treated for : PAVCRACK - Cracking repairs
    UNION

    SELECT
        assetcode AS parentassetcode,
        assetname AS parentassetname,
        direction,
        Carriageway,
        Seg_100m_assetname AS assetname,
        `Start Chng`,
        `End Chng`,
        Chainage_Text,
        Lane_Join AS Lane,
        Lane_Type,
        Task_EndDate AS `Survey Date`,
        PCAS_Year_Int AS `Survey Year`,
        CONCAT('CapWorks - ',`PCAS Year`,'/',CAST(PCAS_Year_Int+1 AS STRING)) AS `Survey_Year_Text`,
        -- Main Variables to change
        'PAVCRACK - Length Treated' AS Attribute_Name,
        (SELECT SUM(len_treated) FROM cwjoined_singlelane_pivotted_len 
        WHERE Seg_100m_assetname = a.Seg_100m_assetname 
            AND PCAS_Year_Int = a.PCAS_Year_Int
            AND Child_Task_Name = a.Child_Task_Name) AS Attribute_Value,
        -- Hardcoded fields
        'Number' AS Attribute_dtype,
        assetid AS AV_Asset_ID,
        assetcode AS AV_Asset_Code,
        '1/09/1900 00:00:00' AS deltautc,
        '1/09/1900 00:00:00' AS modifiedutc,
        'VEN - None' AS modifieduser,
        'Toowoomba Second Range Crossing' AS contract,
        'Polyline' AS spatialtype,
        assetid AS parentassetid,
        'Road' AS parentassettypename,
        'Active' AS stage,
        'T7' AS classification
    FROM cwjoined_singlelane_pivotted_len a
    WHERE a.Child_Task_Name = 'PAVCRACK - Cracking repairs'

    )

    SELECT
    DISTINCT *
    FROM cw_union_distinct
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
| `Lane` | `string` | No |  |
| `Lane_Type` | `string` | Yes |  |
| `Survey Date` | `timestamp` | Yes |  |
| `Survey Year` | `int` | Yes |  |
| `Survey_Year_Text` | `string` | Yes |  |
| `Attribute_Name` | `string` | Yes |  |
| `Attribute_Value` | `string` | Yes |  |
| `Attribute_dtype` | `string` | No |  |
| `AV_Asset_ID` | `int` | Yes |  |
| `AV_Asset_Code` | `string` | Yes |  |
| `deltautc` | `string` | No |  |
| `modifiedutc` | `string` | No |  |
| `modifieduser` | `string` | No |  |
| `contract` | `string` | No |  |
| `spatialtype` | `string` | No |  |
| `parentassetid` | `int` | Yes |  |
| `parentassettypename` | `string` | No |  |
| `stage` | `string` | No |  |
| `classification` | `string` | No |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
