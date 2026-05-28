# Content Guidelines

This directory is the markdown knowledge base for the Ventia Indirect
Procurement Spend Cube engagement.

## Layout

- `index.md`: catalog/map of curated pages. Consult it first.
- `wiki/Ventia/`: curated pages, Title Case filenames, one concept or entity per page.
- `raw/`: immutable source notes. Cite for provenance; do not edit.
- `tickets/`: one markdown file per action item.
- `decisions/`: one markdown file per decision record.
- `docs/`: generated living documents.
- `log.md`: append-only history.
- `resources.md`: external links table.

## Conventions

- Link pages with `[[Page Name]]` wikilinks matching target filenames.
- Use frontmatter on wiki pages: `type`, `topic: Ventia`, `sources`,
  `date-created`, `date-updated`, and `tags`.
- Prefer curated `wiki/` pages over `raw/`.
- Prefer updating an existing page over creating a near-duplicate.
- Never delete unique content.

## Infrastructure Files

`index.md`, `log.md`, `resources.md`, `AGENTS.md`, and `CLAUDE.md` are
infrastructure, not knowledge pages. Do not treat them as orphans, require them
in the catalog, or graph them as curated knowledge.
