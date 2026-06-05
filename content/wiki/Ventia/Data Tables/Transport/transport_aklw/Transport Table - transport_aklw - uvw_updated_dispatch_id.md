---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_aklw
table-name: uvw_updated_dispatch_id
full-name: transport_dev.transport_aklw.uvw_updated_dispatch_id
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-table, databricks, transport-aklw, dispatch]
---

# Transport Table - transport_aklw - uvw_updated_dispatch_id

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_updated_dispatch_id` |
| Full name | `transport_dev.transport_aklw.uvw_updated_dispatch_id` |
| Catalog | `transport_dev` |
| Schema | `transport_aklw` |
| Contract/schema | `transport_aklw` |
| Table type | VIEW |
| Column count | 12 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | dispatch |
| Source system | `ext_mssql_asset_vision_vnz_gen7` |

## View Query

```sql
SELECT
  CASE
    WHEN T1.value = T2.value
    or T2.value IS NULL THEN T1.rownum
    ELSE T2.rownum
  END AS rownum,
  CASE
    WHEN T1.value = T2.value
    or T2.value IS NULL THEN T1.id
    ELSE T2.id
  END AS id,
  CASE
    WHEN T1.value = T2.value
    or T2.value IS NULL THEN T1.recordid
    ELSE T2.recordid
  END AS recordid,
  CASE
    WHEN T1.value = T2.value
    or T2.value IS NULL THEN from_utc_timestamp(T1.modifiedutc, 'Australia/Sydney')
    ELSE from_utc_timestamp(T2.modifiedutc, 'Australia/Sydney')
  END AS modifiedutc,
  'DataServices_VNZ_Gen7' AS source_database_name,
  CASE
    WHEN T1.value = T2.value
    or T2.value IS NULL THEN T1.sourcetable
    ELSE T2.sourcetable
  END AS sourcetable,
  CASE
    WHEN T1.value = T2.value
    or T2.value IS NULL THEN T1.sourcetableid
    ELSE T2.sourcetableid
  END AS sourcetableid,
  CASE
    WHEN T1.value = T2.value
    or T2.value IS NULL THEN T1.name
    ELSE T2.name
  END AS name,
  CASE
    WHEN T1.value = T2.value
    or T2.value IS NULL THEN T1.value
    ELSE T2.value
  END AS value,
  CASE
    WHEN T1.value = T2.value
    or T2.value IS NULL THEN T1.deleted
    ELSE T2.deleted
  END AS deleted,
  CASE
    WHEN T1.value = T2.value
    or T2.value IS NULL THEN T1.modifieduser
    ELSE T2.modifieduser
  END AS modifieduser,
  CASE
    WHEN T1.value = T2.value
    or T2.value IS NULL THEN T1.datatype
    ELSE T2.datatype
  END AS datatype
FROM
  (
    Select
      ROW_NUMBER() OVER (
        PARTITION BY
        sourcetable,
        sourcetableid,
        name
        ORDER BY
          sourcetable,
          sourcetableid,
          name,
          modifiedutc DESC
      ) AS rownum,
      id,
      recordid,
      modifiedutc,
      name,
      value,
      datatype,
      modifieduser,
      sourcetable,
      sourcetableid,
      uniqueid,
      deleted
    from
      ext_mssql_asset_vision_vnz_gen7.dbo.formfield
    where
      name like 'DISPATCH DETAILS|Dispatch ID'
      and deleted = false
  ) T1
  LEFT JOIN (
    Select
      ROW_NUMBER() OVER (
        PARTITION BY
        sourcetable,
        sourcetableid,
        name
        ORDER BY
          sourcetable,
          sourcetableid,
          name
      ) AS rownum,
      id,
      recordid,
      modifiedutc,
      name,
      value,
      datatype,
      modifieduser,
      sourcetable,
      sourcetableid,
      uniqueid,
      deleted
    from
      ext_mssql_asset_vision_vnz_gen7.dbo.formfield
    where
      name like 'DISPATCH DETAILS|Dispatch ID'
      and deleted = false
  ) T2 ON T1.sourcetable = T2.sourcetable
  AND T1.sourcetableid = T2.sourcetableid
WHERE
  T1.rownum = 2
  AND T2.rownum = 1
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `rownum` | `int` | Yes |  |
| `id` | `int` | Yes |  |
| `recordid` | `int` | Yes |  |
| `modifiedutc` | `timestamp` | Yes |  |
| `source_database_name` | `string` | No |  |
| `sourcetable` | `string` | Yes |  |
| `sourcetableid` | `int` | Yes |  |
| `name` | `string` | Yes |  |
| `value` | `string` | Yes |  |
| `deleted` | `boolean` | Yes |  |
| `modifieduser` | `string` | Yes |  |
| `datatype` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_aklw]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
