---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_a_minor_culverts
full-name: transport_dev.transport_wru.uvw_a_minor_culverts
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_a_minor_culverts

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_a_minor_culverts` |
| Full name | `transport_dev.transport_wru.uvw_a_minor_culverts` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 53 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-06-12T04:54:48.542Z; Last altered: 2024-09-24T01:42:21.621Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
  WITH assetregister as (
    SELECT
      asset.id as Asset_ID,
      asset.code as Asset_Code,
      asset.name as asset_name,
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
      assettype = "Minor Culverts" --and stage <> "Disposed"
  )
  SELECT
    *
  FROM
    assetregister PIVOT (
      max(value) for name in (
        'Unique number derived from pit numbers' unique_number_derived_from_pit_numbers,
        'CUL_LEN',
        'UP_PIT_NO',
        'Drainage Class Risk Classification Score' drainage_class_risk_classification_score,
        'CUL_HEI',
        'RL_RN_MAT',
        'st_length',
        'Downstream Pit Number' downstream_pit_number,
        'PIPE_CON',
        'CUL_DI_WID',
        'Warranty/Defect Liability Date' warranty_defect_liability_date,
        'Pipe Shape' pipe_shape,
        'Consequence - RMC Rating Score' consequence_RMC_rating_score,
        'CUL_TYPE',
        'Consequence - Urban and Rural Score' consequence_urban_rural_score,
        'DS_IL',
        'Internal pipe Diameter or Width (mm)' internal_pipe_diameter_or_width_mm,
        'Relined or renewed material' relined_or_renewed_material,
        'Non Circular Pipe height (mm)' non_circular_pipe_height_mm,
        'Upstream X Coordinate' upstream_x_coordinate,
        'Upstream Y Coordinate' upstream_y_coordinate,
        'Unique reference from pit numbers' unique_reference_from_pit_numbers,
        'Downstream Invert Level' downstream_invert_level,
        'Likelihood - RM Code 413, 414 & 613 Score' likelihood_RM_code_413_414_and_613_score,
        'RL_RN_MTD',
        'DN_PIT_NO',
        'Upstream end-of-pipe Invert Level' upstream_end_of_pipe_invert_level,
        'Downstream Y Coordinate' downstream_y_coordinate,
        'Drainage Class Risk Classification' drainage_class_risk_classification,
        'PIPE_NO',
        'sys_attr_l',
        'PIPE_MAT',
        '2nd pipe diameter (mm)' second_pipe_diameter_mm,
        'Upstream Pit Number' upstream_pit_number,
        'WIDTH2',
        'Downstream Pit' downstream_pit,
        'Pipe material' pipe_material,
        'Relining or Renewal Method' relining_or_renewal_method,
        'Downstream X Coordinate' downstream_x_coordinate,
        'Likelihood ERR Incident Register Score' likelihood_ERR_incident_register_score,
        'Pipe section length (m)' pipe_section_length_m,
        'Pipe configuration' pipe_configuration,
        'Upstream Pit' upstream_pit,
        'PSHAPE',
        'Pipe Type' pipe_type,
        'Number of Cells' number_of_cells
      )
    )
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Asset_ID` | `int` | Yes |  |
| `Asset_Code` | `string` | Yes |  |
| `asset_name` | `string` | Yes |  |
| `notes` | `string` | Yes |  |
| `alertnotes` | `string` | Yes |  |
| `assetcondition` | `string` | Yes |  |
| `assetcondition_int` | `int` | Yes |  |
| `unique_number_derived_from_pit_numbers` | `string` | Yes |  |
| `CUL_LEN` | `string` | Yes |  |
| `UP_PIT_NO` | `string` | Yes |  |
| `drainage_class_risk_classification_score` | `string` | Yes |  |
| `CUL_HEI` | `string` | Yes |  |
| `RL_RN_MAT` | `string` | Yes |  |
| `st_length` | `string` | Yes |  |
| `downstream_pit_number` | `string` | Yes |  |
| `PIPE_CON` | `string` | Yes |  |
| `CUL_DI_WID` | `string` | Yes |  |
| `warranty_defect_liability_date` | `string` | Yes |  |
| `pipe_shape` | `string` | Yes |  |
| `consequence_RMC_rating_score` | `string` | Yes |  |
| `CUL_TYPE` | `string` | Yes |  |
| `consequence_urban_rural_score` | `string` | Yes |  |
| `DS_IL` | `string` | Yes |  |
| `internal_pipe_diameter_or_width_mm` | `string` | Yes |  |
| `relined_or_renewed_material` | `string` | Yes |  |
| `non_circular_pipe_height_mm` | `string` | Yes |  |
| `upstream_x_coordinate` | `string` | Yes |  |
| `upstream_y_coordinate` | `string` | Yes |  |
| `unique_reference_from_pit_numbers` | `string` | Yes |  |
| `downstream_invert_level` | `string` | Yes |  |
| `likelihood_RM_code_413_414_and_613_score` | `string` | Yes |  |
| `RL_RN_MTD` | `string` | Yes |  |
| `DN_PIT_NO` | `string` | Yes |  |
| `upstream_end_of_pipe_invert_level` | `string` | Yes |  |
| `downstream_y_coordinate` | `string` | Yes |  |
| `drainage_class_risk_classification` | `string` | Yes |  |
| `PIPE_NO` | `string` | Yes |  |
| `sys_attr_l` | `string` | Yes |  |
| `PIPE_MAT` | `string` | Yes |  |
| `second_pipe_diameter_mm` | `string` | Yes |  |
| `upstream_pit_number` | `string` | Yes |  |
| `WIDTH2` | `string` | Yes |  |
| `downstream_pit` | `string` | Yes |  |
| `pipe_material` | `string` | Yes |  |
| `relining_or_renewal_method` | `string` | Yes |  |
| `downstream_x_coordinate` | `string` | Yes |  |
| `likelihood_ERR_incident_register_score` | `string` | Yes |  |
| `pipe_section_length_m` | `string` | Yes |  |
| `pipe_configuration` | `string` | Yes |  |
| `upstream_pit` | `string` | Yes |  |
| `PSHAPE` | `string` | Yes |  |
| `pipe_type` | `string` | Yes |  |
| `number_of_cells` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
