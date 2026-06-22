"""Prototype inspector route optimisation for Transport road inspections.

This demo uses a small RAMC/RAMCSC-style sample dataset because the repo currently
documents table schemas, not live Databricks rows. The optimisation is exact
for the included sample size under the demo travel-time model:

- start and finish at one depot
- visit every inspection task once
- minimise travel time weighted by a simple traffic-volume penalty

For production, replace `build_travel_matrix` with OSRM, GraphHopper, Google
Routes, or another approved routing API, then keep the optimisation/output
shape mostly the same.
"""

from __future__ import annotations

import argparse
import csv
import html
import json
import math
import http.client
import ssl
import urllib.error
import urllib.parse
import urllib.request
from dataclasses import asdict, dataclass
from datetime import datetime, timedelta
from pathlib import Path
from typing import Any, Iterable


ROOT = Path(__file__).resolve().parent
OUTPUT_DIR = ROOT / "outputs"
OSRM_BASE_URL = "https://router.project-osrm.org"
EXACT_TSP_LIMIT = 12


@dataclass(frozen=True)
class Stop:
    id: str
    name: str
    road: str
    lat: float
    lon: float
    inspection_type: str
    priority: int
    traffic_volume: int
    estimated_duration_min: int
    due_date: str


@dataclass(frozen=True)
class RouteLeg:
    sequence: int
    stop_id: str
    stop_name: str
    road: str
    arrival_time: str
    inspection_start: str
    inspection_end: str
    travel_from_previous_min: float
    inspection_duration_min: int
    cumulative_min: float
    priority: int
    traffic_volume: int
    latitude: float
    longitude: float


DEPOT = Stop(
    id="DEPOT",
    name="RAMC/RAMCSC depot / start",
    road="Depot",
    lat=-27.4292,
    lon=153.0836,
    inspection_type="Start/end",
    priority=0,
    traffic_volume=0,
    estimated_duration_min=0,
    due_date="2026-06-16",
)


SAMPLE_STOPS = [
    Stop("I-001", "Gateway Mwy drainage run", "Gateway Mwy", -27.3922, 153.1084, "Drainage / pit", 2, 55000, 28, "2026-06-16"),
    Stop("I-002", "Port of Brisbane Rd signage check", "Port of Brisbane Rd", -27.3848, 153.1658, "Hazard day", 1, 47000, 18, "2026-06-16"),
    Stop("I-003", "Ipswich Rd guardrail", "Ipswich Rd", -27.5302, 153.0105, "Defect", 2, 42000, 22, "2026-06-17"),
    Stop("I-004", "Pacific Mwy pavement review", "Pacific Mwy", -27.5357, 153.1018, "Pavement", 3, 76000, 35, "2026-06-18"),
    Stop("I-005", "Logan Rd night hazard", "Logan Rd", -27.5687, 153.0810, "Hazard night", 1, 51000, 20, "2026-06-16"),
    Stop("I-006", "Mt Lindesay Hwy line marking", "Mt Lindesay Hwy", -27.6329, 153.0284, "Line marking", 2, 36000, 24, "2026-06-17"),
    Stop("I-007", "Cleveland Redland Bay Rd pits", "Cleveland Redland Bay Rd", -27.5415, 153.2508, "Drainage / pit", 2, 33500, 30, "2026-06-17"),
    Stop("I-008", "Old Cleveland Rd barrier", "Old Cleveland Rd", -27.5019, 153.1622, "Vehicle barrier", 2, 44000, 26, "2026-06-16"),
    Stop("I-009", "Gympie Rd debris patrol", "Gympie Rd", -27.3607, 153.0339, "Defect", 3, 60000, 16, "2026-06-18"),
    Stop("I-010", "Bruce Hwy signs", "Bruce Hwy", -27.2525, 153.0504, "Signs", 2, 72000, 24, "2026-06-17"),
    Stop("I-011", "Beaudesert Rd culvert", "Beaudesert Rd", -27.5890, 153.0250, "Culvert", 2, 48500, 24, "2026-06-17"),
    Stop("I-012", "Moggill Rd shoulder scouring", "Moggill Rd", -27.5004, 152.9399, "Shoulder", 3, 31000, 22, "2026-06-18"),
    Stop("I-013", "Centenary Hwy barrier end terminal", "Centenary Hwy", -27.5538, 152.9289, "Vehicle barrier", 2, 64000, 26, "2026-06-17"),
    Stop("I-014", "Sandgate Rd inlet check", "Sandgate Rd", -27.3340, 153.0618, "Drainage / pit", 2, 52000, 24, "2026-06-16"),
    Stop("I-015", "Wynnum Rd guardrail inspection", "Wynnum Rd", -27.4687, 153.1452, "Guardrail", 1, 45500, 20, "2026-06-16"),
    Stop("I-016", "Samford Rd line marking", "Samford Rd", -27.4176, 152.9870, "Line marking", 3, 39000, 18, "2026-06-18"),
    Stop("I-017", "Lutwyche Rd signal asset check", "Lutwyche Rd", -27.4189, 153.0326, "Signal / sign", 2, 58500, 18, "2026-06-16"),
    Stop("I-018", "Anzac Ave hazard patrol", "Anzac Ave", -27.2298, 153.0376, "Hazard day", 2, 61000, 20, "2026-06-17"),
    Stop("I-019", "Logan Motorway sign face", "Logan Motorway", -27.6686, 153.0832, "Signs", 3, 70000, 24, "2026-06-18"),
    Stop("I-020", "Redland Bay Rd pavement edge", "Redland Bay Rd", -27.6130, 153.3010, "Pavement", 2, 36500, 32, "2026-06-17"),
]


