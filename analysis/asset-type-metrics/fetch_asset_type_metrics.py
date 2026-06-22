from __future__ import annotations

import csv
import json
import os
import re
import shutil
import subprocess
import sys
import tempfile
import time
from collections import defaultdict
from dataclasses import dataclass
from datetime import datetime, timezone
from pathlib import Path
from typing import Any


ROOT = Path(__file__).resolve().parents[2]
OUT_DIR = ROOT / "analysis" / "asset-type-metrics" / "output"
WIKI_OUT = ROOT / "content" / "wiki" / "Ventia" / "Data Tables" / "Transport" / "Transport Asset Type Metrics and Attributes.md"
MAPPING_SQL = ROOT / "analysis" / "deterioration-analysis" / "create_asset_type_category_map.sql"
PROFILE = os.environ.get("DATABRICKS_CONFIG_PROFILE", "ventia-transport")
WAREHOUSE_ID = os.environ.get("DATABRICKS_WAREHOUSE_ID", "e736bc08efffb739")
TARGET_CATALOG = os.environ.get("ATM_TARGET_CATALOG", "transport_dev")
TARGET_SCHEMA = os.environ.get("ATM_TARGET_SCHEMA", "integ_transport_assets")
TABLE_PREFIX = os.environ.get("ATM_TABLE_PREFIX", "atm_")

PUBLISHED_TABLES = {
    "summary": f"{TABLE_PREFIX}asset_type_metrics_summary",
    "detail": f"{TABLE_PREFIX}asset_type_metrics_detail",
    "source_contract": f"{TABLE_PREFIX}asset_type_source_contract_breakdown",
    "mapping": f"{TABLE_PREFIX}asset_type_mapping",
    "metric_dictionary": f"{TABLE_PREFIX}metric_dictionary",
    "run_status": f"{TABLE_PREFIX}run_status",
}

PUBLISHED_TABLE_INFO = {
    "summary": {
        "grain": "standardised asset type",
        "purpose": "Primary dashboard table with numeric coverage rates.",
    },
    "detail": {
        "grain": "source context + contract + raw asset type",
        "purpose": "Drill-down table for raw Asset Vision type/source/contract slices.",
    },
    "source_contract": {
        "grain": "standardised asset type + source + contract",
        "purpose": "Source/contract coverage matrix.",
    },
    "mapping": {
        "grain": "raw asset type",
        "purpose": "Raw-to-standardised naming audit.",
    },
    "metric_dictionary": {
        "grain": "metric definition",
        "purpose": "Definitions and caveats for dashboard tooltips or documentation.",
    },
    "run_status": {
        "grain": "source context refresh status",
        "purpose": "Refresh status, skipped contexts, and loaded asset counts.",
    },
}

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

KEY_TABLES = {
    "asset",
    "vassetlocation",
    "assetattribute",
    "job",
    "jobasset",
    "inspection",
    "photo",
    "capitalwork",
}


@dataclass(frozen=True)
class AssetTypeMap:
    standardised_asset_type_name: str
    asset_subcategory: str
    asset_category: str
    mapping_method: str
    manual_review_notes: str = ""


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
        "disposition": "INLINE",
        "format": "JSON_ARRAY",
    }
    with tempfile.NamedTemporaryFile("w", suffix=".json", encoding="utf-8", delete=False) as handle:
        json.dump(payload, handle)
        payload_path = handle.name
    try:
        response = run_cli(
            [
                "api",
                "post",
                "/api/2.0/sql/statements",
                "--profile",
                PROFILE,
                "--json",
                f"@{payload_path}",
                "-o",
                "json",
            ]
        )
    finally:
        Path(payload_path).unlink(missing_ok=True)
    statement_id = response.get("statement_id")
    state = response.get("status", {}).get("state")
    while state in {"PENDING", "RUNNING"}:
        if not statement_id:
            raise RuntimeError(f"Statement did not return an id: {response}")
        time.sleep(3)
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


def parse_mapping() -> dict[str, AssetTypeMap]:
    text = MAPPING_SQL.read_text(encoding="utf-8")
    mapping: dict[str, AssetTypeMap] = {}
    pattern = re.compile(
        r"\('((?:''|[^'])*)',\s*'((?:''|[^'])*)',\s*'((?:''|[^'])*)',\s*'((?:''|[^'])*)'\)"
    )
    for raw, standard, subcategory, category in pattern.findall(text):
        raw_value = raw.replace("''", "'")
        mapping[raw_value.strip().lower()] = AssetTypeMap(
            standardised_asset_type_name=standard.replace("''", "'"),
            asset_subcategory=subcategory.replace("''", "'"),
            asset_category=category.replace("''", "'"),
            mapping_method="manual_asset_type_mapping_v5",
        )
    return mapping


def lookup_mapping(mapping: dict[str, AssetTypeMap], raw_asset_type: str) -> AssetTypeMap:
    key = (raw_asset_type or "Unspecified asset type").strip().lower()
    found = mapping.get(key)
    if found:
        return found
    raw = raw_asset_type or "Unspecified asset type"
    return AssetTypeMap(
        standardised_asset_type_name=raw,
        asset_subcategory="Other / Unclassified",
        asset_category="Other / Unclassified",
        mapping_method="auto_source_asset_type_other_v1",
        manual_review_notes="Fallback row for live source AssetType not yet manually classified.",
    )


def qident(name: str) -> str:
    return "`" + name.replace("`", "``") + "`"


def empty_cte(columns: list[tuple[str, str]]) -> str:
    rendered = ", ".join(f"CAST(NULL AS {dtype}) AS {name}" for name, dtype in columns)
    return f"SELECT {rendered} WHERE false"


def discover_tables(catalog: str) -> set[str]:
    values = ", ".join(f"'{t}'" for t in sorted(KEY_TABLES))
    sql = f"""
SELECT lower(table_name) AS table_name
FROM {qident(catalog)}.information_schema.tables
WHERE table_schema = 'dbo'
  AND lower(table_name) IN ({values})
ORDER BY lower(table_name)
"""
    rows = execute_statement(sql)
    return {str(row["table_name"]).lower() for row in rows}


