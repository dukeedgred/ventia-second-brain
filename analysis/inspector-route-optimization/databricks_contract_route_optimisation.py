# Databricks notebook source
"""Contract route optimisation for Databricks.

Run this after `databricks_source_union_route_input.sql` has created `route_input`.
If the SQL and Python are in different notebooks/jobs, use a persisted table
such as `transport_dev.integ_transport_assets.route_input` instead of the temp view.

Input view/table required by this script:

    contractor_id, route_date, stop_id, stop_name, road_name,
    latitude, longitude, priority, service_minutes, due_ts,
    depot_latitude, depot_longitude, depot_name

Outputs:

    transport_dev.integ_transport_assets.route_optimised_stops
    transport_dev.integ_transport_assets.route_optimised_geometry
    transport_dev.integ_transport_assets.route_optimised_metrics

Override the input and output table names with Databricks widgets if needed.
By default this notebook previews the input only. Set `run_optimisation = true`
when you are ready to write the output Delta tables.
"""

import hashlib
import html as html_lib
import http.client
import json
import math
import re
import ssl
import urllib.error
import urllib.parse
import urllib.request
from datetime import date, datetime


REQUIRED_COLUMNS = [
    "contractor_id",
    "route_date",
    "stop_id",
    "latitude",
    "longitude",
    "depot_latitude",
    "depot_longitude",
]

EXACT_TSP_LIMIT = 12
DEFAULT_OSRM_BASE_URL = "https://router.project-osrm.org"


# ---------------------------------------------------------------------------
# Widgets / settings
# ---------------------------------------------------------------------------

def get_spark(spark_session=None):
    """Return the notebook SparkSession, or create/find one when imported as a module."""
    if spark_session is not None:
        return spark_session

    existing = globals().get("spark")
    if existing is not None:
        return existing

    try:
        from pyspark.sql import SparkSession
    except Exception as exc:
        raise RuntimeError("No SparkSession is available. In Databricks, pass spark_session=spark.") from exc

    active = SparkSession.getActiveSession()
    if active is not None:
        return active

    try:
        return SparkSession.builder.getOrCreate()
    except Exception as exc:
        raise RuntimeError("No SparkSession is available. In Databricks, pass spark_session=spark.") from exc


def get_dbutils():
    """Return Databricks dbutils when running in a notebook or imported module."""
    utility = globals().get("dbutils")
    if utility is not None:
        return utility

    try:
        import builtins
        utility = getattr(builtins, "dbutils", None)
        if utility is not None:
            return utility
    except Exception:
        pass

    try:
        from pyspark.dbutils import DBUtils
        return DBUtils(get_spark())
    except Exception:
        return None


def widget(name, default):
    """Read a Databricks widget. Falls back cleanly when run outside Databricks."""
    utility = get_dbutils()
    if utility is None:
        return default

    try:
        utility.widgets.get(name)
    except Exception:
        try:
            utility.widgets.text(name, default)
        except Exception:
            return default

    try:
        return utility.widgets.get(name)
    except Exception:
        return default


def widget_list(name, default):
    return [item.strip() for item in widget(name, default).split(",") if item.strip()]


def filter_values(value):
    return [item.strip() for item in str(value or "").split(",") if item.strip()]


CONFIG = {
    "source_table": widget("source_table", "route_input"),
    "source_sql": widget("source_sql", ""),
    "build_route_input_in_python": widget("build_route_input_in_python", "false").lower() == "true",
    "route_source_table": widget(
        "route_source_table",
        "transport_dev.integ_transport_assets.asset_vision_route_source_union",
    ),
    "route_input_table": widget(
        "route_input_table",
        "transport_dev.integ_transport_assets.route_input",
    ),
    "persist_route_input": widget("persist_route_input", "false").lower() == "true",
    "group_columns": widget_list("group_columns", "contractor_id,route_date"),
    "contract_filter": widget("contract_filter", ""),
    "inspection_id_filter": widget("inspection_id_filter", ""),
    "job_id_filter": widget("job_id_filter", ""),
    "stop_id_filter": widget("stop_id_filter", ""),
    "exclude_inspection_id_filter": widget("exclude_inspection_id_filter", ""),
    "exclude_job_id_filter": widget("exclude_job_id_filter", ""),
    "exclude_stop_id_filter": widget("exclude_stop_id_filter", ""),
    "show_input_preview": widget("show_input_preview", "true").lower() == "true",
    "preview_limit": int(widget("preview_limit", "100")),
    "run_optimisation": widget("run_optimisation", "false").lower() == "true",
    "show_route_map": widget("show_route_map", "true").lower() == "true",
    "map_route_id": widget("map_route_id", ""),
    "map_max_routes": int(widget("map_max_routes", "5")),
    "map_tiles": widget("map_tiles", "CartoDB positron"),
    "map_line_colour": widget("map_line_colour", "#0057B8"),
    "map_marker_style": widget("map_marker_style", "numbered"),  # numbered | default
    "due_days": int(widget("due_days", "60")),
    "include_completed": widget("include_completed", "false").lower() == "true",
    "routing_mode": widget("routing_mode", "auto"),  # auto | osrm | offline
    "osrm_base_url": widget("osrm_base_url", DEFAULT_OSRM_BASE_URL),
    "allow_insecure_tls": widget("allow_insecure_tls", "false").lower() == "true",
    "max_stops_per_route": int(widget("max_stops_per_route", "40")),
    "output_route_table": widget(
        "output_route_table",
        "transport_dev.integ_transport_assets.route_optimised_stops",
    ),
    "output_geometry_table": widget(
        "output_geometry_table",
        "transport_dev.integ_transport_assets.route_optimised_geometry",
    ),
    "output_metrics_table": widget(
        "output_metrics_table",
        "transport_dev.integ_transport_assets.route_optimised_metrics",
    ),
    "write_mode": widget("write_mode", "overwrite"),
}


