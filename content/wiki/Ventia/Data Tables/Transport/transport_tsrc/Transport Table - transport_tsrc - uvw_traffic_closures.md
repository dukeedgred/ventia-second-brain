---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: uvw_traffic_closures
full-name: transport_dev.transport_tsrc.uvw_traffic_closures
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-table, databricks, transport-tsrc, traffic-closure]
---

# Transport Table - transport_tsrc - uvw_traffic_closures

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_traffic_closures` |
| Full name | `transport_dev.transport_tsrc.uvw_traffic_closures` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | VIEW |
| Column count | 17 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | traffic closure |
| Related tables/reports | `ext_mssql_asset_vision_ven_gen7.dbo.module`, `ext_mssql_asset_vision_ven_gen7.dbo.formfield` |

## View Query

```sql
SELECT DISTINCT
  CAST(m.id AS int) AS id,
  m.createddate AS CreatedDate,
  m.completeddate AS CompletionDate,
  m.name AS IncidentDescription,
  CASE WHEN f1.value = 'INC'
    THEN 'Incident'
    WHEN f1.value = 'MTC' 
    THEN 'Maintenance' 
    ELSE null
  END AS ClosureType,
  CONCAT(f2.value, '-', f3.value) AS Chainage,
  to_timestamp(f4.value, 'd/M/yyyy H:m:s') AS TrafficFlowStopped,
  to_timestamp(f5.value, 'd/M/yyyy H:m:s') AS TrafficFlowResumed,  
  timestampdiff(MINUTE, to_timestamp(f4.value, 'd/M/yyyy H:m:s'), to_timestamp(f5.value, 'd/M/yyyy H:m:s')) AS DurationInMins,
  f6.value AS TrafficDirection,
  f7.value AS LaneAffected,
  f8.value AS Section,
  CASE WHEN f9.value =''
    THEN 'QGTTM_4.3'
    ELSE CONCAT('TSRC-MTC-TGS-', f9.value)
  END AS TGSNumber,
  f10.value AS IsAudited,
  f11.value AS AEDExternalID,
  f12.sourcetableid AS AVIncidentID,
  f13.value AS CompletionCode
FROM ext_mssql_asset_vision_ven_gen7.dbo.module m 
LEFT JOIN ext_mssql_asset_vision_ven_gen7.dbo.formfield f1
  ON m.id = f1.sourcetableid 
  AND f1.sourcetable = 'Module'
  AND f1.name = 'Closure Details|Closure Details (2)|Category'
  AND f1.deleted = false
LEFT JOIN ext_mssql_asset_vision_ven_gen7.dbo.formfield f2
  ON m.id = f2.sourcetableid
  AND f2.sourcetable = 'Module'
  AND f2.name LIKE 'Closure Details|%|Chainage Start'
  AND f2.deleted = false
LEFT JOIN ext_mssql_asset_vision_ven_gen7.dbo.formfield f3
  ON m.id = f3.sourcetableid
  AND f3.sourcetable = 'Module'
  AND f3.name LIKE 'Closure Details|%|Chainage End'
  AND f3.deleted = false
LEFT JOIN ext_mssql_asset_vision_ven_gen7.dbo.formfield f4
  ON m.id = f4.sourcetableid
  AND f4.sourcetable = 'Module'
  AND f4.name LIKE 'Closure Details|%|TrafficFlowStopped'
  AND f4.deleted = false
LEFT JOIN ext_mssql_asset_vision_ven_gen7.dbo.formfield f5
  ON m.id = f5.sourcetableid
  AND f5.sourcetable = 'Module'
  AND f5.name LIKE 'Closure Details|%|TrafficFlowResumed'
  AND f5.deleted = false
LEFT JOIN ext_mssql_asset_vision_ven_gen7.dbo.formfield f6
  ON m.id = f6.sourcetableid
  AND f6.sourcetable = 'Module'
  AND f6.name LIKE 'Closure Details|%|Direction'
  AND f6.deleted = false