def cte_for_source(source_context: str, catalog: str, tables: set[str]) -> str:
    asset_table = f"{qident(catalog)}.dbo.asset"
    if "vassetlocation" in tables:
        loc_by_asset = f"""
SELECT
  CAST(AssetID AS STRING) AS asset_id,
  COUNT(*) AS location_rows,
  MAX(CASE WHEN WKT IS NOT NULL AND TRIM(CAST(WKT AS STRING)) <> '' THEN 1 ELSE 0 END) AS has_wkt,
  MAX(CASE
    WHEN CAST(regexp_extract(WKT, '(-?\\\\d+(?:\\\\.\\\\d+)?)\\\\s+(-?\\\\d+(?:\\\\.\\\\d+)?)', 1) AS DOUBLE) BETWEEN 112 AND 180
     AND CAST(regexp_extract(WKT, '(-?\\\\d+(?:\\\\.\\\\d+)?)\\\\s+(-?\\\\d+(?:\\\\.\\\\d+)?)', 2) AS DOUBLE) BETWEEN -48 AND -9
    THEN 1 ELSE 0 END) AS has_valid_au_coord,
  concat_ws('; ', sort_array(collect_set(NULLIF(upper(regexp_extract(TRIM(CAST(WKT AS STRING)), '^([A-Za-z]+)', 1)), '')))) AS wkt_geometry_types
FROM {qident(catalog)}.dbo.vassetlocation
WHERE COALESCE(Deleted, false) = false
GROUP BY CAST(AssetID AS STRING)
"""
    else:
        loc_by_asset = empty_cte(
            [
                ("asset_id", "STRING"),
                ("location_rows", "BIGINT"),
                ("has_wkt", "INT"),
                ("has_valid_au_coord", "INT"),
                ("wkt_geometry_types", "STRING"),
            ]
        )

    if "assetattribute" in tables:
        assetattribute = f"""
SELECT
  CAST(AssetID AS STRING) AS asset_id,
  NULLIF(TRIM(CAST(Name AS STRING)), '') AS attribute_name,
  NULLIF(TRIM(CAST(Value AS STRING)), '') AS attribute_value
FROM {qident(catalog)}.dbo.assetattribute
WHERE COALESCE(Deleted, false) = false
"""
    else:
        assetattribute = empty_cte(
            [
                ("asset_id", "STRING"),
                ("attribute_name", "STRING"),
                ("attribute_value", "STRING"),
            ]
        )

    if "job" in tables:
        job_base = f"""
SELECT
  CAST(ID AS STRING) AS job_id,
  CAST(AssetID AS STRING) AS asset_id,
  CAST(DueDate AS TIMESTAMP) AS due_date,
  CAST(CompletedDate AS TIMESTAMP) AS completed_date,
  NULLIF(TRIM(CAST(HazardDefectCode AS STRING)), '') AS hazard_defect_code,
  NULLIF(TRIM(CAST(ActivityCategoryName AS STRING)), '') AS activity_category_name,
  NULLIF(TRIM(CAST(ActivityName AS STRING)), '') AS activity_name,
  NULLIF(TRIM(CAST(InterventionCode AS STRING)), '') AS intervention_code,
  CAST(EstimatedQuantity AS DOUBLE) AS estimated_quantity,
  NULLIF(TRIM(CAST(Priority AS STRING)), '') AS priority,
  NULLIF(TRIM(CAST(ActivityType AS STRING)), '') AS activity_type,
  NULLIF(TRIM(CAST(Compliant AS STRING)), '') AS compliant,
  CAST(RemainingQuantity AS DOUBLE) AS remaining_quantity,
  CAST(ActualQuantity AS DOUBLE) AS actual_quantity,
  NULLIF(TRIM(CAST(InspectionTypeName AS STRING)), '') AS inspection_type_name,
  CAST(EstimatedLength AS DOUBLE) AS estimated_length,
  CAST(EstimatedWidth AS DOUBLE) AS estimated_width,
  CAST(EstimatedDepth AS DOUBLE) AS estimated_depth
FROM {qident(catalog)}.dbo.job
WHERE COALESCE(Deleted, false) = false
"""
    else:
        job_base = empty_cte(
            [
                ("job_id", "STRING"),
                ("asset_id", "STRING"),
                ("due_date", "TIMESTAMP"),
                ("completed_date", "TIMESTAMP"),
                ("hazard_defect_code", "STRING"),
                ("activity_category_name", "STRING"),
                ("activity_name", "STRING"),
                ("intervention_code", "STRING"),
                ("estimated_quantity", "DOUBLE"),
                ("priority", "STRING"),
                ("activity_type", "STRING"),
                ("compliant", "STRING"),
                ("remaining_quantity", "DOUBLE"),
                ("actual_quantity", "DOUBLE"),
                ("inspection_type_name", "STRING"),
                ("estimated_length", "DOUBLE"),
                ("estimated_width", "DOUBLE"),
                ("estimated_depth", "DOUBLE"),
            ]
        )

    if "jobasset" in tables:
        jobasset_base = f"""
SELECT
  CAST(JobID AS STRING) AS job_id,
  CAST(AssetID AS STRING) AS asset_id
FROM {qident(catalog)}.dbo.jobasset
WHERE COALESCE(Deleted, false) = false
"""
    else:
        jobasset_base = empty_cte([("job_id", "STRING"), ("asset_id", "STRING")])

    if "inspection" in tables:
        inspection_base = f"""
SELECT
  CAST(ID AS STRING) AS inspection_id,
  CAST(AssetID AS STRING) AS asset_id,
  CAST(COALESCE(ScheduledDateTo, ScheduledDate) AS TIMESTAMP) AS due_date,
  CAST(CompletedDate AS TIMESTAMP) AS completed_date
FROM {qident(catalog)}.dbo.inspection
WHERE COALESCE(Deleted, false) = false
"""
    else:
        inspection_base = empty_cte(
            [
                ("inspection_id", "STRING"),
                ("asset_id", "STRING"),
                ("due_date", "TIMESTAMP"),
                ("completed_date", "TIMESTAMP"),
            ]
        )

    if "capitalwork" in tables:
        capitalwork_base = f"""
SELECT
  CAST(ID AS STRING) AS capitalwork_id,
  CAST(AssetID AS STRING) AS asset_id,
  CAST(PlannedStart AS TIMESTAMP) AS planned_start,
  CAST(ActualFinish AS TIMESTAMP) AS actual_finish
FROM {qident(catalog)}.dbo.capitalwork
WHERE COALESCE(Deleted, false) = false
"""
    else:
        capitalwork_base = empty_cte(
            [
                ("capitalwork_id", "STRING"),
                ("asset_id", "STRING"),
                ("planned_start", "TIMESTAMP"),
                ("actual_finish", "TIMESTAMP"),
            ]
        )

    if "photo" in tables:
        photo_base = f"""
SELECT
  CAST(ID AS STRING) AS photo_id,
  lower(TRIM(CAST(SourceTable AS STRING))) AS source_table,
  CAST(SourceTableID AS STRING) AS source_table_id
FROM {qident(catalog)}.dbo.photo
WHERE COALESCE(Deleted, false) = false
"""
    else:
        photo_base = empty_cte(
            [
                ("photo_id", "STRING"),
                ("source_table", "STRING"),
                ("source_table_id", "STRING"),
            ]
        )

    return f"""
WITH asset_base AS (
  SELECT
    '{source_context}' AS source_context,
    CAST(ID AS STRING) AS asset_id,
    COALESCE(NULLIF(TRIM(CAST(Contract AS STRING)), ''), '{source_context}') AS contract,
    COALESCE(NULLIF(TRIM(CAST(AssetType AS STRING)), ''), 'Unspecified asset type') AS raw_asset_type,
    NULLIF(TRIM(CAST(Classification AS STRING)), '') AS classification,
    NULLIF(TRIM(CAST(SpatialType AS STRING)), '') AS spatial_type,
    NULLIF(TRIM(CAST(AssetCondition AS STRING)), '') AS asset_condition,
    NULLIF(TRIM(CAST(AssetCriticality AS STRING)), '') AS asset_criticality,
    NULLIF(TRIM(CAST(AssetRisk AS STRING)), '') AS asset_risk,
    CAST(ChainageFrom AS DOUBLE) AS chainage_from,
    CAST(ChainageTo AS DOUBLE) AS chainage_to,
    CAST(ParentAssetID AS STRING) AS parent_asset_id,
    NULLIF(TRIM(CAST(Stage AS STRING)), '') AS stage,
    CAST(ConstructionDate AS TIMESTAMP) AS construction_date,
    CAST(ConstructionCost AS DOUBLE) AS construction_cost,
    CAST(UsefulLife AS DOUBLE) AS useful_life,
    CAST(ConditionDate AS TIMESTAMP) AS condition_date
  FROM {asset_table}
  WHERE COALESCE(Deleted, false) = false
),
loc_by_asset AS (
  {loc_by_asset}
),
assetattribute AS (
  {assetattribute}
),
job_base AS (
  {job_base}
),
jobasset_base AS (
  {jobasset_base}
),
job_link AS (
  SELECT
    job_id,
    asset_id,
    due_date,
    completed_date,
    hazard_defect_code,
    activity_category_name,
    activity_name,
    intervention_code,
    estimated_quantity,
    priority,
    activity_type,
    compliant,
    remaining_quantity,
    actual_quantity,
    inspection_type_name,
    estimated_length,
    estimated_width,
    estimated_depth
  FROM job_base
  WHERE asset_id IS NOT NULL
  UNION
  SELECT
    ja.job_id,
    ja.asset_id,
    j.due_date,
    j.completed_date,
    j.hazard_defect_code,
    j.activity_category_name,
    j.activity_name,
    j.intervention_code,
    j.estimated_quantity,
    j.priority,
    j.activity_type,
    j.compliant,
    j.remaining_quantity,
    j.actual_quantity,
    j.inspection_type_name,
    j.estimated_length,
    j.estimated_width,
    j.estimated_depth
  FROM jobasset_base ja
  LEFT JOIN job_base j
    ON j.job_id = ja.job_id
  WHERE ja.asset_id IS NOT NULL
),
inspection_base AS (
  {inspection_base}
),
capitalwork_base AS (
  {capitalwork_base}
),
photo_base AS (
  {photo_base}
),
asset_rollup AS (
  SELECT
    source_context,
    contract,
    raw_asset_type,
    COUNT(DISTINCT asset_id) AS asset_count,
    SUM(CASE WHEN classification IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_classification,
    COUNT(DISTINCT classification) AS distinct_classifications,
    concat_ws('; ', sort_array(collect_set(classification))) AS classification_examples,
    concat_ws('; ', sort_array(collect_set(spatial_type))) AS spatial_type_examples,
    SUM(CASE WHEN asset_condition IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_condition,
    SUM(CASE WHEN asset_criticality IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_criticality,
    SUM(CASE WHEN asset_risk IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_risk,
    SUM(CASE WHEN chainage_from IS NOT NULL OR chainage_to IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_chainage,
    SUM(CASE WHEN parent_asset_id IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_parent_asset,
    SUM(CASE WHEN stage IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_stage,
    SUM(CASE WHEN construction_date IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_construction_date,
    SUM(CASE WHEN construction_cost IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_construction_cost,
    SUM(CASE WHEN useful_life IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_useful_life,
    SUM(CASE WHEN condition_date IS NOT NULL THEN 1 ELSE 0 END) AS assets_with_condition_date,
    ROUND(SUM(CASE
      WHEN chainage_from IS NOT NULL
       AND chainage_to IS NOT NULL
       AND ABS(chainage_to - chainage_from) > 0
       AND ABS(chainage_to - chainage_from) < 1000000
      THEN ABS(chainage_to - chainage_from) / 1000.0 ELSE 0 END), 3) AS chainage_length_km_proxy
  FROM asset_base
  GROUP BY source_context, contract, raw_asset_type
),
location_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    SUM(CASE WHEN COALESCE(l.location_rows, 0) > 0 THEN 1 ELSE 0 END) AS assets_with_location_row,
    SUM(CASE WHEN COALESCE(l.has_wkt, 0) > 0 THEN 1 ELSE 0 END) AS assets_with_wkt,
    SUM(CASE WHEN COALESCE(l.has_valid_au_coord, 0) > 0 THEN 1 ELSE 0 END) AS assets_with_valid_au_coord,
    SUM(COALESCE(l.location_rows, 0)) AS location_rows,
    concat_ws('; ', sort_array(collect_set(l.wkt_geometry_types))) AS wkt_geometry_types
  FROM asset_base a
  LEFT JOIN loc_by_asset l
    ON l.asset_id = a.asset_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
attribute_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    COUNT(aa.attribute_name) AS attribute_rows,
    COUNT(DISTINCT aa.attribute_name) AS distinct_attribute_names,
    COUNT(DISTINCT CASE WHEN aa.attribute_name IS NOT NULL THEN a.asset_id END) AS assets_with_attributes,
    concat_ws('; ', sort_array(collect_set(aa.attribute_name))) AS attribute_name_examples
  FROM asset_base a
  LEFT JOIN assetattribute aa
    ON aa.asset_id = a.asset_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
job_asset_slice AS (
  SELECT DISTINCT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    a.asset_id,
    jl.job_id
  FROM asset_base a
  LEFT JOIN job_link jl
    ON jl.asset_id = a.asset_id
  WHERE jl.job_id IS NOT NULL
),
job_detail_slice AS (
  SELECT DISTINCT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    jl.job_id,
    jl.due_date,
    jl.completed_date,
    jl.hazard_defect_code,
    jl.activity_category_name,
    jl.activity_name,
    jl.intervention_code,
    jl.estimated_quantity,
    jl.priority,
    jl.activity_type,
    jl.compliant,
    jl.remaining_quantity,
    jl.actual_quantity,
    jl.inspection_type_name,
    jl.estimated_length,
    jl.estimated_width,
    jl.estimated_depth
  FROM asset_base a
  LEFT JOIN job_link jl
    ON jl.asset_id = a.asset_id
  WHERE jl.job_id IS NOT NULL
),
job_asset_rollup AS (
  SELECT
    source_context,
    contract,
    raw_asset_type,
    COUNT(DISTINCT asset_id) AS assets_with_job
  FROM job_asset_slice
  GROUP BY source_context, contract, raw_asset_type
),
job_detail_rollup AS (
  SELECT
    source_context,
    contract,
    raw_asset_type,
    COUNT(DISTINCT job_id) AS job_count,
    COUNT(DISTINCT CASE WHEN completed_date IS NOT NULL THEN job_id END) AS completed_job_count,
    COUNT(DISTINCT CASE WHEN completed_date IS NULL AND due_date < current_timestamp() THEN job_id END) AS overdue_open_job_count,
    concat_ws('; ', sort_array(collect_set(hazard_defect_code))) AS job_hazard_defect_codes,
    concat_ws('; ', sort_array(collect_set(activity_category_name))) AS job_activity_category_names,
    concat_ws('; ', sort_array(collect_set(activity_name))) AS job_activity_names,
    concat_ws('; ', sort_array(collect_set(intervention_code))) AS job_intervention_codes,
    concat_ws('; ', sort_array(collect_set(priority))) AS job_priorities,
    concat_ws('; ', sort_array(collect_set(activity_type))) AS job_activity_types,
    concat_ws('; ', sort_array(collect_set(compliant))) AS job_compliance_values,
    concat_ws('; ', sort_array(collect_set(inspection_type_name))) AS job_inspection_type_names,
    COUNT(DISTINCT CASE WHEN estimated_quantity IS NOT NULL THEN job_id END) AS jobs_with_estimated_quantity,
    ROUND(SUM(estimated_quantity), 3) AS job_estimated_quantity_total,
    COUNT(DISTINCT CASE WHEN actual_quantity IS NOT NULL THEN job_id END) AS jobs_with_actual_quantity,
    ROUND(SUM(actual_quantity), 3) AS job_actual_quantity_total,
    COUNT(DISTINCT CASE WHEN remaining_quantity IS NOT NULL THEN job_id END) AS jobs_with_remaining_quantity,
    ROUND(SUM(remaining_quantity), 3) AS job_remaining_quantity_total,
    COUNT(DISTINCT CASE WHEN estimated_length IS NOT NULL THEN job_id END) AS jobs_with_estimated_length,
    ROUND(SUM(estimated_length), 3) AS job_estimated_length_total,
    COUNT(DISTINCT CASE WHEN estimated_width IS NOT NULL THEN job_id END) AS jobs_with_estimated_width,
    ROUND(AVG(estimated_width), 3) AS job_estimated_width_avg,
    COUNT(DISTINCT CASE WHEN estimated_depth IS NOT NULL THEN job_id END) AS jobs_with_estimated_depth,
    ROUND(AVG(estimated_depth), 3) AS job_estimated_depth_avg
  FROM job_detail_slice
  GROUP BY source_context, contract, raw_asset_type
),
job_rollup AS (
  SELECT
    b.source_context,
    b.contract,
    b.raw_asset_type,
    COALESCE(jd.job_count, 0) AS job_count,
    COALESCE(ja.assets_with_job, 0) AS assets_with_job,
    COALESCE(jd.completed_job_count, 0) AS completed_job_count,
    COALESCE(jd.overdue_open_job_count, 0) AS overdue_open_job_count,
    jd.job_hazard_defect_codes,
    jd.job_activity_category_names,
    jd.job_activity_names,
    jd.job_intervention_codes,
    jd.job_priorities,
    jd.job_activity_types,
    jd.job_compliance_values,
    jd.job_inspection_type_names,
    COALESCE(jd.jobs_with_estimated_quantity, 0) AS jobs_with_estimated_quantity,
    COALESCE(jd.job_estimated_quantity_total, 0.0) AS job_estimated_quantity_total,
    COALESCE(jd.jobs_with_actual_quantity, 0) AS jobs_with_actual_quantity,
    COALESCE(jd.job_actual_quantity_total, 0.0) AS job_actual_quantity_total,
    COALESCE(jd.jobs_with_remaining_quantity, 0) AS jobs_with_remaining_quantity,
    COALESCE(jd.job_remaining_quantity_total, 0.0) AS job_remaining_quantity_total,
    COALESCE(jd.jobs_with_estimated_length, 0) AS jobs_with_estimated_length,
    COALESCE(jd.job_estimated_length_total, 0.0) AS job_estimated_length_total,
    COALESCE(jd.jobs_with_estimated_width, 0) AS jobs_with_estimated_width,
    jd.job_estimated_width_avg,
    COALESCE(jd.jobs_with_estimated_depth, 0) AS jobs_with_estimated_depth,
    jd.job_estimated_depth_avg
  FROM (SELECT DISTINCT source_context, contract, raw_asset_type FROM asset_base) b
  LEFT JOIN job_detail_rollup jd USING (source_context, contract, raw_asset_type)
  LEFT JOIN job_asset_rollup ja USING (source_context, contract, raw_asset_type)
),
inspection_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    COUNT(DISTINCT i.inspection_id) AS inspection_count,
    COUNT(DISTINCT CASE WHEN i.inspection_id IS NOT NULL THEN a.asset_id END) AS assets_with_inspection,
    COUNT(DISTINCT CASE WHEN i.completed_date IS NOT NULL THEN i.inspection_id END) AS completed_inspection_count,
    COUNT(DISTINCT CASE WHEN i.completed_date IS NULL AND i.due_date < current_timestamp() THEN i.inspection_id END) AS overdue_open_inspection_count
  FROM asset_base a
  LEFT JOIN inspection_base i
    ON i.asset_id = a.asset_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
capitalwork_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    COUNT(DISTINCT c.capitalwork_id) AS capitalwork_count,
    COUNT(DISTINCT CASE WHEN c.capitalwork_id IS NOT NULL THEN a.asset_id END) AS assets_with_capitalwork,
    COUNT(DISTINCT CASE WHEN c.actual_finish IS NOT NULL THEN c.capitalwork_id END) AS completed_capitalwork_count
  FROM asset_base a
  LEFT JOIN capitalwork_base c
    ON c.asset_id = a.asset_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
asset_photo_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    COUNT(DISTINCT p.photo_id) AS asset_photo_count,
    COUNT(DISTINCT CASE WHEN p.photo_id IS NOT NULL THEN a.asset_id END) AS assets_with_asset_photo
  FROM asset_base a
  LEFT JOIN photo_base p
    ON p.source_table = 'asset'
   AND p.source_table_id = a.asset_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
),
job_photo_rollup AS (
  SELECT
    a.source_context,
    a.contract,
    a.raw_asset_type,
    COUNT(DISTINCT p.photo_id) AS job_photo_count,
    COUNT(DISTINCT CASE WHEN p.photo_id IS NOT NULL THEN a.asset_id END) AS assets_with_job_photo
  FROM asset_base a
  LEFT JOIN job_link jl
    ON jl.asset_id = a.asset_id
  LEFT JOIN photo_base p
    ON p.source_table = 'job'
   AND p.source_table_id = jl.job_id
  GROUP BY a.source_context, a.contract, a.raw_asset_type
)
SELECT
  ar.*,
  lr.assets_with_location_row,
  lr.assets_with_wkt,
  lr.assets_with_valid_au_coord,
  lr.location_rows,
  lr.wkt_geometry_types,
  atr.attribute_rows,
  atr.distinct_attribute_names,
  atr.assets_with_attributes,
  atr.attribute_name_examples,
  jr.job_count,
  jr.assets_with_job,
  jr.completed_job_count,
  jr.overdue_open_job_count,
  jr.job_hazard_defect_codes,
  jr.job_activity_category_names,
  jr.job_activity_names,
  jr.job_intervention_codes,
  jr.job_priorities,
  jr.job_activity_types,
  jr.job_compliance_values,
  jr.job_inspection_type_names,
  jr.jobs_with_estimated_quantity,
  jr.job_estimated_quantity_total,
  jr.jobs_with_actual_quantity,
  jr.job_actual_quantity_total,
  jr.jobs_with_remaining_quantity,
  jr.job_remaining_quantity_total,
  jr.jobs_with_estimated_length,
  jr.job_estimated_length_total,
  jr.jobs_with_estimated_width,
  jr.job_estimated_width_avg,
  jr.jobs_with_estimated_depth,
  jr.job_estimated_depth_avg,
  ir.inspection_count,
  ir.assets_with_inspection,
  ir.completed_inspection_count,
  ir.overdue_open_inspection_count,
  cr.capitalwork_count,
  cr.assets_with_capitalwork,
  cr.completed_capitalwork_count,
  apr.asset_photo_count,
  apr.assets_with_asset_photo,
  jpr.job_photo_count,
  jpr.assets_with_job_photo
FROM asset_rollup ar
LEFT JOIN location_rollup lr USING (source_context, contract, raw_asset_type)
LEFT JOIN attribute_rollup atr USING (source_context, contract, raw_asset_type)
LEFT JOIN job_rollup jr USING (source_context, contract, raw_asset_type)
LEFT JOIN inspection_rollup ir USING (source_context, contract, raw_asset_type)
LEFT JOIN capitalwork_rollup cr USING (source_context, contract, raw_asset_type)
LEFT JOIN asset_photo_rollup apr USING (source_context, contract, raw_asset_type)
LEFT JOIN job_photo_rollup jpr USING (source_context, contract, raw_asset_type)
ORDER BY ar.contract, ar.raw_asset_type
"""


