import { promises as fs } from 'node:fs'
import path from 'node:path'
import { CONTENT_DIR } from './content'
import type { BrainEvent } from './brain'
import { runCodex } from './codex'

function sanitize(t: string): string {
  return (
    t.replace(/[<>:"/\\|?*\n\r]/g, ' ').replace(/\s+/g, ' ').trim().slice(0, 120) || 'Source'
  )
}

/** When no title is given, name the source from its first non-empty line. */
function deriveName(content: string, today: string): string {
  const firstLine = content
    .split('\n')
    .map((l) => l.replace(/^#+\s*/, '').trim())
    .find((l) => l.length > 0)
  return sanitize(firstLine || `Source ${today}`)
}

function systemPrompt(rawPath: string, today: string): string {
  return [
    'You maintain the "ResMed Second Brain" markdown knowledge base in the current working directory.',
    `A new source has been added at "${rawPath}" — it may be meeting notes, a document, an email, an article, research, a spec, or any other material. Ingest it into the wiki:`,
    '1. Read the source carefully and infer what kind of material it is.',
    '2. Create or update the relevant curated pages under wiki/ResMed/ — Title Case filenames, one concept or entity per page.',
    `   Each page needs YAML frontmatter: type (concept|entity|overview|source-summary), topic: ResMed, sources: ["${rawPath}"], date-created, date-updated: ${today}, and tags.`,
    '   Link related pages with [[Page Name]] wikilinks that match filenames exactly.',
    '3. Update index.md: add any NEW pages to the catalog table (columns: Page | Type | Summary). Keep all existing rows.',
    `4. Append exactly one entry to log.md in the form "## [${today}] ingest | <subject>" with a one-line note.`,
    '5. Harvest links: if the raw note contains any URLs or [label](url) links (Google Drive, Slides/PowerPoint, Sheets/Excel, Docs, dashboards, etc.), add one row per NEW link to the table in resources.md.',
    '   The table columns are exactly: Title | Type | Link | Owner | Updated | Notes. Keep the header row and every existing row; append the new rows beneath them.',
    `   Put the bare URL in the Link column; infer Type as one of Drive, Presentation, Spreadsheet, Doc, Dashboard (otherwise "Link"); write a short human Title and a one-line Note from the surrounding context; set Owner to whoever shared it (else "TBD") and Updated to ${today}.`,
    '   Match on the URL and skip any link already in the table. If the note contains no links, leave resources.md unchanged.',
    'Prefer updating existing pages over creating near-duplicates. Never delete content. Keep edits consistent with the existing files.',
    'When finished, give a 2-3 sentence summary of what you created and updated.',
  ].join('\n')
}

/**
 * Save pasted notes as a raw source file, then let local Codex ingest it
 * into the wiki (creating/updating pages, the index, and the log), streaming
 * its progress back as BrainEvents.
 */
export async function ingest(
  title: string,
  content: string,
  onEvent: (e: BrainEvent) => void,
): Promise<{ rawPath: string }> {
  const today = new Date().toISOString().slice(0, 10)
  const name = title.trim() ? sanitize(title) : deriveName(content, today)
  const rawPath = `raw/${name}.md`
  const abs = path.join(CONTENT_DIR, 'raw', `${name}.md`)
  const fileBody = `---\ntype: source\ntitle: ${name}\ndate-added: ${today}\n---\n\n${content.trim()}\n`

  await fs.mkdir(path.dirname(abs), { recursive: true })
  await fs.writeFile(abs, fileBody, 'utf8')
  onEvent({ type: 'meta', rawPath })
  onEvent({ type: 'status', text: `Saved raw note → ${rawPath}` })

  const prompt = [
    systemPrompt(rawPath, today),
    '',
    `The raw source at "${rawPath}" is new. Ingest it now, following your instructions.`,
  ].join('\n')
  const { text } = await runCodex(prompt, { sandbox: 'workspace-write', onEvent })
  if (text) onEvent({ type: 'result', text })
  return { rawPath }
}
