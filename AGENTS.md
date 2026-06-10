# Repository Guidelines

This file provides guidance to Codex when working in this repository.

## What This Is

Ventia Second Brain is a team knowledge base for the Ventia Indirect Procurement
Spend Cube engagement. It uses curated markdown notes as the data store, with a
React UI for search, graph navigation, Ask, Ingest, Docs, Tickets, Decisions, and
Lint.

The AI features are powered by the local Codex CLI through `codex exec --json`.
There is no app-level API key.

## Commands

```bash
npm install
npm run dev       # Vite web on :5280 plus Express API on :8787
npm run dev:web   # Vite only
npm run dev:api   # API only
npm run build     # tsc -b && vite build
npm run lint      # eslint .
npm run preview
```

Always finish code changes with `npm run build`. Prefer also running
`npm run lint` when touching TypeScript or React files.

## Architecture

```text
Browser (React 19 / HeroUI) -- /api --> Express :8787
  data routes                    --> read/write content/*.md
  ask / docs / extract           --> codex exec, read-only sandbox
  ingest / lint fix              --> codex exec, workspace-write sandbox
```

Core server files:

| Path | Purpose |
|---|---|
| `server/index.ts` | Express routes and SSE endpoints |
| `server/codex.ts` | Shared Codex CLI adapter |
| `server/brain.ts` | Ask the Brain prompt and read-only run |
| `server/docs.ts` | AI-generated living docs |
| `server/extract.ts` | Ticket/decision proposal extraction |
| `server/ingest.ts` | Source ingestion into `content/` |
| `server/lint.ts` | Knowledge-base audit and fix |
| `server/content.ts` | Safe markdown file access |
| `server/git.ts` | Auto-commit and optional sync |

Frontend stateful streaming providers live above the router:
`ThemeProvider`, `AskProvider`, `LintProvider`, `NotesProvider`, and
`IngestProvider`. New long-running streams should follow that pattern.

## Codex Integration

`server/codex.ts` runs:

```text
codex exec --json --sandbox <read-only|workspace-write> --ask-for-approval never -C <content-dir> -o <temp-file> -
```

The prompt is sent through stdin to avoid Windows command-line length limits.
Use read-only sandbox for answering, extracting, and document generation. Use
workspace-write only when the feature is expected to edit `content/`.

Environment variables:

| Var | Purpose |
|---|---|
| `BRAIN_PROVIDER=cli` | Use local Codex CLI |
| `BRAIN_CODEX_MODEL` | Optional model override |
| `BRAIN_CODEX_PROFILE` | Optional Codex profile override |
| `BRAIN_MODEL` | Legacy model override still accepted |

## Content Model

Everything is markdown under `content/`; there is no database.

```text
content/
  index.md          catalog of curated pages
  log.md            append-only operations log
  resources.md      external links table
  raw/              immutable source notes
  wiki/Ventia/      curated knowledge pages
  wiki/Ventia/Data Tables/
                    table documentation organized by sector and contract/schema
  tickets/          markdown-backed action items
  decisions/        markdown-backed ADRs
  docs/             generated living documents
```

Wikilinks `[[Basename]]` drive navigation and graph edges. Prefer updating an
existing page over creating a near-duplicate. Never delete unique content.

Table documentation should live in the wiki, not in a root `tables.md`. For
Transport sector table metadata, use
`content/wiki/Ventia/Data Tables/Transport/`, with a sector catalog,
contract/schema catalog pages, and one unique table page per table. Different
Transport schemas represent different contract or contract-group contexts unless
source material says otherwise. When a Transport table is a view and source
material includes the view SQL/query, preserve that SQL in the table wiki page
as a fenced `sql` block.

## Rules

- Ask is read-only. Do not let Ask edit files.
- Ingest and Lint fix may write only under `content/`.
- For any workflow that needs to fetch data from Databricks, do not request,
  store, or use personal access tokens or `DATABRICKS_TOKEN`. Use an interactive
  OAuth/user-to-machine flow that redirects the user to a browser link, such as
  Databricks CLI `auth login` or the Databricks SQL connector with
  `auth_type="databricks-oauth"`.
- Keep markdown pages source-backed and connected with wikilinks.
- HeroUI is v2 with Tailwind v3; do not upgrade casually.
- Prefer HeroUI semantic tokens over hardcoded hex in app UI.
- The dark Obsidian theme is the default; keep theme changes additive.
- Content writes auto-commit through `server/git.ts` when `BRAIN_AUTOCOMMIT` is on.

## Verification

There is no dedicated test framework. Verification is a clean build plus manual
exercise of the touched workflow where practical:

```bash
npm run lint
npm run build
```

API health check:

```text
GET http://localhost:8787/api/health
```
