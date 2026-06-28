from __future__ import annotations

import argparse
import csv
import html
import json
import math
import os
import re
from collections import Counter, defaultdict
from datetime import datetime
from pathlib import Path
from typing import Any


BASE_DIR = Path(__file__).resolve().parent
QUERY_PATH = BASE_DIR / "source-query.sql"
OUTPUT_PATH = BASE_DIR / "index.html"
SOURCE_TABLE = "ext_mssql_asset_vision_vsm_gen7.dbo.vjob"
SELECTED_CONTRACT = "VentureSmart"
REPORT_NOW = datetime(2022, 7, 31)
MONTHS = ["2022-01", "2022-02", "2022-03", "2022-04", "2022-05"]


QUERY_COLUMNS = [
    "ID",
    "Contract",
    "Region",
    "AssetID",
    "AssetCode",
    "AssetName",
    "AssetTypeName",
    "Section",
    "Area",
    "Classification",
    "HazardDefectCode",
    "HazardCode",
    "ActivityCategoryName",
    "ActivityName",
    "ActivityType",
    "InterventionName",
    "Priority",
    "CreatedDate",
    "DueDate",
    "ScheduledStart",
    "ScheduledEnd",
    "CompletedDate",
    "CompletedStatus",
    "Compliant",
    "MadeSafe",
    "MadeSafeDateUTC",
    "CurrentWorkflowItemCode",
    "CurrentWorkflowItemName",
    "MergedJobID",
    "LinkedJobID",
    "EstimatedQuantity",
    "ActualQuantity",
    "RemainingQuantity",
    "EstimatedLength",
    "EstimatedWidth",
    "EstimatedDepth",
    "Direction",
    "ReferencePointTypeName",
    "ReferencePointName",
    "EndReferencePointTypeName",
    "EndReferencePointName",
    "ChainageFrom",
    "ChainageTo",
    "DistancePast",
    "EndDistancePast",
    "Unit",
    "Reference1",
    "Reference2",
    "Comments",
    "WKT",
]

GRANULAR_COLUMNS = [
    "AssetTypeName",
    "Area",
    "Section",
    "Direction",
    "ReferencePointName",
    "EndReferencePointName",
    "ChainageFrom",
    "ChainageTo",
    "HazardDefectCode",
    "ActivityName",
    "Classification",
]


AREA_CONTEXT = {
    "South St / Benningfield Rd": {
        "AssetID": 70070,
        "AssetCode": "CCTV00070",
        "AssetName": "South St and Benningfield Rd (East Bound)",
        "AssetTypeName": "CCTV camera",
        "Section": "Perth metropolitan ITS",
        "Area": "South St / Benningfield Rd",
        "Classification": "Preventative maintenance",
        "HazardDefectCode": "PMCC.PM",
        "HazardCode": "PMCC",
        "ActivityCategoryName": "ITS maintenance",
        "ActivityName": "Preventative Maintenance",
        "ActivityType": "CCTV planned maintenance",
        "InterventionName": "Camera inspection and maintenance",
        "Priority": "Medium",
        "Direction": "East Bound",
        "ReferencePointTypeName": "Intersection",
        "ReferencePointName": "South St",
        "EndReferencePointTypeName": "Intersection",
        "EndReferencePointName": "Benningfield Rd",
        "ChainageFrom": 1200,
        "ChainageTo": 1260,
        "EstimatedLength": 60,
        "EstimatedWidth": 1,
        "EstimatedDepth": 0,
    },
    "Stock Rd / Leach Hwy": {
        "AssetID": 70076,
        "AssetCode": "CCTV00076",
        "AssetName": "Stock Rd and Leach Hwy (West Bound)",
        "AssetTypeName": "CCTV camera",
        "Section": "Fremantle corridor ITS",
        "Area": "Stock Rd / Leach Hwy",
        "Classification": "Preventative maintenance",
        "HazardDefectCode": "PMES.PM",
        "HazardCode": "PMES",
        "ActivityCategoryName": "Electrical systems maintenance",
        "ActivityName": "Preventative Maintenance",
        "ActivityType": "CCTV electrical service",
        "InterventionName": "Electrical service and inspection",
        "Priority": "Medium",
        "Direction": "West Bound",
        "ReferencePointTypeName": "Road",
        "ReferencePointName": "Stock Rd",
        "EndReferencePointTypeName": "Road",
        "EndReferencePointName": "Leach Hwy",
        "ChainageFrom": 2140,
        "ChainageTo": 2210,
        "EstimatedLength": 70,
        "EstimatedWidth": 1,
        "EstimatedDepth": 0,
    },
    "Roe Hwy / Orrong Rd": {
        "AssetID": 70078,
        "AssetCode": "CCTV00078",
        "AssetName": "Roe Hwy and Rivervale Wattle Grove Link (Orrong Rd) (North Bound)",
        "AssetTypeName": "CCTV camera",
        "Section": "Roe Highway ITS",
        "Area": "Roe Hwy / Orrong Rd",
        "Classification": "Preventative maintenance",
        "HazardDefectCode": "PMHP.PM",
        "HazardCode": "PMHP",
        "ActivityCategoryName": "High-priority ITS maintenance",
        "ActivityName": "Preventative Maintenance",
        "ActivityType": "CCTV health check",
        "InterventionName": "Camera health and pole inspection",
        "Priority": "Medium",
        "Direction": "North Bound",
        "ReferencePointTypeName": "Highway",
        "ReferencePointName": "Roe Hwy",
        "EndReferencePointTypeName": "Road",
        "EndReferencePointName": "Orrong Rd",
        "ChainageFrom": 3380,
        "ChainageTo": 3460,
        "EstimatedLength": 80,
        "EstimatedWidth": 1,
        "EstimatedDepth": 0,
    },
}


ROW_SPECS = [
    ("South St / Benningfield Rd", 38383, "2022-01-12", "2022-01-21", "2022-01-25", "Complete", "No", 1.0, 0.0, 115.850, -32.061),
    ("South St / Benningfield Rd", 38386, "2022-01-28", "2022-02-07", "2022-02-04", "Complete", "Yes", 1.0, 0.0, 115.852, -32.058),
    ("South St / Benningfield Rd", 38391, "2022-02-14", "2022-02-23", "2022-02-28", "Complete", "No", 1.5, -0.5, 115.846, -32.063),
    ("South St / Benningfield Rd", 38402, "2022-03-03", "2022-03-14", "2022-03-19", "Complete", "No", 1.0, 0.0, 115.856, -32.060),
    ("South St / Benningfield Rd", 38416, "2022-03-29", "2022-04-07", "2022-04-12", "Complete", "No", 2.5, -1.5, 115.858, -32.064),
    ("South St / Benningfield Rd", 38429, "2022-04-11", "2022-04-21", "2022-04-26", "Complete", "Yes", 1.0, 0.0, 115.851, -32.066),
    ("South St / Benningfield Rd", 38437, "2022-04-30", "2022-05-09", "2022-05-17", "Complete", "No", 1.0, 0.0, 115.849, -32.059),
    ("South St / Benningfield Rd", 38445, "2022-05-16", "2022-05-27", "2022-06-09", "Complete", "No", 1.5, -0.5, 115.854, -32.057),
    ("South St / Benningfield Rd", 38451, "2022-05-28", "2022-06-08", "", "In Progress", "No", 0.0, 1.0, 115.847, -32.065),
    ("Stock Rd / Leach Hwy", 38384, "2022-01-08", "2022-01-18", "2022-01-20", "Complete", "No", 1.0, 0.0, 115.792, -32.043),
    ("Stock Rd / Leach Hwy", 38389, "2022-02-04", "2022-02-14", "2022-02-12", "Complete", "Yes", 1.0, 0.0, 115.795, -32.045),
    ("Stock Rd / Leach Hwy", 38397, "2022-02-19", "2022-03-01", "2022-03-05", "Complete", "No", 1.5, -0.5, 115.789, -32.046),
    ("Stock Rd / Leach Hwy", 38404, "2022-03-12", "2022-03-22", "2022-03-20", "Complete", "Yes", 1.0, 0.0, 115.797, -32.041),
    ("Stock Rd / Leach Hwy", 38419, "2022-04-05", "2022-04-15", "2022-04-23", "Complete", "No", 1.0, 0.0, 115.791, -32.039),
    ("Stock Rd / Leach Hwy", 38431, "2022-05-03", "2022-05-13", "2022-05-12", "Complete", "Yes", 1.0, 0.0, 115.794, -32.047),
    ("Stock Rd / Leach Hwy", 38447, "2022-05-24", "2022-06-03", "2022-06-09", "Complete", "No", 2.5, -1.5, 115.788, -32.044),
    ("Roe Hwy / Orrong Rd", 38385, "2022-01-20", "2022-01-30", "2022-01-27", "Complete", "Yes", 1.0, 0.0, 115.944, -31.973),
    ("Roe Hwy / Orrong Rd", 38393, "2022-02-10", "2022-02-20", "2022-02-24", "Complete", "No", 1.5, -0.5, 115.949, -31.976),
    ("Roe Hwy / Orrong Rd", 38405, "2022-03-08", "2022-03-18", "2022-03-17", "Complete", "Yes", 1.0, 0.0, 115.942, -31.980),
    ("Roe Hwy / Orrong Rd", 38418, "2022-04-02", "2022-04-13", "2022-04-21", "Complete", "No", 1.0, 0.0, 115.952, -31.978),
    ("Roe Hwy / Orrong Rd", 38435, "2022-05-11", "2022-05-22", "2022-05-24", "Complete", "No", 1.0, 0.0, 115.947, -31.970),
    ("Roe Hwy / Orrong Rd", 38449, "2022-05-29", "2022-06-09", "2022-06-02", "Complete", "Yes", 1.0, 0.0, 115.940, -31.975),
]


