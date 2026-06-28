---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_fndc
table-name: uvw_fw_forward_work_view
full-name: transport_dev.transport_fndc.uvw_fw_forward_work_view
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-fndc]
---

# Transport Table - transport_fndc - uvw_fw_forward_work_view

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_fw_forward_work_view` |
| Full name | `transport_dev.transport_fndc.uvw_fw_forward_work_view` |
| Catalog | `transport_dev` |
| Schema | `transport_fndc` |
| Contract/schema | `transport_fndc` |
| Table type | VIEW |
| Column count | 18 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | capital works / forward works |
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2026-06-03T01:45:07.785Z; Last altered: 2026-06-03T01:45:07.785Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
SELECT
    programme_hdr_id AS programme_hdr_name,
    sec_zone,
    format,
    road_id AS road_name,
    tl_name,
    CAST(tl_start_m AS INT) AS tl_start_m,
    CAST(tl_end_m AS INT) AS tl_end_m,
    CAST(tl_width AS DECIMAL(5, 2)) AS tl_width,
    CAST(tl_length_m AS INT) AS tl_length_m,
    CAST(tl_area AS DECIMAL(10, 2)) AS tl_area,
    fw_year,
    CAST(fw_year_offset AS INT) AS fw_year_offset,
    fw_treatment,
    CAST(coverage AS INT) AS coverage,
    priority,
    reasons,
    reason_note,
    CAST(treat_length_id AS INT) AS treat_length_id
FROM
    staged_dev.stg_api_amds_fndc_test.fw_forward_work_view
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `programme_hdr_name` | `string` | Yes |  |
| `sec_zone` | `string` | Yes |  |
| `format` | `string` | Yes |  |
| `road_name` | `string` | Yes |  |
| `tl_name` | `string` | Yes |  |
| `tl_start_m` | `int` | Yes |  |
| `tl_end_m` | `int` | Yes |  |
| `tl_width` | `decimal(5,2)` | Yes |  |
| `tl_length_m` | `int` | Yes |  |
| `tl_area` | `decimal(10,2)` | Yes |  |
| `fw_year` | `string` | Yes |  |
| `fw_year_offset` | `int` | Yes |  |
| `fw_treatment` | `string` | Yes |  |
| `coverage` | `int` | Yes |  |
| `priority` | `string` | Yes |  |
| `reasons` | `string` | Yes |  |
| `reason_note` | `string` | Yes |  |
| `treat_length_id` | `int` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_fndc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
