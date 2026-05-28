#!/usr/bin/env python3
import argparse
from datetime import date
from pathlib import Path


VALID_PRIORITIES = {"low", "medium", "high"}
VALID_STATUSES = {"todo", "in-progress", "done"}


def sanitize(title: str) -> str:
    cleaned = "".join(" " if c in '<>:"/\\|?*\n\r' else c for c in title)
    cleaned = " ".join(cleaned.split()).strip()
    return (cleaned[:120] or "Untitled").strip()


def yaml_string(value: str) -> str:
    escaped = value.replace("\\", "\\\\").replace('"', '\\"')
    return f'"{escaped}"'


def yaml_array(values: list[str]) -> str:
    if not values:
        return "[]"
    return "[" + ", ".join(yaml_string(v) for v in values) + "]"


def unique_path(folder: Path, title: str) -> Path:
    base = sanitize(title)
    candidate = folder / f"{base}.md"
    index = 2
    while candidate.exists():
        candidate = folder / f"{base} ({index}).md"
        index += 1
    return candidate


def build_ticket(args: argparse.Namespace) -> str:
    body = args.description.strip()
    return "\n".join(
        [
            "---",
            "type: ticket",
            f"status: {args.status}",
            f"priority: {args.priority}",
            f"assignee: {yaml_string(args.assignee)}",
            f"sources: {yaml_array(args.source)}",
            f"date-created: {date.today().isoformat()}",
            "---",
            "",
            body,
            "",
        ]
    )


def main() -> int:
    parser = argparse.ArgumentParser(description="Add a persistent ticket to the Ventia Second Brain.")
    parser.add_argument("--content-dir", default="content", help="Path to the app content directory.")
    parser.add_argument("--title", required=True, help="Ticket title.")
    parser.add_argument("--description", default="", help="Ticket body/description.")
    parser.add_argument("--priority", default="medium", choices=sorted(VALID_PRIORITIES))
    parser.add_argument("--status", default="todo", choices=sorted(VALID_STATUSES))
    parser.add_argument("--assignee", default="Unassigned")
    parser.add_argument("--source", action="append", default=[], help="Source note path. Can be repeated.")
    args = parser.parse_args()

    content_dir = Path(args.content_dir).resolve()
    tickets_dir = content_dir / "tickets"
    tickets_dir.mkdir(parents=True, exist_ok=True)

    path = unique_path(tickets_dir, args.title)
    path.write_text(build_ticket(args), encoding="utf-8")
    print(path.relative_to(content_dir).as_posix())
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
