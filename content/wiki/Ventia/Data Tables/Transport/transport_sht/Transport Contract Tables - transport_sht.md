---
type: contract-table-catalog
topic: Ventia
sector: Transport
contract-schema: transport_sht
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-tables, contract-schema, transport-sht]
---

# Transport Contract Tables - transport_sht

This page catalogs table documentation for the `transport_sht` Transport schema. In Transport, schema differences usually indicate different contracts or contract groupings.

## Table Index

| Table | Full name | Type | Columns | Domain | Purpose |
|---|---|---|---:|---|---|
| [[Transport Table - transport_sht - utbl_nps03_sb]] | `transport_dev.transport_sht.utbl_nps03_sb` | MANAGED | 3 | sensor reading |  |
| [[Transport Table - transport_sht - utbl_nps04_nb]] | `transport_dev.transport_sht.utbl_nps04_nb` | MANAGED | 1 | upload staging |  |
| [[Transport Table - transport_sht - utbl_sps01_nb]] | `transport_dev.transport_sht.utbl_sps01_nb` | MANAGED | 1 | upload staging |  |
| [[Transport Table - transport_sht - utbl_sps02_sb]] | `transport_dev.transport_sht.utbl_sps02_sb` | MANAGED | 3 | sensor reading |  |
| [[Transport Table - transport_sht - utbl_ss_latitude]] | `transport_dev.transport_sht.utbl_ss_latitude` | MANAGED | 8 | service schedule |  |
| [[Transport Table - transport_sht - utbl_tmp_nps03_sb]] | `transport_dev.transport_sht.utbl_tmp_nps03_sb` | MANAGED | 1 | temporary staging | Temporary staging table created via file upload |
| [[Transport Table - transport_sht - utbl_tmp_nps04_nb]] | `transport_dev.transport_sht.utbl_tmp_nps04_nb` | MANAGED | 1 | temporary staging | Temporary staging table for NPS or similar customer feedback data |
| [[Transport Table - transport_sht - utbl_tmp_sps01_nb]] | `transport_dev.transport_sht.utbl_tmp_sps01_nb` | MANAGED | 1 | temporary staging | Temporary or intermediate file-upload dataset |
| [[Transport Table - transport_sht - utbl_tmp_sps02_sb]] | `transport_dev.transport_sht.utbl_tmp_sps02_sb` | MANAGED | 1 | temporary staging | Temporary file-upload staging table |
| [[Transport Table - transport_sht - utbl_tmp_tvs03_sb]] | `transport_dev.transport_sht.utbl_tmp_tvs03_sb` | MANAGED | 1 | temporary staging | Temporary or staging table created via file upload |
| [[Transport Table - transport_sht - utbl_tmp_tvs07_nb]] | `transport_dev.transport_sht.utbl_tmp_tvs07_nb` | MANAGED | 1 | temporary staging | Temporary file-upload staging table |
| [[Transport Table - transport_sht - utbl_tvs03_sb]] | `transport_dev.transport_sht.utbl_tvs03_sb` | MANAGED | 3 | sensor reading |  |
| [[Transport Table - transport_sht - utbl_tvs07_nb]] | `transport_dev.transport_sht.utbl_tvs07_nb` | MANAGED | 3 | sensor reading |  |
| [[Transport Table - transport_sht - uvw_ai1]] | `transport_dev.transport_sht.uvw_ai1` | VIEW | 19 | inspection compliance |  |
| [[Transport Table - transport_sht - uvw_nps03_sb_segmented]] | `transport_dev.transport_sht.uvw_nps03_sb_segmented` | VIEW | 4 | segmented sensor reading |  |
| [[Transport Table - transport_sht - uvw_nps04_nb_segmented]] | `transport_dev.transport_sht.uvw_nps04_nb_segmented` | VIEW | 4 | segmented sensor reading |  |
| [[Transport Table - transport_sht - uvw_sps01_nb_segmented]] | `transport_dev.transport_sht.uvw_sps01_nb_segmented` | VIEW | 4 | segmented sensor reading |  |
| [[Transport Table - transport_sht - uvw_sps02_sb_segmented]] | `transport_dev.transport_sht.uvw_sps02_sb_segmented` | VIEW | 4 | segmented sensor reading |  |
| [[Transport Table - transport_sht - uvw_tvs03_sb_segmented]] | `transport_dev.transport_sht.uvw_tvs03_sb_segmented` | VIEW | 4 | segmented sensor reading |  |
| [[Transport Table - transport_sht - uvw_tvs07_nb_segmented]] | `transport_dev.transport_sht.uvw_tvs07_nb_segmented` | VIEW | 4 | segmented sensor reading |  |
| [[Transport Table - transport_sht - uvw_user_groups]] | `transport_dev.transport_sht.uvw_user_groups` | VIEW | 2 | user mapping |  |
| [[Transport Table - transport_sht - uvw_weather_north_sydney_hourly_rolling_30days]] | `transport_dev.transport_sht.uvw_weather_north_sydney_hourly_rolling_30days` | VIEW | 62 | weather |  |

## Skipped Or Incomplete Inputs

- `uvw_ai2` was visible in the pasted input but the schema was truncated before all columns and view SQL could be verified, so it has not been documented yet.
- A SHT job view object was visible only as the tail of a schema and query after truncation and without a verifiable table identity, so it has not been documented yet.

## Related Pages

- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