def refresh_config_from_widgets():
    """Refresh CONFIG after changing Databricks widgets without restarting Python."""
    CONFIG.update({
        "source_table": widget("source_table", CONFIG["source_table"]),
        "source_sql": widget("source_sql", CONFIG["source_sql"]),
        "build_route_input_in_python": widget(
            "build_route_input_in_python",
            str(CONFIG["build_route_input_in_python"]).lower(),
        ).lower() == "true",
        "route_source_table": widget("route_source_table", CONFIG["route_source_table"]),
        "route_input_table": widget("route_input_table", CONFIG["route_input_table"]),
        "persist_route_input": widget(
            "persist_route_input",
            str(CONFIG["persist_route_input"]).lower(),
        ).lower() == "true",
        "group_columns": widget_list("group_columns", ",".join(CONFIG["group_columns"])),
        "contract_filter": widget("contract_filter", CONFIG["contract_filter"]),
        "inspection_id_filter": widget("inspection_id_filter", CONFIG["inspection_id_filter"]),
        "job_id_filter": widget("job_id_filter", CONFIG["job_id_filter"]),
        "stop_id_filter": widget("stop_id_filter", CONFIG["stop_id_filter"]),
        "exclude_inspection_id_filter": widget(
            "exclude_inspection_id_filter",
            CONFIG["exclude_inspection_id_filter"],
        ),
        "exclude_job_id_filter": widget("exclude_job_id_filter", CONFIG["exclude_job_id_filter"]),
        "exclude_stop_id_filter": widget("exclude_stop_id_filter", CONFIG["exclude_stop_id_filter"]),
        "show_input_preview": widget("show_input_preview", str(CONFIG["show_input_preview"]).lower()).lower() == "true",
        "preview_limit": int(widget("preview_limit", str(CONFIG["preview_limit"]))),
        "run_optimisation": widget("run_optimisation", str(CONFIG["run_optimisation"]).lower()).lower() == "true",
        "show_route_map": widget("show_route_map", str(CONFIG["show_route_map"]).lower()).lower() == "true",
        "map_route_id": widget("map_route_id", CONFIG["map_route_id"]),
        "map_max_routes": int(widget("map_max_routes", str(CONFIG["map_max_routes"]))),
        "map_tiles": widget("map_tiles", CONFIG["map_tiles"]),
        "map_line_colour": widget("map_line_colour", CONFIG["map_line_colour"]),
        "map_marker_style": widget("map_marker_style", CONFIG["map_marker_style"]),
        "due_days": int(widget("due_days", str(CONFIG["due_days"]))),
        "include_completed": widget("include_completed", str(CONFIG["include_completed"]).lower()).lower() == "true",
        "routing_mode": widget("routing_mode", CONFIG["routing_mode"]),
        "osrm_base_url": widget("osrm_base_url", CONFIG["osrm_base_url"]),
        "allow_insecure_tls": widget(
            "allow_insecure_tls",
            str(CONFIG["allow_insecure_tls"]).lower(),
        ).lower() == "true",
        "max_stops_per_route": int(widget("max_stops_per_route", str(CONFIG["max_stops_per_route"]))),
        "output_route_table": widget("output_route_table", CONFIG["output_route_table"]),
        "output_geometry_table": widget("output_geometry_table", CONFIG["output_geometry_table"]),
        "output_metrics_table": widget("output_metrics_table", CONFIG["output_metrics_table"]),
        "write_mode": widget("write_mode", CONFIG["write_mode"]),
    })
    return CONFIG


# ---------------------------------------------------------------------------
# Small helpers
# ---------------------------------------------------------------------------

def as_json_value(value):
    if isinstance(value, (datetime, date)):
        return value.isoformat()
    return value


def due_sort_key(value):
    if value is None:
        return "9999-12-31T23:59:59"
    if isinstance(value, (datetime, date)):
        return value.isoformat()
    return str(value)


def safe_text(value):
    value = "" if value is None else str(value)
    cleaned = re.sub(r"[^A-Za-z0-9]+", "_", value).strip("_")
    return cleaned[:80] or "route"


def make_route_id(group_values, batch_number):
    payload = json.dumps({k: as_json_value(v) for k, v in group_values.items()}, sort_keys=True)
    digest = hashlib.md5(payload.encode("utf-8")).hexdigest()[:10]
    label = safe_text("_".join(str(as_json_value(v)) for v in group_values.values()))
    return f"{label}_r{batch_number:03d}_{digest}"


def haversine_km(lat1, lon1, lat2, lon2):
    radius_km = 6371.0088
    p1 = math.radians(lat1)
    p2 = math.radians(lat2)
    dlat = p2 - p1
    dlon = math.radians(lon2 - lon1)
    h = math.sin(dlat / 2) ** 2 + math.cos(p1) * math.cos(p2) * math.sin(dlon / 2) ** 2
    return 2 * radius_km * math.asin(math.sqrt(h))


# ---------------------------------------------------------------------------
# Travel-time matrix and road geometry
# ---------------------------------------------------------------------------

def offline_matrix(coords, average_speed_kmh=38.0):
    """Fallback matrix: straight-line distance converted to minutes."""
    matrix = []
    for origin_lat, origin_lon in coords:
        row = []
        for dest_lat, dest_lon in coords:
            if origin_lat == dest_lat and origin_lon == dest_lon:
                row.append(0.0)
            else:
                km = haversine_km(origin_lat, origin_lon, dest_lat, dest_lon)
                row.append((km / average_speed_kmh) * 60)
        matrix.append(row)
    return matrix


