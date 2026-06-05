---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport
table-name: uvw_purgrp_masterdata_detail
full-name: transport_dev.transport.uvw_purgrp_masterdata_detail
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-table, databricks, purchasing-group, sap]
---

# Transport Table - transport - uvw_purgrp_masterdata_detail

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_purgrp_masterdata_detail` |
| Full name | `transport_dev.transport.uvw_purgrp_masterdata_detail` |
| Catalog | `transport_dev` |
| Schema | `transport` |
| Contract/schema | `transport` |
| Table type | VIEW |
| Column count | 6 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | purchasing group |
| Source system | SAP |
| Related tables/reports | `staged.stg_sap_hana_cf_sap_ecc.zp2pt_po_apr_grp`, `transport_dev.transport.uvw_purgrp_masterdata_uniquelist` |

## View Query

```sql
Select distinct s.BUKRS as Co_Code, s.PUR_GRP_FROM , s.PUR_GRP_TO,  int(s.PRCTR) as PC_ID, s.RELEASE_CODE, s.EMNAM as Approver
from staged.stg_sap_hana_cf_sap_ecc.zp2pt_po_apr_grp s
inner join transport_dev.transport.uvw_purgrp_masterdata_uniquelist t
on concat(s.PUR_GRP_FROM, s.BUKRS) = concat(t.PUR_GRP_FROM, t.Co_Code)
where s.deleted_in_source =0
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Co_Code` | `string` | No |  |
| `PUR_GRP_FROM` | `string` | No |  |
| `PUR_GRP_TO` | `string` | No |  |
| `PC_ID` | `int` | Yes |  |
| `RELEASE_CODE` | `string` | No |  |
| `Approver` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
