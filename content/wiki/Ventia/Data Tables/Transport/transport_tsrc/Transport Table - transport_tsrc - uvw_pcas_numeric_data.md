---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: uvw_pcas_numeric_data
full-name: transport_dev.transport_tsrc.uvw_pcas_numeric_data
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - uvw_pcas_numeric_data

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_pcas_numeric_data` |
| Full name | `transport_dev.transport_tsrc.uvw_pcas_numeric_data` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | VIEW |
| Column count | 43 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | capital works / forward works |
| Owner/SME | hui.chen@ventia.com |
| Refresh/freshness | Created: 2024-07-28T22:49:07.996Z; Last altered: 2024-07-31T23:24:50.871Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
WITH lppc_calc AS (
    WITH final_calc AS (
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
                    inner join ext_mssql_asset_vision_ven_gen7.dbo.assetattribute aa on aa.assetid = a.id
                where
                    contract = 'Toowoomba Second Range Crossing'
                    AND a.assettype = "PCAS 100m Segments"
                    AND a.deleted = 'False'
                    AND a.stage = 'Active'
                    AND aa.deleted = 'False'
                    -- Exclude these as they will be joined in later to pivot
                    AND aa.`name` NOT in ('Chainage Start','Chainage End','Lane','PCAS Survey Date','Surfacing Material Type','Speed Limit','D&C Control or Defect')
                    --- Filter for only numeric data types
                    AND aa.datatype = "Number"
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
                        WHERE name IN ('Chainage Start','Chainage End','Lane','PCAS Survey Date','Surfacing Material Type','Speed Limit', 'D&C Control or Defect')) b
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
                -- PCAS Grouping
                `Surface Type`,
                `Speed Limit`,
                DnC_Defect,
                CASE WHEN `Surface Type` IS NULL OR DnC_Defect = 'YES' THEN 'Out of Network'
                     WHEN `Surface Type` <> '' AND parentassetname ='Toowoomba Second Range Crossing' THEN `Surface Type` ELSE 'Ramp'
                END AS `Network Group`,
                -- Survey Date
                `Survey Date`,
                CAST(RIGHT(LEFT(`Survey Date`,10),4) AS INT) AS `Survey Year`,
                RIGHT(LEFT(`Survey Date`,10),4) AS `Survey_Year_Text`,
                --- Attribute fields
                Attribute_Name,
                CAST(Attribute_Value AS FLOAT) AS Attribute_Value,
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
                FOR pivotcol_name IN ('Lane' AS `Lane`,'Chainage Start' AS `Start Chng`,'Chainage End' AS `End Chng`,'PCAS Survey Date' AS `Survey Date`,
                                    'Surfacing Material Type' AS `Surface Type`,'Speed Limit' AS `Speed Limit`, 'D&C Control or Defect' AS `DnC_Defect`)
                )
            WHERE Attribute_Value <> '' OR Attribute_Value <> NULL
            ORDER BY code, Attribute_Name
    )
    --- Calculate whether the section has passed or fail the PCAS assessment
    SELECT
        *,
        CASE WHEN Attribute_Value = -99 OR Attribute_Value IS NULL OR Attribute_Value IS NULL THEN 'No Data'
            WHEN Attribute_Name = 'Roughness (NAASRA/km)' THEN
                -- Set the pass/fail criteria
                CASE WHEN `Network Group` = 'Ramp' AND Attribute_Value >100 THEN 'Fail'
                    WHEN `Network Group` <> 'Ramp' AND Attribute_Value >80 THEN 'Fail'
                    ELSE 'Pass' END
            WHEN Attribute_Name = 'Rutting (Driver) 80th Percentile (mm)' OR Attribute_Name = 'Rutting (Passenger) 80th Percentile (mm)' THEN
                CASE WHEN `Network Group` = 'Asphalt' AND Attribute_Value >=12 THEN 'Fail'
                    WHEN `Network Group` <> 'Asphalt' AND Attribute_Value >=15 THEN 'Fail'
                    ELSE 'Pass' END
            WHEN Attribute_Name = 'Total Cracking (%)' THEN
                CASE WHEN Attribute_Value >=4 THEN 'Fail'
                    ELSE 'Pass' END
            WHEN Attribute_Name = 'Longitudinal Cracking (m)' THEN
                CASE WHEN Attribute_Value >=5 THEN 'Fail'
                    ELSE 'Pass' END
            WHEN Attribute_Name = 'Texture (Center) (SPTD) (mm)' OR Attribute_Name = 'Texture (Driver) (SPTD) (mm)' OR Attribute_Name = 'Texture (Passenger) (SPTD) (mm)' THEN
                CASE WHEN `Speed Limit` ='<=80 Km' AND Attribute_Value <=0.4 THEN 'Fail'
                    WHEN `Speed Limit` ='>80 Km' AND Attribute_Value <=1.0 THEN 'Fail' -- As all surfaces are either SS or SMA there is no DGA on network
                    ELSE 'Pass' END
            WHEN Attribute_Name = 'SFC (Driver)' OR Attribute_Name = 'SFC (Passenger)' THEN
                CASE WHEN `Network Group` = 'Ramp' AND Attribute_Value <=40 THEN 'Fail' -- Ramps Req. IL is 50 and KPI allows 10 below the IL
                    WHEN `Network Group` <> 'Ramp' AND Attribute_Value <=25 THEN 'Fail' -- Main alignment Req. IL is 35 and KPI allows 10 below the IL
                    ELSE 'Pass' END
            WHEN Attribute_Name = 'Ravelling (%)' THEN
                CASE WHEN Attribute_Value >=10 THEN 'Fail'
                    ELSE 'Pass' END
            WHEN Attribute_Name = 'Remaining Life - Conforming' THEN --- Conforming method not used to calculate defects
                CASE WHEN Attribute_Value <=5 THEN 'Pass'
                    ELSE 'Pass' END
            WHEN Attribute_Name = 'Remaining Life - Alternate' THEN
                CASE WHEN Attribute_Value <=5 THEN 'Fail'
                    ELSE 'Pass' END
            ELSE 'No Data'
        END AS PCAS_Pass_Fail,
	--- Calculate condition assessment
        CASE WHEN Attribute_Value = -99 OR Attribute_Value = '' OR Attribute_Value IS NULL THEN 'No Data'
             WHEN Attribute_Name = 'Roughness (NAASRA/km)' THEN
                  -- Set the pass/fail criteria
                  CASE WHEN `Network Group` = 'Ramp' AND Attribute_Value <=60 THEN 'Very Good'
                       WHEN `Network Group` = 'Ramp' AND Attribute_Value <=80 THEN 'Good'
                       WHEN `Network Group` = 'Ramp' AND Attribute_Value <=100 THEN 'Fair'
                       WHEN `Network Group` <> 'Ramp' AND Attribute_Value <=40 THEN 'Very Good'
                       WHEN `Network Group` <> 'Ramp' AND Attribute_Value <=60 THEN 'Good'
                       WHEN `Network Group` <> 'Ramp' AND Attribute_Value <=80 THEN 'Fair'
                       ELSE 'Failed' END
             WHEN Attribute_Name = 'Rutting (Driver) 80th Percentile (mm)' OR Attribute_Name = 'Rutting (Passenger) 80th Percentile (mm)' THEN
                  CASE WHEN `Network Group` = 'Asphalt' AND Attribute_Value <=2 THEN 'Very Good'
                       WHEN `Network Group` = 'Asphalt' AND Attribute_Value <=6 THEN 'Good'
                       WHEN `Network Group` = 'Asphalt' AND Attribute_Value <12 THEN 'Fair'
                       WHEN `Network Group` <> 'Asphalt' AND Attribute_Value <=5 THEN 'Very Good'
                       WHEN `Network Group` <> 'Asphalt' AND Attribute_Value <=10 THEN 'Good'
                       WHEN `Network Group` <> 'Asphalt' AND Attribute_Value <15 THEN 'Fair'
                       ELSE 'Failed' END
             WHEN Attribute_Name = 'Total Cracking (%)' THEN
                  CASE WHEN Attribute_Value =0 THEN 'Very Good'
                       WHEN Attribute_Value <=2 THEN 'Good'
                       WHEN Attribute_Value <4 THEN 'Fair'
                       ELSE 'Failed' END
             WHEN Attribute_Name = 'Longitudinal Cracking (m)' THEN
                  CASE WHEN Attribute_Value =0 THEN 'Very Good'
                       WHEN Attribute_Value <=3 THEN 'Good'
                       WHEN Attribute_Value <5 THEN 'Fair'
                       ELSE 'Failed' END
             WHEN Attribute_Name = 'Texture (Center) (SPTD) (mm)' OR Attribute_Name = 'Texture (Driver) (SPTD) (mm)' OR Attribute_Name = 'Texture (Passenger) (SPTD) (mm)' THEN
                  CASE WHEN `Speed Limit` ='<=80 Km' AND Attribute_Value >=1.2 THEN 'Very Good'
                       WHEN `Speed Limit` ='<=80 Km' AND Attribute_Value >=0.8 THEN 'Good'
                       WHEN `Speed Limit` ='<=80 Km' AND Attribute_Value >0.4 THEN 'Fair'
                       WHEN `Speed Limit` ='>80 Km' AND Attribute_Value >=2.0 THEN 'Very Good' -- As all surfaces are either SS or SMA there is no DGA on network
                       WHEN `Speed Limit` ='>80 Km' AND Attribute_Value >=1.5 THEN 'Good'
                       WHEN `Speed Limit` ='>80 Km' AND Attribute_Value >1.0 THEN 'Fair'
                       ELSE 'Failed' END
             WHEN Attribute_Name = 'SFC (Driver)' OR Attribute_Name = 'SFC (Passenger)' THEN
                  CASE WHEN `Network Group` = 'Ramp' AND Attribute_Value >=60 THEN 'Very Good' -- Ramps Req. IL is 50 and KPI allows 10 below the IL
                       WHEN `Network Group` = 'Ramp' AND Attribute_Value >=50 THEN 'Good'
                       WHEN `Network Group` = 'Ramp' AND Attribute_Value >40 THEN 'Fair'
                       WHEN `Network Group` <> 'Ramp' AND Attribute_Value >=50 THEN 'Very Good' -- Main alignment Req. IL is 35 and KPI allows 10 below the IL
                       WHEN `Network Group` <> 'Ramp' AND Attribute_Value >=35 THEN 'Good'
                       WHEN `Network Group` <> 'Ramp' AND Attribute_Value >25 THEN 'Fair' 
                       ELSE 'Failed' END
             WHEN Attribute_Name = 'Ravelling (%)' THEN
                  CASE WHEN Attribute_Value <=2 THEN 'Very Good'
                       WHEN Attribute_Value <=6 THEN 'Good'
                       WHEN Attribute_Value <10 THEN 'Fair'
                       ELSE 'Failed' END
             WHEN Attribute_Name = 'Remaining Life - Conforming' THEN --- Conforming method not used to calculate defects
                  CASE WHEN Attribute_Value >=25 THEN 'Very Good'
                       WHEN Attribute_Value >15 THEN 'Good'
                       WHEN Attribute_Value >5 THEN 'Fair'
                       ELSE 'Failed' END
             WHEN Attribute_Name = 'Remaining Life - Alternate' THEN
                  CASE WHEN Attribute_Value >=25 THEN 'Very Good'
                       WHEN Attribute_Value >15 THEN 'Good'
                       WHEN Attribute_Value >5 THEN 'Fair'
                       ELSE 'Failed' END
            ELSE 'No Data'
        END AS Condition_Rating
    FROM final_calc
)

SELECT
  *,
  FLOOR(`Start Chng`,-3) AS Static_1km_Start, -- Rounded down to nearest 1000s
  CEILING(`End Chng`,-3) AS Static_1km_End,
  --- Check if the 100m segment itslef is a defect
  CASE WHEN
  (SELECT COUNT(DISTINCT assetname) FROM lppc_calc
   WHERE assetname = a.assetname
   AND `Survey Year` = a.`Survey Year` -- Same Year
   AND PCAS_Pass_Fail = 'Fail') > 0 THEN 'Yes' ELSE 'No'
  END AS Defect_100m,
  --- Check if the 100m segment itslef is a defect
  CASE WHEN
  (SELECT COUNT(DISTINCT assetname) FROM lppc_calc
   WHERE assetname = a.assetname
   AND `Survey Year` = a.`Survey Year` -- Same Year
   AND Attribute_Name NOT IN ('Remaining Life - Alternate','Remaining Life - Confirming','Remaining Life - Conforming')
   AND PCAS_Pass_Fail = 'Fail') > 0 THEN 'Yes' ELSE 'No'
  END AS Defect_100m_exclRemLife,
  --- Count of how many 100m segments are defects within the 1km section
  (SELECT count(DISTINCT assetname) FROM lppc_calc
    WHERE `Survey Year` = a.`Survey Year` -- Same Year
    AND parentassetcode = a.parentassetcode -- Same Road
    AND Carriageway = a.Carriageway -- Same direction
    AND Lane = a.Lane -- Same Lane
    AND PCAS_Pass_Fail = 'Fail'
    AND `Start Chng` >= FLOOR(a.`Start Chng`,-3)
    AND `End Chng` <= CEILING(a.`End Chng`,-3)) AS LPPC_Def_Count_Static,
  --- Count of how many 100m segments are defects within the 1km section
  (SELECT count(DISTINCT assetname) FROM lppc_calc
    WHERE `Survey Year` = a.`Survey Year` -- Same Year
    AND parentassetcode = a.parentassetcode -- Same Road
    AND Carriageway = a.Carriageway -- Same direction
    AND Lane = a.Lane -- Same Lane
    AND Attribute_Name NOT IN ('Remaining Life - Alternate','Remaining Life - Confirming','Remaining Life - Conforming')
    AND PCAS_Pass_Fail = 'Fail'
    AND `Start Chng` >= FLOOR(a.`Start Chng`,-3)
    AND `End Chng` <= CEILING(a.`End Chng`,-3)) AS LPPC_Def_Count_Static_exclRemLife,
  --- If the 100m section itself is a defect and count of 100m segments that are defects within the 1km section is > 1 then its an LPPC Defect
  CASE WHEN
  (SELECT count(DISTINCT assetname) FROM lppc_calc
    WHERE `Survey Year` = a.`Survey Year` -- Same Year
    AND parentassetcode = a.parentassetcode -- Same Road
    AND Carriageway = a.Carriageway -- Same direction
    AND Lane = a.Lane -- Same Lane
    AND PCAS_Pass_Fail = 'Fail'
    AND `Start Chng` >= FLOOR(a.`Start Chng`,-3)
    AND `End Chng` <= CEILING(a.`End Chng`,-3)) >1 AND 
  (SELECT COUNT(DISTINCT assetname) FROM lppc_calc
   WHERE assetname = a.assetname
   AND `Survey Year` = a.`Survey Year` -- Same Year
   AND PCAS_Pass_Fail = 'Fail') > 0 THEN 'Yes' ELSE 'No'
  END AS LPPC_Defect_Static,
  --- If the 100m section itself is a defect and count of 100m segments that are defects within the 1km section is > 1 then its an LPPC Defect
  CASE WHEN
  (SELECT count(DISTINCT assetname) FROM lppc_calc
    WHERE `Survey Year` = a.`Survey Year` -- Same Year
    AND parentassetcode = a.parentassetcode -- Same Road
    AND Carriageway = a.Carriageway -- Same direction
    AND Lane = a.Lane -- Same Lane
    AND Attribute_Name NOT IN ('Remaining Life - Alternate','Remaining Life - Confirming','Remaining Life - Conforming')
    AND PCAS_Pass_Fail = 'Fail'
    AND `Start Chng` >= FLOOR(a.`Start Chng`,-3)
    AND `End Chng` <= CEILING(a.`End Chng`,-3)) >1 AND 
  (SELECT COUNT(DISTINCT assetname) FROM lppc_calc
   WHERE assetname = a.assetname
   AND `Survey Year` = a.`Survey Year` -- Same Year
   AND Attribute_Name NOT IN ('Remaining Life - Alternate','Remaining Life - Confirming','Remaining Life - Conforming')
   AND PCAS_Pass_Fail = 'Fail') > 0 THEN 'Yes' ELSE 'No'
  END AS LPPC_Defect_Static_exclRemLife,
  --- If the 100m section itself is a defect and count of 100m segments that are defects within the 1km section is > 1 then its an LPPC Defect
  CASE WHEN
  (SELECT count(DISTINCT assetname) FROM lppc_calc
    WHERE `Survey Year` = a.`Survey Year` -- Same Year
    AND parentassetcode = a.parentassetcode -- Same Road
    AND Carriageway = a.Carriageway -- Same direction
    AND Lane = a.Lane -- Same Lane
    AND PCAS_Pass_Fail = 'Fail'
    AND `Start Chng` >= a.`End Chng`- 1000
    AND `End Chng` <= a.`Start Chng`+ 1000) >1 AND 
  (SELECT COUNT(DISTINCT assetname) FROM lppc_calc
   WHERE assetname = a.assetname
   AND `Survey Year` = a.`Survey Year` -- Same Year
   AND PCAS_Pass_Fail = 'Fail') > 0 THEN 'Yes' ELSE 'No'
  END AS LPPC_Defect_Rolling,
  --- If the 100m section itself is a defect and count of 100m segments that are defects within the 1km section is > 1 then its an LPPC Defect
  CASE WHEN
  (SELECT count(DISTINCT assetname) FROM lppc_calc
    WHERE `Survey Year` = a.`Survey Year` -- Same Year
    AND parentassetcode = a.parentassetcode -- Same Road
    AND Carriageway = a.Carriageway -- Same direction
    AND Lane = a.Lane -- Same Lane
    AND Attribute_Name NOT IN ('Remaining Life - Alternate','Remaining Life - Confirming','Remaining Life - Conforming')
    AND PCAS_Pass_Fail = 'Fail'
    AND `Start Chng` >= a.`End Chng`- 1000
    AND `End Chng` <= a.`Start Chng`+ 1000) >1 AND 
  (SELECT COUNT(DISTINCT assetname) FROM lppc_calc
   WHERE assetname = a.assetname
   AND `Survey Year` = a.`Survey Year` -- Same Year
   AND Attribute_Name NOT IN ('Remaining Life - Alternate','Remaining Life - Confirming','Remaining Life - Conforming')
   AND PCAS_Pass_Fail = 'Fail') > 0 THEN 'Yes' ELSE 'No'
  END AS LPPC_Defect_Rolling_exclRemLife
FROM lppc_calc a
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
| `Attribute_Name` | `string` | Yes |  |
| `Attribute_Value` | `float` | Yes |  |
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
| `PCAS_Pass_Fail` | `string` | No |  |
| `Condition_Rating` | `string` | No |  |
| `Static_1km_Start` | `decimal(11,0)` | Yes |  |
| `Static_1km_End` | `decimal(11,0)` | Yes |  |
| `Defect_100m` | `string` | No |  |
| `Defect_100m_exclRemLife` | `string` | No |  |
| `LPPC_Def_Count_Static` | `bigint` | Yes |  |
| `LPPC_Def_Count_Static_exclRemLife` | `bigint` | Yes |  |
| `LPPC_Defect_Static` | `string` | No |  |
| `LPPC_Defect_Static_exclRemLife` | `string` | No |  |
| `LPPC_Defect_Rolling` | `string` | No |  |
| `LPPC_Defect_Rolling_exclRemLife` | `string` | No |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
