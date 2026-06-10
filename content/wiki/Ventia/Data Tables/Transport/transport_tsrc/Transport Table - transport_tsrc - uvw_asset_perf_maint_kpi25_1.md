---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: uvw_asset_perf_maint_kpi25_1
full-name: transport_dev.transport_tsrc.uvw_asset_perf_maint_kpi25_1
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - uvw_asset_perf_maint_kpi25_1

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_asset_perf_maint_kpi25_1` |
| Full name | `transport_dev.transport_tsrc.uvw_asset_perf_maint_kpi25_1` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | VIEW |
| Column count | 30 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | KPI / reporting |
| Owner/SME | Helix_readwrite_transport_dev_transport_tsrc |
| Refresh/freshness | Created: 2024-08-27T05:38:41.333Z; Last altered: 2024-10-22T03:45:37.809Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
              WITH AV_Link AS (
                WITH compliancestat AS (
                  WITH allinspdates AS (
                    --Annually
                    SELECT
                      comp.`COMS Asset Name`,
                      comp.`AV Asset Name`,
                      comp.`Asset Type`,
                      comp.`Asset Raised Against`,
                      comp.`AV Inspection Name`,
                      comp.`Activity Name`,
                      comp.Frequency,
                      comp.`Asset Raised Against`,
                      comp.`Date Valid From`,
                      comp.`Date Valid To`,
                      ref.`EarliestStartDate-Annual` AS EarliestStartDate,
                      ref.DueDate
                    FROM
                      transport_dev.transport_tsrc.utbl_ref_routine_inspection_compliance comp
                      RIGHT JOIN transport_dev.transport_tsrc.utbl_ref_inspection_due_dates_yearly ref
                    WHERE
                      comp.Frequency = 'Annually'
                      AND ref.Annually = 'Yes'
                      AND (ref.DueDate <= comp.`Date Valid To` AND ref.DueDate > comp.`Date Valid From`)
                      AND comp.Duplicate IS NULL
                      
                    UNION
                    
                    --2 Yearly
                    SELECT
                      comp.`COMS Asset Name`,
                      comp.`AV Asset Name`,
                      comp.`Asset Type`,
                      comp.`Asset Raised Against`,
                      comp.`AV Inspection Name`,
                      comp.`Activity Name`,
                      comp.Frequency,
                      comp.`Asset Raised Against`,
                      comp.`Date Valid From`,
                      comp.`Date Valid To`,
                      ref.`EarliestStartDate->Annual` AS EarliestStartDate,
                      ref.DueDate
                    FROM
                      transport_dev.transport_tsrc.utbl_ref_routine_inspection_compliance comp
                      RIGHT JOIN transport_dev.transport_tsrc.utbl_ref_inspection_due_dates_yearly ref
                    WHERE
                      comp.Frequency = '2 Yearly'
                      AND ref.`2Yearly` = 'Yes'
                      AND (ref.DueDate <= comp.`Date Valid To` AND ref.DueDate > comp.`Date Valid From`)
                      AND comp.Duplicate IS NULL
                      
                    UNION
                    
                    --5 Yearly
                    SELECT
                      comp.`COMS Asset Name`,
                      comp.`AV Asset Name`,
                      comp.`Asset Type`,
                      comp.`Asset Raised Against`,
                      comp.`AV Inspection Name`,
                      comp.`Activity Name`,
                      comp.Frequency,
                      comp.`Asset Raised Against`,
                      comp.`Date Valid From`,
                      comp.`Date Valid To`,
                      ref.`EarliestStartDate->Annual` AS EarliestStartDate,
                      ref.DueDate
                    FROM
                      transport_dev.transport_tsrc.utbl_ref_routine_inspection_compliance comp
                      RIGHT JOIN transport_dev.transport_tsrc.utbl_ref_inspection_due_dates_yearly ref
                    WHERE
                      comp.Frequency = '5 Yearly'
                      AND ref.`5Yearly` = 'Yes'
                      AND (ref.DueDate <= comp.`Date Valid To` AND ref.DueDate > comp.`Date Valid From`)
                      AND comp.Duplicate IS NULL
                      
                    UNION
                    
                    --10 Yearly
                    SELECT
                      comp.`COMS Asset Name`,
                      comp.`AV Asset Name`,
                      comp.`Asset Type`,
                      comp.`Asset Raised Against`,
                      comp.`AV Inspection Name`,
                      comp.`Activity Name`,
                      comp.Frequency,
                      comp.`Asset Raised Against`,
                      comp.`Date Valid From`,
                      comp.`Date Valid To`,
                      ref.`EarliestStartDate->Annual` AS EarliestStartDate,
                      ref.DueDate
                    FROM
                      transport_dev.transport_tsrc.utbl_ref_routine_inspection_compliance comp
                      RIGHT JOIN transport_dev.transport_tsrc.utbl_ref_inspection_due_dates_yearly ref
                    WHERE
                      comp.Frequency = '10 Yearly'
                      AND ref.`10Yearly` = 'Yes'
                      AND (ref.DueDate <= comp.`Date Valid To` AND ref.DueDate > comp.`Date Valid From`)
                      AND comp.Duplicate IS NULL
                      
                    UNION
                    
                    --Monthly
                    SELECT
                      comp.`COMS Asset Name`,
                      comp.`AV Asset Name`,
                      comp.`Asset Type`,
                      comp.`Asset Raised Against`,
                      comp.`AV Inspection Name`,
                      comp.`Activity Name`,
                      comp.Frequency,
                      comp.`Asset Raised Against`,
                      comp.`Date Valid From`,
                      comp.`Date Valid To`,
                      ref.`EarliestStartDate-Monthly` AS EarliestStartDate,
                      ref.DueDate
                    FROM
                      transport_dev.transport_tsrc.utbl_ref_routine_inspection_compliance comp
                      RIGHT JOIN transport_dev.transport_tsrc.utbl_ref_inspection_due_dates_monthly ref
                    WHERE
                      comp.Frequency = 'Monthly'
                      AND ref.`Monthly` = 'Yes'
                      AND (ref.DueDate <= comp.`Date Valid To` AND ref.DueDate > comp.`Date Valid From`)
                      AND comp.Duplicate IS NULL
                      
                    UNION
                    
                    --3 Monthly
                    SELECT
                      comp.`COMS Asset Name`,
                      comp.`AV Asset Name`,
                      comp.`Asset Type`,
                      comp.`Asset Raised Against`,
                      comp.`AV Inspection Name`,
                      comp.`Activity Name`,
                      comp.Frequency,
                      comp.`Asset Raised Against`,
                      comp.`Date Valid From`,
                      comp.`Date Valid To`,
                      ref.`EarliestStartDate-3Monthly` AS EarliestStartDate,
                      ref.DueDate
                    FROM
                      transport_dev.transport_tsrc.utbl_ref_routine_inspection_compliance comp
                      RIGHT JOIN transport_dev.transport_tsrc.utbl_ref_inspection_due_dates_monthly ref
                    WHERE
                      comp.Frequency = '3 Monthly'
                      AND ref.`3Monthly` = 'Yes'
                      AND (ref.DueDate <= comp.`Date Valid To` AND ref.DueDate > comp.`Date Valid From`)
                      AND comp.Duplicate IS NULL
                      
                    UNION
                    
                      --6 Monthly
                    SELECT
                      comp.`COMS Asset Name`,
                      comp.`AV Asset Name`,
                      comp.`Asset Type`,
                      comp.`Asset Raised Against`,
                      comp.`AV Inspection Name`,
                      comp.`Activity Name`,
                      comp.Frequency,
                      comp.`Asset Raised Against`,
                      comp.`Date Valid From`,
                      comp.`Date Valid To`,
                      ref.`EarliestStartDate-6Monthly` AS EarliestStartDate,
                      ref.DueDate
                    FROM
                      transport_dev.transport_tsrc.utbl_ref_routine_inspection_compliance comp
                      RIGHT JOIN transport_dev.transport_tsrc.utbl_ref_inspection_due_dates_monthly ref
                    WHERE
                      comp.Frequency = '6 Monthly'
                      AND ref.`6Monthly` = 'Yes'
                      AND (ref.DueDate <= comp.`Date Valid To` AND ref.DueDate > comp.`Date Valid From`)
                      AND comp.Duplicate IS NULL
                      
                    UNION
                    
                    --Weekly
                    SELECT
                      comp.`COMS Asset Name`,
                      comp.`AV Asset Name`,
                      comp.`Asset Type`,
                      comp.`Asset Raised Against`,
                      comp.`AV Inspection Name`,
                      comp.`Activity Name`,
                      comp.Frequency,
                      comp.`Asset Raised Against`,
                      comp.`Date Valid From`,
                      comp.`Date Valid To`,
                      ref.`EarliestStartDate-Weekly` AS EarliestStartDate,
                      ref.DueDate
                    FROM
                      transport_dev.transport_tsrc.utbl_ref_routine_inspection_compliance comp
                      RIGHT JOIN transport_dev.transport_tsrc.utbl_ref_inspection_due_dates_weekly ref
                    WHERE
                      comp.Frequency = 'Weekly'
                      AND ref.`Weekly` = 'Yes'
                      AND (ref.DueDate <= comp.`Date Valid To` AND ref.DueDate > comp.`Date Valid From`)
                      AND comp.Duplicate IS NULL
                      
                    UNION
                    
                    --Fortnightly
                    SELECT
                      comp.`COMS Asset Name`,
                      comp.`AV Asset Name`,
                      comp.`Asset Type`,
                      comp.`Asset Raised Against`,
                      comp.`AV Inspection Name`,
                      comp.`Activity Name`,
                      comp.Frequency,
                      comp.`Asset Raised Against`,
                      comp.`Date Valid From`,
                      comp.`Date Valid To`,
                      ref.`EarliestStartDate-Fortnightly` AS EarliestStartDate,
                      ref.DueDate
                    FROM
                      transport_dev.transport_tsrc.utbl_ref_routine_inspection_compliance comp
                      RIGHT JOIN transport_dev.transport_tsrc.utbl_ref_inspection_due_dates_weekly ref
                    WHERE
                      comp.Frequency = 'Fortnightly'
                      AND ref.`Fornightly` = 'Yes'
                      AND (ref.DueDate <= comp.`Date Valid To` AND ref.DueDate > comp.`Date Valid From`)
                      AND comp.Duplicate IS NULL
                  )
                  SELECT
                    a.id,
                    a.`code`,
                    a.assettype,
                    a.assetname,
                    to_date(  case when a.constructiondate is NULL then '2018-01-01T00:00:00.000'
                                else a.constructiondate
                                end) as constructiondate,
                    a.disposaldate,
                    a.stage,
                    a.DrainageRiskRating,
                    a.`WAHPoints`,
                    a.`ElectricalAssetType`,
                    a.`MechanicalAssetType`,
                    i.`Asset Type`,
                    i.`Asset Raised Against`,
                    i.`AV Asset Name`,
                    i.`AV Inspection Name`,
                    i.`Activity Name`,
                    i.Frequency,
                    TO_DATE(i.EarliestStartDate) AS EarliestStartDate,
                    TO_DATE(i.DueDate) AS DueDate,
                    ( SELECT
                        MAX(scheduleddate)
                      FROM
                        ( SELECT
                            TO_DATE(scheduleddate) AS scheduleddate
                          FROM
                            transport_dev.transport_tsrc.uvw_inspection ti
                          WHERE
                            ti.assetid = a.id
                            AND ti.inspectiontypenamederived = i.`AV Inspection Name`
                            AND TO_DATE(convert_timezone('Australia/Queensland', ti.`completeddate`)) <= i.DueDate
                            AND TO_DATE(convert_timezone('Australia/Queensland', ti.`completeddate`)) >= i.EarliestStartDate
                        )
                    ) AS scheduleddate,
                    CASE
                      WHEN (SELECT
                              MAX(id)
                            FROM
                              ( SELECT
                                  id,
                                  TO_DATE(convert_timezone('Australia/Queensland', ti.`completeddate`)) AS completeddate
                                FROM
                                  transport_dev.transport_tsrc.uvw_inspection ti
                                WHERE
                                  ( ti.assetid = a.id
                                    AND ti.inspectiontypenamederived = i.`AV Inspection Name`
                                    AND TO_DATE(convert_timezone('Australia/Queensland', ti.`completeddate`)) <= i.DueDate
                                    AND TO_DATE(convert_timezone('Australia/Queensland', ti.`completeddate`)) >= i.EarliestStartDate
                                  )
                                  OR 
                                  ( ti.assetid = a.id
                                    AND ti.inspectiontypenamederived = i.`AV Inspection Name`
                                    AND TO_DATE(convert_timezone('Australia/Queensland', ti.`completeddate`)) >= i.DueDate
                                    AND TO_DATE(convert_timezone('Australia/Queensland', ti.`completeddate`)) <= i.EarliestStartDate
                                  )
                              )
                            ) IS NULL THEN (SELECT
                                              MAX(id)
                                            FROM
                                              ( SELECT
                                                  id,
                                                  TO_DATE(convert_timezone('Australia/Queensland', ti.`completeddate`)) AS completeddate
                                                FROM
                                                  transport_dev.transport_tsrc.uvw_inspection ti
                                                WHERE
                                                  ti.assetid = a.id
                                                  AND ti.inspectiontypenamederived = i.`AV Inspection Name`
                                                  AND TO_DATE(convert_timezone('Australia/Queensland', ti.`completeddate`)) > i.DueDate
                                                ORDER BY completeddate
                                                LIMIT 1
                                              )
                                          )
                      ELSE (SELECT
                              MAX(id)
                            FROM
                              ( SELECT
                                  id,
                                  TO_DATE(
                                    convert_timezone('Australia/Queensland', ti.`completeddate`)
                                  ) AS completeddate
                                FROM
                                  transport_dev.transport_tsrc.uvw_inspection ti
                                WHERE
                                  ( ti.assetid = a.id
                                    AND ti.inspectiontypenamederived = i.`AV Inspection Name`
                                    AND TO_DATE(convert_timezone('Australia/Queensland', ti.`completeddate`)) <= i.DueDate
                                    AND TO_DATE(convert_timezone('Australia/Queensland', ti.`completeddate`)) >= i.EarliestStartDate
                                  )
                                  OR 
                                  ( ti.assetid = a.id
                                    AND ti.inspectiontypenamederived = i.`AV Inspection Name`
                                    AND TO_DATE(convert_timezone('Australia/Queensland', ti.`completeddate`)) >= i.DueDate
                                    AND TO_DATE(convert_timezone('Australia/Queensland', ti.`completeddate`)) <= i.EarliestStartDate
                                  )
                              )
                           )
                    END AS CompletedInspId,
                    CASE
                      WHEN (SELECT
                              MAX(completeddate)
                            FROM
                              ( SELECT
                                  TO_DATE(convert_timezone('Australia/Queensland', ti.`completeddate`)) AS completeddate
                                FROM
                                  transport_dev.transport_tsrc.uvw_inspection ti
                                WHERE
                                  ti.assetid = a.id
                                  AND ti.inspectiontypenamederived = i.`AV Inspection Name`
                                  AND TO_DATE(convert_timezone('Australia/Queensland', ti.`completeddate`)) <= i.DueDate
                                  AND TO_DATE(convert_timezone('Australia/Queensland', ti.`completeddate`)) >= i.EarliestStartDate
                              )
                            ) IS NULL THEN (SELECT
                                              MAX(completeddate)
                                            FROM
                                              ( SELECT
                                                  TO_DATE(convert_timezone('Australia/Queensland', ti.`completeddate`)) AS completeddate
                                                FROM
                                                  transport_dev.transport_tsrc.uvw_inspection ti
                                                WHERE
                                                  ti.assetid = a.id
                                                  AND ti.inspectiontypenamederived = i.`AV Inspection Name`
                                                  AND TO_DATE(convert_timezone('Australia/Queensland', ti.`completeddate`)) > i.DueDate
                                                ORDER BY completeddate
                                                LIMIT 1
                                              )
                                           )
                      ELSE (SELECT
                              MAX(completeddate)
                            FROM
                              ( SELECT
                                  TO_DATE(convert_timezone('Australia/Queensland', ti.`completeddate`)) AS completeddate
                                FROM
                                  transport_dev.transport_tsrc.uvw_inspection ti
                                WHERE
                                  ti.assetid = a.id
                                  AND ti.inspectiontypenamederived = i.`AV Inspection Name`
                                  AND TO_DATE(convert_timezone('Australia/Queensland', ti.`completeddate`)) <= i.DueDate
                                  AND TO_DATE(convert_timezone('Australia/Queensland', ti.`completeddate`)) >= i.EarliestStartDate
                              )
                          )
                    END AS Completeddate,
                    ( SELECT
                        MAX(completeddate)
                      FROM
                        ( SELECT
                            TO_DATE(convert_timezone('Australia/Queensland', ti.`completeddate`)) AS completeddate
                          FROM
                            transport_dev.transport_tsrc.uvw_inspection ti
                          WHERE
                            ti.assetid = a.id
                            AND ti.inspectiontypenamederived = i.`AV Inspection Name`
                            AND TO_DATE(convert_timezone('Australia/Queensland', ti.`completeddate`)) > i.DueDate
                          ORDER BY completeddate
                          LIMIT 1
                        )
                    ) AS NonCompliantDate
                  FROM
                    allinspdates i
                    INNER JOIN transport_dev.transport_tsrc.uvw_assets a 
                       ON (a.assettype = i.`Asset Raised Against` AND a.constructiondate <= i.DueDate AND a.disposaldate >= i.DueDate)
                          OR (a.assettype = i.`Asset Raised Against` AND a.constructiondate <= i.DueDate AND a.disposaldate IS NULL) --- Filter for to exclude period that AV was NOT used
                  WHERE
                    EarliestStartDate >= '2023-07-01'
                  ORDER BY
                    code,
                    EarliestStartDate
                ) 
                ---Query for excluding
                SELECT
                  cs.*,
                  CASE
                    WHEN TO_DATE(`Completeddate`) IS NOT NULL AND TO_DATE(`Completeddate`) <= `DueDate` THEN 'Compliant'
                    WHEN TO_DATE(`Completeddate`) IS NULL AND NonCompliantDate IS NULL AND (`DueDate` <= TO_DATE(convert_timezone('Australia/Queensland', getdate()))) THEN 'Overdue'
                    WHEN TO_DATE(`Completeddate`) IS NOT NULL AND NonCompliantDate IS NOT NULL THEN 'Late'
                    ELSE 'Pending'
                  END AS ComplianceStatus,
                  CASE
                    WHEN scheduleddate IS NOT NULL -- or (TO_DATE(`Completeddate`) IS NULL AND NonCompliantDate IS NULL)
                    THEN 'Yes'
                    ELSE 'No'
                  END AS ScheduledStatus,
                  CONCAT(code, `AV Inspection Name`, EarliestStartDate, DueDate) AS AbatementCostKey
                FROM
                  compliancestat cs
                WHERE
                  --- Excluding Table Drains that are NOT High Risk from the 6 Monthly High Risk Table Drain Inspection Activity
                  NOT (`AV Inspection Name` = 'Table Drains - High Risk - 6 Monthly' 
                  AND `DrainageRiskRating` = 'Standard drainage asset') AND 

                  ---Excluding all Traffic Signals AND Traffic Signal General inspection AND Electrical test AND AS 3019 check inspection activities
                  NOT (`assettype` = 'Traffic Signals' AND 
                  `Activity Name` IN ('General inspection', 'Electrical test and AS 3019 check')) AND

                  ---Excluding all Bridges AND Bridge - WAH Access 10 Anchor point certification inspection activities
                  NOT (`assettype` = 'Bridge' 
                  AND `AV Inspection Name` = 'Bridge - WAH Access 10 Anchor point certification') AND 

                   ---Excluding all Electrical AND Building - CCTV Maintenance - 3 Monthly, Building - CCTV Maintenance - 6 Monthly, Building - Electrical Switch Boards - 6 Monthlym AND Building - Electrical Switch Boards - 2 Yearly activities
                  NOT ( `assettype` = 'Electrical' 
                  AND `AV Inspection Name` IN ( 'Building - CCTV Maintenance - 3 Monthly',
                                                'Building - CCTV Maintenance - 6 Monthly',
                                                'Building - Electrical Switch Boards - 6 Monthly',
                                                'Building - Electrical Switch Boards - 2 Yearly')) AND 

                  ---Excluding all Mechanical AND Building - Air Conditioning System - 3 monthly, Building - Air Conditioning System - 12 Monthly, Building - Hot Water System - 3 Monthly, Building - Rain Water System - 12 Monthly AND Building - WAH Access System - 12 Monthly activities
                  NOT (`Asset Raised Against` = 'Mechanical' 
                  AND `AV Inspection Name` IN ( 'Building - Air Conditioning System - 3 monthly',
                                                'Building - Air Conditioning System - 12 Monthly',
                                                'Building - Hot Water System - 3 Monthly',
                                                'Building - Rain Water System - 12 Monthly',
                                                'Building - WAH Access System - 12 Monthly')) AND 

                  ---Excluding all TCC Server Room AND Building - UPS - Inspect VRLA Battery - 6 Monthly, AND Building - UPS - Inspect Fan - 12 Monthly
                  NOT (`assettype` = 'TCC Server Room' 
                  AND `AV Inspection Name` IN ( 'Building - UPS - Inspect VRLA Battery - 6 Monthly', 
                                                'Building - UPS - Inspect Fan - 12 Monthly'))
                  
                UNION
                
                ---Query for including
                SELECT
                  cs.*,
                  CASE
                    WHEN TO_DATE(`Completeddate`) IS NOT NULL AND TO_DATE(`Completeddate`) <= `DueDate` THEN 'Compliant'
                    WHEN TO_DATE(`Completeddate`) IS NULL AND NonCompliantDate IS NULL AND (`DueDate` <= TO_DATE(convert_timezone('Australia/Queensland', getdate()))) THEN 'Overdue'
                    WHEN TO_DATE(`Completeddate`) IS NOT NULL AND NonCompliantDate IS NOT NULL THEN 'Late'
                    ELSE 'Pending'
                  END AS ComplianceStatus,
                  CASE
                    WHEN scheduleddate IS NOT NULL -- or (TO_DATE(`Completeddate`) IS NULL AND NonCompliantDate IS NULL)
                    THEN 'Yes'
                    ELSE 'No'
                  END AS ScheduledStatus,
                  CONCAT(code, `AV Inspection Name`, EarliestStartDate, DueDate) AS AbatementCostKey
                FROM
                  compliancestat cs
                WHERE
                  ---Traffic Signals
                  (code IN ('TS00164', 'TS00165', 'TS00127', 'TS00128') AND `Activity Name` IN ('General inspection', 'Electrical test AND AS 3019 check'))
                   ---Including Bridges WITH WAH Points for Bridge - WAH Access 10 Anchor point certification inspection activities
                  OR (cs.`WAHPoints` = 'Yes' AND `AV Inspection Name` = 'Bridge - WAH Access 10 Anchor point certification')
                   ---Including Electrical
                  OR (`ElectricalAssetType` = `Asset Type` AND `AV Inspection Name` IN (  'Building - CCTV Maintenance - 3 Monthly',
                                                                                          'Building - CCTV Maintenance - 6 Monthly',
                                                                                          'Building - Electrical Switch Boards - 6 Monthly',
                                                                                          'Building - Electrical Switch Boards - 2 Yearly'
                                                                                        ))
                   ---Including Mechanical
                  OR (MechanicalAssetType = `Asset Type` AND `AV Inspection Name` IN ('Building - Air Conditioning System - 3 monthly',
                                                                                      'Building - Air Conditioning System - 12 Monthly',
                                                                                      'Building - Hot Water System - 3 Monthly',
                                                                                      'Building - Rain Water System - 12 Monthly',
                                                                                      'Building - WAH Access System - 12 Monthly'
                                                                                    ))
                   ---Including UPS
                  OR (assetname = `Asset Type` AND `AV Inspection Name` IN ('Building - UPS - Inspect VRLA Battery - 6 Monthly', 'Building - UPS - Inspect Fan - 12 Monthly'))
              )
              SELECT
                *,
                CONCAT('https://gen7.assetvision.com.au/Inspections/ViewInspection/', CompletedInspId) AS `AV_Link`,
                COALESCE(`completeddate`, `NonCompliantDate`, TO_DATE(convert_timezone('Australia/Queensland', GETDATE()))) AS `AssessmentDate`,
                CASE
                  WHEN Frequency IN ('Weekly', 'Fortnightly') THEN 5
                  WHEN Frequency IN ('Monthly') THEN 10
                  ELSE 20
                END AS AdditionalRectificationPeriod,
                LPAD(ROW_NUMBER() OVER (ORDER BY AbatementCostKey ASC), 10, 0) AS `ReqInspId`
              FROM
                AV_Link
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `id` | `int` | Yes |  |
| `code` | `string` | Yes |  |
| `assettype` | `string` | Yes |  |
| `assetname` | `string` | Yes |  |
| `constructiondate` | `date` | Yes |  |
| `disposaldate` | `timestamp` | Yes |  |
| `stage` | `string` | Yes |  |
| `DrainageRiskRating` | `string` | Yes |  |
| `WAHPoints` | `string` | Yes |  |
| `ElectricalAssetType` | `string` | Yes |  |
| `MechanicalAssetType` | `string` | Yes |  |
| `Asset Type` | `string` | Yes |  |
| `Asset Raised Against` | `string` | Yes |  |
| `AV Asset Name` | `string` | Yes |  |
| `AV Inspection Name` | `string` | Yes |  |
| `Activity Name` | `string` | Yes |  |
| `Frequency` | `string` | Yes |  |
| `EarliestStartDate` | `date` | Yes |  |
| `DueDate` | `date` | Yes |  |
| `scheduleddate` | `date` | Yes |  |
| `CompletedInspId` | `int` | Yes |  |
| `Completeddate` | `date` | Yes |  |
| `NonCompliantDate` | `date` | Yes |  |
| `ComplianceStatus` | `string` | No |  |
| `ScheduledStatus` | `string` | No |  |
| `AbatementCostKey` | `string` | Yes |  |
| `AV_Link` | `string` | Yes |  |
| `AssessmentDate` | `date` | Yes |  |
| `AdditionalRectificationPeriod` | `int` | No |  |
| `ReqInspId` | `string` | No |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
