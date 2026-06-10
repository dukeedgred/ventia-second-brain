---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: uvw_pcas_stripmap_ele_feature_singlelane
full-name: transport_dev.transport_tsrc.uvw_pcas_stripmap_ele_feature_singlelane
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - uvw_pcas_stripmap_ele_feature_singlelane

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_pcas_stripmap_ele_feature_singlelane` |
| Full name | `transport_dev.transport_tsrc.uvw_pcas_stripmap_ele_feature_singlelane` |
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
| Refresh/freshness | Created: 2024-07-24T00:27:14.306Z; Last altered: 2024-07-31T23:24:53.121Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
WITH asset_created AS (
    WITH assetpivot AS (
        WITH assetjoined AS (
            SELECT
                --- Attributes used to Unpivot
                a.parentassetcode,
                a.parentassetname,
                a.direction,
                CASE WHEN direction = "1 or 2" THEN "Westbound" ELSE "Eastbound" END AS Carriageway,
                a.chainagefrom,
                a.chainageto,
                --- Columns to Keep
                att.`name` AS Attribute_Name,
                att.value AS Attribute_Value,
                att.datatype AS Attribute_dtype,
                a.`id` AS `AV_Asset_ID`,
                a.`code` AS `AV_Asset_Code`,
                a.deltautc,
                a.modifiedutc,
                a.modifieduser,
                a.contract,
                a.spatialtype,
                a.parentassetid,
                a.parentassettypename,
                a.stage,
                a.classification
            FROM ext_mssql_asset_vision_ven_gen7.dbo.asset a
            inner join ext_mssql_asset_vision_ven_gen7.dbo.assetattribute att on att.assetid = a.id
            where
            contract = 'Toowoomba Second Range Crossing'
            --- Asset table to stack against strip map
            AND a.assettype = "Strip Map - Geometric Features"
            AND a.deleted = 'False'
            AND a.stage = 'Active'
            AND att.deleted = 'False'
            -- Exclude these as they will be joined in later to pivot
            AND att.`name` NOT IN ('Lane Affected','Structure Over Freeway','Comments')
        )
        --- Join in chainages, lane and survey date attribute as its only column to allow pivoting out
        SELECT
            b.name AS pivotcol_name,
            b.value AS pivotcol_val,
            a.*
        FROM 
        assetjoined a
        -- join to get lane, start and end chainage to pivot
        LEFT JOIN (SELECT assetid,name,value FROM ext_mssql_asset_vision_ven_gen7.dbo.assetattribute
                    WHERE name IN ('Lane Affected')) b
        ON b.assetid = a.AV_Asset_ID
    )
    SELECT
        *,
        CASE WHEN Lane = 'L1 - Outer Lane' THEN 'L1'
             WHEN Lane = 'L2 - Inner Lane' THEN 'L2'
             ELSE 'L1'
        END AS Lane_join
    FROM assetpivot PIVOT (
    MAX(pivotcol_val)
    --- Pivots out new columns code reads as where value in pivotcol_name is X then name it AS Y
    --- e.g. where value in pivotcol_name is 'Chainage Start' pivot out into a column called `Start Chng`
    FOR pivotcol_name IN ('Lane Affected' AS `Lane`)
    )
    WHERE Attribute_Value <> '' OR Attribute_Value <> NULL 
    -- Don't include those that affect both lanes do those in anotehr separate join
    AND Lane <> 'Both'
    ORDER BY AV_Asset_Code, Attribute_Name
)
--- Left joined against the PCAS Numbers Strip Map
SELECT
    --- Location referencing fields
    b.parentassetcode,
    a.parentassetname,
    b.direction,
    a.Carriageway,
    b.assetname,
    b.`Start Chng`,
    b.`End Chng`,
    b.Chainage_Text,
    b.Lane,
    b.Lane_Type,
    --- Survey Date feilds
    '1/09/1900 00:00:00' AS `Survey Date`, 
    1900 AS `Survey Year`,
    'All' AS Survey_Year_Text,
    --- Attribute Fields
    a.Attribute_Name,
    a.Attribute_Value,
    a.Attribute_dtype,
    a.AV_Asset_ID,
    a.AV_Asset_Code,
    a.deltautc,
    a.modifiedutc,
    a.modifieduser,
    a.contract,
    a.spatialtype,
    a.parentassetid,
    a.parentassettypename,
    a.stage,
    a.classification
FROM asset_created a
--- Left joined against the PCAS Numbers Strip Map
LEFT JOIN (SELECT DISTINCT parentassetcode, direction, assetname, `Start Chng`, `End Chng`, Chainage_Text,Lane, Lane_Type
           FROM transport_dev.transport_tsrc.uvw_pcas_numeric_data) b --- Need to Update table
ON a.parentassetcode = b.parentassetcode AND a.direction = b.direction AND a.Lane_join = b.Lane AND b.`Start Chng` < a.chainageto AND  b.`End Chng` > a.chainagefrom
ORDER BY b.`Start Chng`,`Survey Year`
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
| `Survey Date` | `string` | No |  |
| `Survey Year` | `int` | No |  |
| `Survey_Year_Text` | `string` | No |  |
| `Attribute_Name` | `string` | Yes |  |
| `Attribute_Value` | `string` | Yes |  |
| `Attribute_dtype` | `string` | Yes |  |
| `AV_Asset_ID` | `int` | Yes |  |
| `AV_Asset_Code` | `string` | Yes |  |
| `deltautc` | `timestamp` | Yes |  |
| `modifiedutc` | `timestamp` | Yes |  |
| `modifieduser` | `string` | Yes |  |
| `contract` | `string` | Yes |  |
| `spatialtype` | `string` | Yes |  |
| `parentassetid` | `int` | Yes |  |
| `parentassettypename` | `string` | Yes |  |
| `stage` | `string` | Yes |  |
| `classification` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
