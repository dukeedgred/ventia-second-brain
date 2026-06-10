---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: uvw_incident_trigger_report_map_geom
full-name: transport_dev.transport_tsrc.uvw_incident_trigger_report_map_geom
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - uvw_incident_trigger_report_map_geom

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_incident_trigger_report_map_geom` |
| Full name | `transport_dev.transport_tsrc.uvw_incident_trigger_report_map_geom` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | VIEW |
| Column count | 7 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | incidents |
| Owner/SME | Helix_readwrite_transport_dev_transport_tsrc |
| Refresh/freshness | Created: 2024-07-25T23:38:54.96Z; Last altered: 2024-10-22T03:46:03.7Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
    Select row_number() over (order by (ObjectId)) as UID, 
    ObjectId, 
    ObjectType,
    TriggerSectionId,
    incidentid,
    count,
    WKT 
from (

Select distinct
geom.TriggerSectionId as ObjectId, 
'Trigger Section' as ObjectType,
geom.TriggerSectionId,
Null as incidentid,
TriggerSectionWKT as WKT,
geom.incidentcount as count
from utbl_incident_triggered_section_geom geom
left join uvw_incident_triggered_report rep on rep.TriggerSectionId = geom.TriggerSectionId

union all

select
incidentid as ObjectId,
'Incident' as  ObjectType,
TriggerSectionId,
incidentid,
concat('POINT (', Longitude, ' ', Latitude, ')') as WKT,
NULL as count 
from uvw_incident_triggered_report)
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `UID` | `int` | No |  |
| `ObjectId` | `int` | Yes |  |
| `ObjectType` | `string` | No |  |
| `TriggerSectionId` | `int` | Yes |  |
| `incidentid` | `int` | Yes |  |
| `count` | `bigint` | Yes |  |
| `WKT` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