def to_int(value: Any) -> int:
    if value in (None, ""):
        return 0
    return int(float(value))


def to_float(value: Any) -> float:
    if value in (None, ""):
        return 0.0
    return float(value)


def split_examples(value: Any) -> set[str]:
    if not value:
        return set()
    return {part.strip() for part in str(value).split(";") if part.strip()}


def pct(numerator: int | float, denominator: int | float) -> str:
    if not denominator:
        return "0.0%"
    return f"{100 * float(numerator) / float(denominator):.1f}%"


def pct_number(numerator: int | float, denominator: int | float) -> float:
    if not denominator:
        return 0.0
    return round(100 * float(numerator) / float(denominator), 4)


def ratio(numerator: int | float, denominator: int | float) -> str:
    if not denominator:
        return "0.00"
    return f"{float(numerator) / float(denominator):.2f}"


def ratio_number(numerator: int | float, denominator: int | float) -> float:
    if not denominator:
        return 0.0
    return round(float(numerator) / float(denominator), 6)


def md_escape(value: Any) -> str:
    text = "" if value is None else str(value)
    return text.replace("|", "\\|").replace("\n", " ").strip()


def as_backtick(value: str) -> str:
    return "`" + value.replace("`", "\\`") + "`"


def short_list(values: set[str], limit: int = 10) -> str:
    ordered = sorted(v for v in values if v)
    if not ordered:
        return ""
    clipped = ordered[:limit]
    suffix = f"; +{len(ordered) - limit} more" if len(ordered) > limit else ""
    return "; ".join(clipped) + suffix


def add_set(target: set[str], raw_values: Any) -> None:
    target.update(split_examples(raw_values))


def aggregate(rows: list[dict[str, Any]], mapping: dict[str, AssetTypeMap]) -> list[dict[str, Any]]:
    groups: dict[str, dict[str, Any]] = {}
    for row in rows:
        raw_type = str(row.get("raw_asset_type") or "Unspecified asset type")
        mapped = lookup_mapping(mapping, raw_type)
        key = mapped.standardised_asset_type_name
        group = groups.setdefault(
            key,
            {
                "standardised_asset_type_name": key,
                "asset_category": mapped.asset_category,
                "asset_subcategory": mapped.asset_subcategory,
                "mapping_methods": set(),
                "manual_review_notes": set(),
                "raw_asset_types": set(),
                "source_contexts": set(),
                "source_labels": set(),
                "contracts": set(),
                "source_contract_breakdown": defaultdict(int),
                "classification_examples": set(),
                "spatial_type_examples": set(),
                "wkt_geometry_types": set(),
                "attribute_name_examples": set(),
                "detail_rows": [],
            },
        )
        group["mapping_methods"].add(mapped.mapping_method)
        if mapped.manual_review_notes:
            group["manual_review_notes"].add(mapped.manual_review_notes)
        group["raw_asset_types"].add(raw_type)
        group["source_contexts"].add(str(row.get("source_context") or ""))
        source_label = str(row.get("source_label") or row.get("source_context") or "")
        group["source_labels"].add(source_label)
        contract = str(row.get("contract") or "")
        group["contracts"].add(contract)
        group["source_contract_breakdown"][f"{source_label} / {contract}"] += to_int(row.get("asset_count"))
        add_set(group["classification_examples"], row.get("classification_examples"))
        add_set(group["spatial_type_examples"], row.get("spatial_type_examples"))
        add_set(group["wkt_geometry_types"], row.get("wkt_geometry_types"))
        add_set(group["attribute_name_examples"], row.get("attribute_name_examples"))
        group["detail_rows"].append(row)

        for field in [
            "asset_count",
            "assets_with_classification",
            "distinct_classifications",
            "assets_with_condition",
            "assets_with_criticality",
            "assets_with_risk",
            "assets_with_chainage",
            "assets_with_parent_asset",
            "assets_with_stage",
            "assets_with_construction_date",
            "assets_with_construction_cost",
            "assets_with_useful_life",
            "assets_with_condition_date",
            "assets_with_location_row",
            "assets_with_wkt",
            "assets_with_valid_au_coord",
            "location_rows",
            "attribute_rows",
            "distinct_attribute_names",
            "assets_with_attributes",
            "job_count",
            "assets_with_job",
            "completed_job_count",
            "overdue_open_job_count",
            "inspection_count",
            "assets_with_inspection",
            "completed_inspection_count",
            "overdue_open_inspection_count",
            "capitalwork_count",
            "assets_with_capitalwork",
            "completed_capitalwork_count",
            "asset_photo_count",
            "assets_with_asset_photo",
            "job_photo_count",
            "assets_with_job_photo",
        ]:
            group[field] = group.get(field, 0) + to_int(row.get(field))
        group["chainage_length_km_proxy"] = group.get("chainage_length_km_proxy", 0.0) + to_float(
            row.get("chainage_length_km_proxy")
        )

    output: list[dict[str, Any]] = []
    for group in groups.values():
        group["source_contract_breakdown"] = dict(
            sorted(group["source_contract_breakdown"].items(), key=lambda item: (-item[1], item[0]))
        )
        group["distinct_attribute_names"] = len(group["attribute_name_examples"])
        group["distinct_classifications"] = len(group["classification_examples"])
        group["detail_rows"] = sorted(
            group["detail_rows"],
            key=lambda r: (
                str(r.get("source_label") or ""),
                str(r.get("contract") or ""),
                str(r.get("raw_asset_type") or ""),
            ),
        )
        output.append(group)
    return sorted(
        output,
        key=lambda item: (
            item["asset_category"],
            item["asset_subcategory"],
            item["standardised_asset_type_name"],
        ),
    )


