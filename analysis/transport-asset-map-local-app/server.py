from __future__ import annotations

import json
import mimetypes
import os
import re
import shutil
import subprocess
import sys
import time
from collections import defaultdict
from datetime import datetime, timezone
from http import HTTPStatus
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path
from typing import Any
from urllib.parse import parse_qs, unquote, urlparse


ROOT = Path(__file__).resolve().parent
STATIC_DIR = ROOT / "static"
DATA_PATH = ROOT / "data" / "transport_asset_geo_aggregated.json"
PROFILE = os.environ.get("DATABRICKS_CONFIG_PROFILE", "ventia-transport")
WAREHOUSE_ID = os.environ.get("DATABRICKS_WAREHOUSE_ID", "e736bc08efffb739")
PORT = int(os.environ.get("PORT", "8791"))
GRID_DEGREES = 0.05


SOURCE_CONTEXTS = {
    "asset_vision_ven_gen7": {
        "catalog": "ext_mssql_asset_vision_ven_gen7",
        "label": "RAMC / BAC / PoB / TSRC group",
    },
    "asset_vision_ven_rms": {
        "catalog": "ext_mssql_asset_vision_ven_rms",
        "label": "RMS",
    },
    "asset_vision_ven_rms_new": {
        "catalog": "ext_mssql_asset_vision_ven_rms_new",
        "label": "RMS new",
    },
    "asset_vision_ven_rms_old": {
        "catalog": "ext_mssql_asset_vision_ven_rms_old",
        "label": "RMS old",
    },
    "asset_vision_ven_vicroads": {
        "catalog": "ext_mssql_asset_vision_ven_vicroads",
        "label": "VicRoads",
    },
    "asset_vision_vns_gen7": {
        "catalog": "ext_mssql_asset_vision_vns_gen7",
        "label": "VNS",
    },
    "asset_vision_vnz_gen7": {
        "catalog": "ext_mssql_asset_vision_vnz_gen7",
        "label": "VNZ",
    },
    "asset_vision_vsm_gen7": {
        "catalog": "ext_mssql_asset_vision_vsm_gen7",
        "label": "VentureSmart",
    },
}


COORD_PATTERN_SQL = "(-?\\\\d+(?:\\\\.\\\\d+)?)\\\\s+(-?\\\\d+(?:\\\\.\\\\d+)?)"
NUMBER_RE = re.compile(r"[-+]?\d+(?:\.\d+)?(?:[eE][-+]?\d+)?")


def find_databricks_cli() -> str:
    env_path = os.environ.get("DATABRICKS_CLI")
    if env_path and Path(env_path).exists():
        return env_path
    on_path = shutil.which("databricks")
    if on_path:
        return on_path
    local_app = os.environ.get("LOCALAPPDATA")
    if local_app:
        matches = sorted(
            (Path(local_app) / "Microsoft" / "WinGet" / "Packages").glob(
                "Databricks.DatabricksCLI*/databricks.exe"
            )
        )
        if matches:
            return str(matches[-1])
    raise RuntimeError("Databricks CLI was not found. Set DATABRICKS_CLI if needed.")


def run_cli(args: list[str]) -> dict[str, Any]:
    cli = find_databricks_cli()
    proc = subprocess.run(
        [cli, *args],
        text=True,
        encoding="utf-8",
        errors="replace",
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        check=False,
    )
    if proc.returncode != 0:
        raise RuntimeError(proc.stderr.strip() or proc.stdout.strip())
    return json.loads(proc.stdout)


