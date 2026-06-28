---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: uvw_test_asset_condition_report
full-name: transport_dev.transport_tsrc.uvw_test_asset_condition_report
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - uvw_test_asset_condition_report

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_test_asset_condition_report` |
| Full name | `transport_dev.transport_tsrc.uvw_test_asset_condition_report` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | VIEW |
| Column count | 9 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | asset register / hierarchy |
| Owner/SME | huy.nguyen@ventia.com |
| Refresh/freshness | Created: 2025-04-15T07:10:30.259Z; Last altered: 2025-04-15T07:10:30.259Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
WITH S2 AS (

WITH S1 AS (

SELECT
assetnum,
description,
siteid,
classificationid,
description1, 
lastreading, 
metername,
CASE
WHEN `lastreading` = '3 Good' OR `lastreading` = '2 Very Good' OR `lastreading` = '1 Excellent' THEN 1
ELSE 0
END AS `Good`,
CASE 
WHEN `lastreading` = '4 Fair' THEN 1 
ELSE 0
END AS `Fair`,
CASE 
WHEN `lastreading` = '5 Poor' THEN 1 
ELSE 0
END AS `Poor`,
CASE 
WHEN `lastreading` = '6 Unserviceable' THEN 1 
ELSE 0
END AS `Unserviceable`,
CASE 
WHEN `lastreading` = '7 Not Assessed' THEN 1 
ELSE 0
END AS `Not Assessed`
FROM transport_dev.transport_tsrc.utbl_test_condition_data
WHERE metername = 'CONDITION' AND
assetnum <> '' AND
lastreading <> ''

)
SELECT
siteid,
description1,
SUM(Good) AS `Good`,
SUM(Fair) AS `Fair`,
SUM(Poor) AS `Poor`,
SUM(Unserviceable) AS `Unserviceable`,
SUM(`Not Assessed`) AS `Not Assessed`,
row_number() OVER(PARTITION BY siteid ORDER BY description1) as `Index`
FROM S1
GROUP BY siteid, description1
SORT BY siteid, description1
)

SELECT 
S2.*,
CASE
WHEN siteid = 'M5SW' THEN 'Part 1'
WHEN siteid = 'CCT' AND `Index` <=65 THEN 'Part 1' 
WHEN siteid = 'CCT' AND `Index` <=130 THEN 'Part 2' 
WHEN siteid = 'CCT' AND `Index` > 130 THEN 'Part 3'
WHEN siteid = 'ED' AND `Index` <=63 THEN 'Part 1' 
WHEN siteid = 'ED' AND `Index` > 63 THEN 'Part 2'
WHEN siteid = 'LCT' AND `Index` <=71 THEN 'Part 1' 
WHEN siteid = 'LCT' AND `Index` <=142 THEN 'Part 2' 
WHEN siteid = 'LCT' AND `Index` > 142 THEN 'Part 3'
WHEN siteid = 'M2' AND `Index` <=64 THEN 'Part 1' 
WHEN siteid = 'M2' AND `Index` <=128 THEN 'Part 2' 
WHEN siteid = 'M2' AND `Index` > 128 THEN 'Part 3'
ELSE ''
END AS `Part`
FROM S2
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `siteid` | `string` | Yes |  |
| `description1` | `string` | Yes |  |
| `Good` | `bigint` | Yes |  |
| `Fair` | `bigint` | Yes |  |
| `Poor` | `bigint` | Yes |  |
| `Unserviceable` | `bigint` | Yes |  |
| `Not Assessed` | `bigint` | Yes |  |
| `Index` | `int` | No |  |
| `Part` | `string` | No |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
