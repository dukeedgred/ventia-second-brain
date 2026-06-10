# Transport Four Vs Summary

Generated: 09/06/2026 15:49

Scope: Asset Vision source catalogues and `transport_dev` contract schemas currently visible in Databricks.

Important caveat: row counts are table-object counts. Views and base tables may overlap, so totals are not deduplicated counts of unique assets, jobs, inspections or events.

## Executive summary

| Area | Volume | Velocity | Variety | Veracity / usage |
|---|---:|---|---|---:|
| Source tables | 48,620,904 rows across 230 table objects | Latest timestamp signal across source tables: Current: latest data within 1 day | Asset, job, inspection, capital work, photos, forms/modules, workflow, resource/timesheet, reference/system | not available |
| Contract tables | 233,560,284 rows across 319 table objects | Latest timestamp signal across contract tables: Current: latest data within 1 day | Traffic counts, job exports, timesheets, capital work, reference/date/EOT, tunnel-specific contract outputs | not available |

## Source table summary

| Family | Schema/catalogue | Tables | Row count across objects | Velocity | Variety | Usage |
|---|---|---:|---:|---|---|---:|
| source | `ext_mssql_asset_vision_ven_gen7` | 38 | 24,051,436 | Current: latest data within 1 day | Asset register / hierarchy; Audit / export / system; Capital works; Forms / modules; Inspections; Jobs / work orders / defects; Other / contract-specific; Photos / evidence; Reference / contract support; Resources / timesheets; Workflow / status | not available |
| source | `ext_mssql_asset_vision_ven_rms` | 38 | 24,569,468 | Current: latest data within 1 day | Asset register / hierarchy; Audit / export / system; Capital works; Forms / modules; Inspections; Jobs / work orders / defects; Other / contract-specific; Photos / evidence; Reference / contract support; Resources / timesheets; Workflow / status | not available |
| source | `ext_mssql_asset_vision_ven_vicroads` | 40 | 0 | No timestamp signal | Asset register / hierarchy; Audit / export / system; Capital works; Forms / modules; Inspections; Jobs / work orders / defects; Lane access; Other / contract-specific; Photos / evidence; Reference / contract support; Resources / timesheets; Workflow / status | not available |
| source | `ext_mssql_asset_vision_vns_gen7` | 38 | 0 | No timestamp signal | Asset register / hierarchy; Audit / export / system; Capital works; Forms / modules; Inspections; Jobs / work orders / defects; Other / contract-specific; Photos / evidence; Reference / contract support; Resources / timesheets; Workflow / status | not available |
| source | `ext_mssql_asset_vision_vnz_gen7` | 38 | 0 | No timestamp signal | Asset register / hierarchy; Audit / export / system; Capital works; Forms / modules; Inspections; Jobs / work orders / defects; Other / contract-specific; Photos / evidence; Reference / contract support; Resources / timesheets; Workflow / status | not available |
| source | `ext_mssql_asset_vision_vsm_gen7` | 38 | 0 | No timestamp signal | Asset register / hierarchy; Audit / export / system; Capital works; Forms / modules; Inspections; Jobs / work orders / defects; Other / contract-specific; Photos / evidence; Reference / contract support; Resources / timesheets; Workflow / status | not available |

## Contract table summary

| Family | Schema/catalogue | Tables | Row count across objects | Velocity | Variety | Usage |
|---|---|---:|---:|---|---|---:|
| contract | `transport_dev.transport` | 40 | 16,519,404 | Current: latest data within 1 day | Forms / modules; Other / contract-specific; Resources / timesheets | not available |
| contract | `transport_dev.transport_aklw` | 11 | 1,822,984 | Current: latest data within 1 day | Capital works; Forms / modules; Other / contract-specific; Resources / timesheets | not available |
| contract | `transport_dev.transport_fndc` | 12 | 264,594 | Current: latest data within 1 day | Other / contract-specific | not available |
| contract | `transport_dev.transport_nel` | 4 | 11,405 | Current: latest data within 1 day | Other / contract-specific; Reference / contract support | not available |
| contract | `transport_dev.transport_ramc` | 17 | 39,868 | Recent: latest data within 31 days | Audit / export / system; Other / contract-specific | not available |
| contract | `transport_dev.transport_sht` | 27 | 165,474,873 | Stale: latest data within 180 days | Other / contract-specific | not available |
| contract | `transport_dev.transport_srapc` | 42 | 1,108 | Recent: latest data within 31 days | Asset register / hierarchy; Other / contract-specific | not available |
| contract | `transport_dev.transport_tsrc` | 88 | 829,475 | Current: latest data within 1 day | Other / contract-specific; Reference / contract support; Traffic counts | not available |
| contract | `transport_dev.transport_wru` | 78 | 48,596,573 | Current: latest data within 1 day | Asset register / hierarchy; Audit / export / system; Capital works; Lane access; Other / contract-specific; Reference / contract support; Resources / timesheets; Traffic counts | not available |

## Definitions used

- Volume: `COUNT(*)` by table, summed to schema/catalogue level.
- Velocity: inferred from the latest timestamp/date-like value found in each table. This is latest observed data freshness, not a confirmed pipeline schedule.
- Variety: classified from table names and column inventory into business/data domains.
- Veracity / usage: Databricks `system.access.table_lineage` usage events over the last 90 days when accessible.

## Output files

- `four_vs_schema_summary.csv`: boss-level schema/catalogue summary.
- `four_vs_table_metrics.csv`: table-level row count, freshness, variety and usage details.
- `table_inventory.csv`: Databricks table inventory used.
- `table_columns.csv`: Databricks column inventory used.
