---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_sht
table-name: uvw_user_groups
full-name: transport_dev.transport_sht.uvw_user_groups
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-table, databricks, transport-sht, user-mapping]
---

# Transport Table - transport_sht - uvw_user_groups

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_user_groups` |
| Full name | `transport_dev.transport_sht.uvw_user_groups` |
| Catalog | `transport_dev` |
| Schema | `transport_sht` |
| Contract/schema | `transport_sht` |
| Table type | VIEW |
| Column count | 2 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | user mapping |
| Related tables/reports | `ext_mssql_asset_vision_vns_gen7.dbo.inspection` |

## View Query

```sql
select distinct 
  completeduser as `Completed User`,
  assigneduser as `Amended Completed User`
from
  ext_mssql_asset_vision_vns_gen7.dbo.inspection
where
  contract = 'Sydney Harbour Tunnel (SHT)'
  and completeduser != assigneduser
  and completeduser != ''
  and assigneduser != ''
  and assigneduser in (
    'VNS - Tech Crew',
    'Specialist Subcontractor',
    'VNS - RMWs',
    'VNS - Maintenance Crew'
  )
order by
  `Completed User`,
  `Amended Completed User`
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `Completed User` | `string` | Yes |  |
| `Amended Completed User` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_sht]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