def execute_statement(sql: str) -> list[dict[str, Any]]:
    payload = {
        "warehouse_id": WAREHOUSE_ID,
        "statement": sql,
        "wait_timeout": "30s",
        "on_wait_timeout": "CONTINUE",
    }
    response = run_cli(
        [
            "api",
            "post",
            "/api/2.0/sql/statements",
            "--profile",
            PROFILE,
            "--json",
            json.dumps(payload),
            "-o",
            "json",
        ]
    )
    statement_id = response.get("statement_id")
    state = response.get("status", {}).get("state")
    while state in {"PENDING", "RUNNING"}:
        if not statement_id:
            raise RuntimeError(f"Statement did not return an id: {response}")
        time.sleep(1.5)
        response = run_cli(
            [
                "api",
                "get",
                f"/api/2.0/sql/statements/{statement_id}",
                "--profile",
                PROFILE,
                "-o",
                "json",
            ]
        )
        state = response.get("status", {}).get("state")

    if state != "SUCCEEDED":
        status = response.get("status", {})
        error = status.get("error", {}) if isinstance(status, dict) else {}
        message = error.get("message") or json.dumps(status, indent=2)
        raise RuntimeError(message)

    columns = [
        column["name"]
        for column in response.get("manifest", {}).get("schema", {}).get("columns", [])
    ]
    rows = list(response.get("result", {}).get("data_array", []))
    next_link = response.get("result", {}).get("next_chunk_internal_link")
    while next_link:
        chunk = run_cli(["api", "get", next_link, "--profile", PROFILE, "-o", "json"])
        rows.extend(chunk.get("data_array", []))
        next_link = chunk.get("next_chunk_internal_link")
    return [dict(zip(columns, row)) for row in rows]


def sql_quote(value: str) -> str:
    return "'" + value.replace("'", "''") + "'"


def int_param(params: dict[str, list[str]], key: str, default: int, minimum: int, maximum: int) -> int:
    raw = params.get(key, [str(default)])[0]
    try:
        value = int(raw)
    except ValueError:
        value = default
    return max(minimum, min(maximum, value))


