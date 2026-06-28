---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_sht
table-name: uvw_nps04_nb_segmented
full-name: transport_dev.transport_sht.uvw_nps04_nb_segmented
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-table, databricks, transport-sht, segmented-sensor-reading]
---

# Transport Table - transport_sht - uvw_nps04_nb_segmented

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_nps04_nb_segmented` |
| Full name | `transport_dev.transport_sht.uvw_nps04_nb_segmented` |
| Catalog | `transport_dev` |
| Schema | `transport_sht` |
| Contract/schema | `transport_sht` |
| Table type | VIEW |
| Column count | 4 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | segmented sensor reading |
| Related tables/reports | `transport_dev.transport_sht.utbl_nps04_nb` |

## View Query

```sql
SELECT
  date_trunc('hour', Date_Time) + floor(minute(Date_Time) / 15) * INTERVAL '15' MINUTES AS interval_start,                
  AVG(PPM_Value) AS avg_reading,
  MAX(PPM_Value) AS max_reading,
  MIN(PPM_Value) AS min_reading
FROM
  transport_dev.transport_sht.utbl_nps04_nb
GROUP BY
  1 
ORDER BY
  1
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `interval_start` | `timestamp` | Yes |  |
| `avg_reading` | `decimal(8,5)` | Yes |  |
| `max_reading` | `decimal(4,1)` | Yes |  |
| `min_reading` | `decimal(4,1)` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_sht]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
