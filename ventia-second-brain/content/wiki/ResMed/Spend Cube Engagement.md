---
type: overview
topic: ResMed
sources: ["raw/May 25, 2026.md"]
date-created: 2026-05-25
date-updated: 2026-05-28
tags: [project, spend-cube, engagement, overview]
---

# Spend Cube Engagement

ResMed Indirect Procurement — Spend Cube: an engagement to classify and analyse indirect spend using a cascade of rule-based, RAG, and LLM methods.

## Objective

Build a spend cube that accurately categorises indirect procurement spend across ResMed, enabling visibility and reporting at L1–L4 taxonomy levels.

## Timeline

- **Mini UAT:** Tuesday or Wednesday (week of 2026-05-25) — [[UAT Planning]]
- **Target completion:** mid-July 2026

## Tooling

| Tool | Purpose |
|---|---|
| Obsidian / Second Brain | Project management, artifact capture, meeting notes ingestion |
| Snowflake | Data warehouse; output tables; write access provisioned by Benji |
| Streamlit | UI for demonstrating classification results to Erikson / Benjamin |
| Codex CLI | Backend AI for Second Brain queries and wiki maintenance |

## Current Status (as of 2026-05-25)

- Obsidian second brain configured; requires Codex CLI authenticated on user machine.
- Write access to Snowflake for the team **pending** (awaiting Benji confirmation).
- Workaround: file extracts used to share results for the Tuesday milestone instead of a full SQL table.
- Three determination columns will be kept separate for initial UAT: rule-based, RAG, LLM/AI (see [[Classification Approach]]).
- Streamlit UI being finalised by Duke Kang; mock Snowflake tables in progress.

## Project Management Process

The team adopted a new PM process: meeting notes capture decisions and action items via Obsidian rather than a Jira-style ticketing system. Charlotte Pan owns documentation of decisions and waiting criteria.

## Related Pages

- [[Engagement Team]]
- [[Classification Approach]]
- [[Evaluation Framework]]
- [[Taxonomy and Stakeholders]]
- [[UAT Planning]]
