---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport
table-name: uvw_wbs_master_data_prps
full-name: transport_dev.transport.uvw_wbs_master_data_prps
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-table, databricks, wbs, sap]
---

# Transport Table - transport - uvw_wbs_master_data_prps

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_wbs_master_data_prps` |
| Full name | `transport_dev.transport.uvw_wbs_master_data_prps` |
| Catalog | `transport_dev` |
| Schema | `transport` |
| Contract/schema | `transport` |
| Table type | VIEW |
| Column count | 7 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | WBS master |
| Source system | SAP |
| Related tables/reports | `staged.stg_sap_hana_cf_sap_ecc.prps`, `transport_dev.transport.uvw_pc_masterdata` |

## View Query

```sql
select int(PSPNR) as WBS_ID, POSID as WBS_Element, POST1 as WBS_Description, OBJNR as Object_Number, int(PRCTR) as PC_ID, s.ERDAT as Created_Date, PBUKR as Co_Code  from staged.stg_sap_hana_cf_sap_ecc.prps s
inner join transport_dev.transport.uvw_pc_masterdata t 
ON int(PRCTR) = t.PC_ID
where s.deleted_in_source =0
UNION all
select int(PSPNR) as WBS_ID, POSID as WBS_Element, POST1 as WBS_Description, OBJNR as Object_Number, int(PRCTR) as PC_ID, s.ERDAT as Created_Date, PBUKR as Co_Code  from staged.stg_sap_hana_cf_sap_ecc.prps s
where int(PRCTR)=90240 and s.deleted_in_source =0
UNION all
select int(PSPNR) as WBS_ID, POSID as WBS_Element, POST1 as WBS_Description, OBJNR as Object_Number, int(PRCTR) as PC_ID, s.ERDAT as Created_Date, PBUKR as Co_Code  from staged.stg_sap_hana_cf_sap_ecc.prps s
where int(PRCTR)=90050 and s.deleted_in_source =0
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `WBS_ID` | `int` | Yes |  |
| `WBS_Element` | `string` | Yes |  |
| `WBS_Description` | `string` | Yes |  |
| `Object_Number` | `string` | Yes |  |
| `PC_ID` | `int` | Yes |  |
| `Created_Date` | `string` | Yes |  |
| `Co_Code` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
