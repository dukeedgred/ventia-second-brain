# Asset Type Metrics

This folder contains the repeatable Databricks-backed workflow used to build the Transport asset-type metrics markdown page and dashboard tables.

## SQL-first Run

Use these in Databricks SQL if you want to avoid the Python script.

```sql
-- 1. Create/refresh the raw AssetType to standardised taxonomy mapping.
-- analysis/deterioration-analysis/create_asset_type_category_map.sql

-- 2. Create/refresh narrow source-union base tables.
-- analysis/asset-type-metrics/asset_type_base_tables.sql

-- 3. Create/refresh the detail-grain table from active Asset Vision sources.
-- analysis/asset-type-metrics/create_atm_detail_table_from_sources.sql

-- 4. Recreate dashboard/helper tables from the detail table.
-- analysis/asset-type-metrics/create_atm_dashboard_tables.sql
```

The base script recreates:

- `atm_source_contexts`
- `atm_asset_base`
- `atm_asset_location_base`
- `atm_asset_attribute_base`
- `atm_job_base`
- `atm_job_asset_base`
- `atm_inspection_base`
- `atm_capitalwork_base`
- `atm_photo_base`

The detail script recreates:

- `atm_asset_type_metrics_detail`

The dashboard script recreates:

- `atm_asset_type_metrics_summary`
- `atm_asset_type_source_contract_breakdown`
- `atm_asset_type_mapping`
- `atm_metric_dictionary`
- `atm_run_status`

## Full Python Refresh

```powershell
python analysis\asset-type-metrics\fetch_asset_type_metrics.py
```

Use Python only when you need the full live source refresh, markdown regeneration, CSV/JSON outputs, or re-publication of every `atm_` table from raw Asset Vision sources. The script uses the Databricks CLI OAuth profile from `DATABRICKS_CONFIG_PROFILE`, defaulting to `ventia-transport`, and SQL warehouse `DATABRICKS_WAREHOUSE_ID`, defaulting to `e736bc08efffb739`.

## Databricks Targets

- Catalog: `transport_dev`
- Schema: `integ_transport_assets`
- Prefix: `atm_`
- Last generated at: `2026-06-17T07:45:45+00:00`

| Table | Rows | Grain | Use |
|---|---:|---|---|
| `transport_dev.integ_transport_assets.atm_asset_type_metrics_summary` | 227 | standardised asset type | Primary dashboard table with numeric coverage rates. |
| `transport_dev.integ_transport_assets.atm_asset_type_metrics_detail` | 421 | source context + contract + raw asset type | Drill-down table for raw Asset Vision type/source/contract slices. |
| `transport_dev.integ_transport_assets.atm_asset_type_source_contract_breakdown` | 421 | standardised asset type + source + contract | Source/contract coverage matrix. |
| `transport_dev.integ_transport_assets.atm_asset_type_mapping` | 245 | raw asset type | Raw-to-standardised naming audit. |
| `transport_dev.integ_transport_assets.atm_metric_dictionary` | 20 | metric definition | Definitions and caveats for dashboard tooltips or documentation. |
| `transport_dev.integ_transport_assets.atm_run_status` | 8 | source context refresh status | Refresh status, skipped contexts, and loaded asset counts. |

## Local Outputs

- `output/asset_type_metrics_summary.csv`: standardised asset-type summary for quick spreadsheet checks.
- `output/asset_type_metrics_raw.json`: full local payload including detail rows, standardised rows, skipped sources, and published table names.
- `output/asset_type_metrics_queries.sql`: source aggregate SQL used for each Asset Vision source context.
- `output/published_tables.json`: machine-readable list of created Databricks tables, row counts, grains, and dashboard uses.
- `asset_type_base_tables.sql`: narrow source-union base tables for assets, locations, attributes, jobs, job-asset links, inspections, capital works, photos, and source contexts.
- `create_atm_detail_table_from_sources.sql`: concise Databricks SQL refresh for the detail table from active Asset Vision source catalogues.
- `create_atm_dashboard_tables.sql`: concise Databricks SQL refresh for dashboard/helper tables from the detail table.

## Notes

- Tables are recreated on every run.
- Generated metrics are proxy metrics unless explicitly source-populated; use `atm_metric_dictionary` for formula/caveat text.
- `atm_asset_type_metrics_summary` is the best starting point for Databricks dashboard visuals.