def haversine_km(a: Stop, b: Stop) -> float:
    radius_km = 6371.0088
    lat1 = math.radians(a.lat)
    lat2 = math.radians(b.lat)
    dlat = lat2 - lat1
    dlon = math.radians(b.lon - a.lon)
    h = math.sin(dlat / 2) ** 2 + math.cos(lat1) * math.cos(lat2) * math.sin(dlon / 2) ** 2
    return 2 * radius_km * math.asin(math.sqrt(h))


def traffic_penalty(volume_a: int, volume_b: int, max_volume: int) -> float:
    if max_volume <= 0:
        return 1.0
    avg = (volume_a + volume_b) / 2
    return 1.0 + 0.35 * (avg / max_volume)


def build_travel_matrix(stops: list[Stop], average_speed_kmh: float = 38.0) -> list[list[float]]:
    """Return a minutes matrix using distance and traffic-volume weighting."""
    max_volume = max(stop.traffic_volume for stop in stops)
    matrix: list[list[float]] = []
    for origin in stops:
        row = []
        for destination in stops:
            if origin.id == destination.id:
                row.append(0.0)
                continue
            distance_km = haversine_km(origin, destination)
            base_minutes = (distance_km / average_speed_kmh) * 60
            row.append(base_minutes * traffic_penalty(origin.traffic_volume, destination.traffic_volume, max_volume))
        matrix.append(row)
    return matrix


def fetch_json(url: str, timeout_seconds: int = 30, allow_insecure_tls: bool = False) -> dict[str, Any]:
    request = urllib.request.Request(
        url,
        headers={"User-Agent": "VentiaSecondBrainRouteDemo/0.1"},
    )
    context = None
    if allow_insecure_tls and url.lower().startswith("https://"):
        context = ssl._create_unverified_context()
    try:
        with urllib.request.urlopen(request, timeout=timeout_seconds, context=context) as response:
            return json.loads(response.read().decode("utf-8"))
    except (http.client.RemoteDisconnected, urllib.error.URLError, TimeoutError, json.JSONDecodeError) as exc:
        raise RuntimeError(str(exc)) from exc


def osrm_coordinate_string(stops: list[Stop], route: Iterable[int] | None = None) -> str:
    indices = range(len(stops)) if route is None else route
    return ";".join(f"{stops[index].lon:.6f},{stops[index].lat:.6f}" for index in indices)


def build_osrm_travel_matrix(stops: list[Stop], base_url: str, allow_insecure_tls: bool = False) -> list[list[float]]:
    query = urllib.parse.urlencode(
        {
            "annotations": "duration,distance",
            "fallback_speed": 35,
        }
    )
    url = f"{base_url.rstrip('/')}/table/v1/driving/{osrm_coordinate_string(stops)}?{query}"
    data = fetch_json(url, allow_insecure_tls=allow_insecure_tls)
    if data.get("code") != "Ok":
        raise RuntimeError(f"{data.get('code', 'Error')}: {data.get('message', 'OSRM table request failed')}")

    durations = data.get("durations")
    if not isinstance(durations, list) or len(durations) != len(stops):
        raise RuntimeError("OSRM table response did not include a complete duration matrix")

    fallback_matrix = build_travel_matrix(stops)
    matrix: list[list[float]] = []
    for i, row in enumerate(durations):
        if not isinstance(row, list) or len(row) != len(stops):
            raise RuntimeError("OSRM table response had an unexpected row shape")
        matrix.append(
            [
                fallback_matrix[i][j] if seconds is None else float(seconds) / 60
                for j, seconds in enumerate(row)
            ]
        )
    return matrix


def route_stop_coordinates(stops: list[Stop], route: Iterable[int]) -> list[list[float]]:
    return [[stops[index].lat, stops[index].lon] for index in route]


