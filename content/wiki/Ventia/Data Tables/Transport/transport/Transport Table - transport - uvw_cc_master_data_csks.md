---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport
table-name: uvw_cc_master_data_csks
full-name: transport_dev.transport.uvw_cc_master_data_csks
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport]
---

# Transport Table - transport - uvw_cc_master_data_csks

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_cc_master_data_csks` |
| Full name | `transport_dev.transport.uvw_cc_master_data_csks` |
| Catalog | `transport_dev` |
| Schema | `transport` |
| Contract/schema | `transport` |
| Table type | VIEW |
| Column count | 4 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | bhupesh.balani@ventia.com |
| Refresh/freshness | Created: 2025-02-13T12:23:12.397Z; Last altered: 2025-02-13T12:23:12.397Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
select KOSTL as Cost_Object, BUKRS as Co_Code, int(PRCTR) as PC_ID, OBJNR as Object_Number
from staged.stg_sap_hana_cf_sap_ecc.csks s
inner join transport_dev.transport.uvw_pc_masterdata t 
ON int(PRCTR) = t.PC_ID
where s.deleted_in_source =0
UNION all
select KOSTL as Cost_Object, BUKRS as Co_Code, int(PRCTR) as PC_ID, OBJNR as Object_Number
from staged.stg_sap_hana_cf_sap_ecc.csks s
where int(PRCTR)=90240 and s.deleted_in_source =0
UNION all
select KOSTL as Cost_Object, BUKRS as Co_Code, int(PRCTR) as PC_ID, OBJNR as Object_Number
from staged.stg_sap_hana_cf_sap_ecc.csks s
where int(PRCTR)=90050 and s.deleted_in_source =0
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Cost_Object` | `string` | No |  |
| `Co_Code` | `string` | Yes |  |
| `PC_ID` | `int` | Yes |  |
| `Object_Number` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
