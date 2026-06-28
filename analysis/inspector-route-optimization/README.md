# Inspector Route Optimisation Prototype

This is a small Python proof-of-concept for road inspector route optimisation.
It uses sample RAMC/RAMCSC-style inspection tasks because the repository currently has
documented Databricks table schemas, not live row extracts.

Run:

```bash
python analysis/inspector-route-optimization/route_optimisation_demo.py
```

The default mode is `auto`: it tries OSRM road-network routing first and falls
back to an offline straight-coordinate approximation if internet access or the
service is unavailable.

Force the road-routing version:

```bash
python analysis/inspector-route-optimization/route_optimisation_demo.py --routing osrm
```

If Python rejects the OSRM HTTPS certificate chain on a local machine, this
demo can be run with:

```bash
python analysis/inspector-route-optimization/route_optimisation_demo.py --routing osrm --allow-insecure-tls
```

Do not use `--allow-insecure-tls` for production. Use a properly trusted
self-hosted or approved routing endpoint instead.

Generated outputs:

- `outputs/inspection_route_demo.html` - self-contained visual route summary.
- `outputs/optimised_route.csv` - ordered inspection route with indicative arrival times.
- `outputs/route_metrics.json` - metrics and assumptions.
- `databricks_contract_route_optimisation.py` - Databricks-ready script for
  running the optimisation per contractor/contract group and writing Delta
  outputs.
- `databricks_source_union_route_input.sql` - Databricks SQL notebook that
  unions source Asset Vision `vjob` tables and creates a filterable
  `route_input` view for the optimiser.

The HTML uses Leaflet with OpenStreetMap tiles for the map view, so the map
tiles require internet access when the file is opened. When OSRM succeeds, the
blue route line is generated from road geometry rather than direct lines between
inspection points. The same page also includes an offline coordinate fallback
plot if the map library, tiles, or routing service cannot load.

## Method

The demo solves a one-inspector TSP-style route with a fixed start/end depot.
It uses OSRM's table service for road-network travel times when available. For
small stop sets it runs exact Held-Karp; for larger lists it uses a nearest
neighbour route improved by 2-opt so the demo can handle more inspection sites.

For production, replace the demo matrix with travel times from an approved
routing source such as OSRM, GraphHopper, Google Routes, or a self-hosted
OpenStreetMap router. For multiple inspectors, shift constraints, breaks,
optional stops, and time windows, move from TSP to a Vehicle Routing Problem
solver such as OR-Tools.

## Best Current Data Candidates

- `transport_ramc.uvw_inspection`
- `transport_ramc.uvw_roadlastinspected`
- `transport_ramc.uvw_stripmap_wkt`
- `transport_ramc.uvw_stripmap_full`
- `transport_ramc.uvw_stripmap_jobs`
- `transport_ramc.uvw_job`

RAMC is a better pilot if the goal is to avoid overfitting to a highly mature
contract. The trade-off is that traffic-volume inputs are not as clearly
documented for RAMC in this prototype source set, so a real pilot would likely
need an external or adjacent traffic source.

## Databricks Pattern

Use `databricks_contract_route_optimisation.py` when moving from the local demo
to Databricks. The script expects a normalised table or temp view, then groups by
`contractor_id,route_date` by default and writes three Delta tables:

- route stop order: one row per depot/inspection stop sequence.
- route geometry: one road-following GeoJSON/WKT linestring per route.
- route metrics: travel minutes, service minutes, total minutes and method.

Minimum source columns:

```text
contractor_id, route_date, stop_id, stop_name, road_name,
latitude, longitude, priority, service_minutes, due_ts,
depot_latitude, depot_longitude, depot_name
```

Example Databricks setup:

```sql
CREATE OR REPLACE TEMP VIEW route_input AS
SELECT
  Contract AS contractor_id,
  current_date() AS route_date,
  InspectionId AS stop_id,
  InspectionName AS stop_name,
  RoadName AS road_name,
  Latitude AS latitude,
  Longitude AS longitude,
  Priority AS priority,
  25 AS service_minutes,
  DueDate AS due_ts,
  DepotLatitude AS depot_latitude,
  DepotLongitude AS depot_longitude,
  DepotName AS depot_name
FROM your_catalog.your_schema.your_due_inspections
WHERE Latitude IS NOT NULL
  AND Longitude IS NOT NULL
  AND Status IN ('Due', 'Scheduled');
```

Useful widget values:

```text
source_table = route_input
source_sql =
build_route_input_in_python = false
route_source_table = transport_dev.integ_transport_assets.asset_vision_route_source_union
route_input_table = transport_dev.integ_transport_assets.route_input
persist_route_input = false
group_columns = contractor_id,route_date
contract_filter =
inspection_id_filter =
job_id_filter =
stop_id_filter =
exclude_inspection_id_filter =
exclude_job_id_filter =
exclude_stop_id_filter =
show_input_preview = true
preview_limit = 100
run_optimisation = false
show_route_map = true
map_route_id =
map_max_routes = 5
map_tiles = CartoDB positron
map_line_colour = #0057B8
map_marker_style = numbered
routing_mode = auto
osrm_base_url = https://your-approved-osrm-endpoint
due_days = 60
include_completed = false
max_stops_per_route = 40
output_route_table = transport_dev.integ_transport_assets.route_optimised_stops
output_geometry_table = transport_dev.integ_transport_assets.route_optimised_geometry
output_metrics_table = transport_dev.integ_transport_assets.route_optimised_metrics
```

The Python notebook reads SQL data at `read_source()`. It uses
`spark.table(source_table)` by default, or `spark.sql(source_sql)` if the
`source_sql` widget is populated. Leave `run_optimisation = false` while checking
the preview tables, then set it to `true` when the filtered input looks right.

`map_tiles = CartoDB positron` gives a bright basemap. With numbered markers,
the depot is labelled `S/E` because the prototype uses the same selected site as
both the start and end point.

If switching to a SQL warehouse is inconvenient, set
`build_route_input_in_python = true`. The Python utility will rebuild the
`route_input` shape directly from
`transport_dev.integ_transport_assets.asset_vision_route_source_union` using the
same filter logic as the SQL CTE.

```python
from utils import (
    CONFIG,
    display_route_map,
    optimise_all_routes,
    preview_input,
    read_source,
    refresh_config_from_widgets,
    validate_source,
    write_outputs,
)

refresh_config_from_widgets()

CONFIG["build_route_input_in_python"] = True
CONFIG["route_source_table"] = "transport_dev.integ_transport_assets.asset_vision_route_source_union"
CONFIG["persist_route_input"] = False

df = read_source(spark_session=spark)
validate_source(df)
preview_input(df)

stop_rows, geometry_rows, metric_rows = optimise_all_routes(df, spark_session=spark)

if stop_rows:
    write_outputs(stop_rows, geometry_rows, metric_rows, spark_session=spark)
    display_route_map(stop_rows, geometry_rows, spark_session=spark)
else:
    print("No route rows were produced. Check the filter widgets.")
```

Set `persist_route_input = true` if you also want Python to overwrite
`transport_dev.integ_transport_assets.route_input` for inspection/debugging.

The default grouping is `contractor_id,route_date`, so one inspection can become
multiple coloured routes if its jobs have different due dates. For one route per
inspection, set:

```python
CONFIG["group_columns"] = ["contractor_id", "inspection_id"]
```

When `build_route_input_in_python = true`, the site-depot selection uses the
same grouping columns, so the route and depot grouping stay aligned.

For a quick one-job test, set `job_id_filter` to the Asset Vision `job_id`.
Because the SQL maps `job_id` to `stop_id`, `stop_id_filter` works too:

```python
CONFIG["source_table"] = "transport_dev.integ_transport_assets.route_input"
CONFIG["job_id_filter"] = "123456"
CONFIG["run_optimisation"] = True
```

To skip a bad record while keeping the rest of the selected contract/inspection,
use the exclude filters. These accept one value or a comma-separated list:

```python
CONFIG["inspection_id_filter"] = ""
CONFIG["exclude_inspection_id_filter"] = "20933"
CONFIG["exclude_job_id_filter"] = "123456,123457"
```

In the SQL source notebook, `exclude_inspection_id_filter` and
`exclude_job_id_filter` are applied while building
`asset_vision_route_source_union`, so excluded records are removed from the
persisted source table as well as the downstream `route_input`.

In the SQL source notebook, `contract_filter`, `inspection_id_filter`, and
`job_id_filter` are Databricks dropdown widgets. The dropdowns are populated
from the persisted `${output_table}` after the source union has been built.
Pick a contract first, then rerun the dropdown-refresh cell to narrow the
inspection and job lists to that contract. The dropdown choices are capped at
1,000 values so the notebook UI stays usable; use contract filtering first when
there are many jobs.