def build_sample_rows() -> list[dict[str, Any]]:
    rows: list[dict[str, Any]] = []
    for index, spec in enumerate(ROW_SPECS):
        (
            location,
            job_id,
            created_date,
            due_date,
            completed_date,
            completed_status,
            compliant,
            actual_quantity,
            remaining_quantity,
            lon,
            lat,
        ) = spec
        context = AREA_CONTEXT[location]
        chainage_from = context["ChainageFrom"] + (index % 5) * 7
        row = {
            **context,
            "ID": job_id,
            "Contract": SELECTED_CONTRACT,
            "Region": "Western Australia",
            "CreatedDate": created_date,
            "DueDate": due_date,
            "ScheduledStart": created_date,
            "ScheduledEnd": due_date,
            "CompletedDate": completed_date,
            "CompletedStatus": completed_status,
            "Compliant": compliant,
            "MadeSafe": "",
            "MadeSafeDateUTC": "",
            "CurrentWorkflowItemCode": "COMPLETE" if completed_date else "INPROG",
            "CurrentWorkflowItemName": "Complete" if completed_date else "In Progress",
            "MergedJobID": "",
            "LinkedJobID": job_id - 1 if index in {4, 7, 8, 15, 18} else "",
            "EstimatedQuantity": 1.0,
            "ActualQuantity": actual_quantity,
            "RemainingQuantity": remaining_quantity,
            "ChainageFrom": chainage_from,
            "ChainageTo": chainage_from + 12,
            "DistancePast": index % 5,
            "EndDistancePast": (index % 5) + 12,
            "Unit": "each",
            "Reference1": f"{context['ReferencePointName']} camera run",
            "Reference2": f"{context['EndReferencePointName']} approach",
            "Comments": "Offline source-shaped validation row",
            "WKT": f"POINT ({lon:.6f} {lat:.6f})",
            "Deleted": False,
        }
        rows.append(row)
    return rows


def read_query() -> str:
    return QUERY_PATH.read_text(encoding="utf-8")


def load_csv(path: Path) -> list[dict[str, Any]]:
    with path.open("r", encoding="utf-8-sig", newline="") as handle:
        return [dict(row) for row in csv.DictReader(handle)]


def fetch_live_rows(query: str) -> list[dict[str, Any]]:
    try:
        from databricks import sql  # type: ignore
    except ImportError as exc:
        raise RuntimeError("databricks-sql-connector is not installed") from exc

    host = os.getenv("DATABRICKS_SERVER_HOSTNAME") or os.getenv("DATABRICKS_HOST", "")
    http_path = os.getenv("DATABRICKS_HTTP_PATH", "")
    if host.startswith("https://"):
        host = host.removeprefix("https://").rstrip("/")
    if not host or not http_path:
        raise RuntimeError(
            "live mode needs DATABRICKS_SERVER_HOSTNAME or DATABRICKS_HOST, plus DATABRICKS_HTTP_PATH",
        )

    with sql.connect(
        server_hostname=host,
        http_path=http_path,
        auth_type="databricks-oauth",
    ) as connection:
        with connection.cursor() as cursor:
            cursor.execute(query)
            columns = [column[0] for column in cursor.description]
            return [dict(zip(columns, row)) for row in cursor.fetchall()]


def parse_date(value: Any) -> datetime | None:
    if value in (None, ""):
        return None
    if isinstance(value, datetime):
        return value.replace(tzinfo=None)
    text = str(value).strip()
    if not text:
        return None
    text = text.replace("Z", "+00:00")
    try:
        return datetime.fromisoformat(text).replace(tzinfo=None)
    except ValueError:
        try:
            return datetime.strptime(text[:10], "%Y-%m-%d")
        except ValueError:
            return None


def parse_bool(value: Any) -> bool | None:
    if value in (None, ""):
        return None
    if isinstance(value, bool):
        return value
    text = str(value).strip().lower()
    if text in {"true", "1", "yes", "y"}:
        return True
    if text in {"false", "0", "no", "n"}:
        return False
    return None


def parse_float(value: Any) -> float | None:
    if value in (None, ""):
        return None
    try:
        return float(value)
    except (TypeError, ValueError):
        return None


def parse_point_wkt(value: Any) -> tuple[float, float] | None:
    if not value:
        return None
    match = re.search(r"POINT\s*\(\s*([-0-9.]+)\s+([-0-9.]+)\s*\)", str(value), re.IGNORECASE)
    if not match:
        return None
    return float(match.group(1)), float(match.group(2))


def days_between(start: datetime, end: datetime) -> int:
    return round((end - start).total_seconds() / 86400)


def is_non_compliant(row: dict[str, Any]) -> bool:
    return str(row.get("Compliant", "")).strip().lower() == "no"


def is_overdue(row: dict[str, Any]) -> bool:
    due = parse_date(row.get("DueDate"))
    completed = parse_date(row.get("CompletedDate"))
    if not due:
        return False
    if not completed:
        return due < REPORT_NOW
    return completed > due


def days_late(row: dict[str, Any]) -> int:
    due = parse_date(row.get("DueDate"))
    completed = parse_date(row.get("CompletedDate")) or REPORT_NOW
    if not due or completed <= due:
        return 0
    return days_between(due, completed)


def is_bad(row: dict[str, Any]) -> bool:
    return is_non_compliant(row) or is_overdue(row)


def month_key(value: Any) -> str:
    date = parse_date(value)
    return f"{date.year}-{date.month:02d}" if date else ""


def location_label(row: dict[str, Any]) -> str:
    area = str(row.get("Area") or "").strip()
    if area:
        return area
    start = str(row.get("ReferencePointName") or "").strip()
    end = str(row.get("EndReferencePointName") or "").strip()
    if start and end:
        return f"{start} / {end}"
    return start or end or "Unspecified location"


def issue_signature(row: dict[str, Any]) -> str:
    hazard = str(row.get("HazardDefectCode") or row.get("HazardCode") or "Unknown").strip()
    activity = str(row.get("ActivityName") or "Unspecified activity").strip()
    return f"{hazard} | {activity}"


