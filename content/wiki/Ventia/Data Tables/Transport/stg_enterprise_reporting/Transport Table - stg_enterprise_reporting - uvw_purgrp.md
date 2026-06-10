---
type: data-table
topic: Ventia
sector: Transport
contract-schema: stg_enterprise_reporting
table-name: uvw_purgrp
full-name: transport_dev.stg_enterprise_reporting.uvw_purgrp
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, stg-enterprise-reporting]
---

# Transport Table - stg_enterprise_reporting - uvw_purgrp

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_purgrp` |
| Full name | `transport_dev.stg_enterprise_reporting.uvw_purgrp` |
| Catalog | `transport_dev` |
| Schema | `stg_enterprise_reporting` |
| Contract/schema | `stg_enterprise_reporting` |
| Table type | VIEW |
| Column count | 3 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | bhupesh.balani@ventia.com |
| Refresh/freshness | Created: 2025-09-12T06:06:11.824Z; Last altered: 2025-09-12T06:06:11.824Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
SELECT
BUKRS as Co_Code,
PUR_GRP_FROM as Purch_Grp,
PUR_GRP_FROM_NAME as Purch_Grp_Description
from staged.stg_sap_hana_cf_sap_ecc.zp2pt_po_apr_grp
where deleted_in_source=0
Group By BUKRS, PUR_GRP_FROM, PUR_GRP_FROM_NAME
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Co_Code` | `string` | No | Company Code |
| `Purch_Grp` | `string` | No | Purchasing Group From |
| `Purch_Grp_Description` | `string` | Yes | Purchase Group Name (From) |

## Related Pages

- [[Transport Contract Tables - stg_enterprise_reporting]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
