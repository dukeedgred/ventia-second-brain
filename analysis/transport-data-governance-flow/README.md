# Transport Data Governance Flow

This folder splits the Transport governance/dashboard work into small Databricks SQL steps.

The bronze source-union objects are still expected to come from:

```text
analysis/asset-type-metrics/asset_type_base_tables.sql
```

## Flow

```text
bronze Asset Vision base tables
    vw_bronze_transport_asset_base
    vw_bronze_transport_job_base
    vw_bronze_transport_inspection_base
    ...

        -> silver conformed views
            asset category mapping
            contract grouping
            job / inspection / resource / timesheet asset links
            asset-level availability flags

                -> gold dashboard views
                    contract + asset category data availability
                    contract monthly KPI timeseries
                    governance field scope
                    KPI buildability register
```

## Run Order

| Order | File | Output |
|---:|---|---|
| 00 | `00_create_map_transport_contract_group.sql` | `map_transport_contract_group` |
| 01 | `01_create_silver_asset_with_category.sql` | `vw_silver_transport_asset_with_category` |
| 02 | `02_create_silver_job_asset_link.sql` | `vw_silver_transport_job_asset_link` |
| 03 | `03_create_silver_inspection_asset_link.sql` | `vw_silver_transport_inspection_asset_link` |
| 04 | `04_create_silver_photo_asset_link.sql` | `vw_silver_transport_photo_asset_link` |
| 05 | `05_create_silver_planned_resource_asset_link.sql` | `vw_silver_transport_planned_resource_asset_link` |
| 06 | `06_create_silver_timesheet_asset_link.sql` | `vw_silver_transport_timesheet_asset_link` |
| 07 | `07_create_silver_asset_data_availability_detail.sql` | `vw_silver_transport_asset_data_availability_detail` |
| 08 | `08_create_gold_contract_asset_category_data_availability.sql` | `vw_gold_transport_contract_asset_category_data_availability` |
| 09 | `09_create_gold_contract_kpi_monthly_timeseries.sql` | `vw_gold_transport_contract_kpi_monthly_timeseries` |
| 10 | `10_create_gold_governance_field_scope.sql` | `vw_gold_transport_governance_field_scope` |
| 11 | `11_create_dict_kpi_buildability.sql` | `dict_transport_kpi_buildability` |

## Naming Rules

- `map_` is a maintained mapping table.
- `dict_` is a low-volume reference/dictionary table.
- `vw_bronze_` is source standardisation.
- `vw_silver_` is conformed logic and reusable joins.
- `vw_gold_` is dashboard or governance-consumption output.
- `raw_contract_name` is the original source value.
- `standardised_contract_name` is the governed reporting contract.
- `has_*` columns are row-level flags.
- `pct_*` columns are rollup percentages.

