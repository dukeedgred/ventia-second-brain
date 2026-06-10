# VenSpark Idea Triage Demo

This folder contains a self-contained static HTML demo generated from Databricks table `staged.stg_api_venspark.ideas`.

## Open

Open `index.html` in a browser. No local server is required.

## What it does

- Ranks VenSpark ideas using available source-table fields only.
- Highlights quick-win candidates, data-related opportunities, stale active ideas and likely overlaps.
- Excludes submitter and owner personal fields from the exported JSON and HTML.
- Uses inferred effort/theme tags from title and description text. These are triage aids, not confirmed delivery estimates.

## Current extract

- Source rows: 542
- Ideas analysed: 542
- Last loaded: 2026-06-10 01:32:09.907871
- Generated: 2026-06-10T04:56:17+00:00

## Files

- `index.html`: interactive report.
- `data/ideas.json`: sanitized idea-level export used by the report.
- `data/summary.json`: chart data, counts, shortlists and caveats.
- `queries.sql`: Databricks SQL used for the extract.
- `generate_report.py`: repeatable generator.
