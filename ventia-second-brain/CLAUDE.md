# Legacy Claude Guidance

This repository is now Codex-compatible. Use `AGENTS.md` as the source of truth
for agent instructions, commands, architecture, and AI backend details.

The runtime AI backend now uses local `codex exec --json` through
`server/codex.ts`, not `claude -p`.