def augment_rows(rows: list[dict[str, Any]]) -> list[dict[str, Any]]:
    augmented: list[dict[str, Any]] = []
    for row in rows:
        next_row = dict(row)
        point = parse_point_wkt(row.get("WKT"))
        if point:
            next_row["_lon"], next_row["_lat"] = point
        else:
            next_row["_lon"] = parse_float(row.get("Longitude"))
            next_row["_lat"] = parse_float(row.get("Latitude"))
        next_row["_location"] = location_label(row)
        next_row["_issue"] = issue_signature(row)
        next_row["_asset_type"] = str(row.get("AssetTypeName") or "Unspecified asset type").strip()
        next_row["_bad"] = is_bad(row)
        next_row["_overdue"] = is_overdue(row)
        next_row["_non_compliant"] = is_non_compliant(row)
        next_row["_days_late"] = days_late(row)
        augmented.append(next_row)
    return augmented


def forecast_monthly(values: list[int]) -> dict[str, Any]:
    n = len(values)
    x_mean = (n - 1) / 2
    y_mean = sum(values) / n if n else 0
    numerator = sum((index - x_mean) * (value - y_mean) for index, value in enumerate(values))
    denominator = sum((index - x_mean) ** 2 for index in range(n))
    slope = numerator / denominator if denominator else 0
    intercept = y_mean - slope * x_mean
    next_value = max(0, intercept + slope * n)
    fitted = [intercept + slope * index for index in range(n)]
    residual = sum(abs(value - fitted[index]) for index, value in enumerate(values)) / n if n else 0
    uncertainty = max(1, math.ceil(residual + abs(slope) * 1.2))
    return {
        "next": next_value,
        "lower": max(0, next_value - uncertainty),
        "upper": next_value + uncertainty,
        "slope": slope,
        "confidence": "Medium" if n >= 6 and residual < 1 else "Low",
    }


def trend_label(slope: float) -> str:
    if slope >= 0.35:
        return "Increasing"
    if slope <= -0.35:
        return "Reducing"
    return "Flat or noisy"


def top_counter_value(rows: list[dict[str, Any]], field: str) -> str:
    counts = Counter(str(row.get(field) or "Unspecified").strip() for row in rows)
    return counts.most_common(1)[0][0] if counts else "Unspecified"


def analyse_areas(rows: list[dict[str, Any]]) -> list[dict[str, Any]]:
    grouped: dict[str, list[dict[str, Any]]] = defaultdict(list)
    for row in rows:
        grouped[row["_location"]].append(row)

    areas: list[dict[str, Any]] = []
    for location, location_rows in grouped.items():
        bad_rows = [row for row in location_rows if row["_bad"]]
        overdue_rows = [row for row in location_rows if row["_overdue"]]
        non_compliant_rows = [row for row in location_rows if row["_non_compliant"]]
        lons = [row["_lon"] for row in location_rows if row.get("_lon") is not None]
        lats = [row["_lat"] for row in location_rows if row.get("_lat") is not None]
        monthly = [
            sum(1 for row in location_rows if row["_bad"] and month_key(row.get("CreatedDate")) == month)
            for month in MONTHS
        ]
        forecast = forecast_monthly(monthly)
        bad_rate = len(bad_rows) / len(location_rows) if location_rows else 0
        issue_counts = Counter(row["_issue"] for row in bad_rows)
        asset_counts = Counter(row["_asset_type"] for row in bad_rows)
        avg_days_late = (
            sum(row["_days_late"] for row in overdue_rows) / len(overdue_rows) if overdue_rows else 0
        )
        risk_band = "high" if len(bad_rows) >= 5 or bad_rate >= 0.72 else "medium" if len(bad_rows) >= 3 or bad_rate >= 0.55 else "low"
        areas.append(
            {
                "location": location,
                "rows": location_rows,
                "bad_rows": bad_rows,
                "total_jobs": len(location_rows),
                "bad_jobs": len(bad_rows),
                "bad_rate": bad_rate,
                "overdue_jobs": len(overdue_rows),
                "non_compliant_jobs": len(non_compliant_rows),
                "avg_days_late": avg_days_late,
                "centroid": {
                    "lon": sum(lons) / len(lons) if lons else 0,
                    "lat": sum(lats) / len(lats) if lats else 0,
                },
                "monthly": monthly,
                "forecast": forecast,
                "trend": trend_label(forecast["slope"]),
                "risk_band": risk_band,
                "top_issue": issue_counts.most_common(1)[0] if issue_counts else ("No bad jobs", 0),
                "top_asset_type": asset_counts.most_common(1)[0] if asset_counts else ("Unspecified", 0),
                "section": top_counter_value(location_rows, "Section"),
                "direction": top_counter_value(location_rows, "Direction"),
                "reference": top_counter_value(location_rows, "ReferencePointName"),
                "end_reference": top_counter_value(location_rows, "EndReferencePointName"),
                "chainage_from": min(parse_float(row.get("ChainageFrom")) or 0 for row in location_rows),
                "chainage_to": max(parse_float(row.get("ChainageTo")) or 0 for row in location_rows),
            },
        )
    return sorted(
        areas,
        key=lambda item: (-item["bad_jobs"], -item["bad_rate"], -item["avg_days_late"], item["location"]),
    )


def validate_sql(query: str) -> dict[str, Any]:
    missing = [
        column
        for column in QUERY_COLUMNS
        if not re.search(rf"\b{re.escape(column)}\b", query, flags=re.IGNORECASE)
    ]
    checks = {
        "source_table": SOURCE_TABLE.lower() in query.lower(),
        "contract_filter": re.search(r"Contract\s*=\s*'VentureSmart'", query, flags=re.IGNORECASE) is not None,
        "region_filter": re.search(r"Region\s*=\s*'Western Australia'", query, flags=re.IGNORECASE) is not None,
        "wkt_filter": re.search(r"WKT\s+IS\s+NOT\s+NULL", query, flags=re.IGNORECASE) is not None,
        "deleted_filter": "Deleted" in query and "COALESCE" in query.upper(),
    }
    return {"missing_columns": missing, "checks": checks, "valid": not missing and all(checks.values())}


def validate_rows(rows: list[dict[str, Any]], mode: str) -> dict[str, Any]:
    messages: list[str] = []
    warnings: list[str] = []
    failures: list[str] = []
    if not rows:
        failures.append("No rows were returned for validation.")
        return {
            "mode": mode,
            "valid": False,
            "messages": messages,
            "warnings": warnings,
            "failures": failures,
            "counts": {},
        }

    row_columns = set().union(*(row.keys() for row in rows))
    missing_output_columns = [column for column in QUERY_COLUMNS if column not in row_columns]
    if missing_output_columns:
        failures.append("Output is missing required columns: " + ", ".join(missing_output_columns))
    else:
        messages.append("All expected source-query columns are present in the output rows.")

    missing_granular = [
        column for column in GRANULAR_COLUMNS if any(not str(row.get(column) or "").strip() for row in rows)
    ]
    if missing_granular:
        warnings.append(
            "Some rows have blank granular fields: " + ", ".join(sorted(set(missing_granular))),
        )
    else:
        messages.append("Granular asset, issue, and location fields are populated on every row.")

    wrong_contract = [row.get("ID") for row in rows if str(row.get("Contract")) != SELECTED_CONTRACT]
    if wrong_contract:
        failures.append(f"{len(wrong_contract)} rows do not match Contract = {SELECTED_CONTRACT}.")
    else:
        messages.append(f"Every row matches Contract = {SELECTED_CONTRACT}.")

    wrong_region = [row.get("ID") for row in rows if str(row.get("Region")) != "Western Australia"]
    if wrong_region:
        failures.append(f"{len(wrong_region)} rows do not match Region = Western Australia.")
    else:
        messages.append("Every row matches Region = Western Australia.")

    deleted_rows = [row.get("ID") for row in rows if parse_bool(row.get("Deleted")) is True]
    if deleted_rows:
        failures.append(f"{len(deleted_rows)} rows are marked Deleted = true.")

    bad_wkt = [row.get("ID") for row in rows if parse_point_wkt(row.get("WKT")) is None]
    if bad_wkt:
        failures.append(f"{len(bad_wkt)} rows do not have parseable POINT WKT.")
    else:
        messages.append("Every row has parseable POINT WKT for map and location checks.")

    date_errors = [
        row.get("ID")
        for row in rows
        if row.get("DueDate") and parse_date(row.get("DueDate")) is None
    ]
    if date_errors:
        failures.append(f"{len(date_errors)} rows have an invalid DueDate.")

    augmented = augment_rows(rows)
    bad_rows = [row for row in augmented if row["_bad"]]
    if not bad_rows:
        warnings.append("No bad rows were found, so hotspot ranking would be empty.")
    else:
        messages.append(f"{len(bad_rows)} rows qualify as bad using overdue or non-compliant logic.")

    counts = {
        "rows": len(rows),
        "bad_rows": len(bad_rows),
        "overdue_rows": sum(1 for row in augmented if row["_overdue"]),
        "non_compliant_rows": sum(1 for row in augmented if row["_non_compliant"]),
        "locations": len({row["_location"] for row in augmented}),
        "asset_types": len({row["_asset_type"] for row in augmented}),
        "issue_signatures": len({row["_issue"] for row in augmented}),
    }
    if mode == "offline_sample":
        warnings.append(
            "Live Databricks execution was not used; validation ran against source-shaped prototype rows.",
        )
    return {
        "mode": mode,
        "valid": not failures,
        "messages": messages,
        "warnings": warnings,
        "failures": failures,
        "counts": counts,
    }


