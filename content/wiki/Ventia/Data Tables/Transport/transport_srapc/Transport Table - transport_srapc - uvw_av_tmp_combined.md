---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_srapc
table-name: uvw_av_tmp_combined
full-name: transport_dev.transport_srapc.uvw_av_tmp_combined
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-srapc]
---

# Transport Table - transport_srapc - uvw_av_tmp_combined

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_av_tmp_combined` |
| Full name | `transport_dev.transport_srapc.uvw_av_tmp_combined` |
| Catalog | `transport_dev` |
| Schema | `transport_srapc` |
| Contract/schema | `transport_srapc` |
| Table type | VIEW |
| Column count | 69 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | staging / backup |
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2024-05-27T05:35:32.361Z; Last altered: 2024-07-18T20:30:59.777Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
SELECT
  *
FROM
  transport_dev.transport_srapc.uvw_jobs_actgroup
  LEFT JOIN transport_dev.transport_srapc.utbl_tmp_civil_master ON interventionname = Mapped_AV_Activity
WHERE
  STATUS = 'Open'
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Job ID` | `int` | Yes |  |
| `Asset Group` | `string` | No |  |
| `TMP Number` | `string` | Yes |  |
| `interventionname` | `string` | Yes |  |
| `Activity Name` | `string` | Yes |  |
| `Priority` | `string` | Yes |  |
| `Latitude` | `binary` | Yes |  |
| `Longitude` | `binary` | Yes |  |
| `Created Date` | `timestamp` | Yes |  |
| `Created Month` | `string` | Yes |  |
| `Due Date` | `timestamp` | Yes |  |
| `Status` | `string` | Yes |  |
| `Rectified Date` | `timestamp` | Yes |  |
| `Current Workflow Status Name` | `string` | Yes |  |
| `DueDate` | `timestamp` | Yes |  |
| `Record_No.` | `bigint` | Yes |  |
| `Asset_Group` | `string` | Yes |  |
| `Asset_Group__level_1` | `string` | Yes |  |
| `Asset_Class__level_2` | `string` | Yes |  |
| `Asset_Type__level_3` | `string` | Yes |  |
| `Asset_Component__Level_4` | `string` | Yes |  |
| `FMECA_Ref._No.` | `string` | Yes |  |
| `Functional_Failure` | `string` | Yes |  |
| `Potential_Failure_Mode___Including_but_not_inclusive_of` | `string` | Yes |  |
| `TMP_No.` | `string` | Yes |  |
| `Mapped_AV_Activity` | `string` | Yes |  |
| `Effect_of_Failure` | `string` | Yes |  |
| `Potential_Root_Cause___including_but_not_inclusive_of_` | `string` | Yes |  |
| `Likelihood` | `string` | Yes |  |
| `R__Reliability_` | `string` | Yes |  |
| `A__Availability_` | `string` | Yes |  |
| `M__Maintainability_` | `string` | Yes |  |
| `S__Safety_` | `string` | Yes |  |
| `Se___Security_` | `string` | Yes |  |
| `He__Health_` | `string` | Yes |  |
| `En__Environment_` | `string` | Yes |  |
| `Ec__Economics_` | `string` | Yes |  |
| `P__Political_` | `string` | Yes |  |
| `Risk_Rating` | `string` | Yes |  |
| `RONOF` | `string` | Yes |  |
| `Pavement_Health_Index` | `string` | Yes |  |
| `ARL` | `string` | Yes |  |
| `SEC` | `string` | Yes |  |
| `HSEC` | `string` | Yes |  |
| `SC` | `string` | Yes |  |
| `EC` | `string` | Yes |  |
| `HEC` | `string` | Yes |  |
| `No_of_Tasks` | `bigint` | Yes |  |
| `Defect_identification__Evident_or_Hidden_` | `string` | Yes |  |
| `Type_of_Maintenance_Task` | `string` | Yes |  |
| `Latitude__Days_` | `string` | Yes |  |
| `Assessment_Criteria` | `string` | Yes |  |
| `Intervention_Level` | `string` | Yes |  |
| `Immediate_Response_Time` | `string` | Yes |  |
| `Permanent_Rectification_Time` | `string` | Yes |  |
| `P-F_Interval` | `string` | Yes |  |
| `Proposed_Maintenance_Activity` | `string` | Yes |  |
| `Proposed_Maintenance_Activity_2` | `string` | Yes |  |
| `Maintenance_Scheduled_Interval__Aggregation_` | `string` | Yes |  |
| `Potential_Failure_to_Functional_Failure` | `string` | Yes |  |
| `Potential_Failure_to_Functional_Failure___Unit_` | `string` | Yes |  |
| `Failure_Rate__days_` | `string` | Yes |  |
| `Prob._Of_Human_Error` | `string` | Yes |  |
| `Acceptable_Prob_of_Human_Error` | `string` | Yes |  |
| `No._Inspections_in_PF_Interval` | `string` | Yes |  |
| `Task_Interval__Days_` | `string` | Yes |  |
| `Task_Interval__Months_` | `string` | Yes |  |
| `Task_Interval__Years_` | `string` | Yes |  |
| `Comments` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_srapc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
