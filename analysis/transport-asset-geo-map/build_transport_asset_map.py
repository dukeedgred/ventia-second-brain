from __future__ import annotations

import html
import json
import os
import shutil
import subprocess
import sys
import time
from collections import defaultdict
from datetime import datetime, timezone
from pathlib import Path
from typing import Any


ROOT = Path(__file__).resolve().parent
OUT_DIR = ROOT / "output"
PROFILE = os.environ.get("DATABRICKS_CONFIG_PROFILE", "ventia-transport")
WAREHOUSE_ID = os.environ.get("DATABRICKS_WAREHOUSE_ID", "e736bc08efffb739")
GRID_DEGREES = 0.05


SOURCE_CONTEXTS = [
    ("asset_vision_ven_gen7", "ext_mssql_asset_vision_ven_gen7", "RAMC / BAC / PoB / TSRC group"),
    ("asset_vision_ven_rms", "ext_mssql_asset_vision_ven_rms", "RMS"),
    ("asset_vision_ven_rms_new", "ext_mssql_asset_vision_ven_rms_new", "RMS new"),
    ("asset_vision_ven_rms_old", "ext_mssql_asset_vision_ven_rms_old", "RMS old"),
    ("asset_vision_ven_vicroads", "ext_mssql_asset_vision_ven_vicroads", "VicRoads"),
    ("asset_vision_vns_gen7", "ext_mssql_asset_vision_vns_gen7", "VNS"),
    ("asset_vision_vnz_gen7", "ext_mssql_asset_vision_vnz_gen7", "VNZ"),
    ("asset_vision_vsm_gen7", "ext_mssql_asset_vision_vsm_gen7", "VentureSmart"),
]


ACTIVE_CONTEXTS: list[tuple[str, str, str]] = []
SKIPPED_CONTEXTS: list[dict[str, str]] = []


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
        raise RuntimeError(
            "Databricks CLI failed:\n"
            + " ".join([cli, *args])
            + "\n\nSTDERR:\n"
            + proc.stderr.strip()
            + "\n\nSTDOUT:\n"
            + proc.stdout.strip()
        )
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
        time.sleep(2)
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
        raise RuntimeError(f"Statement failed: {message}")

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


def discover_active_contexts() -> list[tuple[str, str, str]]:
    active: list[tuple[str, str, str]] = []
    skipped: list[dict[str, str]] = []
    for source_context, catalog, display_name in SOURCE_CONTEXTS:
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

    global ACTIVE_CONTEXTS, SKIPPED_CONTEXTS
    ACTIVE_CONTEXTS = active
    SKIPPED_CONTEXTS = skipped
    if not ACTIVE_CONTEXTS:
        raise RuntimeError("No source contexts had both dbo.asset and dbo.vassetlocation available.")
    return ACTIVE_CONTEXTS


