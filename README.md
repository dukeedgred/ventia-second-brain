# Ventia Second Brain

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

Run all commands from the repository root:

```powershell
cd C:\Users\<you>\projects\ventia-second-brain
npm install
```

If your npm is configured for offline mode, install with offline mode disabled
for this command:

```powershell
npm install --offline=false
```

To make that permanent for future installs:

```powershell
npm config set offline false
```

Check the setting with:

```powershell
npm config get offline
```

It should print `false`.

## Start

```powershell
npm run dev
```

This starts both services:

- Web app: `http://localhost:5280`
- API: `http://localhost:8787`

Stop the app with `Ctrl+C`.

## First-Time Setup Checklist

```powershell
node -v
npm -v
codex doctor
npm config get offline
npm install --offline=false
npm run dev
```

Expected result: the web app opens at `http://localhost:5280`, and the backend
health endpoint returns OK at `http://localhost:8787/api/health`.

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

**`npm install` says it cannot find `package.json`**

You are in the wrong folder. Run `npm install` from the repository root, where
`package.json` lives:

```powershell
cd C:\Users\<you>\projects\ventia-second-brain
```

**`npm install` fails with `ENOTCACHED`**

Npm is in offline mode and is refusing to download missing packages. Check it:

```powershell
npm config get offline
```

If it prints `true`, either run:

```powershell
npm install --offline=false
```

or turn offline mode off permanently:

```powershell
npm config set offline false
```

**`npm install` fails with `UNABLE_TO_GET_ISSUER_CERT_LOCALLY`**

Node/npm does not trust the certificate chain used by your network. This often
happens on corporate networks with SSL inspection.

Preferred fix: install/configure the corporate root CA, then point npm at it:

```powershell
npm config set cafile C:\path\to\corporate-ca.pem
npm install --offline=false
```

Short-term unblock only:

```powershell
npm install --offline=false --strict-ssl=false --no-audit --no-fund
```

Do not keep `strict-ssl=false` as your normal setup. It disables npm TLS
certificate verification.

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
