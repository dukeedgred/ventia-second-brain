---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_srapc
table-name: uvw_a_slope_all_data
full-name: transport_dev.transport_srapc.uvw_a_slope_all_data
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-srapc]
---

# Transport Table - transport_srapc - uvw_a_slope_all_data

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_a_slope_all_data` |
| Full name | `transport_dev.transport_srapc.uvw_a_slope_all_data` |
| Catalog | `transport_dev` |
| Schema | `transport_srapc` |
| Contract/schema | `transport_srapc` |
| Table type | VIEW |
| Column count | 86 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2024-07-09T06:24:32.932Z; Last altered: 2024-07-18T20:31:00.777Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
WITH slopespivoted AS (
  WITH slopesunpivioted AS(
  SELECT
    a.id AS `ID`,
    a.assettype AS `Asset Type`,
    a.code AS `Code`,
    a.name AS `Name`,
    a.parentassetcode AS `Parent Asset Code`,
    a.parentassetname AS `Parent Asset Name`,
    a.direction AS `Parent Direction`,
    a.chainagefrom AS `Parent Chainage From`,
    a.chainageto AS `Parent Chainage To`,
    a.assetcriticality AS `Criticality`,
    a.assetcondition AS `Condition`,
    a.assetrisk AS `Risk`,
    a.classification AS `Classification`,
    a.notes AS `Notes`,
    a.alertnotes AS `Alert Notes`,
    a.parentassettypename AS `Parent Asset Type`,
    a.parentassetposition AS `Parent Asset Position`,
    a.offsetmetres AS `Offset Metres`,
    a.offsetside AS `Offset Side`,
    convert_timezone('UTC', 'Australia/Sydney', a.modifiedutc) AS `Last Modified`,
    a.modifieduser AS `Last Modified User`,
    a.stage AS `Asset Stage`,
    TO_TIMESTAMP(a.constructiondate) AS `Construction Date`,
    a.constructioncost AS `Construction Cost`,
    TO_TIMESTAMP(a.conditiondate) AS `Condition Date`,
    a.usefullife AS `Useful Life (No. of Years)`,
    '' AS `Service Level Condition`,
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
    LEFT JOIN ext_mssql_asset_vision_ven_rms.dbo.assetattribute aa ON aa.assetid = a.id
  WHERE
    a.contract = 'SRAP-C'
    AND a.assettype = 'Slope'
    AND a.deleted = false
    AND aa.deleted = false
)
SELECT
  *
FROM
  slopesunpivioted PIVOT (
    MAX(AttributeValue) FOR AttributeName IN (
      'Slope Site Id',
      'Cross Sectional Position',
      'Slope Risk Classification',
      'OBJECTID',
      'asset_cate',
      'road_numbe',
      'current_zo',
      'proposed_z',
      'systempk',
      'sourceseq',
      'side',
      'site_lengt',
      'slope_type',
      'slope_mate',
      'slope_heig',
      'slope_angl',
      'max_hazard',
      'max_magnit',
      'slope_scor',
      'slope_desc',
      'location_c',
      'srmp_flag',
      'ifc_code',
      'arl',
      'segment',
      'lga',
      'start_link',
      'start_offs',
      'start_cway',
      'start_cw_1',
      'end_link',
      'end_offset',
      'end_cway_c',
      'end_cway_v',
      'shape_leng',
      'shape_Length',
      'analysis_d',
      'next_analy',
      'ConOps_Score',
      'ConOps_Rank',
      'Tender Asset',
      'Asset Identification Date',
      'Hierarchy String'
    )
  )
)
SELECT 
  s.*,
  TO_TIMESTAMP(n1.scheduleddate) AS `Slope Inspection - Next Scheduled`,
  TO_TIMESTAMP(l1.completeddate) AS `Slope Inspection - Last Inspection`,
  l1.comments AS `Slope Inspection - Last Comment`,
  TO_TIMESTAMP(n2.scheduleddate) AS `Scheduled Slope Inspection - Next Scheduled`,
  TO_TIMESTAMP(l2.completeddate) AS `Scheduled Slope Inspection - Last Inspection`,
  l2.comments AS `Scheduled Slope Inspection - Last Comment`,
  (SELECT COUNT(1) FROM ext_mssql_asset_vision_ven_rms.dbo.job j where j.contract = 'SRAP-C' AND j.assetid = s.ID and j.deleted = false AND j.completedstatus = 'Open' AND j.assettypename = s.`Asset Type`) AS `Open Maintenance Jobs`
FROM
  slopespivoted s
  LEFT JOIN transport_dev.transport_srapc.uvw_asset_inspection_last l1 ON l1.assetid = s.ID AND s.`Asset Type` = l1.assettypename AND l1.inspectiontypename = 'Slope Inspection'
  LEFT JOIN transport_dev.transport_srapc.uvw_asset_inspection_last l2 ON l2.assetid = s.ID AND s.`Asset Type` = l2.assettypename AND l2.inspectiontypename = 'Scheduled Slope Inspection'
  LEFT JOIN transport_dev.transport_srapc.uvw_asset_inspection_next n1 ON n1.assetid = s.ID AND s.`Asset Type` = n1.assettypename AND n1.inspectiontypename = 'Slope Inspection'
  LEFT JOIN transport_dev.transport_srapc.uvw_asset_inspection_next n2 ON n2.assetid = s.ID AND s.`Asset Type` = n2.assettypename AND n2.inspectiontypename = 'Scheduled Slope Inspection'
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
| `Parent Chainage From` | `int` | Yes |  |
| `Parent Chainage To` | `int` | Yes |  |
| `Criticality` | `string` | Yes |  |
| `Condition` | `string` | Yes |  |
| `Risk` | `string` | Yes |  |
| `Classification` | `string` | Yes |  |
| `Notes` | `string` | Yes |  |
| `Alert Notes` | `string` | Yes |  |
| `Parent Asset Type` | `string` | Yes |  |
| `Parent Asset Position` | `string` | Yes |  |
| `Offset Metres` | `int` | Yes |  |
| `Offset Side` | `string` | Yes |  |
| `Last Modified` | `timestamp_ntz` | Yes |  |
| `Last Modified User` | `string` | Yes |  |
| `Asset Stage` | `string` | Yes |  |
| `Construction Date` | `timestamp` | Yes |  |
| `Construction Cost` | `decimal(12,2)` | Yes |  |
| `Condition Date` | `timestamp` | Yes |  |
| `Useful Life (No. of Years)` | `decimal(6,2)` | Yes |  |
| `Service Level Condition` | `string` | No |  |
| `Barcode` | `string` | No |  |
| `District` | `string` | Yes |  |
| `Depreciation Rate (%)` | `string` | No |  |
| `Depreciation Rate Override (%)` | `string` | No |  |
| `Latest Valuation Date` | `string` | No |  |
| `Valuation Amount ($)` | `string` | No |  |
| `Written Down Value ($)` | `string` | No |  |
| `WDV as of 30/06/2023 ($)` | `string` | No |  |
| `WDV as of 30/06/2024 ($)` | `string` | No |  |
| `Slope Site Id` | `string` | Yes |  |
| `Cross Sectional Position` | `string` | Yes |  |
| `Slope Risk Classification` | `string` | Yes |  |
| `OBJECTID` | `string` | Yes |  |
| `asset_cate` | `string` | Yes |  |
| `road_numbe` | `string` | Yes |  |
| `current_zo` | `string` | Yes |  |
| `proposed_z` | `string` | Yes |  |
| `systempk` | `string` | Yes |  |
| `sourceseq` | `string` | Yes |  |
| `side` | `string` | Yes |  |
| `site_lengt` | `string` | Yes |  |
| `slope_type` | `string` | Yes |  |
| `slope_mate` | `string` | Yes |  |
| `slope_heig` | `string` | Yes |  |
| `slope_angl` | `string` | Yes |  |
| `max_hazard` | `string` | Yes |  |
| `max_magnit` | `string` | Yes |  |
| `slope_scor` | `string` | Yes |  |
| `slope_desc` | `string` | Yes |  |
| `location_c` | `string` | Yes |  |
| `srmp_flag` | `string` | Yes |  |
| `ifc_code` | `string` | Yes |  |
| `arl` | `string` | Yes |  |
| `segment` | `string` | Yes |  |
| `lga` | `string` | Yes |  |
| `start_link` | `string` | Yes |  |
| `start_offs` | `string` | Yes |  |
| `start_cway` | `string` | Yes |  |
| `start_cw_1` | `string` | Yes |  |
| `end_link` | `string` | Yes |  |
| `end_offset` | `string` | Yes |  |
| `end_cway_c` | `string` | Yes |  |
| `end_cway_v` | `string` | Yes |  |
| `shape_leng` | `string` | Yes |  |
| `shape_Length` | `string` | Yes |  |
| `analysis_d` | `string` | Yes |  |
| `next_analy` | `string` | Yes |  |
| `ConOps_Score` | `string` | Yes |  |
| `ConOps_Rank` | `string` | Yes |  |
| `Tender Asset` | `string` | Yes |  |
| `Asset Identification Date` | `string` | Yes |  |
| `Hierarchy String` | `string` | Yes |  |
| `Slope Inspection - Next Scheduled` | `timestamp` | Yes |  |
| `Slope Inspection - Last Inspection` | `timestamp` | Yes |  |
| `Slope Inspection - Last Comment` | `string` | Yes |  |
| `Scheduled Slope Inspection - Next Scheduled` | `timestamp` | Yes |  |
| `Scheduled Slope Inspection - Last Inspection` | `timestamp` | Yes |  |
| `Scheduled Slope Inspection - Last Comment` | `string` | Yes |  |
| `Open Maintenance Jobs` | `bigint` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_srapc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
