from __future__ import annotations

import json
import os
import re
import shutil
import subprocess
import sys
import time
from collections import defaultdict
from datetime import datetime, timezone
from pathlib import Path
from typing import Any


ROOT = Path(__file__).resolve().parent
OUT_DIR = ROOT / "data"
PROFILE = os.environ.get("DATABRICKS_CONFIG_PROFILE", "ventia-transport")
WAREHOUSE_ID = os.environ.get("DATABRICKS_WAREHOUSE_ID", "e736bc08efffb739")


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


RELEVANT_BASE_TABLES = {
    "asset",
    "assetarea",
    "assetattribute",
    "assetclassification",
    "assethierarchy",
    "assetlocation",
    "assetaudit",
    "capitalwork",
    "capitalworktask",
    "contractreference",
    "custommoduleitem",
    "formfield",
    "inspection",
    "inspectionrelation",
    "inspectionstatus",
    "job",
    "jobasset",
    "jobcomment",
    "module",
    "photo",
    "plannedresourceitem",
    "resource",
    "resourceattribute",
    "resourceaudit",
    "timesheetitem",
    "workflowstatus",
}


LOW_VALUE_SOURCE_TABLES = {
    "exportdate",
    "exportdatelog",
    "log",
    "summarycheck",
}


TABLE_PROFILES = {
    "asset": {
        "business_area": "Asset register and hierarchy",
        "cluster": "Asset attributes",
        "potential": "Potential: active asset count, condition coverage, criticality coverage, asset risk distribution, assets missing region or class.",
    },
    "assetarea": {
        "business_area": "Asset register and geography",
        "cluster": "Location/geography attributes",
        "potential": "Potential: assets by area, assets missing area, asset-area overlap count.",
    },
    "assetattribute": {
        "business_area": "Asset register and custom attributes",
        "cluster": "Asset attributes",
        "potential": "Potential: attribute completeness by asset class, common attribute values, attributes missing on critical assets.",
    },
    "assetclassification": {
        "business_area": "Asset register and classification",
        "cluster": "Asset attributes",
        "potential": "Potential: assets by class, class coverage rate, unclassified asset count.",
    },
    "assethierarchy": {
        "business_area": "Asset hierarchy",
        "cluster": "Asset attributes",
        "potential": "Potential: parent-child asset depth, orphan asset count, hierarchy completeness.",
    },
    "assetlocation": {
        "business_area": "Asset location",
        "cluster": "Location/geography attributes",
        "potential": "Potential: geocoded asset count, assets without location, assets by chainage or region where available.",
    },
    "assetaudit": {
        "business_area": "Asset audit",
        "cluster": "Time/date attributes",
        "potential": "Potential: asset change volume, recently modified assets, audit coverage by asset type.",
    },
    "capitalwork": {
        "business_area": "Capital works / forward programme",
        "cluster": "Capital works attributes",
        "potential": "Potential: capital works count, planned vs actual completion, estimated vs actual cost variance.",
    },
    "capitalworktask": {
        "business_area": "Capital works / forward programme",
        "cluster": "Work order attributes",
        "potential": "Potential: capital task count, task completion rate, task duration variance.",
    },
    "contractreference": {
        "business_area": "Contract context",
        "cluster": "Contractor attributes",
        "potential": "Potential: source contract reference coverage, contract reference mismatch count.",
    },
    "custommoduleitem": {
        "business_area": "Custom forms and modules",
        "cluster": "Contract-specific attributes",
        "potential": "Potential: custom form usage count, populated custom field rate, frequent custom module values.",
    },
    "formfield": {
        "business_area": "Custom forms and modules",
        "cluster": "Contract-specific attributes",
        "potential": "Potential: available form field count, required-field coverage, contract-specific field inventory.",
    },
    "inspection": {
        "business_area": "Inspections",
        "cluster": "Inspection attributes",
        "potential": "Potential: inspection count, completion rate, overdue inspection rate, average days to complete.",
    },
    "inspectionrelation": {
        "business_area": "Inspections",
        "cluster": "Inspection linkage attributes",
        "potential": "Potential: inspections linked to assets, inspections linked to jobs, unlinked inspection count.",
    },
    "inspectionstatus": {
        "business_area": "Inspections",
        "cluster": "Inspection status attributes",
        "potential": "Potential: inspections by status, status ageing, time in status.",
    },
    "job": {
        "business_area": "Jobs / work orders",
        "cluster": "Work order attributes",
        "potential": "Potential: jobs raised, closed jobs, open backlog, overdue jobs, SLA compliance proxy where due/completed dates exist.",
    },
    "jobasset": {
        "business_area": "Jobs / work orders",
        "cluster": "Asset-job linkage attributes",
        "potential": "Potential: jobs per asset, repeat work by asset, assets with no linked jobs.",
    },
    "jobcomment": {
        "business_area": "Jobs / work orders",
        "cluster": "Work order attributes",
        "potential": "Potential: job comment volume, comments per job, recent comment activity.",
    },
    "module": {
        "business_area": "Custom forms and modules",
        "cluster": "Contract-specific attributes",
        "potential": "Potential: module usage count, module activity by source table, forms linked to jobs/assets.",
    },
    "photo": {
        "business_area": "Evidence / attachments",
        "cluster": "Evidence attributes",
        "potential": "Potential: photo count, before/after photo coverage, jobs/assets missing evidence.",
    },
    "plannedresourceitem": {
        "business_area": "Resources and planning",
        "cluster": "Resource attributes",
        "potential": "Potential: planned resource hours, planned quantity, plan-vs-actual resource coverage.",
    },
    "resource": {
        "business_area": "Resources and planning",
        "cluster": "Resource attributes",
        "potential": "Potential: active resource count, resource availability, resources by crew or type where available.",
    },
    "resourceattribute": {
        "business_area": "Resources and planning",
        "cluster": "Resource attributes",
        "potential": "Potential: resource attribute completeness, skills/capability coverage if fields are populated.",
    },
    "resourceaudit": {
        "business_area": "Resources and planning",
        "cluster": "Time/date attributes",
        "potential": "Potential: resource change volume, recently modified resources, audit coverage.",
    },
    "timesheetitem": {
        "business_area": "Timesheets and labour",
        "cluster": "Cost/quantity attributes",
        "potential": "Potential: labour hours, cost by job/resource, planned vs recorded time where linked fields exist.",
    },
    "workflowstatus": {
        "business_area": "Workflow and status",
        "cluster": "SLA/performance attributes",
        "potential": "Potential: status ageing, workflow step volume, time between workflow states.",
    },
}