def pct(value: float) -> str:
    return f"{value * 100:.0f}%"


def fmt(value: Any) -> str:
    if value in (None, ""):
        return "n/a"
    if isinstance(value, float):
        return f"{value:.1f}"
    return str(value)


def esc(value: Any) -> str:
    return html.escape(fmt(value), quote=True)


def render_bad_reasons(row: dict[str, Any]) -> str:
    reasons: list[str] = []
    if row["_non_compliant"]:
        reasons.append("Non-compliant")
    if row["_overdue"]:
        reasons.append("Open overdue" if not row.get("CompletedDate") else "Completed late")
    return ", ".join(reasons) or "None"


def render_validation_panel(sql_validation: dict[str, Any], row_validation: dict[str, Any]) -> str:
    status_class = "ok" if sql_validation["valid"] and row_validation["valid"] else "bad"
    status_text = "Validation passed" if status_class == "ok" else "Validation needs review"
    check_rows = "".join(
        f"<tr><td>{esc(name.replace('_', ' ').title())}</td><td>{'Passed' if passed else 'Failed'}</td></tr>"
        for name, passed in sql_validation["checks"].items()
    )
    messages = row_validation["messages"] + [
        f"SQL selected all required columns: {'yes' if not sql_validation['missing_columns'] else 'no'}",
    ]
    warning_items = row_validation["warnings"] + [
        "Missing SQL columns: " + ", ".join(sql_validation["missing_columns"])
        if sql_validation["missing_columns"]
        else "",
    ]
    failure_items = row_validation["failures"]
    return f"""
      <section class="validation-panel">
        <div class="panel-heading">
          <div>
            <p class="eyebrow">Query and output validation</p>
            <h2>{esc(status_text)}</h2>
          </div>
          <span class="status-pill {status_class}">{esc(row_validation['mode'])}</span>
        </div>
        <div class="validation-grid">
          <div>
            <h3>What I checked</h3>
            <ul>{''.join(f'<li>{esc(item)}</li>' for item in messages if item)}</ul>
          </div>
          <div>
            <h3>Warnings</h3>
            <ul>{''.join(f'<li>{esc(item)}</li>' for item in warning_items if item) or '<li>No warnings.</li>'}</ul>
          </div>
          <div>
            <h3>Failures</h3>
            <ul>{''.join(f'<li>{esc(item)}</li>' for item in failure_items if item) or '<li>No failures.</li>'}</ul>
          </div>
          <div>
            <h3>SQL safeguards</h3>
            <table class="mini-table"><tbody>{check_rows}</tbody></table>
          </div>
        </div>
      </section>
    """


def render_kpis(rows: list[dict[str, Any]], areas: list[dict[str, Any]], validation: dict[str, Any]) -> str:
    bad_rows = [row for row in rows if row["_bad"]]
    next_total = sum(area["forecast"]["next"] for area in areas)
    kpis = [
        ("Rows validated", len(rows), f"{validation['mode']} output"),
        ("Bad jobs", len(bad_rows), f"{pct(len(bad_rows) / len(rows))} of validated jobs"),
        ("Bad locations", len(areas), "Grouped by Area/reference points"),
        ("Asset types", validation["counts"].get("asset_types", 0), "From AssetTypeName"),
        ("Next-month risk", f"{next_total:.1f}", "Bad jobs, low confidence"),
    ]
    return "<section class=\"kpi-grid\">" + "".join(
        f"""
        <article class="kpi-card">
          <span>{esc(label)}</span>
          <strong>{esc(value)}</strong>
          <small>{esc(note)}</small>
        </article>
        """
        for label, value, note in kpis
    ) + "</section>"


def render_map(areas: list[dict[str, Any]]) -> str:
    map_areas: list[dict[str, Any]] = []
    for area in areas:
        centroid = area["centroid"]
        if not centroid["lon"] or not centroid["lat"]:
            continue
        jobs = [
            {
                "id": row.get("ID"),
                "lat": row.get("_lat"),
                "lon": row.get("_lon"),
                "asset_code": row.get("AssetCode"),
                "asset_name": row.get("AssetName"),
                "asset_type": row.get("AssetTypeName"),
                "issue": row.get("_issue"),
                "location": row.get("_location"),
                "direction": row.get("Direction"),
                "chainage_from": row.get("ChainageFrom"),
                "chainage_to": row.get("ChainageTo"),
                "days_late": row.get("_days_late"),
                "reason": render_bad_reasons(row),
            }
            for row in area["bad_rows"]
            if row.get("_lat") is not None and row.get("_lon") is not None
        ]
        map_areas.append(
            {
                "location": area["location"],
                "lat": centroid["lat"],
                "lon": centroid["lon"],
                "bad_jobs": area["bad_jobs"],
                "total_jobs": area["total_jobs"],
                "bad_rate": area["bad_rate"],
                "risk_band": area["risk_band"],
                "top_asset_type": area["top_asset_type"][0],
                "top_issue": area["top_issue"][0],
                "reference": area["reference"],
                "end_reference": area["end_reference"],
                "chainage_from": area["chainage_from"],
                "chainage_to": area["chainage_to"],
                "jobs": jobs,
            },
        )

    if not map_areas:
        return "<section class=\"map-panel\"><p>No mappable points.</p></section>"

    map_json = json.dumps(map_areas).replace("</", "<\\/")
    return f"""
      <section class="map-panel">
        <div class="panel-heading">
          <div>
            <p class="eyebrow">Actual map</p>
            <h2>Bad-area jobs on a dark street basemap</h2>
          </div>
        </div>
        <div class="actual-map-shell">
          <div id="actual-bad-area-map" class="actual-map" role="img" aria-label="Actual street map with bad-area jobs"></div>
          <div class="map-loading-note" id="map-loading-note">Loading dark street map tiles...</div>
        </div>
        <script type="application/json" id="bad-area-map-data">{map_json}</script>
        <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
        <script>
          (() => {{
            const payload = JSON.parse(document.getElementById("bad-area-map-data").textContent);
            const note = document.getElementById("map-loading-note");
            const colours = {{ high: "#f04438", medium: "#f79009", low: "#12b76a" }};
            const h = (value) =>
              String(value ?? "n/a")
                .replaceAll("&", "&amp;")
                .replaceAll("<", "&lt;")
                .replaceAll(">", "&gt;")
                .replaceAll('"', "&quot;")
                .replaceAll("'", "&#039;");
            const mapEl = document.getElementById("actual-bad-area-map");
            if (!window.L) {{
              note.textContent = "The actual map needs browser internet access to load Leaflet and dark map tiles.";
              note.classList.add("visible");
              return;
            }}
            const map = L.map(mapEl, {{
              scrollWheelZoom: true,
              zoomControl: true,
              attributionControl: true,
            }});
            L.tileLayer("https://{{s}}.basemaps.cartocdn.com/dark_all/{{z}}/{{x}}/{{y}}{{r}}.png", {{
              maxZoom: 19,
              attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors &copy; <a href="https://carto.com/attributions">CARTO</a>',
            }}).addTo(map);

            const bounds = [];
            payload.forEach((area) => {{
              const colour = colours[area.risk_band] || colours.low;
              const areaPoint = [area.lat, area.lon];
              bounds.push(areaPoint);
              const radius = 90 + area.bad_jobs * 24;
              L.circle(areaPoint, {{
                radius,
                color: colour,
                weight: 2,
                fillColor: colour,
                fillOpacity: 0.24,
              }})
                .bindPopup(`
                  <strong>${{h(area.location)}}</strong>
                  <div class="map-popup-grid">
                    <span>Bad jobs</span><b>${{h(area.bad_jobs)}} / ${{h(area.total_jobs)}}</b>
                    <span>Asset type</span><b>${{h(area.top_asset_type)}}</b>
                    <span>Issue</span><b>${{h(area.top_issue)}}</b>
                    <span>Reference</span><b>${{h(area.reference)}} to ${{h(area.end_reference)}}</b>
                    <span>Chainage</span><b>${{h(area.chainage_from)}} to ${{h(area.chainage_to)}}</b>
                  </div>
                `)
                .addTo(map);

              area.jobs.forEach((job) => {{
                if (job.lat === null || job.lon === null) return;
                const marker = L.circleMarker([job.lat, job.lon], {{
                  radius: job.days_late >= 7 ? 7 : 5,
                  color: "#0b1220",
                  weight: 2,
                  fillColor: colour,
                  fillOpacity: 0.95,
                }});
                marker
                  .bindPopup(`
                    <strong>Job ${{h(job.id)}}</strong>
                    <div class="map-popup-grid">
                      <span>Reason</span><b>${{h(job.reason)}}</b>
                      <span>Asset</span><b>${{h(job.asset_code)}}</b>
                      <span>Asset type</span><b>${{h(job.asset_type)}}</b>
                      <span>Issue</span><b>${{h(job.issue)}}</b>
                      <span>Direction</span><b>${{h(job.direction)}}</b>
                      <span>Chainage</span><b>${{h(job.chainage_from)}} to ${{h(job.chainage_to)}}</b>
                    </div>
                  `)
                  .addTo(map);
                bounds.push([job.lat, job.lon]);
              }});
            }});
            if (bounds.length) map.fitBounds(bounds, {{ padding: [26, 26], maxZoom: 14 }});
            note.style.display = "none";
          }})();
        </script>
      </section>
    """


