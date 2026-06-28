from __future__ import annotations

import csv
import json
from collections import defaultdict
from datetime import datetime, timezone
from pathlib import Path
from typing import Any

from collect_source_data import (
    DIMENSION_TERMS,
    LOW_VALUE_SOURCE_TABLES,
    METRIC_TERMS,
    RELEVANT_BASE_TABLES,
    SOURCE_CONTEXTS,
    TABLE_PROFILES,
    column_bucket,
    friendly_name,
)


ROOT = Path(__file__).resolve().parent
PROJECT_ROOT = ROOT.parents[1]
OUT_DIR = ROOT / "data"
CACHE_DIR = PROJECT_ROOT / "analysis" / "databricks-validation" / "four-vs-out"
ASSET_GEO_PATH = PROJECT_ROOT / "analysis" / "transport-asset-geo-map" / "output" / "transport_asset_geo_aggregated.json"


CATALOG_TO_CONTEXT = {catalog: context for context, catalog, _label in SOURCE_CONTEXTS}
CATALOG_TO_LABEL = {catalog: label for _context, catalog, label in SOURCE_CONTEXTS}


def read_csv(path: Path) -> list[dict[str, str]]:
    with path.open("r", encoding="utf-8-sig", newline="") as handle:
        return list(csv.DictReader(handle))


def int_value(value: Any) -> int:
    if value in (None, ""):
        return 0
    return int(float(str(value).replace(",", "")))


def load_source_metadata() -> tuple[list[dict[str, str]], list[dict[str, str]], dict[tuple[str, str, str], dict[str, str]]]:
    inventory = [
        row
        for row in read_csv(CACHE_DIR / "table_inventory.csv")
        if row.get("table_family") == "source"
        and row.get("schema_name") == "dbo"
        and row.get("catalog_name", "").startswith("ext_mssql_asset_vision")
        and not row.get("table_name", "").lower().startswith("v")
        and row.get("table_name", "").lower() in RELEVANT_BASE_TABLES
        and row.get("table_name", "").lower() not in LOW_VALUE_SOURCE_TABLES
    ]
    columns = [
        row
        for row in read_csv(CACHE_DIR / "table_columns.csv")
        if row.get("table_family") == "source"
        and row.get("schema_name") == "dbo"
        and row.get("catalog_name", "").startswith("ext_mssql_asset_vision")
        and not row.get("table_name", "").lower().startswith("v")
        and row.get("table_name", "").lower() in RELEVANT_BASE_TABLES
        and row.get("table_name", "").lower() not in LOW_VALUE_SOURCE_TABLES
    ]
    metrics = {}
    for row in read_csv(CACHE_DIR / "four_vs_table_metrics.csv"):
        if (
            row.get("table_family") == "source"
            and row.get("schema_name") == "dbo"
            and row.get("catalog_name", "").startswith("ext_mssql_asset_vision")
            and not row.get("table_name", "").lower().startswith("v")
        ):
            metrics[(row["catalog_name"], row["schema_name"], row["table_name"].lower())] = row
    return inventory, columns, metrics


