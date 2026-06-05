---
type: contract-table-catalog
topic: Ventia
sector: Transport
contract-schema: transport_srapc
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-tables, contract-schema, transport-srapc]
---

# Transport Contract Tables - transport_srapc

This page catalogs table documentation for the `transport_srapc` Transport schema. In Transport, schema differences usually indicate different contracts or contract groupings.

## Table Index

| Table | Full name | Type | Columns | Domain | Purpose |
|---|---|---|---:|---|---|
| [[Transport Table - transport_srapc - utbl_monthly_report]] | `transport_dev.transport_srapc.utbl_monthly_report` | MANAGED | 12 | monthly reporting |  |
| [[Transport Table - transport_srapc - utbl_srapc_formitize_mapping]] | `transport_dev.transport_srapc.utbl_srapc_formitize_mapping` | MANAGED | 7 | form mapping |  |
| [[Transport Table - transport_srapc - utbl_tacp_constants]] | `transport_dev.transport_srapc.utbl_tacp_constants` | MANAGED | 6 | TACP constants |  |
| [[Transport Table - transport_srapc - utbl_tacp_toc]] | `transport_dev.transport_srapc.utbl_tacp_toc` | MANAGED | 3 | TACP mapping |  |
| [[Transport Table - transport_srapc - utbl_tmp_civil_master]] | `transport_dev.transport_srapc.utbl_tmp_civil_master` | MANAGED | 54 | civil maintenance master |  |
| [[Transport Table - transport_srapc - uvw_weatherobervations]] | `transport_dev.transport_srapc.uvw_weatherobervations` | VIEW | 26 | weather |  |

## Skipped Or Incomplete Inputs

- `uvw_a_bridge_all_data` was visible in the pasted input but the schema was truncated before all columns and view SQL could be verified, so it has not been documented yet.
- A SRAPC TACP/export view object was visible only as the tail of a schema and query after truncation and without a verifiable table identity, so it has not been documented yet.

## Related Pages

- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
