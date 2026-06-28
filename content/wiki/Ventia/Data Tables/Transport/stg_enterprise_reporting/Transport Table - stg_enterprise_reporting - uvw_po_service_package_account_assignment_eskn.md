---
type: data-table
topic: Ventia
sector: Transport
contract-schema: stg_enterprise_reporting
table-name: uvw_po_service_package_account_assignment_eskn
full-name: transport_dev.stg_enterprise_reporting.uvw_po_service_package_account_assignment_eskn
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, stg-enterprise-reporting]
---

# Transport Table - stg_enterprise_reporting - uvw_po_service_package_account_assignment_eskn

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_po_service_package_account_assignment_eskn` |
| Full name | `transport_dev.stg_enterprise_reporting.uvw_po_service_package_account_assignment_eskn` |
| Catalog | `transport_dev` |
| Schema | `stg_enterprise_reporting` |
| Contract/schema | `stg_enterprise_reporting` |
| Table type | VIEW |
| Column count | 8 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | commercial / finance |
| Owner/SME | bhupesh.balani@ventia.com |
| Refresh/freshness | Created: 2025-08-12T13:34:42.653Z; Last altered: 2025-08-12T13:34:42.653Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
WITH Summary_ESKN AS (
SELECT
    s.PACKNO AS Entry_Sheet_Number,
    s.LOEKZ AS Deletion_Indicator,
    s.AEDAT AS Created_Date,
    CAST(CAST(s.SAKTO AS INT) AS STRING) AS GL_Account,
    CAST(CAST(s.KOSTL AS INT) AS STRING) AS Cost_Centre,
    CAST(CAST(s.AUFNR AS INT) AS STRING) AS Order_Number,
    s.EREKZ AS Final_Invoice_Indicator,
    CAST(CAST(s.PRCTR AS INT) AS STRING) AS Profit_Centre,
    replace(CAST(CAST(s.PS_PSP_PNR AS INT) AS STRING), '0', '') AS WBS_Element_Key,
    CAST(CAST(s.NPLNR AS INT) AS STRING) AS Network_Number,
    s.WPROZ AS Distribution_Percentage,
    s.ZEKKN as Seq_no,
    t.EBELN as PO_Document,
    t.EBELP as Item,
    v_TDP.Total_Distribution_Percent,
    w.POSID_EDIT as WBS_Element,
    CAST(CASE
        WHEN (CAST(CAST(s.KOSTL AS INT) AS STRING) = '' or CAST(CAST(s.KOSTL AS INT) AS STRING) is null) AND (CAST(CAST(s.AUFNR AS INT) AS STRING) = '' or CAST(CAST(s.AUFNR AS INT) AS STRING) is null) AND (CAST(CAST(s.NPLNR AS INT) AS STRING) = '' or CAST(CAST(s.NPLNR AS INT) AS STRING) is null) AND (w.POSID_EDIT <> '' and w.POSID_EDIT is not null) THEN
          w.POSID_EDIT
            WHEN (CAST(CAST(s.KOSTL AS INT) AS STRING) = '' or CAST(CAST(s.KOSTL AS INT) AS STRING) is null) AND (CAST(CAST(s.AUFNR AS INT) AS STRING) = '' or CAST(CAST(s.AUFNR AS INT) AS STRING) is null) AND (CAST(CAST(s.NPLNR AS INT) AS STRING) <> '' and CAST(CAST(s.NPLNR AS INT) AS STRING) is not null) AND (w.POSID_EDIT = '' or w.POSID_EDIT is null) THEN
              CAST(CAST(s.NPLNR AS INT) AS STRING)
                WHEN (CAST(CAST(s.KOSTL AS INT) AS STRING) = '' or CAST(CAST(s.KOSTL AS INT) AS STRING) is null) AND (CAST(CAST(s.AUFNR AS INT) AS STRING) <> '' and CAST(CAST(s.AUFNR AS INT) AS STRING) is not null) AND (CAST(CAST(s.NPLNR AS INT) AS STRING) = '' or CAST(CAST(s.NPLNR AS INT) AS STRING) is null) AND (w.POSID_EDIT = '' or w.POSID_EDIT is null) THEN
                  CAST(CAST(s.AUFNR AS INT) AS STRING)
                    WHEN (CAST(CAST(s.KOSTL AS INT) AS STRING) <> '' and CAST(CAST(s.KOSTL AS INT) AS STRING) is not null) AND (CAST(CAST(s.AUFNR AS INT) AS STRING) = '' or CAST(CAST(s.AUFNR AS INT) AS STRING) is null) AND (CAST(CAST(s.NPLNR AS INT) AS STRING) = '' or CAST(CAST(s.NPLNR AS INT) AS STRING) is null) AND (w.POSID_EDIT = '' or w.POSID_EDIT is null) THEN
                      CAST(CAST(s.KOSTL AS INT) AS STRING)
                        WHEN (CAST(CAST(s.KOSTL AS INT) AS STRING) <> '' and CAST(CAST(s.KOSTL AS INT) AS STRING) is not null) AND (CAST(CAST(s.AUFNR AS INT) AS STRING) <> '' and CAST(CAST(s.AUFNR AS INT) AS STRING) is not null) THEN
                          CAST(CAST(s.KOSTL AS INT) AS STRING)
                            ELSE
                              'Check'
      END AS STRING) AS Cost_Object
FROM staged.stg_sap_hana_cf_sap_ecc.eskn s
left join staged.stg_sap_hana_cf_sap_ecc.essr t
on s.PACKNO=t.LBLNI
left join(
    select v.EBELN, v.EBELP, sum(u.WPROZ) as Total_Distribution_Percent
    from staged.stg_sap_hana_cf_sap_ecc.eskn u
    left join staged.stg_sap_hana_cf_sap_ecc.essr v
    on u.PACKNO=v.LBLNI
    where u.deleted_in_source=0
    group by
        v.EBELN, v.EBELP
) as v_TDP
on concat(t.EBELN,'-',t.EBELP)= concat(v_TDP.EBELN,'-',v_TDP.EBELP)
LEFT JOIN staged.stg_sap_hana_cf_sap_ecc.prps w
on s.PS_PSP_PNR = w.PSPNR
WHERE s.deleted_in_source = 0
AND s.ZEKKN=s.BEKKN
)
SELECT
PO_Document,
Item,
Seq_no,
GL_Account,
Cost_Object,
Profit_Centre,
sum(Distribution_Percentage) as Distribution_Percentage,
avg(Total_Distribution_Percent) as Total_Distribution_Percent
FROM
Summary_ESKN
GROUP BY PO_Document, Item, Seq_no, GL_Account, Cost_Object, Profit_Centre
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `PO_Document` | `string` | Yes | Purchasing Document Number |
| `Item` | `string` | Yes | Item Number of Purchasing Document |
| `Seq_no` | `string` | No | Sequential Number of Account Assignment |
| `GL_Account` | `string` | Yes |  |
| `Cost_Object` | `string` | Yes |  |
| `Profit_Centre` | `string` | Yes |  |
| `Distribution_Percentage` | `decimal(14,1)` | Yes |  |
| `Total_Distribution_Percent` | `decimal(18,5)` | Yes |  |

## Related Pages

- [[Transport Contract Tables - stg_enterprise_reporting]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