def build_schema_summary() -> list[dict[str, Any]]:
    inventory, columns, metrics = load_source_metadata()
    columns_by_table: dict[tuple[str, str, str], list[str]] = defaultdict(list)
    for row in columns:
        key = (row["catalog_name"], row["schema_name"], row["table_name"].lower())
        columns_by_table[key].append(row["column_name"])

    output = []
    for row in sorted(inventory, key=lambda item: (item["catalog_name"], item["table_name"])):
        table = row["table_name"].lower()
        catalog = row["catalog_name"]
        key = (catalog, row["schema_name"], table)
        raw_columns = columns_by_table.get(key, [])
        metric_row = metrics.get(key, {})
        profile = TABLE_PROFILES.get(
            table,
            {
                "business_area": "Other source attributes",
                "cluster": "Other source attributes",
                "potential": "Potential: source record count and completeness checks.",
            },
        )
        dim_fields = column_bucket(raw_columns, DIMENSION_TERMS, 12)
        metric_fields = column_bucket(raw_columns, METRIC_TERMS, 12)
        if not dim_fields:
            dim_fields = [friendly_name(col) for col in raw_columns[:6]]
        if not metric_fields and any(col.lower() == "id" for col in raw_columns):
            metric_fields = ["ID / record count"]

        source_schema = CATALOG_TO_CONTEXT.get(catalog, catalog)
        row_count = int_value(metric_row.get("row_count"))
        latest_ts = metric_row.get("latest_observed_ts") or ""
        velocity = metric_row.get("inferred_velocity") or "Not assessed in cached metadata"
        notes = [
            f"Cached Databricks source extract from {catalog}.dbo.{table}.",
            "Base source table; source views, transport schemas, reporting schemas and curated tables excluded.",
        ]
        if latest_ts:
            notes.append(f"Latest observed timestamp in cached metrics: {latest_ts}.")
        if row_count:
            notes.append(f"Cached source row count: {row_count:,}.")

        output.append(
            {
                "Schema Name": source_schema,
                "Table Name": table,
                "Business Area / Subject": profile["business_area"],
                "Attribute Cluster": profile["cluster"],
                "Dimension Attributes": ", ".join(dim_fields),
                "Metric Attributes": ", ".join(metric_fields) if metric_fields else "No obvious numeric/date metric fields found in cached metadata",
                "Example Values or Field Examples": "Field examples: " + ", ".join(friendly_name(col) for col in raw_columns[:8]),
                "Potential Additional Metrics": profile["potential"],
                "Notes / Assumptions": " ".join(notes),
                "Cached Row Count": row_count,
                "Cached Freshness / Velocity": velocity,
            }
        )
    return output


def build_contractor_assets() -> list[dict[str, Any]]:
    data = json.loads(ASSET_GEO_PATH.read_text(encoding="utf-8"))
    output = []
    for row in data.get("classes", []):
        asset_count = int_value(row.get("asset_count"))
        if asset_count <= 0:
            continue
        classification_count = int_value(row.get("classification_count"))
        geocoded_rows = int_value(row.get("geocoded_rows"))
        location_note = "Region/state not available in cached source asset summary"
        if geocoded_rows:
            location_note = f"No region/state field in cached summary; {geocoded_rows:,} geocoded asset-location rows available"
        output.append(
            {
                "Contractor": row.get("project") or row.get("source_label") or row.get("source_context"),
                "Asset Type": row.get("asset_type") or "Unspecified asset type",
                "Asset Category": "Not separated in cached summary",
                "Asset Count": asset_count,
                "Location / Region / State if available": location_note,
                "Source Schema": row.get("source_context"),
                "Source Table": "dbo.asset",
                "Notes / Data Quality Issues": (
                    f"Asset count is grouped from cached source-only aggregation. "
                    f"Classification values exist in source but are not broken out here; classification count for this group: {classification_count:,}. "
                    f"Geocoded rows from source location extract: {geocoded_rows:,}."
                ),
            }
        )
    output.sort(key=lambda item: (str(item["Contractor"]), -int(item["Asset Count"]), str(item["Asset Type"])))
    return output


def main() -> int:
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    schema_summary = build_schema_summary()
    contractor_assets = build_contractor_assets()
    data = {
        "generated_at_utc": datetime.now(timezone.utc).isoformat(timespec="seconds"),
        "source_basis": {
            "metadata_cache": str(CACHE_DIR),
            "asset_summary_cache": str(ASSET_GEO_PATH),
            "note": "Prepared from cached Databricks extracts after live Databricks auth/network calls failed in this session.",
        },
        "schema_summary": schema_summary,
        "contractor_assets": contractor_assets,
        "validation": {
            "only_source_tables_used": True,
            "excluded_transport_contract_reporting_curated": True,
            "schema_summary_rows": len(schema_summary),
            "contractor_asset_rows": len(contractor_assets),
            "asset_count_total": sum(int(row["Asset Count"]) for row in contractor_assets),
            "source_schemas": sorted({row["Schema Name"] for row in schema_summary}),
            "contractor_asset_source_schemas": sorted({row["Source Schema"] for row in contractor_assets}),
            "source_tables_used_for_asset_counts": ["dbo.asset"],
            "asset_category_limitation": "Asset category/classification exists in source metadata, but cached asset summary is grouped by AssetType only.",
            "location_limitation": "Region/state was not available in cached asset summary; geocoded row coverage is included in notes.",
        },
    }
    output_path = OUT_DIR / "source_table_workbook_data.json"
    output_path.write_text(json.dumps(data, indent=2, ensure_ascii=False), encoding="utf-8")
    print(json.dumps(data["validation"], indent=2, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