DIMENSION_TERMS = (
    "id",
    "code",
    "name",
    "type",
    "category",
    "classification",
    "contract",
    "region",
    "section",
    "direction",
    "status",
    "priority",
    "risk",
    "condition",
    "criticality",
    "asset",
    "job",
    "inspection",
    "resource",
    "module",
    "workflow",
    "activity",
    "hazard",
    "defect",
    "reference",
    "user",
    "reason",
    "unit",
)


METRIC_TERMS = (
    "date",
    "time",
    "duration",
    "cost",
    "quantity",
    "amount",
    "length",
    "width",
    "depth",
    "area",
    "chainage",
    "distance",
    "offset",
    "due",
    "scheduled",
    "completed",
    "actual",
    "estimated",
    "remaining",
    "usefullife",
    "percent",
    "rate",
    "score",
    "number",
)


TECHNICAL_COLUMNS = {
    "row_number",
    "rowid",
    "_rescued_data",
    "hash",
    "checksum",
    "deltautc",
    "etl_updated_at",
}


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


def friendly_name(name: str) -> str:
    text = str(name).replace("_", " ").strip()
    text = re.sub(r"(?<=[a-z0-9])(?=[A-Z])", " ", text)
    text = re.sub(r"(?<=[A-Z])(?=[A-Z][a-z])", " ", text)
    replacements = {
        "Utc": "UTC",
        "Id": "ID",
        "Crm": "CRM",
        "Sla": "SLA",
        "Wkt": "WKT",
    }
    words = []
    for word in re.sub(r"\s+", " ", text).split(" "):
        word = replacements.get(word, word)
        if word.isupper():
            words.append(word)
        else:
            words.append(word[:1].lower() + word[1:])
    return " ".join(words)


def column_bucket(columns: list[str], terms: tuple[str, ...], limit: int = 10) -> list[str]:
    output = []
    for column in columns:
        key = re.sub(r"[^a-z0-9]", "", column.lower())
        if column.lower() in TECHNICAL_COLUMNS:
            continue
        if any(term in key for term in terms):
            output.append(friendly_name(column))
        if len(output) >= limit:
            break
    return output


