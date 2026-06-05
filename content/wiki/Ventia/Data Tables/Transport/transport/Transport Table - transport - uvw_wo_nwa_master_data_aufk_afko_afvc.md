---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport
table-name: uvw_wo_nwa_master_data_aufk_afko_afvc
full-name: transport_dev.transport.uvw_wo_nwa_master_data_aufk_afko_afvc
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-table, databricks, work-order, sap]
---

# Transport Table - transport - uvw_wo_nwa_master_data_aufk_afko_afvc

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_wo_nwa_master_data_aufk_afko_afvc` |
| Full name | `transport_dev.transport.uvw_wo_nwa_master_data_aufk_afko_afvc` |
| Catalog | `transport_dev` |
| Schema | `transport` |
| Contract/schema | `transport` |
| Table type | VIEW |
| Column count | 14 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | work order master |
| Source system | SAP |
| Related tables/reports | `staged.stg_sap_hana_cf_sap_ecc.aufk`, `staged.stg_sap_hana_cf_sap_ecc.afko`, `staged.stg_sap_hana_cf_sap_ecc.afvc`, `transport_dev.transport.uvw_pc_masterdata` |

## View Query

```sql
select s.AUFNR as Cost_Object, s.AUART as Object_Type, s.KTEXT as Object_Description, s.BUKRS as Co_Code, s.KOSTV as Resp_Cost_Centre, s.WAERS as CURR, s.ASTNR as Object_Status, s.OBJNR as Object_Number, s.PSPEL as WBS_ID, int(s.PRCTR) as PC_ID, q.aufpl as Routing_Number, r.vornr as Operation_Activity, r.LTXA1 as Operation_Text, s.SDI_CHANGE_TIME as Entry_Date
from staged.stg_sap_hana_cf_sap_ecc.aufk s
inner join transport_dev.transport.uvw_pc_masterdata t 
ON int(s.PRCTR) = t.PC_ID
inner join staged.stg_sap_hana_cf_sap_ecc.afko q
on s.AUFNR = q.AUFNR
inner join staged.stg_sap_hana_cf_sap_ecc.afvc r
on q.aufpl = r.AUFPL
where s.deleted_in_source =0
UNION all
select s.AUFNR as Cost_Object, s.AUART as Object_Type, s.KTEXT as Object_Description, s.BUKRS as Co_Code, s.KOSTV as Resp_Cost_Centre, s.WAERS as CURR, s.ASTNR as Object_Status, s.OBJNR as Object_Number, s.PSPEL as WBS_ID, int(s.PRCTR) as PC_ID, q.aufpl as Routing_Number, r.vornr as Operation_Activity, r.LTXA1 as Operation_Text, s.SDI_CHANGE_TIME as Entry_Date
from staged.stg_sap_hana_cf_sap_ecc.aufk s
inner join staged.stg_sap_hana_cf_sap_ecc.afko q
on s.AUFNR = q.AUFNR
inner join staged.stg_sap_hana_cf_sap_ecc.afvc r
on q.aufpl = r.AUfpl
where int(s.PRCTR)=90240 and s.deleted_in_source =0
UNION all
select s.AUFNR as Cost_Object, s.AUART as Object_Type, s.KTEXT as Object_Description, s.BUKRS as Co_Code, s.KOSTV as Resp_Cost_Centre, s.WAERS as CURR, s.ASTNR as Object_Status, s.OBJNR as Object_Number, s.PSPEL as WBS_ID, int(s.PRCTR) as PC_ID, q.aufpl as Routing_Number, r.vornr as Operation_Activity, r.LTXA1 as Operation_Text, s.SDI_CHANGE_TIME as Entry_Date
from staged.stg_sap_hana_cf_sap_ecc.aufk s
inner join staged.stg_sap_hana_cf_sap_ecc.afko q
on s.AUFNR = q.AUFNR
inner join staged.stg_sap_hana_cf_sap_ecc.afvc r
on q.aufpl = r.AUfpl
where int(s.PRCTR)=90050 and s.deleted_in_source =0
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Cost_Object` | `string` | No |  |
| `Object_Type` | `string` | Yes |  |
| `Object_Description` | `string` | Yes |  |
| `Co_Code` | `string` | Yes |  |
| `Resp_Cost_Centre` | `string` | Yes |  |
| `CURR` | `string` | Yes |  |
| `Object_Status` | `string` | Yes |  |
| `Object_Number` | `string` | Yes |  |
| `WBS_ID` | `string` | Yes |  |
| `PC_ID` | `int` | Yes |  |
| `Routing_Number` | `string` | Yes |  |
| `Operation_Activity` | `string` | Yes |  |
| `Operation_Text` | `string` | Yes |  |
| `Entry_Date` | `timestamp` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
