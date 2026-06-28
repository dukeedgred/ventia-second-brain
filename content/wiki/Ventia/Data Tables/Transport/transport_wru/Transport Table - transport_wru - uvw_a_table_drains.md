---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_a_table_drains
full-name: transport_dev.transport_wru.uvw_a_table_drains
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_a_table_drains

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_a_table_drains` |
| Full name | `transport_dev.transport_wru.uvw_a_table_drains` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 19 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-06-12T05:16:33.575Z; Last altered: 2024-09-24T01:42:35.684Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
  WITH assetregister as (
    SELECT
      asset.id as Asset_ID,
      asset.code,
      asset.notes,
      asset.alertnotes,
      asset.assetcondition,
      int(left(asset.assetcondition, 1)) as assetcondition_int,
      assetattribute.name,
      assetattribute.value
    FROM
      ext_mssql_asset_vision_ven_vicroads.dbo.asset
      INNER JOIN ext_mssql_asset_vision_ven_vicroads.dbo.assetattribute ON asset.id = assetattribute.assetid
    WHERE
      assettype = 'Table Drain'
      and stage <> "Disposed"
  )
  SELECT
    *
  FROM
    assetregister PIVOT (
      max(value) for name in (
        'Length (m)' length_m,
        'Depth (m)' depth_m,
        'Width (m)' width_m,
        'Table Drain Shape' table_drain_shape,
        'Table Drain Material' table_drain_material,
        'Authority Responsible For Maintenance' authority_responsible_for_maintenance,
        'Warranty/Defect Liability Date' warranty_defect_liability_date,
        'Likelihood - RM Code 413, 414 & 613 Score' likelihood_rm_code_413_414_613,
        'Likelihood ERR Incident Register Score' likelihood_err,
        'Consequence - Urban and Rural Score' consequence_urban_rural_score,
        'Consequence - RMC Rating Score' consequence_rmc_rating,
        'Drainage Class Risk Classification Score' drainage_class_risk_classification_score,
        'Drainage Class Risk Classification' drainage_risk_classification
      )
    )
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Asset_ID` | `int` | Yes |  |
| `code` | `string` | Yes |  |
| `notes` | `string` | Yes |  |
| `alertnotes` | `string` | Yes |  |
| `assetcondition` | `string` | Yes |  |
| `assetcondition_int` | `int` | Yes |  |
| `length_m` | `string` | Yes |  |
| `depth_m` | `string` | Yes |  |
| `width_m` | `string` | Yes |  |
| `table_drain_shape` | `string` | Yes |  |
| `table_drain_material` | `string` | Yes |  |
| `authority_responsible_for_maintenance` | `string` | Yes |  |
| `warranty_defect_liability_date` | `string` | Yes |  |
| `likelihood_rm_code_413_414_613` | `string` | Yes |  |
| `likelihood_err` | `string` | Yes |  |
| `consequence_urban_rural_score` | `string` | Yes |  |
| `consequence_rmc_rating` | `string` | Yes |  |
| `drainage_class_risk_classification_score` | `string` | Yes |  |
| `drainage_risk_classification` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
