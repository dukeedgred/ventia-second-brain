from __future__ import annotations

import json
from collections import defaultdict
from pathlib import Path
from typing import Any


ROOT = Path(__file__).resolve().parent
OUT_DIR = ROOT / "data"
ASSET_DATA_PATH = OUT_DIR / "source_table_workbook_data.json"
OUTPUT_PATH = OUT_DIR / "source_table_workbook_revised_data.json"


ASSET_FAMILY_RULES = [
    ("Signs and linemarking", ["sign", "line", "linemark", "rrpm", "marker", "pavement marking"]),
    ("Drainage and stormwater", ["drain", "storm", "pit", "pipe", "culvert", "water", "channel"]),
    ("Roads, pavement and surfacing", ["road", "pavement", "sealed", "surface", "lane", "carriageway", "shoulder", "kerb"]),
    ("Safety barriers and roadside protection", ["barrier", "guardrail", "fence", "fencing", "crash", "attenuator", "bollard", "safety"]),
    ("Structures and civil assets", ["bridge", "structure", "wall", "retaining", "embankment", "slope", "tunnel", "gantry"]),
    ("Electrical, lighting and ITS", ["light", "lamp", "electrical", "its", "cctv", "camera", "vms", "signal", "fan", "device", "sensor"]),
    ("Pathways, crossings and public realm", ["footpath", "pathway", "path", "crossing", "pedestrian", "vegetation", "landscape", "tree", "berm"]),
]


DOMAIN_BY_TABLE = {
    "asset": "Asset register / hierarchy",
    "assetarea": "Location / geography",
    "assetattribute": "Asset custom attributes",
    "assetclassification": "Asset register / hierarchy",
    "assethierarchy": "Asset hierarchy",
    "assetlocation": "Location / geography",
    "assetaudit": "Audit / change history",
    "capitalwork": "Capital works",
    "capitalworktask": "Capital works",
    "contractreference": "Contract reference",
    "custommoduleitem": "Forms / modules",
    "formfield": "Forms / modules",
    "inspection": "Inspections",
    "inspectionrelation": "Inspections",
    "inspectionstatus": "Workflow / status",
    "job": "Jobs / work orders",
    "jobasset": "Jobs / work orders",
    "jobcomment": "Jobs / work orders",
    "module": "Forms / modules",
    "photo": "Photos / evidence",
    "plannedresourceitem": "Resources / labour",
    "resource": "Resources / labour",
    "resourceattribute": "Resources / labour",
    "resourceaudit": "Resources / labour",
    "timesheetitem": "Resources / labour",
    "workflowstatus": "Workflow / status",
}


def int_value(value: Any) -> int:
    if value in (None, ""):
        return 0
    return int(float(str(value).replace(",", "")))


def asset_family(asset_type: str) -> str:
    text = asset_type.lower()
    for family, terms in ASSET_FAMILY_RULES:
        if any(term in text for term in terms):
            return family
    return "Other / source-specific"


def compact_counts(rows: list[tuple[str, int]], limit: int = 5) -> str:
    parts = [f"{name} ({count:,})" for name, count in rows[:limit]]
    remaining = sum(count for _name, count in rows[limit:])
    if remaining:
        parts.append(f"Other ({remaining:,})")
    return "; ".join(parts)


def source_label_lookup(base_data: dict[str, Any]) -> dict[str, str]:
    labels = {}
    for row in base_data.get("source_contexts_requested", []):
        labels[row["source_schema"]] = row.get("label") or row["source_schema"]
    return labels


def build_schema_summary(base_data: dict[str, Any]) -> list[dict[str, Any]]:
    labels = source_label_lookup(base_data)
    rows_by_schema: dict[str, list[dict[str, Any]]] = defaultdict(list)
    for row in base_data["schema_summary"]:
        rows_by_schema[row["Schema Name"]].append(row)

    asset_rows_by_schema: dict[str, list[dict[str, Any]]] = defaultdict(list)
    for row in base_data["contractor_assets"]:
        asset_rows_by_schema[row["Source Schema"]].append(row)

    skipped = {
        row.get("source_schema"): row.get("reason", "")
        for row in base_data.get("skipped_source_contexts", [])
    }

    output = []
    for schema in sorted(set(rows_by_schema) | set(asset_rows_by_schema)):
        schema_rows = rows_by_schema.get(schema, [])
        asset_rows = asset_rows_by_schema.get(schema, [])
        table_names = sorted({row["Table Name"] for row in schema_rows})
        domains = sorted({DOMAIN_BY_TABLE.get(table, "Other source attributes") for table in table_names})
        total_assets = sum(int_value(row["Asset Count"]) for row in asset_rows)
        asset_types = {row["Asset Type"] for row in asset_rows}
        asset_categories = {
            row["Asset Category"]
            for row in asset_rows
            if row.get("Asset Category") and row["Asset Category"] != "Not separated in cached summary"
        }

        existing_metrics = []
        if "asset" in table_names or total_assets:
            existing_metrics.append("Asset inventory counts by source Contract, AssetType, Classification and Region where populated.")
        if {"assetlocation", "assetarea"} & set(table_names):
            existing_metrics.append("Location signals from asset location/area tables, chainage, direction and spatial/location fields.")
        if "inspection" in table_names:
            existing_metrics.append("Inspection counts, status/type fields, scheduled and completed date signals.")
        if "job" in table_names:
            existing_metrics.append("Job/work-order counts, due/scheduled/completed dates, priority, compliance, made-safe and quantity fields.")
        if {"capitalwork", "capitalworktask"} & set(table_names):
            existing_metrics.append("Capital works/task counts, planned/actual dates, cost and quantity fields.")
        if {"workflowstatus", "inspectionstatus"} & set(table_names):
            existing_metrics.append("Workflow/status counts and status-date ageing signals.")
        if "photo" in table_names:
            existing_metrics.append("Photo/evidence record counts and source-object links.")
        if {"resource", "resourceattribute", "plannedresourceitem", "timesheetitem"} & set(table_names):
            existing_metrics.append("Resource/labour records, timesheet quantity/cost/time fields where populated.")
        if {"module", "custommoduleitem", "formfield"} & set(table_names):
            existing_metrics.append("Custom module/form-field usage and contract-specific attributes.")

        data_gaps = []
        if schema in skipped:
            data_gaps.append(f"Skipped in live extract: {skipped[schema]}")
        if not table_names:
            data_gaps.append("No source tables found in live extraction.")
        if total_assets == 0:
            data_gaps.append("No source asset rows in live grouped asset extract.")
        if not asset_categories:
            data_gaps.append("No populated asset category/classification values in grouped asset extract.")
        data_gaps.append("Source views and transport/reporting/curated schemas are intentionally excluded.")

        output.append(
            {
                "Source Schema": schema,
                "Contract / Source Context": labels.get(schema, schema),
                "Source Tables Reviewed": len(table_names),
                "Asset Count": total_assets,
                "Asset Type Count": len(asset_types),
                "Asset Category Count": len(asset_categories),
                "Business Domains Covered": "; ".join(domains),
                "Useful Existing Metrics / Signals": " ".join(existing_metrics),
                "Useful Dimensions": "Contract/project, AssetType, Classification, Region, status, priority, activity, asset/job/inspection/resource identifiers where present.",
                "Potential Metrics": "Potential: overdue job/inspection rate, completion rate, SLA breach proxy, repeat jobs per asset, condition/risk profile, evidence coverage, capital works slippage, missing-location rate.",
                "Data Gaps / Assumptions": " ".join(data_gaps),
            }
        )
    return output


