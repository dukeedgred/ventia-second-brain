---
type: data-table
topic: Ventia
sector: Transport
contract-schema: stg_enterprise_reporting
table-name: uvw_po_history_ekbe
full-name: transport_dev.stg_enterprise_reporting.uvw_po_history_ekbe
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, stg-enterprise-reporting]
---

# Transport Table - stg_enterprise_reporting - uvw_po_history_ekbe

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_po_history_ekbe` |
| Full name | `transport_dev.stg_enterprise_reporting.uvw_po_history_ekbe` |
| Catalog | `transport_dev` |
| Schema | `stg_enterprise_reporting` |
| Contract/schema | `stg_enterprise_reporting` |
| Table type | VIEW |
| Column count | 11 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | commercial / finance |
| Owner/SME | bhupesh.balani@ventia.com |
| Refresh/freshness | Created: 2025-11-10T07:22:12.009Z; Last altered: 2025-11-10T07:22:12.009Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
WITH PO_History AS (
    SELECT
        EBELN AS PO_Document,
        EBELP AS Item,
        BELNR AS Material_Document,
        BWART AS Movement_Type,
        BUDAT AS Posting_Date,
        SUM(CAST(CASE 
            WHEN SHKZG = 'H' THEN -DMBTR 
            ELSE DMBTR 
        END AS Decimal(21,3))) AS Amount_in_Loc_curr,
        SUM(WRBTR) AS Local_Currency,
        WAERS AS CURR,
        LFBNR AS Reference_Material_Document,
        WERKS AS Co_Code,
        MWSKZ AS Tax_Code,
        BEWTP AS GR_IR,
        SUM(MENGE) AS PO_Qty,
        SUM(AREWR) AS GR_Adjustment_Amount,
        XBLNR AS Reference_Document_Number,
        SHKZG AS Debit_Credit_Indicator,
        ZEKKN AS Seq_no,
        CASE
            WHEN startswith(BELNR, '50') THEN 'GR'
            WHEN startswith(BELNR, '51') THEN 'IR'
            WHEN startswith(BELNR, '54') THEN 'GR_Adjustment'
            WHEN startswith(BELNR, '10') THEN 'Service_Entry'
            WHEN startswith(BELNR, '00') THEN 'Delivery_Note'
            WHEN startswith(BELNR, '49') THEN 'Good_Issue'
            ELSE 'Check'
        END AS Movement_Category,
        SUM(t.Approved_SES_GR) AS Approved_SES_GR,
        SUM(t.Approved_SES_IR) AS Approved_SES_IR,
        SUM(t.Unapproved_SES) AS Unapproved_SES,
        t.Acceptance_Indicator,
        t.Deletion_Indicator
    FROM staged.stg_sap_hana_cf_sap_ecc.ekbe s
    LEFT JOIN transport_dev.stg_enterprise_reporting.uvw_GR_IR_Against_SES_EKBE t
        ON s.EBELN = t.PO_Document
        AND s.EBELP = t.Item
        AND s.BELNR = t.Material_Document
    WHERE deleted_in_source = 0
    GROUP BY ALL
)
SELECT
    PO_Document,
    Item,
    ROUND(SUM(CAST(CASE
        WHEN Movement_Category = 'GR' AND Debit_Credit_Indicator = 'H' THEN -PO_Qty
        WHEN Movement_Category = 'GR' AND Debit_Credit_Indicator <> 'H' THEN PO_Qty
        ELSE 0
    END AS STRING)), 3) AS GR_Qty,
    ROUND(SUM(CAST(CASE
        WHEN Movement_Category = 'IR' AND Debit_Credit_Indicator = 'H' THEN -PO_Qty
        WHEN Movement_Category = 'IR' AND Debit_Credit_Indicator <> 'H' THEN PO_Qty
        ELSE 0
    END AS STRING)), 3) AS IR_Qty,
    ROUND(SUM(CAST(CASE
        WHEN Movement_Category = 'GR_Adjustment' AND Debit_Credit_Indicator = 'H' THEN -PO_Qty
        WHEN Movement_Category = 'GR_Adjustment' AND Debit_Credit_Indicator <> 'H' THEN PO_Qty
        ELSE 0
    END AS STRING)), 3) AS MR11_Qty,
    ROUND(SUM(CAST(CASE
        WHEN Movement_Category = 'Service_Entry' AND Amount_in_Loc_curr > 0 THEN PO_Qty
        ELSE 0
    END AS STRING)), 3) AS Service_PO_GR_Qty,
    ROUND(SUM(CAST(CASE
        WHEN Movement_Category = 'GR' THEN Amount_in_Loc_curr 
        ELSE 0
    END AS STRING)), 2) AS GR_Amount,
    ROUND(SUM(CAST(CASE
        WHEN Movement_Category = 'IR' THEN Amount_in_Loc_curr 
        ELSE 0
    END AS STRING)), 2) AS IR_Amount,
    ROUND(SUM(CAST(CASE
        WHEN Movement_Category = 'GR_Adjustment' AND Debit_Credit_Indicator = 'H' THEN -GR_Adjustment_Amount
        WHEN Movement_Category = 'GR_Adjustment' AND Debit_Credit_Indicator <> 'H' THEN GR_Adjustment_Amount
        ELSE 0
    END AS STRING)), 2) AS MR11_Amount,
    ROUND(SUM(CAST(CASE
        WHEN Movement_Category = 'Service_Entry' THEN Approved_SES_GR 
        ELSE 0
    END AS STRING)), 2) AS Service_PO_GR_Amount,
    SUM(zeroifnull(Unapproved_SES)) AS Unapproved_SES
FROM PO_History
GROUP BY
    PO_Document, 
    Item
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `PO_Document` | `string` | No | Purchasing Document Number |
| `Item` | `string` | No | Item Number of Purchasing Document |
| `GR_Qty` | `double` | Yes |  |
| `IR_Qty` | `double` | Yes |  |
| `MR11_Qty` | `double` | Yes |  |
| `Service_PO_GR_Qty` | `double` | Yes |  |
| `GR_Amount` | `double` | Yes |  |
| `IR_Amount` | `double` | Yes |  |
| `MR11_Amount` | `double` | Yes |  |
| `Service_PO_GR_Amount` | `double` | Yes |  |
| `Unapproved_SES` | `decimal(38,2)` | Yes |  |

## Related Pages

- [[Transport Contract Tables - stg_enterprise_reporting]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
