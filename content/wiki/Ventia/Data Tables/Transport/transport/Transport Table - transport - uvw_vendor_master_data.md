---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport
table-name: uvw_vendor_master_data
full-name: transport_dev.transport.uvw_vendor_master_data
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-table, databricks, vendor, sap]
---

# Transport Table - transport - uvw_vendor_master_data

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_vendor_master_data` |
| Full name | `transport_dev.transport.uvw_vendor_master_data` |
| Catalog | `transport_dev` |
| Schema | `transport` |
| Contract/schema | `transport` |
| Table type | VIEW |
| Column count | 4 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | vendor master |
| Source system | SAP |
| Related tables/reports | `staged.stg_sap_hana_cf_sap_ecc.lfa1`, `staged.stg_sap_hana_cf_sap_ecc.lfb1` |

## View Query

```sql
select distinct s.LIFNR as Vendor_ID, s.NAME1 as Vendor_Name, s.STCEG as VAT_Registration_Number, t.MINDK as Minority_Indicators from
staged.stg_sap_hana_cf_sap_ecc.lfa1 s
inner join staged.stg_sap_hana_cf_sap_ecc.lfb1 t
on s.LIFNR=t.LIFNR
where s.deleted_in_source=0
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Vendor_ID` | `string` | No |  |
| `Vendor_Name` | `string` | Yes |  |
| `VAT_Registration_Number` | `string` | Yes |  |
| `Minority_Indicators` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