def render_area_matrix(areas: list[dict[str, Any]]) -> str:
    rows = "".join(
        f"""
        <tr>
          <td><b>{esc(area['location'])}</b><small>{esc(area['section'])}</small></td>
          <td>{esc(area['top_asset_type'][0])}</td>
          <td>{esc(area['top_issue'][0])}</td>
          <td>{esc(area['direction'])}</td>
          <td>{esc(area['reference'])} to {esc(area['end_reference'])}</td>
          <td>{area['chainage_from']:.0f} to {area['chainage_to']:.0f}</td>
          <td><span class="risk-tag {area['risk_band']}">{area['bad_jobs']} / {area['total_jobs']}</span></td>
          <td>{pct(area['bad_rate'])}</td>
          <td>{area['avg_days_late']:.1f}</td>
          <td>{esc(area['trend'])}</td>
        </tr>
        """
        for area in areas
    )
    return f"""
      <section class="table-panel">
        <div class="panel-heading">
          <div>
            <p class="eyebrow">Granular issue and location matrix</p>
            <h2>Where the bad work is concentrated</h2>
          </div>
        </div>
        <div class="table-wrap">
          <table>
            <thead>
              <tr>
                <th>Location</th>
                <th>Asset type</th>
                <th>Issue signature</th>
                <th>Direction</th>
                <th>Reference points</th>
                <th>Chainage</th>
                <th>Bad jobs</th>
                <th>Bad rate</th>
                <th>Avg days late</th>
                <th>Trend</th>
              </tr>
            </thead>
            <tbody>{rows}</tbody>
          </table>
        </div>
      </section>
    """


def render_issue_breakdown(rows: list[dict[str, Any]]) -> str:
    bad_rows = [row for row in rows if row["_bad"]]
    by_issue = Counter(row["_issue"] for row in bad_rows)
    by_asset = Counter(row["_asset_type"] for row in bad_rows)
    issue_items = "".join(
        f"<li><span>{esc(issue)}</span><b>{count}</b></li>" for issue, count in by_issue.most_common()
    )
    asset_items = "".join(
        f"<li><span>{esc(asset)}</span><b>{count}</b></li>" for asset, count in by_asset.most_common()
    )
    return f"""
      <section class="breakdown-grid">
        <article>
          <p class="eyebrow">Issue detail</p>
          <h2>Bad jobs by hazard/activity</h2>
          <ul class="count-list">{issue_items}</ul>
        </article>
        <article>
          <p class="eyebrow">Asset detail</p>
          <h2>Bad jobs by AssetTypeName</h2>
          <ul class="count-list">{asset_items}</ul>
        </article>
      </section>
    """


def source_value(row: dict[str, Any], field: str) -> str:
    value = str(row.get(field) or "").strip()
    return value if value else "Unspecified"


def created_month(row: dict[str, Any]) -> str:
    date = parse_date(row.get("CreatedDate"))
    return date.strftime("%Y-%m") if date else "Unspecified"


def created_season(row: dict[str, Any]) -> str:
    date = parse_date(row.get("CreatedDate"))
    if not date:
        return "Unspecified"
    if date.month in {12, 1, 2}:
        return "Summer"
    if date.month in {3, 4, 5}:
        return "Autumn"
    if date.month in {6, 7, 8}:
        return "Winter"
    return "Spring"


def work_order_age_band(row: dict[str, Any]) -> str:
    created = parse_date(row.get("CreatedDate"))
    closed_or_now = parse_date(row.get("CompletedDate")) or REPORT_NOW
    if not created:
        return "Unspecified"
    age = max(0, days_between(created, closed_or_now))
    if age <= 14:
        return "0-14 days"
    if age <= 30:
        return "15-30 days"
    if age <= 60:
        return "31-60 days"
    return "61+ days"


def planned_reactive_signal(row: dict[str, Any]) -> str:
    text = " ".join(
        str(row.get(field) or "")
        for field in ("ActivityType", "ActivityName", "ActivityCategoryName", "Classification", "HazardDefectCode")
    ).lower()
    if re.search(r"preventative|planned|schedule|routine", text):
        return "Planned/preventative"
    if re.search(r"reactive|hazard|defect|incident|emergency|fault|break", text):
        return "Reactive/defect"
    return "Unclassified"


def repeat_work_signal(row: dict[str, Any]) -> str:
    linked = str(row.get("LinkedJobID") or "").strip()
    merged = str(row.get("MergedJobID") or "").strip()
    return "Linked/merged repeat work signal" if linked or merged else "No linked repeat signal"


