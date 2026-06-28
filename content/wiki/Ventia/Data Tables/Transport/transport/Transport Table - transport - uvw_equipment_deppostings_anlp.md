---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport
table-name: uvw_equipment_deppostings_anlp
full-name: transport_dev.transport.uvw_equipment_deppostings_anlp
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport]
---

# Transport Table - transport - uvw_equipment_deppostings_anlp

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_equipment_deppostings_anlp` |
| Full name | `transport_dev.transport.uvw_equipment_deppostings_anlp` |
| Catalog | `transport_dev` |
| Schema | `transport` |
| Contract/schema | `transport` |
| Table type | VIEW |
| Column count | 20 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | bhupesh.balani@ventia.com |
| Refresh/freshness | Created: 2025-03-12T06:13:55.056Z; Last altered: 2025-03-12T06:13:55.056Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
select s.BUKRS as Co_Code, s.GJAHR as Fiscal_Year, s.PERAF as Period, s.AFBNR as Seq_No, s.ANLN1 as Main_Asset_Number, s.ANLN2 as Asset_SubNumber, s.AFABER as DepArea_Real_Derived, s.NAFAZ as Posted_Dep_Year, s.NAFAP as Dep_Planned_Year, s.SAFAG as SpecialDep_Posted_Year, s.AAFAG as UnplannedDep_Posted_Year, s.MAFAG as Remaining_Asset_Value, s.ZINSG as Int_Posted_Year, s.AFASL as Dep_Key, s.KOSTL as Cost_Centre, s.CAUFN as Internal_Order, s.BELNR as Material_Document, s.LSTAR as Activity_Type, s.PS_PSP_PNR2 as WBS_Element, format_string(int(s.PRCTR)) as PC_ID
from staged.stg_sap_hana_cf_sap_ecc.anlp s
inner join transport_dev.transport.uvw_pc_masterdata t 
ON int(PRCTR) = t.PC_ID
where s.deleted_in_source =0
UNION all
select s.BUKRS as Co_Code, s.GJAHR as Fiscal_Year, s.PERAF as Period, s.AFBNR as Seq_No, s.ANLN1 as Main_Asset_Number, s.ANLN2 as Asset_SubNumber, s.AFABER as DepArea_Real_Derived, s.NAFAZ as Posted_Dep_Year, s.NAFAP as Dep_Planned_Year, s.SAFAG as SpecialDep_Posted_Year, s.AAFAG as UnplannedDep_Posted_Year, s.MAFAG as Remaining_Asset_Value, s.ZINSG as Int_Posted_Year, s.AFASL as Dep_Key, s.KOSTL as Cost_Centre, s.CAUFN as Internal_Order, s.BELNR as Material_Document, s.LSTAR as Activity_Type, s.PS_PSP_PNR2 as WBS_Element, format_string(int(s.PRCTR)) as PC_ID
from staged.stg_sap_hana_cf_sap_ecc.anlp s
where int(PRCTR)=90240 and s.deleted_in_source =0
UNION all
select s.BUKRS as Co_Code, s.GJAHR as Fiscal_Year, s.PERAF as Period, s.AFBNR as Seq_No, s.ANLN1 as Main_Asset_Number, s.ANLN2 as Asset_SubNumber, s.AFABER as DepArea_Real_Derived, s.NAFAZ as Posted_Dep_Year, s.NAFAP as Dep_Planned_Year, s.SAFAG as SpecialDep_Posted_Year, s.AAFAG as UnplannedDep_Posted_Year, s.MAFAG as Remaining_Asset_Value, s.ZINSG as Int_Posted_Year, s.AFASL as Dep_Key, s.KOSTL as Cost_Centre, s.CAUFN as Internal_Order, s.BELNR as Material_Document, s.LSTAR as Activity_Type, s.PS_PSP_PNR2 as WBS_Element, format_string(int(s.PRCTR)) as PC_ID
from staged.stg_sap_hana_cf_sap_ecc.anlp s
where int(PRCTR)=90050 and s.deleted_in_source =0
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Co_Code` | `string` | No |  |
| `Fiscal_Year` | `string` | No |  |
| `Period` | `string` | No |  |
| `Seq_No` | `string` | No |  |
| `Main_Asset_Number` | `string` | No |  |
| `Asset_SubNumber` | `string` | No |  |
| `DepArea_Real_Derived` | `string` | No |  |
| `Posted_Dep_Year` | `decimal(13,2)` | Yes |  |
| `Dep_Planned_Year` | `decimal(13,2)` | Yes |  |
| `SpecialDep_Posted_Year` | `decimal(13,2)` | Yes |  |
| `UnplannedDep_Posted_Year` | `decimal(13,2)` | Yes |  |
| `Remaining_Asset_Value` | `decimal(13,2)` | Yes |  |
| `Int_Posted_Year` | `decimal(13,2)` | Yes |  |
| `Dep_Key` | `string` | Yes |  |
| `Cost_Centre` | `string` | Yes |  |
| `Internal_Order` | `string` | Yes |  |
| `Material_Document` | `string` | Yes |  |
| `Activity_Type` | `string` | Yes |  |
| `WBS_Element` | `string` | Yes |  |
| `PC_ID` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