def fetch_json(url, allow_insecure_tls=False, timeout_seconds=60):
    context = None
    if allow_insecure_tls and url.lower().startswith("https://"):
        context = ssl._create_unverified_context()

    request = urllib.request.Request(url, headers={"User-Agent": "VentiaRouteOptimisation/0.1"})
    try:
        with urllib.request.urlopen(request, timeout=timeout_seconds, context=context) as response:
            return json.loads(response.read().decode("utf-8"))
    except (http.client.RemoteDisconnected, urllib.error.URLError, TimeoutError, json.JSONDecodeError) as exc:
        raise RuntimeError(str(exc))


def osrm_coord_string(coords):
    # OSRM expects lon,lat order.
    return ";".join(f"{lon:.6f},{lat:.6f}" for lat, lon in coords)


def osrm_matrix(coords):
    params = urllib.parse.urlencode({"annotations": "duration,distance", "fallback_speed": 35})
    url = f"{CONFIG['osrm_base_url'].rstrip('/')}/table/v1/driving/{osrm_coord_string(coords)}?{params}"
    data = fetch_json(url, CONFIG["allow_insecure_tls"])

    if data.get("code") != "Ok":
        raise RuntimeError(f"{data.get('code', 'Error')}: {data.get('message', 'OSRM table request failed')}")

    durations = data.get("durations")
    if not durations or len(durations) != len(coords):
        raise RuntimeError("OSRM table response did not include a complete duration matrix")

    backup = offline_matrix(coords)
    matrix = []
    for i, row in enumerate(durations):
        matrix.append([
            backup[i][j] if seconds is None else float(seconds) / 60
            for j, seconds in enumerate(row)
        ])
    return matrix


def osrm_geometry(coords, route):
    routed_coords = [coords[index] for index in route]
    params = urllib.parse.urlencode({
        "overview": "full",
        "geometries": "geojson",
        "steps": "false",
        "continue_straight": "false",
    })
    url = f"{CONFIG['osrm_base_url'].rstrip('/')}/route/v1/driving/{osrm_coord_string(routed_coords)}?{params}"
    data = fetch_json(url, CONFIG["allow_insecure_tls"])

    if data.get("code") != "Ok":
        raise RuntimeError(f"{data.get('code', 'Error')}: {data.get('message', 'OSRM route request failed')}")

    points = data.get("routes", [{}])[0].get("geometry", {}).get("coordinates", [])
    if not points:
        raise RuntimeError("OSRM route response did not include geometry")

    # Convert back to lat,lon order for internal use.
    return [(float(lat), float(lon)) for lon, lat in points]


def get_matrix(coords):
    mode = CONFIG["routing_mode"].lower()
    if mode in ("auto", "osrm"):
        try:
            return osrm_matrix(coords), f"OSRM table: {CONFIG['osrm_base_url'].rstrip('/')}"
        except RuntimeError as exc:
            if mode == "osrm":
                raise
            return offline_matrix(coords), f"Offline fallback because OSRM failed: {exc}"

    return offline_matrix(coords), "Offline haversine matrix"


def get_geometry(coords, route):
    mode = CONFIG["routing_mode"].lower()
    if mode in ("auto", "osrm"):
        try:
            return osrm_geometry(coords, route), f"OSRM route geometry: {CONFIG['osrm_base_url'].rstrip('/')}"
        except RuntimeError as exc:
            if mode == "osrm":
                raise
            return [coords[index] for index in route], f"Straight-line fallback because OSRM failed: {exc}"

    return [coords[index] for index in route], "Straight-line stop geometry"


# ---------------------------------------------------------------------------
# Route optimiser
# ---------------------------------------------------------------------------

def exact_tsp_route(matrix):
    """Exact TSP for small routes. Depot is fixed at index 0."""
    n = len(matrix)
    if n < 2:
        return [0]

    dp = {}
    for i in range(1, n):
        dp[(1 << (i - 1), i)] = (matrix[0][i], 0)

    for subset_size in range(2, n):
        next_dp = {}
        for mask in range(1, 1 << (n - 1)):
            if mask.bit_count() != subset_size:
                continue
            for last in range(1, n):
                if not mask & (1 << (last - 1)):
                    continue

                previous_mask = mask ^ (1 << (last - 1))
                best = (math.inf, -1)
                for previous in range(1, n):
                    if previous_mask & (1 << (previous - 1)):
                        candidate = dp[(previous_mask, previous)][0] + matrix[previous][last]
                        if candidate < best[0]:
                            best = (candidate, previous)
                next_dp[(mask, last)] = best
        dp.update(next_dp)

    full_mask = (1 << (n - 1)) - 1
    best_last = min(range(1, n), key=lambda last: dp[(full_mask, last)][0] + matrix[last][0])

    route_reversed = []
    mask = full_mask
    last = best_last
    while last != 0:
        route_reversed.append(last)
        _, previous = dp[(mask, last)]
        mask ^= 1 << (last - 1)
        last = previous

    return [0] + list(reversed(route_reversed)) + [0]


def nearest_neighbour_route(matrix):
    unvisited = set(range(1, len(matrix)))
    route = [0]
    current = 0

    while unvisited:
        next_stop = min(unvisited, key=lambda index: (matrix[current][index], index))
        route.append(next_stop)
        unvisited.remove(next_stop)
        current = next_stop

    route.append(0)
    return route


def two_opt(route, matrix):
    best = route[:]
    improved = True

    while improved:
        improved = False
        for i in range(1, len(best) - 2):
            for j in range(i + 1, len(best) - 1):
                old_cost = matrix[best[i - 1]][best[i]] + matrix[best[j]][best[j + 1]]
                new_cost = matrix[best[i - 1]][best[j]] + matrix[best[i]][best[j + 1]]
                if new_cost + 1e-9 < old_cost:
                    best[i:j + 1] = reversed(best[i:j + 1])
                    improved = True

    return best


def optimise_order(matrix):
    if len(matrix) <= EXACT_TSP_LIMIT:
        return exact_tsp_route(matrix), f"Exact Held-Karp TSP for <= {EXACT_TSP_LIMIT - 1} stops"

    route = nearest_neighbour_route(matrix)
    route = two_opt(route, matrix)
    return route, "Nearest-neighbour + 2-opt heuristic"


