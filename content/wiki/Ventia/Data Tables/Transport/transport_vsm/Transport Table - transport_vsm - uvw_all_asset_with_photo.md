---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_vsm
table-name: uvw_all_asset_with_photo
full-name: transport_dev.transport_vsm.uvw_all_asset_with_photo
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-vsm]
---

# Transport Table - transport_vsm - uvw_all_asset_with_photo

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_all_asset_with_photo` |
| Full name | `transport_dev.transport_vsm.uvw_all_asset_with_photo` |
| Catalog | `transport_dev` |
| Schema | `transport_vsm` |
| Contract/schema | `transport_vsm` |
| Table type | VIEW |
| Column count | 25 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | asset register / hierarchy |
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2024-07-11T23:33:48.337Z; Last altered: 2024-07-18T20:33:33.591Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
WITH latestjob(
        SELECT
            contract, 
            id, 
            assettypename, 
            assetcode, 
            assetid, 
            completedstatus,
            ROW_NUMBER() OVER(PARTITION BY assettypename, assetcode, id ORDER BY assettypename, assetcode, id DESC) AS rownum
        FROM
            ext_mssql_asset_vision_vsm_gen7.dbo.job
        WHERE
            contract = 'VentureSmart'
            AND deleted = false
        ORDER BY
            assettypename,
            assetcode,
            rownum 
            ),
    assetphoto(
        WITH assetallphoto(
            WITH latestjob(
                SELECT
                    contract, 
                    id,                     
                    assettypename, 
                    assetcode, 
                    assetid, 
                    completedstatus,
                    ROW_NUMBER() OVER(PARTITION BY assettypename, assetcode, id ORDER BY assettypename, assetcode, id DESC) AS rownum
                FROM
                    ext_mssql_asset_vision_vsm_gen7.dbo.job
                WHERE
                    contract = 'VentureSmart'
                    AND deleted = false
                ORDER BY
                    assettypename,
                    assetcode,
                    rownum 
            )
            SELECT
                id, 
                sourcetable, 
                sourcetableid, 
                url, 
                stage
            FROM
                ext_mssql_asset_vision_vsm_gen7.dbo.photo
            WHERE
                sourcetable = 'Asset'
                AND deleted = false

            UNION ALL

            SELECT
                p.id, 
                'Asset' AS sourcetable, 
                j.assetid AS sourcetableid, 
                p.url, 
                p.stage
            FROM
                ext_mssql_asset_vision_vsm_gen7.dbo.photo p
                JOIN latestjob j ON j.id = p.sourcetableid
            WHERE
                p.sourcetable = 'Job'
                AND p.deleted = false
                AND p.stage = 'Job After'
                AND j.rownum = 1
        )
        SELECT 
            *,
            ROW_NUMBER() OVER(PARTITION BY sourcetableid ORDER BY sourcetableid) AS rownum
        FROM
            assetallphoto
        ORDER BY 
            sourcetableid
    )
SELECT
  a.id,
  a.modifiedutc,
  a.modifieduser,
  a.contract,
  a.assettype,
  a.code,
  a.name,
  a.stage,
  a.classification,
  a.parentassetid,
  a.parentassetcode,
  a.parentassetname,
  a.spatialtype,
  l.WKT AS spatialinfo,
  j.id AS latestjobid,
  ap1.url AS Photo1,
  ap2.url AS Photo2,
  ap3.url AS Photo3,
  ap4.url AS Photo4,
  ap5.url AS Photo5,
  ap6.url AS Photo6,
  ap7.url AS Photo7,
  ap8.url AS Photo8,
  ap9.url AS Photo9,
  ap10.url AS Photo10
FROM
  ext_mssql_asset_vision_vsm_gen7.dbo.asset a
  LEFT JOIN latestjob j ON j.assettypename = a.assettype AND j.assetcode = a.code AND j.rownum = 1
  LEFT JOIN assetphoto ap1 ON a.id = ap1.sourcetableid AND ap1.rownum = 1
  LEFT JOIN assetphoto ap2 ON a.id = ap2.sourcetableid AND ap2.rownum = 2
  LEFT JOIN assetphoto ap3 ON a.id = ap3.sourcetableid AND ap3.rownum = 3
  LEFT JOIN assetphoto ap4 ON a.id = ap4.sourcetableid AND ap4.rownum = 4
  LEFT JOIN assetphoto ap5 ON a.id = ap5.sourcetableid AND ap5.rownum = 5
  LEFT JOIN assetphoto ap6 ON a.id = ap6.sourcetableid AND ap6.rownum = 6
  LEFT JOIN assetphoto ap7 ON a.id = ap7.sourcetableid AND ap7.rownum = 7
  LEFT JOIN assetphoto ap8 ON a.id = ap8.sourcetableid AND ap8.rownum = 8
  LEFT JOIN assetphoto ap9 ON a.id = ap9.sourcetableid AND ap9.rownum = 9
  LEFT JOIN assetphoto ap10 ON a.id = ap10.sourcetableid AND ap10.rownum = 10
  LEFT JOIN ext_mssql_asset_vision_vsm_gen7.dbo.vassetlocation l ON a.id = l.assetid AND l.deleted = false
WHERE
  a.contract = 'VentureSmart'
  AND a.deleted = false
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `id` | `int` | Yes |  |
| `modifiedutc` | `timestamp` | Yes |  |
| `modifieduser` | `string` | Yes |  |
| `contract` | `string` | Yes |  |
| `assettype` | `string` | Yes |  |
| `code` | `string` | Yes |  |
| `name` | `string` | Yes |  |
| `stage` | `string` | Yes |  |
| `classification` | `string` | Yes |  |
| `parentassetid` | `int` | Yes |  |
| `parentassetcode` | `string` | Yes |  |
| `parentassetname` | `string` | Yes |  |
| `spatialtype` | `string` | Yes |  |
| `spatialinfo` | `string` | Yes |  |
| `latestjobid` | `int` | Yes |  |
| `Photo1` | `string` | Yes |  |
| `Photo2` | `string` | Yes |  |
| `Photo3` | `string` | Yes |  |
| `Photo4` | `string` | Yes |  |
| `Photo5` | `string` | Yes |  |
| `Photo6` | `string` | Yes |  |
| `Photo7` | `string` | Yes |  |
| `Photo8` | `string` | Yes |  |
| `Photo9` | `string` | Yes |  |
| `Photo10` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_vsm]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
