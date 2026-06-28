---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_srapc
table-name: uvw_srapc_special_projects
full-name: transport_dev.transport_srapc.uvw_srapc_special_projects
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-srapc]
---

# Transport Table - transport_srapc - uvw_srapc_special_projects

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_srapc_special_projects` |
| Full name | `transport_dev.transport_srapc.uvw_srapc_special_projects` |
| Catalog | `transport_dev` |
| Schema | `transport_srapc` |
| Contract/schema | `transport_srapc` |
| Table type | VIEW |
| Column count | 94 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2026-06-05T04:32:45.898Z; Last altered: 2026-06-05T04:32:45.898Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
WITH combinedissues AS (
    SELECT
        i.issue_id,
        i.key,
        i.summary,
        i.issue_type,
        i.status,
        i.priority,
        i.assignee,
        i.reporter,
        i.created,
        i.updated,
        i.resolved,
        i.labels,
        c.field_name,
        c.value
    FROM
        staged_dev.stg_api_jira_proj_tran_srapc.issues i
            LEFT JOIN staged_dev.stg_api_jira_proj_tran_srapc.custom_fields c
                ON i.key = c.issue_key
)
SELECT
    *
FROM
    combinedissues
        PIVOT (
            MAX(value) FOR field_name IN (
                'Estimator Name' AS `Estimator Name`,
                'Project Team' AS `Project Team`,
                'Finance Team' AS `Finance Team`,
                'Category of Tender' AS `Category of Tender`,
                'Description' AS `Description`,
                'Variation' AS `Variation`,
                'Variation Description' AS `Variation Description`,
                'TfNSW Reference Number' AS `TfNSW Reference Number`,
                'TfNSW Project WBS' AS `TfNSW Project WBS`,
                'Project Year' AS `Project Year`,
                'Date Received' AS `Date Received`,
                'Date Submitted' AS `Date Submitted`,
                'Project Awarded?' AS `Project Awarded?`,
                'Date Approved/Rejected' AS `Date Approved/Rejected`,
                'Ventia Acceptance' AS `Ventia Acceptance`,
                'RFQ' AS `RFQ`,
                'Proposed Due Date' AS `Proposed Due Date`,
                'Quotation Required From' AS `Quotation Required From`,
                'Likelihood Winning' AS `Likelihood Winning`,
                'Commercial Mechanism' AS `Commercial Mechanism`,
                'Budget/Estimate - Fixed Price' AS `Budget/Estimate - Fixed Price`,
                'Budget/Estimate - Prov Sums' AS `Budget/Estimate - Prov Sums`,
                'Budget/Estimate Combined' AS `Budget/Estimate Combined`,
                'TfNSW Contact Name' AS `TfNSW Contact Name`,
                'TfNSW Phone Number' AS `TfNSW Phone Number`,
                'TfNSW Email Address' AS `TfNSW Email Address`,
                'Finalisation Handover completed?' AS `Finalisation Handover completed?`,
                'Rejection Reason' AS `Rejection Reason`,
                'HLCE - High Level Cost Estimate Submission Date' AS `Estimates - HLCE`,
                'HLCE –High Level Cost Estimate' AS `Estimates - HLCE Due Date`,
                'HLCE –High Level Cost Estimate Due Date' AS `Estimates - HLCE Submission Date`,
                'SD HLCE - Strategic Design High Level Cost Estimate' AS `Estimates - SD HLCE`,
                'SD HLCE - Strategic Design High Level Cost Estimate Due Date' AS `Estimates - SD HLCE Due Date`,
                'SD HLCE - Strategic Design High Level Submission Date' AS `Estimates - SD HLCE Submission Date`,
                '50% CD HLCE - Concept Design High Level Cost Submission Date' AS `Estimates - 50% CD HLCE`,
                '50% CD HLCE-Concept Design High Level Cost Estimate' AS `Estimates - 50% CD HLCE Due Date`,
                '50% CD HLCE-Concept Design High Level Cost Estimate Due Date' AS `Estimates - 50% CD HLCE Submission Date`,
                '100% CD HLCE - Concept Design High Level Cost Estimate' AS `Estimates - 100% CD HLCE`,
                '100% CD HLCE - Concept Design High Level Cost Estimate Due Date' AS `Estimates - 100% CD HLCE Due Date`,
                '100% CD HLCE - Concept Design High Level Cost Estimate Submission Date' AS `Estimates - 100% CD HLCE Submission Date`,
                '20% DD HLCE – Detailed Design High Level Cost Estimate' AS `Estimates - 20% DD HLCE`,
                '20% DD HLCE – Detailed Design High Level Cost Estimate Due Date' AS `Estimates - 20% DD HLCE Due Date`,
                '20% DD HLCE – Detailed Design High Level Cost Estimate Submission Date' AS `Estimates - 20% DD HLCE Submission Date`,
                '50% DD HLCE – Detailed Design High Level Cost Estimate' AS `Estimates - 50% DD HLCE`,
                '50% DD HLCE – Detailed Design High Level Cost Estimate Due Date' AS `Estimates - 50% DD HLCE Due Date`,
                '50% DD HLCE – Detailed Design High Level Cost Estimate Submission Date' AS `Estimates - 50% DD HLCE Submission Date`,
                '80% DD HLCE– Detailed Design High Level Cost Estimate' AS `Estimates - 80% DD HLCE`,
                '80% DD HLCE– Detailed Design High Level Cost Estimate Due Date' AS `Estimates - 80% DD HLCE Due Date`,
                '80% DD HLCE– Detailed Design High Level Cost Estimate Submission Date' AS `Estimates - 80% DD HLCE Submission Date`,
                '100% DD Construction Proposal – Detailed Design Construction Proposal' AS `Estimates - 100% DD Construction Proposal`,
                '100% DD Construction Proposal – Detailed Design Construction Proposal Due Date' AS `Estimates - 100% DD Construction Proposal Due Date`,
                '100% DD Construction Proposal – Detailed Design Construction Proposal Submission Date' AS `Estimates - 100% DD Construction Proposal Submission Date`,
                'AFC Construction Proposal ' AS `Estimates - AFC Construction Proposal `,
                'AFC Construction Proposal Due Date' AS `Estimates - AFC Construction Proposal Due Date`,
                'AFC Construction Proposal Submission Date' AS `Estimates - AFC Construction Proposal Submission Date`,
                'Construction Proposal' AS `Estimates - Construction Proposal`,
                'Construction Proposal Due Date' AS `Estimates - Construction Proposal Due Date`,
                'Construction Proposal Submission Date' AS `Estimates - Construction Proposal Submission Date`,
                'Variation Due Date' AS `Estimates - Variation Due Date`,
                'Variation Submission Date' AS `Estimates - Variation Submission Date`,
                'Others - Description' AS `Estimates - Others - Description`,
                'Variation 1 Estimate' AS `Estimates - Variation 1 Estimate`,
                'Variation 2 Estimate' AS `Estimates - Variation 2 Estimate`,
                'Variation 3 Estimate' AS `Estimates - Variation 3 Estimate`,
                'Variation 4 Estimate' AS `Estimates - Variation 4 Estimate`,
                'Variation 5 Estimate' AS `Estimates - Variation 5 Estimate`,
                'Variation 6 Estimate' AS `Estimates - Variation 6 Estimate`,
                'Variation 7 Estimate' AS `Estimates - Variation 7 Estimate`,
                'Variation 8 Estimate' AS `Estimates - Variation 8 Estimate`,
                'Variation 9 Estimate' AS `Estimates - Variation 9 Estimate`,
                'Variation 10 Estimate' AS `Estimates - Variation 10 Estimate`,
                'Variation - Description' AS `Estimates - Variation - Description`,
                '% Completed To Date' AS `Planning - % Completed To Date`,
                'Estimated Timeframe' AS `Planning - Estimated Timeframe`,
                'Project Duration (Weeks)' AS `Planning - Project Duration (Weeks)`,
                'Ventia WBS Fixed Price' AS `Finance - Ventia WBS Fixed Price`,
                'Ventia WBS Prov Sum' AS `Finance - Ventia WBS Prov Sum`,
                'Finance Approved - Fixed Price' AS `Finance - Finance Approved - Fixed Price`,
                'Finance Approved - Prov Sums' AS `Finance - Finance Approved - Prov Sums`,
                'Finance Approved - Combined' AS `Practical Completion - Finance Approved - Combined`,
                'PC Notification Date' AS `Practical Completion - PC Notification Date`,
                'Handover Date' AS `Practical Completion - Handover Date`
            )
        )
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `issue_id` | `string` | Yes |  |
| `key` | `string` | Yes |  |
| `summary` | `string` | Yes |  |
| `issue_type` | `string` | Yes |  |
| `status` | `string` | Yes |  |
| `priority` | `string` | Yes |  |
| `assignee` | `string` | Yes |  |
| `reporter` | `string` | Yes |  |
| `created` | `string` | Yes |  |
| `updated` | `string` | Yes |  |
| `resolved` | `string` | Yes |  |
| `labels` | `string` | Yes |  |
| `Estimator Name` | `string` | Yes |  |
| `Project Team` | `string` | Yes |  |
| `Finance Team` | `string` | Yes |  |
| `Category of Tender` | `string` | Yes |  |
| `Description` | `string` | Yes |  |
| `Variation` | `string` | Yes |  |
| `Variation Description` | `string` | Yes |  |
| `TfNSW Reference Number` | `string` | Yes |  |
| `TfNSW Project WBS` | `string` | Yes |  |
| `Project Year` | `string` | Yes |  |
| `Date Received` | `string` | Yes |  |
| `Date Submitted` | `string` | Yes |  |
| `Project Awarded?` | `string` | Yes |  |
| `Date Approved/Rejected` | `string` | Yes |  |
| `Ventia Acceptance` | `string` | Yes |  |
| `RFQ` | `string` | Yes |  |
| `Proposed Due Date` | `string` | Yes |  |
| `Quotation Required From` | `string` | Yes |  |
| `Likelihood Winning` | `string` | Yes |  |
| `Commercial Mechanism` | `string` | Yes |  |
| `Budget/Estimate - Fixed Price` | `string` | Yes |  |
| `Budget/Estimate - Prov Sums` | `string` | Yes |  |
| `Budget/Estimate Combined` | `string` | Yes |  |
| `TfNSW Contact Name` | `string` | Yes |  |
| `TfNSW Phone Number` | `string` | Yes |  |
| `TfNSW Email Address` | `string` | Yes |  |
| `Finalisation Handover completed?` | `string` | Yes |  |
| `Rejection Reason` | `string` | Yes |  |
| `Estimates - HLCE` | `string` | Yes |  |
| `Estimates - HLCE Due Date` | `string` | Yes |  |
| `Estimates - HLCE Submission Date` | `string` | Yes |  |
| `Estimates - SD HLCE` | `string` | Yes |  |
| `Estimates - SD HLCE Due Date` | `string` | Yes |  |
| `Estimates - SD HLCE Submission Date` | `string` | Yes |  |
| `Estimates - 50% CD HLCE` | `string` | Yes |  |
| `Estimates - 50% CD HLCE Due Date` | `string` | Yes |  |
| `Estimates - 50% CD HLCE Submission Date` | `string` | Yes |  |
| `Estimates - 100% CD HLCE` | `string` | Yes |  |
| `Estimates - 100% CD HLCE Due Date` | `string` | Yes |  |
| `Estimates - 100% CD HLCE Submission Date` | `string` | Yes |  |
| `Estimates - 20% DD HLCE` | `string` | Yes |  |
| `Estimates - 20% DD HLCE Due Date` | `string` | Yes |  |
| `Estimates - 20% DD HLCE Submission Date` | `string` | Yes |  |
| `Estimates - 50% DD HLCE` | `string` | Yes |  |
| `Estimates - 50% DD HLCE Due Date` | `string` | Yes |  |
| `Estimates - 50% DD HLCE Submission Date` | `string` | Yes |  |
| `Estimates - 80% DD HLCE` | `string` | Yes |  |
| `Estimates - 80% DD HLCE Due Date` | `string` | Yes |  |
| `Estimates - 80% DD HLCE Submission Date` | `string` | Yes |  |
| `Estimates - 100% DD Construction Proposal` | `string` | Yes |  |
| `Estimates - 100% DD Construction Proposal Due Date` | `string` | Yes |  |
| `Estimates - 100% DD Construction Proposal Submission Date` | `string` | Yes |  |
| `Estimates - AFC Construction Proposal ` | `string` | Yes |  |
| `Estimates - AFC Construction Proposal Due Date` | `string` | Yes |  |
| `Estimates - AFC Construction Proposal Submission Date` | `string` | Yes |  |
| `Estimates - Construction Proposal` | `string` | Yes |  |
| `Estimates - Construction Proposal Due Date` | `string` | Yes |  |
| `Estimates - Construction Proposal Submission Date` | `string` | Yes |  |
| `Estimates - Variation Due Date` | `string` | Yes |  |
| `Estimates - Variation Submission Date` | `string` | Yes |  |
| `Estimates - Others - Description` | `string` | Yes |  |
| `Estimates - Variation 1 Estimate` | `string` | Yes |  |
| `Estimates - Variation 2 Estimate` | `string` | Yes |  |
| `Estimates - Variation 3 Estimate` | `string` | Yes |  |
| `Estimates - Variation 4 Estimate` | `string` | Yes |  |
| `Estimates - Variation 5 Estimate` | `string` | Yes |  |
| `Estimates - Variation 6 Estimate` | `string` | Yes |  |
| `Estimates - Variation 7 Estimate` | `string` | Yes |  |
| `Estimates - Variation 8 Estimate` | `string` | Yes |  |
| `Estimates - Variation 9 Estimate` | `string` | Yes |  |
| `Estimates - Variation 10 Estimate` | `string` | Yes |  |
| `Estimates - Variation - Description` | `string` | Yes |  |
| `Planning - % Completed To Date` | `string` | Yes |  |
| `Planning - Estimated Timeframe` | `string` | Yes |  |
| `Planning - Project Duration (Weeks)` | `string` | Yes |  |
| `Finance - Ventia WBS Fixed Price` | `string` | Yes |  |
| `Finance - Ventia WBS Prov Sum` | `string` | Yes |  |
| `Finance - Finance Approved - Fixed Price` | `string` | Yes |  |
| `Finance - Finance Approved - Prov Sums` | `string` | Yes |  |
| `Practical Completion - Finance Approved - Combined` | `string` | Yes |  |
| `Practical Completion - PC Notification Date` | `string` | Yes |  |
| `Practical Completion - Handover Date` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_srapc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