def route_travel_minutes(route, matrix):
    return sum(matrix[a][b] for a, b in zip(route, route[1:]))


# ---------------------------------------------------------------------------
# Source rows and batching
# ---------------------------------------------------------------------------

def build_route_input_from_source(spark_session=None, persist=None):
    """Build route_input from asset_vision_route_source_union using PySpark."""
    spark_session = get_spark(spark_session)
    try:
        from pyspark.sql import Window
        from pyspark.sql import functions as F
    except Exception as exc:
        raise RuntimeError("PySpark is required to build route_input in Python.") from exc

    source_df = spark_session.table(CONFIG["route_source_table"])

    contract_filter = CONFIG["contract_filter"].strip()
    if contract_filter:
        source_df = source_df.where(F.lower(F.col("contract").cast("string")).contains(contract_filter.lower()))

    inspection_id_filter = CONFIG["inspection_id_filter"].strip()
    if inspection_id_filter:
        source_df = source_df.where(F.col("inspection_id").cast("string") == inspection_id_filter)

    job_id_filter = CONFIG["job_id_filter"].strip() or CONFIG["stop_id_filter"].strip()
    if job_id_filter:
        source_df = source_df.where(F.col("job_id").cast("string") == job_id_filter)

    exclude_inspection_ids = filter_values(CONFIG["exclude_inspection_id_filter"])
    if exclude_inspection_ids:
        source_df = source_df.where(
            F.col("inspection_id").isNull()
            | (~F.col("inspection_id").cast("string").isin(exclude_inspection_ids))
        )

    exclude_job_ids = filter_values(CONFIG["exclude_job_id_filter"]) + filter_values(CONFIG["exclude_stop_id_filter"])
    if exclude_job_ids:
        source_df = source_df.where(F.col("job_id").isNull() | (~F.col("job_id").cast("string").isin(exclude_job_ids)))

    if not CONFIG["include_completed"]:
        source_df = source_df.where(
            F.col("completed_ts").isNull()
            | (~F.lower(F.coalesce(F.col("completed_status"), F.lit(""))).contains("complete"))
        )

    source_df = source_df.where(
        F.col("due_ts").isNotNull()
        & (F.to_date(F.col("due_ts")) >= F.current_date())
        & (F.to_date(F.col("due_ts")) <= F.date_add(F.current_date(), int(CONFIG["due_days"])))
    )

    route_candidates = source_df.select(
        F.col("contract").alias("contractor_id"),
        F.to_date(F.col("due_ts")).alias("route_date"),
        F.col("job_id").cast("string").alias("stop_id"),
        F.coalesce(
            F.col("activity_name"),
            F.col("intervention_name"),
            F.col("inspection_type_name"),
            F.col("asset_name"),
            F.concat(F.lit("Job "), F.col("job_id").cast("string")),
        ).alias("stop_name"),
        F.coalesce(F.col("asset_name"), F.col("section"), F.col("asset_code")).alias("road_name"),
        F.col("latitude"),
        F.col("longitude"),
        F.col("priority"),
        F.coalesce(F.col("estimated_duration_minutes"), F.lit(25.0)).cast("double").alias("service_minutes"),
        F.col("due_ts"),
        F.col("source_context"),
        F.col("source_catalog"),
        F.col("documented_contract_context"),
        F.col("contract"),
        F.col("job_id"),
        F.col("inspection_id"),
        F.col("completed_status"),
        F.col("assigned_user"),
        F.col("workflow_status"),
        F.col("wkt"),
    )

    depot_group_columns = [column for column in CONFIG["group_columns"] if column in route_candidates.columns]
    if not depot_group_columns:
        depot_group_columns = ["contractor_id", "route_date"]

    depot_window = Window.partitionBy(*depot_group_columns).orderBy("due_ts", "priority", "stop_id")
    site_depots = (
        route_candidates
        .withColumn("depot_rank", F.row_number().over(depot_window))
        .where(F.col("depot_rank") == 1)
        .select(
            *depot_group_columns,
            F.col("stop_id").alias("depot_stop_id"),
            F.col("stop_name").alias("depot_stop_name"),
            F.col("latitude").alias("depot_latitude"),
            F.col("longitude").alias("depot_longitude"),
        )
    )

    join_condition = None
    for column in depot_group_columns:
        condition = F.col(f"rc.{column}") == F.col(f"sd.{column}")
        join_condition = condition if join_condition is None else join_condition & condition

    route_input = (
        route_candidates.alias("rc")
        .join(
            site_depots.alias("sd"),
            join_condition,
            "inner",
        )
        .select(
            F.col("rc.contractor_id"),
            F.col("rc.route_date"),
            F.col("rc.stop_id"),
            F.col("rc.stop_name"),
            F.col("rc.road_name"),
            F.col("rc.latitude"),
            F.col("rc.longitude"),
            F.col("rc.priority"),
            F.col("rc.service_minutes"),
            F.col("rc.due_ts"),
            F.col("sd.depot_latitude"),
            F.col("sd.depot_longitude"),
            F.concat(F.lit("Site depot - "), F.col("sd.depot_stop_name")).alias("depot_name"),
            F.col("sd.depot_stop_id"),
            F.lit("earliest_due_site_in_route_group").alias("depot_source"),
            F.col("rc.source_context"),
            F.col("rc.source_catalog"),
            F.col("rc.documented_contract_context"),
            F.col("rc.contract"),
            F.col("rc.job_id"),
            F.col("rc.inspection_id"),
            F.col("rc.completed_status"),
            F.col("rc.assigned_user"),
            F.col("rc.workflow_status"),
            F.col("rc.wkt"),
        )
    )

    should_persist = CONFIG["persist_route_input"] if persist is None else persist
    if should_persist:
        route_input.write.format("delta").mode(CONFIG["write_mode"]).option(
            "overwriteSchema", "true"
        ).saveAsTable(CONFIG["route_input_table"])
        print(f"Wrote route input table: {CONFIG['route_input_table']}")

    return route_input


