---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_srapc
table-name: uvw_monthly_subcontractor_data_social
full-name: transport_dev.transport_srapc.uvw_monthly_subcontractor_data_social
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-srapc]
---

# Transport Table - transport_srapc - uvw_monthly_subcontractor_data_social

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_monthly_subcontractor_data_social` |
| Full name | `transport_dev.transport_srapc.uvw_monthly_subcontractor_data_social` |
| Catalog | `transport_dev` |
| Schema | `transport_srapc` |
| Contract/schema | `transport_srapc` |
| Table type | VIEW |
| Column count | 11 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2025-10-27T02:12:35.259Z; Last altered: 2025-10-27T02:12:35.259Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
SELECT
  -- Admin --
  --  AccountID  AS `AccountID`,
  ABN AS `ABN`,
  submittedFormID AS `Form ID`,
  formText_3 AS `Name of Aboriginal vendor (sub subcontracted)`,
  formNumber_1 AS `Number of Employees 20+`,
  Period AS `Reporting period`,
  Subcontractor AS `Subcontractor`,
  email AS `Subcontractor email`,
  to_date(Date, 'dd MMM yyyy') AS Submission_Date,
  formDropdown_12 AS `Main Type of Works`,
  formText_2 AS `Contractor Representative Name`,
  -- Social --
  formCurrency_3 AS `Spend amount Aboriginal sub-subcontractors AUD `
FROM
  transport_dev.formitize_srapc.srapc_monthly_subcontractor_data_capture_portal
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `ABN` | `string` | Yes |  |
| `Form ID` | `int` | No |  |
| `Name of Aboriginal vendor (sub subcontracted)` | `string` | Yes |  |
| `Number of Employees 20+` | `string` | Yes |  |
| `Reporting period` | `string` | Yes |  |
| `Subcontractor` | `string` | Yes |  |
| `Subcontractor email` | `string` | Yes |  |
| `Submission_Date` | `date` | Yes |  |
| `Main Type of Works` | `string` | Yes |  |
| `Contractor Representative Name` | `string` | Yes |  |
| `Spend amount Aboriginal sub-subcontractors AUD ` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_srapc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