If you move the functions into an imported Databricks module such as
`utils/utils.py`, pass the notebook Spark session explicitly:

```python
from utils.utils import optimise_all_routes, write_outputs

stop_rows, geometry_rows, metric_rows = optimise_all_routes(spark_session=spark)
write_outputs(stop_rows, geometry_rows, metric_rows, spark_session=spark)
```

Imported Python modules do not automatically inherit the notebook's global
`spark` variable.

### Interactive Map in Databricks

Install Folium once on the cluster/notebook if needed:

```python
%pip install folium
```

Then restart Python if Databricks asks you to, re-import your utilities, and run:

```python
from utils.utils import (
    CONFIG,
    display_route_map,
    optimise_all_routes,
    preview_input,
    read_source,
    validate_source,
    write_outputs,
)

CONFIG["source_table"] = "transport_dev.integ_transport_assets.route_input"
CONFIG["run_optimisation"] = True

df = read_source(spark_session=spark)
validate_source(df)
preview_input(df)

if CONFIG["run_optimisation"]:
    stop_rows, geometry_rows, metric_rows = optimise_all_routes(df, spark_session=spark)
    write_outputs(stop_rows, geometry_rows, metric_rows, spark_session=spark)
    display_route_map(stop_rows, geometry_rows)
else:
    print("Preview only. Set run_optimisation to true to optimise, write outputs, and show the map.")
```

To map already-written output tables instead of in-memory rows:

```python
from utils.utils import display_route_map

display_route_map(spark_session=spark, max_routes=5)
```

To show one route only, copy a `route_id` from the metrics output and pass it:

```python
display_route_map(spark_session=spark, route_id="RAMC_2026_06_15_r001_abc123")
```

For production, do not point high-volume Databricks jobs at the public OSRM demo
server. Use a self-hosted OSRM/GraphHopper endpoint or an approved paid routing
API, and run the optimiser on a filtered set of due inspections rather than full
history.

### Source-Table Union

If you want to avoid curated `transport_dev.transport_*` views, run
`databricks_source_union_route_input.sql` first. It unions documented Asset
Vision source `vjob` tables:

- `ext_mssql_asset_vision_ven_gen7.dbo.vjob` for RAMC / BAC / PoB / TSRC.
- `ext_mssql_asset_vision_ven_vicroads.dbo.vjob` for WRU.
- `ext_mssql_asset_vision_vns_gen7.dbo.vjob` for SHT / WHT.
- `ext_mssql_asset_vision_vnz_gen7.dbo.vjob` for Auckland West.
- `ext_mssql_asset_vision_vsm_gen7.dbo.vjob` for VentureSmart.

The SQL notebook creates:

- `asset_vision_route_source_union`: routeable source jobs with WKT-derived
  latitude/longitude.
- `route_input`: filtered optimiser input using widgets for contract,
  inspection id, completed-status inclusion, and inspections due from today
  through the next `due_days` days. The default `due_days` is 60.
- a persisted raw source Delta table controlled by the `output_table` widget.
- a persisted optimiser input Delta table controlled by the `route_input_table`
  widget. Use this table as `source_table` if the optimiser runs in a separate
  notebook/job.

Default persisted tables use the existing Transport schema:

```text
output_table = transport_dev.integ_transport_assets.asset_vision_route_source_union
route_input_table = transport_dev.integ_transport_assets.route_input
```

The route input no longer uses a fixed placeholder depot. For each
`contractor_id, route_date` group, the SQL chooses the earliest due site in that
group as the start/end location and writes it to `depot_latitude`,
`depot_longitude`, and `depot_name`. The selected site's `stop_id` is also
preserved as `depot_stop_id`, with `depot_source =
earliest_due_site_in_route_group`.

The documented `ext_mssql_asset_vision_ven_rms_old` source context maps to
SRAPC but does not currently have a documented source `vjob` table in this repo,
so SRAPC may need either a refreshed source inventory or the curated
`transport_dev.transport_srapc.uvw_job` view.

## Data Needed To Improve

- Actual inspection rows with routeable lat/lon, WKT, or segment geometry.
- Inspector depot, start/end locations, shift length, breaks, and available crew count.
- Inspection frequency rules by road class, direction, asset type, and contract obligation.
- Estimated inspection duration calibrated from completed historical work.
- Traffic-aware travel-time matrix, ideally time-of-day sensitive.
- Historical planned versus completed routes for validation.
- Rules for deferring, splitting, or grouping lower-priority inspections with nearby jobs.