def write_csv(groups: list[dict[str, Any]], path: Path) -> None:
    fields = [
        "asset_category",
        "asset_subcategory",
        "standardised_asset_type_name",
        "asset_count",
        "raw_asset_types",
        "source_labels",
        "contracts",
        "assets_with_wkt_pct",
        "assets_with_valid_au_coord_pct",
        "assets_with_condition_pct",
        "assets_with_criticality_pct",
        "assets_with_risk_pct",
        "assets_with_chainage_pct",
        "assets_with_attributes_pct",
        "assets_with_job_pct",
        "assets_with_inspection_pct",
        "assets_with_asset_photo_pct",
        "chainage_length_km_proxy",
        "job_count",
        "inspection_count",
        "capitalwork_count",
        "attribute_rows",
        "distinct_attribute_names",
        "mapping_methods",
    ]
    with path.open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=fields)
        writer.writeheader()
        for group in groups:
            asset_count = group["asset_count"]
            writer.writerow(
                {
                    "asset_category": group["asset_category"],
                    "asset_subcategory": group["asset_subcategory"],
                    "standardised_asset_type_name": group["standardised_asset_type_name"],
                    "asset_count": asset_count,
                    "raw_asset_types": "; ".join(sorted(group["raw_asset_types"])),
                    "source_labels": "; ".join(sorted(group["source_labels"])),
                    "contracts": "; ".join(sorted(group["contracts"])),
                    "assets_with_wkt_pct": pct(group["assets_with_wkt"], asset_count),
                    "assets_with_valid_au_coord_pct": pct(group["assets_with_valid_au_coord"], asset_count),
                    "assets_with_condition_pct": pct(group["assets_with_condition"], asset_count),
                    "assets_with_criticality_pct": pct(group["assets_with_criticality"], asset_count),
                    "assets_with_risk_pct": pct(group["assets_with_risk"], asset_count),
                    "assets_with_chainage_pct": pct(group["assets_with_chainage"], asset_count),
                    "assets_with_attributes_pct": pct(group["assets_with_attributes"], asset_count),
                    "assets_with_job_pct": pct(group["assets_with_job"], asset_count),
                    "assets_with_inspection_pct": pct(group["assets_with_inspection"], asset_count),
                    "assets_with_asset_photo_pct": pct(group["assets_with_asset_photo"], asset_count),
                    "chainage_length_km_proxy": round(group["chainage_length_km_proxy"], 3),
                    "job_count": group["job_count"],
                    "inspection_count": group["inspection_count"],
                    "capitalwork_count": group["capitalwork_count"],
                    "attribute_rows": group["attribute_rows"],
                    "distinct_attribute_names": group["distinct_attribute_names"],
                    "mapping_methods": "; ".join(sorted(group["mapping_methods"])),
                }
            )


def metric_dictionary() -> list[tuple[str, str, str, str]]:
    return [
        (
            "Standardised asset type",
            "`analysis/deterioration-analysis/create_asset_type_category_map.sql`; raw `asset.AssetType`",
            "Manual mapping by raw `AssetType`; fallback keeps live raw value and marks it `Other / Unclassified`.",
            "Created classification layer. Review fallback rows before using as a final taxonomy.",
        ),
        (
            "Asset count",
            "`*.dbo.asset.ID`",
            "`COUNT(DISTINCT asset.ID)` where `COALESCE(asset.Deleted, false) = false`.",
            "Base denominator for most asset-type rates.",
        ),
        (
            "Source / contract coverage",
            "`asset.Contract`; source catalog label",
            "Distinct source contexts and contracts where the asset type is present.",
            "Blank source contract is replaced by source context to keep the grain explicit.",
        ),
        (
            "Classification coverage",
            "`asset.Classification`",
            "Assets with non-empty classification divided by asset count; distinct examples retained.",
            "Classification is source-populated, not the same as the manual standardised asset category.",
        ),
        (
            "Spatial type values",
            "`asset.SpatialType`",
            "Distinct non-empty source spatial type values by asset type.",
            "Useful because WKT geometry can differ by asset type and by source.",
        ),
        (
            "WKT coverage",
            "`vassetlocation.WKT` joined by `AssetID`",
            "Assets with at least one non-empty WKT divided by asset count.",
            "Generated metric. WKT lives in the view-style location table, not the base `asset` table.",
        ),
        (
            "Valid AU coordinate coverage",
            "`vassetlocation.WKT`",
            "Extract first numeric coordinate pair from WKT and count assets where lon is 112..180 and lat is -48..-9.",
            "Generated proxy for map-readiness; line/polygon assets use first coordinate only.",
        ),
        (
            "WKT geometry type",
            "`vassetlocation.WKT`",
            "Uppercase first token of WKT, such as `POINT`, `LINESTRING`, `POLYGON`, or `MULTIPOLYGON`.",
            "Generated parser; does not validate full geometry syntax.",
        ),
        (
            "Condition / criticality / risk coverage",
            "`asset.AssetCondition`, `asset.AssetCriticality`, `asset.AssetRisk`",
            "Assets with non-empty field divided by asset count.",
            "Source-populated attributes. Values are not harmonised in this run.",
        ),
        (
            "Chainage coverage",
            "`asset.ChainageFrom`, `asset.ChainageTo`",
            "Assets with either chainage endpoint populated divided by asset count.",
            "Source-populated linear-reference availability metric.",
        ),
        (
            "Chainage length km proxy",
            "`asset.ChainageFrom`, `asset.ChainageTo`",
            "`SUM(ABS(ChainageTo - ChainageFrom) / 1000)` where both endpoints exist, delta is positive, and delta is less than 1,000,000.",
            "Generated metric. Treat as a proxy because source units and route semantics can vary.",
        ),
        (
            "Parent asset coverage",
            "`asset.ParentAssetID`",
            "Assets with a parent asset ID divided by asset count.",
            "Source-populated hierarchy metric.",
        ),
        (
            "Lifecycle/commercial coverage",
            "`asset.ConstructionDate`, `asset.ConstructionCost`, `asset.UsefulLife`, `asset.ConditionDate`",
            "Assets with non-empty lifecycle/commercial fields divided by asset count.",
            "Source-populated; availability can vary sharply by asset type.",
        ),
        (
            "Custom attribute coverage",
            "`assetattribute.AssetID`, `assetattribute.Name`, `assetattribute.Value`",
            "Assets with at least one non-deleted attribute divided by asset count; counts rows and distinct attribute names.",
            "Source-populated custom attributes. Attribute semantics are not normalised here.",
        ),
        (
            "Job coverage",
            "`job.AssetID`, `jobasset.AssetID`, `job.ID`",
            "Assets linked to at least one job divided by asset count; job count is distinct linked jobs.",
            "Generated relationship metric; uses both direct job asset ID and many-to-many `jobasset` links. Counts are standardised from source-contract/raw-type slices.",
        ),
        (
            "Open overdue job count",
            "`job.DueDate`, `job.CompletedDate`",
            "Distinct linked jobs where `CompletedDate IS NULL AND DueDate < current_timestamp()`.",
            "Generated operational proxy, not a contract KPI.",
        ),
        (
            "Inspection coverage",
            "`inspection.AssetID`, `inspection.ID`",
            "Assets linked to at least one inspection divided by asset count; inspection count is distinct inspections.",
            "Generated relationship metric from the inspection table.",
        ),
        (
            "Open overdue inspection count",
            "`inspection.ScheduledDateTo`, `inspection.ScheduledDate`, `inspection.CompletedDate`",
            "Distinct linked inspections where open and scheduled due date is in the past.",
            "Generated proxy, not a contract-specific inspection KPI.",
        ),
        (
            "Capital work coverage",
            "`capitalwork.AssetID`, `capitalwork.ID`",
            "Assets linked to at least one capital work record divided by asset count.",
            "Generated relationship metric from source Asset Vision capital works.",
        ),
        (
            "Photo/evidence coverage",
            "`photo.SourceTable`, `photo.SourceTableID`",
            "Assets with direct asset photos plus assets whose linked jobs have job photos.",
            "Generated evidence proxy. Direct asset photos and job photos are reported separately.",
        ),
    ]


def sql_literal(value: Any) -> str:
    if value is None:
        return "NULL"
    if isinstance(value, bool):
        return "true" if value else "false"
    if isinstance(value, int):
        return str(value)
    if isinstance(value, float):
        if value != value:
            return "NULL"
        return repr(value)
    text = str(value).replace("\\", "\\\\").replace("'", "''").replace("\r", " ").replace("\n", " ")
    return f"'{text}'"


def qualified_table(table_name: str) -> str:
    return f"{qident(TARGET_CATALOG)}.{qident(TARGET_SCHEMA)}.{qident(table_name)}"


def create_delta_table(table_name: str, columns: list[tuple[str, str]]) -> None:
    column_sql = ",\n  ".join(f"{qident(name)} {dtype}" for name, dtype in columns)
    execute_statement(f"""
CREATE OR REPLACE TABLE {qualified_table(table_name)} (
  {column_sql}
)
USING DELTA
""")


def insert_rows(table_name: str, columns: list[tuple[str, str]], rows: list[dict[str, Any]], chunk_size: int = 25) -> None:
    if not rows:
        return
    column_names = [name for name, _ in columns]
    column_sql = ", ".join(qident(name) for name in column_names)
    for start in range(0, len(rows), chunk_size):
        chunk = rows[start : start + chunk_size]
        values_sql = ",\n".join(
            "(" + ", ".join(sql_literal(row.get(name)) for name in column_names) + ")"
            for row in chunk
        )
        execute_statement(f"""
INSERT INTO {qualified_table(table_name)} ({column_sql})
VALUES
{values_sql}
""")


def publish_table(table_name: str, columns: list[tuple[str, str]], rows: list[dict[str, Any]]) -> None:
    create_delta_table(table_name, columns)
    insert_rows(table_name, columns, rows)


def joined(values: set[str] | list[str] | tuple[str, ...], limit: int | None = None) -> str:
    ordered = sorted(v for v in values if v)
    if limit is not None:
        ordered = ordered[:limit]
    return "; ".join(ordered)


