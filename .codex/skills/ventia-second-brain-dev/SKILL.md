---
name: ventia-second-brain-dev
description: Work on the Ventia Second Brain repository. Use when modifying the React/HeroUI frontend, Express backend, markdown knowledge-base workflows, Codex-powered Ask/Ingest/Docs/Extract/Lint features, git auto-commit/sync behavior, or project documentation in this repo.
---

# Ventia Second Brain Dev

## Project Shape

This is a markdown-backed team knowledge base for the Ventia Indirect
Procurement Spend Cube engagement.

```text
Browser (React 19 / HeroUI) -- /api --> Express :8787
  data routes                    --> read/write content/*.md
  ask / docs / extract           --> codex exec, read-only sandbox
  ingest / lint fix              --> codex exec, workspace-write sandbox
```

Key paths:

- `server/index.ts`: Express routes and SSE endpoints.
- `server/codex.ts`: shared local Codex CLI adapter.
- `server/brain.ts`: Ask prompt and read-only Codex run.
- `server/docs.ts`: generated living documents.
- `server/extract.ts`: ticket/decision proposal extraction.
- `server/ingest.ts`: source ingestion into `content/`.
- `server/lint.ts`: knowledge-base audit/fix.
- `server/content.ts`: safe markdown file access.
- `server/git.ts`: auto-commit and optional sync.
- `src/lib/*`: streaming/state providers.
- `src/pages/*` and `src/components/*`: HeroUI frontend.

## Commands

```bash
npm install
npm run dev
npm run dev:web
npm run dev:api
npm run build
npm run lint
npm run preview
```

Always finish implementation changes with `npm run build`. Run `npm run lint`
when touching TypeScript or React, but be aware this repo currently has existing
React 19 lint failures unrelated to Codex compatibility.

## Codex Runtime

AI features must use `server/codex.ts`, not direct `claude` calls.

The adapter runs:

```text
codex exec --json --sandbox <read-only|workspace-write> --ask-for-approval never -C <content-dir> -o <temp-file> -
```

Rules:

- Use `read-only` sandbox for Ask, Docs generation, and Extract.
- Use `workspace-write` only for Ingest and Lint fix workflows.
- Send long prompts through stdin to avoid Windows command-line length limits.
- Prefer `BRAIN_CODEX_MODEL` and `BRAIN_CODEX_PROFILE` for Codex overrides.
- Keep `BRAIN_MODEL` only as a legacy model override fallback.
- Keep Ask read-only. Do not add write capability to Ask.

## Content Model

Everything is markdown under `content/`; there is no database.

```text
content/
  index.md
  log.md
  resources.md
  raw/
  wiki/Ventia/
  tickets/
  decisions/
  docs/
```

Wikilinks `[[Basename]]` drive navigation and graph edges. Prefer updating an
existing page over creating a near-duplicate. Never delete unique content.

Infrastructure files such as `index.md`, `log.md`, `resources.md`, `AGENTS.md`,
and `CLAUDE.md` are not curated knowledge pages.

## Frontend Rules

- HeroUI is v2 with Tailwind v3. Do not casually upgrade either.
- Prefer HeroUI semantic tokens over hardcoded hex values.
- Keep the dark Obsidian theme as the default; make theme changes additive.
- Long-running stream state must live above the router so it survives tab/page
  switches. Follow the existing `AskProvider`, `IngestProvider`, and
  `LintProvider` patterns.
- Do not put new streaming state only inside a page component.

## Git Sync

Content writes can auto-commit through `server/git.ts`.

- `BRAIN_AUTOCOMMIT` defaults on.
- `BRAIN_GIT_SYNC` defaults off.
- Write workflows during development may create commits scoped to `content/`.
- Do not bypass the queue/status handling in `server/git.ts`.

## Verification

Minimum verification for code changes:

```bash
npm run build
```

Useful backend-only check when server files change:

```bash
npx tsc --ignoreConfig --noEmit --target es2023 --module esnext --moduleResolution bundler --types node --skipLibCheck server/index.ts server/brain.ts server/codex.ts server/content.ts server/docs.ts server/extract.ts server/git.ts server/graph.ts server/ingest.ts server/items.ts server/lint.ts server/resources.ts server/search.ts
```

Runtime health check:

```text
GET http://localhost:8787/api/health
```