def root_cause_driver_definitions() -> list[dict[str, Any]]:
    return [
        {
            "label": "Fault category",
            "getter": lambda row: source_value(row, "HazardDefectCode"),
            "action": "Check whether this fault category needs targeted inspection, coding cleanup, or intervention planning.",
        },
        {
            "label": "Work category",
            "getter": lambda row: source_value(row, "ActivityCategoryName"),
            "action": "Review work-pack design, scheduling rules, and crew capacity for this category.",
        },
        {
            "label": "Job type",
            "getter": lambda row: source_value(row, "ActivityType"),
            "action": "Review the method pack and due-date assumptions for this job type.",
        },
        {
            "label": "Work activity",
            "getter": lambda row: source_value(row, "ActivityName"),
            "action": "Validate whether this activity has repeat failure or planning constraints.",
        },
        {
            "label": "Asset type",
            "getter": lambda row: source_value(row, "AssetTypeName"),
            "action": "Prioritise an asset-type maintenance review if this is not a contract-wide pattern.",
        },
        {
            "label": "Priority",
            "getter": lambda row: source_value(row, "Priority"),
            "action": "Check whether priority settings and response windows match operational reality.",
        },
        {
            "label": "Classification",
            "getter": lambda row: source_value(row, "Classification"),
            "action": "Review whether this classification needs different scheduling or assurance treatment.",
        },
        {
            "label": "Workflow status",
            "getter": lambda row: source_value(row, "CurrentWorkflowItemName"),
            "action": "Look for handoff, closeout, or workflow bottlenecks around this status.",
        },
        {
            "label": "Completion status",
            "getter": lambda row: source_value(row, "CompletedStatus"),
            "action": "Check completion and closeout practices for this status.",
        },
        {
            "label": "Planned/reactive signal",
            "getter": planned_reactive_signal,
            "action": "Compare planned versus reactive capacity and scheduling rules.",
        },
        {
            "label": "Work order age band",
            "getter": work_order_age_band,
            "action": "Triage ageing work earlier and review escalation before due-date breach.",
        },
        {
            "label": "Repeat work signal",
            "getter": repeat_work_signal,
            "action": "Inspect linked or merged work for recurrence, duplicate capture, or closeout quality issues.",
        },
        {
            "label": "Created month",
            "getter": created_month,
            "action": "Check whether demand, weather, or rostering patterns explain this month-specific concentration.",
        },
        {
            "label": "Created season",
            "getter": created_season,
            "action": "Check seasonal planning, access constraints, and maintenance windows.",
        },
        {
            "label": "Section",
            "getter": lambda row: source_value(row, "Section"),
            "action": "Field-check this section for access constraints, repeat defects, or local delivery constraints.",
        },
        {
            "label": "Direction",
            "getter": lambda row: source_value(row, "Direction"),
            "action": "Review direction-specific access, traffic management, or asset-condition constraints.",
        },
        {
            "label": "Reference point",
            "getter": lambda row: source_value(row, "ReferencePointName"),
            "action": "Inspect this reference point for repeat work, access issues, or location-specific constraints.",
        },
        {
            "label": "End reference point",
            "getter": lambda row: source_value(row, "EndReferencePointName"),
            "action": "Inspect this endpoint for repeat work, access issues, or location-specific constraints.",
        },
    ]


def root_cause_interpretation(driver: dict[str, Any], share_lift: float, rate_lift: float) -> str:
    if share_lift >= 1.35 and rate_lift >= 1.10:
        prefix = "Over-indexed factor and worse-than-baseline bad outcome rate"
    elif share_lift >= 1.35:
        prefix = "Over-indexed factor in this bad area"
    elif rate_lift >= 1.10:
        prefix = "Associated driver with worse-than-baseline bad outcome rate"
    else:
        prefix = "Associated driver to monitor"
    return f"{prefix}; likely contributor to investigate, not proven cause. {driver['action']}"


def build_root_cause_driver_analysis(
    areas: list[dict[str, Any]],
    rows: list[dict[str, Any]],
) -> list[dict[str, Any]]:
    contract_bad_rows = [row for row in rows if row["_bad"]]
    contract_bad_rate = len(contract_bad_rows) / len(rows) if rows else 0
    drivers = root_cause_driver_definitions()
    analysis: list[dict[str, Any]] = []

    for area in areas:
        area_bad_count = max(1, area["bad_jobs"])
        area_entries: list[dict[str, Any]] = []
        for driver in drivers:
            label = driver["label"]
            getter = driver["getter"]
            area_groups: dict[str, list[dict[str, Any]]] = defaultdict(list)
            contract_bad_counts: Counter[str] = Counter()
            for row in area["rows"]:
                value = str(getter(row)).strip() or "Unspecified"
                if value != "Unspecified":
                    area_groups[value].append(row)
            for row in contract_bad_rows:
                value = str(getter(row)).strip() or "Unspecified"
                if value != "Unspecified":
                    contract_bad_counts[value] += 1

            for value, value_rows in area_groups.items():
                bad_rows = [row for row in value_rows if row["_bad"]]
                bad_count = len(bad_rows)
                if bad_count == 0:
                    continue
                share_of_area_bad = bad_count / area_bad_count
                bad_rate = bad_count / len(value_rows)
                contract_bad_share = (
                    contract_bad_counts[value] / len(contract_bad_rows) if contract_bad_rows else 0
                )
                share_lift = share_of_area_bad / contract_bad_share if contract_bad_share else 0
                rate_lift = bad_rate / contract_bad_rate if contract_bad_rate else 0
                if share_of_area_bad < 0.25 and share_lift < 1.15 and rate_lift < 1.10:
                    continue
                if share_lift < 1.08 and rate_lift < 1.08:
                    continue
                area_entries.append(
                    {
                        "driver": label,
                        "value": value,
                        "bad_count": bad_count,
                        "share": share_of_area_bad,
                        "bad_rate": bad_rate,
                        "share_lift": share_lift,
                        "rate_lift": rate_lift,
                        "score": bad_count * max(share_lift, 1) * max(rate_lift, 0.75),
                        "interpretation": root_cause_interpretation(driver, share_lift, rate_lift),
                    },
                )

        area_entries = sorted(
            area_entries,
            key=lambda item: (-item["score"], -item["bad_count"], -item["share_lift"], item["driver"]),
        )[:7]
        top = area_entries[0] if area_entries else None
        if top:
            action = top["interpretation"].split(". ", 1)[-1]
            summary = (
                f"{top['driver']} = {top['value']} is the strongest associated driver. "
                f"It accounts for {pct(top['share'])} of bad outcomes in this area and is "
                f"{top['share_lift']:.1f}x over the selected-contract bad-outcome share. "
                f"Operational action: {action}"
            )
        else:
            summary = (
                "No source-table driver was materially over-indexed against the selected-contract baseline. "
                "Treat this as a location-volume hotspot and validate with operations before changing process."
            )
        analysis.append({"area": area, "drivers": area_entries, "summary": summary})
    return analysis


def render_root_cause_drivers(areas: list[dict[str, Any]], rows: list[dict[str, Any]]) -> str:
    analyses = build_root_cause_driver_analysis(areas, rows)
    cards = []
    for item in analyses:
        area = item["area"]
        if item["drivers"]:
            rows_html = "".join(
                f"""
                <tr>
                  <td>{esc(driver['driver'])}</td>
                  <td>{esc(driver['value'])}</td>
                  <td>{driver['bad_count']}</td>
                  <td>{pct(driver['share'])}</td>
                  <td>{pct(driver['bad_rate'])}</td>
                  <td>{driver['share_lift']:.1f}x</td>
                  <td>{esc(driver['interpretation'])}</td>
                </tr>
                """
                for driver in item["drivers"]
            )
        else:
            rows_html = """
                <tr>
                  <td colspan="7">No materially over-indexed source-table driver was found for this area.</td>
                </tr>
            """
        cards.append(
            f"""
            <article class="root-cause-card">
              <div class="root-cause-top">
                <div>
                  <h3>{esc(area['location'])}</h3>
                  <p>{esc(item['summary'])}</p>
                </div>
                <span class="risk-tag {area['risk_band']}">{area['bad_jobs']} bad outcomes</span>
              </div>
              <div class="table-wrap compact">
                <table>
                  <thead>
                    <tr>
                      <th>Driver</th>
                      <th>Driver value</th>
                      <th>Bad outcome count</th>
                      <th>Share of bad outcomes</th>
                      <th>Bad outcome rate</th>
                      <th>Lift vs contract bad share</th>
                      <th>Interpretation</th>
                    </tr>
                  </thead>
                  <tbody>{rows_html}</tbody>
                </table>
              </div>
            </article>
            """,
        )
    return f"""
      <section class="root-cause-panel">
        <div class="panel-heading">
          <div>
            <p class="eyebrow">Root-cause driver analysis</p>
            <h2>Over-indexed factors associated with poor performance</h2>
            <p class="panel-note">
              These are associated drivers, not proven causes. Lift compares the driver's bad-outcome share
              in the bad area with the same driver's bad-outcome share across the selected contract.
            </p>
          </div>
        </div>
        <div class="root-cause-list">{''.join(cards)}</div>
      </section>
    """


