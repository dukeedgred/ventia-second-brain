---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport
table-name: uvw_purgrp_masterdata_uniquelist
full-name: transport_dev.transport.uvw_purgrp_masterdata_uniquelist
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-table, databricks, purchasing-group, sap]
---

# Transport Table - transport - uvw_purgrp_masterdata_uniquelist

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_purgrp_masterdata_uniquelist` |
| Full name | `transport_dev.transport.uvw_purgrp_masterdata_uniquelist` |
| Catalog | `transport_dev` |
| Schema | `transport` |
| Contract/schema | `transport` |
| Table type | VIEW |
| Column count | 2 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | purchasing group |
| Source system | SAP |
| Related tables/reports | `staged.stg_sap_hana_cf_sap_ecc.zp2pt_po_apr_grp`, `transport_dev.transport.uvw_pc_masterdata` |

## View Query

```sql
Select distinct BUKRS as Co_Code, PUR_GRP_FROM
from staged.stg_sap_hana_cf_sap_ecc.zp2pt_po_apr_grp s
inner join transport_dev.transport.uvw_pc_masterdata t 
ON int(PRCTR) = t.PC_ID
where s.deleted_in_source =0
UNION all
Select distinct BUKRS as Co_Code, PUR_GRP_FROM
from staged.stg_sap_hana_cf_sap_ecc.zp2pt_po_apr_grp s
where int(PRCTR)=90240 and s.deleted_in_source =0
UNION all
Select distinct BUKRS as Co_Code, PUR_GRP_FROM
from staged.stg_sap_hana_cf_sap_ecc.zp2pt_po_apr_grp s
where int(PRCTR)=90050 and s.deleted_in_source =0
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Co_Code` | `string` | No |  |
| `PUR_GRP_FROM` | `string` | No |  |

## Related Pages

- [[Transport Contract Tables - transport]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
