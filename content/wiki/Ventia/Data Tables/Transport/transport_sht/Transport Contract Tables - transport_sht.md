---
type: contract-table-catalog
topic: Ventia
sector: Transport
contract-schema: transport_sht
date-created: 2026-06-05
date-updated: 2026-06-09
tags: [transport, data-tables, contract-schema, transport-sht]
---

# Transport Contract Tables - transport_sht

This page catalogs table documentation for the `transport_sht` Transport schema. In Transport, schema differences usually indicate different contracts, contract groupings, or curated reporting contexts.

## Context Notes

- Stakeholder documentation identifies Sydney Harbour Tunnel operational work management as Maximo. The `transport_sht` Databricks schema is treated here as a curated Transport reporting/schema context, not as evidence that SHT operates in Asset Vision.

## Table Index

| Table | Full name | Type | Columns | Domain | Purpose |
|---|---|---|---:|---|---|
| [[Transport Table - transport_sht - utbl_nps03_sb]] | `transport_dev.transport_sht.utbl_nps03_sb` | MANAGED | 3 |  |  |
| [[Transport Table - transport_sht - utbl_nps04_nb]] | `transport_dev.transport_sht.utbl_nps04_nb` | MANAGED | 1 |  | Created by the file upload UI |
| [[Transport Table - transport_sht - utbl_sps01_nb]] | `transport_dev.transport_sht.utbl_sps01_nb` | MANAGED | 1 |  | Created by the file upload UI |
| [[Transport Table - transport_sht - utbl_sps02_sb]] | `transport_dev.transport_sht.utbl_sps02_sb` | MANAGED | 3 |  |  |
| [[Transport Table - transport_sht - utbl_ss_latitude]] | `transport_dev.transport_sht.utbl_ss_latitude` | MANAGED | 8 |  | Created by the file upload UI |
| [[Transport Table - transport_sht - utbl_tmp_nps03_sb]] | `transport_dev.transport_sht.utbl_tmp_nps03_sb` | MANAGED | 1 | staging / backup |  |
| [[Transport Table - transport_sht - utbl_tmp_nps04_nb]] | `transport_dev.transport_sht.utbl_tmp_nps04_nb` | MANAGED | 1 | staging / backup |  |
| [[Transport Table - transport_sht - utbl_tmp_sps01_nb]] | `transport_dev.transport_sht.utbl_tmp_sps01_nb` | MANAGED | 1 | staging / backup |  |
| [[Transport Table - transport_sht - utbl_tmp_sps02_sb]] | `transport_dev.transport_sht.utbl_tmp_sps02_sb` | MANAGED | 1 | staging / backup |  |
| [[Transport Table - transport_sht - utbl_tmp_tvs03_sb]] | `transport_dev.transport_sht.utbl_tmp_tvs03_sb` | MANAGED | 1 | staging / backup |  |
| [[Transport Table - transport_sht - utbl_tmp_tvs07_nb]] | `transport_dev.transport_sht.utbl_tmp_tvs07_nb` | MANAGED | 1 | staging / backup |  |
| [[Transport Table - transport_sht - utbl_tvs03_sb]] | `transport_dev.transport_sht.utbl_tvs03_sb` | MANAGED | 3 |  |  |
| [[Transport Table - transport_sht - utbl_tvs07_nb]] | `transport_dev.transport_sht.utbl_tvs07_nb` | MANAGED | 3 |  |  |
| [[Transport Table - transport_sht - uvw_ai1]] | `transport_dev.transport_sht.uvw_ai1` | VIEW | 19 |  |  |
| [[Transport Table - transport_sht - uvw_ai2]] | `transport_dev.transport_sht.uvw_ai2` | VIEW | 17 |  |  |
| [[Transport Table - transport_sht - uvw_all_assets]] | `transport_dev.transport_sht.uvw_all_assets` | VIEW | 35 | asset register / hierarchy |  |
| [[Transport Table - transport_sht - uvw_all_critical_assets]] | `transport_dev.transport_sht.uvw_all_critical_assets` | VIEW | 21 | asset register / hierarchy |  |
| [[Transport Table - transport_sht - uvw_inspection]] | `transport_dev.transport_sht.uvw_inspection` | VIEW | 46 | inspection / audit / condition |  |
| [[Transport Table - transport_sht - uvw_job]] | `transport_dev.transport_sht.uvw_job` | VIEW | 80 | jobs / work orders |  |
| [[Transport Table - transport_sht - uvw_nps03_sb_segmented]] | `transport_dev.transport_sht.uvw_nps03_sb_segmented` | VIEW | 4 | asset register / hierarchy |  |
| [[Transport Table - transport_sht - uvw_nps04_nb_segmented]] | `transport_dev.transport_sht.uvw_nps04_nb_segmented` | VIEW | 4 | asset register / hierarchy |  |
| [[Transport Table - transport_sht - uvw_sps01_nb_segmented]] | `transport_dev.transport_sht.uvw_sps01_nb_segmented` | VIEW | 4 | asset register / hierarchy |  |
| [[Transport Table - transport_sht - uvw_sps02_sb_segmented]] | `transport_dev.transport_sht.uvw_sps02_sb_segmented` | VIEW | 4 | asset register / hierarchy |  |
| [[Transport Table - transport_sht - uvw_tvs03_sb_segmented]] | `transport_dev.transport_sht.uvw_tvs03_sb_segmented` | VIEW | 4 | asset register / hierarchy |  |
| [[Transport Table - transport_sht - uvw_tvs07_nb_segmented]] | `transport_dev.transport_sht.uvw_tvs07_nb_segmented` | VIEW | 4 | asset register / hierarchy |  |
| [[Transport Table - transport_sht - uvw_user_groups]] | `transport_dev.transport_sht.uvw_user_groups` | VIEW | 2 | user / security |  |
| [[Transport Table - transport_sht - uvw_weather_north_sydney_hourly_rolling_30days]] | `transport_dev.transport_sht.uvw_weather_north_sydney_hourly_rolling_30days` | VIEW | 62 | weather |  |

## Related Pages

- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
