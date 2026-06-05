---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_fndc
table-name: weather_hourly_forecast
full-name: transport_dev.transport_fndc.weather_hourly_forecast
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-table, databricks, transport-fndc, weather]
---

# Transport Table - transport_fndc - weather_hourly_forecast

## Identity

| Field | Value |
|---|---|
| Table name | `weather_hourly_forecast` |
| Full name | `transport_dev.transport_fndc.weather_hourly_forecast` |
| Catalog | `transport_dev` |
| Schema | `transport_fndc` |
| Contract/schema | `transport_fndc` |
| Table type | MANAGED |
| Column count | 6 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | weather |

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `time` | `timestamp` | Yes |  |
| `temperature_2m` | `double` | Yes |  |
| `relative_humidity_2m` | `bigint` | Yes |  |
| `precipitation` | `double` | Yes |  |
| `wind_speed_10m` | `double` | Yes |  |
| `loaded_at` | `timestamp` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_fndc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