def fetch_osrm_route_geometry(
    stops: list[Stop],
    route: list[int],
    base_url: str,
    allow_insecure_tls: bool = False,
) -> list[list[float]]:
    query = urllib.parse.urlencode(
        {
            "overview": "full",
            "geometries": "geojson",
            "steps": "false",
            "continue_straight": "false",
        }
    )
    url = f"{base_url.rstrip('/')}/route/v1/driving/{osrm_coordinate_string(stops, route)}?{query}"
    data = fetch_json(url, allow_insecure_tls=allow_insecure_tls)
    if data.get("code") != "Ok":
        raise RuntimeError(f"{data.get('code', 'Error')}: {data.get('message', 'OSRM route request failed')}")

    routes = data.get("routes")
    if not routes:
        raise RuntimeError("OSRM route response did not include a route")

    coordinates = routes[0].get("geometry", {}).get("coordinates", [])
    if not coordinates:
        raise RuntimeError("OSRM route response did not include geometry")
    return [[float(lat), float(lon)] for lon, lat in coordinates]


def resolve_travel_matrix(
    stops: list[Stop],
    routing_mode: str,
    base_url: str,
    allow_insecure_tls: bool = False,
) -> tuple[list[list[float]], str]:
    if routing_mode in {"auto", "osrm"}:
        try:
            matrix = build_osrm_travel_matrix(stops, base_url, allow_insecure_tls)
            return matrix, f"OSRM road-network duration matrix ({base_url.rstrip('/')})"
        except RuntimeError as exc:
            if routing_mode == "osrm":
                raise RuntimeError(f"OSRM matrix failed: {exc}") from exc
            return build_travel_matrix(stops), f"Offline haversine fallback; OSRM unavailable ({exc})"
    return build_travel_matrix(stops), "Offline traffic-weighted haversine matrix"


def resolve_route_geometry(
    stops: list[Stop],
    route: list[int],
    routing_mode: str,
    base_url: str,
    route_name: str,
    allow_insecure_tls: bool = False,
) -> tuple[list[list[float]], str]:
    if routing_mode in {"auto", "osrm"}:
        try:
            geometry = fetch_osrm_route_geometry(stops, route, base_url, allow_insecure_tls)
            return geometry, f"OSRM full road geometry for {route_name}"
        except RuntimeError as exc:
            if routing_mode == "osrm":
                raise RuntimeError(f"OSRM geometry failed for {route_name}: {exc}") from exc
            return route_stop_coordinates(stops, route), f"Straight-line fallback for {route_name}; OSRM unavailable ({exc})"
    return route_stop_coordinates(stops, route), f"Straight-line stop geometry for {route_name}"


def exact_tsp_route(matrix: list[list[float]]) -> list[int]:
    """Held-Karp TSP for one inspector, fixed depot at index 0.

    Returns stop indices including depot at the start and end.
    """
    n = len(matrix)
    if n < 2:
        return [0]

    # State: (visited_mask_without_depot, last_index) -> (cost, previous_index)
    dp: dict[tuple[int, int], tuple[float, int]] = {}
    for i in range(1, n):
        dp[(1 << (i - 1), i)] = (matrix[0][i], 0)

    for subset_size in range(2, n):
        next_dp: dict[tuple[int, int], tuple[float, int]] = {}
        for mask in range(1, 1 << (n - 1)):
            if mask.bit_count() != subset_size:
                continue
            for last in range(1, n):
                if not mask & (1 << (last - 1)):
                    continue
                previous_mask = mask ^ (1 << (last - 1))
                best = (math.inf, -1)
                for previous in range(1, n):
                    if not previous_mask & (1 << (previous - 1)):
                        continue
                    previous_cost = dp[(previous_mask, previous)][0]
                    candidate = previous_cost + matrix[previous][last]
                    if candidate < best[0]:
                        best = (candidate, previous)
                next_dp[(mask, last)] = best
        dp.update(next_dp)

    full_mask = (1 << (n - 1)) - 1
    best_last = -1
    best_cost = math.inf
    for last in range(1, n):
        cost = dp[(full_mask, last)][0] + matrix[last][0]
        if cost < best_cost:
            best_cost = cost
            best_last = last

    route_reversed = []
    mask = full_mask
    last = best_last
    while last != 0:
        route_reversed.append(last)
        _, previous = dp[(mask, last)]
        mask ^= 1 << (last - 1)
        last = previous
    route = [0, *reversed(route_reversed), 0]
    return route


def nearest_neighbour_route(matrix: list[list[float]]) -> list[int]:
    n = len(matrix)
    if n < 2:
        return [0]

    unvisited = set(range(1, n))
    route = [0]
    current = 0
    while unvisited:
        next_stop = min(unvisited, key=lambda index: (matrix[current][index], index))
        route.append(next_stop)
        unvisited.remove(next_stop)
        current = next_stop
    route.append(0)
    return route