def source_union_sql(contexts: list[tuple[str, str, str]]) -> str:
    branches = []
    coord_pattern = "(-?\\\\d+(?:\\\\.\\\\d+)?)\\\\s+(-?\\\\d+(?:\\\\.\\\\d+)?)"
    for source_context, catalog, display_name in contexts:
        branches.append(
            f"""
            SELECT
              '{source_context}' AS source_context,
              '{display_name}' AS source_label,
              COALESCE(NULLIF(TRIM(CAST(a.Contract AS STRING)), ''), '{source_context}') AS project,
              COALESCE(NULLIF(TRIM(CAST(a.AssetType AS STRING)), ''), 'Unspecified asset type') AS asset_type,
              COALESCE(NULLIF(TRIM(CAST(a.Classification AS STRING)), ''), 'Unclassified') AS classification,
              LOWER(COALESCE(NULLIF(TRIM(CAST(a.SpatialType AS STRING)), ''), 'unknown')) AS spatial_type,
              CAST(a.ID AS STRING) AS asset_id,
              CAST(regexp_extract(loc.WKT, '{coord_pattern}', 1) AS DOUBLE) AS lon,
              CAST(regexp_extract(loc.WKT, '{coord_pattern}', 2) AS DOUBLE) AS lat
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
    SUM(CASE WHEN spatial_type = 'line' THEN 1 ELSE 0 END) AS line_assets,
    SUM(CASE WHEN spatial_type = 'polygon' THEN 1 ELSE 0 END) AS polygon_assets
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
        result_sets[str(row.get("result_set"))].append(json.loads(payload))
    return result_sets


def int_value(value: Any) -> int:
    if value is None or value == "":
        return 0
    return int(float(value))


def number_value(value: Any) -> float:
    if value is None or value == "":
        return 0.0
    return float(value)


def normalise_sets(result_sets: dict[str, list[dict[str, Any]]]) -> dict[str, Any]:
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

    top_asset_types = []
    type_totals: dict[str, int] = defaultdict(int)
    project_totals: dict[str, int] = defaultdict(int)
    for row in classes:
        type_totals[row["asset_type"]] += row["asset_count"]
        project_totals[row["project"]] += row["asset_count"]
    top_asset_types = [
        {"asset_type": key, "asset_count": value}
        for key, value in sorted(type_totals.items(), key=lambda item: item[1], reverse=True)[:18]
    ]
    top_projects = [
        {"project": key, "asset_count": value}
        for key, value in sorted(project_totals.items(), key=lambda item: item[1], reverse=True)[:18]
    ]

    return {
        "generated_at_utc": datetime.now(timezone.utc).isoformat(timespec="seconds"),
        "source_contexts": [
            {"source_context": context, "catalog": catalog, "label": label}
            for context, catalog, label in ACTIVE_CONTEXTS
        ],
        "skipped_contexts": SKIPPED_CONTEXTS,
        "grid": grid,
        "classes": classes,
        "summary": summary,
        "totals": {
            "grid_cells": len(grid),
            "class_rows": len(classes),
            "source_contexts": len(summary),
            "skipped_contexts": len(SKIPPED_CONTEXTS),
            "assets": sum(row["source_assets"] for row in summary),
            "valid_geo_rows": sum(row["valid_geo_rows"] for row in summary),
        },
        "top_asset_types": top_asset_types,
        "top_projects": top_projects,
        "assumptions": [
            "This is a location overview, not an exact engineering drawing.",
            "Nearby assets are grouped into circles so the browser stays fast.",
            "Some line or polygon assets are shown using a representative point.",
            "Asset type comes from Asset Vision. Some names may need cleanup before executive reporting.",
            "Records without a usable Australia/New Zealand location are not shown on the map.",
        ],
    }


def js_json(value: Any) -> str:
    return html.escape(json.dumps(value, ensure_ascii=False), quote=False)


def bars_html(rows: list[dict[str, Any]], label_key: str, value_key: str) -> str:
    maximum = max([row[value_key] for row in rows], default=1)
    output = []
    for row in rows:
        value = row[value_key]
        width = max(2, round((value / maximum) * 100))
        output.append(
            f"""
            <div class="bar-row">
              <div class="bar-label" title="{html.escape(str(row[label_key]))}">{html.escape(str(row[label_key]))}</div>
              <div class="bar-track"><div class="bar-fill" style="width:{width}%"></div></div>
              <div class="bar-value">{value:,}</div>
            </div>
            """
        )
    return "\n".join(output)


def render_html(data: dict[str, Any]) -> str:
    map_points = data["grid"]
    classes = data["classes"]
    summary = data["summary"]
    totals = data["totals"]
    source_label_by_context = {row["source_context"]: row["source_label"] for row in summary}
    source_label_by_context.update({context: label for context, _catalog, label in SOURCE_CONTEXTS})

    def friendly_source(row: dict[str, Any]) -> str:
        return row.get("source_label") or source_label_by_context.get(
            row.get("source_context", ""),
            row.get("source_context", ""),
        )

    summary_rows = "\n".join(
        f"""
        <tr>
          <td>{html.escape(row['source_label'])}<br><span>{html.escape(row['source_context'])}</span></td>
          <td>{row['source_assets']:,}</td>
          <td>{row['valid_geo_rows']:,}</td>
          <td>{row['source_rows']:,}</td>
        </tr>
        """
        for row in summary
    )
    class_rows = "\n".join(
        f"""
        <tr data-project="{html.escape(row['project'])}" data-asset-type="{html.escape(row['asset_type'])}">
          <td>{html.escape(row['project'])}<br><span>{html.escape(friendly_source(row))}</span></td>
          <td>{html.escape(row['asset_type'])}</td>
          <td>{row['asset_count']:,}</td>
          <td>{row['geocoded_rows']:,}</td>
          <td>{row['classification_count']:,}</td>
        </tr>
        """
        for row in classes[:500]
    )
    notes = "\n".join(f"<li>{html.escape(note)}</li>" for note in data["assumptions"])
    skipped_note = ""
    if data.get("skipped_contexts"):
        skipped_rows = "".join(
            f"<li><strong>{html.escape(source_label_by_context.get(row['source_context'], row['source_context']))}</strong>: source table was not available in the current Databricks environment.</li>"
            for row in data["skipped_contexts"]
        )
        skipped_note = f"<ul>{skipped_rows}</ul>"

    return f"""<!doctype html>
<html lang="en-AU">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Where Our Transport Assets Are</title>
  <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css">
  <style>
    :root {{
      --bg: #f4f6f8;
      --panel: #fff;
      --ink: #142033;
      --muted: #5e6a7c;
      --line: #d9e1ea;
      --blue: #235e9f;
      --teal: #17847d;
      --green: #27804a;
      --amber: #aa5a00;
      --shadow: 0 14px 34px rgba(18, 32, 51, .09);
    }}
    * {{ box-sizing: border-box; }}
    body {{
      margin: 0;
      background: var(--bg);
      color: var(--ink);
      font-family: Inter, ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
      line-height: 1.42;
    }}
    header {{
      background: #111827;
      color: #fff;
      padding: 26px 32px 22px;
      border-bottom: 5px solid var(--teal);
    }}
    .shell {{ max-width: 1500px; margin: 0 auto; }}
    .eyebrow {{
      color: #9fddd8;
      font-size: 12px;
      font-weight: 800;
      letter-spacing: .08em;
      text-transform: uppercase;
      margin-bottom: 8px;
    }}
    h1, h2, h3, p {{ margin: 0; }}
    h1 {{ font-size: clamp(30px, 4vw, 46px); line-height: 1.08; letter-spacing: 0; }}
    .subtitle {{ color: #d8dee8; margin-top: 10px; max-width: 1050px; font-size: 15px; }}
    main {{ max-width: 1500px; margin: 0 auto; padding: 20px 32px 36px; }}
    .kpis {{
      display: grid;
      grid-template-columns: repeat(5, minmax(150px, 1fr));
      gap: 12px;
      margin-bottom: 16px;
    }}
    .card, .panel {{
      background: var(--panel);
      border: 1px solid var(--line);
      border-radius: 8px;
      box-shadow: var(--shadow);
    }}
    .card {{ padding: 15px; min-height: 105px; }}
    .label {{ color: var(--muted); font-size: 12px; font-weight: 800; text-transform: uppercase; letter-spacing: .05em; }}
    .value {{ font-size: 30px; font-weight: 850; margin-top: 6px; }}
    .note {{ color: var(--muted); font-size: 12px; margin-top: 7px; }}
    .reader-guide {{
      display: grid;
      grid-template-columns: repeat(3, minmax(0, 1fr));
      gap: 12px;
      margin-bottom: 16px;
    }}
    .guide-card {{
      background: #fff;
      border: 1px solid var(--line);
      border-radius: 8px;
      padding: 14px 15px;
      box-shadow: var(--shadow);
    }}
    .guide-card strong {{
      display: block;
      font-size: 14px;
      margin-bottom: 5px;
    }}
    .guide-card span {{
      color: var(--muted);
      font-size: 13px;
    }}
    .grid {{
      display: grid;
      grid-template-columns: minmax(0, 1.25fr) minmax(380px, .75fr);
      gap: 16px;
      align-items: start;
    }}
    .panel {{ margin-bottom: 16px; overflow: hidden; }}
    .panel-head {{
      padding: 14px 16px;
      border-bottom: 1px solid var(--line);
      background: #fbfcfe;
      display: flex;
      justify-content: space-between;
      gap: 12px;
      align-items: end;
    }}
    h2 {{ font-size: 17px; }}
    .hint {{ color: var(--muted); font-size: 12px; margin-top: 4px; }}
    .panel-body {{ padding: 15px 16px 17px; }}
    #map {{
      height: 690px;
      width: 100%;
      background: #e7edf3;
    }}
    .controls {{
      display: grid;
      grid-template-columns: 1fr 1fr 1fr;
      gap: 10px;
      margin-bottom: 12px;
    }}
    input, select {{
      width: 100%;
      border: 1px solid var(--line);
      border-radius: 6px;
      padding: 9px 10px;
      background: #fff;
      color: var(--ink);
      font: inherit;
      font-size: 13px;
    }}
    .legend {{
      display: flex;
      flex-wrap: wrap;
      gap: 8px;
      font-size: 12px;
      color: var(--muted);
    }}
    .swatch {{ display: inline-block; width: 10px; height: 10px; border-radius: 999px; margin-right: 5px; }}
    table {{ width: 100%; border-collapse: collapse; font-size: 12px; }}
    th {{
      text-align: left;
      color: #344054;
      background: #f3f6fa;
      border-bottom: 1px solid var(--line);
      padding: 9px;
      position: sticky;
      top: 0;
      z-index: 1;
    }}
    td {{ border-bottom: 1px solid #edf1f6; padding: 9px; vertical-align: top; }}
    td span {{ color: var(--muted); font-size: 11px; }}
    .table-wrap {{ max-height: 440px; overflow: auto; border: 1px solid var(--line); border-radius: 8px; }}
    .bar-row {{
      display: grid;
      grid-template-columns: minmax(150px, 240px) 1fr 76px;
      gap: 10px;
      align-items: center;
      margin: 9px 0;
      font-size: 12px;
    }}
    .bar-label {{ white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }}
    .bar-track {{ height: 12px; background: #edf2f7; border-radius: 999px; overflow: hidden; border: 1px solid #dde6ef; }}
    .bar-fill {{ height: 100%; background: linear-gradient(90deg, var(--blue), var(--teal)); }}
    .bar-value {{ text-align: right; color: var(--muted); font-variant-numeric: tabular-nums; }}
    ul {{ margin: 0; padding-left: 18px; color: #344054; font-size: 13px; }}
    li {{ margin: 7px 0; }}
    @media (max-width: 1100px) {{
      .grid {{ grid-template-columns: 1fr; }}
      .kpis {{ grid-template-columns: repeat(2, minmax(0, 1fr)); }}
      .reader-guide {{ grid-template-columns: 1fr; }}
      #map {{ height: 560px; }}
    }}
  </style>
</head>
<body>
  <header>
    <div class="shell">
      <div class="eyebrow">Transport assets</div>
      <h1>Where Our Transport Assets Are</h1>
      <p class="subtitle">A simple map of Asset Vision records by project and asset type. Bigger circles mean more assets in that area. Use the filters to answer: where are the assets, which projects have the most, and what asset types dominate?</p>
    </div>
  </header>

  <main>
    <section class="kpis">
      <article class="card"><div class="label">Data sources</div><div class="value">{totals['source_contexts']:,}</div><div class="note">Asset Vision sources included</div></article>
      <article class="card"><div class="label">Assets found</div><div class="value">{totals['assets']:,}</div><div class="note">Total asset records counted</div></article>
      <article class="card"><div class="label">Assets on map</div><div class="value">{totals['valid_geo_rows']:,}</div><div class="note">Records with usable location</div></article>
      <article class="card"><div class="label">Map areas</div><div class="value">{totals['grid_cells']:,}</div><div class="note">Nearby assets grouped together</div></article>
      <article class="card"><div class="label">Missing source</div><div class="value">{totals['skipped_contexts']:,}</div><div class="note">One source was unavailable</div></article>
    </section>

    <section class="reader-guide">
      <div class="guide-card"><strong>1. Start with the map</strong><span>Look for the largest circles. They show where the most assets are concentrated.</span></div>
      <div class="guide-card"><strong>2. Filter to a project or asset type</strong><span>Use the dropdowns to focus on one contract, one project, or one asset type.</span></div>
      <div class="guide-card"><strong>3. Use the side panels for the story</strong><span>The right-hand charts explain which asset types and projects drive the numbers.</span></div>
    </section>

    <section class="grid">
      <div>
        <section class="panel">
          <div class="panel-head">
            <div>
              <h2>Asset Map</h2>
              <p class="hint">Each circle is a group of nearby assets. Bigger circle = more assets. Colours show the source system group.</p>
            </div>
            <div class="legend" id="legend"></div>
          </div>
          <div class="panel-body">
            <div class="controls">
              <select id="projectFilter"><option value="">All projects / contracts</option></select>
              <select id="assetTypeFilter"><option value="">All asset types</option></select>
              <input id="searchBox" type="search" placeholder="Search project or asset type">
            </div>
            <div id="map"></div>
          </div>
        </section>

        <section class="panel">
          <div class="panel-head">
            <div>
              <h2>What Assets Are In Each Project?</h2>
              <p class="hint">Use this table when someone asks what asset types sit under a contract or project.</p>
            </div>
          </div>
          <div class="panel-body">
            <div class="table-wrap">
              <table>
                <thead>
                  <tr>
                    <th>Project / contract</th>
                    <th>Asset type</th>
                    <th>Assets</th>
                    <th>Mapped records</th>
                    <th>Detail groups</th>
                  </tr>
                </thead>
                <tbody id="classRows">{class_rows}</tbody>
              </table>
            </div>
          </div>
        </section>
      </div>

      <aside>
        <section class="panel">
          <div class="panel-head"><div><h2>Most Common Asset Types</h2><p class="hint">The asset types with the most records in Asset Vision.</p></div></div>
          <div class="panel-body">{bars_html(data['top_asset_types'], 'asset_type', 'asset_count')}</div>
        </section>

        <section class="panel">
          <div class="panel-head"><div><h2>Largest Projects / Contracts</h2><p class="hint">Projects or contracts with the most asset records.</p></div></div>
          <div class="panel-body">{bars_html(data['top_projects'], 'project', 'asset_count')}</div>
        </section>

        <section class="panel">
          <div class="panel-head"><div><h2>Data Coverage</h2><p class="hint">How much data was available, and how much had a usable map location.</p></div></div>
          <div class="panel-body table-wrap">
            <table>
              <thead><tr><th>Data source</th><th>Assets</th><th>Mapped records</th><th>Total rows</th></tr></thead>
              <tbody>{summary_rows}</tbody>
            </table>
          </div>
        </section>

        <section class="panel">
          <div class="panel-head"><div><h2>What To Remember</h2><p class="hint">Plain-language notes for non-technical viewers.</p></div></div>
          <div class="panel-body"><ul>{notes}</ul></div>
        </section>

        <section class="panel">
          <div class="panel-head"><div><h2>Missing Data</h2><p class="hint">One documented source was not available when this page was generated.</p></div></div>
          <div class="panel-body">{skipped_note or '<p class="hint">None skipped.</p>'}</div>
        </section>
      </aside>
    </section>
  </main>

  <script id="asset-data" type="application/json">{js_json(data)}</script>
  <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
  <script>
    const data = JSON.parse(document.getElementById('asset-data').textContent);
    const points = data.grid;
    const classes = data.classes;
    const fmt = new Intl.NumberFormat('en-AU');
    const palette = ['#235e9f','#17847d','#27804a','#aa5a00','#7b4ea3','#b72f56','#52606d','#006d9c','#6f6a00','#bf4f24'];
    const sourceLabelByContext = Object.fromEntries(data.source_contexts.map((row) => [row.source_context, row.label]));
    const friendlySource = (row) => row.source_label || sourceLabelByContext[row.source_context] || row.source_context;
    const sources = [...new Set(points.map((row) => friendlySource(row)))].sort();
    const colorBySource = Object.fromEntries(sources.map((source, index) => [source, palette[index % palette.length]]));

    const map = L.map('map', {{ preferCanvas: true }}).setView([-27.8, 134.2], 4);
    L.tileLayer('https://{{s}}.tile.openstreetmap.org/{{z}}/{{x}}/{{y}}.png', {{
      maxZoom: 18,
      attribution: '&copy; OpenStreetMap contributors'
    }}).addTo(map);
    const layer = L.layerGroup().addTo(map);

    function populateSelect(id, values) {{
      const select = document.getElementById(id);
      values.forEach((value) => {{
        const option = document.createElement('option');
        option.value = value;
        option.textContent = value;
        select.appendChild(option);
      }});
    }}

    populateSelect('projectFilter', [...new Set(points.map((row) => row.project))].sort());
    populateSelect('assetTypeFilter', [...new Set(points.map((row) => row.asset_type))].sort());
    document.getElementById('legend').innerHTML = sources.map((source) => `<span><i class="swatch" style="background:${{colorBySource[source]}}"></i>${{source}}</span>`).join('');

    function filteredPoints() {{
      const project = document.getElementById('projectFilter').value;
      const assetType = document.getElementById('assetTypeFilter').value;
      const search = document.getElementById('searchBox').value.trim().toLowerCase();
      return points.filter((row) => {{
        if (project && row.project !== project) return false;
        if (assetType && row.asset_type !== assetType) return false;
        if (!search) return true;
        const text = `${{row.project}} ${{friendlySource(row)}} ${{row.asset_type}} ${{row.example_classification || ''}}`.toLowerCase();
        return text.includes(search);
      }});
    }}

    function renderMap() {{
      layer.clearLayers();
      const rows = filteredPoints();
      let bounds = [];
      rows.forEach((row) => {{
        const radius = Math.max(4, Math.min(26, 3 + Math.sqrt(row.asset_count) * 1.1));
        const source = friendlySource(row);
        const marker = L.circleMarker([row.lat, row.lon], {{
          radius,
          color: colorBySource[source] || '#235e9f',
          weight: 1,
          fillColor: colorBySource[source] || '#235e9f',
          fillOpacity: 0.42
        }});
        marker.bindTooltip(`<strong>${{row.project}}</strong><br>${{row.asset_type}}<br>${{fmt.format(row.asset_count)}} assets in this area<br>${{source}}`, {{ sticky: true }});
        marker.addTo(layer);
        bounds.push([row.lat, row.lon]);
      }});
      if (bounds.length) {{
        map.fitBounds(bounds, {{ padding: [28, 28], maxZoom: 8 }});
      }} else {{
        map.setView([-27.8, 134.2], 4);
      }}
    }}

    function renderClassRows() {{
      const project = document.getElementById('projectFilter').value;
      const assetType = document.getElementById('assetTypeFilter').value;
      const search = document.getElementById('searchBox').value.trim().toLowerCase();
      const rows = classes.filter((row) => {{
        if (project && row.project !== project) return false;
        if (assetType && row.asset_type !== assetType) return false;
        if (!search) return true;
        return `${{row.project}} ${{friendlySource(row)}} ${{row.asset_type}}`.toLowerCase().includes(search);
      }}).slice(0, 500);
      document.getElementById('classRows').innerHTML = rows.map((row) => `
        <tr>
          <td>${{row.project}}<br><span>${{friendlySource(row)}}</span></td>
          <td>${{row.asset_type}}</td>
          <td>${{fmt.format(row.asset_count)}}</td>
          <td>${{fmt.format(row.geocoded_rows)}}</td>
          <td>${{fmt.format(row.classification_count)}}</td>
        </tr>
      `).join('');
    }}

    ['projectFilter', 'assetTypeFilter', 'searchBox'].forEach((id) => {{
      document.getElementById(id).addEventListener('input', () => {{
        renderMap();
        renderClassRows();
      }});
      document.getElementById(id).addEventListener('change', () => {{
        renderMap();
        renderClassRows();
      }});
    }});

    renderMap();
    renderClassRows();
  </script>
</body>
</html>
"""


def write_outputs(data: dict[str, Any], sql: str) -> None:
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    (OUT_DIR / "transport_asset_geo_aggregated.json").write_text(
        json.dumps(data, indent=2, ensure_ascii=False),
        encoding="utf-8",
    )
    (OUT_DIR / "transport_asset_geo_query.sql").write_text(sql, encoding="utf-8")
    (OUT_DIR / "transport_asset_geo_map.html").write_text(render_html(data), encoding="utf-8")
    (ROOT / "README.md").write_text(
        f"""# Where Our Transport Assets Are

This report shows where Transport Asset Vision records are located, which projects have the most assets, and which asset types dominate.

## Open

Open `output/transport_asset_geo_map.html`.

## Outputs

- `output/transport_asset_geo_map.html`: interactive map and project/asset type summary.
- `output/transport_asset_geo_aggregated.json`: source data used by the HTML page.
- `output/transport_asset_geo_query.sql`: SQL used for Databricks aggregation.

## Scope

Included source contexts:
{chr(10).join(f"- `{context}` / `{catalog}` / {label}" for context, catalog, label in ACTIVE_CONTEXTS)}

Skipped source contexts:
{chr(10).join(f"- `{item['source_context']}` / `{item['catalog']}`: {item['reason']}" for item in SKIPPED_CONTEXTS) or "- None"}

## Notes

- Generated at {data['generated_at_utc']}.
- This is a location overview, not an exact engineering drawing.
- Nearby assets are grouped into circles so the browser stays fast.
- Some line or polygon assets are shown using a representative point.
- Asset type comes from Asset Vision `AssetType`.
""",
        encoding="utf-8",
    )


def main() -> int:
    print("Discovering available source contexts...")
    contexts = discover_active_contexts()
    print(f"Using source contexts: {len(contexts)}")
    if SKIPPED_CONTEXTS:
        print(f"Skipped source contexts: {len(SKIPPED_CONTEXTS)}")
    sql = aggregate_sql(contexts)
    print("Running aggregated Databricks query...")
    rows = execute_statement(sql)
    print(f"Downloaded aggregated rows: {len(rows):,}")
    data = normalise_sets(parse_result_sets(rows))
    write_outputs(data, sql)
    print(f"Wrote {OUT_DIR / 'transport_asset_geo_map.html'}")
    print(
        "Totals: "
        + json.dumps(
            data["totals"],
            ensure_ascii=False,
        )
    )
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except Exception as exc:
        print(f"ERROR: {exc}", file=sys.stderr)
        raise SystemExit(1)