def read_source(spark_session=None):
    spark_session = get_spark(spark_session)
    if CONFIG["build_route_input_in_python"]:
        print(f"Building route input in Python from: {CONFIG['route_source_table']}")
        return build_route_input_from_source(spark_session)

    source_sql = CONFIG["source_sql"].strip()
    if source_sql:
        print("Loading route input from the source_sql widget.")
        return apply_input_filters(spark_session.sql(source_sql))

    print(f"Loading route input table/view: {CONFIG['source_table']}")
    return apply_input_filters(spark_session.table(CONFIG["source_table"]))


def validate_source(df):
    missing = []
    for column in REQUIRED_COLUMNS + CONFIG["group_columns"]:
        if column not in df.columns:
            missing.append(column)
    if missing:
        raise ValueError(f"Source data is missing required columns: {sorted(set(missing))}")


def apply_input_filters(df):
    """Apply lightweight interactive filters before rows are collected into Python."""
    try:
        from pyspark.sql import functions as F
    except Exception:
        return df

    contract_filter = CONFIG["contract_filter"].strip()
    if contract_filter:
        column = "contractor_id" if "contractor_id" in df.columns else "contract"
        if column not in df.columns:
            raise ValueError("contract_filter was set, but neither contractor_id nor contract exists in the source.")
        df = df.where(F.lower(F.col(column).cast("string")).contains(contract_filter.lower()))

    inspection_id_filter = CONFIG["inspection_id_filter"].strip()
    if inspection_id_filter:
        if "inspection_id" not in df.columns:
            raise ValueError("inspection_id_filter was set, but inspection_id does not exist in the source.")
        df = df.where(F.col("inspection_id").cast("string") == inspection_id_filter)

    job_id_filter = CONFIG["job_id_filter"].strip()
    if job_id_filter:
        column = "job_id" if "job_id" in df.columns else "stop_id"
        if column not in df.columns:
            raise ValueError("job_id_filter was set, but neither job_id nor stop_id exists in the source.")
        df = df.where(F.col(column).cast("string") == job_id_filter)

    stop_id_filter = CONFIG["stop_id_filter"].strip()
    if stop_id_filter:
        if "stop_id" not in df.columns:
            raise ValueError("stop_id_filter was set, but stop_id does not exist in the source.")
        df = df.where(F.col("stop_id").cast("string") == stop_id_filter)

    exclude_inspection_ids = filter_values(CONFIG["exclude_inspection_id_filter"])
    if exclude_inspection_ids:
        if "inspection_id" not in df.columns:
            raise ValueError(
                "exclude_inspection_id_filter was set, but inspection_id does not exist in the source."
            )
        df = df.where(
            F.col("inspection_id").isNull()
            | (~F.col("inspection_id").cast("string").isin(exclude_inspection_ids))
        )

    exclude_job_ids = filter_values(CONFIG["exclude_job_id_filter"])
    if exclude_job_ids:
        column = "job_id" if "job_id" in df.columns else "stop_id"
        if column not in df.columns:
            raise ValueError("exclude_job_id_filter was set, but neither job_id nor stop_id exists in the source.")
        df = df.where(F.col(column).isNull() | (~F.col(column).cast("string").isin(exclude_job_ids)))

    exclude_stop_ids = filter_values(CONFIG["exclude_stop_id_filter"])
    if exclude_stop_ids:
        if "stop_id" not in df.columns:
            raise ValueError("exclude_stop_id_filter was set, but stop_id does not exist in the source.")
        df = df.where(F.col("stop_id").isNull() | (~F.col("stop_id").cast("string").isin(exclude_stop_ids)))

    return df


def routeable_source(df):
    return df.dropna(subset=[
        "latitude",
        "longitude",
        "depot_latitude",
        "depot_longitude",
        "stop_id",
    ])


def show_dataframe(title, df, limit=None):
    limit = CONFIG["preview_limit"] if limit is None else limit
    print(title)
    preview_df = df.limit(limit)
    try:
        display(preview_df)  # noqa: F821
    except Exception:
        preview_df.show(limit, truncate=False)


def preview_input(df):
    if not CONFIG["show_input_preview"]:
        return

    if CONFIG["build_route_input_in_python"]:
        source_label = f"{CONFIG['route_source_table']} -> Python-built route_input"
    else:
        source_label = "source_sql widget" if CONFIG["source_sql"].strip() else CONFIG["source_table"]
    print(json.dumps({
        "source": source_label,
        "build_route_input_in_python": CONFIG["build_route_input_in_python"],
        "route_source_table": CONFIG["route_source_table"],
        "persist_route_input": CONFIG["persist_route_input"],
        "route_input_table": CONFIG["route_input_table"],
        "group_columns": CONFIG["group_columns"],
        "contract_filter": CONFIG["contract_filter"],
        "inspection_id_filter": CONFIG["inspection_id_filter"],
        "job_id_filter": CONFIG["job_id_filter"],
        "stop_id_filter": CONFIG["stop_id_filter"],
        "exclude_inspection_id_filter": CONFIG["exclude_inspection_id_filter"],
        "exclude_job_id_filter": CONFIG["exclude_job_id_filter"],
        "exclude_stop_id_filter": CONFIG["exclude_stop_id_filter"],
        "routing_mode": CONFIG["routing_mode"],
        "due_days": CONFIG["due_days"],
        "include_completed": CONFIG["include_completed"],
        "max_stops_per_route": CONFIG["max_stops_per_route"],
        "run_optimisation": CONFIG["run_optimisation"],
    }, indent=2))

    show_dataframe("Input rows used by the optimiser", df)

    grouped = routeable_source(df).groupBy(*CONFIG["group_columns"]).count()
    if CONFIG["group_columns"]:
        grouped = grouped.orderBy(*CONFIG["group_columns"])
    show_dataframe("Routeable row count by route group", grouped)

    try:
        from pyspark.sql import functions as F
    except Exception:
        return

    null_checks = []
    for column in REQUIRED_COLUMNS:
        null_checks.append(F.sum(F.when(F.col(column).isNull(), 1).otherwise(0)).alias(f"{column}_nulls"))
    show_dataframe("Required column null checks", df.select(*null_checks), limit=1)


