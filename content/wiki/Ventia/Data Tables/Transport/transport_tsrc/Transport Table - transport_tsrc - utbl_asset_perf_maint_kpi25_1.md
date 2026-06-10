---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: utbl_asset_perf_maint_kpi25_1
full-name: transport_dev.transport_tsrc.utbl_asset_perf_maint_kpi25_1
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - utbl_asset_perf_maint_kpi25_1

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_asset_perf_maint_kpi25_1` |
| Full name | `transport_dev.transport_tsrc.utbl_asset_perf_maint_kpi25_1` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | MANAGED |
| Column count | 32 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | KPI / reporting |
| Owner/SME | Helix_admins |
| Refresh/freshness | Created: 2024-07-11T21:14:03.175Z; Last altered: 2026-06-09T05:40:05.26Z |
| Source details | Data source format: DELTA |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `id` | `int` | Yes |  |
| `code` | `string` | Yes |  |
| `assettype` | `string` | Yes |  |
| `assetname` | `string` | Yes |  |
| `constructiondate` | `date` | Yes |  |
| `disposaldate` | `timestamp` | Yes |  |
| `stage` | `string` | Yes |  |
| `DrainageRiskRating` | `string` | Yes |  |
| `WAHPoints` | `string` | Yes |  |
| `AssetSubType` | `string` | Yes |  |
| `Asset_Type` | `string` | Yes |  |
| `Asset_Raised_Against` | `string` | Yes |  |
| `AV_Asset_Name` | `string` | Yes |  |
| `AV_Inspection_Name` | `string` | Yes |  |
| `Activity_Name` | `string` | Yes |  |
| `Frequency` | `string` | Yes |  |
| `ConstructionDatePlus6Months` | `string` | Yes |  |
| `ConstructionDatePlus6MonthsYN` | `string` | Yes |  |
| `EarliestStartDate` | `date` | Yes |  |
| `DueDate` | `date` | Yes |  |
| `scheduleddate` | `date` | Yes |  |
| `scheduledinspid` | `int` | Yes |  |
| `CompletedInspId` | `int` | Yes |  |
| `Completeddate` | `date` | Yes |  |
| `NonCompliantDate` | `date` | Yes |  |
| `ComplianceStatus` | `string` | Yes |  |
| `ScheduledStatus` | `string` | Yes |  |
| `AbatementCostKey` | `string` | Yes |  |
| `AV_Link` | `string` | Yes |  |
| `AssessmentDate` | `date` | Yes |  |
| `AdditionalRectificationPeriod` | `int` | Yes |  |
| `ReqInspId` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