def collect_metadata() -> tuple[list[dict[str, Any]], dict[str, list[str]], list[dict[str, str]]]:
    schema_rows: list[dict[str, Any]] = []
    columns_by_key: dict[str, list[str]] = {}
    skipped: list[dict[str, str]] = []

    for source_schema, catalog, label in SOURCE_CONTEXTS:
        try:
            tables = execute_statement(
                f"""
                SELECT lower(table_name) AS table_name, table_type
                FROM {catalog}.information_schema.tables
                WHERE lower(table_schema) = 'dbo'
                """.strip()
            )
        except Exception as exc:
            skipped.append(
                {
                    "source_schema": source_schema,
                    "catalog": catalog,
                    "reason": str(exc).splitlines()[0][:220],
                }
            )
            continue

        table_types = {str(row["table_name"]).lower(): str(row.get("table_type") or "") for row in tables}
        usable_tables = [
            table
            for table in sorted(table_types)
            if table in RELEVANT_BASE_TABLES and not table.startswith("v") and table not in LOW_VALUE_SOURCE_TABLES
        ]
        if not usable_tables:
            skipped.append(
                {
                    "source_schema": source_schema,
                    "catalog": catalog,
                    "reason": "No relevant Asset Vision base source tables found.",
                }
            )
            continue

        table_list = ", ".join(sql_quote(table) for table in usable_tables)
        column_rows = execute_statement(
            f"""
            SELECT lower(table_name) AS table_name, column_name, data_type, ordinal_position
            FROM {catalog}.information_schema.columns
            WHERE lower(table_schema) = 'dbo'
              AND lower(table_name) IN ({table_list})
            ORDER BY lower(table_name), ordinal_position
            """.strip()
        )

        grouped_columns: dict[str, list[dict[str, Any]]] = defaultdict(list)
        for row in column_rows:
            grouped_columns[str(row["table_name"]).lower()].append(row)

        for table in usable_tables:
            profile = TABLE_PROFILES.get(
                table,
                {
                    "business_area": "Other source attributes",
                    "cluster": "Other source attributes",
                    "potential": "Potential: source record count and completeness checks.",
                },
            )
            raw_columns = [str(row["column_name"]) for row in grouped_columns.get(table, [])]
            key = f"{source_schema}.{table}"
            columns_by_key[key] = raw_columns
            dim_fields = column_bucket(raw_columns, DIMENSION_TERMS, 12)
            metric_fields = column_bucket(raw_columns, METRIC_TERMS, 12)
            if not dim_fields:
                dim_fields = [friendly_name(col) for col in raw_columns[:6]]
            if not metric_fields:
                metric_fields = ["ID / record count where ID exists"] if any(col.lower() == "id" for col in raw_columns) else []

            schema_rows.append(
                {
                    "Schema Name": source_schema,
                    "Table Name": table,
                    "Business Area / Subject": profile["business_area"],
                    "Attribute Cluster": profile["cluster"],
                    "Dimension Attributes": ", ".join(dim_fields),
                    "Metric Attributes": ", ".join(metric_fields) if metric_fields else "No obvious numeric/date metric fields found in metadata",
                    "Example Values or Field Examples": "Field examples: " + ", ".join(friendly_name(col) for col in raw_columns[:8]),
                    "Potential Additional Metrics": profile["potential"],
                    "Notes / Assumptions": f"Source catalog {catalog}.dbo.{table}; base source table only; source views and transport/reporting schemas excluded.",
                    "_catalog": catalog,
                    "_source_label": label,
                    "_column_count": len(raw_columns),
                    "_table_type": table_types.get(table, ""),
                }
            )

    return schema_rows, columns_by_key, skipped


def expression_for(columns: list[str], column_name: str, default_value: str) -> str:
    by_lower = {column.lower(): column for column in columns}
    actual = by_lower.get(column_name.lower())
    if actual:
        return f"COALESCE(NULLIF(TRIM(CAST(a.{actual} AS STRING)), ''), {sql_quote(default_value)})"
    return sql_quote(default_value)


def non_blank_count_expr(columns: list[str], column_name: str) -> str:
    by_lower = {column.lower(): column for column in columns}
    actual = by_lower.get(column_name.lower())
    if not actual:
        return "0"
    return f"SUM(CASE WHEN NULLIF(TRIM(CAST(a.{actual} AS STRING)), '') IS NOT NULL THEN 1 ELSE 0 END)"


def deleted_filter(columns: list[str]) -> str:
    by_lower = {column.lower(): column for column in columns}
    actual = by_lower.get("deleted")
    if not actual:
        return "1 = 1"
    return f"COALESCE(a.{actual}, false) = false"