def two_opt_route(route: list[int], matrix: list[list[float]]) -> list[int]:
    best = route[:]
    improved = True
    while improved:
        improved = False
        for i in range(1, len(best) - 2):
            for j in range(i + 1, len(best) - 1):
                old_cost = matrix[best[i - 1]][best[i]] + matrix[best[j]][best[j + 1]]
                new_cost = matrix[best[i - 1]][best[j]] + matrix[best[i]][best[j + 1]]
                if new_cost + 1e-9 < old_cost:
                    best[i : j + 1] = reversed(best[i : j + 1])
                    improved = True
    return best


def optimise_route(matrix: list[list[float]]) -> tuple[list[int], str]:
    if len(matrix) <= EXACT_TSP_LIMIT:
        return exact_tsp_route(matrix), f"Exact Held-Karp TSP, used because stop count <= {EXACT_TSP_LIMIT - 1}"

    seeded = nearest_neighbour_route(matrix)
    improved = two_opt_route(seeded, matrix)
    return improved, "Nearest-neighbour seed improved with 2-opt, used for larger stop lists"


def baseline_route(stops: list[Stop]) -> list[int]:
    """Naive current-planning proxy: priority, due date, then road name."""
    ordered = sorted(
        range(1, len(stops)),
        key=lambda i: (stops[i].priority, stops[i].due_date, stops[i].road, stops[i].name),
    )
    return [0, *ordered, 0]


def route_travel_minutes(route: Iterable[int], matrix: list[list[float]]) -> float:
    indices = list(route)
    return sum(matrix[a][b] for a, b in zip(indices, indices[1:]))


def route_total_minutes(route: Iterable[int], stops: list[Stop], matrix: list[list[float]]) -> float:
    route_indices = list(route)
    return route_travel_minutes(route_indices, matrix) + sum(
        stops[i].estimated_duration_min for i in route_indices if i != 0
    )


def build_route_legs(route: list[int], stops: list[Stop], matrix: list[list[float]]) -> list[RouteLeg]:
    current = datetime(2026, 6, 16, 7, 30)
    cumulative = 0.0
    legs = []
    for sequence, stop_index in enumerate(route[1:-1], start=1):
        previous_index = route[sequence - 1]
        travel_min = matrix[previous_index][stop_index]
        current += timedelta(minutes=travel_min)
        arrival = current
        duration = stops[stop_index].estimated_duration_min
        current += timedelta(minutes=duration)
        cumulative += travel_min + duration
        stop = stops[stop_index]
        legs.append(
            RouteLeg(
                sequence=sequence,
                stop_id=stop.id,
                stop_name=stop.name,
                road=stop.road,
                arrival_time=arrival.strftime("%H:%M"),
                inspection_start=arrival.strftime("%H:%M"),
                inspection_end=current.strftime("%H:%M"),
                travel_from_previous_min=round(travel_min, 1),
                inspection_duration_min=duration,
                cumulative_min=round(cumulative, 1),
                priority=stop.priority,
                traffic_volume=stop.traffic_volume,
                latitude=stop.lat,
                longitude=stop.lon,
            )
        )
    return legs


def write_csv(path: Path, rows: list[RouteLeg]) -> None:
    with path.open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=list(asdict(rows[0]).keys()))
        writer.writeheader()
        for row in rows:
            writer.writerow(asdict(row))


def svg_point(stop: Stop, min_lon: float, max_lon: float, min_lat: float, max_lat: float) -> tuple[float, float]:
    width = 840
    height = 540
    padding = 52
    x = padding + ((stop.lon - min_lon) / (max_lon - min_lon)) * (width - padding * 2)
    y = padding + ((max_lat - stop.lat) / (max_lat - min_lat)) * (height - padding * 2)
    return x, y


