---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
table-name: utbl_ref_section_to_m_mapping_2_km_sections
full-name: transport_dev.transport_tsrc.utbl_ref_section_to_m_mapping_2_km_sections
date-created: 2026-06-09
date-updated: 2026-06-09
tags: [transport, data-table, databricks, transport-tsrc]
---

# Transport Table - transport_tsrc - utbl_ref_section_to_m_mapping_2_km_sections

## Identity

| Field | Value |
|---|---|
| Table name | `utbl_ref_section_to_m_mapping_2_km_sections` |
| Full name | `transport_dev.transport_tsrc.utbl_ref_section_to_m_mapping_2_km_sections` |
| Catalog | `transport_dev` |
| Schema | `transport_tsrc` |
| Contract/schema | `transport_tsrc` |
| Table type | MANAGED |
| Column count | 10 |
| Last documented | 2026-06-09 |

## Context

| Field | Value |
|---|---|
| Business purpose | Created by the file upload UI |
| Data domain | reference / mapping |
| Owner/SME | pranav.kumar@ventia.com |
| Refresh/freshness | Created: 2024-06-03T07:31:03.858Z; Last altered: 2026-06-09T05:40:04.834Z |
| Source details | Data source format: DELTA |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `ID` | `bigint` | Yes |  |
| `Start` | `bigint` | Yes |  |
| `End` | `bigint` | Yes |  |
| `Direction` | `string` | Yes |  |
| `AssetName` | `string` | Yes |  |
| `Area` | `bigint` | Yes |  |
| `IncidentKey` | `string` | Yes |  |
| `InterchangeName` | `string` | Yes |  |
| `SectionID` | `string` | Yes |  |
| `TrafficVolKey` | `string` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_tsrc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