def prepare_summary_rows(groups: list[dict[str, Any]], generated_at: str) -> list[dict[str, Any]]:
    rows: list[dict[str, Any]] = []
    for group in groups:
        asset_count = group["asset_count"]
        rows.append(
            {
                "run_generated_at_utc": generated_at,
                "standardised_asset_type_name": group["standardised_asset_type_name"],
                "asset_category": group["asset_category"],
                "asset_subcategory": group["asset_subcategory"],
                "asset_count": asset_count,
                "raw_asset_type_count": len(group["raw_asset_types"]),
                "source_label_count": len(group["source_labels"]),
                "contract_count": len(group["contracts"]),
                "raw_asset_types": joined(group["raw_asset_types"]),
                "source_labels": joined(group["source_labels"]),
                "contracts": joined(group["contracts"]),
                "mapping_methods": joined(group["mapping_methods"]),
                "manual_review_notes": joined(group["manual_review_notes"]),
                "assets_with_classification": group["assets_with_classification"],
                "distinct_classifications": group["distinct_classifications"],
                "classification_examples": joined(group["classification_examples"], 50),
                "spatial_type_examples": joined(group["spatial_type_examples"], 50),
                "assets_with_condition": group["assets_with_condition"],
                "condition_coverage_pct": pct_number(group["assets_with_condition"], asset_count),
                "assets_with_criticality": group["assets_with_criticality"],
                "criticality_coverage_pct": pct_number(group["assets_with_criticality"], asset_count),
                "assets_with_risk": group["assets_with_risk"],
                "risk_coverage_pct": pct_number(group["assets_with_risk"], asset_count),
                "assets_with_chainage": group["assets_with_chainage"],
                "chainage_coverage_pct": pct_number(group["assets_with_chainage"], asset_count),
                "chainage_length_km_proxy": round(group["chainage_length_km_proxy"], 3),
                "assets_with_parent_asset": group["assets_with_parent_asset"],
                "parent_asset_coverage_pct": pct_number(group["assets_with_parent_asset"], asset_count),
                "assets_with_stage": group["assets_with_stage"],
                "stage_coverage_pct": pct_number(group["assets_with_stage"], asset_count),
                "assets_with_construction_date": group["assets_with_construction_date"],
                "construction_date_coverage_pct": pct_number(group["assets_with_construction_date"], asset_count),
                "assets_with_construction_cost": group["assets_with_construction_cost"],
                "construction_cost_coverage_pct": pct_number(group["assets_with_construction_cost"], asset_count),
                "assets_with_useful_life": group["assets_with_useful_life"],
                "useful_life_coverage_pct": pct_number(group["assets_with_useful_life"], asset_count),
                "assets_with_condition_date": group["assets_with_condition_date"],
                "condition_date_coverage_pct": pct_number(group["assets_with_condition_date"], asset_count),
                "assets_with_location_row": group["assets_with_location_row"],
                "location_row_coverage_pct": pct_number(group["assets_with_location_row"], asset_count),
                "assets_with_wkt": group["assets_with_wkt"],
                "wkt_coverage_pct": pct_number(group["assets_with_wkt"], asset_count),
                "assets_with_valid_au_coord": group["assets_with_valid_au_coord"],
                "valid_au_coord_coverage_pct": pct_number(group["assets_with_valid_au_coord"], asset_count),
                "location_rows": group["location_rows"],
                "wkt_geometry_types": joined(group["wkt_geometry_types"], 50),
                "attribute_rows": group["attribute_rows"],
                "distinct_attribute_names": group["distinct_attribute_names"],
                "assets_with_attributes": group["assets_with_attributes"],
                "custom_attribute_coverage_pct": pct_number(group["assets_with_attributes"], asset_count),
                "attribute_name_examples": joined(group["attribute_name_examples"], 100),
                "job_count": group["job_count"],
                "assets_with_job": group["assets_with_job"],
                "job_coverage_pct": pct_number(group["assets_with_job"], asset_count),
                "jobs_per_asset": ratio_number(group["job_count"], asset_count),
                "completed_job_count": group["completed_job_count"],
                "overdue_open_job_count": group["overdue_open_job_count"],
                "inspection_count": group["inspection_count"],
                "assets_with_inspection": group["assets_with_inspection"],
                "inspection_coverage_pct": pct_number(group["assets_with_inspection"], asset_count),
                "inspections_per_asset": ratio_number(group["inspection_count"], asset_count),
                "completed_inspection_count": group["completed_inspection_count"],
                "overdue_open_inspection_count": group["overdue_open_inspection_count"],
                "capitalwork_count": group["capitalwork_count"],
                "assets_with_capitalwork": group["assets_with_capitalwork"],
                "capitalwork_coverage_pct": pct_number(group["assets_with_capitalwork"], asset_count),
                "completed_capitalwork_count": group["completed_capitalwork_count"],
                "asset_photo_count": group["asset_photo_count"],
                "assets_with_asset_photo": group["assets_with_asset_photo"],
                "asset_photo_coverage_pct": pct_number(group["assets_with_asset_photo"], asset_count),
                "job_photo_count": group["job_photo_count"],
                "assets_with_job_photo": group["assets_with_job_photo"],
                "job_photo_asset_coverage_pct": pct_number(group["assets_with_job_photo"], asset_count),
                "total_photo_count": group["asset_photo_count"] + group["job_photo_count"],
            }
        )
    return rows


SUMMARY_COLUMNS = [
    ("run_generated_at_utc", "STRING"),
    ("standardised_asset_type_name", "STRING"),
    ("asset_category", "STRING"),
    ("asset_subcategory", "STRING"),
    ("asset_count", "BIGINT"),
    ("raw_asset_type_count", "BIGINT"),
    ("source_label_count", "BIGINT"),
    ("contract_count", "BIGINT"),
    ("raw_asset_types", "STRING"),
    ("source_labels", "STRING"),
    ("contracts", "STRING"),
    ("mapping_methods", "STRING"),
    ("manual_review_notes", "STRING"),
    ("assets_with_classification", "BIGINT"),
    ("distinct_classifications", "BIGINT"),
    ("classification_examples", "STRING"),
    ("spatial_type_examples", "STRING"),
    ("assets_with_condition", "BIGINT"),
    ("condition_coverage_pct", "DOUBLE"),
    ("assets_with_criticality", "BIGINT"),
    ("criticality_coverage_pct", "DOUBLE"),
    ("assets_with_risk", "BIGINT"),
    ("risk_coverage_pct", "DOUBLE"),
    ("assets_with_chainage", "BIGINT"),
    ("chainage_coverage_pct", "DOUBLE"),
    ("chainage_length_km_proxy", "DOUBLE"),
    ("assets_with_parent_asset", "BIGINT"),
    ("parent_asset_coverage_pct", "DOUBLE"),
    ("assets_with_stage", "BIGINT"),
    ("stage_coverage_pct", "DOUBLE"),
    ("assets_with_construction_date", "BIGINT"),
    ("construction_date_coverage_pct", "DOUBLE"),
    ("assets_with_construction_cost", "BIGINT"),
    ("construction_cost_coverage_pct", "DOUBLE"),
    ("assets_with_useful_life", "BIGINT"),
    ("useful_life_coverage_pct", "DOUBLE"),
    ("assets_with_condition_date", "BIGINT"),
    ("condition_date_coverage_pct", "DOUBLE"),
    ("assets_with_location_row", "BIGINT"),
    ("location_row_coverage_pct", "DOUBLE"),
    ("assets_with_wkt", "BIGINT"),
    ("wkt_coverage_pct", "DOUBLE"),
    ("assets_with_valid_au_coord", "BIGINT"),
    ("valid_au_coord_coverage_pct", "DOUBLE"),
    ("location_rows", "BIGINT"),
    ("wkt_geometry_types", "STRING"),
    ("attribute_rows", "BIGINT"),
    ("distinct_attribute_names", "BIGINT"),
    ("assets_with_attributes", "BIGINT"),
    ("custom_attribute_coverage_pct", "DOUBLE"),
    ("attribute_name_examples", "STRING"),
    ("job_count", "BIGINT"),
    ("assets_with_job", "BIGINT"),
    ("job_coverage_pct", "DOUBLE"),
    ("jobs_per_asset", "DOUBLE"),
    ("completed_job_count", "BIGINT"),
    ("overdue_open_job_count", "BIGINT"),
    ("inspection_count", "BIGINT"),
    ("assets_with_inspection", "BIGINT"),
    ("inspection_coverage_pct", "DOUBLE"),
    ("inspections_per_asset", "DOUBLE"),
    ("completed_inspection_count", "BIGINT"),
    ("overdue_open_inspection_count", "BIGINT"),
    ("capitalwork_count", "BIGINT"),
    ("assets_with_capitalwork", "BIGINT"),
    ("capitalwork_coverage_pct", "DOUBLE"),
    ("completed_capitalwork_count", "BIGINT"),
    ("asset_photo_count", "BIGINT"),
    ("assets_with_asset_photo", "BIGINT"),
    ("asset_photo_coverage_pct", "DOUBLE"),
    ("job_photo_count", "BIGINT"),
    ("assets_with_job_photo", "BIGINT"),
    ("job_photo_asset_coverage_pct", "DOUBLE"),
    ("total_photo_count", "BIGINT"),
]


def prepare_detail_rows(detail_rows: list[dict[str, Any]], mapping: dict[str, AssetTypeMap], generated_at: str) -> list[dict[str, Any]]:
    rows: list[dict[str, Any]] = []
    for row in detail_rows:
        raw_type = str(row.get("raw_asset_type") or "Unspecified asset type")
        mapped = lookup_mapping(mapping, raw_type)
        asset_count = to_int(row.get("asset_count"))
        out = {
            "run_generated_at_utc": generated_at,
            "source_context": row.get("source_context"),
            "source_catalog": row.get("source_catalog"),
            "source_label": row.get("source_label"),
            "contract": row.get("contract"),
            "raw_asset_type": raw_type,
            "standardised_asset_type_name": mapped.standardised_asset_type_name,
            "asset_category": mapped.asset_category,
            "asset_subcategory": mapped.asset_subcategory,
            "mapping_method": mapped.mapping_method,
            "manual_review_notes": mapped.manual_review_notes,
            "available_tables": "; ".join(row.get("available_tables") or []),
            "asset_count": asset_count,
            "assets_with_classification": to_int(row.get("assets_with_classification")),
            "distinct_classifications": to_int(row.get("distinct_classifications")),
            "classification_examples": row.get("classification_examples"),
            "spatial_type_examples": row.get("spatial_type_examples"),
            "assets_with_condition": to_int(row.get("assets_with_condition")),
            "condition_coverage_pct": pct_number(to_int(row.get("assets_with_condition")), asset_count),
            "assets_with_criticality": to_int(row.get("assets_with_criticality")),
            "criticality_coverage_pct": pct_number(to_int(row.get("assets_with_criticality")), asset_count),
            "assets_with_risk": to_int(row.get("assets_with_risk")),
            "risk_coverage_pct": pct_number(to_int(row.get("assets_with_risk")), asset_count),
            "assets_with_chainage": to_int(row.get("assets_with_chainage")),
            "chainage_coverage_pct": pct_number(to_int(row.get("assets_with_chainage")), asset_count),
            "chainage_length_km_proxy": round(to_float(row.get("chainage_length_km_proxy")), 3),
            "assets_with_parent_asset": to_int(row.get("assets_with_parent_asset")),
            "parent_asset_coverage_pct": pct_number(to_int(row.get("assets_with_parent_asset")), asset_count),
            "assets_with_stage": to_int(row.get("assets_with_stage")),
            "stage_coverage_pct": pct_number(to_int(row.get("assets_with_stage")), asset_count),
            "assets_with_construction_date": to_int(row.get("assets_with_construction_date")),
            "construction_date_coverage_pct": pct_number(to_int(row.get("assets_with_construction_date")), asset_count),
            "assets_with_construction_cost": to_int(row.get("assets_with_construction_cost")),
            "construction_cost_coverage_pct": pct_number(to_int(row.get("assets_with_construction_cost")), asset_count),
            "assets_with_useful_life": to_int(row.get("assets_with_useful_life")),
            "useful_life_coverage_pct": pct_number(to_int(row.get("assets_with_useful_life")), asset_count),
            "assets_with_condition_date": to_int(row.get("assets_with_condition_date")),
            "condition_date_coverage_pct": pct_number(to_int(row.get("assets_with_condition_date")), asset_count),
            "assets_with_location_row": to_int(row.get("assets_with_location_row")),
            "location_row_coverage_pct": pct_number(to_int(row.get("assets_with_location_row")), asset_count),
            "assets_with_wkt": to_int(row.get("assets_with_wkt")),
            "wkt_coverage_pct": pct_number(to_int(row.get("assets_with_wkt")), asset_count),
            "assets_with_valid_au_coord": to_int(row.get("assets_with_valid_au_coord")),
            "valid_au_coord_coverage_pct": pct_number(to_int(row.get("assets_with_valid_au_coord")), asset_count),
            "location_rows": to_int(row.get("location_rows")),
            "wkt_geometry_types": row.get("wkt_geometry_types"),
            "attribute_rows": to_int(row.get("attribute_rows")),
            "distinct_attribute_names": to_int(row.get("distinct_attribute_names")),
            "assets_with_attributes": to_int(row.get("assets_with_attributes")),
            "custom_attribute_coverage_pct": pct_number(to_int(row.get("assets_with_attributes")), asset_count),
            "attribute_name_examples": row.get("attribute_name_examples"),
            "job_count": to_int(row.get("job_count")),
            "assets_with_job": to_int(row.get("assets_with_job")),
            "job_coverage_pct": pct_number(to_int(row.get("assets_with_job")), asset_count),
            "jobs_per_asset": ratio_number(to_int(row.get("job_count")), asset_count),
            "completed_job_count": to_int(row.get("completed_job_count")),
            "overdue_open_job_count": to_int(row.get("overdue_open_job_count")),
            "job_hazard_defect_codes": row.get("job_hazard_defect_codes"),
            "job_activity_category_names": row.get("job_activity_category_names"),
            "job_activity_names": row.get("job_activity_names"),
            "job_intervention_codes": row.get("job_intervention_codes"),
            "job_priorities": row.get("job_priorities"),
            "job_activity_types": row.get("job_activity_types"),
            "job_compliance_values": row.get("job_compliance_values"),
            "job_inspection_type_names": row.get("job_inspection_type_names"),
            "jobs_with_estimated_quantity": to_int(row.get("jobs_with_estimated_quantity")),
            "job_estimated_quantity_total": round(to_float(row.get("job_estimated_quantity_total")), 3),
            "jobs_with_actual_quantity": to_int(row.get("jobs_with_actual_quantity")),
            "job_actual_quantity_total": round(to_float(row.get("job_actual_quantity_total")), 3),
            "jobs_with_remaining_quantity": to_int(row.get("jobs_with_remaining_quantity")),
            "job_remaining_quantity_total": round(to_float(row.get("job_remaining_quantity_total")), 3),
            "jobs_with_estimated_length": to_int(row.get("jobs_with_estimated_length")),
            "job_estimated_length_total": round(to_float(row.get("job_estimated_length_total")), 3),
            "jobs_with_estimated_width": to_int(row.get("jobs_with_estimated_width")),
            "job_estimated_width_avg": round(to_float(row.get("job_estimated_width_avg")), 3),
            "jobs_with_estimated_depth": to_int(row.get("jobs_with_estimated_depth")),
            "job_estimated_depth_avg": round(to_float(row.get("job_estimated_depth_avg")), 3),
            "inspection_count": to_int(row.get("inspection_count")),
            "assets_with_inspection": to_int(row.get("assets_with_inspection")),
            "inspection_coverage_pct": pct_number(to_int(row.get("assets_with_inspection")), asset_count),
            "inspections_per_asset": ratio_number(to_int(row.get("inspection_count")), asset_count),
            "completed_inspection_count": to_int(row.get("completed_inspection_count")),
            "overdue_open_inspection_count": to_int(row.get("overdue_open_inspection_count")),
            "capitalwork_count": to_int(row.get("capitalwork_count")),
            "assets_with_capitalwork": to_int(row.get("assets_with_capitalwork")),
            "capitalwork_coverage_pct": pct_number(to_int(row.get("assets_with_capitalwork")), asset_count),
            "completed_capitalwork_count": to_int(row.get("completed_capitalwork_count")),
            "asset_photo_count": to_int(row.get("asset_photo_count")),
            "assets_with_asset_photo": to_int(row.get("assets_with_asset_photo")),
            "asset_photo_coverage_pct": pct_number(to_int(row.get("assets_with_asset_photo")), asset_count),
            "job_photo_count": to_int(row.get("job_photo_count")),
            "assets_with_job_photo": to_int(row.get("assets_with_job_photo")),
            "job_photo_asset_coverage_pct": pct_number(to_int(row.get("assets_with_job_photo")), asset_count),
            "total_photo_count": to_int(row.get("asset_photo_count")) + to_int(row.get("job_photo_count")),
        }
        rows.append(out)
    return rows


