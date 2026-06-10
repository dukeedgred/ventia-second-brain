from __future__ import annotations

import html
import json
import os
import re
import shutil
import subprocess
import sys
import time
from collections import Counter, defaultdict
from datetime import datetime, timezone
from pathlib import Path
from typing import Any


ROOT = Path(__file__).resolve().parent
DATA_DIR = ROOT / "data"
TABLE_NAME = "staged.stg_api_venspark.ideas"
PROFILE = os.environ.get("DATABRICKS_CONFIG_PROFILE", "ventia-transport")
WAREHOUSE_ID = os.environ.get("DATABRICKS_WAREHOUSE_ID", "e736bc08efffb739")


IDEAS_SQL = f"""
SELECT
  CAST(idea_id AS STRING) AS idea_id,
  CAST(id AS STRING) AS source_id,
  COALESCE(title, '') AS title,
  LEFT(REGEXP_REPLACE(REGEXP_REPLACE(COALESCE(description, ''), '<[^>]*>', ' '), '\\\\s+', ' '), 900) AS description,
  COALESCE(campaign_title, 'Unspecified') AS campaign_title,
  COALESCE(status_title, 'Unspecified') AS status_title,
  COALESCE(stage_title, 'Unspecified') AS stage_title,
  CAST(submittedAt AS STRING) AS submitted_at,
  CAST(lastStageUpdateAt AS STRING) AS last_stage_update_at,
  CAST(lastStatusUpdateAt AS STRING) AS last_status_update_at,
  CAST(row_updated_timestamp AS STRING) AS row_updated_timestamp,
  COALESCE(CAST(likesCount AS INT), 0) AS likes,
  COALESCE(CAST(commentsCount AS INT), 0) AS comments,
  COALESCE(CAST(tokenVotesSum AS INT), 0) AS votes,
  ROUND(COALESCE(TRY_CAST(textSentiment AS DOUBLE), 0), 3) AS sentiment
FROM {TABLE_NAME}
WHERE COALESCE(CAST(deleted_from_source AS INT), 0) = 0
  AND COALESCE(CAST(isDeletedInternally AS BOOLEAN), false) = false
  AND COALESCE(CAST(wasComment AS BOOLEAN), false) = false
ORDER BY submittedAt DESC
LIMIT 1000
""".strip()


SUMMARY_SQL = f"""
SELECT
  COUNT(*) AS source_rows,
  COUNT(DISTINCT idea_id) AS distinct_ideas,
  SUM(CASE WHEN COALESCE(CAST(deleted_from_source AS INT), 0) <> 0 THEN 1 ELSE 0 END) AS deleted_rows,
  SUM(CASE WHEN COALESCE(CAST(wasComment AS BOOLEAN), false) THEN 1 ELSE 0 END) AS comment_rows,
  CAST(MIN(submittedAt) AS STRING) AS first_submitted_at,
  CAST(MAX(submittedAt) AS STRING) AS last_submitted_at,
  CAST(MAX(row_updated_timestamp) AS STRING) AS last_loaded_at
FROM {TABLE_NAME}
""".strip()


THEME_RULES = [
    (
        "Data, reporting and insight",
        [
            "dashboard",
            "report",
            "power bi",
            "data",
            "database",
            "register",
            "tracker",
            "visibility",
            "kpi",
            "metric",
            "catalog",
            "catalogue",
            "source of truth",
            "analytics",
            "insight",
        ],
    ),
    (
        "Automation and integration",
        [
            "automate",
            "automation",
            "integrat",
            "sync",
            "api",
            "rpa",
            "bot",
            "workflow",
            "ariba",
            "sap",
            "rapid global",
            "solv",
        ],
    ),
    (
        "Safety, risk and compliance",
        [
            "safety",
            "hazard",
            "incident",
            "fatigue",
            "risk",
            "swms",
            "hse",
            "near miss",
            "compliance",
        ],
    ),
    (
        "Asset, field and operations",
        [
            "asset",
            "inspection",
            "field",
            "work order",
            "photo",
            "evidence",
            "maintenance",
            "proofworks",
        ],
    ),
    (
        "Commercial and procurement",
        [
            "supplier",
            "subcontractor",
            "procurement",
            "purchasing",
            "invoice",
            "claims",
            "contract",
            "work winning",
            "pricing",
        ],
    ),
    (
        "Communications and enablement",
        [
            "teams",
            "email",
            "phone",
            "communication",
            "comms",
            "onboarding",
            "training",
            "guide",
            "template",
            "folder",
            "naming",
            "directory",
            "learning",
        ],
    ),
    (
        "Sustainability and environment",
        [
            "waste",
            "recycle",
            "reuse",
            "carbon",
            "sustainability",
            "energy",
            "environment",
        ],
    ),
    (
        "Workforce and capability",
        [
            "talent",
            "skill",
            "resource",
            "people",
            "org chart",
            "capability",
            "workforce",
        ],
    ),
]


QUICK_KEYWORDS = [
    "dashboard",
    "report",
    "tracker",
    "register",
    "list",
    "directory",
    "phone",
    "training",
    "onboarding",
    "template",
    "checklist",
    "naming convention",
    "counter",
    "sharepoint",
    "playbook",
    "library",
    "guide",
    "pack",
]

MEDIUM_KEYWORDS = [
    "integration",
    "integrat",
    "automate",
    "workflow",
    "database",
    "portal",
    "ariba",
    "sap",
    "rapid global",
    "solv",
    "asset management",
    "contract intelligence",
    "obligations",
]

LARGE_KEYWORDS = [
    "drone",
    "drones",
    "cobot",
    "robot",
    "starlink",
    "hardware",
    "enterprise platform",
    "company-wide replacement",
    "ai asset",
    "satellite",
    "sensor",
    "wearable",
    "fleet-wide",
]


