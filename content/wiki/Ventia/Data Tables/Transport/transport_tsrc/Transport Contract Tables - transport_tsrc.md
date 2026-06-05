---
type: contract-table-catalog
topic: Ventia
sector: Transport
contract-schema: transport_tsrc
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-tables, contract-schema, transport-tsrc]
---

# Transport Contract Tables - transport_tsrc

This page catalogs table documentation for the `transport_tsrc` Transport schema. In Transport, schema differences usually indicate different contracts or contract groupings.

## Table Index

| Table | Full name | Type | Columns | Domain | Purpose |
|---|---|---|---:|---|---|
| [[Transport Table - transport_tsrc - bkp_uvw_incident_closures]] | `transport_dev.transport_tsrc.bkp_uvw_incident_closures` | MANAGED | 6 | incident closure |  |
| [[Transport Table - transport_tsrc - utbl_aed_asset_bridge]] | `transport_dev.transport_tsrc.utbl_aed_asset_bridge` | MANAGED | 56 | bridge asset |  |
| [[Transport Table - transport_tsrc - utbl_aed_assets]] | `transport_dev.transport_tsrc.utbl_aed_assets` | MANAGED | 4 | AED asset |  |
| [[Transport Table - transport_tsrc - utbl_aed_incidents_closures]] | `transport_dev.transport_tsrc.utbl_aed_incidents_closures` | MANAGED | 34 | incident closure |  |
| [[Transport Table - transport_tsrc - utbl_aed_incidents_events]] | `transport_dev.transport_tsrc.utbl_aed_incidents_events` | MANAGED | 6 | incident event |  |
| [[Transport Table - transport_tsrc - utbl_aed_incidents_list]] | `transport_dev.transport_tsrc.utbl_aed_incidents_list` | MANAGED | 11 | incident |  |
| [[Transport Table - transport_tsrc - uvw_traffic_closures]] | `transport_dev.transport_tsrc.uvw_traffic_closures` | VIEW | 17 | traffic closure |  |
| [[Transport Table - transport_tsrc - uvw_traffic_volume]] | `transport_dev.transport_tsrc.uvw_traffic_volume` | VIEW | 10 | traffic volume |  |

## Skipped Or Incomplete Inputs

- `utbl_aed_incidents_sr` was visible in the pasted input but the object was truncated before complete columns could be verified, so it has not been documented yet.
- One or more intervening TSRC objects between `utbl_aed_incidents_sr` and `uvw_traffic_closures`, including a KPI/abatement view query tail, were hidden or truncated by the pasted payload limit, so they have not been documented yet.

## Related Pages

- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