def collect_asset_summary(schema_rows: list[dict[str, Any]], columns_by_key: dict[str, list[str]]) -> list[dict[str, Any]]:
    branches = []
    table_rows = {
        (row["Schema Name"], row["Table Name"]): row
        for row in schema_rows
    }
    for source_schema, catalog, label in SOURCE_CONTEXTS:
        row = table_rows.get((source_schema, "asset"))
        columns = columns_by_key.get(f"{source_schema}.asset", [])
        if not row or not columns:
            continue
        contractor_expr = expression_for(columns, "Contract", label)
        asset_type_expr = expression_for(columns, "AssetType", "Unspecified asset type")
        category_expr = expression_for(columns, "Classification", "Unclassified")
        region_expr = expression_for(columns, "Region", "Not supplied")
        id_expr = "CAST(a.ID AS STRING)" if any(col.lower() == "id" for col in columns) else "CONCAT('row-', monotonically_increasing_id())"
        condition_count = non_blank_count_expr(columns, "AssetCondition")
        criticality_count = non_blank_count_expr(columns, "AssetCriticality")
        risk_count = non_blank_count_expr(columns, "AssetRisk")
        branches.append(
            f"""
            SELECT
              {sql_quote(label)} AS contractor_source,
              {sql_quote(source_schema)} AS source_schema,
              {sql_quote(catalog)} AS source_catalog,
              {contractor_expr} AS contractor,
              {asset_type_expr} AS asset_type,
              {category_expr} AS asset_category,
              {region_expr} AS location_region,
              COUNT(DISTINCT {id_expr}) AS asset_count,
              {condition_count} AS condition_populated_count,
              {criticality_count} AS criticality_populated_count,
              {risk_count} AS risk_populated_count
            FROM {catalog}.dbo.asset a
            WHERE {deleted_filter(columns)}
            GROUP BY
              {contractor_expr},
              {asset_type_expr},
              {category_expr},
              {region_expr}
            """
        )

    if not branches:
        return []

    sql = "\nUNION ALL\n".join(branches)
    rows = execute_statement(sql)
    output = []
    for row in rows:
        asset_count = int(float(row.get("asset_count") or 0))
        if asset_count <= 0:
            continue
        condition_count = int(float(row.get("condition_populated_count") or 0))
        criticality_count = int(float(row.get("criticality_populated_count") or 0))
        risk_count = int(float(row.get("risk_populated_count") or 0))
        notes = []
        if str(row.get("location_region") or "").strip().lower() == "not supplied":
            notes.append("Region not supplied in source asset row.")
        if condition_count == 0 and criticality_count == 0 and risk_count == 0:
            notes.append("No condition/criticality/risk values populated for this group.")
        else:
            notes.append(
                f"Condition populated {condition_count:,}; criticality {criticality_count:,}; risk {risk_count:,}."
            )
        output.append(
            {
                "Contractor": row.get("contractor") or row.get("contractor_source"),
                "Asset Type": row.get("asset_type") or "Unspecified asset type",
                "Asset Category": row.get("asset_category") or "Unclassified",
                "Asset Count": asset_count,
                "Location / Region / State if available": row.get("location_region") or "Not supplied",
                "Source Schema": row.get("source_schema"),
                "Source Table": "asset",
                "Notes / Data Quality Issues": " ".join(notes),
                "_contractor_source": row.get("contractor_source"),
            }
        )

    output.sort(key=lambda item: (str(item["Contractor"]), -int(item["Asset Count"]), str(item["Asset Type"])))
    return output


def main() -> int:
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    schema_rows, columns_by_key, skipped = collect_metadata()
    asset_rows = collect_asset_summary(schema_rows, columns_by_key)
    data = {
        "generated_at_utc": datetime.now(timezone.utc).isoformat(timespec="seconds"),
        "profile": PROFILE,
        "warehouse_id": WAREHOUSE_ID,
        "source_contexts_requested": [
            {"source_schema": context, "catalog": catalog, "label": label}
            for context, catalog, label in SOURCE_CONTEXTS
        ],
        "schema_summary": [
            {key: value for key, value in row.items() if not key.startswith("_")}
            for row in schema_rows
        ],
        "contractor_assets": [
            {key: value for key, value in row.items() if not key.startswith("_")}
            for row in asset_rows
        ],
        "skipped_source_contexts": skipped,
        "validation": {
            "only_source_tables_used": True,
            "excluded_schema_prefixes": ["transport_", "stg_enterprise_reporting", "reporting", "curated"],
            "excluded_tables": sorted(LOW_VALUE_SOURCE_TABLES),
            "excluded_views": True,
            "source_tables_used_for_asset_counts": sorted({f"{row['Source Schema']}.{row['Source Table']}" for row in asset_rows}),
            "schema_summary_rows": len(schema_rows),
            "contractor_asset_rows": len(asset_rows),
            "asset_count_total": sum(int(row["Asset Count"]) for row in asset_rows),
        },
    }
    output_path = OUT_DIR / "source_table_workbook_data.json"
    output_path.write_text(json.dumps(data, indent=2, ensure_ascii=False), encoding="utf-8")
    print(json.dumps(data["validation"], indent=2, ensure_ascii=False))
    if skipped:
        print("Skipped source contexts:")
        for item in skipped:
            print(f"- {item['source_schema']}: {item['reason']}")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except Exception as exc:
        print(f"ERROR: {exc}", file=sys.stderr)
        raise SystemExit(1)
