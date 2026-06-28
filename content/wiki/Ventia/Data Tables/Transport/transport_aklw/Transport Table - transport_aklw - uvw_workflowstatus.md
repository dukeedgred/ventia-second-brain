---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_aklw
table-name: uvw_workflowstatus
full-name: transport_dev.transport_aklw.uvw_workflowstatus
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-table, databricks, transport-aklw, workflow]
---

# Transport Table - transport_aklw - uvw_workflowstatus

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_workflowstatus` |
| Full name | `transport_dev.transport_aklw.uvw_workflowstatus` |
| Catalog | `transport_dev` |
| Schema | `transport_aklw` |
| Contract/schema | `transport_aklw` |
| Table type | VIEW |
| Column count | 14 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | workflow |
| Source system | `ext_mssql_asset_vision_vnz_gen7` |

## View Query

```sql
SELECT
  *
FROM
  ext_mssql_asset_vision_vnz_gen7.dbo.workflowstatus
WHERE
  deleted = False
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `ID` | `int` | Yes |  |
| `RecordID` | `int` | Yes |  |
| `DeltaUTC` | `timestamp` | Yes |  |
| `ModifiedUTC` | `timestamp` | Yes |  |
| `ModifiedUser` | `string` | Yes |  |
| `WorkflowItemCode` | `string` | Yes |  |
| `WorkflowItemName` | `string` | Yes |  |
| `SourceTable` | `string` | Yes |  |
| `SourceTableID` | `int` | Yes |  |
| `StatusDate` | `timestamp` | Yes |  |
| `Comment` | `string` | Yes |  |
| `Reason` | `string` | Yes |  |
| `SpatialInfo` | `binary` | Yes |  |
| `Deleted` | `boolean` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_aklw]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