DETAIL_COLUMNS = [
    ("run_generated_at_utc", "STRING"),
    ("source_context", "STRING"),
    ("source_catalog", "STRING"),
    ("source_label", "STRING"),
    ("contract", "STRING"),
    ("raw_asset_type", "STRING"),
    ("standardised_asset_type_name", "STRING"),
    ("asset_category", "STRING"),
    ("asset_subcategory", "STRING"),
    ("mapping_method", "STRING"),
    ("manual_review_notes", "STRING"),
    ("available_tables", "STRING"),
    ("asset_count", "BIGINT"),
    ("assets_with_classification", "BIGINT"),
    ("distinct_classifications", "BIGINT"),
    ("classification_examples", "STRING"),
    ("spatial_type_examples", "STRING"),
    ("assets_with_condition", "BIGINT"),
    ("condition_coverage_pct", "DOUBLE"),
    ("assets_with_criticality", "BIGINT"),
    ("criticality_coverage_pct", "DOUBLE"),
    ("assets_with_risk", "BIGINT"),
    ("risk_coverage_pct", "DOUBLE"),
    ("assets_with_chainage", "BIGINT"),
    ("chainage_coverage_pct", "DOUBLE"),
    ("chainage_length_km_proxy", "DOUBLE"),
    ("assets_with_parent_asset", "BIGINT"),
    ("parent_asset_coverage_pct", "DOUBLE"),
    ("assets_with_stage", "BIGINT"),
    ("stage_coverage_pct", "DOUBLE"),
    ("assets_with_construction_date", "BIGINT"),
    ("construction_date_coverage_pct", "DOUBLE"),
    ("assets_with_construction_cost", "BIGINT"),
    ("construction_cost_coverage_pct", "DOUBLE"),
    ("assets_with_useful_life", "BIGINT"),
    ("useful_life_coverage_pct", "DOUBLE"),
    ("assets_with_condition_date", "BIGINT"),
    ("condition_date_coverage_pct", "DOUBLE"),
    ("assets_with_location_row", "BIGINT"),
    ("location_row_coverage_pct", "DOUBLE"),
    ("assets_with_wkt", "BIGINT"),
    ("wkt_coverage_pct", "DOUBLE"),
    ("assets_with_valid_au_coord", "BIGINT"),
    ("valid_au_coord_coverage_pct", "DOUBLE"),
    ("location_rows", "BIGINT"),
    ("wkt_geometry_types", "STRING"),
    ("attribute_rows", "BIGINT"),
    ("distinct_attribute_names", "BIGINT"),
    ("assets_with_attributes", "BIGINT"),
    ("custom_attribute_coverage_pct", "DOUBLE"),
    ("attribute_name_examples", "STRING"),
    ("job_count", "BIGINT"),
    ("assets_with_job", "BIGINT"),
    ("job_coverage_pct", "DOUBLE"),
    ("jobs_per_asset", "DOUBLE"),
    ("completed_job_count", "BIGINT"),
    ("overdue_open_job_count", "BIGINT"),
    ("job_hazard_defect_codes", "STRING"),
    ("job_activity_category_names", "STRING"),
    ("job_activity_names", "STRING"),
    ("job_intervention_codes", "STRING"),
    ("job_priorities", "STRING"),
    ("job_activity_types", "STRING"),
    ("job_compliance_values", "STRING"),
    ("job_inspection_type_names", "STRING"),
    ("jobs_with_estimated_quantity", "BIGINT"),
    ("job_estimated_quantity_total", "DOUBLE"),
    ("jobs_with_actual_quantity", "BIGINT"),
    ("job_actual_quantity_total", "DOUBLE"),
    ("jobs_with_remaining_quantity", "BIGINT"),
    ("job_remaining_quantity_total", "DOUBLE"),
    ("jobs_with_estimated_length", "BIGINT"),
    ("job_estimated_length_total", "DOUBLE"),
    ("jobs_with_estimated_width", "BIGINT"),
    ("job_estimated_width_avg", "DOUBLE"),
    ("jobs_with_estimated_depth", "BIGINT"),
    ("job_estimated_depth_avg", "DOUBLE"),
    ("inspection_count", "BIGINT"),
    ("assets_with_inspection", "BIGINT"),
    ("inspection_coverage_pct", "DOUBLE"),
    ("inspections_per_asset", "DOUBLE"),
    ("completed_inspection_count", "BIGINT"),
    ("overdue_open_inspection_count", "BIGINT"),
    ("capitalwork_count", "BIGINT"),
    ("assets_with_capitalwork", "BIGINT"),
    ("capitalwork_coverage_pct", "DOUBLE"),
    ("completed_capitalwork_count", "BIGINT"),
    ("asset_photo_count", "BIGINT"),
    ("assets_with_asset_photo", "BIGINT"),
    ("asset_photo_coverage_pct", "DOUBLE"),
    ("job_photo_count", "BIGINT"),
    ("assets_with_job_photo", "BIGINT"),
    ("job_photo_asset_coverage_pct", "DOUBLE"),
    ("total_photo_count", "BIGINT"),
]


def prepare_source_contract_rows(groups: list[dict[str, Any]], generated_at: str) -> list[dict[str, Any]]:
    rows: list[dict[str, Any]] = []
    for group in groups:
        source_rows: dict[str, dict[str, Any]] = defaultdict(lambda: {"assets": 0, "raw": set()})
        for detail in group["detail_rows"]:
            source_label = str(detail.get("source_label") or "")
            source_context = str(detail.get("source_context") or "")
            source_catalog = str(detail.get("source_catalog") or "")
            contract = str(detail.get("contract") or "")
            key = "\t".join([source_label, source_context, source_catalog, contract])
            source_rows[key]["assets"] += to_int(detail.get("asset_count"))
            source_rows[key]["raw"].add(str(detail.get("raw_asset_type") or ""))
        for key, info in source_rows.items():
            source_label, source_context, source_catalog, contract = key.split("\t")
            rows.append(
                {
                    "run_generated_at_utc": generated_at,
                    "standardised_asset_type_name": group["standardised_asset_type_name"],
                    "asset_category": group["asset_category"],
                    "asset_subcategory": group["asset_subcategory"],
                    "source_label": source_label,
                    "source_context": source_context,
                    "source_catalog": source_catalog,
                    "contract": contract,
                    "asset_count": info["assets"],
                    "raw_asset_type_count": len(info["raw"]),
                    "raw_asset_types": joined(info["raw"]),
                }
            )
    return sorted(
        rows,
        key=lambda row: (
            row["asset_category"],
            row["asset_subcategory"],
            row["standardised_asset_type_name"],
            row["source_label"],
            row["contract"],
        ),
    )


SOURCE_CONTRACT_COLUMNS = [
    ("run_generated_at_utc", "STRING"),
    ("standardised_asset_type_name", "STRING"),
    ("asset_category", "STRING"),
    ("asset_subcategory", "STRING"),
    ("source_label", "STRING"),
    ("source_context", "STRING"),
    ("source_catalog", "STRING"),
    ("contract", "STRING"),
    ("asset_count", "BIGINT"),
    ("raw_asset_type_count", "BIGINT"),
    ("raw_asset_types", "STRING"),
]


def prepare_mapping_rows(mapping: dict[str, AssetTypeMap], generated_at: str) -> list[dict[str, Any]]:
    rows = []
    for raw_asset_type, mapped in sorted(mapping.items()):
        rows.append(
            {
                "run_generated_at_utc": generated_at,
                "raw_asset_type": raw_asset_type,
                "standardised_asset_type_name": mapped.standardised_asset_type_name,
                "asset_category": mapped.asset_category,
                "asset_subcategory": mapped.asset_subcategory,
                "mapping_method": mapped.mapping_method,
                "manual_review_notes": mapped.manual_review_notes,
            }
        )
    return rows


MAPPING_COLUMNS = [
    ("run_generated_at_utc", "STRING"),
    ("raw_asset_type", "STRING"),
    ("standardised_asset_type_name", "STRING"),
    ("asset_category", "STRING"),
    ("asset_subcategory", "STRING"),
    ("mapping_method", "STRING"),
    ("manual_review_notes", "STRING"),
]


def prepare_metric_dictionary_rows(generated_at: str) -> list[dict[str, Any]]:
    rows = []
    for index, (name, source, formula, caveat) in enumerate(metric_dictionary(), start=1):
        metric_id = re.sub(r"[^a-z0-9]+", "_", name.lower()).strip("_")
        rows.append(
            {
                "run_generated_at_utc": generated_at,
                "metric_order": index,
                "metric_id": metric_id,
                "metric_name": name,
                "source_columns": source,
                "formula": formula,
                "caveat": caveat,
            }
        )
    return rows


METRIC_DICTIONARY_COLUMNS = [
    ("run_generated_at_utc", "STRING"),
    ("metric_order", "BIGINT"),
    ("metric_id", "STRING"),
    ("metric_name", "STRING"),
    ("source_columns", "STRING"),
    ("formula", "STRING"),
    ("caveat", "STRING"),
]