def render_bad_jobs(rows: list[dict[str, Any]]) -> str:
    bad_rows = sorted(
        [row for row in rows if row["_bad"]],
        key=lambda row: (-row["_days_late"], str(row.get("CreatedDate"))),
    )
    table_rows = "".join(
        f"""
        <tr>
          <td><b>{esc(row.get('ID'))}</b><small>{esc(render_bad_reasons(row))}</small></td>
          <td>{esc(row.get('AssetCode'))}<small>{esc(row.get('AssetName'))}</small></td>
          <td>{esc(row.get('AssetTypeName'))}</td>
          <td>{esc(row['_issue'])}</td>
          <td>{esc(row['_location'])}<small>{esc(row.get('ReferencePointName'))} to {esc(row.get('EndReferencePointName'))}</small></td>
          <td>{esc(row.get('Direction'))}</td>
          <td>{esc(row.get('ChainageFrom'))} to {esc(row.get('ChainageTo'))}</td>
          <td>{esc(row.get('DueDate'))}</td>
          <td>{esc(row.get('CompletedDate') or 'Open')}</td>
          <td>{row['_days_late']}</td>
        </tr>
        """
        for row in bad_rows
    )
    return f"""
      <section class="table-panel">
        <div class="panel-heading">
          <div>
            <p class="eyebrow">Specific issues</p>
            <h2>Bad job detail with asset type and location fields</h2>
          </div>
        </div>
        <div class="table-wrap">
          <table>
            <thead>
              <tr>
                <th>Job</th>
                <th>Asset</th>
                <th>Asset type</th>
                <th>Issue</th>
                <th>Location</th>
                <th>Direction</th>
                <th>Chainage</th>
                <th>Due</th>
                <th>Completed</th>
                <th>Days late</th>
              </tr>
            </thead>
            <tbody>{table_rows}</tbody>
          </table>
        </div>
      </section>
    """


def render_sql(query: str) -> str:
    return f"""
      <section class="sql-panel">
        <div class="panel-heading">
          <div>
            <p class="eyebrow">Validated source query</p>
            <h2>Databricks SQL extract</h2>
          </div>
        </div>
        <pre><code>{html.escape(query.strip())}</code></pre>
      </section>
    """


def css() -> str:
    return """
    :root {
      color-scheme: dark;
      --bg: #12110f;
      --bg-2: #171916;
      --panel: #1f2420;
      --panel-2: #252b26;
      --ink: #f3f0e8;
      --muted: #b7b0a3;
      --line: #3b453c;
      --line-strong: #566352;
      --green: #12b76a;
      --teal: #2dd4bf;
      --amber: #f79009;
      --red: #f04438;
      --plum: #b16cea;
      --shadow: 0 24px 60px rgba(0, 0, 0, 0.28);
      font-family: Inter, ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
    }
    * { box-sizing: border-box; }
    body {
      margin: 0;
      background:
        linear-gradient(135deg, rgba(45, 212, 191, 0.08), transparent 36%),
        linear-gradient(225deg, rgba(247, 144, 9, 0.10), transparent 38%),
        var(--bg);
      color: var(--ink);
    }
    .page-shell { width: min(1480px, 100%); margin: 0 auto; padding: 28px; }
    .report-header {
      display: grid;
      grid-template-columns: minmax(0, 1fr) auto;
      gap: 24px;
      align-items: start;
      border-bottom: 1px solid var(--line);
      padding-bottom: 22px;
    }
    h1, h2, h3, p { margin-top: 0; }
    h1 { margin-bottom: 10px; font-size: clamp(2rem, 4vw, 4rem); line-height: 1; letter-spacing: 0; }
    h2 { margin-bottom: 8px; font-size: 1.05rem; letter-spacing: 0; }
    h3 { margin-bottom: 8px; font-size: 0.92rem; letter-spacing: 0; }
    .eyebrow {
      margin-bottom: 8px;
      color: var(--teal);
      font-size: 0.74rem;
      font-weight: 800;
      letter-spacing: 0;
      text-transform: uppercase;
    }
    .lead { max-width: 880px; color: var(--muted); font-size: 1.02rem; line-height: 1.55; }
    .source-badge {
      min-width: 330px;
      border: 1px solid var(--line);
      border-radius: 8px;
      background: var(--panel);
      box-shadow: var(--shadow);
      padding: 16px;
    }
    .source-badge span { display: block; color: var(--muted); font-size: 0.74rem; text-transform: uppercase; font-weight: 800; }
    .source-badge strong { display: block; margin-top: 8px; color: var(--ink); line-height: 1.35; word-break: break-word; }
    section { margin-top: 18px; }
    .definition-band, .validation-panel, .map-panel, .table-panel, .root-cause-panel, .sql-panel, .breakdown-grid article {
      border: 1px solid var(--line);
      border-radius: 8px;
      background: rgba(31, 36, 32, 0.96);
      box-shadow: var(--shadow);
    }
    .definition-band {
      display: grid;
      grid-template-columns: minmax(0, 1.2fr) minmax(0, 1fr);
      gap: 18px;
      padding: 20px;
    }
    .definition-band p, li, small { color: var(--muted); line-height: 1.5; }
    code {
      border: 1px solid var(--line);
      border-radius: 5px;
      background: #111713;
      color: #d8fff7;
      padding: 1px 5px;
      white-space: nowrap;
    }
    .kpi-grid {
      display: grid;
      grid-template-columns: repeat(5, minmax(0, 1fr));
      gap: 14px;
    }
    .kpi-card {
      min-height: 118px;
      border: 1px solid var(--line);
      border-radius: 8px;
      background: linear-gradient(180deg, #252b26, #1b211d);
      padding: 16px;
    }
    .kpi-card span { display: block; color: var(--muted); font-size: 0.76rem; font-weight: 800; text-transform: uppercase; }
    .kpi-card strong { display: block; margin: 10px 0 6px; color: #fff8e8; font-size: 2rem; line-height: 1; }
    .kpi-card small { display: block; }
    .panel-heading {
      display: flex;
      align-items: start;
      justify-content: space-between;
      gap: 18px;
      padding: 18px 20px 0;
    }
    .validation-grid {
      display: grid;
      grid-template-columns: repeat(4, minmax(0, 1fr));
      gap: 16px;
      padding: 16px 20px 20px;
    }
    .validation-grid ul { margin: 0; padding-left: 18px; }
    .status-pill, .risk-tag {
      display: inline-flex;
      align-items: center;
      min-height: 26px;
      border-radius: 999px;
      padding: 3px 10px;
      font-size: 0.78rem;
      font-weight: 800;
      white-space: nowrap;
    }
    .status-pill.ok, .risk-tag.low { background: rgba(18, 183, 106, 0.15); color: #9ff7c8; }
    .status-pill.bad, .risk-tag.high { background: rgba(240, 68, 56, 0.16); color: #ffb4ad; }
    .risk-tag.medium { background: rgba(247, 144, 9, 0.17); color: #ffd28a; }
    .actual-map-shell {
      position: relative;
      margin: 16px 20px 20px;
      overflow: hidden;
      border: 1px solid var(--line);
      border-radius: 8px;
      background: #0b1220;
    }
    .actual-map {
      width: 100%;
      height: min(68vh, 720px);
      min-height: 540px;
      background: #0b1220;
    }
    .map-loading-note {
      position: absolute;
      inset: 0;
      display: grid;
      place-items: center;
      padding: 24px;
      background: rgba(11, 18, 32, 0.86);
      color: var(--muted);
      text-align: center;
      pointer-events: none;
    }
    .map-loading-note:not(.visible) { display: none; }
    .leaflet-container { background: #0b1220; color: var(--ink); font: inherit; }
    .leaflet-control-zoom a,
    .leaflet-control-attribution {
      border-color: var(--line) !important;
      background: rgba(17, 23, 19, 0.92) !important;
      color: var(--ink) !important;
    }
    .leaflet-control-zoom a:hover { background: rgba(37, 43, 38, 0.98) !important; }
    .leaflet-popup-content-wrapper,
    .leaflet-popup-tip {
      border: 1px solid var(--line);
      background: #17201b;
      color: var(--ink);
      box-shadow: var(--shadow);
    }
    .leaflet-popup-content { margin: 12px; min-width: 230px; }
    .leaflet-popup-content strong { display: block; margin-bottom: 8px; color: #fff8e8; }
    .map-popup-grid {
      display: grid;
      grid-template-columns: auto minmax(0, 1fr);
      gap: 6px 12px;
      color: var(--muted);
      font-size: 0.82rem;
    }
    .map-popup-grid b { color: var(--ink); text-align: right; word-break: break-word; }
    .breakdown-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 18px; }
    .breakdown-grid article { padding: 18px 20px; }
    .panel-note {
      max-width: 920px;
      margin: 8px 0 0;
      color: var(--muted);
      line-height: 1.5;
      font-size: 0.92rem;
    }
    .root-cause-list {
      display: grid;
      gap: 14px;
      padding: 16px 20px 20px;
    }
    .root-cause-card {
      overflow: hidden;
      border: 1px solid var(--line);
      border-radius: 8px;
      background: rgba(17, 23, 19, 0.72);
    }
    .root-cause-top {
      display: flex;
      align-items: start;
      justify-content: space-between;
      gap: 16px;
      padding: 16px 16px 0;
    }
    .root-cause-top h3 { margin-bottom: 6px; color: #fff8e8; }
    .root-cause-top p { margin-bottom: 0; color: var(--muted); line-height: 1.5; }
    .count-list { list-style: none; margin: 0; padding: 0; display: grid; gap: 8px; }
    .count-list li { display: flex; justify-content: space-between; gap: 16px; border-bottom: 1px solid var(--line); padding-bottom: 8px; }
    .count-list b { color: var(--ink); }
    .table-wrap { overflow-x: auto; padding: 14px 20px 20px; }
    .table-wrap.compact { padding: 12px 16px 16px; }
    table { width: 100%; min-width: 1040px; border-collapse: collapse; }
    th, td { border-bottom: 1px solid var(--line); padding: 12px 10px; text-align: left; vertical-align: top; }
    th { color: var(--muted); font-size: 0.74rem; font-weight: 800; text-transform: uppercase; }
    td { color: #ece8dd; font-size: 0.88rem; }
    td small { display: block; margin-top: 4px; font-size: 0.78rem; }
    tr:hover { background: rgba(45, 212, 191, 0.05); }
    .mini-table { min-width: 0; }
    pre {
      margin: 16px 20px 20px;
      max-height: 360px;
      overflow: auto;
      border: 1px solid var(--line);
      border-radius: 8px;
      background: #0f1411;
      padding: 16px;
    }
    pre code { border: 0; background: transparent; padding: 0; white-space: pre; color: #e8fff8; }
    @media (max-width: 980px) {
      .page-shell { padding: 18px; }
      .report-header, .definition-band, .validation-grid, .breakdown-grid { grid-template-columns: 1fr; }
      .root-cause-top { display: grid; }
      .source-badge { min-width: 0; }
      .kpi-grid { grid-template-columns: repeat(2, minmax(0, 1fr)); }
    }
    @media (max-width: 620px) {
      .kpi-grid { grid-template-columns: 1fr; }
      h1 { font-size: 2rem; }
    }
    """


