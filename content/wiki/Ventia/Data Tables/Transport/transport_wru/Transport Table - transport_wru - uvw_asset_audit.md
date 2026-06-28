---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_wru
table-name: uvw_asset_audit
full-name: transport_dev.transport_wru.uvw_asset_audit
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-wru]
---

# Transport Table - transport_wru - uvw_asset_audit

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_asset_audit` |
| Full name | `transport_dev.transport_wru.uvw_asset_audit` |
| Catalog | `transport_dev` |
| Schema | `transport_wru` |
| Contract/schema | `transport_wru` |
| Table type | VIEW |
| Column count | 9 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Data domain | asset register / hierarchy |
| Owner/SME | unknown |
| Refresh/freshness | Created: 2024-11-13T23:32:29.815Z; Last altered: 2024-11-13T23:32:29.815Z |
| Source details | Data source format: UNKNOWN_DATA_SOURCE_FORMAT |

## View Query

```sql
(
  SELECT
    a.id,
    c.AssetID,
    c.Modified,
    c.ModifiedUser,
    c.DeltaUTC,
    c.DisplayName,
    c.OriginalValue,
    CASE
    WHEN c.DisplayName = 'Record Created' then 'Active' else c.NewValue
    end as NewValue,
    to_date(c.Modified) as datekey
  FROM
    ext_mssql_asset_vision_ven_vicroads.dbo.asset a
    INNER JOIN ext_mssql_asset_vision_ven_vicroads.dbo.assetaudit c on a.id = c.AssetID
  WHERE
    a.contract LIKE '%Western Roads Upgrade (WRU)%'
    and a.code not in (
      'SS0616',
      'SS0821',
      'SS0922',
      'SS1275',
      'SN9633',
      'SN0681',
      'SN0751',
      'SN0806',
      'SN6189',
      'SN6215',
      'SN6567',
      'SN7043',
      'SN7892',
      'SN9463',
      'SN9483',
      'SN9628',
      'SN2654',
      'SN2655',
      'SN2678',
      'SN2758'
    )
    AND a.deleted = false
    AND c.displayname in ('Stage', 'Notes', 'Record Created')
)
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `id` | `int` | Yes |  |
| `AssetID` | `int` | Yes |  |
| `Modified` | `timestamp` | Yes |  |
| `ModifiedUser` | `string` | Yes |  |
| `DeltaUTC` | `timestamp` | Yes |  |
| `DisplayName` | `string` | Yes |  |
| `OriginalValue` | `string` | Yes |  |
| `NewValue` | `string` | Yes |  |
| `datekey` | `date` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_wru]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
