---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_kpi_1_noncompliant
full-name: transport_dev.transport_wru.uvw_kpi_1_noncompliant
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_kpi_1_noncompliant

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_kpi_1_noncompliant` |
| Full name | `transport_dev.transport_wru.uvw_kpi_1_noncompliant` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 3 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | KPI / reporting |
| Owner/SME | Helix_readwrite_transport_dev_transport_wru |
| Refresh/freshness | Created: 2024-06-18T12:40:11.388Z; Last altered: 2024-09-24T01:42:29.106Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
select
  DateUID,
  non_compliant,
  array_join(collect_set(Non_Compliant_Comments), ',') as Non_Compliant_Comments
from
  (
    --Non Compliant from AV tick box
    select
      b.Dateuid,
      a.Non_Compliant,
      a.Non_Compliant_Comments
    from
      (
        select
          inspection_ID,
          'Yes' as Non_Compliant,
          concat(
            'Inspection ',
            `Non-Compliant Information|Non-Compliant Inspection`
          ) as Non_Compliant_Comments
        from
          (
            select
              b.id as inspection_ID,
              a.name,
              a.value
            from
              ext_mssql_asset_vision_ven_vicroads.dbo.formfield a
              join transport_dev.transport_wru.uvw_inspection b on b.id = a.sourcetableid
            where
              a.sourcetable = 'Inspection'
              and a.name in(
                'Non-Compliant Information|Non-Compliant Inspection',
                'Non-Compliant Information|Non-Compliant Comments'
              )
              and a.deleted = false
          ) PIVOT (
            max(value) FOR name in (
              'Non-Compliant Information|Non-Compliant Inspection',
              'Non-Compliant Information|Non-Compliant Comments'
            )
          )
        where
          `Non-Compliant Information|Non-Compliant Inspection` is true
      ) a
      join transport_dev.transport_wru.uvw_inspection_hazard_defect b on a.Inspection_ID = b.inspection_ID
    union
      --Non Compliant from DTP (historical data)
    select
      b.DateUID,
      'Yes' as Non_Compliant,
      concat('Inspection ', a.Comments) as Non_Compliant_Comments
    from
      transport_dev.transport_wru.utbl_non_compliant_inspections a
      join transport_dev.transport_wru.uvw_inspection_hazard_defect b on a.Inspection_ID = b.inspection_ID
    
    union
      --Non Compliant from been late and not included in the AV tick box nor DTP historical data
      --Forward inspection
    select
      a.DateUID,
      'Yes' as Non_Compliant,
      concat('Inspection ', a.f_insp, ' was late.') as Non_Compliant_Comments
    from
      transport_dev.transport_wru.uvw_inspection_kpi_1_series a
      left join transport_dev.transport_wru.utbl_non_compliant_inspections b on a.f_insp = b.inspection_ID
      left join (
        select
          sourcetableid as inspection_ID
        from
          ext_mssql_asset_vision_ven_vicroads.dbo.formfield
        where
          sourcetable = 'Inspection'
          and name = 'Non-Compliant Information|Non-Compliant Inspection'
          and value is true
      ) c on a.f_insp = c.inspection_ID
    where
      b.inspection_ID is null
      and a.compliant_Timing = 'Late'
      and c.inspection_ID is null
    union
      --Reverse inspection
    select
      a.DateUID,
      'Yes' as Non_Compliant,
      concat('Inspection ', a.r_insp, ' was late.') as Non_Compliant_Comments
    from
      transport_dev.transport_wru.uvw_inspection_kpi_1_series a
      left join transport_dev.transport_wru.uvw_inspection_hazard_defect b on a.r_insp = b.inspection_ID
      left join (
        select
          sourcetableid as inspection_ID
        from
          ext_mssql_asset_vision_ven_vicroads.dbo.formfield
        where
          sourcetable = 'Inspection'
          and name = 'Non-Compliant Information|Non-Compliant Inspection'
          and value is true
      ) c on a.r_insp = c.inspection_ID
    where
      b.inspection_ID is null
      and a.compliant_Timing = 'Late'
      and a.f_insp <> a.r_insp
      and c.inspection_ID is null
  )
group by
  DateUID,
  non_compliant
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `DateUID` | `string` | Yes |  |
| `non_compliant` | `string` | No |  |
| `Non_Compliant_Comments` | `string` | No |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
