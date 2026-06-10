---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport
table-name: uvw_cc_masterdata
full-name: transport_dev.transport.uvw_cc_masterdata
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport]
---

# Transport Table - transport - uvw_cc_masterdata

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_cc_masterdata` |
| Full name | `transport_dev.transport.uvw_cc_masterdata` |
| Catalog | `transport_dev` |
| Schema | `transport` |
| Contract/schema | `transport` |
| Table type | VIEW |
| Column count | 6 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | bhupesh.balani@ventia.com |
| Refresh/freshness | Created: 2024-08-07T05:49:28.59Z; Last altered: 2024-08-07T05:49:28.59Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
Select format_string(int(s.KOSTL))  as Cost_Centre_ID, format_string(int(s.PRCTR)) as PC_ID, t.LTEXT as Cost_Centre_Description, t.DATBI as Valid_To_Date,
if(int(left(t.DATBI,6))<int(date_format(now(), 'yyyyMM')),'Closed', 'Released') as BW_Status, s.BUKRS as Co_Code
from staged.stg_sap_hana_cf_sap_ecc.csks s
left join staged.stg_sap_hana_cf_sap_ecc.cskt t
on s.KOSTL=t.KOSTL
inner join transport_dev.transport.uvw_pc_masterdata u 
ON int(PRCTR) = u.PC_ID
where s.deleted_in_source =0
union all
Select format_string(int(s.KOSTL))  as Cost_Centre_ID, format_string(int(s.PRCTR)) as PC_ID, t.LTEXT as Cost_Centre_Description, t.DATBI as Valid_To_Date,
if(int(left(t.DATBI,6))<int(date_format(now(), 'yyyyMM')),'Closed', 'Released') as BW_Status, s.BUKRS as Co_Code
from staged.stg_sap_hana_cf_sap_ecc.csks s
left join staged.stg_sap_hana_cf_sap_ecc.cskt t
on s.KOSTL=t.KOSTL
where int(s.PRCTR)=90240 and s.deleted_in_source =0
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Cost_Centre_ID` | `string` | Yes |  |
| `PC_ID` | `string` | Yes |  |
| `Cost_Centre_Description` | `string` | Yes |  |
| `Valid_To_Date` | `string` | Yes |  |
| `BW_Status` | `string` | No |  |
| `Co_Code` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