def build_contractor_asset_summary(base_data: dict[str, Any]) -> list[dict[str, Any]]:
    grouped: dict[str, dict[str, Any]] = {}
    for row in base_data["contractor_assets"]:
        contractor = row["Contractor"]
        grouped.setdefault(
            contractor,
            {
                "Contractor / Source Contract": contractor,
                "sources": set(),
                "asset_types": defaultdict(int),
                "asset_categories": defaultdict(int),
                "families": defaultdict(int),
                "regions": defaultdict(int),
                "total_assets": 0,
                "notes": [],
            },
        )
        bucket = grouped[contractor]
        count = int_value(row["Asset Count"])
        asset_type = row["Asset Type"] or "Unspecified asset type"
        category = row["Asset Category"] or "Unclassified"
        region = row.get("Location / Region / State if available") or "Not supplied"
        bucket["sources"].add(row["Source Schema"])
        bucket["asset_types"][asset_type] += count
        bucket["asset_categories"][category] += count
        bucket["families"][asset_family(asset_type)] += count
        bucket["regions"][region] += count
        bucket["total_assets"] += count
        if "," in contractor:
            bucket["notes"].append("Source Contract value contains multiple labels; kept as-is from source.")

    output = []
    for contractor, bucket in grouped.items():
        family_rows = sorted(bucket["families"].items(), key=lambda item: item[1], reverse=True)
        type_rows = sorted(bucket["asset_types"].items(), key=lambda item: item[1], reverse=True)
        category_rows = sorted(bucket["asset_categories"].items(), key=lambda item: item[1], reverse=True)
        region_rows = sorted(bucket["regions"].items(), key=lambda item: item[1], reverse=True)
        dominant_family, dominant_count = family_rows[0] if family_rows else ("Not classified", 0)
        location_values = [name for name, _count in region_rows if name != "Not supplied"]
        notes = sorted(set(bucket["notes"]))
        notes.append("Asset families are keyword-grouped from source AssetType values for comparison.")
        if not location_values:
            notes.append("Region/state is not populated for this contractor in the source asset grouping.")
        output.append(
            {
                "Contractor / Source Contract": contractor,
                "Source Schema(s)": ", ".join(sorted(bucket["sources"])),
                "Total Assets": bucket["total_assets"],
                "Asset Type Count": len(bucket["asset_types"]),
                "Asset Category Count": len([name for name in bucket["asset_categories"] if name != "Unclassified"]),
                "Dominant Asset Family": f"{dominant_family} ({dominant_count:,})",
                "Asset Family Mix": compact_counts(family_rows, 5),
                "Top Asset Types": compact_counts(type_rows, 8),
                "Top Source Asset Categories": compact_counts(category_rows, 6),
                "Location / Region Coverage": compact_counts(region_rows, 5),
                "Notes / Data Quality Issues": " ".join(notes),
            }
        )
    output.sort(key=lambda item: int_value(item["Total Assets"]), reverse=True)
    return output


def main() -> int:
    base_data = json.loads(ASSET_DATA_PATH.read_text(encoding="utf-8"))
    schema_summary = build_schema_summary(base_data)
    contractor_assets = build_contractor_asset_summary(base_data)
    revised = {
        "schema_summary": schema_summary,
        "contractor_assets": contractor_assets,
        "validation": {
            "only_source_tables_used": True,
            "schema_rows": len(schema_summary),
            "contractor_rows": len(contractor_assets),
            "total_assets": sum(int_value(row["Total Assets"]) for row in contractor_assets),
            "source_tables_for_asset_summary": "dbo.asset grouped live from Databricks source catalogs",
            "excluded": "transport_* schemas, reporting schemas, curated tables, derived contract views, raw row-level IDs",
        },
    }
    OUTPUT_PATH.write_text(json.dumps(revised, indent=2, ensure_ascii=False), encoding="utf-8")
    print(json.dumps(revised["validation"], indent=2, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
