---
type: data-table
topic: Ventia
sector: Transport
contract-schema: stg_enterprise_reporting
table-name: uvw_gr_ir_against_ses_ekbe
full-name: transport_dev.stg_enterprise_reporting.uvw_gr_ir_against_ses_ekbe
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, stg-enterprise-reporting]
---

# Transport Table - stg_enterprise_reporting - uvw_gr_ir_against_ses_ekbe

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_gr_ir_against_ses_ekbe` |
| Full name | `transport_dev.stg_enterprise_reporting.uvw_gr_ir_against_ses_ekbe` |
| Catalog | `transport_dev` |
| Schema | `stg_enterprise_reporting` |
| Contract/schema | `stg_enterprise_reporting` |
| Table type | VIEW |
| Column count | 8 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Owner/SME | bhupesh.balani@ventia.com |
| Refresh/freshness | Created: 2025-11-19T14:01:18.321Z; Last altered: 2025-11-19T14:01:18.321Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
WITH IR_Amount_SES AS (
    WITH GR_Amount_SES AS (
        WITH Approved_GR_Amount_SES AS (
            SELECT 
                t0.EBELN,
                t0.EBELP,
                t0.ZEKKN,
                t0.BELNR,
                t0.WRBTR,
                COALESCE(s.KZABN, '') AS Acceptance_Indicator,
                COALESCE(s.LOEKZ, '') AS Deletion_Indicator
            FROM staged.stg_sap_hana_cf_sap_ecc.ekbe t0
            LEFT JOIN staged.stg_sap_hana_cf_sap_ecc.essr s
                ON t0.BELNR = s.LBLNI
            WHERE t0.deleted_in_source = 0
        )
        SELECT 
            t1.EBELN AS PO_Document,
            t1.EBELP AS Item,
            t1.ZEKKN AS Seq_no,
            t1.BELNR AS Material_Document,
            t1.WRBTR AS SES_Amount,
            COALESCE(SUM(
                CASE
                    WHEN t2.SHKZG = 'H' THEN -t2.WRBTR
                    WHEN t2.SHKZG <> 'H' THEN t2.WRBTR
                    ELSE 0
                END
            ), 0) AS GR_SES,
            t1.Acceptance_Indicator,
            t1.Deletion_Indicator
        FROM Approved_GR_Amount_SES t1
        LEFT JOIN staged.stg_sap_hana_cf_sap_ecc.ekbe t2
            ON t1.EBELN = t2.EBELN
            AND t1.EBELP = t2.EBELP
            AND t1.BELNR = t2.LFBNR
            AND startswith(t1.BELNR, '10')
            AND startswith(t2.BELNR, '50')
        WHERE t1.Deletion_Indicator = ''
          AND (t2.deleted_in_source = 0 OR t2.deleted_in_source IS NULL)
          AND startswith(t1.BELNR, '10')
        GROUP BY 
            t1.EBELN, 
            t1.EBELP, 
            t1.ZEKKN,
            t1.BELNR, 
            t1.WRBTR,
            t1.acceptance_indicator,
            t1.deletion_indicator
    )
    SELECT 
        GR_Amount_SES.*,
        COALESCE(SUM(
            CASE
                WHEN t3.SHKZG = 'H' THEN -t3.WRBTR
                WHEN t3.SHKZG <> 'H' THEN t3.WRBTR
                ELSE 0
            END
        ), 0) AS IR_SES        
    FROM GR_Amount_SES
    LEFT JOIN staged.stg_sap_hana_cf_sap_ecc.ekbe t3
        ON GR_Amount_SES.PO_Document = t3.EBELN
        AND GR_Amount_SES.Item = t3.EBELP
        AND GR_Amount_SES.Material_Document = t3.LFBNR
        AND startswith(GR_Amount_SES.Material_Document, '10')
        AND startswith(t3.BELNR, '51')
    WHERE t3.deleted_in_source = 0 OR t3.deleted_in_source IS NULL
    GROUP BY 
        GR_Amount_SES.PO_Document, 
        GR_Amount_SES.Item, 
        GR_Amount_SES.Seq_no,
        GR_Amount_SES.Material_Document, 
        GR_Amount_SES.SES_Amount,
        GR_Amount_SES.GR_SES,
        GR_Amount_SES.acceptance_indicator,
        GR_Amount_SES.deletion_indicator
)
SELECT 
    IR_Amount_SES.PO_Document,
    IR_Amount_SES.Item,
    IR_Amount_SES.Acceptance_Indicator,
    IR_Amount_SES.Deletion_Indicator,
    IR_Amount_SES.Material_Document,
    IF(SES_Amount = GR_SES, SES_Amount, GR_SES) AS Approved_SES_GR,
    IF(SES_Amount = IR_SES, SES_Amount, IR_SES) AS Approved_SES_IR,
    IF(IR_Amount_SES.Deletion_Indicator='X',0, IF(IR_Amount_SES.Acceptance_Indicator='X',0,SES_Amount - GR_SES)) AS Unapproved_SES
FROM IR_Amount_SES
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `PO_Document` | `string` | No | Purchasing Document Number |
| `Item` | `string` | No | Item Number of Purchasing Document |
| `Acceptance_Indicator` | `string` | No |  |
| `Deletion_Indicator` | `string` | No |  |
| `Material_Document` | `string` | No | Number of Material Document |
| `Approved_SES_GR` | `decimal(23,2)` | Yes |  |
| `Approved_SES_IR` | `decimal(23,2)` | Yes |  |
| `Unapproved_SES` | `decimal(24,2)` | Yes |  |

## Related Pages

- [[Transport Contract Tables - stg_enterprise_reporting]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