def row_to_stop(row):
    data = row.asDict(recursive=True)
    return {
        "stop_id": str(data["stop_id"]),
        "stop_name": str(data.get("stop_name") or data["stop_id"]),
        "road_name": str(data.get("road_name") or ""),
        "lat": float(data["latitude"]),
        "lon": float(data["longitude"]),
        "priority": int(data.get("priority") or 3),
        "service_minutes": float(data.get("service_minutes") or 20),
        "due_ts": data.get("due_ts"),
    }


def row_to_depot(row):
    data = row.asDict(recursive=True)
    return {
        "name": str(data.get("depot_name") or "Depot"),
        "lat": float(data["depot_latitude"]),
        "lon": float(data["depot_longitude"]),
    }


def split_batches(depot, stops):
    """Keep route chunks small enough for routing APIs and the heuristic."""
    max_size = CONFIG["max_stops_per_route"]
    if max_size <= 0 or len(stops) <= max_size:
        return [stops]

    remaining = stops[:]
    batches = []

    while remaining:
        batch = []
        current_lat = depot["lat"]
        current_lon = depot["lon"]

        while remaining and len(batch) < max_size:
            chosen = min(
                remaining,
                key=lambda stop: (
                    haversine_km(current_lat, current_lon, stop["lat"], stop["lon"]),
                    due_sort_key(stop["due_ts"]),
                    stop["priority"],
                    stop["stop_id"],
                ),
            )
            batch.append(chosen)
            remaining.remove(chosen)
            current_lat = chosen["lat"]
            current_lon = chosen["lon"]

        batches.append(batch)

    return batches


# ---------------------------------------------------------------------------
# Output builders
# ---------------------------------------------------------------------------

def geometry_geojson(points):
    return json.dumps({"type": "LineString", "coordinates": [[lon, lat] for lat, lon in points]})


def geometry_wkt(points):
    return "LINESTRING(" + ", ".join(f"{lon:.6f} {lat:.6f}" for lat, lon in points) + ")"


def build_route_outputs(group_values, depot, stops, batch_number):
    route_id = make_route_id(group_values, batch_number)

    coords = [(depot["lat"], depot["lon"])]
    for stop in stops:
        coords.append((stop["lat"], stop["lon"]))

    matrix, matrix_source = get_matrix(coords)
    route, method = optimise_order(matrix)
    geometry, geometry_source = get_geometry(coords, route)

    output_group = {key: as_json_value(value) for key, value in group_values.items()}

    stop_rows = []
    cumulative_travel = 0.0
    cumulative_total = 0.0

    for sequence, route_index in enumerate(route):
        previous_index = route[sequence - 1] if sequence > 0 else route_index
        travel_from_previous = 0.0 if sequence == 0 else matrix[previous_index][route_index]
        cumulative_travel += travel_from_previous

        if route_index == 0:
            stop_id = "_DEPOT_END" if sequence > 0 else "_DEPOT_START"
            stop_name = depot["name"]
            road_name = ""
            lat = depot["lat"]
            lon = depot["lon"]
            priority = 0
            service_minutes = 0.0
            is_depot = True
        else:
            stop = stops[route_index - 1]
            stop_id = stop["stop_id"]
            stop_name = stop["stop_name"]
            road_name = stop["road_name"]
            lat = stop["lat"]
            lon = stop["lon"]
            priority = stop["priority"]
            service_minutes = stop["service_minutes"]
            is_depot = False

        cumulative_total += travel_from_previous + service_minutes
        stop_rows.append({
            **output_group,
            "route_id": route_id,
            "route_batch": batch_number,
            "sequence": sequence,
            "stop_id": stop_id,
            "stop_name": stop_name,
            "road_name": road_name,
            "latitude": lat,
            "longitude": lon,
            "priority": priority,
            "service_minutes": service_minutes,
            "travel_from_previous_minutes": round(travel_from_previous, 2),
            "cumulative_travel_minutes": round(cumulative_travel, 2),
            "cumulative_total_minutes": round(cumulative_total, 2),
            "is_depot": is_depot,
        })

    travel_minutes = route_travel_minutes(route, matrix)
    service_minutes = sum(stop["service_minutes"] for stop in stops)

    metrics_row = {
        **output_group,
        "route_id": route_id,
        "route_batch": batch_number,
        "stop_count": len(stops),
        "travel_minutes": round(travel_minutes, 2),
        "service_minutes": round(service_minutes, 2),
        "total_minutes": round(travel_minutes + service_minutes, 2),
        "optimisation_method": method,
        "matrix_source": matrix_source,
        "geometry_source": geometry_source,
        "routing_mode": CONFIG["routing_mode"],
    }

    geometry_row = {
        **output_group,
        "route_id": route_id,
        "route_batch": batch_number,
        "geometry_point_count": len(geometry),
        "geometry_geojson": geometry_geojson(geometry),
        "geometry_wkt": geometry_wkt(geometry),
        "geometry_source": geometry_source,
    }

    return stop_rows, geometry_row, metrics_row


# ---------------------------------------------------------------------------
# Main run
# ---------------------------------------------------------------------------