def detail_sql(params: dict[str, list[str]]) -> tuple[str, dict[str, Any]]:
    source_context = params.get("source_context", [""])[0]
    project = params.get("project", [""])[0].strip()
    asset_type = params.get("asset_type", [""])[0].strip()
    condition = params.get("condition", [""])[0].strip()
    risk = params.get("risk", [""])[0].strip()
    spatial = params.get("spatial", [""])[0].strip().lower()
    limit = int_param(params, "limit", 1200, 50, 8000)
    stride = int_param(params, "stride", 1, 1, 50)

    if source_context not in SOURCE_CONTEXTS:
        raise ValueError("Select a valid source context.")
    if not project and not asset_type:
        raise ValueError("Select at least a project or an asset class before loading exact geometry.")

    catalog = SOURCE_CONTEXTS[source_context]["catalog"]
    filters = [
        "COALESCE(a.Deleted, false) = false",
        "COALESCE(loc.Deleted, false) = false",
        "loc.WKT IS NOT NULL",
        f"CAST(regexp_extract(loc.WKT, '{COORD_PATTERN_SQL}', 1) AS DOUBLE) BETWEEN 112 AND 180",
        f"CAST(regexp_extract(loc.WKT, '{COORD_PATTERN_SQL}', 2) AS DOUBLE) BETWEEN -48 AND -9",
    ]
    if project:
        filters.append(
            "COALESCE(NULLIF(TRIM(CAST(a.Contract AS STRING)), ''), "
            + sql_quote(source_context)
            + ") = "
            + sql_quote(project)
        )
    if asset_type:
        filters.append(
            "COALESCE(NULLIF(TRIM(CAST(a.AssetType AS STRING)), ''), 'Unspecified asset type') = "
            + sql_quote(asset_type)
        )
    if condition:
        filters.append("LOWER(COALESCE(CAST(a.AssetCondition AS STRING), '')) LIKE " + sql_quote(f"%{condition.lower()}%"))
    if risk:
        filters.append("LOWER(COALESCE(CAST(a.AssetRisk AS STRING), '')) LIKE " + sql_quote(f"%{risk.lower()}%"))
    if spatial == "line":
        filters.append("LOWER(COALESCE(CAST(a.SpatialType AS STRING), '')) IN ('line', 'polyline', 'linestring')")
    elif spatial == "polygon":
        filters.append("LOWER(COALESCE(CAST(a.SpatialType AS STRING), '')) IN ('polygon', 'poly', 'area')")
    elif spatial == "point":
        filters.append("LOWER(COALESCE(CAST(a.SpatialType AS STRING), '')) = 'point'")

    where_clause = "\n      AND ".join(filters)
    sql = f"""
    SELECT
      CAST(a.ID AS STRING) AS asset_id,
      COALESCE(NULLIF(TRIM(CAST(a.Contract AS STRING)), ''), {sql_quote(source_context)}) AS project,
      COALESCE(NULLIF(TRIM(CAST(a.AssetType AS STRING)), ''), 'Unspecified asset type') AS asset_type,
      COALESCE(NULLIF(TRIM(CAST(a.Classification AS STRING)), ''), 'Unclassified') AS classification,
      COALESCE(NULLIF(TRIM(CAST(a.AssetCondition AS STRING)), ''), 'Not supplied') AS asset_condition,
      COALESCE(NULLIF(TRIM(CAST(a.AssetRisk AS STRING)), ''), 'Not supplied') AS asset_risk,
      COALESCE(NULLIF(TRIM(CAST(a.AssetCriticality AS STRING)), ''), 'Not supplied') AS asset_criticality,
      LOWER(COALESCE(NULLIF(TRIM(CAST(a.SpatialType AS STRING)), ''), 'unknown')) AS spatial_type,
      loc.WKT AS wkt,
      COUNT(*) OVER () AS total_matching
    FROM {catalog}.dbo.asset a
    INNER JOIN {catalog}.dbo.vassetlocation loc
      ON loc.AssetID = a.ID
    WHERE {where_clause}
    ORDER BY a.AssetType, a.ID
    LIMIT {limit}
    """.strip()
    meta = {
        "source_context": source_context,
        "catalog": catalog,
        "project": project,
        "asset_type": asset_type,
        "condition": condition,
        "risk": risk,
        "spatial": spatial,
        "limit": limit,
        "stride": stride,
    }
    return sql, meta


def pair_numbers(text: str) -> list[list[float]]:
    numbers = [float(match.group(0)) for match in NUMBER_RE.finditer(text)]
    coords: list[list[float]] = []
    for index in range(0, len(numbers) - 1, 2):
        lon = numbers[index]
        lat = numbers[index + 1]
        if 112 <= lon <= 180 and -48 <= lat <= -9:
            coords.append([lon, lat])
    return coords