def render_html(
    path: Path,
    stops: list[Stop],
    optimal_route: list[int],
    baseline: list[int],
    matrix: list[list[float]],
    legs: list[RouteLeg],
    optimal_route_geometry: list[list[float]],
    baseline_route_geometry: list[list[float]],
    matrix_source: str,
    geometry_source: str,
    optimisation_method: str,
) -> None:
    min_lon = min(stop.lon for stop in stops) - 0.01
    max_lon = max(stop.lon for stop in stops) + 0.01
    min_lat = min(stop.lat for stop in stops) - 0.01
    max_lat = max(stop.lat for stop in stops) + 0.01

    points = [svg_point(stop, min_lon, max_lon, min_lat, max_lat) for stop in stops]
    optimal_polyline = " ".join(f"{points[index][0]:.1f},{points[index][1]:.1f}" for index in optimal_route)
    baseline_polyline = " ".join(f"{points[index][0]:.1f},{points[index][1]:.1f}" for index in baseline)

    optimal_travel = route_travel_minutes(optimal_route, matrix)
    baseline_travel = route_travel_minutes(baseline, matrix)
    optimal_total = route_total_minutes(optimal_route, stops, matrix)
    baseline_total = route_total_minutes(baseline, stops, matrix)
    saving = baseline_total - optimal_total

    stop_markers = []
    route_rank = {stop_index: rank for rank, stop_index in enumerate(optimal_route[1:-1], start=1)}
    for index, stop in enumerate(stops):
        x, y = points[index]
        if index == 0:
            stop_markers.append(
                f'<circle cx="{x:.1f}" cy="{y:.1f}" r="11" fill="#1f6feb" stroke="#ffffff" stroke-width="2" />'
                f'<text x="{x + 15:.1f}" y="{y + 5:.1f}" class="label depot">Depot</text>'
            )
            continue
        radius = 8 + max(0, 4 - stop.priority)
        fill = {1: "#d92d20", 2: "#f79009", 3: "#12b76a"}.get(stop.priority, "#667085")
        rank = route_rank[index]
        stop_markers.append(
            f'<circle cx="{x:.1f}" cy="{y:.1f}" r="{radius}" fill="{fill}" stroke="#101828" stroke-width="1" />'
            f'<text x="{x:.1f}" y="{y + 4:.1f}" text-anchor="middle" class="rank">{rank}</text>'
            f'<title>{html.escape(stop.id)} - {html.escape(stop.name)} | {html.escape(stop.road)}</title>'
        )

    rows = "\n".join(
        "<tr>"
        f"<td>{leg.sequence}</td>"
        f"<td>{html.escape(leg.stop_name)}</td>"
        f"<td>{html.escape(leg.road)}</td>"
        f"<td>{leg.arrival_time}</td>"
        f"<td>{leg.travel_from_previous_min:.1f}</td>"
        f"<td>{leg.inspection_duration_min}</td>"
        f"<td>{leg.priority}</td>"
        f"<td>{leg.traffic_volume:,}</td>"
        "</tr>"
        for leg in legs
    )

    map_stops = []
    for index, stop in enumerate(stops):
        map_stops.append(
            {
                "id": stop.id,
                "name": stop.name,
                "road": stop.road,
                "lat": stop.lat,
                "lon": stop.lon,
                "priority": stop.priority,
                "trafficVolume": stop.traffic_volume,
                "inspectionType": stop.inspection_type,
                "rank": route_rank.get(index),
                "isDepot": index == 0,
            }
        )
    map_stops_json = json.dumps(map_stops).replace("</", "<\\/")
    optimal_route_json = json.dumps(optimal_route_geometry)
    baseline_route_json = json.dumps(baseline_route_geometry)
    route_bounds_json = json.dumps(optimal_route_geometry or route_stop_coordinates(stops, optimal_route))

    source_tables = [
        "transport_ramc.uvw_inspection: inspection demand, completed/scheduled status, assigned users and route context",
        "transport_ramc.uvw_roadlastinspected: road-level last inspection status by asset, direction and active stage",
        "transport_ramc.uvw_stripmap_wkt / uvw_stripmap_full: asset and job WKT for strip-map geometry",
        "transport_ramc.uvw_job / uvw_stripmap_jobs: recent jobs, defect points and work density",
        "External or adjacent source: traffic volume / congestion data, because RAMC traffic-volume tables are not yet clearly documented in this prototype source set",
    ]
    source_list = "\n".join(f"<li>{html.escape(item)}</li>" for item in source_tables)

    improvements = [
        "Actual row extracts with lat/lon or WKT for each due inspection segment.",
        "Inspector start/end depots, shift length, breaks, vehicle constraints and available crew count.",
        "Inspection frequency rules by road class, direction and asset type.",
        "Service time calibration from completed inspections rather than fixed estimates.",
        "Traffic-aware road travel times and route geometry from OSRM, GraphHopper, Google Routes or another approved routing API.",
        "Historical actual route traces to compare planned versus completed coverage.",
        "Rules for whether low-priority inspections can be deferred, split, or grouped with nearby jobs.",
    ]
    improvement_list = "\n".join(f"<li>{html.escape(item)}</li>" for item in improvements)

    html_doc = f"""<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <title>Inspector Route Optimisation Demo</title>
  <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
  <style>
    :root {{
      color-scheme: light;
      --ink: #101828;
      --muted: #667085;
      --line: #d0d5dd;
      --panel: #ffffff;
      --bg: #f6f8fb;
      --blue: #1f6feb;
      --green: #067647;
    }}
    * {{ box-sizing: border-box; }}
    body {{
      margin: 0;
      font-family: Arial, Helvetica, sans-serif;
      background: var(--bg);
      color: var(--ink);
    }}
    main {{
      max-width: 1220px;
      margin: 0 auto;
      padding: 28px;
    }}
    h1 {{ margin: 0 0 8px; font-size: 28px; }}
    h2 {{ margin: 24px 0 12px; font-size: 18px; }}
    p {{ color: var(--muted); line-height: 1.5; }}
    .grid {{
      display: grid;
      grid-template-columns: minmax(0, 2fr) minmax(320px, 1fr);
      gap: 18px;
      align-items: start;
    }}
    .panel {{
      background: var(--panel);
      border: 1px solid var(--line);
      border-radius: 8px;
      padding: 16px;
      box-shadow: 0 1px 2px rgba(16, 24, 40, 0.05);
    }}
    .metrics {{
      display: grid;
      grid-template-columns: repeat(2, minmax(0, 1fr));
      gap: 10px;
      margin-top: 12px;
    }}
    .metric {{
      border: 1px solid var(--line);
      border-radius: 6px;
      padding: 12px;
      background: #fcfcfd;
    }}
    .metric strong {{
      display: block;
      font-size: 24px;
      margin-bottom: 4px;
    }}
    .metric span {{ color: var(--muted); font-size: 13px; }}
    #map {{
      width: 100%;
      height: 540px;
      border: 1px solid var(--line);
      border-radius: 6px;
      overflow: hidden;
      background: #eef2f6;
    }}
    .map-panel {{
      padding: 16px;
    }}
    .map-note {{
      color: var(--muted);
      font-size: 12px;
      margin: 10px 0 0;
    }}
    .fallback {{
      margin-top: 14px;
      color: var(--muted);
      font-size: 13px;
    }}
    .fallback summary {{
      cursor: pointer;
      margin-bottom: 10px;
      color: #344054;
      font-weight: 700;
    }}
    .rank-tooltip {{
      background: transparent;
      border: 0;
      box-shadow: none;
      color: #ffffff;
      font-weight: 700;
      font-size: 11px;
      line-height: 1;
    }}
    .leaflet-popup-content {{
      font-size: 13px;
      line-height: 1.45;
    }}
    .fallback svg {{
      width: 100%;
      height: auto;
      display: block;
      border: 1px solid var(--line);
      border-radius: 6px;
      background:
        linear-gradient(90deg, rgba(16,24,40,0.05) 1px, transparent 1px),
        linear-gradient(rgba(16,24,40,0.05) 1px, transparent 1px),
        #f9fafb;
      background-size: 42px 42px;
    }}
    .rank {{ font-size: 10px; fill: white; font-weight: 700; pointer-events: none; }}
    .label {{ font-size: 13px; fill: var(--ink); font-weight: 700; }}
    .depot {{ fill: #1f2937; }}
    table {{ width: 100%; border-collapse: collapse; font-size: 13px; }}
    th, td {{ padding: 8px; border-bottom: 1px solid var(--line); text-align: left; }}
    th {{ color: #344054; background: #f9fafb; }}
    ul {{ color: var(--muted); line-height: 1.5; padding-left: 20px; }}
    .legend {{ display: flex; gap: 14px; flex-wrap: wrap; font-size: 13px; color: var(--muted); }}
    .key {{ display: inline-flex; align-items: center; gap: 6px; }}
    .swatch {{ width: 12px; height: 12px; border-radius: 999px; display: inline-block; }}
    @media (max-width: 900px) {{ .grid {{ grid-template-columns: 1fr; }} }}
  </style>
</head>
<body>
  <main>
    <h1>Inspector Route Optimisation Demo</h1>
    <p>
      Sample RAMC/RAMCSC-style route using road-network routing when available, then a TSP-style optimiser.
      This is a proof of method: the coordinates and volumes are sample rows, while the data fields match
      the documented RAMC table shape.
    </p>

    <section class="grid">
      <div class="panel map-panel">
        <div id="map" role="img" aria-label="OpenStreetMap inspection route view"></div>
        <p class="map-note">Route geometry: {html.escape(geometry_source)}. Travel matrix: {html.escape(matrix_source)}. Map tiles load from OpenStreetMap.</p>
        <details class="fallback">
          <summary>Offline coordinate fallback, straight stop-to-stop only</summary>
          <svg viewBox="0 0 840 540" role="img" aria-label="Optimised inspection route coordinate fallback">
            <polyline points="{baseline_polyline}" fill="none" stroke="#98a2b3" stroke-width="3" stroke-dasharray="7 8" />
            <polyline points="{optimal_polyline}" fill="none" stroke="#1f6feb" stroke-width="4" stroke-linejoin="round" stroke-linecap="round" />
            {''.join(stop_markers)}
          </svg>
        </details>
        <div class="legend" style="margin-top: 12px;">
          <span class="key"><span class="swatch" style="background:#1f6feb"></span>Optimised route</span>
          <span class="key"><span class="swatch" style="background:#98a2b3"></span>Baseline priority/due-date route</span>
          <span class="key"><span class="swatch" style="background:#d92d20"></span>Priority 1</span>
          <span class="key"><span class="swatch" style="background:#f79009"></span>Priority 2</span>
          <span class="key"><span class="swatch" style="background:#12b76a"></span>Priority 3</span>
        </div>
      </div>

      <aside class="panel">
        <h2>Route Metrics</h2>
        <div class="metrics">
          <div class="metric"><strong>{optimal_travel:.1f}</strong><span>Optimised travel min</span></div>
          <div class="metric"><strong>{baseline_travel:.1f}</strong><span>Baseline travel min</span></div>
          <div class="metric"><strong>{optimal_total:.1f}</strong><span>Total day min incl. inspections</span></div>
          <div class="metric"><strong>{saving:.1f}</strong><span>Minutes saved vs baseline</span></div>
          <div class="metric"><strong>{len(stops) - 1}</strong><span>Inspection stops connected</span></div>
        </div>
        <p>
          {html.escape(optimisation_method)}. The optimiser minimises travel time only. Priority is still shown because a real model would use
          priority and due date as constraints or penalties.
        </p>
      </aside>
    </section>

    <section class="panel" style="margin-top: 18px;">
      <h2>Optimised Stop Order</h2>
      <table>
        <thead>
          <tr>
            <th>#</th><th>Inspection</th><th>Road</th><th>Arrive</th><th>Travel min</th>
            <th>Inspect min</th><th>Priority</th><th>Traffic vol</th>
          </tr>
        </thead>
        <tbody>{rows}</tbody>
      </table>
    </section>

    <section class="grid" style="margin-top: 18px;">
      <div class="panel">
        <h2>Production Data Inputs</h2>
        <ul>{source_list}</ul>
      </div>
      <div class="panel">
        <h2>Data To Improve</h2>
        <ul>{improvement_list}</ul>
      </div>
    </section>
  </main>
  <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
  <script>
    const stops = {map_stops_json};
    const optimalRoute = {optimal_route_json};
    const baselineRoute = {baseline_route_json};
    const routeBounds = {route_bounds_json};

    function escapeHtml(value) {{
      return String(value)
        .replaceAll("&", "&amp;")
        .replaceAll("<", "&lt;")
        .replaceAll(">", "&gt;")
        .replaceAll('"', "&quot;")
        .replaceAll("'", "&#039;");
    }}

    function priorityColour(priority, isDepot) {{
      if (isDepot) return "#1f6feb";
      if (priority === 1) return "#d92d20";
      if (priority === 2) return "#f79009";
      if (priority === 3) return "#12b76a";
      return "#667085";
    }}

    function initialiseMap() {{
      const mapElement = document.getElementById("map");
      if (!window.L || !mapElement) {{
        if (mapElement) mapElement.textContent = "Map library could not load. Use the offline coordinate fallback below.";
        return;
      }}

      const map = L.map("map", {{ zoomControl: true }});
      map.createPane("routePane");
      map.getPane("routePane").style.zIndex = 650;

      L.tileLayer("https://{{s}}.tile.openstreetmap.org/{{z}}/{{x}}/{{y}}.png", {{
        maxZoom: 19,
        attribution: "&copy; OpenStreetMap contributors"
      }}).addTo(map);

      const baselineLine = L.polyline(baselineRoute, {{
        pane: "routePane",
        color: "#475467",
        weight: 4,
        dashArray: "7 8",
        opacity: 0.95,
        lineJoin: "round",
        lineCap: "round"
      }}).addTo(map);

      const optimalHalo = L.polyline(optimalRoute, {{
        pane: "routePane",
        color: "#ffffff",
        weight: 11,
        opacity: 0.9,
        lineJoin: "round",
        lineCap: "round"
      }}).addTo(map);

      const optimalLine = L.polyline(optimalRoute, {{
        pane: "routePane",
        color: "#1f6feb",
        weight: 7,
        opacity: 1,
        lineJoin: "round",
        lineCap: "round"
      }}).addTo(map);

      const markers = stops.map((stop) => {{
        const marker = L.circleMarker([stop.lat, stop.lon], {{
          radius: stop.isDepot ? 9 : 8 + Math.max(0, 4 - stop.priority),
          color: "#101828",
          weight: stop.isDepot ? 2 : 1,
          fillColor: priorityColour(stop.priority, stop.isDepot),
          fillOpacity: 0.95
        }}).addTo(map);

        const title = stop.isDepot ? "Depot / start-end" : "#" + stop.rank + " " + stop.name;
        marker.bindPopup(
          "<strong>" + escapeHtml(title) + "</strong><br>" +
          escapeHtml(stop.road) + "<br>" +
          "Type: " + escapeHtml(stop.inspectionType) + "<br>" +
          "Priority: " + escapeHtml(stop.isDepot ? "n/a" : stop.priority) + "<br>" +
          "Traffic volume: " + Number(stop.trafficVolume || 0).toLocaleString()
        );

        if (!stop.isDepot) {{
          marker.bindTooltip(String(stop.rank), {{
            permanent: true,
            direction: "center",
            className: "rank-tooltip"
          }});
        }}

        return marker;
      }});

      L.featureGroup([baselineLine, optimalHalo, optimalLine, ...markers]).addTo(map);
      map.fitBounds(L.latLngBounds(routeBounds).pad(0.18));
    }}

    window.addEventListener("load", initialiseMap);
  </script>
</body>
</html>
"""
    path.write_text(html_doc, encoding="utf-8")


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Prototype RAMC/RAMCSC inspector route optimisation.")
    parser.add_argument(
        "--routing",
        choices=("auto", "offline", "osrm"),
        default="auto",
        help="Use OSRM road-network routing, offline approximation, or auto fallback.",
    )
    parser.add_argument(
        "--osrm-base-url",
        default=OSRM_BASE_URL,
        help="OSRM base URL. Use a self-hosted endpoint for production or repeat testing.",
    )
    parser.add_argument(
        "--allow-insecure-tls",
        action="store_true",
        help="Demo-only workaround for local Python certificate-store issues when calling HTTPS OSRM.",
    )
    parser.add_argument(
        "--max-stops",
        type=int,
        default=0,
        help="Optional cap on inspection stops, excluding the depot. 0 means use all sample stops.",
    )
    return parser.parse_args()