def optimise_all_routes(df=None, spark_session=None):
    if df is None:
        df = read_source(spark_session)
    validate_source(df)

    df = routeable_source(df)

    rows = df.collect()
    grouped_rows = {}
    group_values_by_key = {}

    for row in rows:
        data = row.asDict(recursive=True)
        group_values = {column: data.get(column) for column in CONFIG["group_columns"]}
        key = json.dumps({k: as_json_value(v) for k, v in group_values.items()}, sort_keys=True)
        grouped_rows.setdefault(key, []).append(row)
        group_values_by_key[key] = group_values

    all_stop_rows = []
    all_geometry_rows = []
    all_metric_rows = []

    for key, group_rows in grouped_rows.items():
        group_values = group_values_by_key[key]
        depot = row_to_depot(group_rows[0])

        stops = [row_to_stop(row) for row in group_rows]
        stops = sorted(stops, key=lambda stop: (due_sort_key(stop["due_ts"]), stop["priority"], stop["stop_id"]))

        for batch_number, batch in enumerate(split_batches(depot, stops), start=1):
            stop_rows, geometry_row, metrics_row = build_route_outputs(
                group_values,
                depot,
                batch,
                batch_number,
            )
            all_stop_rows.extend(stop_rows)
            all_geometry_rows.append(geometry_row)
            all_metric_rows.append(metrics_row)

    return all_stop_rows, all_geometry_rows, all_metric_rows


def write_outputs(stop_rows, geometry_rows, metric_rows, spark_session=None):
    if not stop_rows:
        raise ValueError("No route rows were produced. Check route_input filters and coordinate columns.")

    spark_session = get_spark(spark_session)

    spark_session.createDataFrame(stop_rows).write.format("delta").mode(CONFIG["write_mode"]).option(
        "overwriteSchema", "true"
    ).saveAsTable(CONFIG["output_route_table"])

    spark_session.createDataFrame(geometry_rows).write.format("delta").mode(CONFIG["write_mode"]).option(
        "overwriteSchema", "true"
    ).saveAsTable(CONFIG["output_geometry_table"])

    spark_session.createDataFrame(metric_rows).write.format("delta").mode(CONFIG["write_mode"]).option(
        "overwriteSchema", "true"
    ).saveAsTable(CONFIG["output_metrics_table"])


def row_to_dict(row):
    if hasattr(row, "asDict"):
        return row.asDict(recursive=True)
    return dict(row)


def read_output_rows(route_id=None, spark_session=None, max_routes=None):
    spark_session = get_spark(spark_session)
    route_df = spark_session.table(CONFIG["output_route_table"])
    geometry_df = spark_session.table(CONFIG["output_geometry_table"])

    if route_id:
        from pyspark.sql import functions as F
        route_df = route_df.where(F.col("route_id") == route_id)
        geometry_df = geometry_df.where(F.col("route_id") == route_id)

    stop_rows = [
        row.asDict(recursive=True)
        for row in route_df.orderBy("route_id", "route_batch", "sequence").collect()
    ]
    geometry_rows = [row.asDict(recursive=True) for row in geometry_df.collect()]

    if not route_id and max_routes:
        selected_route_ids = []
        for row in stop_rows:
            current_route_id = row.get("route_id")
            if current_route_id not in selected_route_ids:
                selected_route_ids.append(current_route_id)
            if len(selected_route_ids) >= max_routes:
                break

        stop_rows = [row for row in stop_rows if row.get("route_id") in selected_route_ids]
        geometry_rows = [row for row in geometry_rows if row.get("route_id") in selected_route_ids]

    return stop_rows, geometry_rows


def popup_value(row, key, default=""):
    value = row.get(key, default)
    return html_lib.escape("" if value is None else str(value))


def geometry_points(row):
    try:
        geometry = json.loads(row.get("geometry_geojson") or "{}")
    except json.JSONDecodeError:
        return []

    if geometry.get("type") != "LineString":
        return []

    points = []
    for lon, lat in geometry.get("coordinates", []):
        points.append((float(lat), float(lon)))
    return points


def numbered_marker_icon(sequence, is_depot=False):
    label = "S/E" if is_depot else str(sequence)
    background = "#027A48" if is_depot else "#0057B8"
    border = "#FFFFFF"
    width = 34 if is_depot else 28
    anchor_x = 17 if is_depot else 14
    html = f"""
    <div style="
      background:{background};
      color:#FFFFFF;
      border:2px solid {border};
      border-radius:999px;
      width:{width}px;
      height:28px;
      line-height:24px;
      text-align:center;
      font-size:11px;
      font-weight:700;
      box-shadow:0 1px 4px rgba(0,0,0,0.45);
    ">{html_lib.escape(label)}</div>
    """
    return {"html": html, "icon_size": (width, 28), "icon_anchor": (anchor_x, 14)}


def add_map_tiles(route_map):
    """Add a bright map tile layer by default, with a widget override."""
    import folium

    tile_name = (CONFIG["map_tiles"] or "").strip()
    tile_key = tile_name.lower().replace(" ", "").replace("_", "")

    if tile_key in ("", "light", "positron", "cartodbpositron", "cartodblight"):
        folium.TileLayer(
            tiles="https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png",
            attr="&copy; OpenStreetMap contributors &copy; CARTO",
            name="Light map",
            control=False,
        ).add_to(route_map)
        return

    folium.TileLayer(
        tiles=tile_name,
        name=tile_name,
        control=False,
    ).add_to(route_map)