def simplify_line(coords: list[list[float]], stride: int, max_points: int = 900) -> list[list[float]]:
    if len(coords) <= 2:
        return coords
    effective_stride = max(stride, (len(coords) // max_points) + 1)
    simplified = coords[::effective_stride]
    if simplified[-1] != coords[-1]:
        simplified.append(coords[-1])
    return simplified


def split_top_level_groups(text: str) -> list[str]:
    groups: list[str] = []
    depth = 0
    start: int | None = None
    for index, char in enumerate(text):
        if char == "(":
            if depth == 0:
                start = index + 1
            depth += 1
        elif char == ")":
            depth -= 1
            if depth == 0 and start is not None:
                groups.append(text[start:index])
                start = None
    return groups


def wkt_to_geometry(wkt: str, stride: int) -> tuple[dict[str, Any] | None, dict[str, int]]:
    if not wkt:
        return None, {"raw_points": 0, "rendered_points": 0}
    text = wkt.strip()
    upper = text.upper()
    raw_points = 0
    rendered_points = 0

    if upper.startswith("POINT"):
        coords = pair_numbers(text)
        if not coords:
            return None, {"raw_points": 0, "rendered_points": 0}
        return {"type": "Point", "coordinates": coords[0]}, {"raw_points": 1, "rendered_points": 1}

    if upper.startswith("LINESTRING"):
        coords = pair_numbers(text)
        raw_points = len(coords)
        coords = simplify_line(coords, stride)
        rendered_points = len(coords)
        if len(coords) < 2:
            return None, {"raw_points": raw_points, "rendered_points": rendered_points}
        return {"type": "LineString", "coordinates": coords}, {"raw_points": raw_points, "rendered_points": rendered_points}

    if upper.startswith("MULTILINESTRING"):
        body = text[text.find("(") :]
        lines = []
        for group in split_top_level_groups(body):
            coords = pair_numbers(group)
            raw_points += len(coords)
            coords = simplify_line(coords, stride)
            rendered_points += len(coords)
            if len(coords) >= 2:
                lines.append(coords)
        if not lines:
            return None, {"raw_points": raw_points, "rendered_points": rendered_points}
        return {"type": "MultiLineString", "coordinates": lines}, {"raw_points": raw_points, "rendered_points": rendered_points}

    if upper.startswith("POLYGON"):
        body = text[text.find("(") :]
        rings = []
        for group in split_top_level_groups(body):
            coords = pair_numbers(group)
            raw_points += len(coords)
            coords = simplify_line(coords, stride)
            rendered_points += len(coords)
            if len(coords) >= 4:
                rings.append(coords)
        if not rings:
            coords = pair_numbers(text)
            raw_points = len(coords)
            coords = simplify_line(coords, stride)
            rendered_points = len(coords)
            if len(coords) >= 4:
                rings = [coords]
        if not rings:
            return None, {"raw_points": raw_points, "rendered_points": rendered_points}
        return {"type": "Polygon", "coordinates": rings}, {"raw_points": raw_points, "rendered_points": rendered_points}

    coords = pair_numbers(text)
    raw_points = len(coords)
    coords = simplify_line(coords, stride)
    rendered_points = len(coords)
    if len(coords) >= 2:
        return {"type": "LineString", "coordinates": coords}, {"raw_points": raw_points, "rendered_points": rendered_points}
    return None, {"raw_points": raw_points, "rendered_points": rendered_points}


def rows_to_geojson(rows: list[dict[str, Any]], meta: dict[str, Any]) -> dict[str, Any]:
    features = []
    total_matching = 0
    raw_points = 0
    rendered_points = 0
    skipped = 0
    stride = int(meta["stride"])
    for row in rows:
        total_matching = int(float(row.get("total_matching") or total_matching or 0))
        geometry, point_meta = wkt_to_geometry(str(row.get("wkt") or ""), stride)
        raw_points += point_meta["raw_points"]
        rendered_points += point_meta["rendered_points"]
        if not geometry:
            skipped += 1
            continue
        features.append(
            {
                "type": "Feature",
                "geometry": geometry,
                "properties": {
                    "asset_id": row.get("asset_id"),
                    "project": row.get("project"),
                    "asset_type": row.get("asset_type"),
                    "classification": row.get("classification"),
                    "asset_condition": row.get("asset_condition"),
                    "asset_risk": row.get("asset_risk"),
                    "asset_criticality": row.get("asset_criticality"),
                    "spatial_type": row.get("spatial_type"),
                },
            }
        )
    return {
        "type": "FeatureCollection",
        "features": features,
        "meta": {
            **meta,
            "query_source": "databricks",
            "returned_rows": len(rows),
            "returned_features": len(features),
            "skipped_geometry_rows": skipped,
            "total_matching": total_matching,
            "raw_coordinate_points": raw_points,
            "rendered_coordinate_points": rendered_points,
            "limited": bool(total_matching and len(rows) < total_matching),
        },
    }


def source_context_rows() -> list[tuple[str, str, str]]:
    return [
        (source_context, config["catalog"], config["label"])
        for source_context, config in SOURCE_CONTEXTS.items()
    ]


def discover_active_contexts() -> tuple[list[tuple[str, str, str]], list[dict[str, str]]]:
    active: list[tuple[str, str, str]] = []
    skipped: list[dict[str, str]] = []
    for source_context, catalog, display_name in source_context_rows():
        try:
            rows = execute_statement(
                f"""
                SELECT lower(table_name) AS table_name
                FROM {catalog}.information_schema.tables
                WHERE lower(table_schema) = 'dbo'
                  AND lower(table_name) IN ('asset', 'vassetlocation')
                """.strip()
            )
            found = {str(row.get("table_name", "")).lower() for row in rows}
            missing = sorted({"asset", "vassetlocation"} - found)
            if missing:
                skipped.append(
                    {
                        "source_context": source_context,
                        "catalog": catalog,
                        "reason": "Missing required table(s): " + ", ".join(missing),
                    }
                )
                continue
            active.append((source_context, catalog, display_name))
        except Exception as exc:
            skipped.append(
                {
                    "source_context": source_context,
                    "catalog": catalog,
                    "reason": str(exc).splitlines()[0][:220],
                }
            )

    if not active:
        raise RuntimeError("No source contexts had both dbo.asset and dbo.vassetlocation available.")
    return active, skipped


def source_union_sql(contexts: list[tuple[str, str, str]]) -> str:
    branches = []
    for source_context, catalog, display_name in contexts:
        branches.append(
            f"""
            SELECT
              {sql_quote(source_context)} AS source_context,
              {sql_quote(display_name)} AS source_label,
              COALESCE(NULLIF(TRIM(CAST(a.Contract AS STRING)), ''), {sql_quote(source_context)}) AS project,
              COALESCE(NULLIF(TRIM(CAST(a.AssetType AS STRING)), ''), 'Unspecified asset type') AS asset_type,
              COALESCE(NULLIF(TRIM(CAST(a.Classification AS STRING)), ''), 'Unclassified') AS classification,
              LOWER(COALESCE(NULLIF(TRIM(CAST(a.SpatialType AS STRING)), ''), 'unknown')) AS spatial_type,
              CAST(a.ID AS STRING) AS asset_id,
              CAST(regexp_extract(loc.WKT, '{COORD_PATTERN_SQL}', 1) AS DOUBLE) AS lon,
              CAST(regexp_extract(loc.WKT, '{COORD_PATTERN_SQL}', 2) AS DOUBLE) AS lat
            FROM {catalog}.dbo.asset a
            LEFT JOIN {catalog}.dbo.vassetlocation loc
              ON loc.AssetID = a.ID
             AND COALESCE(loc.Deleted, false) = false
            WHERE COALESCE(a.Deleted, false) = false
            """
        )
    return "\nUNION ALL\n".join(branches)


def aggregate_sql(contexts: list[tuple[str, str, str]]) -> str:
    union_sql = source_union_sql(contexts)
    return f"""
WITH unified_assets AS (
{union_sql}
),
valid_geo AS (
  SELECT
    source_context,
    source_label,
    project,
    asset_type,
    classification,
    spatial_type,
    asset_id,
    lon,
    lat
  FROM unified_assets
  WHERE lon BETWEEN 112 AND 180
    AND lat BETWEEN -48 AND -9
),
grid_agg AS (
  SELECT
    source_context,
    source_label,
    project,
    asset_type,
    ROUND(lat / {GRID_DEGREES}) * {GRID_DEGREES} AS lat_grid,
    ROUND(lon / {GRID_DEGREES}) * {GRID_DEGREES} AS lon_grid,
    COUNT(DISTINCT asset_id) AS asset_count,
    COUNT(*) AS location_rows,
    COUNT(DISTINCT classification) AS classification_count,
    MIN(classification) AS example_classification,
    SUM(CASE WHEN spatial_type = 'point' THEN 1 ELSE 0 END) AS point_assets,
    SUM(CASE WHEN spatial_type IN ('line', 'polyline', 'linestring') THEN 1 ELSE 0 END) AS line_assets,
    SUM(CASE WHEN spatial_type IN ('polygon', 'poly', 'area') THEN 1 ELSE 0 END) AS polygon_assets
  FROM valid_geo
  GROUP BY source_context, source_label, project, asset_type, ROUND(lat / {GRID_DEGREES}) * {GRID_DEGREES}, ROUND(lon / {GRID_DEGREES}) * {GRID_DEGREES}
),
class_agg AS (
  SELECT
    source_context,
    source_label,
    project,
    asset_type,
    COUNT(DISTINCT asset_id) AS asset_count,
    COUNT(*) AS location_rows,
    COUNT(DISTINCT classification) AS classification_count,
    SUM(CASE WHEN lon IS NOT NULL AND lat IS NOT NULL THEN 1 ELSE 0 END) AS geocoded_rows
  FROM unified_assets
  GROUP BY source_context, source_label, project, asset_type
),
summary AS (
  SELECT
    source_context,
    source_label,
    COUNT(DISTINCT asset_id) AS source_assets,
    SUM(CASE WHEN lon BETWEEN 112 AND 180 AND lat BETWEEN -48 AND -9 THEN 1 ELSE 0 END) AS valid_geo_rows,
    COUNT(*) AS source_rows
  FROM unified_assets
  GROUP BY source_context, source_label
)
SELECT 'grid' AS result_set, to_json(named_struct(
  'source_context', source_context,
  'source_label', source_label,
  'project', project,
  'asset_type', asset_type,
  'lat', lat_grid,
  'lon', lon_grid,
  'asset_count', asset_count,
  'location_rows', location_rows,
  'classification_count', classification_count,
  'example_classification', example_classification,
  'point_assets', point_assets,
  'line_assets', line_assets,
  'polygon_assets', polygon_assets
)) AS payload
FROM grid_agg
UNION ALL
SELECT 'class' AS result_set, to_json(named_struct(
  'source_context', source_context,
  'source_label', source_label,
  'project', project,
  'asset_type', asset_type,
  'asset_count', asset_count,
  'location_rows', location_rows,
  'classification_count', classification_count,
  'geocoded_rows', geocoded_rows
)) AS payload
FROM class_agg
UNION ALL
SELECT 'summary' AS result_set, to_json(named_struct(
  'source_context', source_context,
  'source_label', source_label,
  'source_assets', source_assets,
  'valid_geo_rows', valid_geo_rows,
  'source_rows', source_rows
)) AS payload
FROM summary
""".strip()


def parse_result_sets(rows: list[dict[str, Any]]) -> dict[str, list[dict[str, Any]]]:
    result_sets: dict[str, list[dict[str, Any]]] = defaultdict(list)
    for row in rows:
        payload = row.get("payload")
        if not payload:
            continue
        if isinstance(payload, str):
            payload = json.loads(payload)
        result_sets[str(row.get("result_set"))].append(payload)
    return result_sets


def int_value(value: Any) -> int:
    if value is None or value == "":
        return 0
    return int(float(value))


def number_value(value: Any) -> float:
    if value is None or value == "":
        return 0.0
    return float(value)


def normalise_sets(
    result_sets: dict[str, list[dict[str, Any]]],
    active_contexts: list[tuple[str, str, str]],
    skipped_contexts: list[dict[str, str]],
) -> dict[str, Any]:
    grid = result_sets.get("grid", [])
    classes = result_sets.get("class", [])
    summary = result_sets.get("summary", [])

    for row in grid:
        row["asset_count"] = int_value(row.get("asset_count"))
        row["location_rows"] = int_value(row.get("location_rows"))
        row["classification_count"] = int_value(row.get("classification_count"))
        row["lat"] = number_value(row.get("lat"))
        row["lon"] = number_value(row.get("lon"))
        row["point_assets"] = int_value(row.get("point_assets"))
        row["line_assets"] = int_value(row.get("line_assets"))
        row["polygon_assets"] = int_value(row.get("polygon_assets"))

    for row in classes:
        row["asset_count"] = int_value(row.get("asset_count"))
        row["location_rows"] = int_value(row.get("location_rows"))
        row["classification_count"] = int_value(row.get("classification_count"))
        row["geocoded_rows"] = int_value(row.get("geocoded_rows"))

    for row in summary:
        row["source_assets"] = int_value(row.get("source_assets"))
        row["valid_geo_rows"] = int_value(row.get("valid_geo_rows"))
        row["source_rows"] = int_value(row.get("source_rows"))

    grid.sort(key=lambda item: item["asset_count"], reverse=True)
    classes.sort(key=lambda item: item["asset_count"], reverse=True)
    summary.sort(key=lambda item: item["source_assets"], reverse=True)

    type_totals: dict[str, int] = defaultdict(int)
    project_totals: dict[str, int] = defaultdict(int)
    for row in classes:
        type_totals[row["asset_type"]] += row["asset_count"]
        project_totals[row["project"]] += row["asset_count"]

    return {
        "generated_at_utc": datetime.now(timezone.utc).isoformat(timespec="seconds"),
        "data_source": "databricks-live-refresh",
        "grid_degrees": GRID_DEGREES,
        "source_contexts": [
            {"source_context": context, "catalog": catalog, "label": label}
            for context, catalog, label in active_contexts
        ],
        "skipped_contexts": skipped_contexts,
        "grid": grid,
        "classes": classes,
        "summary": summary,
        "totals": {
            "grid_cells": len(grid),
            "class_rows": len(classes),
            "source_contexts": len(summary),
            "skipped_contexts": len(skipped_contexts),
            "assets": sum(row["source_assets"] for row in summary),
            "valid_geo_rows": sum(row["valid_geo_rows"] for row in summary),
        },
        "top_asset_types": [
            {"asset_type": key, "asset_count": value}
            for key, value in sorted(type_totals.items(), key=lambda item: item[1], reverse=True)[:18]
        ],
        "top_projects": [
            {"project": key, "asset_count": value}
            for key, value in sorted(project_totals.items(), key=lambda item: item[1], reverse=True)[:18]
        ],
        "assumptions": [
            "Overview data is aggregated in Databricks before it is written to the local cache.",
            "The overview map uses the first coordinate found in each Asset Vision WKT value as a representative point for grid aggregation.",
            "The exact-geometry layer queries filtered WKT rows directly from Databricks.",
            f"Overview grid aggregation rounds coordinates to {GRID_DEGREES} degrees to keep the browser responsive.",
            "Rows without valid Australia/New Zealand extent lon/lat coordinates are excluded from the overview map but still appear in the class summary via geocoded row counts.",
        ],
    }


def refresh_overview_from_databricks() -> dict[str, Any]:
    active_contexts, skipped_contexts = discover_active_contexts()
    rows = execute_statement(aggregate_sql(active_contexts))
    data = normalise_sets(parse_result_sets(rows), active_contexts, skipped_contexts)
    DATA_PATH.parent.mkdir(parents=True, exist_ok=True)
    DATA_PATH.write_text(json.dumps(data, indent=2, ensure_ascii=False), encoding="utf-8")
    return data


def load_overview() -> dict[str, Any]:
    data = json.loads(DATA_PATH.read_text(encoding="utf-8"))
    data.setdefault("data_source", "local-cache")
    return data


def filter_metadata() -> dict[str, Any]:
    data = load_overview()
    projects_by_context: dict[str, set[str]] = {}
    asset_types_by_context: dict[str, set[str]] = {}
    for row in data.get("classes", []):
        context = row.get("source_context")
        if not context:
            continue
        projects_by_context.setdefault(context, set()).add(row.get("project") or "")
        asset_types_by_context.setdefault(context, set()).add(row.get("asset_type") or "")
    return {
        "data_source": data.get("data_source", "local-cache"),
        "generated_at_utc": data.get("generated_at_utc"),
        "source_contexts": [
            {
                "source_context": row.get("source_context"),
                "source_label": row.get("source_label"),
                "source_assets": row.get("source_assets"),
                "valid_geo_rows": row.get("valid_geo_rows"),
            }
            for row in data.get("summary", [])
        ],
        "projects_by_context": {
            key: sorted(value)
            for key, value in projects_by_context.items()
        },
        "asset_types_by_context": {
            key: sorted(value)
            for key, value in asset_types_by_context.items()
        },
        "totals": data.get("totals", {}),
        "skipped_contexts": data.get("skipped_contexts", []),
    }


class Handler(BaseHTTPRequestHandler):
    server_version = "TransportAssetMapLocal/1.0"

    def log_message(self, format: str, *args: Any) -> None:
        sys.stderr.write("%s - - [%s] %s\n" % (self.client_address[0], self.log_date_time_string(), format % args))

    def send_json(self, data: Any, status: HTTPStatus = HTTPStatus.OK) -> None:
        body = json.dumps(data, ensure_ascii=False).encode("utf-8")
        self.send_response(status)
        self.send_header("Content-Type", "application/json; charset=utf-8")
        self.send_header("Content-Length", str(len(body)))
        self.send_header("Cache-Control", "no-store")
        self.end_headers()
        self.wfile.write(body)

    def send_file(self, path: Path) -> None:
        if not path.exists() or not path.is_file():
            self.send_error(HTTPStatus.NOT_FOUND)
            return
        ctype = mimetypes.guess_type(str(path))[0] or "application/octet-stream"
        body = path.read_bytes()
        self.send_response(HTTPStatus.OK)
        self.send_header("Content-Type", ctype)
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def do_GET(self) -> None:
        parsed = urlparse(self.path)
        path = unquote(parsed.path)
        try:
            if path == "/api/health":
                self.send_json(
                    {
                        "ok": True,
                        "databricks_profile": PROFILE,
                        "warehouse_id": WAREHOUSE_ID,
                        "overview_cache": str(DATA_PATH),
                    }
                )
                return
            if path == "/api/overview":
                self.send_json(load_overview())
                return
            if path == "/api/filters":
                self.send_json(filter_metadata())
                return
            if path == "/api/refresh-overview":
                self.send_json(refresh_overview_from_databricks())
                return
            if path == "/api/geometry":
                params = parse_qs(parsed.query)
                sql, meta = detail_sql(params)
                rows = execute_statement(sql)
                response = rows_to_geojson(rows, meta)
                self.send_json(response)
                return
            if path in {"/", "/index.html"}:
                self.send_file(STATIC_DIR / "index.html")
                return
            if path.startswith("/static/"):
                requested = (STATIC_DIR / path.removeprefix("/static/")).resolve()
                if not str(requested).startswith(str(STATIC_DIR.resolve())):
                    self.send_error(HTTPStatus.FORBIDDEN)
                    return
                self.send_file(requested)
                return
            self.send_error(HTTPStatus.NOT_FOUND)
        except ValueError as exc:
            self.send_json({"error": str(exc)}, HTTPStatus.BAD_REQUEST)
        except Exception as exc:
            self.send_json({"error": str(exc)}, HTTPStatus.INTERNAL_SERVER_ERROR)


def main() -> int:
    if not DATA_PATH.exists():
        raise RuntimeError(f"Missing overview data: {DATA_PATH}")
    httpd = ThreadingHTTPServer(("127.0.0.1", PORT), Handler)
    print(f"Transport asset local app: http://127.0.0.1:{PORT}/")
    print("Press Ctrl+C to stop.")
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        pass
    finally:
        httpd.server_close()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