def main() -> None:
    args = parse_args()
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    sample_stops = SAMPLE_STOPS[: args.max_stops] if args.max_stops > 0 else SAMPLE_STOPS
    stops = [DEPOT, *sample_stops]
    matrix, matrix_source = resolve_travel_matrix(
        stops, args.routing, args.osrm_base_url, args.allow_insecure_tls
    )
    optimal_route, optimisation_method = optimise_route(matrix)
    baseline = baseline_route(stops)
    legs = build_route_legs(optimal_route, stops, matrix)
    optimal_geometry, optimal_geometry_source = resolve_route_geometry(
        stops, optimal_route, args.routing, args.osrm_base_url, "optimised route", args.allow_insecure_tls
    )
    baseline_geometry, baseline_geometry_source = resolve_route_geometry(
        stops, baseline, args.routing, args.osrm_base_url, "baseline route", args.allow_insecure_tls
    )
    geometry_source = f"{optimal_geometry_source}; {baseline_geometry_source}"

    write_csv(OUTPUT_DIR / "optimised_route.csv", legs)
    metrics = {
        "method": optimisation_method,
        "routing_mode": args.routing,
        "matrix_source": matrix_source,
        "geometry_source": geometry_source,
        "stop_count_excluding_depot": len(stops) - 1,
        "optimised_route_stop_ids": [stops[index].id for index in optimal_route],
        "baseline_route_stop_ids": [stops[index].id for index in baseline],
        "optimised_travel_min": round(route_travel_minutes(optimal_route, matrix), 1),
        "baseline_travel_min": round(route_travel_minutes(baseline, matrix), 1),
        "optimised_total_min": round(route_total_minutes(optimal_route, stops, matrix), 1),
        "baseline_total_min": round(route_total_minutes(baseline, stops, matrix), 1),
        "estimated_saving_min": round(route_total_minutes(baseline, stops, matrix) - route_total_minutes(optimal_route, stops, matrix), 1),
        "assumptions": [
            "Sample task coordinates and traffic volumes are illustrative.",
            "Auto routing uses OSRM when available, otherwise an offline haversine approximation.",
            "Production should use an approved or self-hosted routing service for repeatable road travel times.",
            "The demo solves one inspector route; multiple inspectors should use VRP with shift and workload constraints.",
        ],
    }
    (OUTPUT_DIR / "route_metrics.json").write_text(json.dumps(metrics, indent=2), encoding="utf-8")
    render_html(
        OUTPUT_DIR / "inspection_route_demo.html",
        stops,
        optimal_route,
        baseline,
        matrix,
        legs,
        optimal_geometry,
        baseline_geometry,
        matrix_source,
        geometry_source,
        optimisation_method,
    )

    print(json.dumps(metrics, indent=2))
    print(f"\nWrote: {OUTPUT_DIR / 'inspection_route_demo.html'}")
    print(f"Wrote: {OUTPUT_DIR / 'optimised_route.csv'}")
    print(f"Wrote: {OUTPUT_DIR / 'route_metrics.json'}")


if __name__ == "__main__":
    main()