LEFT JOIN ext_mssql_asset_vision_ven_gen7.dbo.formfield f7
  ON m.id = f7.sourcetableid
  AND f7.sourcetable = 'Module'
  AND f7.name LIKE 'Closure Details|%|Lane Affected'
  AND f7.deleted = false
LEFT JOIN ext_mssql_asset_vision_ven_gen7.dbo.formfield f8
  ON m.id = f8.sourcetableid
  AND f8.sourcetable = 'Module'
  AND f8.name = 'Closure Details|Closure Details (2)|Section'
  AND f8.deleted = false
LEFT JOIN ext_mssql_asset_vision_ven_gen7.dbo.formfield f9
  ON m.id = f9.sourcetableid 
  AND f9.sourcetable = 'Module'
  AND f9.name = 'Closure Details|Closure Details (1)|TGS Number'
  AND f9.deleted = false 
LEFT JOIN ext_mssql_asset_vision_ven_gen7.dbo.formfield f10
  ON m.id = f10.sourcetableid 
  AND f10.sourcetable = 'Module'
  AND f10.name = 'Closure Details|%|Is Audited'
  AND f10.deleted = false 
LEFT JOIN ext_mssql_asset_vision_ven_gen7.dbo.formfield f11
  ON m.id = f11.sourcetableid 
  AND f11.sourcetable = 'Module'
  AND f11.name = 'Closure Details|Closure Details (1)|AED ID'
  AND f11.deleted = false 
LEFT JOIN ext_mssql_asset_vision_ven_gen7.dbo.formfield f12
  ON f12.value = nullif(f11.value, '') 
  AND f12.sourcetable = 'Module'
  AND f12.name = 'Checklist|AED External ID'
  AND f12.deleted = false 
LEFT JOIN ext_mssql_asset_vision_ven_gen7.dbo.formfield f13
  ON f12.sourcetableid = f13.sourcetableid 
  AND f13.sourcetable = 'Module'
  AND f13.name = 'Rectification|Rectification (2)|Completion Code'
  AND f13.deleted = false 
WHERE m.contract = 'Toowoomba Second Range Crossing' 
  AND m.modulename = 'Closures' 
  AND m.deleted = false
UNION ALL 
SELECT DISTINCT
  CAST(m.id AS INT) AS id,
  m.createddate AS CreatedDate,
  m2.completeddate AS CompletionDate,
  CASE WHEN LEN(m.name)< 5
    THEN m2.name 
    ELSE m.name
  END AS IncidentDescription,
  'Incident' AS ClosureType,
  CASE WHEN f3.value <> '' and f3.value <> null 
      THEN f3.value 
      ELSE CASE WHEN f9.value <> '' and f9.value <> null  
               THEN f3.value
               ELSE m2.chainagefrom
            END
  END AS Chainage, 
  CASE WHEN SUBSTRING(f7.value,1,2) = '10'
      THEN to_timestamp(m.createddate, 'd/M/yyyy H:m:s') 
      ELSE to_timestamp(f8.value, 'd/M/yyyy H:m:s') 
  END AS TrafficFlowStopped, 
  to_timestamp(COALESCE(f5.value, m2.completeddate), 'd/M/yyyy H:m:s') as TrafficFlowResumed,  
  CASE WHEN SUBSTRING(f7.value,1,2) = '10'
      THEN timestampdiff(MINUTE, to_timestamp(m.createddate, 'd/M/yyyy H:m:s'), to_timestamp(COALESCE(f5.value, m2.completeddate), 'd/M/yyyy H:m:s')) 
      ELSE timestampdiff(MINUTE, to_timestamp(f8.value, 'd/M/yyyy H:m:s'), to_timestamp(COALESCE(f5.value, m2.completeddate), 'd/M/yyyy H:m:s')) 
  END AS DurationInMins,
  f6.value AS TrafficDirection,
  f4.value as LaneAffected,  
  f1.value AS Section,
  f2.value AS TGSNumber,
  NULL as IsAudited,
  NULL AS AEDExternalID,
  m2.id AS AVIncidentID,
  f7.value as CompletionCode