def prepare_run_status_rows(
    detail_rows: list[dict[str, Any]],
    skipped_contexts: list[dict[str, str]],
    generated_at: str,
) -> list[dict[str, Any]]:
    by_context: dict[str, dict[str, Any]] = {}
    for row in detail_rows:
        context = str(row.get("source_context") or "")
        entry = by_context.setdefault(
            context,
            {
                "source_context": context,
                "source_catalog": row.get("source_catalog"),
                "source_label": row.get("source_label"),
                "status": "loaded",
                "aggregate_row_count": 0,
                "asset_count": 0,
                "available_tables": "; ".join(row.get("available_tables") or []),
                "message": "",
            },
        )
        entry["aggregate_row_count"] += 1
        entry["asset_count"] += to_int(row.get("asset_count"))
    rows = []
    for context, catalog, label in SOURCE_CONTEXTS:
        entry = by_context.get(context)
        if entry:
            rows.append({"run_generated_at_utc": generated_at, **entry})
        else:
            skipped = next((item for item in skipped_contexts if item["source_context"] == context), None)
            rows.append(
                {
                    "run_generated_at_utc": generated_at,
                    "source_context": context,
                    "source_catalog": catalog,
                    "source_label": label,
                    "status": "skipped",
                    "aggregate_row_count": 0,
                    "asset_count": 0,
                    "available_tables": "",
                    "message": skipped["reason"] if skipped else "No rows returned.",
                }
            )
    return rows


RUN_STATUS_COLUMNS = [
    ("run_generated_at_utc", "STRING"),
    ("source_context", "STRING"),
    ("source_catalog", "STRING"),
    ("source_label", "STRING"),
    ("status", "STRING"),
    ("aggregate_row_count", "BIGINT"),
    ("asset_count", "BIGINT"),
    ("available_tables", "STRING"),
    ("message", "STRING"),
]


def publish_databricks_tables(
    groups: list[dict[str, Any]],
    detail_rows: list[dict[str, Any]],
    mapping: dict[str, AssetTypeMap],
    skipped_contexts: list[dict[str, str]],
    generated_at: str,
) -> list[dict[str, Any]]:
    table_rows = {
        "summary": (SUMMARY_COLUMNS, prepare_summary_rows(groups, generated_at)),
        "detail": (DETAIL_COLUMNS, prepare_detail_rows(detail_rows, mapping, generated_at)),
        "source_contract": (SOURCE_CONTRACT_COLUMNS, prepare_source_contract_rows(groups, generated_at)),
        "mapping": (MAPPING_COLUMNS, prepare_mapping_rows(mapping, generated_at)),
        "metric_dictionary": (METRIC_DICTIONARY_COLUMNS, prepare_metric_dictionary_rows(generated_at)),
        "run_status": (RUN_STATUS_COLUMNS, prepare_run_status_rows(detail_rows, skipped_contexts, generated_at)),
    }

    execute_statement(f"CREATE SCHEMA IF NOT EXISTS {qident(TARGET_CATALOG)}.{qident(TARGET_SCHEMA)}")
    published_tables: list[dict[str, Any]] = []
    for table_key, table_name in PUBLISHED_TABLES.items():
        columns, rows = table_rows[table_key]
        publish_table(table_name, columns, rows)
        published_tables.append(
            {
                "key": table_key,
                "table": table_name,
                "full_name": f"{TARGET_CATALOG}.{TARGET_SCHEMA}.{table_name}",
                "qualified_name": qualified_table(table_name),
                "row_count": len(rows),
                **PUBLISHED_TABLE_INFO[table_key],
            }
        )
    return published_tables


def write_markdown(
    groups: list[dict[str, Any]],
    detail_rows: list[dict[str, Any]],
    skipped_contexts: list[dict[str, str]],
    published_tables: list[dict[str, Any]],
    generated_at: str,
    path: Path,
) -> None:
    total_assets = sum(group["asset_count"] for group in groups)
    total_types = len(groups)
    total_raw = len({raw for group in groups for raw in group["raw_asset_types"]})
    active_sources = sorted({label for group in groups for label in group["source_labels"]})
    fallback_groups = [
        group
        for group in groups
        if "auto_source_asset_type_other_v1" in group["mapping_methods"]
    ]
    top_by_assets = sorted(groups, key=lambda group: group["asset_count"], reverse=True)[:25]
    low_wkt = [
        group
        for group in sorted(groups, key=lambda group: group["asset_count"], reverse=True)
        if group["asset_count"] >= 100 and group["assets_with_wkt"] / max(group["asset_count"], 1) < 0.5
    ][:30]

    lines: list[str] = []
    lines.extend(
        [
            "---",
            "type: analysis-summary",
            "topic: Ventia",
            "sector: Transport",
            "analysis: asset-type-metrics",
            "date-created: 2026-06-17",
            "date-updated: 2026-06-17",
            "tags: [transport, data-tables, asset-vision, databricks, asset-type-metrics]",
            "---",
            "",
            "# Transport Asset Type Metrics and Attributes",
            "",
            f"Generated from live Databricks validation at `{generated_at}` using the Databricks CLI OAuth profile `{PROFILE}` and SQL warehouse `{WAREHOUSE_ID}`.",
            "",
            "This page summarizes what data is available by standardised asset type, what attributes and metrics can be pulled, and how generated metrics are formulated. It is intentionally asset-type-level rather than only source-table-level because WKT geometry, linear reference fields, condition/risk/criticality fields, custom attributes, jobs, inspections, capital works, and photo evidence vary materially by raw Asset Vision asset type and source context.",
            "",
            "## Executive Summary",
            "",
            f"- Live validation returned `{total_assets:,}` non-deleted source assets across `{len(active_sources)}` active Asset Vision source labels.",
            f"- Raw `asset.AssetType` values were standardised into `{total_types:,}` standardised asset type rows from `{total_raw:,}` raw source asset-type labels.",
            f"- The standardised naming layer comes from `analysis/deterioration-analysis/create_asset_type_category_map.sql`; `{len(fallback_groups):,}` standardised rows still use the fallback `Other / Unclassified` mapping and should be manually reviewed before being treated as final taxonomy.",
            f"- WKT is validated from `vassetlocation.WKT`, not from `asset.SpatialType`; an asset type can have a source spatial type value and still have no usable WKT, or can have mixed WKT geometry types.",
            "- Generated operational metrics are relationship proxies, not contract KPI definitions. They are valid for triage and data-product design, but formal KPI reporting needs contract-specific SLA rules, due-date rules, inspection schedules, and status definitions.",
            "",
        ]
    )

    if skipped_contexts:
        lines.extend(["## Skipped / Limited Sources", ""])
        lines.extend(["| Source context | Catalog | Reason |", "|---|---|---|"])
        for skipped in skipped_contexts:
            lines.append(
                f"| `{md_escape(skipped['source_context'])}` | `{md_escape(skipped['catalog'])}` | {md_escape(skipped['reason'])} |"
            )
        lines.append("")

    lines.extend(
        [
            "## Source Tables Used",
            "",
            "| Source table | What it contributes | Asset-type use |",
            "|---|---|---|",
            "| `*.dbo.asset` | Asset identity, raw asset type, contract, source classification, source spatial type, parent asset, chainage, lifecycle fields, condition, criticality, risk | Base denominator and core attribute coverage by asset type |",
            "| `*.dbo.vassetlocation` | WKT, spatial information, location chainage/direction | WKT coverage, geometry type, valid-Australia coordinate proxy, location-row coverage |",
            "| `*.dbo.assetattribute` | Custom name/value attributes by asset | Attribute coverage, distinct custom attribute name counts, example attribute names |",
            "| `*.dbo.job` | Direct asset-linked jobs, due date, completed date | Linked job count, assets with jobs, job completion/overdue proxy |",
            "| `*.dbo.jobasset` | Many-to-many job-to-asset links | Adds job coverage where jobs are related through bridge records rather than direct `job.AssetID` |",
            "| `*.dbo.inspection` | Asset-linked inspections, scheduled dates, completed date | Inspection coverage, inspection completion/overdue proxy |",
            "| `*.dbo.capitalwork` | Asset-linked capital works, planned/actual dates | Capital-work coverage and completed capital-work count |",
            "| `*.dbo.photo` | Direct photos for assets and photos attached to jobs | Evidence/photo coverage by asset type |",
            "",
            "## Databricks Tables Published",
            "",
            f"The same run publishes dashboard-ready Delta tables to `{TARGET_CATALOG}.{TARGET_SCHEMA}` with the `{TABLE_PREFIX}` prefix.",
            "",
            "| Table | Rows | Grain | Dashboard use |",
            "|---|---:|---|---|",
        ]
    )
    for table in published_tables:
        lines.append(
            f"| `{table['full_name']}` | {table['row_count']:,} | {md_escape(table['grain'])} | {md_escape(table['purpose'])} |"
        )

    lines.extend(
        [
            "",
            "## Metric Dictionary",
            "",
            "| Metric / attribute | Source columns | Formula used here | Caveat |",
            "|---|---|---|---|",
        ]
    )
    for name, source, formula, caveat in metric_dictionary():
        lines.append(f"| {md_escape(name)} | {md_escape(source)} | {md_escape(formula)} | {md_escape(caveat)} |")

    lines.extend(
        [
            "",
            "## Top Asset Types by Volume",
            "",
            "| Standardised asset type | Category | Assets | Sources | WKT assets | Valid AU coord | Condition | Criticality | Risk | Jobs / asset | Inspections / asset | Notes |",
            "|---|---|---:|---|---:|---:|---:|---:|---:|---:|---:|---|",
        ]
    )
    for group in top_by_assets:
        asset_count = group["asset_count"]
        notes = []
        if group["assets_with_wkt"] < asset_count:
            notes.append(f"{asset_count - group['assets_with_wkt']:,} assets missing WKT")
        if group["assets_with_attributes"]:
            notes.append(f"{group['distinct_attribute_names']:,} custom attribute names")
        if "auto_source_asset_type_other_v1" in group["mapping_methods"]:
            notes.append("fallback taxonomy")
        lines.append(
            "| "
            + " | ".join(
                [
                    md_escape(group["standardised_asset_type_name"]),
                    md_escape(group["asset_category"]),
                    f"{asset_count:,}",
                    md_escape(short_list(group["source_labels"], 4)),
                    f"{group['assets_with_wkt']:,} ({pct(group['assets_with_wkt'], asset_count)})",
                    f"{group['assets_with_valid_au_coord']:,} ({pct(group['assets_with_valid_au_coord'], asset_count)})",
                    pct(group["assets_with_condition"], asset_count),
                    pct(group["assets_with_criticality"], asset_count),
                    pct(group["assets_with_risk"], asset_count),
                    ratio(group["job_count"], asset_count),
                    ratio(group["inspection_count"], asset_count),
                    md_escape("; ".join(notes)),
                ]
            )
            + " |"
        )

    lines.extend(
        [
            "",
            "## WKT and Geometry Watchlist",
            "",
            "These are high-volume standardised asset types with fewer than 50% of assets carrying WKT in the live validation. This does not mean the assets have no spatial reference at all; some may have chainage, parent asset, source spatial type, or source binary `SpatialInfo`, but they are not immediately map-ready through `vassetlocation.WKT`.",
            "",
            "| Standardised asset type | Assets | WKT coverage | Valid AU coordinate coverage | Source spatial types | WKT geometry types observed | Chainage coverage |",
            "|---|---:|---:|---:|---|---|---:|",
        ]
    )
    for group in low_wkt:
        asset_count = group["asset_count"]
        lines.append(
            "| "
            + " | ".join(
                [
                    md_escape(group["standardised_asset_type_name"]),
                    f"{asset_count:,}",
                    pct(group["assets_with_wkt"], asset_count),
                    pct(group["assets_with_valid_au_coord"], asset_count),
                    md_escape(short_list(group["spatial_type_examples"], 6)),
                    md_escape(short_list(group["wkt_geometry_types"], 6)),
                    pct(group["assets_with_chainage"], asset_count),
                ]
            )
            + " |"
        )

    lines.extend(
        [
            "",
            "## Full Standardised Asset Type Register",
            "",
            "| Category | Subcategory | Standardised asset type | Raw source asset types | Assets | Source labels | Contracts | WKT | Valid AU coord | Condition | Criticality | Risk | Chainage | Parent | Custom attributes | Jobs | Inspections | Photos | Capital works |",
            "|---|---|---|---|---:|---|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|",
        ]
    )
    for group in groups:
        asset_count = group["asset_count"]
        lines.append(
            "| "
            + " | ".join(
                [
                    md_escape(group["asset_category"]),
                    md_escape(group["asset_subcategory"]),
                    md_escape(group["standardised_asset_type_name"]),
                    md_escape(short_list(group["raw_asset_types"], 8)),
                    f"{asset_count:,}",
                    md_escape(short_list(group["source_labels"], 5)),
                    md_escape(short_list(group["contracts"], 8)),
                    pct(group["assets_with_wkt"], asset_count),
                    pct(group["assets_with_valid_au_coord"], asset_count),
                    pct(group["assets_with_condition"], asset_count),
                    pct(group["assets_with_criticality"], asset_count),
                    pct(group["assets_with_risk"], asset_count),
                    pct(group["assets_with_chainage"], asset_count),
                    pct(group["assets_with_parent_asset"], asset_count),
                    f"{pct(group['assets_with_attributes'], asset_count)} / {group['distinct_attribute_names']:,} names",
                    f"{group['job_count']:,}",
                    f"{group['inspection_count']:,}",
                    f"{group['asset_photo_count'] + group['job_photo_count']:,}",
                    f"{group['capitalwork_count']:,}",
                ]
            )
            + " |"
        )

    lines.extend(
        [
            "",
            "## Asset Type Detail",
            "",
            "Each section below uses the standardised name as the heading. Raw source names are retained so the mapping can be audited back to Asset Vision. `Rows by source/contract` is capped to the largest source-contract combinations for scanability; the CSV output keeps the same aggregate metrics in machine-readable form.",
            "",
        ]
    )
    for group in groups:
        asset_count = group["asset_count"]
        lines.extend(
            [
                f"### {group['standardised_asset_type_name']}",
                "",
                f"- Category: {group['asset_category']} / {group['asset_subcategory']}.",
                f"- Raw source asset types: {short_list(group['raw_asset_types'], 20) or 'None supplied'}.",
                f"- Asset count: `{asset_count:,}` across `{len(group['source_labels'])}` source labels and `{len(group['contracts'])}` source contract values.",
                f"- WKT: `{group['assets_with_wkt']:,}` assets with WKT ({pct(group['assets_with_wkt'], asset_count)}), `{group['assets_with_valid_au_coord']:,}` with a valid-Australia first coordinate ({pct(group['assets_with_valid_au_coord'], asset_count)}). Geometry tokens observed: {short_list(group['wkt_geometry_types'], 12) or 'none observed'}. Source `SpatialType` values: {short_list(group['spatial_type_examples'], 12) or 'none supplied'}.",
                f"- Core attributes: condition {pct(group['assets_with_condition'], asset_count)}, criticality {pct(group['assets_with_criticality'], asset_count)}, risk {pct(group['assets_with_risk'], asset_count)}, source classification {pct(group['assets_with_classification'], asset_count)}, parent asset {pct(group['assets_with_parent_asset'], asset_count)}, stage {pct(group['assets_with_stage'], asset_count)}.",
                f"- Linear/lifecycle attributes: chainage {pct(group['assets_with_chainage'], asset_count)} with `{group['chainage_length_km_proxy']:.3f}` km proxy, construction date {pct(group['assets_with_construction_date'], asset_count)}, construction cost {pct(group['assets_with_construction_cost'], asset_count)}, useful life {pct(group['assets_with_useful_life'], asset_count)}, condition date {pct(group['assets_with_condition_date'], asset_count)}.",
                f"- Custom attributes: `{group['attribute_rows']:,}` attribute rows, `{group['distinct_attribute_names']:,}` distinct attribute names, covering `{group['assets_with_attributes']:,}` assets ({pct(group['assets_with_attributes'], asset_count)}). Examples: {short_list(group['attribute_name_examples'], 18) or 'none observed'}.",
                f"- Operations/evidence: `{group['job_count']:,}` linked jobs ({ratio(group['job_count'], asset_count)} per asset), `{group['overdue_open_job_count']:,}` open-overdue job proxy records, `{group['inspection_count']:,}` linked inspections ({ratio(group['inspection_count'], asset_count)} per asset), `{group['overdue_open_inspection_count']:,}` open-overdue inspection proxy records, `{group['capitalwork_count']:,}` capital works, `{group['asset_photo_count']:,}` direct asset photos, `{group['job_photo_count']:,}` linked job photos.",
                f"- Classification examples: {short_list(group['classification_examples'], 12) or 'none supplied'}.",
                f"- Mapping method: {', '.join(sorted(group['mapping_methods']))}.",
                "",
                "| Rows by source/contract | Assets | Raw asset types in that source/contract |",
                "|---|---:|---|",
            ]
        )
        source_rows: dict[str, dict[str, Any]] = defaultdict(lambda: {"assets": 0, "raw": set()})
        for row in group["detail_rows"]:
            label = f"{row.get('source_label') or row.get('source_context')} / {row.get('contract')}"
            source_rows[label]["assets"] += to_int(row.get("asset_count"))
            source_rows[label]["raw"].add(str(row.get("raw_asset_type") or ""))
        for label, info in sorted(source_rows.items(), key=lambda item: (-item[1]["assets"], item[0]))[:12]:
            lines.append(
                f"| {md_escape(label)} | {info['assets']:,} | {md_escape(short_list(info['raw'], 8))} |"
            )
        lines.append("")

    lines.extend(
        [
            "## Related Pages",
            "",
            "- [[Transport Data Tables]]",
            "- [[Asset Vision]]",
            "- [[Transport Data Landscape]]",
            "- [[Ventia Databricks Platform]]",
            "- [[Transport Asset Inventory Validation]]",
            "- [[Transport Asset Condition Inspections]]",
        ]
    )

    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text("\n".join(lines) + "\n", encoding="utf-8")


