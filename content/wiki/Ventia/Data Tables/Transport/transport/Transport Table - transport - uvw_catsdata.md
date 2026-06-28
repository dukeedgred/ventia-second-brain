---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport
table-name: uvw_catsdata
full-name: transport_dev.transport.uvw_catsdata
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport]
---

# Transport Table - transport - uvw_catsdata

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_catsdata` |
| Full name | `transport_dev.transport.uvw_catsdata` |
| Catalog | `transport_dev` |
| Schema | `transport` |
| Contract/schema | `transport` |
| Table type | VIEW |
| Column count | 22 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | bhupesh.balani@ventia.com |
| Refresh/freshness | Created: 2024-08-21T07:42:53.307Z; Last altered: 2024-08-21T07:42:53.307Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
Select BELNR as Document_Number, PERNR as Personnel_Number, WORKDATE as Work_Date, SKOSTL as Sender_Cost_Centre, LSTAR as Activity_Type, RKOSTL as Receiver_Cost_Centre, RPROJ as Receiver_WBS, RAUFNR as Receiver_Order, RNPLNR as Network_Number, AWART as Att_or_Abs_Type, HRKOSTL as Cost_Centre, BEMOT as Acc_Indicator, ERNAM as Username, ERSDA as Created_On, ERSTM as Time_of_Entry, CATSHOURS as Hours, BEGUZ as Start_Time, ENDUZ as End_Time, VTKEN as Previous_Day_Indicator, LTXA1 as Short_Text, CATSQUANTITY as Qty, left(format_string(int(SKOSTL)),5) as PC_ID
from staged.stg_sap_hana_cf_sap_ecc.catsdb s
inner join transport_dev.transport.uvw_pc_masterdata t 
ON left(format_string(int(SKOSTL)),5) = t.PC_ID
where s.deleted_in_source =0
Union all
Select BELNR as Document_Number, PERNR as Personnel_Number, WORKDATE as Work_Date, SKOSTL as Sender_Cost_Centre, LSTAR as Activity_Type, RKOSTL as Receiver_Cost_Centre, RPROJ as Receiver_WBS, RAUFNR as Receiver_Order, RNPLNR as Network_Number, AWART as Att_or_Abs_Type, HRKOSTL as Cost_Centre, BEMOT as Acc_Indicator, ERNAM as Username, ERSDA as Created_On, ERSTM as Time_of_Entry, CATSHOURS as Hours, BEGUZ as Start_Time, ENDUZ as End_Time, VTKEN as Previous_Day_Indicator, LTXA1 as Short_Text, CATSQUANTITY as Qty, left(format_string(int(SKOSTL)),5) as PC_ID
from staged.stg_sap_hana_cf_sap_ecc.catsdb s
inner join transport_dev.transport.uvw_pc_masterdata t 
ON left(format_string(int(SKOSTL)),5) = "90240"
where s.deleted_in_source =0
union all
Select BELNR as Document_Number, PERNR as Personnel_Number, WORKDATE as Work_Date, SKOSTL as Sender_Cost_Centre, LSTAR as Activity_Type, RKOSTL as Receiver_Cost_Centre, RPROJ as Receiver_WBS, RAUFNR as Receiver_Order, RNPLNR as Network_Number, AWART as Att_or_Abs_Type, HRKOSTL as Cost_Centre, BEMOT as Acc_Indicator, ERNAM as Username, ERSDA as Created_On, ERSTM as Time_of_Entry, CATSHOURS as Hours, BEGUZ as Start_Time, ENDUZ as End_Time, VTKEN as Previous_Day_Indicator, LTXA1 as Short_Text, CATSQUANTITY as Qty, left(format_string(int(SKOSTL)),5) as PC_ID
from staged.stg_sap_hana_cf_sap_ecc.catsdb s
inner join transport_dev.transport.uvw_pc_masterdata t 
ON left(format_string(int(SKOSTL)),5) = "90050"
where s.deleted_in_source =0
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Document_Number` | `string` | Yes |  |
| `Personnel_Number` | `string` | Yes |  |
| `Work_Date` | `string` | Yes |  |
| `Sender_Cost_Centre` | `string` | Yes |  |
| `Activity_Type` | `string` | Yes |  |
| `Receiver_Cost_Centre` | `string` | Yes |  |
| `Receiver_WBS` | `string` | Yes |  |
| `Receiver_Order` | `string` | Yes |  |
| `Network_Number` | `string` | Yes |  |
| `Att_or_Abs_Type` | `string` | Yes |  |
| `Cost_Centre` | `string` | Yes |  |
| `Acc_Indicator` | `string` | Yes |  |
| `Username` | `string` | Yes |  |
| `Created_On` | `string` | Yes |  |
| `Time_of_Entry` | `string` | Yes |  |
| `Hours` | `decimal(4,2)` | Yes |  |
| `Start_Time` | `string` | Yes |  |
| `End_Time` | `string` | Yes |  |
| `Previous_Day_Indicator` | `string` | Yes |  |
| `Short_Text` | `string` | Yes |  |
| `Qty` | `decimal(15,3)` | Yes |  |
| `PC_ID` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