FROM
  ext_mssql_asset_vision_ven_gen7.dbo.module m
LEFT JOIN ext_mssql_asset_vision_ven_gen7.dbo.module m2 
  ON m.parentsourcetablename = 'Module'
  AND m.parentsourcetableid = m2.id
LEFT JOIN ext_mssql_asset_vision_ven_gen7.dbo.formfield f1
  ON m.id = f1.sourcetableid
  AND f1.sourcetable = 'Module'
  AND f1.name = 'Incident Closure details|Section'
  AND f1.deleted = false
LEFT JOIN ext_mssql_asset_vision_ven_gen7.dbo.formfield f2
  ON m.id = f2.sourcetableid 
  AND f2.sourcetable = 'Module'
  AND f2.name = 'Incident Closure details|TGS'
  AND f2.deleted = false 
LEFT JOIN ext_mssql_asset_vision_ven_gen7.dbo.formfield f3
  ON m2.id = f3.sourcetableid
  AND f3.sourcetable = 'Module'
  AND f3.name = 'Overview|Chainage'
  AND f3.deleted = false
LEFT JOIN ext_mssql_asset_vision_ven_gen7.dbo.formfield f4
  ON m2.id = f4.sourcetableid
  AND f4.sourcetable = 'Module'
  AND f4.name = 'Details|Details (2)|Lanes Affected' 
  AND f4.deleted = false
LEFT JOIN ext_mssql_asset_vision_ven_gen7.dbo.formfield f5
  ON m2.id = f5.sourcetableid 
  AND f5.sourcetable = 'Module'
  AND f5.name like 'Rectification|%|End Time'
  AND f5.deleted = false 
LEFT JOIN ext_mssql_asset_vision_ven_gen7.dbo.formfield f6
  ON m2.id = f6.sourcetableid
  AND f6.sourcetable = 'Module'
  AND f6.name like 'Details|%|Direction'
  AND f6.deleted = false
LEFT JOIN ext_mssql_asset_vision_ven_gen7.dbo.formfield f7
  ON m2.id = f7.sourcetableid 
  AND f7.sourcetable = 'Module'
  AND f7.name like 'Rectification|%|Completion Code'
  AND f7.deleted = false 
LEFT JOIN ext_mssql_asset_vision_ven_gen7.dbo.formfield f8
  ON m2.id = f8.sourcetableid 
  AND f8.sourcetable = 'Module'
  AND f8.name = 'Occurrence|Occurrence Date and Time'
  AND f8.deleted = false 
LEFT JOIN ext_mssql_asset_vision_ven_gen7.dbo.formfield f9
  ON m2.id = f9.sourcetableid
  AND f9.sourcetable = 'Module'
  AND f9.name like 'Details|%|Chainage'
  AND f9.deleted = false
WHERE m.contract = 'Toowoomba Second Range Crossing' 
  AND m.modulename = 'Incident Closure'
  AND m.parentsourcetableid IS NOT NULL
  AND m.parentsourcetablename IS NOT NULL --Only Sub Registers
  AND m.deleted = false 
  AND m2.modulename = 'Incident'
  AND m2.deleted = false
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `id` | `int` | Yes |  |
| `CreatedDate` | `timestamp` | Yes |  |
| `CompletionDate` | `timestamp` | Yes |  |
| `IncidentDescription` | `string` | Yes |  |
| `ClosureType` | `string` | Yes |  |
| `Chainage` | `string` | Yes |  |
| `TrafficFlowStopped` | `timestamp` | Yes |  |
| `TrafficFlowResumed` | `timestamp` | Yes |  |
| `DurationInMins` | `bigint` | Yes |  |
| `TrafficDirection` | `string` | Yes |  |
| `LaneAffected` | `string` | Yes |  |
| `Section` | `string` | Yes |  |
| `TGSNumber` | `string` | Yes |  |
| `IsAudited` | `string` | Yes |  |
| `AEDExternalID` | `string` | Yes |  |
| `AVIncidentID` | `int` | Yes |  |
| `CompletionCode` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
