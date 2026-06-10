---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: uvw_pcas_seg_geom_wkt
full-name: transport_dev.transport_tsrc.uvw_pcas_seg_geom_wkt
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - uvw_pcas_seg_geom_wkt

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_pcas_seg_geom_wkt` |
| Full name | `transport_dev.transport_tsrc.uvw_pcas_seg_geom_wkt` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | VIEW |
| Column count | 8 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | capital works / forward works |
| Owner/SME | hui.chen@ventia.com |
| Refresh/freshness | Created: 2024-07-23T23:44:29.16Z; Last altered: 2024-07-31T23:24:52.324Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
SELECT
    DISTINCT
    a.*,
    b.WKT
FROM
(SELECT DISTINCT `AV_Asset_ID`,assetname,`Start Chng`,`End Chng`,`Chainage_Text`,Carriageway,Lane 
 FROM transport_dev.transport_tsrc.uvw_pcas_numeric_data) a --- Update this table name
LEFT JOIN 
(SELECT * FROM  ext_mssql_asset_vision_ven_gen7.dbo.vassetlocation) b --- Update this table name
ON a.`AV_Asset_ID` = b.assetid
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `AV_Asset_ID` | `int` | Yes |  |
| `assetname` | `string` | Yes |  |
| `Start Chng` | `int` | Yes |  |
| `End Chng` | `int` | Yes |  |
| `Chainage_Text` | `string` | Yes |  |
| `Carriageway` | `string` | No |  |
| `Lane` | `string` | Yes |  |
| `WKT` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
