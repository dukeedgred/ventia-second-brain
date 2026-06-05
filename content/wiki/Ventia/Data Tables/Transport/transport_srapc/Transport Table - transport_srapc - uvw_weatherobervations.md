---
type: data-table
topic: Ventia
sector: Transport
contract-schema: transport_srapc
table-name: uvw_weatherobervations
full-name: transport_dev.transport_srapc.uvw_weatherobervations
date-created: 2026-06-05
date-updated: 2026-06-05
tags: [transport, data-table, databricks, transport-srapc, weather]
---

# Transport Table - transport_srapc - uvw_weatherobervations

## Identity

| Field | Value |
|---|---|
| Table name | `uvw_weatherobervations` |
| Full name | `transport_dev.transport_srapc.uvw_weatherobervations` |
| Catalog | `transport_dev` |
| Schema | `transport_srapc` |
| Contract/schema | `transport_srapc` |
| Table type | VIEW |
| Column count | 26 |
| Last documented | 2026-06-05 |

## Context

| Field | Value |
|---|---|
| Data domain | weather |
| Related tables/reports | `staged_dev.stg_api_bom_au.bom_au_station_weather_details` |

## View Query

```sql
select
  case
    when name = 'Holsworthy (Defence)' then '068263'
    when name = 'Campbelltown' then '068257'
    when name = 'Richmond' then '067105'
    when name = 'Mount Boyce' then '063292'
    when name = 'Holsworthy' then '066161'
    when name = 'Badgerys Creek' then '067108'
    when name = 'Camden' then '068192'
    when name = 'Penrith' then '067113'
    else null
  end as station_id,
  w.name as station_name,
  w.wmo,
  w.history_product,
  to_timestamp(w.local_date_time_full, 'yyyyMMddHHmmss') as local_date_time,
  w.local_date_time_full,
  w.aifstime_utc as utc_date_time_full,
  w.lat,
  w.lon,
  w.weather,
  w.air_temp,
  w.apparent_t,
  w.dewpt,
  w.rel_hum,
  w.delta_t,
  w.vis_km,
  w.wind_dir,
  w.wind_spd_kmh,
  w.wind_spd_kt,
  w.gust_kmh,
  w.gust_kt,
  w.press_qnh,
  w.press_msl,
  w.press_tend,
  r.rain_since_9am,
  case
    when
      (
        r.rain_since_9am < lag(r.rain_since_9am) over (
            partition by r.wmo
            order by r.local_date_time_full
          )
      )
      or substring(r.local_date_time_full, 9, 4) = '9000'
    then
      cast(r.rain_since_9am as decimal(5, 1))
    else
      cast(
        ( r.rain_since_9am
          - lag(r.rain_since_9am) over (partition by r.wmo order by r.local_date_time_full)
        ) as decimal(5, 1)
      )
  end as rain_since_last_read
from
  staged_dev.stg_api_bom_au.bom_au_station_weather_details w
  left join (
              select
                wmo,
                local_date_time_full,
                coalesce(try_to_number(rain_trace, '9999.99'), 0) as rain_since_9am
              from
                staged_dev.stg_api_bom_au.bom_au_station_weather_details
            ) r
      on r.wmo = w.wmo
      and r.local_date_time_full = w.local_date_time_full
order by
  w.name,
  w.local_date_time_full
```

## Columns

| Column | Data type | Nullable | Notes |
|---|---|---|---|
| `station_id` | `string` | Yes |  |
| `station_name` | `string` | Yes | Represents the name or designation of the weather station. |
| `wmo` | `bigint` | No | World Meteorological Organization station identifier used to uniquely identify a weather station. |
| `history_product` | `string` | No | Represents the historical weather data product or category associated with the station. |
| `local_date_time` | `timestamp` | Yes |  |
| `local_date_time_full` | `string` | Yes | Represents the complete local date and time of the weather data observation, providing more precision or granularity. |
| `utc_date_time_full` | `string` | No | Represents the UTC (Coordinated Universal Time) date and time of the weather data observation in a string format. |
| `lat` | `double` | Yes | Represents the latitude coordinate of the weather station's location in decimal degrees. |
| `lon` | `double` | Yes | Represents the longitude coordinate of the weather station's location in decimal degrees. |
| `weather` | `string` | Yes | Represents the observed or reported weather condition at the weather station. |
| `air_temp` | `double` | Yes | Represents the ambient air temperature measured at the weather station, typically expressed in degrees Celsius. |
| `apparent_t` | `double` | Yes | Represents the perceived temperature adjusted for humidity and wind conditions. |
| `dewpt` | `double` | Yes | Represents the dew point temperature, indicating the temperature at which air becomes saturated with moisture. |
| `rel_hum` | `bigint` | Yes | Represents the relative humidity, expressed as a percentage, indicating the amount of moisture in the air relative to the maximum it could hold at the same temperature. |
| `delta_t` | `double` | Yes | Represents the temperature difference between two related temperature values, typically indicative of atmospheric instability. |
| `vis_km` | `string` | Yes | Represents the visibility distance measured in kilometers, indicating how far objects can be seen clearly from the observation point. |
| `wind_dir` | `string` | Yes | Represents the observed wind direction at the weather station, typically expressed in degrees from true north. |
| `wind_spd_kmh` | `bigint` | Yes | Represents the wind speed measured in kilometers per hour. |
| `wind_spd_kt` | `bigint` | Yes | Represents the wind speed measured in knots. |
| `gust_kmh` | `bigint` | Yes | Represents the wind gust speed measured in kilometers per hour. |
| `gust_kt` | `bigint` | Yes | Represents the wind gust speed measured in knots. |
| `press_qnh` | `string` | Yes | Represents the atmospheric pressure at sea level adjusted using the barometric formula, measured in hectopascals (hPa). |
| `press_msl` | `string` | Yes | Represents the atmospheric pressure reduced to mean sea level, typically used for weather analysis and forecasting. |
| `press_tend` | `string` | Yes | Represents the trend or tendency of atmospheric pressure observed at the weather station, typically indicating whether it is rising, falling, or steady. |
| `rain_since_9am` | `decimal(12,2)` | Yes |  |
| `rain_since_last_read` | `decimal(5,1)` | Yes |  |

## Related Pages

- [[Transport Contract Tables - transport_srapc]]
- [[Transport Data Tables]]
- [[Transport Data Landscape]]
- [[Ventia Databricks Platform]]
