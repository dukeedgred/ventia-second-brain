---
name: add-tickets-to-tab
description: Add persistent tickets to the ResMed Second Brain Tickets tab. Use when the user asks Codex to create, capture, persist, file, or add action items, tasks, follow-ups, to-dos, blockers, or tickets into the app's Tickets tab.
---

# Add Tickets To Tab

## What This Does

Persist tickets as markdown files under `content/tickets/`. The Tickets tab reads
that folder through `/api/tickets`, so adding a file there is the stateful source
of truth.

Use the bundled script for reliable file naming and frontmatter:

```bash
python .codex/skills/add-tickets-to-tab/scripts/add_ticket.py --title "Follow up with Benji on Snowflake access" --description "Confirm write access timing and capture any workaround." --priority high --assignee "Duke"
```

## Ticket Schema

Each ticket is a markdown file:

```markdown
---
type: ticket
status: todo
priority: medium
assignee: Unassigned
sources: []
date-created: 2026-05-28
---

Ticket description goes here.
```

Valid values:

- `status`: `todo`, `in-progress`, `done`
- `priority`: `low`, `medium`, `high`
- `assignee`: any string, default `Unassigned`
- `sources`: optional list of note paths, for example `raw/May 25, 2026.md`

## Workflow

1. Convert the user's request into one or more concrete tickets.
2. Prefer a short imperative title.
3. Use the script once per ticket.
4. If the dev server is running, the Tickets tab updates after refresh. No extra
   app code change is required.
5. Mention the created ticket paths in the final response.

## Script Usage

```bash
python .codex/skills/add-tickets-to-tab/scripts/add_ticket.py `
  --title "Ticket title" `
  --description "One or two sentence description" `
  --priority medium `
  --status todo `
  --assignee "Unassigned" `
  --source "raw/May 25, 2026.md"
```

Options:

- `--content-dir`: defaults to `content`
- `--title`: required
- `--description`: optional
- `--priority`: `low`, `medium`, or `high`
- `--status`: `todo`, `in-progress`, or `done`
- `--assignee`: defaults to `Unassigned`
- `--source`: repeatable; adds entries to `sources`

The script avoids overwriting existing tickets by appending ` (2)`, ` (3)`, etc.
