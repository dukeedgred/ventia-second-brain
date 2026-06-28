---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_srapc
table-name: uvw_a_bridge_all_data
full-name: transport_dev.transport_srapc.uvw_a_bridge_all_data
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-srapc]
---

# Transport Table - transport_srapc - uvw_a_bridge_all_data

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_a_bridge_all_data` |
| Full name | `transport_dev.transport_srapc.uvw_a_bridge_all_data` |
| Catalog | `transport_dev` |
| Schema | `transport_srapc` |
| Contract/schema | `transport_srapc` |
| Table type | VIEW |
| Column count | 58 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2024-07-09T06:29:42.436Z; Last altered: 2024-07-18T20:30:53.355Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
WITH bridgespivoted AS (
  WITH bridgesunpivioted AS(
  SELECT
    a.id AS `ID`,
    a.assettype AS `Asset Type`,
    a.code AS `Code`,
    a.name AS `Name`,
    a.parentassetcode AS `Parent Asset Code`,
    a.parentassetname AS `Parent Asset Name`,
    a.direction AS `Parent Direction`,
    a.chainagefrom AS `Parent Chainage`,
    a.assetcriticality AS `Criticality`,
    a.assetcondition AS `Condition`,
    a.assetrisk AS `Risk`,
    a.classification AS `Classification`,
    a.notes AS `Notes`,
    a.alertnotes AS `Alert Notes`,
    a.parentassettypename AS `Parent Asset Type`,
    a.parentassetposition AS `Parent Asset Position`,
    convert_timezone('UTC', 'Australia/Sydney', a.modifiedutc) AS `Last Modified`,
    a.modifieduser AS `Last Modified User`,
    a.stage AS `Asset Stage`,
    TO_TIMESTAMP(a.constructiondate) AS `Construction Date`,
    a.constructioncost AS `Construction Cost`,
    TO_TIMESTAMP(a.conditiondate) AS `Condition Date`,
    a.usefullife AS `Useful Life (No. of Years)`,
    '' AS `Service Level Condition`,
    SUBSTRING(al.WKT, INSTR(al.WKT, '-'), ( INSTR(al.WKT, ')') - INSTR(al.WKT, '-') )) as `Latitude`,
    SUBSTRING(al.WKT, INSTR(al.WKT, '(') + 1, ( INSTR(al.WKT, ' -') - INSTR(al.WKT, '(') - 1 )) as `Longitude`,
    '' AS `Barcode`,
    a.contract AS `District`,
    '' AS `Depreciation Rate (%)`,
    '' AS `Depreciation Rate Override (%)`,
    '' AS `Latest Valuation Date`,
    '' AS `Valuation Amount ($)`,
    '' AS `Written Down Value ($)`,
    '' AS `WDV as of 30/06/2023 ($)`,
    '' AS `WDV as of 30/06/2024 ($)`,
    aa.name AS `AttributeName`,
    aa.value AS `AttributeValue`
  from
    ext_mssql_asset_vision_ven_rms.dbo.asset a
    LEFT JOIN ext_mssql_asset_vision_ven_rms.dbo.vassetlocation al ON al.assetid = a.id AND al.deleted = false
    LEFT JOIN ext_mssql_asset_vision_ven_rms.dbo.assetattribute aa ON aa.assetid = a.id
  WHERE
    a.contract = 'SRAP-C'
    AND (a.assettype = 'Bridge' OR a.assettype = 'Bridge Size Culvert')
    AND a.deleted = false
    AND aa.deleted = false
)
SELECT
  *
FROM
  bridgesunpivioted PIVOT (
    MAX(AttributeValue) FOR AttributeName IN (
      'Description Type', 
      'Description Over', 
      'Description At', 
      'Region', 
      'Zone', 
      'LGA', 
      'Operational Status', 
      'Controlled By', 
      'Inspected By', 
      'Maintained By', 
      'Facility Type', 
      'Bridge Type', 
      'Conops_Rank', 
      'Confined_Space', 
      'Tender Asset', 
      'Asset Identification Date'
    )
  )
)
SELECT 
  s.*,
  TO_TIMESTAMP(n1.scheduleddate) AS `Nominated Inspection - Next Scheduled`,
  TO_TIMESTAMP(l1.completeddate) AS `Nominated Inspection - Last Inspection`,
  l1.comments AS `Nominated Inspection - Last Comment`,
  TO_TIMESTAMP(n2.scheduleddate) AS `Scheduled Inspection - Next Scheduled`,
  TO_TIMESTAMP(l2.completeddate) AS `Scheduled Inspection - Last Inspection`,
  l2.comments AS `Scheduled Inspection - Last Comment`,
  (SELECT COUNT(1) FROM ext_mssql_asset_vision_ven_rms.dbo.job j where j.contract = 'SRAP-C' AND j.assetid = s.ID and j.deleted = false AND j.completedstatus = 'Open' AND j.assettypename = s.`Asset Type`) AS `Open Maintenance Jobs`
FROM
  bridgespivoted s
  LEFT JOIN transport_dev.transport_srapc.uvw_asset_inspection_last l1 ON l1.assetid = s.ID AND s.`Asset Type` = l1.assettypename AND l1.inspectiontypename = 'Nominated Inspection'
  LEFT JOIN transport_dev.transport_srapc.uvw_asset_inspection_last l2 ON l2.assetid = s.ID AND s.`Asset Type` = l2.assettypename AND l2.inspectiontypename = 'Scheduled Inspection'
  LEFT JOIN transport_dev.transport_srapc.uvw_asset_inspection_next n1 ON n1.assetid = s.ID AND s.`Asset Type` = n1.assettypename AND n1.inspectiontypename = 'Nominated Inspection'
  LEFT JOIN transport_dev.transport_srapc.uvw_asset_inspection_next n2 ON n2.assetid = s.ID AND s.`Asset Type` = n2.assettypename AND n2.inspectiontypename = 'Scheduled Inspection'
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `ID` | `int` | Yes |  |
| `Asset Type` | `string` | Yes |  |
| `Code` | `string` | Yes |  |
| `Name` | `string` | Yes |  |
| `Parent Asset Code` | `string` | Yes |  |
| `Parent Asset Name` | `string` | Yes |  |
| `Parent Direction` | `string` | Yes |  |
| `Parent Chainage` | `int` | Yes |  |
| `Criticality` | `string` | Yes |  |
| `Condition` | `string` | Yes |  |
| `Risk` | `string` | Yes |  |
| `Classification` | `string` | Yes |  |
| `Notes` | `string` | Yes |  |
| `Alert Notes` | `string` | Yes |  |
| `Parent Asset Type` | `string` | Yes |  |
| `Parent Asset Position` | `string` | Yes |  |
| `Last Modified` | `timestamp_ntz` | Yes |  |
| `Last Modified User` | `string` | Yes |  |
| `Asset Stage` | `string` | Yes |  |
| `Construction Date` | `timestamp` | Yes |  |
| `Construction Cost` | `decimal(12,2)` | Yes |  |
| `Condition Date` | `timestamp` | Yes |  |
| `Useful Life (No. of Years)` | `decimal(6,2)` | Yes |  |
| `Service Level Condition` | `string` | No |  |
| `Latitude` | `string` | Yes |  |
| `Longitude` | `string` | Yes |  |
| `Barcode` | `string` | No |  |
| `District` | `string` | Yes |  |
| `Depreciation Rate (%)` | `string` | No |  |
| `Depreciation Rate Override (%)` | `string` | No |  |
| `Latest Valuation Date` | `string` | No |  |
| `Valuation Amount ($)` | `string` | No |  |
| `Written Down Value ($)` | `string` | No |  |
| `WDV as of 30/06/2023 ($)` | `string` | No |  |
| `WDV as of 30/06/2024 ($)` | `string` | No |  |
| `Description Type` | `string` | Yes |  |
| `Description Over` | `string` | Yes |  |
| `Description At` | `string` | Yes |  |
| `Region` | `string` | Yes |  |
| `Zone` | `string` | Yes |  |
| `LGA` | `string` | Yes |  |
| `Operational Status` | `string` | Yes |  |
| `Controlled By` | `string` | Yes |  |
| `Inspected By` | `string` | Yes |  |
| `Maintained By` | `string` | Yes |  |
| `Facility Type` | `string` | Yes |  |
| `Bridge Type` | `string` | Yes |  |
| `Conops_Rank` | `string` | Yes |  |
| `Confined_Space` | `string` | Yes |  |
| `Tender Asset` | `string` | Yes |  |
| `Asset Identification Date` | `string` | Yes |  |
| `Nominated Inspection - Next Scheduled` | `timestamp` | Yes |  |
| `Nominated Inspection - Last Inspection` | `timestamp` | Yes |  |
| `Nominated Inspection - Last Comment` | `string` | Yes |  |
| `Scheduled Inspection - Next Scheduled` | `timestamp` | Yes |  |
| `Scheduled Inspection - Last Inspection` | `timestamp` | Yes |  |
| `Scheduled Inspection - Last Comment` | `string` | Yes |  |
| `Open Maintenance Jobs` | `bigint` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_srapc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
