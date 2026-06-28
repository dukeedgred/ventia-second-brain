---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: utbl_incident_triggered_section_geom
full-name: transport_dev.transport_tsrc.utbl_incident_triggered_section_geom
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - utbl_incident_triggered_section_geom

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_incident_triggered_section_geom` |
| Full name | `transport_dev.transport_tsrc.utbl_incident_triggered_section_geom` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | MANAGED |
| Column count | 39 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | incidents |
| Owner/SME | Helix_readwrite_corporate_dev |
| Refresh/freshness | Created: 2024-07-25T05:06:45.343Z; Last altered: 2024-10-22T03:41:25.616Z |
| Source details | Data source format: DELTA |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `TriggerSectionId` | `int` | Yes |  |
| `assetcode` | `string` | Yes |  |
| `assetname` | `string` | Yes |  |
| `direction` | `string` | Yes |  |
| `incidentcount` | `bigint` | Yes |  |
| `minChainage` | `int` | Yes |  |
| `minIncidentDate` | `timestamp` | Yes |  |
| `maxChainage` | `int` | Yes |  |
| `maxIncidentDate` | `timestamp` | Yes |  |
| `AbatementTriggerDate` | `string` | Yes |  |
| `TriggerSectionWKT` | `string` | Yes |  |
| `abatablecount` | `bigint` | Yes |  |
| `rsaregkey` | `string` | Yes |  |
| `id` | `int` | Yes |  |
| `contract` | `string` | Yes |  |
| `region` | `string` | Yes |  |
| `completeddate` | `timestamp` | Yes |  |
| `modulename` | `string` | Yes |  |
| `rsaname` | `string` | Yes |  |
| `TriggeredSectionDetails_-_EndDate` | `string` | Yes |  |
| `TMRTeambinderSubmissionReferenceID` | `string` | Yes |  |
| `InitiatedbyaKPI02event` | `string` | Yes |  |
| `TriggeredSectionDetails_-_StartDate` | `string` | Yes |  |
| `ConsultantContractor` | `string` | Yes |  |
| `ReportSubmissionDate` | `timestamp` | Yes |  |
| `AbatableSection` | `string` | Yes |  |
| `triggersectionkey` | `string` | Yes |  |
| `CompletionStatus` | `string` | Yes |  |
| `DueDate` | `timestamp` | Yes |  |
| `ProgressStatus` | `string` | Yes |  |
| `RepQtrKey` | `string` | Yes |  |
| `Year` | `bigint` | Yes |  |
| `Quarter` | `string` | Yes |  |
| `BusinessDaysLateinQTR` | `int` | Yes |  |
| `maxYearQtr` | `string` | Yes |  |
| `minYearQtr` | `string` | Yes |  |
| `PartialDay` | `double` | Yes |  |
| `TotalBusinessDaysLateinQtr` | `double` | Yes |  |
| `AbatementCost` | `double` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
