---
type: data-table
topic: Ventia
sector: Transport
contract-schema: stg_enterprise_reporting
table-name: uvw_po_delivery_dates_eket
full-name: transport_dev.stg_enterprise_reporting.uvw_po_delivery_dates_eket
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, stg-enterprise-reporting]
---

# Transport Table - stg_enterprise_reporting - uvw_po_delivery_dates_eket

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_po_delivery_dates_eket` |
| Full name | `transport_dev.stg_enterprise_reporting.uvw_po_delivery_dates_eket` |
| Catalog | `transport_dev` |
| Schema | `stg_enterprise_reporting` |
| Contract/schema | `stg_enterprise_reporting` |
| Table type | VIEW |
| Column count | 4 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | commercial / finance |
| Owner/SME | bhupesh.balani@ventia.com |
| Refresh/freshness | Created: 2025-08-20T02:34:33.841Z; Last altered: 2025-08-20T02:34:33.841Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
SELECT 
    EBELN AS PO_Document,
    EBELP AS Item,
    EINDT AS Delivery_Date,
    CASE 
        WHEN INT(LEFT(EINDT, 6)) < INT(DATE_FORMAT(NOW(), 'yyyyMM')) THEN 'Prior Month'
        WHEN INT(LEFT(EINDT, 6)) = INT(DATE_FORMAT(NOW(), 'yyyyMM')) THEN 'Current Month'
        ELSE 'Future Month'
    END AS Delivery_Due
FROM 
    staged.stg_sap_hana_cf_sap_ecc.eket
WHERE 
    deleted_in_source = 0
    AND MENGE>0
GROUP BY 
    EBELN, EBELP, EINDT
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `PO_Document` | `string` | No | Purchasing Document Number |
| `Item` | `string` | No | Item Number of Purchasing Document |
| `Delivery_Date` | `string` | Yes | Item Delivery Date |
| `Delivery_Due` | `string` | No |  |

## Related Pages

- [[Transport Contract Tables - stg_enterprise_reporting]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
