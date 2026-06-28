---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_sht
table-name: uvw_weather_north_sydney_hourly_rolling_30days
full-name: transport_dev.transport_sht.uvw_weather_north_sydney_hourly_rolling_30days
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-table, databricks, transport-sht, weather]
---

# Transport Table - transport_sht - uvw_weather_north_sydney_hourly_rolling_30days

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_weather_north_sydney_hourly_rolling_30days` |
| Full name | `transport_dev.transport_sht.uvw_weather_north_sydney_hourly_rolling_30days` |
| Catalog | `transport_dev` |
| Schema | `transport_sht` |
| Contract/schema | `transport_sht` |
| Table type | VIEW |
| Column count | 62 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | weather |
| Related tables/reports | `staged_dev.stg_api_open_metro_au.north_sydney_hourly`, `staged_dev.stg_api_open_metro_au.weather_interpretation_codes` |

## View Query

```sql
select  w.date,
        w.date_local,
        w.location_name,
        w.location_timezone,
        w.temperature_2m,
        w.relative_humidity_2m,
        w.dew_point_2m,
        w.apparent_temperature,
        w.precipitation_probability,
        w.precipitation,
        w.rain,
        w.showers,
        w.snowfall,
        w.snow_depth,
        w.weather_code,
        wc.Description weather_condition,
        w.pressure_msl,
        w.surface_pressure,
        w.cloud_cover,
        w.cloud_cover_low,
        w.cloud_cover_mid,
        w.cloud_cover_high,
        w.visibility,
        w.evapotranspiration,
        w.et0_fao_evapotranspiration,
        w.vapour_pressure_deficit,
        w.wind_speed_10m,
        w.wind_speed_80m,
        w.wind_speed_120m,
        w.wind_speed_180m,
        w.wind_direction_10m,
        w.wind_direction_80m,
        w.wind_direction_120m,
        w.wind_direction_180m,
        w.wind_gusts_10m,
        w.temperature_80m,
        w.temperature_120m,
        w.temperature_180m,
        w.soil_temperature_0cm,
        w.soil_temperature_6cm,
        w.soil_temperature_18cm,
        w.soil_temperature_54cm,
        w.soil_moisture_0_to_1cm,
        w.soil_moisture_1_to_3cm,
        w.soil_moisture_3_to_9cm,
        w.soil_moisture_9_to_27cm,
        w.soil_moisture_27_to_81cm,
        w.uv_index,
        w.uv_index_clear_sky,
        w.is_day,
        w.sunshine_duration,
        w.wet_bulb_temperature_2m,
        w.total_column_integrated_water_vapour,
        w.cape,
        w.lifted_index,
        w.convective_inhibition,
        w.freezing_level_height,
        w.boundary_layer_height,
        w.row_created_exec_id,
        w.row_updated_exec_id,
        w.row_updated_timestamp,
        w.row_created_timestamp
from   staged_dev.stg_api_open_metro_au.north_sydney_hourly w
 left join staged_dev.stg_api_open_metro_au.weather_interpretation_codes wc on wc.Code = w.weather_code
where  w.date_local <= date_trunc('hour', from_utc_timestamp(current_timestamp(), 'Australia/Sydney'))  -- Show everything prior to current date and hour
  and  w.date_local >= date_trunc('hour',from_utc_timestamp(current_timestamp() - interval 30 day, 'Australia/Sydney'))
order by w.date_local desc
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `date` | `timestamp` | No |  |
| `date_local` | `timestamp` | Yes |  |
| `location_name` | `string` | No |  |
| `location_timezone` | `string` | Yes |  |
| `temperature_2m` | `float` | Yes |  |
| `relative_humidity_2m` | `float` | Yes |  |
| `dew_point_2m` | `float` | Yes |  |
| `apparent_temperature` | `float` | Yes |  |
| `precipitation_probability` | `float` | Yes |  |
| `precipitation` | `float` | Yes |  |
| `rain` | `float` | Yes |  |
| `showers` | `float` | Yes |  |
| `snowfall` | `float` | Yes |  |
| `snow_depth` | `float` | Yes |  |
| `weather_code` | `float` | Yes |  |
| `weather_condition` | `string` | Yes |  |
| `pressure_msl` | `float` | Yes |  |
| `surface_pressure` | `float` | Yes |  |
| `cloud_cover` | `float` | Yes |  |
| `cloud_cover_low` | `float` | Yes |  |
| `cloud_cover_mid` | `float` | Yes |  |
| `cloud_cover_high` | `float` | Yes |  |
| `visibility` | `float` | Yes |  |
| `evapotranspiration` | `float` | Yes |  |
| `et0_fao_evapotranspiration` | `float` | Yes |  |
| `vapour_pressure_deficit` | `float` | Yes |  |
| `wind_speed_10m` | `float` | Yes |  |
| `wind_speed_80m` | `float` | Yes |  |
| `wind_speed_120m` | `float` | Yes |  |
| `wind_speed_180m` | `float` | Yes |  |
| `wind_direction_10m` | `float` | Yes |  |
| `wind_direction_80m` | `float` | Yes |  |
| `wind_direction_120m` | `float` | Yes |  |
| `wind_direction_180m` | `float` | Yes |  |
| `wind_gusts_10m` | `float` | Yes |  |
| `temperature_80m` | `float` | Yes |  |
| `temperature_120m` | `float` | Yes |  |
| `temperature_180m` | `float` | Yes |  |
| `soil_temperature_0cm` | `float` | Yes |  |
| `soil_temperature_6cm` | `float` | Yes |  |
| `soil_temperature_18cm` | `float` | Yes |  |
| `soil_temperature_54cm` | `float` | Yes |  |
| `soil_moisture_0_to_1cm` | `float` | Yes |  |
| `soil_moisture_1_to_3cm` | `float` | Yes |  |
| `soil_moisture_3_to_9cm` | `float` | Yes |  |
| `soil_moisture_9_to_27cm` | `float` | Yes |  |
| `soil_moisture_27_to_81cm` | `float` | Yes |  |
| `uv_index` | `float` | Yes |  |
| `uv_index_clear_sky` | `float` | Yes |  |
| `is_day` | `float` | Yes |  |
| `sunshine_duration` | `float` | Yes |  |
| `wet_bulb_temperature_2m` | `float` | Yes |  |
| `total_column_integrated_water_vapour` | `float` | Yes |  |
| `cape` | `float` | Yes |  |
| `lifted_index` | `float` | Yes |  |
| `convective_inhibition` | `float` | Yes |  |
| `freezing_level_height` | `float` | Yes |  |
| `boundary_layer_height` | `float` | Yes |  |
| `row_created_exec_id` | `string` | Yes |  |
| `row_updated_exec_id` | `string` | Yes |  |
| `row_updated_timestamp` | `timestamp` | Yes |  |
| `row_created_timestamp` | `timestamp` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_sht]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
