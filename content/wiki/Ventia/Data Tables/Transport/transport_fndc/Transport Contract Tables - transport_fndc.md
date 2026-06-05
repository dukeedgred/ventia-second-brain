---
type: contract-table-catalog
topic: Ventia
sector: Transport
contract-schema: transport_fndc
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-tables, contract-schema, transport-fndc]
---

# Transport Contract Tables - transport_fndc

This page catalogs table documentation for the `transport_fndc` Transport schema. In Transport, schema differences usually indicate different contracts or contract groupings.

## Table Index

| Table | Full name | Type | Columns | Domain | Purpose |
|---|---|---|---:|---|---|
| [[Transport Table - transport_fndc - byo_tbl_kerikeri_weather_hr_fc]] | `transport_dev.transport_fndc.byo_tbl_kerikeri_weather_hr_fc` | MANAGED | 6 | weather |  |
| [[Transport Table - transport_fndc - byo_tbl_national_road_cl_nz]] | `transport_dev.transport_fndc.byo_tbl_national_road_cl_nz` | MANAGED | 26 | road network | National road centreline network, traffic, and road-controlling-authority data |
| [[Transport Table - transport_fndc - weather_hourly_forecast]] | `transport_dev.transport_fndc.weather_hourly_forecast` | MANAGED | 6 | weather |  |

## Skipped Or Incomplete Inputs

- `uvw_c_surface` was visible in the pasted input but the view query and following payload were truncated before the full object could be verified, so it has not been documented yet.
- A later treatment-length view object was visible only after truncation and without a verifiable table identity, so it has not been documented yet.

## Related Pages

- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
- [[Transport Contract Portfolio]]