def render_html(
    rows: list[dict[str, Any]],
    areas: list[dict[str, Any]],
    query: str,
    sql_validation: dict[str, Any],
    row_validation: dict[str, Any],
) -> str:
    return f"""<!doctype html>
<html lang="en-AU">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>VentureSmart Bad-Area Analytics</title>
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
    <style>{css()}</style>
  </head>
  <body>
    <main class="page-shell">
      <header class="report-header">
        <div>
          <p class="eyebrow">Python-generated source-table analytics</p>
          <h1>VentureSmart bad-area report</h1>
          <p class="lead">
            This report uses <code>{esc(SOURCE_TABLE)}</code> fields only. Python validates the query shape and
            row output, then groups bad jobs by location, asset type, issue signature, reference points,
            direction, and chainage. A job is bad when it is non-compliant or overdue.
          </p>
        </div>
        <div class="source-badge">
          <span>Selected contract</span>
          <strong>{esc(SELECTED_CONTRACT)} | Western Australia</strong>
          <span style="margin-top:14px">Generated</span>
          <strong>{datetime.now().strftime('%Y-%m-%d %H:%M')}</strong>
        </div>
      </header>

      <section class="definition-band">
        <article>
          <p class="eyebrow">Bad-area definition</p>
          <h2>High-risk source-table clusters</h2>
          <p>
            Bad areas are grouped from <code>Area</code> or reference-point fields in <code>vjob</code>.
            The report avoids curated Transport tables and does not assert an SLA threshold that is not in
            the source documentation.
          </p>
        </article>
        <article>
          <p class="eyebrow">Granularity added</p>
          <h2>Asset and location fields are now first-class</h2>
          <p>
            The SQL and report now include <code>AssetTypeName</code>, <code>Section</code>,
            <code>Direction</code>, <code>ReferencePointName</code>, <code>EndReferencePointName</code>,
            <code>ChainageFrom</code>, and <code>ChainageTo</code>.
          </p>
        </article>
      </section>

      {render_validation_panel(sql_validation, row_validation)}
      {render_kpis(rows, areas, row_validation)}
      {render_map(areas)}
      {render_area_matrix(areas)}
      {render_issue_breakdown(rows)}
      {render_root_cause_drivers(areas, rows)}
      {render_bad_jobs(rows)}
      {render_sql(query)}
    </main>
  </body>
</html>
"""


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Generate the VentureSmart sandbox analytics report.")
    parser.add_argument("--output", type=Path, default=OUTPUT_PATH, help="HTML report path.")
    parser.add_argument("--input-csv", type=Path, help="Optional CSV exported from source-query.sql.")
    parser.add_argument(
        "--live",
        action="store_true",
        help="Run source-query.sql through Databricks SQL connector using browser OAuth.",
    )
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    query = read_query()
    sql_validation = validate_sql(query)

    if args.live:
        rows = fetch_live_rows(query)
        mode = "live_databricks"
    elif args.input_csv:
        rows = load_csv(args.input_csv)
        mode = f"csv:{args.input_csv.name}"
    else:
        rows = build_sample_rows()
        mode = "offline_sample"

    row_validation = validate_rows(rows, mode)
    augmented = augment_rows(rows)
    areas = analyse_areas(augmented)
    html_report = render_html(augmented, areas, query, sql_validation, row_validation)
    args.output.write_text(html_report, encoding="utf-8")

    counts = row_validation.get("counts", {})
    print(f"Wrote {args.output}")
    print(f"Validation mode: {row_validation['mode']}")
    print(f"Rows: {counts.get('rows', 0)}")
    print(f"Bad rows: {counts.get('bad_rows', 0)}")
    print(f"Locations: {counts.get('locations', 0)}")
    print(f"SQL validation: {'passed' if sql_validation['valid'] else 'needs review'}")
    print(f"Row validation: {'passed' if row_validation['valid'] else 'needs review'}")
    if row_validation["warnings"]:
        print("Warnings:")
        for warning in row_validation["warnings"]:
            print(f"- {warning}")
    if row_validation["failures"]:
        print("Failures:")
        for failure in row_validation["failures"]:
            print(f"- {failure}")
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
