---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_sht
table-name: utbl_sps02_sb
full-name: transport_dev.transport_sht.utbl_sps02_sb
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-table, databricks, transport-sht, sensor-reading]
---

# Transport Table - transport_sht - utbl_sps02_sb

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_sps02_sb` |
| Full name | `transport_dev.transport_sht.utbl_sps02_sb` |
| Catalog | `transport_dev` |
| Schema | `transport_sht` |
| Contract/schema | `transport_sht` |
| Table type | MANAGED |
| Column count | 3 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | sensor reading |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Date_Time` | `timestamp` | Yes |  |
| `Raw_Reading` | `int` | Yes |  |
| `PPM_Value` | `decimal(4,1)` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_sht]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
