---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_fndc
table-name: uvw_mt_dispatch
full-name: transport_dev.transport_fndc.uvw_mt_dispatch
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-fndc]
---

# Transport Table - transport_fndc - uvw_mt_dispatch

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_mt_dispatch` |
| Full name | `transport_dev.transport_fndc.uvw_mt_dispatch` |
| Catalog | `transport_dev` |
| Schema | `transport_fndc` |
| Contract/schema | `transport_fndc` |
| Table type | VIEW |
| Column count | 94 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2026-06-03T04:09:13.767Z; Last altered: 2026-06-03T04:09:13.767Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
SELECT
    contract_id AS contract_name,
    CAST(dispatch_id AS INT) as dispatch_id,
    assigned_to,
    assigned_patrol_id,
    job_manager_client,
    job_manager_contractor,
    road_id as road_name,
    CAST(start_m AS INT) as start_m,
    CAST(end_m AS INT) as end_m,
    side,
    CAST(offset AS DECIMAL(5,2)) AS offset,
    house_no,
    feature,
    CAST(easting AS DECIMAL(14,4)) AS easting,
    CAST(northing AS DECIMAL(14,4)) AS northing,
    gps_date,
    gps_by,
    gps_method_id,
    gps_from_asset,
    asset_type,
    CAST(system_id AS INT) AS system_id,
    likely_column_id,
    CAST(likely_id AS INT) AS likely_id,
    asset_update_rqd,
    CAST(length_m AS DECIMAL(5,2)) AS length_m,
    CAST(width AS DECIMAL(5,2)) AS width,
    CAST(depth AS DECIMAL(5,2)) AS depth,
    CAST(est_quantity AS DECIMAL(5,2)) AS est_quantity,
    est_quantity_user,
    est_units,
    est_units_user,
    external_id,
    tmu_external_id,
    police_event_id,
    notes,
    notes_maintenance,
    item_type,
    fault,
    fault_desc,
    disp_group_1,
    disp_group_2,
    disp_group_3,
    disp_group_4,
    disp_group_5,
    priority,
    programme_id,
    programme_category,
    programmed_by,
    CAST(programmed_date AS TIMESTAMP) AS programmed_date,
    view_status,
    call_type,
    first_name,
    surname,
    contact_phone,
    contact_mobile,
    patrol_id,
    cyclic_patrol_id,
    template_job_id AS template_job_name,
    dispatch_claim_sw,
    dispatch_auto_claim_done,
    unread_progress_sw,
    mc_cost_group,
    mc_activity,
    mc_fault,
    mc_failure,
    call_status,
    CAST(call_entered AS TIMESTAMP) AS call_entered,
    CAST(call_dispatched AS TIMESTAMP) AS call_dispatched,
    CAST(call_time_on_site AS TIMESTAMP) AS call_time_on_site,
    CAST(call_complete AS TIMESTAMP) AS call_complete,
    CAST(call_complete_expected AS TIMESTAMP) AS call_complete_expected,
    CAST(call_complete_actual AS TIMESTAMP) AS call_complete_actual,
    CAST(ccentre_enter_date AS TIMESTAMP) AS ccentre_enter_date,
    CAST(call_responded AS TIMESTAMP) AS call_responded,
    call_responded_by,
    response_time_id,
    CAST(response_time_target AS INT) AS response_time_target,
    CAST(response_time_actual AS INT) AS response_time_actual,
    response_time_band,
    locked,
    job_marker,
    claim_group_1,
    claim_group_2,
    inspection,
    rework,
    CAST(proposed_start_date AS TIMESTAMP) AS proposed_start_date,
    CAST(estimated_time_to_complete AS INT) AS estimated_time_to_complete,
    CAST(added_on AS TIMESTAMP) AS added_on,
    added_by,
    CAST(chgd_on AS TIMESTAMP) AS chgd_on,
    chgd_by,
    fault_hierarchy_1,
    fault_hierarchy_2,
    fault_hierarchy_3
FROM
    staged_dev.stg_api_amds_fndc_test.mt_dispatch
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `contract_name` | `string` | Yes |  |
| `dispatch_id` | `int` | Yes |  |
| `assigned_to` | `string` | Yes |  |
| `assigned_patrol_id` | `string` | Yes |  |
| `job_manager_client` | `string` | Yes |  |
| `job_manager_contractor` | `string` | Yes |  |
| `road_name` | `string` | Yes |  |
| `start_m` | `int` | Yes |  |
| `end_m` | `int` | Yes |  |
| `side` | `string` | Yes |  |
| `offset` | `decimal(5,2)` | Yes |  |
| `house_no` | `string` | Yes |  |
| `feature` | `string` | Yes |  |
| `easting` | `decimal(14,4)` | Yes |  |
| `northing` | `decimal(14,4)` | Yes |  |
| `gps_date` | `string` | Yes |  |
| `gps_by` | `string` | Yes |  |
| `gps_method_id` | `string` | Yes |  |
| `gps_from_asset` | `string` | Yes |  |
| `asset_type` | `string` | Yes |  |
| `system_id` | `int` | Yes |  |
| `likely_column_id` | `string` | Yes |  |
| `likely_id` | `int` | Yes |  |
| `asset_update_rqd` | `string` | Yes |  |
| `length_m` | `decimal(5,2)` | Yes |  |
| `width` | `decimal(5,2)` | Yes |  |
| `depth` | `decimal(5,2)` | Yes |  |
| `est_quantity` | `decimal(5,2)` | Yes |  |
| `est_quantity_user` | `string` | Yes |  |
| `est_units` | `string` | Yes |  |
| `est_units_user` | `string` | Yes |  |
| `external_id` | `string` | Yes |  |
| `tmu_external_id` | `string` | Yes |  |
| `police_event_id` | `string` | Yes |  |
| `notes` | `string` | Yes |  |
| `notes_maintenance` | `string` | Yes |  |
| `item_type` | `string` | Yes |  |
| `fault` | `string` | Yes |  |
| `fault_desc` | `string` | Yes |  |
| `disp_group_1` | `string` | Yes |  |
| `disp_group_2` | `string` | Yes |  |
| `disp_group_3` | `string` | Yes |  |
| `disp_group_4` | `string` | Yes |  |
| `disp_group_5` | `string` | Yes |  |
| `priority` | `string` | Yes |  |
| `programme_id` | `string` | Yes |  |
| `programme_category` | `string` | Yes |  |
| `programmed_by` | `string` | Yes |  |
| `programmed_date` | `timestamp` | Yes |  |
| `view_status` | `string` | Yes |  |
| `call_type` | `string` | Yes |  |
| `first_name` | `string` | Yes |  |
| `surname` | `string` | Yes |  |
| `contact_phone` | `string` | Yes |  |
| `contact_mobile` | `string` | Yes |  |
| `patrol_id` | `string` | Yes |  |
| `cyclic_patrol_id` | `string` | Yes |  |
| `template_job_name` | `string` | Yes |  |
| `dispatch_claim_sw` | `string` | Yes |  |
| `dispatch_auto_claim_done` | `string` | Yes |  |
| `unread_progress_sw` | `string` | Yes |  |
| `mc_cost_group` | `string` | Yes |  |
| `mc_activity` | `string` | Yes |  |
| `mc_fault` | `string` | Yes |  |
| `mc_failure` | `string` | Yes |  |
| `call_status` | `string` | Yes |  |
| `call_entered` | `timestamp` | Yes |  |
| `call_dispatched` | `timestamp` | Yes |  |
| `call_time_on_site` | `timestamp` | Yes |  |
| `call_complete` | `timestamp` | Yes |  |
| `call_complete_expected` | `timestamp` | Yes |  |
| `call_complete_actual` | `timestamp` | Yes |  |
| `ccentre_enter_date` | `timestamp` | Yes |  |
| `call_responded` | `timestamp` | Yes |  |
| `call_responded_by` | `string` | Yes |  |
| `response_time_id` | `string` | Yes |  |
| `response_time_target` | `int` | Yes |  |
| `response_time_actual` | `int` | Yes |  |
| `response_time_band` | `string` | Yes |  |
| `locked` | `string` | Yes |  |
| `job_marker` | `string` | Yes |  |
| `claim_group_1` | `string` | Yes |  |
| `claim_group_2` | `string` | Yes |  |
| `inspection` | `string` | Yes |  |
| `rework` | `string` | Yes |  |
| `proposed_start_date` | `timestamp` | Yes |  |
| `estimated_time_to_complete` | `int` | Yes |  |
| `added_on` | `timestamp` | Yes |  |
| `added_by` | `string` | Yes |  |
| `chgd_on` | `timestamp` | Yes |  |
| `chgd_by` | `string` | Yes |  |
| `fault_hierarchy_1` | `string` | Yes |  |
| `fault_hierarchy_2` | `string` | Yes |  |
| `fault_hierarchy_3` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_fndc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