DUPLICATE_RULES = {
    "People counter and attendance tracking": ["people counter", "attendance", "room counter"],
    "Comms, directory and profile data": ["phone number", "company wide communication", "teams", "email management", "profile"],
    "Contract intelligence and cross-sell": ["contract intelligence", "contract database", "who is ventia", "cross sell", "cross-sell"],
    "Asset knowledge and standards": ["asset management", "asset naming", "asset register", "asset data"],
    "Forms and workflow modernisation": ["forms platform", "dashpivot", "form", "workflow"],
    "Field evidence and photo capture": ["photo", "proofworks", "evidence", "image validation"],
    "Training and onboarding": ["training", "onboarding", "journey pack", "tiny courses"],
    "Procurement and purchasing": ["ariba", "purchase", "procurement", "invoice", "supplier pricing"],
    "Safety and HSE improvements": ["hse", "swms", "fatigue", "hazard", "near miss", "safety"],
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
        winget = Path(local_app) / "Microsoft" / "WinGet" / "Packages"
        matches = sorted(winget.glob("Databricks.DatabricksCLI*/databricks.exe"))
        if matches:
            return str(matches[-1])

    raise RuntimeError(
        "Databricks CLI was not found. Install it or set DATABRICKS_CLI to databricks.exe."
    )


def run_cli(args: list[str]) -> dict[str, Any]:
    cli = find_databricks_cli()
    proc = subprocess.run(
        [cli, *args],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
        encoding="utf-8",
        errors="replace",
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
    try:
        return json.loads(proc.stdout)
    except json.JSONDecodeError as exc:
        raise RuntimeError(f"Could not parse Databricks CLI JSON output: {exc}\n{proc.stdout}") from exc


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
        raise RuntimeError(f"Statement failed: {json.dumps(response.get('status'), indent=2)}")

    columns = [
        col["name"]
        for col in response.get("manifest", {}).get("schema", {}).get("columns", [])
    ]
    rows = response.get("result", {}).get("data_array", [])
    return [dict(zip(columns, row)) for row in rows]


def parse_dt(value: Any) -> datetime | None:
    if not value:
        return None
    text = str(value).strip()
    if not text:
        return None
    text = text.replace("Z", "+00:00")
    try:
        return datetime.fromisoformat(text)
    except ValueError:
        pass
    for fmt in ("%Y-%m-%d %H:%M:%S.%f", "%Y-%m-%d %H:%M:%S", "%Y-%m-%d"):
        try:
            return datetime.strptime(text, fmt)
        except ValueError:
            continue
    return None


def days_since(value: Any, now: datetime) -> int | None:
    dt = parse_dt(value)
    if not dt:
        return None
    if dt.tzinfo is None:
        dt = dt.replace(tzinfo=timezone.utc)
    return max(0, (now - dt.astimezone(timezone.utc)).days)


def as_int(value: Any) -> int:
    try:
        if value is None or value == "":
            return 0
        return int(float(value))
    except (TypeError, ValueError):
        return 0


def as_float(value: Any) -> float:
    try:
        if value is None or value == "":
            return 0.0
        return float(value)
    except (TypeError, ValueError):
        return 0.0


def normalise_text(value: Any) -> str:
    text = html.unescape(str(value or ""))
    text = re.sub(r"<[^>]*>", " ", text)
    text = re.sub(r"[\w.+-]+@[\w.-]+\.[A-Za-z]{2,}", "[email removed]", text)
    text = re.sub(r"\b(?:\+?61|0)[2-478](?:[\s.-]?\d){8}\b", "[phone removed]", text)
    text = re.sub(r"\s+", " ", text)
    return text.strip()


def infer_theme(text: str) -> str:
    lower = text.lower()
    best_theme = "Other operational improvement"
    best_count = 0
    for theme, keywords in THEME_RULES:
        hits = sum(1 for keyword in keywords if keyword in lower)
        if hits > best_count:
            best_theme = theme
            best_count = hits
    return best_theme


def infer_effort(text: str) -> str:
    lower = text.lower()
    if any(keyword in lower for keyword in LARGE_KEYWORDS):
        return "High"
    if any(keyword in lower for keyword in MEDIUM_KEYWORDS):
        return "Medium"
    if any(keyword in lower for keyword in QUICK_KEYWORDS):
        return "Low"
    return "Medium"


def stage_status_key(idea: dict[str, Any]) -> str:
    return f"{idea.get('status_title') or 'Unspecified'} / {idea.get('stage_title') or 'Unspecified'}"


def is_closed(idea: dict[str, Any]) -> bool:
    text = stage_status_key(idea).lower()
    closed_terms = [
        "closed",
        "complete",
        "completed",
        "duplicate",
        "not proceeding",
        "rejected",
        "cancelled",
        "archived",
    ]
    return any(term in text for term in closed_terms)


def stage_weight(idea: dict[str, Any]) -> int:
    text = stage_status_key(idea).lower()
    if "implement" in text:
        return 26
    if "develop" in text:
        return 22
    if "evaluate" in text:
        return 18
    if "review" in text:
        return 14
    if "waiting" in text:
        return 10
    if "qualify" in text:
        return 7
    if "new" in text:
        return 5
    return 3


def infer_duplicate_cluster(text: str) -> str | None:
    lower = text.lower()
    for cluster, keywords in DUPLICATE_RULES.items():
        if any(keyword in lower for keyword in keywords):
            return cluster
    return None


def reason_for(idea: dict[str, Any]) -> str:
    parts = [
        f"{idea['likes']} likes",
        f"{idea['comments']} comments",
        stage_status_key(idea),
        idea["theme"],
    ]
    if idea["quick_win"]:
        parts.append("low-effort candidate")
    if idea["data_related"]:
        parts.append("data/reporting use case")
    if idea["stale"]:
        parts.append(f"{idea['days_since_status_update']} days since status update")
    return "; ".join(parts)


def next_step_for(idea: dict[str, Any]) -> str:
    if idea["quick_win"] and idea["data_related"]:
        return "Build a 1 to 2 week dashboard or register prototype using available source data."
    if idea["quick_win"]:
        return "Validate the owner and expected workflow, then prototype the simplest usable version."
    if idea["data_related"]:
        return "Confirm the source tables and refresh path before spending time on the interface."
    if idea["effort"] == "High":
        return "Do discovery first; this is not a fast demo candidate unless scope is narrowed."
    return "Clarify business owner, user group and minimum decision this idea should support."


def score_idea(idea: dict[str, Any]) -> int:
    score = 2 * idea["likes"] + 3 * idea["comments"] + idea["votes"]
    score += stage_weight(idea)
    if idea["quick_win"]:
        score += 18
    if idea["data_related"]:
        score += 12
    if idea["stale"] and idea["likes"] + idea["comments"] >= 15:
        score += 10
    if idea["closed"]:
        score -= 45
    if idea["effort"] == "High":
        score -= 16
    return max(0, int(score))


def enrich(raw_rows: list[dict[str, Any]]) -> list[dict[str, Any]]:
    now = datetime.now(timezone.utc)
    ideas: list[dict[str, Any]] = []
    for row in raw_rows:
        title = normalise_text(row.get("title"))
        description = normalise_text(row.get("description"))
        combined = f"{title} {description}".strip()
        likes = as_int(row.get("likes"))
        comments = as_int(row.get("comments"))
        votes = as_int(row.get("votes"))
        row_out: dict[str, Any] = {
            "idea_id": str(row.get("idea_id") or row.get("source_id") or "").strip(),
            "title": title or "Untitled idea",
            "short_description": description[:260],
            "campaign_title": normalise_text(row.get("campaign_title")) or "Unspecified",
            "status_title": normalise_text(row.get("status_title")) or "Unspecified",
            "stage_title": normalise_text(row.get("stage_title")) or "Unspecified",
            "submitted_at": row.get("submitted_at"),
            "last_stage_update_at": row.get("last_stage_update_at"),
            "last_status_update_at": row.get("last_status_update_at"),
            "row_updated_timestamp": row.get("row_updated_timestamp"),
            "likes": likes,
            "comments": comments,
            "votes": votes,
            "sentiment": round(as_float(row.get("sentiment")), 3),
        }
        row_out["theme"] = infer_theme(combined)
        row_out["effort"] = infer_effort(combined)
        row_out["closed"] = is_closed(row_out)
        row_out["data_related"] = row_out["theme"] == "Data, reporting and insight" or any(
            keyword in combined.lower()
            for keyword in ["data", "dashboard", "report", "register", "analytics", "metric", "kpi"]
        )
        row_out["quick_win"] = row_out["effort"] == "Low" and not row_out["closed"]
        row_out["duplicate_cluster"] = infer_duplicate_cluster(combined)
        row_out["days_since_status_update"] = days_since(
            row_out["last_status_update_at"] or row_out["last_stage_update_at"], now
        )
        row_out["stale"] = (
            not row_out["closed"]
            and row_out["days_since_status_update"] is not None
            and row_out["days_since_status_update"] >= 90
            and row_out["stage_title"].lower() in {"qualify", "evaluate", "develop"}
        )
        row_out["priority_score"] = score_idea(row_out)
        row_out["evidence"] = reason_for(row_out)
        row_out["recommended_next_step"] = next_step_for(row_out)
        ideas.append(row_out)

    ideas.sort(key=lambda item: item["priority_score"], reverse=True)
    return ideas


def top_counts(ideas: list[dict[str, Any]], key: str, limit: int = 12) -> list[dict[str, Any]]:
    grouped: dict[str, dict[str, Any]] = defaultdict(lambda: {"count": 0, "likes": 0, "comments": 0})
    for idea in ideas:
        label = idea.get(key) or "Unspecified"
        grouped[label]["count"] += 1
        grouped[label]["likes"] += idea["likes"]
        grouped[label]["comments"] += idea["comments"]
    rows = [{"label": label, **values} for label, values in grouped.items()]
    rows.sort(key=lambda item: (item["count"], item["likes"] + item["comments"]), reverse=True)
    return rows[:limit]


def make_summary(ideas: list[dict[str, Any]], source_summary: dict[str, Any]) -> dict[str, Any]:
    clusters = defaultdict(list)
    for idea in ideas:
        if idea.get("duplicate_cluster"):
            clusters[idea["duplicate_cluster"]].append(idea)

    duplicate_clusters = []
    for cluster, rows in clusters.items():
        if len(rows) < 2:
            continue
        sorted_rows = sorted(rows, key=lambda item: item["priority_score"], reverse=True)
        duplicate_clusters.append(
            {
                "cluster": cluster,
                "count": len(rows),
                "engagement": sum(item["likes"] + item["comments"] for item in rows),
                "ideas": [
                    {
                        "idea_id": item["idea_id"],
                        "title": item["title"],
                        "stage_status": stage_status_key(item),
                        "priority_score": item["priority_score"],
                    }
                    for item in sorted_rows[:6]
                ],
            }
        )
    duplicate_clusters.sort(key=lambda item: (item["engagement"], item["count"]), reverse=True)

    return {
        "generated_at_utc": datetime.now(timezone.utc).isoformat(timespec="seconds"),
        "source_table": TABLE_NAME,
        "profile": PROFILE,
        "warehouse_id": WAREHOUSE_ID,
        "source_summary": source_summary,
        "counts": {
            "ideas_loaded": len(ideas),
            "open_ideas": sum(1 for idea in ideas if not idea["closed"]),
            "closed_or_inactive": sum(1 for idea in ideas if idea["closed"]),
            "quick_wins": sum(1 for idea in ideas if idea["quick_win"]),
            "data_related": sum(1 for idea in ideas if idea["data_related"]),
            "stale_active": sum(1 for idea in ideas if idea["stale"]),
        },
        "charts": {
            "campaigns": top_counts(ideas, "campaign_title", 10),
            "stage_status": top_counts(ideas, "stage_status", 12)
            if False
            else top_stage_status(ideas, 12),
            "themes": top_counts(ideas, "theme", 10),
            "effort": top_counts(ideas, "effort", 5),
        },
        "shortlists": {
            "quick_wins": [compact(item) for item in ideas if item["quick_win"]][:10],
            "data_related": [compact(item) for item in ideas if item["data_related"]][:10],
            "stale": [compact(item) for item in ideas if item["stale"]][:10],
            "top_priority": [compact(item) for item in ideas[:15]],
        },
        "duplicate_clusters": duplicate_clusters[:8],
        "scoring_rubric": [
            "2 points per like, 3 points per comment and 1 point per token vote.",
            "Stage/status weight favours ideas already in Evaluate, Develop or Implement.",
            "Low-effort ideas get a quick-win uplift.",
            "Data/reporting ideas get a small uplift because the requested demo is data-related.",
            "Closed, duplicate or high-effort ideas are penalised.",
            "The score is a triage heuristic, not a formal business case.",
        ],
        "data_quality_notes": [
            "The current table has 542 rows, not the earlier 523 figure, based on the latest Databricks count.",
            "The output excludes submitter and owner fields to avoid exposing personal data in the demo.",
            "customFields and keyPhrases are not used for scoring because prior inspection showed sparse or weak evidence.",
            "Feasibility is inferred from title and description keywords. It needs owner validation before delivery funding.",
        ],
    }


def top_stage_status(ideas: list[dict[str, Any]], limit: int) -> list[dict[str, Any]]:
    grouped: dict[str, dict[str, Any]] = defaultdict(lambda: {"count": 0, "likes": 0, "comments": 0})
    for idea in ideas:
        label = stage_status_key(idea)
        grouped[label]["count"] += 1
        grouped[label]["likes"] += idea["likes"]
        grouped[label]["comments"] += idea["comments"]
    rows = [{"label": label, **values} for label, values in grouped.items()]
    rows.sort(key=lambda item: (item["count"], item["likes"] + item["comments"]), reverse=True)
    return rows[:limit]


def compact(idea: dict[str, Any]) -> dict[str, Any]:
    keys = [
        "idea_id",
        "title",
        "campaign_title",
        "status_title",
        "stage_title",
        "theme",
        "effort",
        "priority_score",
        "likes",
        "comments",
        "votes",
        "evidence",
        "recommended_next_step",
    ]
    return {key: idea[key] for key in keys}


def json_for_html(value: Any) -> str:
    return html.escape(json.dumps(value, ensure_ascii=False), quote=False)


def report_html(ideas: list[dict[str, Any]], summary: dict[str, Any]) -> str:
    return f"""<!doctype html>
<html lang="en-AU">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>VenSpark Opportunity Triage</title>
  <style>
    :root {{
      --bg: #f5f7fb;
      --panel: #ffffff;
      --panel-2: #eef3f8;
      --text: #172033;
      --muted: #5c667a;
      --line: #d8e0ea;
      --blue: #2364aa;
      --teal: #167d78;
      --green: #287a43;
      --amber: #b35c00;
      --red: #b42318;
      --ink: #0f172a;
      --shadow: 0 16px 40px rgba(21, 35, 56, 0.09);
    }}

    * {{ box-sizing: border-box; }}
    body {{
      margin: 0;
      font-family: Inter, ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
      background: var(--bg);
      color: var(--text);
      line-height: 1.45;
    }}

    header {{
      background: #101828;
      color: white;
      padding: 28px 36px 24px;
      border-bottom: 5px solid var(--teal);
    }}

    .shell {{
      max-width: 1440px;
      margin: 0 auto;
    }}

    .eyebrow {{
      color: #a7d7d2;
      font-size: 12px;
      font-weight: 800;
      letter-spacing: .08em;
      text-transform: uppercase;
      margin-bottom: 8px;
    }}

    h1, h2, h3, p {{ margin: 0; }}
    h1 {{
      font-size: clamp(30px, 4vw, 48px);
      line-height: 1.06;
      letter-spacing: 0;
      margin-bottom: 10px;
    }}

    .subtitle {{
      max-width: 980px;
      color: #d4dbe7;
      font-size: 15px;
    }}

    main {{
      max-width: 1440px;
      margin: 0 auto;
      padding: 24px 36px 42px;
    }}

    .kpis {{
      display: grid;
      grid-template-columns: repeat(6, minmax(150px, 1fr));
      gap: 14px;
      margin-bottom: 18px;
    }}

    .card, .panel {{
      background: var(--panel);
      border: 1px solid var(--line);
      box-shadow: var(--shadow);
    }}

    .card {{
      padding: 16px;
      border-radius: 8px;
      min-height: 112px;
    }}

    .card .label {{
      color: var(--muted);
      font-size: 12px;
      font-weight: 800;
      text-transform: uppercase;
      letter-spacing: .05em;
      margin-bottom: 8px;
    }}

    .card .value {{
      font-size: 30px;
      font-weight: 850;
      letter-spacing: 0;
      color: var(--ink);
    }}

    .card .note {{
      color: var(--muted);
      font-size: 12px;
      margin-top: 8px;
    }}

    .grid {{
      display: grid;
      grid-template-columns: minmax(0, 1.45fr) minmax(360px, .8fr);
      gap: 18px;
      align-items: start;
    }}

    .panel {{
      border-radius: 8px;
      margin-bottom: 18px;
      overflow: hidden;
    }}

    .panel-head {{
      display: flex;
      justify-content: space-between;
      gap: 16px;
      padding: 16px 18px;
      border-bottom: 1px solid var(--line);
      background: #fbfcfe;
    }}

    .panel h2 {{
      font-size: 17px;
      letter-spacing: 0;
      color: var(--ink);
    }}

    .panel .hint {{
      color: var(--muted);
      font-size: 12px;
      margin-top: 3px;
    }}

    .panel-body {{
      padding: 16px 18px 18px;
    }}

    .charts {{
      display: grid;
      grid-template-columns: repeat(2, minmax(0, 1fr));
      gap: 18px;
    }}

    .chart-block {{
      min-width: 0;
    }}

    .bar-row {{
      display: grid;
      grid-template-columns: minmax(150px, 250px) 1fr 70px;
      gap: 10px;
      align-items: center;
      margin: 9px 0;
      font-size: 12px;
    }}

    .bar-label {{
      color: var(--text);
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
    }}

    .bar-track {{
      height: 12px;
      background: var(--panel-2);
      border-radius: 999px;
      overflow: hidden;
      border: 1px solid #dce5ee;
    }}

    .bar-fill {{
      height: 100%;
      min-width: 2px;
      background: linear-gradient(90deg, var(--blue), var(--teal));
    }}

    .bar-value {{
      text-align: right;
      color: var(--muted);
      font-variant-numeric: tabular-nums;
    }}

    .controls {{
      display: grid;
      grid-template-columns: 1.5fr repeat(3, minmax(150px, .45fr));
      gap: 10px;
      margin-bottom: 12px;
    }}

    input, select {{
      width: 100%;
      border: 1px solid var(--line);
      border-radius: 6px;
      padding: 10px 11px;
      background: white;
      color: var(--text);
      font: inherit;
      font-size: 13px;
    }}

    table {{
      width: 100%;
      border-collapse: collapse;
      font-size: 12px;
    }}

    th {{
      text-align: left;
      color: #344054;
      background: #f3f6fa;
      border-bottom: 1px solid var(--line);
      padding: 10px 9px;
      position: sticky;
      top: 0;
      z-index: 1;
    }}

    td {{
      border-bottom: 1px solid #edf1f6;
      padding: 10px 9px;
      vertical-align: top;
    }}

    tbody tr {{
      cursor: pointer;
    }}

    tbody tr:hover {{
      background: #f7fbff;
    }}

    .table-wrap {{
      max-height: 520px;
      overflow: auto;
      border: 1px solid var(--line);
      border-radius: 8px;
    }}

    .score {{
      display: inline-flex;
      min-width: 44px;
      justify-content: center;
      border-radius: 999px;
      padding: 4px 8px;
      color: white;
      background: var(--blue);
      font-weight: 800;
      font-variant-numeric: tabular-nums;
    }}

    .pill {{
      display: inline-flex;
      align-items: center;
      gap: 5px;
      border-radius: 999px;
      padding: 4px 8px;
      margin: 2px 4px 2px 0;
      background: #edf4ff;
      color: #174ea6;
      font-size: 11px;
      font-weight: 760;
      white-space: nowrap;
    }}

    .pill.teal {{ background: #e8f6f4; color: #12645f; }}
    .pill.amber {{ background: #fff3df; color: #914600; }}
    .pill.red {{ background: #fff0ee; color: var(--red); }}
    .pill.green {{ background: #e9f7ee; color: var(--green); }}

    .shortlist {{
      display: grid;
      gap: 10px;
    }}

    .idea-card {{
      border: 1px solid var(--line);
      border-radius: 8px;
      padding: 12px;
      background: #ffffff;
      cursor: pointer;
    }}

    .idea-card:hover {{
      border-color: #9dc3e8;
      background: #f8fbff;
    }}

    .idea-title {{
      font-size: 13px;
      font-weight: 820;
      color: var(--ink);
      margin-bottom: 7px;
    }}

    .idea-meta {{
      color: var(--muted);
      font-size: 11px;
      margin-top: 6px;
    }}

    .detail {{
      border-left: 4px solid var(--teal);
      background: #f8fbfb;
    }}

    .detail h3 {{
      font-size: 17px;
      margin-bottom: 8px;
    }}

    .detail dl {{
      display: grid;
      grid-template-columns: 120px 1fr;
      gap: 8px 12px;
      margin: 14px 0 0;
      font-size: 12px;
    }}

    dt {{
      color: var(--muted);
      font-weight: 800;
    }}

    dd {{
      margin: 0;
    }}

    .notes {{
      display: grid;
      gap: 10px;
      color: #344054;
      font-size: 13px;
    }}

    .note-line {{
      border-left: 3px solid #aebdcc;
      padding-left: 10px;
    }}

    .cluster {{
      border-top: 1px solid var(--line);
      padding: 12px 0;
    }}

    .cluster:first-child {{
      border-top: 0;
      padding-top: 0;
    }}

    .cluster-title {{
      font-weight: 850;
      color: var(--ink);
      margin-bottom: 5px;
    }}

    .cluster ul {{
      margin: 8px 0 0 17px;
      padding: 0;
      color: var(--muted);
      font-size: 12px;
    }}

    footer {{
      color: var(--muted);
      font-size: 12px;
      margin-top: 18px;
    }}

    @media (max-width: 1180px) {{
      .kpis {{ grid-template-columns: repeat(3, minmax(0, 1fr)); }}
      .grid {{ grid-template-columns: 1fr; }}
      .charts {{ grid-template-columns: 1fr; }}
    }}

    @media (max-width: 780px) {{
      header {{ padding: 24px 18px; }}
      main {{ padding: 18px; }}
      .kpis {{ grid-template-columns: repeat(2, minmax(0, 1fr)); }}
      .controls {{ grid-template-columns: 1fr; }}
      .bar-row {{ grid-template-columns: 1fr; gap: 5px; }}
      .bar-value {{ text-align: left; }}
    }}
  </style>
</head>
<body>
  <header>
    <div class="shell">
      <div class="eyebrow">Fast data demo</div>
      <h1>VenSpark Opportunity Triage</h1>
      <p class="subtitle">
        A static interactive report from <strong>{html.escape(TABLE_NAME)}</strong>, designed to find practical ideas worth actioning first.
        It uses only available idea metadata and excludes submitter/owner personal fields.
      </p>
    </div>
  </header>

  <main>
    <section class="kpis" id="kpis"></section>

    <section class="grid">
      <div>
        <section class="panel">
          <div class="panel-head">
            <div>
              <h2>Opportunity Portfolio</h2>
              <p class="hint">Campaign, stage/status and theme mix from the current table extract.</p>
            </div>
          </div>
          <div class="panel-body charts">
            <div class="chart-block">
              <h3 class="hint">Top campaigns by idea count</h3>
              <div id="campaignChart"></div>
            </div>
            <div class="chart-block">
              <h3 class="hint">Stage / status funnel</h3>
              <div id="stageChart"></div>
            </div>
            <div class="chart-block">
              <h3 class="hint">Theme mix</h3>
              <div id="themeChart"></div>
            </div>
            <div class="chart-block">
              <h3 class="hint">Estimated delivery effort</h3>
              <div id="effortChart"></div>
            </div>
          </div>
        </section>

        <section class="panel">
          <div class="panel-head">
            <div>
              <h2>Explore Ideas</h2>
              <p class="hint">Click a row to inspect why it was ranked. Scores are a triage heuristic, not approval.</p>
            </div>
          </div>
          <div class="panel-body">
            <div class="controls">
              <input id="search" type="search" placeholder="Search title, campaign, stage or theme">
              <select id="themeFilter"><option value="">All themes</option></select>
              <select id="effortFilter"><option value="">All effort levels</option></select>
              <select id="statusFilter"><option value="">All statuses</option></select>
            </div>
            <div class="table-wrap">
              <table>
                <thead>
                  <tr>
                    <th>Score</th>
                    <th>Idea</th>
                    <th>Theme</th>
                    <th>Stage / status</th>
                    <th>Engagement</th>
                    <th>Why it surfaced</th>
                  </tr>
                </thead>
                <tbody id="ideaRows"></tbody>
              </table>
            </div>
          </div>
        </section>
      </div>

      <aside>
        <section class="panel detail">
          <div class="panel-body" id="ideaDetail"></div>
        </section>

        <section class="panel">
          <div class="panel-head">
            <div>
              <h2>Recommended Quick Demo</h2>
              <p class="hint">Low-effort, high-engagement candidates.</p>
            </div>
          </div>
          <div class="panel-body shortlist" id="quickWins"></div>
        </section>

        <section class="panel">
          <div class="panel-head">
            <div>
              <h2>Data-Related Ideas</h2>
              <p class="hint">Good candidates for analytics, reporting or data-quality demos.</p>
            </div>
          </div>
          <div class="panel-body shortlist" id="dataIdeas"></div>
        </section>
      </aside>
    </section>

    <section class="grid">
      <section class="panel">
        <div class="panel-head">
          <div>
            <h2>Overlaps To Consolidate</h2>
            <p class="hint">Inferred duplicates or related idea families based on title and description keywords.</p>
          </div>
        </div>
        <div class="panel-body" id="clusters"></div>
      </section>

      <section class="panel">
        <div class="panel-head">
          <div>
            <h2>Assumptions And Data Quality</h2>
            <p class="hint">What this demo can and cannot claim from the source table.</p>
          </div>
        </div>
        <div class="panel-body notes" id="notes"></div>
      </section>
    </section>

    <footer id="footer"></footer>
  </main>

  <script id="ideas-json" type="application/json">{json_for_html(ideas)}</script>
  <script id="summary-json" type="application/json">{json_for_html(summary)}</script>
  <script>
    const ideas = JSON.parse(document.getElementById('ideas-json').textContent);
    const summary = JSON.parse(document.getElementById('summary-json').textContent);
    const byId = new Map(ideas.map((idea) => [String(idea.idea_id), idea]));
    const fmt = new Intl.NumberFormat('en-AU');
    const dateFmt = new Intl.DateTimeFormat('en-AU', {{ dateStyle: 'medium', timeStyle: 'short' }});

    const state = {{
      search: '',
      theme: '',
      effort: '',
      status: '',
      selectedId: ideas[0]?.idea_id,
    }};

    function safeText(value) {{
      return value == null || value === '' ? 'Not supplied' : String(value);
    }}

    function formatDate(value) {{
      if (!value) return 'Not supplied';
      const date = new Date(value);
      if (Number.isNaN(date.valueOf())) return String(value);
      return dateFmt.format(date);
    }}

    function kpiCard(label, value, note) {{
      return `<article class="card"><div class="label">${{label}}</div><div class="value">${{fmt.format(value)}}</div><div class="note">${{note}}</div></article>`;
    }}

    function renderKpis() {{
      const counts = summary.counts;
      const source = summary.source_summary || {{}};
      document.getElementById('kpis').innerHTML = [
        kpiCard('Source rows', Number(source.source_rows || counts.ideas_loaded), `Databricks table count, loaded ${{formatDate(source.last_loaded_at)}}`),
        kpiCard('Ideas analysed', counts.ideas_loaded, 'Non-deleted, non-comment idea records'),
        kpiCard('Open ideas', counts.open_ideas, 'Not inferred as closed, duplicate or rejected'),
        kpiCard('Quick wins', counts.quick_wins, 'Low-effort candidates still open'),
        kpiCard('Data-related', counts.data_related, 'Analytics, reporting or data-quality themes'),
        kpiCard('Stale active', counts.stale_active, 'Open ideas with old status movement'),
      ].join('');
    }}

    function renderBars(targetId, rows, valueKey = 'count') {{
      const max = Math.max(1, ...rows.map((row) => Number(row[valueKey] || 0)));
      document.getElementById(targetId).innerHTML = rows.map((row) => {{
        const value = Number(row[valueKey] || 0);
        const width = Math.max(2, Math.round((value / max) * 100));
        const title = `${{row.label}}: ${{fmt.format(value)}} ideas, ${{fmt.format(row.likes || 0)}} likes, ${{fmt.format(row.comments || 0)}} comments`;
        return `
          <div class="bar-row" title="${{title.replaceAll('"', '&quot;')}}">
            <div class="bar-label">${{row.label}}</div>
            <div class="bar-track"><div class="bar-fill" style="width:${{width}}%"></div></div>
            <div class="bar-value">${{fmt.format(value)}}</div>
          </div>`;
      }}).join('');
    }}

    function pill(text, kind = '') {{
      return `<span class="pill ${{kind}}">${{text}}</span>`;
    }}

    function ideaCard(idea) {{
      const flags = [
        pill(String(idea.priority_score), 'green'),
        idea.quick_win ? pill('Quick win', 'teal') : '',
        idea.data_related ? pill('Data', '') : '',
        idea.stale ? pill('Stale', 'amber') : '',
      ].join('');
      return `
        <article class="idea-card" data-id="${{idea.idea_id}}">
          <div class="idea-title">${{idea.title}}</div>
          <div>${{flags}}</div>
          <div class="idea-meta">${{idea.stage_title}} / ${{idea.status_title}} - ${{idea.likes}} likes, ${{idea.comments}} comments</div>
        </article>`;
    }}

    function filteredIdeas() {{
      const query = state.search.trim().toLowerCase();
      return ideas.filter((idea) => {{
        if (state.theme && idea.theme !== state.theme) return false;
        if (state.effort && idea.effort !== state.effort) return false;
        if (state.status && idea.status_title !== state.status) return false;
        if (!query) return true;
        const haystack = [idea.title, idea.campaign_title, idea.stage_title, idea.status_title, idea.theme, idea.evidence].join(' ').toLowerCase();
        return haystack.includes(query);
      }});
    }}

    function renderRows() {{
      const rows = filteredIdeas().slice(0, 160);
      document.getElementById('ideaRows').innerHTML = rows.map((idea) => `
        <tr data-id="${{idea.idea_id}}">
          <td><span class="score">${{idea.priority_score}}</span></td>
          <td><strong>${{idea.title}}</strong><br><span class="hint">${{idea.campaign_title}}</span></td>
          <td>${{idea.theme}}<br>${{pill(idea.effort + ' effort', idea.effort === 'High' ? 'amber' : idea.effort === 'Low' ? 'teal' : '')}}</td>
          <td>${{idea.stage_title}}<br><span class="hint">${{idea.status_title}}</span></td>
          <td>${{fmt.format(idea.likes)}} likes<br>${{fmt.format(idea.comments)}} comments</td>
          <td>${{idea.evidence}}</td>
        </tr>`).join('');
      document.querySelectorAll('[data-id]').forEach((element) => {{
        element.addEventListener('click', () => selectIdea(element.dataset.id));
      }});
    }}

    function selectIdea(id) {{
      const idea = byId.get(String(id)) || ideas[0];
      if (!idea) return;
      state.selectedId = idea.idea_id;
      document.getElementById('ideaDetail').innerHTML = `
        <h3>${{idea.title}}</h3>
        <div>
          ${{pill('Score ' + idea.priority_score, 'green')}}
          ${{idea.quick_win ? pill('Quick win', 'teal') : ''}}
          ${{idea.data_related ? pill('Data-related', '') : ''}}
          ${{idea.stale ? pill('Needs follow-up', 'amber') : ''}}
          ${{idea.closed ? pill('Closed/inactive', 'red') : ''}}
        </div>
        <dl>
          <dt>Campaign</dt><dd>${{idea.campaign_title}}</dd>
          <dt>Stage/status</dt><dd>${{idea.stage_title}} / ${{idea.status_title}}</dd>
          <dt>Theme</dt><dd>${{idea.theme}}</dd>
          <dt>Effort</dt><dd>${{idea.effort}}</dd>
          <dt>Engagement</dt><dd>${{fmt.format(idea.likes)}} likes, ${{fmt.format(idea.comments)}} comments, ${{fmt.format(idea.votes)}} votes</dd>
          <dt>Submitted</dt><dd>${{formatDate(idea.submitted_at)}}</dd>
          <dt>Evidence</dt><dd>${{idea.evidence}}</dd>
          <dt>Next step</dt><dd>${{idea.recommended_next_step}}</dd>
        </dl>`;
    }}

    function populateFilters() {{
      const filters = [
        ['themeFilter', [...new Set(ideas.map((idea) => idea.theme))].sort()],
        ['effortFilter', [...new Set(ideas.map((idea) => idea.effort))].sort()],
        ['statusFilter', [...new Set(ideas.map((idea) => idea.status_title))].sort()],
      ];
      filters.forEach(([id, values]) => {{
        const select = document.getElementById(id);
        values.forEach((value) => {{
          const option = document.createElement('option');
          option.value = value;
          option.textContent = value;
          select.appendChild(option);
        }});
      }});

      document.getElementById('search').addEventListener('input', (event) => {{
        state.search = event.target.value;
        renderRows();
      }});
      document.getElementById('themeFilter').addEventListener('change', (event) => {{
        state.theme = event.target.value;
        renderRows();
      }});
      document.getElementById('effortFilter').addEventListener('change', (event) => {{
        state.effort = event.target.value;
        renderRows();
      }});
      document.getElementById('statusFilter').addEventListener('change', (event) => {{
        state.status = event.target.value;
        renderRows();
      }});
    }}

    function renderShortlists() {{
      document.getElementById('quickWins').innerHTML = summary.shortlists.quick_wins.slice(0, 7).map(ideaCard).join('');
      document.getElementById('dataIdeas').innerHTML = summary.shortlists.data_related.slice(0, 7).map(ideaCard).join('');
    }}

    function renderClusters() {{
      const clusters = summary.duplicate_clusters || [];
      document.getElementById('clusters').innerHTML = clusters.length ? clusters.map((cluster) => `
        <div class="cluster">
          <div class="cluster-title">${{cluster.cluster}}</div>
          <div class="hint">${{cluster.count}} related ideas, ${{fmt.format(cluster.engagement)}} likes/comments combined</div>
          <ul>
            ${{cluster.ideas.map((idea) => `<li>${{idea.title}} <span class="hint">(${{idea.stage_status}}, score ${{idea.priority_score}})</span></li>`).join('')}}
          </ul>
        </div>`).join('') : '<p class="hint">No duplicate clusters inferred.</p>';
    }}

    function renderNotes() {{
      const notes = [
        ...summary.scoring_rubric,
        ...summary.data_quality_notes,
      ];
      document.getElementById('notes').innerHTML = notes.map((note) => `<div class="note-line">${{note}}</div>`).join('');
      document.getElementById('footer').textContent = `Generated ${{formatDate(summary.generated_at_utc)}} from ${{summary.source_table}} using profile ${{summary.profile}}.`;
    }}

    renderKpis();
    renderBars('campaignChart', summary.charts.campaigns);
    renderBars('stageChart', summary.charts.stage_status);
    renderBars('themeChart', summary.charts.themes);
    renderBars('effortChart', summary.charts.effort);
    populateFilters();
    renderRows();
    renderShortlists();
    renderClusters();
    renderNotes();
    selectIdea(state.selectedId);
  </script>
</body>
</html>
"""


def readme_text(summary: dict[str, Any]) -> str:
    return f"""# VenSpark Idea Triage Demo

This folder contains a self-contained static HTML demo generated from Databricks table `{TABLE_NAME}`.

## Open

Open `index.html` in a browser. No local server is required.

## What it does

- Ranks VenSpark ideas using available source-table fields only.
- Highlights quick-win candidates, data-related opportunities, stale active ideas and likely overlaps.
- Excludes submitter and owner personal fields from the exported JSON and HTML.
- Uses inferred effort/theme tags from title and description text. These are triage aids, not confirmed delivery estimates.

## Current extract

- Source rows: {summary["source_summary"].get("source_rows")}
- Ideas analysed: {summary["counts"].get("ideas_loaded")}
- Last loaded: {summary["source_summary"].get("last_loaded_at")}
- Generated: {summary.get("generated_at_utc")}

## Files

- `index.html`: interactive report.
- `data/ideas.json`: sanitized idea-level export used by the report.
- `data/summary.json`: chart data, counts, shortlists and caveats.
- `queries.sql`: Databricks SQL used for the extract.
- `generate_report.py`: repeatable generator.
"""


def queries_text() -> str:
    return f"""-- Source table
-- {TABLE_NAME}

-- Sanitized idea extract used by the demo.
{IDEAS_SQL};

-- Source-table count and recency check.
{SUMMARY_SQL};
"""


def main() -> int:
    DATA_DIR.mkdir(parents=True, exist_ok=True)
    print(f"Fetching source summary from {TABLE_NAME}...")
    source_summary_rows = execute_statement(SUMMARY_SQL)
    if not source_summary_rows:
        raise RuntimeError("Summary query returned no rows.")
    source_summary = source_summary_rows[0]

    print(f"Fetching sanitized idea rows from {TABLE_NAME}...")
    raw_rows = execute_statement(IDEAS_SQL)
    ideas = enrich(raw_rows)
    summary = make_summary(ideas, source_summary)

    (DATA_DIR / "ideas.json").write_text(
        json.dumps(ideas, indent=2, ensure_ascii=False),
        encoding="utf-8",
    )
    (DATA_DIR / "summary.json").write_text(
        json.dumps(summary, indent=2, ensure_ascii=False),
        encoding="utf-8",
    )
    (ROOT / "index.html").write_text(report_html(ideas, summary), encoding="utf-8")
    (ROOT / "README.md").write_text(readme_text(summary), encoding="utf-8")
    (ROOT / "queries.sql").write_text(queries_text(), encoding="utf-8")

    print(f"Wrote {ROOT / 'index.html'}")
    print(f"Ideas analysed: {len(ideas)}")
    print(f"Quick wins: {summary['counts']['quick_wins']}")
    print(f"Data-related: {summary['counts']['data_related']}")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except Exception as exc:
        print(f"ERROR: {exc}", file=sys.stderr)
        raise SystemExit(1)
