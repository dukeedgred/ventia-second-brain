---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_fndc
table-name: uvw_treatment_length
full-name: transport_dev.transport_fndc.uvw_treatment_length
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-fndc]
---

# Transport Table - transport_fndc - uvw_treatment_length

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_treatment_length` |
| Full name | `transport_dev.transport_fndc.uvw_treatment_length` |
| Catalog | `transport_dev` |
| Schema | `transport_fndc` |
| Contract/schema | `transport_fndc` |
| Table type | VIEW |
| Column count | 197 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2026-06-01T23:06:40.515Z; Last altered: 2026-06-01T23:06:40.515Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
SELECT
    CAST(treat_length_id AS INT) AS treat_length_id,
    tl_name,
    road_id AS road_name,
    CAST(tl_start_m AS INT) AS tl_start_m,
    CAST(tl_end_m AS INT) AS tl_end_m,
    CAST(tl_length_m AS INT) AS tl_length_m,
    CAST(tl_area AS DECIMAL(10, 2)) AS tl_area,
    CAST(tl_wheelpath_m AS INT) AS tl_wheelpath_m,
    CAST(tl_width AS DECIMAL(10, 2)) AS tl_width,
    CAST(tl_lanes AS DECIMAL(10, 2)) AS tl_lanes,
    tl_disabled,
    tl_cost_set,
    CAST(exception_count AS INT) AS exception_count,
    pavement_type,
    pavement_use,
    urban_rural,
    full_rating,
    maint_group,
    tl_valid_ok,
    terrain,
    coastal_inland,
    est_mmp,
    asset_owner,
    cway_hierarchy,
    CAST(tl_sealed_area AS DECIMAL(10, 2)) AS tl_sealed_area,
    CAST(c_surface_id AS INT) AS c_surface_id,
    CAST(surface_date AS TIMESTAMP) AS surface_date,
    CAST(surface_covered AS DECIMAL(10, 2)) AS surface_covered,
    CAST(lg_ts_sealed_area AS DECIMAL(10, 2)) AS lg_ts_sealed_area,
    CAST(surface_length_m AS INT) AS surface_length_m,
    CAST(surf_depth AS INT) AS surf_depth,
    CAST(surf_offset AS DECIMAL(10, 2)) AS surf_offset,
    CAST(surf_width AS DECIMAL(10, 2)) AS surf_width,
    surf_material,
    surf_function,
    CAST(top_surface_life AS INT) AS top_surface_life,
    CAST(first_chip_size AS INT) AS first_chip_size,
    CAST(second_chip_size AS INT) AS second_chip_size,
    surf_binder,
    CAST(avg_surf_depth AS INT) AS avg_surf_depth,
    CAST(number_seal_layers AS INT) AS number_seal_layers,
    CAST(pct_life_achieve_1 AS INT) AS pct_life_achieve_1,
    CAST(pct_life_achieve_2 AS INT) AS pct_life_achieve_2,
    reducing_seal_life,
    surface_source,
    CAST(layer_depth AS INT) AS layer_depth,
    CAST(layer_date AS TIMESTAMP) AS layer_date,
    CAST(layer_covered AS DECIMAL(10, 2)) AS layer_covered,
    CAST(layer_start_m AS INT) AS layer_start_m,
    CAST(layer_end_m AS INT) AS layer_end_m,
    CAST(layer_length_m AS INT) AS layer_length_m,
    CAST(layer_subgrade_cbr AS DECIMAL(10, 2)) AS layer_subgrade_cbr,
    reconstructed,
    CAST(avg_pave_depth AS DECIMAL(10, 2)) AS avg_pave_depth,
    CAST(rehab_stab_depth AS DECIMAL(10, 2)) AS rehab_stab_depth,
    tl_upper_pms,
    CAST(tot_pave_depth AS INT) AS tot_pave_depth,
    layer_source,
    pave_material,
    CAST(tl_pave_area AS DECIMAL(10, 2)) AS tl_pave_area,
    CAST(tl_subgrade_area AS DECIMAL(10, 2)) AS tl_subgrade_area,
    CAST(naasra_min AS INT) AS naasra_min,
    CAST(naasra_max AS INT) AS naasra_max,
    CAST(naasra_avg AS INT) AS naasra_avg,
    CAST(naasra_stddev AS INT) AS naasra_stddev,
    naasra_avg_ok,
    CAST(naasra_length AS INT) AS naasra_length,
    CAST(naasra_max_date AS TIMESTAMP) AS naasra_max_date,
    CAST(ste_length AS DECIMAL(10, 2)) AS ste_length,
    CAST(avg_lane_iri_qc AS DECIMAL(10, 3)) AS avg_lane_iri_qc,
    CAST(hsd_iri_avg AS DECIMAL(10, 3)) AS hsd_iri_avg,
    CAST(hsd_texture_300 AS DECIMAL(10, 2)) AS hsd_texture_300,
    CAST(hsd_texture_surv_m AS INT) AS hsd_texture_surv_m,
    hsd_text_surv_num,
    CAST(hsd_texture_avg AS DECIMAL(10, 2)) AS hsd_texture_avg,
    CAST(hsd_rutting_30 AS DECIMAL(10, 2)) AS hsd_rutting_30,
    CAST(hsd_rutting_avg AS INT) AS hsd_rutting_avg,
    CAST(hsd_rutting_stddev AS DECIMAL(10, 2)) AS hsd_rutting_stddev,
    CAST(hsd_rutting_surv_m AS INT) AS hsd_rutting_surv_m,
    hsd_rut_surv_num,
    CAST(hsd_shoving AS DECIMAL(10, 2)) AS hsd_shoving,
    CAST(hsd_shoving_surv_m AS INT) AS hsd_shoving_surv_m,
    scrim_surv_num,
    scrim_surv_m,
    avg_scrim,
    avg_skid_rv,
    max_skid_rv,
    avg_rv_below_0,
    length_below_0,
    avg_rv_below_rt,
    length_below_rt,
    roll_count,
    roll_length,
    roll_avg_skid_rv,
    roll_net_avg_txt,
    roll_min_texture,
    roll_max_texture,
    misc_length,
    misc_avg_skid_rv,
    misc_net_avg_txt,
    misc_min_texture,
    misc_max_texture,
    rating_surv_num,
    CAST(insp_length AS DECIMAL(10, 3)) AS insp_length,
    CAST(insp_area AS DECIMAL(10, 3)) AS insp_area,
    CAST(insp_wheelpath AS DECIMAL(10, 3)) AS insp_wheelpath,
    CAST(surf_broke_lhs AS DECIMAL(10, 2)) AS surf_broke_lhs,
    CAST(surf_highlip_lhs AS DECIMAL(10, 2)) AS surf_highlip_lhs,
    CAST(surf_brokesurf_lhs AS DECIMAL(10, 2)) AS surf_brokesurf_lhs,
    CAST(surf_blocked_lhs AS DECIMAL(10, 2)) AS surf_blocked_lhs,
    CAST(surf_uphill_lhs AS DECIMAL(10, 2)) AS surf_uphill_lhs,
    CAST(earth_block_lhs AS DECIMAL(10, 2)) AS earth_block_lhs,
    CAST(earth_inadeq_lhs AS DECIMAL(10, 2)) AS earth_inadeq_lhs,
    CAST(ineffsh_lhs AS DECIMAL(10, 2)) AS ineffsh_lhs,
    CAST(surf_broke_rhs AS DECIMAL(10, 2)) AS surf_broke_rhs,
    CAST(surf_highlip_rhs AS DECIMAL(10, 2)) AS surf_highlip_rhs,
    CAST(surf_brokesurf_rhs AS DECIMAL(10, 2)) AS surf_brokesurf_rhs,
    CAST(surf_blocked_rhs AS DECIMAL(10, 2)) AS surf_blocked_rhs,
    CAST(surf_uphill_rhs AS DECIMAL(10, 2)) AS surf_uphill_rhs,
    CAST(earth_block_rhs AS DECIMAL(10, 2)) AS earth_block_rhs,
    CAST(earth_inadeq_rhs AS DECIMAL(10, 2)) AS earth_inadeq_rhs,
    CAST(ineffsh_rhs AS DECIMAL(10, 2)) AS ineffsh_rhs,
    swc_severity,
    CAST(rutting AS DECIMAL(10, 2)) AS rutting,
    CAST(rutting_mean_depth AS DECIMAL(10, 2)) AS rutting_mean_depth,
    CAST(rut_meandepth_sdev AS DECIMAL(10, 2)) AS rut_meandepth_sdev,
    CAST(shoving AS DECIMAL(10, 2)) AS shoving,
    CAST(scabbing AS DECIMAL(10, 2)) AS scabbing,
    CAST(flushing AS DECIMAL(10, 2)) AS flushing,
    CAST(alligator AS DECIMAL(10, 2)) AS alligator,
    CAST(l_t AS DECIMAL(10, 2)) AS l_t,
    CAST(joints AS DECIMAL(10, 2)) AS joints,
    CAST(holes AS DECIMAL(10, 2)) AS holes,
    CAST(patch AS DECIMAL(10, 2)) AS patch,
    CAST(surf_cond_index AS DECIMAL(10, 2)) AS surf_cond_index,
    CAST(sci_ci AS DECIMAL(10, 2)) AS sci_ci,
    CAST(sci_ai AS DECIMAL(10, 2)) AS sci_ai,
    CAST(pave_integ_index AS DECIMAL(10, 2)) AS pave_integ_index,
    CAST(edgeb AS DECIMAL(10, 2)) AS edgeb,
    CAST(edgeb_p AS DECIMAL(10, 2)) AS edgeb_p,
    CAST(drain_inadequate AS DECIMAL(10, 2)) AS drain_inadequate,
    CAST(avg_no_lanes_insp AS INT) AS avg_no_lanes_insp,
    CAST(prev_crack_length AS DECIMAL(10, 2)) AS prev_crack_length,
    serv_covers,
    serv_trenches,
    CAST(accident_total AS INT) AS accident_total,
    CAST(wet_acc_total AS INT) AS wet_acc_total,
    CAST(dry_acc_total AS INT) AS dry_acc_total,
    CAST(day_acc_total AS INT) AS day_acc_total,
    CAST(night_acc_total AS INT) AS night_acc_total,
    CAST(skid_acc_total AS INT) AS skid_acc_total,
    CAST(fatal_acc_total AS INT) AS fatal_acc_total,
    CAST(serious_acc_total AS INT) AS serious_acc_total,
    CAST(minor_acc_total AS INT) AS minor_acc_total,
    CAST(non_injury_acc_total AS INT) AS non_injury_acc_total,
    dtims_region,
    dtims_growth_light,
    dtims_growth_heavy,
    dtims_raise_level,
    dtims_constr_qual,
    dtims_zone,
    dtims_p020,
    dtims_p425,
    dtims_p075,
    dtims_d95,
    dtims_plasticity,
    dtims_layer_status,
    snp,
    snp_method,
    dtims_sii,
    CAST(dtims_kc_len AS INT) AS dtims_kc_len,
    dtims_ssrf,
    CAST(dtims_peak_def AS DECIMAL(10, 2)) AS dtims_peak_def,
    dtims_peak_bb,
    subnetwork,
    soil_type,
    cbr_estimate,
    pave_config,
    gradings_per_year,
    cuts_per_grading,
    tl_group_1,
    tl_group_2,
    tl_group_3,
    tl_group_4,
    tl_group_5,
    CAST(audit_date AS TIMESTAMP) AS audit_date,
    audit_note,
    likelihood_wt,
    risk_likelihood,
    consequence_wt,
    risk_consequence,
    risk,
    risk_date,
    CAST(added_on AS TIMESTAMP) AS added_on,
    added_by,
    CAST(chgd_on AS TIMESTAMP) AS chgd_on,
    chgd_by
FROM
    staged_dev.stg_api_amds_fndc_test.treatment_length
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `treat_length_id` | `int` | Yes |  |
| `tl_name` | `string` | Yes |  |
| `road_name` | `string` | Yes |  |
| `tl_start_m` | `int` | Yes |  |
| `tl_end_m` | `int` | Yes |  |
| `tl_length_m` | `int` | Yes |  |
| `tl_area` | `decimal(10,2)` | Yes |  |
| `tl_wheelpath_m` | `int` | Yes |  |
| `tl_width` | `decimal(10,2)` | Yes |  |
| `tl_lanes` | `decimal(10,2)` | Yes |  |
| `tl_disabled` | `string` | Yes |  |
| `tl_cost_set` | `string` | Yes |  |
| `exception_count` | `int` | Yes |  |
| `pavement_type` | `string` | Yes |  |
| `pavement_use` | `string` | Yes |  |
| `urban_rural` | `string` | Yes |  |
| `full_rating` | `string` | Yes |  |
| `maint_group` | `string` | Yes |  |
| `tl_valid_ok` | `string` | Yes |  |
| `terrain` | `string` | Yes |  |
| `coastal_inland` | `string` | Yes |  |
| `est_mmp` | `string` | Yes |  |
| `asset_owner` | `string` | Yes |  |
| `cway_hierarchy` | `string` | Yes |  |
| `tl_sealed_area` | `decimal(10,2)` | Yes |  |
| `c_surface_id` | `int` | Yes |  |
| `surface_date` | `timestamp` | Yes |  |
| `surface_covered` | `decimal(10,2)` | Yes |  |
| `lg_ts_sealed_area` | `decimal(10,2)` | Yes |  |
| `surface_length_m` | `int` | Yes |  |
| `surf_depth` | `int` | Yes |  |
| `surf_offset` | `decimal(10,2)` | Yes |  |
| `surf_width` | `decimal(10,2)` | Yes |  |
| `surf_material` | `string` | Yes |  |
| `surf_function` | `string` | Yes |  |
| `top_surface_life` | `int` | Yes |  |
| `first_chip_size` | `int` | Yes |  |
| `second_chip_size` | `int` | Yes |  |
| `surf_binder` | `string` | Yes |  |
| `avg_surf_depth` | `int` | Yes |  |
| `number_seal_layers` | `int` | Yes |  |
| `pct_life_achieve_1` | `int` | Yes |  |
| `pct_life_achieve_2` | `int` | Yes |  |
| `reducing_seal_life` | `string` | Yes |  |
| `surface_source` | `string` | Yes |  |
| `layer_depth` | `int` | Yes |  |
| `layer_date` | `timestamp` | Yes |  |
| `layer_covered` | `decimal(10,2)` | Yes |  |
| `layer_start_m` | `int` | Yes |  |
| `layer_end_m` | `int` | Yes |  |
| `layer_length_m` | `int` | Yes |  |
| `layer_subgrade_cbr` | `decimal(10,2)` | Yes |  |
| `reconstructed` | `string` | Yes |  |
| `avg_pave_depth` | `decimal(10,2)` | Yes |  |
| `rehab_stab_depth` | `decimal(10,2)` | Yes |  |
| `tl_upper_pms` | `string` | Yes |  |
| `tot_pave_depth` | `int` | Yes |  |
| `layer_source` | `string` | Yes |  |
| `pave_material` | `string` | Yes |  |
| `tl_pave_area` | `decimal(10,2)` | Yes |  |
| `tl_subgrade_area` | `decimal(10,2)` | Yes |  |
| `naasra_min` | `int` | Yes |  |
| `naasra_max` | `int` | Yes |  |
| `naasra_avg` | `int` | Yes |  |
| `naasra_stddev` | `int` | Yes |  |
| `naasra_avg_ok` | `string` | Yes |  |
| `naasra_length` | `int` | Yes |  |
| `naasra_max_date` | `timestamp` | Yes |  |
| `ste_length` | `decimal(10,2)` | Yes |  |
| `avg_lane_iri_qc` | `decimal(10,3)` | Yes |  |
| `hsd_iri_avg` | `decimal(10,3)` | Yes |  |
| `hsd_texture_300` | `decimal(10,2)` | Yes |  |
| `hsd_texture_surv_m` | `int` | Yes |  |
| `hsd_text_surv_num` | `string` | Yes |  |
| `hsd_texture_avg` | `decimal(10,2)` | Yes |  |
| `hsd_rutting_30` | `decimal(10,2)` | Yes |  |
| `hsd_rutting_avg` | `int` | Yes |  |
| `hsd_rutting_stddev` | `decimal(10,2)` | Yes |  |
| `hsd_rutting_surv_m` | `int` | Yes |  |
| `hsd_rut_surv_num` | `string` | Yes |  |
| `hsd_shoving` | `decimal(10,2)` | Yes |  |
| `hsd_shoving_surv_m` | `int` | Yes |  |
| `scrim_surv_num` | `string` | Yes |  |
| `scrim_surv_m` | `string` | Yes |  |
| `avg_scrim` | `string` | Yes |  |
| `avg_skid_rv` | `string` | Yes |  |
| `max_skid_rv` | `string` | Yes |  |
| `avg_rv_below_0` | `string` | Yes |  |
| `length_below_0` | `string` | Yes |  |
| `avg_rv_below_rt` | `string` | Yes |  |
| `length_below_rt` | `string` | Yes |  |
| `roll_count` | `string` | Yes |  |
| `roll_length` | `string` | Yes |  |
| `roll_avg_skid_rv` | `string` | Yes |  |
| `roll_net_avg_txt` | `string` | Yes |  |
| `roll_min_texture` | `string` | Yes |  |
| `roll_max_texture` | `string` | Yes |  |
| `misc_length` | `string` | Yes |  |
| `misc_avg_skid_rv` | `string` | Yes |  |
| `misc_net_avg_txt` | `string` | Yes |  |
| `misc_min_texture` | `string` | Yes |  |
| `misc_max_texture` | `string` | Yes |  |
| `rating_surv_num` | `string` | Yes |  |
| `insp_length` | `decimal(10,3)` | Yes |  |
| `insp_area` | `decimal(10,3)` | Yes |  |
| `insp_wheelpath` | `decimal(10,3)` | Yes |  |
| `surf_broke_lhs` | `decimal(10,2)` | Yes |  |
| `surf_highlip_lhs` | `decimal(10,2)` | Yes |  |
| `surf_brokesurf_lhs` | `decimal(10,2)` | Yes |  |
| `surf_blocked_lhs` | `decimal(10,2)` | Yes |  |
| `surf_uphill_lhs` | `decimal(10,2)` | Yes |  |
| `earth_block_lhs` | `decimal(10,2)` | Yes |  |
| `earth_inadeq_lhs` | `decimal(10,2)` | Yes |  |
| `ineffsh_lhs` | `decimal(10,2)` | Yes |  |
| `surf_broke_rhs` | `decimal(10,2)` | Yes |  |
| `surf_highlip_rhs` | `decimal(10,2)` | Yes |  |
| `surf_brokesurf_rhs` | `decimal(10,2)` | Yes |  |
| `surf_blocked_rhs` | `decimal(10,2)` | Yes |  |
| `surf_uphill_rhs` | `decimal(10,2)` | Yes |  |
| `earth_block_rhs` | `decimal(10,2)` | Yes |  |
| `earth_inadeq_rhs` | `decimal(10,2)` | Yes |  |
| `ineffsh_rhs` | `decimal(10,2)` | Yes |  |
| `swc_severity` | `string` | Yes |  |
| `rutting` | `decimal(10,2)` | Yes |  |
| `rutting_mean_depth` | `decimal(10,2)` | Yes |  |
| `rut_meandepth_sdev` | `decimal(10,2)` | Yes |  |
| `shoving` | `decimal(10,2)` | Yes |  |
| `scabbing` | `decimal(10,2)` | Yes |  |
| `flushing` | `decimal(10,2)` | Yes |  |
| `alligator` | `decimal(10,2)` | Yes |  |
| `l_t` | `decimal(10,2)` | Yes |  |
| `joints` | `decimal(10,2)` | Yes |  |
| `holes` | `decimal(10,2)` | Yes |  |
| `patch` | `decimal(10,2)` | Yes |  |
| `surf_cond_index` | `decimal(10,2)` | Yes |  |
| `sci_ci` | `decimal(10,2)` | Yes |  |
| `sci_ai` | `decimal(10,2)` | Yes |  |
| `pave_integ_index` | `decimal(10,2)` | Yes |  |
| `edgeb` | `decimal(10,2)` | Yes |  |
| `edgeb_p` | `decimal(10,2)` | Yes |  |
| `drain_inadequate` | `decimal(10,2)` | Yes |  |
| `avg_no_lanes_insp` | `int` | Yes |  |
| `prev_crack_length` | `decimal(10,2)` | Yes |  |
| `serv_covers` | `string` | Yes |  |
| `serv_trenches` | `string` | Yes |  |
| `accident_total` | `int` | Yes |  |
| `wet_acc_total` | `int` | Yes |  |
| `dry_acc_total` | `int` | Yes |  |
| `day_acc_total` | `int` | Yes |  |
| `night_acc_total` | `int` | Yes |  |
| `skid_acc_total` | `int` | Yes |  |
| `fatal_acc_total` | `int` | Yes |  |
| `serious_acc_total` | `int` | Yes |  |
| `minor_acc_total` | `int` | Yes |  |
| `non_injury_acc_total` | `int` | Yes |  |
| `dtims_region` | `string` | Yes |  |
| `dtims_growth_light` | `string` | Yes |  |
| `dtims_growth_heavy` | `string` | Yes |  |
| `dtims_raise_level` | `string` | Yes |  |
| `dtims_constr_qual` | `string` | Yes |  |
| `dtims_zone` | `string` | Yes |  |
| `dtims_p020` | `string` | Yes |  |
| `dtims_p425` | `string` | Yes |  |
| `dtims_p075` | `string` | Yes |  |
| `dtims_d95` | `string` | Yes |  |
| `dtims_plasticity` | `string` | Yes |  |
| `dtims_layer_status` | `string` | Yes |  |
| `snp` | `string` | Yes |  |
| `snp_method` | `string` | Yes |  |
| `dtims_sii` | `string` | Yes |  |
| `dtims_kc_len` | `int` | Yes |  |
| `dtims_ssrf` | `string` | Yes |  |
| `dtims_peak_def` | `decimal(10,2)` | Yes |  |
| `dtims_peak_bb` | `string` | Yes |  |
| `subnetwork` | `string` | Yes |  |
| `soil_type` | `string` | Yes |  |
| `cbr_estimate` | `string` | Yes |  |
| `pave_config` | `string` | Yes |  |
| `gradings_per_year` | `string` | Yes |  |
| `cuts_per_grading` | `string` | Yes |  |
| `tl_group_1` | `string` | Yes |  |
| `tl_group_2` | `string` | Yes |  |
| `tl_group_3` | `string` | Yes |  |
| `tl_group_4` | `string` | Yes |  |
| `tl_group_5` | `string` | Yes |  |
| `audit_date` | `timestamp` | Yes |  |
| `audit_note` | `string` | Yes |  |
| `likelihood_wt` | `string` | Yes |  |
| `risk_likelihood` | `string` | Yes |  |
| `consequence_wt` | `string` | Yes |  |
| `risk_consequence` | `string` | Yes |  |
| `risk` | `string` | Yes |  |
| `risk_date` | `string` | Yes |  |
| `added_on` | `timestamp` | Yes |  |
| `added_by` | `string` | Yes |  |
| `chgd_on` | `timestamp` | Yes |  |
| `chgd_by` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_fndc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
