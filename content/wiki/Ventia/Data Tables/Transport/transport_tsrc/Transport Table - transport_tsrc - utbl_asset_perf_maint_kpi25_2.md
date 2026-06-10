---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: utbl_asset_perf_maint_kpi25_2
full-name: transport_dev.transport_tsrc.utbl_asset_perf_maint_kpi25_2
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - utbl_asset_perf_maint_kpi25_2

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_asset_perf_maint_kpi25_2` |
| Full name | `transport_dev.transport_tsrc.utbl_asset_perf_maint_kpi25_2` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | MANAGED |
| Column count | 33 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | KPI / reporting |
| Owner/SME | Helix_admins |
| Refresh/freshness | Created: 2024-07-22T01:54:45.905Z; Last altered: 2026-06-09T05:40:04.912Z |
| Source details | Data source format: DELTA |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `id` | `int` | Yes |  |
| `code` | `string` | Yes |  |
| `assettype` | `string` | Yes |  |
| `AssetSubType` | `string` | Yes |  |
| `constructiondate` | `date` | Yes |  |
| `disposaldate` | `date` | Yes |  |
| `stage` | `string` | Yes |  |
| `Asset_Raised_Against` | `string` | Yes |  |
| `Asset_Type` | `string` | Yes |  |
| `Activity_Name` | `string` | Yes |  |
| `Activity_Category_Name` | `string` | Yes |  |
| `Activity_Code` | `string` | Yes |  |
| `Intervention_Code` | `string` | Yes |  |
| `Intervention_Name` | `string` | Yes |  |
| `Activity_Category_Code2` | `string` | Yes |  |
| `Activity_Code2` | `string` | Yes |  |
| `Intervention_Code2` | `string` | Yes |  |
| `InterventionCodeNewSpec` | `string` | Yes |  |
| `InterventionCodeOldSpec` | `string` | Yes |  |
| `Frequency` | `string` | Yes |  |
| `EarliestStartDate` | `date` | Yes |  |
| `DueDate` | `date` | Yes |  |
| `scheduleddate` | `date` | Yes |  |
| `scheduledinspid` | `int` | Yes |  |
| `CompletedJobId` | `int` | Yes |  |
| `Completeddate` | `date` | Yes |  |
| `NonCompliantDate` | `date` | Yes |  |
| `ComplianceStatus` | `string` | Yes |  |
| `ScheduledStatus` | `string` | Yes |  |
| `ReqMaintId` | `string` | Yes |  |
| `AV_Link` | `string` | Yes |  |
| `AssessmentDate` | `date` | Yes |  |
| `AdditionalRectificationPeriod` | `int` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
