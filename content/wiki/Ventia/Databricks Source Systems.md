---
type: source-system-catalog
topic: Ventia
date-created: 2026-06-09
date-updated: 2026-06-09
source-note: User-supplied Databricks source-system list pasted on 2026-06-09
tags: [databricks, source-systems, catalog, transport, asset-vision]
---

# Databricks Source Systems

This page captures the supplied Databricks source-system inventory. Schema names were not supplied in the pasted extract; `null` comments are recorded as not supplied rather than inferred.

## Source System Index

| # | Catalog | Schema | Supplied comment |
|---:|---|---|---|
| 1 | `ext_mssql_aea_sqlsrv_274_wacscs_epems_production` | Not supplied | Electronic prisoner and electronic monitoring system data for WA |
| 2 | `ext_mssql_asset_vision_ven_gen7` | Not supplied | Work management and asset data for the transport contracts RAMC, BAC, PoB, TSRC |
| 3 | `ext_mssql_asset_vision_ven_rms` | Not supplied | Not supplied |
| 4 | `ext_mssql_asset_vision_ven_rms_old` | Not supplied | Work management and asset data for the transport contract SRAPC |
| 5 | `ext_mssql_asset_vision_ven_vicroads` | Not supplied | Work management and asset data for the transport contract WRU |
| 6 | `ext_mssql_asset_vision_vns_gen7` | Not supplied | Work management and asset data for the transport contract SHT/WHT |
| 7 | `ext_mssql_asset_vision_vnz_gen7` | Not supplied | Work management and asset data for the transport contract Auckland West |
| 8 | `ext_mssql_asset_vision_vsm_gen7` | Not supplied | Work management and asset data for the transport contract VentureSmart |
| 9 | `ext_mssql_assetvisionreporting_av_ven_gen7` | Not supplied | Not supplied |
| 10 | `ext_mssql_assetvisionreporting_av_ven_vicroads` | Not supplied | Not supplied |

## Transport Asset Vision Mapping

| Source context | Catalog | Supplied contract/context mapping | Notes |
|---|---|---|---|
| [[Transport Source Tables - asset_vision_ven_gen7]] | `ext_mssql_asset_vision_ven_gen7` | RAMC, BAC, PoB, TSRC | Asset Vision work management and asset data |
| [[Transport Source Tables - asset_vision_ven_rms]] | `ext_mssql_asset_vision_ven_rms` | Not supplied | Comment was `null` in the supplied inventory |
| [[Transport Source Tables - asset_vision_ven_rms_old]] | `ext_mssql_asset_vision_ven_rms_old` | SRAPC | Asset Vision work management and asset data |
| [[Transport Source Tables - asset_vision_ven_vicroads]] | `ext_mssql_asset_vision_ven_vicroads` | WRU | Asset Vision work management and asset data |
| [[Transport Source Tables - asset_vision_vns_gen7]] | `ext_mssql_asset_vision_vns_gen7` | SHT/WHT | Asset Vision work management and asset data |
| [[Transport Source Tables - asset_vision_vnz_gen7]] | `ext_mssql_asset_vision_vnz_gen7` | Auckland West | Asset Vision work management and asset data |
| [[Transport Source Tables - asset_vision_vsm_gen7]] | `ext_mssql_asset_vision_vsm_gen7` | VentureSmart | Asset Vision work management and asset data |
| Not yet documented as a Transport source-table context | `ext_mssql_assetvisionreporting_av_ven_gen7` | Not supplied | Asset Vision Reporting catalog; no comment supplied |
| Not yet documented as a Transport source-table context | `ext_mssql_assetvisionreporting_av_ven_vicroads` | Not supplied | Asset Vision Reporting catalog; no comment supplied |

## Related Pages

- [[Ventia Databricks Platform]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Asset Vision]]
- [[Transport Contract Portfolio]]
