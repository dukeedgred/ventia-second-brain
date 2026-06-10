---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: utbl_road_safety_audit_register
full-name: transport_dev.transport_tsrc.utbl_road_safety_audit_register
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - utbl_road_safety_audit_register

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_road_safety_audit_register` |
| Full name | `transport_dev.transport_tsrc.utbl_road_safety_audit_register` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | MANAGED |
| Column count | 35 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | inspection / audit / condition |
| Owner/SME | Helix_readwrite_transport_dev_transport_tsrc |
| Refresh/freshness | Created: 2024-07-25T05:13:46.176Z; Last altered: 2024-10-22T03:45:28.418Z |
| Source details | Data source format: DELTA |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `id` | `int` | Yes |  |
| `deltautc` | `timestamp` | Yes |  |
| `modifiedutc` | `timestamp` | Yes |  |
| `contract` | `string` | Yes |  |
| `region` | `string` | Yes |  |
| `completeddate` | `timestamp` | Yes |  |
| `modulename` | `string` | Yes |  |
| `rsaname` | `string` | Yes |  |
| `createddate` | `timestamp` | Yes |  |
| `createduser` | `string` | Yes |  |
| `assigneduser` | `string` | Yes |  |
| `comments` | `string` | Yes |  |
| `assetid` | `int` | Yes |  |
| `assetcode` | `string` | Yes |  |
| `assetname` | `string` | Yes |  |
| `entirelength` | `string` | Yes |  |
| `direction` | `varchar(50)` | Yes |  |
| `startpointname` | `string` | Yes |  |
| `chainagefrom` | `int` | Yes |  |
| `startdistancepast` | `int` | Yes |  |
| `endpointname` | `string` | Yes |  |
| `chainageto` | `int` | Yes |  |
| `enddistancepast` | `int` | Yes |  |
| `deleted` | `boolean` | Yes |  |
| `spatialinfo` | `binary` | Yes |  |
| `parentsourcetablename` | `string` | Yes |  |
| `parentsourcetableid` | `int` | Yes |  |
| `TriggeredSectionDetails_-_EndDate` | `string` | Yes |  |
| `TMRTeambinderSubmissionReferenceID` | `string` | Yes |  |
| `InitiatedbyaKPI02event` | `string` | Yes |  |
| `TriggeredSectionDetails_-_StartDate` | `string` | Yes |  |
| `ConsultantContractor` | `string` | Yes |  |
| `ReportSubmissionDate` | `string` | Yes |  |
| `triggersectionkey` | `string` | Yes |  |
| `ReportSubmissionDateTime` | `timestamp` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
