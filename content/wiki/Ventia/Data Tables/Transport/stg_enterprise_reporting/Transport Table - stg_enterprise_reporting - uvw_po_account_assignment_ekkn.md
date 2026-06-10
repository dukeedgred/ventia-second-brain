---
type: data-table
topic: Ventia
sector: Transport
contract-schema: stg_enterprise_reporting
table-name: uvw_po_account_assignment_ekkn
full-name: transport_dev.stg_enterprise_reporting.uvw_po_account_assignment_ekkn
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, stg-enterprise-reporting]
---

# Transport Table - stg_enterprise_reporting - uvw_po_account_assignment_ekkn

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_po_account_assignment_ekkn` |
| Full name | `transport_dev.stg_enterprise_reporting.uvw_po_account_assignment_ekkn` |
| Catalog | `transport_dev` |
| Schema | `stg_enterprise_reporting` |
| Contract/schema | `stg_enterprise_reporting` |
| Table type | VIEW |
| Column count | 18 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | commercial / finance |
| Owner/SME | bhupesh.balani@ventia.com |
| Refresh/freshness | Created: 2025-08-29T15:42:23.869Z; Last altered: 2025-08-29T15:42:23.869Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
SELECT
    s.EBELN AS PO_Document,
    s.EBELP AS Item,
    CAST(CAST(s.SAKTO AS INT) AS STRING) AS GL_Account,
    CAST(CAST(s.KOSTL AS INT) AS STRING) AS Cost_Centre,
    CAST(CAST(s.PRCTR AS INT) AS STRING) AS Profit_Centre,
    replace(s.APLZL_ORD, '00000000','') AS Activity,
    replace(CAST(CAST(s.PS_PSP_PNR AS INT) AS STRING), '0', '') AS WBS_Element_Key,
    CAST(CAST(s.NPLNR AS INT) AS STRING) AS Network_Number,
    CAST(CAST(s.AUFNR AS INT) AS STRING) AS Order_Number,
    s.VPROZ AS Distribution_Percentage,
    s.MENGE as Distribution_Qty,
    s.ZEKKN as Seq_no,
    t.VRTKZ as Distribution_Indicator,
    u_TDQ.Total_Distribution_Qty,
    u_TDQ.Total_Distribution_Percent,
    CAST(CASE WHEN t.VRTKZ = '1' OR t.VRTKZ = '2' THEN 'Yes' ELSE 'No' END AS STRING) AS MultipleAccountAssignment,
    v.POSID_EDIT as WBS_Element,
    CAST(CASE
        WHEN (CAST(CAST(s.KOSTL AS INT) AS STRING) = '' or CAST(CAST(s.KOSTL AS INT) AS STRING) is null) AND (CAST(CAST(s.AUFNR AS INT) AS STRING) = '' or CAST(CAST(s.AUFNR AS INT) AS STRING) is null) AND (CAST(CAST(s.NPLNR AS INT) AS STRING) = '' or CAST(CAST(s.NPLNR AS INT) AS STRING) is null) AND (v.POSID_EDIT <> '' and v.POSID_EDIT is not null) THEN
          v.POSID_EDIT
            WHEN (CAST(CAST(s.KOSTL AS INT) AS STRING) = '' or CAST(CAST(s.KOSTL AS INT) AS STRING) is null) AND (CAST(CAST(s.AUFNR AS INT) AS STRING) = '' or CAST(CAST(s.AUFNR AS INT) AS STRING) is null) AND (CAST(CAST(s.NPLNR AS INT) AS STRING) <> '' and CAST(CAST(s.NPLNR AS INT) AS STRING) is not null) AND (v.POSID_EDIT = '' or v.POSID_EDIT is null) THEN
              CAST(CAST(s.NPLNR AS INT) AS STRING)
                WHEN (CAST(CAST(s.KOSTL AS INT) AS STRING) = '' or CAST(CAST(s.KOSTL AS INT) AS STRING) is null) AND (CAST(CAST(s.AUFNR AS INT) AS STRING) <> '' and CAST(CAST(s.AUFNR AS INT) AS STRING) is not null) AND (CAST(CAST(s.NPLNR AS INT) AS STRING) = '' or CAST(CAST(s.NPLNR AS INT) AS STRING) is null) AND (v.POSID_EDIT = '' or v.POSID_EDIT is null) THEN
                  CAST(CAST(s.AUFNR AS INT) AS STRING)
                    WHEN (CAST(CAST(s.KOSTL AS INT) AS STRING) <> '' and CAST(CAST(s.KOSTL AS INT) AS STRING) is not null) AND (CAST(CAST(s.AUFNR AS INT) AS STRING) = '' or CAST(CAST(s.AUFNR AS INT) AS STRING) is null) AND (CAST(CAST(s.NPLNR AS INT) AS STRING) = '' or CAST(CAST(s.NPLNR AS INT) AS STRING) is null) AND (v.POSID_EDIT = '' or v.POSID_EDIT is null) THEN
                      CAST(CAST(s.KOSTL AS INT) AS STRING)
                        WHEN (CAST(CAST(s.KOSTL AS INT) AS STRING) <> '' and CAST(CAST(s.KOSTL AS INT) AS STRING) is not null) AND (CAST(CAST(s.AUFNR AS INT) AS STRING) <> '' and CAST(CAST(s.AUFNR AS INT) AS STRING) is not null) THEN
                          CAST(CAST(s.KOSTL AS INT) AS STRING)
                            WHEN (t.KNTTP='P' OR t.KNTTP='Q') THEN v.POSID_EDIT
                               WHEN t.KNTTP='N' THEN CAST(CAST(s.NPLNR AS INT) AS STRING)
                                WHEN (t.KNTTP='F' OR t.KNTTP='A') THEN CAST(CAST(s.AUFNR AS INT) AS STRING)
                                    WHEN t.KNTTP='K' THEN CAST(CAST(s.KOSTL AS INT) AS STRING)
                                        WHEN (t.KNTTP='U' OR t.KNTTP='') THEN 'Unknown'
                                            ELSE 'Check'
      END AS STRING) AS Cost_Object
FROM staged.stg_sap_hana_cf_sap_ecc.ekkn s
left join staged.stg_sap_hana_cf_sap_ecc.ekpo t
on concat(s.EBELN,'-',s.EBELP) = concat(t.EBELN,'-',t.EBELP)
left join(
  select u.EBELN, u.EBELP, sum(u.MENGE) as Total_Distribution_Qty, sum(u.VPROZ) as Total_Distribution_Percent
  from staged.stg_sap_hana_cf_sap_ecc.ekkn u
  where u.deleted_in_source=0
  group by
    u.EBELN, u.EBELP
) as u_TDQ
on concat(s.EBELN,'-',s.ebelp)= concat(u_TDQ.EBELN,'-',u_TDQ.EBELP)
LEFT JOIN staged.stg_sap_hana_cf_sap_ecc.prps v
on s.PS_PSP_PNR = v.PSPNR
WHERE s.deleted_in_source = 0
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `PO_Document` | `string` | No | Purchasing Document Number |
| `Item` | `string` | No | Item Number of Purchasing Document |
| `GL_Account` | `string` | Yes |  |
| `Cost_Centre` | `string` | Yes |  |
| `Profit_Centre` | `string` | Yes |  |
| `Activity` | `string` | Yes |  |
| `WBS_Element_Key` | `string` | Yes |  |
| `Network_Number` | `string` | Yes |  |
| `Order_Number` | `string` | Yes |  |
| `Distribution_Percentage` | `decimal(3,1)` | Yes | Distribution percentage in the case of multiple acct assgt |
| `Distribution_Qty` | `decimal(13,3)` | Yes | Quantity |
| `Seq_no` | `string` | No | Sequential Number of Account Assignment |
| `Distribution_Indicator` | `string` | Yes | Distribution indicator for multiple account assignment |
| `Total_Distribution_Qty` | `decimal(23,3)` | Yes |  |
| `Total_Distribution_Percent` | `decimal(13,1)` | Yes |  |
| `MultipleAccountAssignment` | `string` | No |  |
| `WBS_Element` | `string` | Yes | Work Breakdown Structure Element (WBS Element) Edited |
| `Cost_Object` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - stg_enterprise_reporting]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