def write_readme(generated_at: str, published_tables: list[dict[str, Any]]) -> None:
    lines = [
        "# Asset Type Metrics",
        "",
        "This folder contains the repeatable Databricks-backed workflow used to build the Transport asset-type metrics markdown page and dashboard tables.",
        "",
        "## Run",
        "",
        "```powershell",
        "python analysis\\asset-type-metrics\\fetch_asset_type_metrics.py",
        "```",
        "",
        "The script uses the Databricks CLI OAuth profile from `DATABRICKS_CONFIG_PROFILE`, defaulting to `ventia-transport`, and SQL warehouse `DATABRICKS_WAREHOUSE_ID`, defaulting to `e736bc08efffb739`.",
        "",
        "## Databricks Targets",
        "",
        f"- Catalog: `{TARGET_CATALOG}`",
        f"- Schema: `{TARGET_SCHEMA}`",
        f"- Prefix: `{TABLE_PREFIX}`",
        f"- Last generated at: `{generated_at}`",
        "",
        "| Table | Rows | Grain | Use |",
        "|---|---:|---|---|",
    ]
    for table in published_tables:
        lines.append(
            f"| `{table['full_name']}` | {table['row_count']:,} | {table['grain']} | {table['purpose']} |"
        )
    lines.extend(
        [
            "",
            "## Local Outputs",
            "",
            "- `output/asset_type_metrics_summary.csv`: standardised asset-type summary for quick spreadsheet checks.",
            "- `output/asset_type_metrics_raw.json`: full local payload including detail rows, standardised rows, skipped sources, and published table names.",
            "- `output/asset_type_metrics_queries.sql`: source aggregate SQL used for each Asset Vision source context.",
            "- `output/published_tables.json`: machine-readable list of created Databricks tables, row counts, grains, and dashboard uses.",
            "",
            "## Notes",
            "",
            "- Tables are recreated on every run.",
            "- Generated metrics are proxy metrics unless explicitly source-populated; use `atm_metric_dictionary` for formula/caveat text.",
            "- `atm_asset_type_metrics_summary` is the best starting point for Databricks dashboard visuals.",
        ]
    )
    (ROOT / "analysis" / "asset-type-metrics" / "README.md").write_text(
        "\n".join(lines) + "\n",
        encoding="utf-8",
    )


def main() -> int:
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    mapping = parse_mapping()
    generated_at = datetime.now(timezone.utc).replace(microsecond=0).isoformat()
    all_rows: list[dict[str, Any]] = []
    skipped_contexts: list[dict[str, str]] = []
    source_sql: dict[str, str] = {}

    for source_context, catalog, label in SOURCE_CONTEXTS:
        try:
            tables = discover_tables(catalog)
            if "asset" not in tables:
                skipped_contexts.append(
                    {
                        "source_context": source_context,
                        "catalog": catalog,
                        "reason": "No dbo.asset table visible in information_schema.",
                    }
                )
                continue
            sql = cte_for_source(source_context, catalog, tables)
            source_sql[source_context] = sql
            rows = execute_statement(sql)
            for row in rows:
                row["source_label"] = label
                row["source_catalog"] = catalog
                row["available_tables"] = sorted(tables)
            all_rows.extend(rows)
            print(f"{source_context}: {len(rows)} aggregate rows", flush=True)
        except Exception as exc:
            skipped_contexts.append(
                {
                    "source_context": source_context,
                    "catalog": catalog,
                    "reason": str(exc).splitlines()[0],
                }
            )
            print(f"{source_context}: skipped: {exc}", file=sys.stderr, flush=True)

    if not all_rows:
        raise RuntimeError("No asset-type rows were returned from Databricks.")

    groups = aggregate(all_rows, mapping)
    published_tables = publish_databricks_tables(groups, all_rows, mapping, skipped_contexts, generated_at)

    payload = {
        "generated_at_utc": generated_at,
        "profile": PROFILE,
        "warehouse_id": WAREHOUSE_ID,
        "target_catalog": TARGET_CATALOG,
        "target_schema": TARGET_SCHEMA,
        "table_prefix": TABLE_PREFIX,
        "published_tables": published_tables,
        "source_contexts": [
            {"source_context": c, "catalog": catalog, "label": label}
            for c, catalog, label in SOURCE_CONTEXTS
        ],
        "skipped_contexts": skipped_contexts,
        "detail_rows": all_rows,
        "standardised_asset_types": [
            {
                key: (sorted(value) if isinstance(value, set) else value)
                for key, value in group.items()
                if key not in {"detail_rows", "source_contract_breakdown"}
            }
            | {"source_contract_breakdown": group["source_contract_breakdown"]}
            for group in groups
        ],
    }

    (OUT_DIR / "asset_type_metrics_raw.json").write_text(
        json.dumps(payload, indent=2, ensure_ascii=False),
        encoding="utf-8",
    )
    (OUT_DIR / "asset_type_metrics_queries.sql").write_text(
        "\n\n-- " + "\n\n-- ".join(
            f"{source_context}\n{sql}" for source_context, sql in source_sql.items()
        ),
        encoding="utf-8",
    )
    write_csv(groups, OUT_DIR / "asset_type_metrics_summary.csv")
    write_markdown(groups, all_rows, skipped_contexts, published_tables, generated_at, WIKI_OUT)
    (OUT_DIR / "published_tables.json").write_text(
        json.dumps(
            {
                "generated_at_utc": generated_at,
                "target_catalog": TARGET_CATALOG,
                "target_schema": TARGET_SCHEMA,
                "table_prefix": TABLE_PREFIX,
                "published_tables": published_tables,
            },
            indent=2,
        ),
        encoding="utf-8",
    )
    write_readme(generated_at, published_tables)

    print(f"Wrote {OUT_DIR / 'asset_type_metrics_raw.json'}", flush=True)
    print(f"Wrote {OUT_DIR / 'asset_type_metrics_summary.csv'}", flush=True)
    print(f"Wrote {OUT_DIR / 'published_tables.json'}", flush=True)
    print(f"Wrote {WIKI_OUT}", flush=True)
    print("Published Databricks tables:", flush=True)
    for table in published_tables:
        print(f"  {table['qualified_name']} ({table['row_count']:,} rows)", flush=True)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