def build_route_map(stop_rows=None, geometry_rows=None, route_id=None, max_routes=None, spark_session=None):
    """Build a Folium map for Databricks/IPython display."""
    try:
        import folium
    except ImportError as exc:
        raise ImportError("Install Folium in Databricks with `%pip install folium`, then rerun the notebook.") from exc

    max_routes = CONFIG["map_max_routes"] if max_routes is None else max_routes

    if stop_rows is None or geometry_rows is None:
        stop_rows, geometry_rows = read_output_rows(route_id, spark_session, max_routes)
    else:
        stop_rows = [row_to_dict(row) for row in stop_rows]
        geometry_rows = [row_to_dict(row) for row in geometry_rows]

    if route_id:
        stop_rows = [row for row in stop_rows if row.get("route_id") == route_id]
        geometry_rows = [row for row in geometry_rows if row.get("route_id") == route_id]

    if not stop_rows:
        raise ValueError("No stop rows available for the route map.")

    selected_route_ids = []
    for row in stop_rows:
        current_route_id = row.get("route_id")
        if current_route_id not in selected_route_ids:
            selected_route_ids.append(current_route_id)
        if not route_id and len(selected_route_ids) >= max_routes:
            break

    stop_rows = [row for row in stop_rows if row.get("route_id") in selected_route_ids]
    geometry_rows = [row for row in geometry_rows if row.get("route_id") in selected_route_ids]

    all_points = []
    for row in stop_rows:
        if row.get("latitude") is not None and row.get("longitude") is not None:
            all_points.append((float(row["latitude"]), float(row["longitude"])))

    if not all_points:
        raise ValueError("No coordinates available for the route map.")

    centre = (
        sum(point[0] for point in all_points) / len(all_points),
        sum(point[1] for point in all_points) / len(all_points),
    )
    route_map = folium.Map(
        location=centre,
        zoom_start=12,
        tiles=None,
        control_scale=True,
        height="650px",
    )
    add_map_tiles(route_map)

    palette = [
        CONFIG["map_line_colour"],
        "#D92D20",
        "#027A48",
        "#C2410C",
        "#0E7490",
        "#4B5563",
    ]
    geometry_by_route_id = {row.get("route_id"): geometry_points(row) for row in geometry_rows}

    for route_index, selected_route_id in enumerate(selected_route_ids):
        colour = palette[route_index % len(palette)]
        route_stops = sorted(
            [row for row in stop_rows if row.get("route_id") == selected_route_id],
            key=lambda row: (row.get("route_batch") or 0, row.get("sequence") or 0),
        )

        line_points = geometry_by_route_id.get(selected_route_id) or [
            (float(row["latitude"]), float(row["longitude"]))
            for row in route_stops
            if row.get("latitude") is not None and row.get("longitude") is not None
        ]

        if len(line_points) >= 2:
            folium.PolyLine(
                line_points,
                color="#FFFFFF",
                weight=9,
                opacity=0.95,
                tooltip=str(selected_route_id),
            ).add_to(route_map)
            folium.PolyLine(
                line_points,
                color=colour,
                weight=5,
                opacity=0.95,
                tooltip=str(selected_route_id),
            ).add_to(route_map)

        for row in route_stops:
            if row.get("latitude") is None or row.get("longitude") is None:
                continue

            sequence = popup_value(row, "sequence")
            stop_id = popup_value(row, "stop_id")
            stop_name = popup_value(row, "stop_name")
            road_name = popup_value(row, "road_name")
            travel = popup_value(row, "travel_from_previous_minutes")
            cumulative = popup_value(row, "cumulative_total_minutes")
            popup_html = (
                f"<b>{sequence}. {stop_name}</b><br>"
                f"Stop ID: {stop_id}<br>"
                f"Road: {road_name}<br>"
                f"Travel from previous: {travel} min<br>"
                f"Cumulative time: {cumulative} min"
            )

            is_depot = bool(row.get("is_depot"))
            marker_location = (float(row["latitude"]), float(row["longitude"]))
            if CONFIG["map_marker_style"].lower() == "numbered":
                icon_settings = numbered_marker_icon(sequence, is_depot)
                icon = folium.DivIcon(**icon_settings)
            else:
                icon = folium.Icon(color="green" if is_depot else "blue", icon="home" if is_depot else "info-sign")

            folium.Marker(
                location=marker_location,
                popup=folium.Popup(popup_html, max_width=340),
                tooltip=f"{sequence}. {stop_name}",
                icon=icon,
            ).add_to(route_map)

    folium.LayerControl().add_to(route_map)
    return route_map


def get_display_html():
    display_html = globals().get("displayHTML")
    if display_html is not None:
        return display_html

    try:
        import builtins
        return getattr(builtins, "displayHTML", None)
    except Exception:
        return None


def display_route_map(stop_rows=None, geometry_rows=None, route_id=None, max_routes=None, spark_session=None):
    route_map = build_route_map(stop_rows, geometry_rows, route_id, max_routes, spark_session)
    rendered = route_map._repr_html_()

    display_html = get_display_html()
    if display_html is not None:
        display_html(rendered)
        return route_map

    try:
        from IPython.display import HTML, display as ipython_display
        ipython_display(HTML(rendered))
    except Exception:
        print(rendered)

    return route_map


def main(spark_session=None):
    df = read_source(spark_session)
    validate_source(df)
    preview_input(df)

    if not CONFIG["run_optimisation"]:
        print("Preview only. Set the Databricks widget run_optimisation to true to optimise and write outputs.")
        return

    stop_rows, geometry_rows, metric_rows = optimise_all_routes(df, spark_session)
    write_outputs(stop_rows, geometry_rows, metric_rows, spark_session)

    if CONFIG["show_route_map"]:
        display_route_map(
            stop_rows,
            geometry_rows,
            route_id=CONFIG["map_route_id"] or None,
            max_routes=CONFIG["map_max_routes"],
            spark_session=spark_session,
        )

    print(json.dumps({
        "route_stop_rows": len(stop_rows),
        "route_geometry_rows": len(geometry_rows),
        "route_metric_rows": len(metric_rows),
        "output_route_table": CONFIG["output_route_table"],
        "output_geometry_table": CONFIG["output_geometry_table"],
        "output_metrics_table": CONFIG["output_metrics_table"],
    }, indent=2))


if __name__ == "__main__":
    main()
