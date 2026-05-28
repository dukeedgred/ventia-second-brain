# ResMed Second Brain

A team knowledge base with markdown notes, search, an interactive graph, and an
"Ask the Brain" assistant grounded in the local workspace.

## Requirements

| Requirement | Notes |
|---|---|
| Node.js 18+ | Check with `node -v`. |
| Codex CLI | The backend runs local `codex exec` for Ask, Ingest, Docs, Lint, and Extract. Install and sign in, then run `codex doctor` to confirm it is ready. |

No separate API key is required by this app when the Codex CLI is already
authenticated.

## Install

```bash
npm install
```

## Start

```bash
npm run dev
```

This starts:

- Web app: `http://localhost:5280`
- API: `http://localhost:8787`

Stop the app with `Ctrl+C`.

## Optional Settings

Copy the example environment file if you want to change defaults:

```bash
cp .env.example .env
```

| Setting | What it does | Default |
|---|---|---|
| `PORT` | Backend API port | `8787` |
| `CONTENT_DIR` | Folder where notes live | `./content` |
| `BRAIN_PROVIDER` | Brain engine provider | `cli` |
| `BRAIN_CODEX_MODEL` | Optional Codex model override | Codex CLI default |
| `BRAIN_CODEX_PROFILE` | Optional Codex profile override | Codex CLI default |

`BRAIN_MODEL` is still accepted as a legacy model override, but
`BRAIN_CODEX_MODEL` is preferred.

## Troubleshooting

**The page will not load at `http://localhost:5280`**

Make sure `npm run dev` is still running and did not show an error. If port 5280
or 8787 is already in use, close the other process or set a different `PORT` in
`.env`.

**Ask, Ingest, Docs, Lint, or Extract fails**

Run `codex doctor` in a terminal and confirm the CLI is installed, authenticated,
and on `PATH`, then restart `npm run dev`.

**`node` or `npm` is not recognized**

Install Node.js and open a fresh terminal.

## Build

```bash
npm run build
npm run preview
```
