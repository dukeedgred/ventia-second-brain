import { promises as fs } from 'node:fs'
import path from 'node:path'
import { CONTENT_DIR, readNote } from './content'
import type { BrainEvent } from './brain'
import { runCodex } from './codex'

export type DocDef = {
  id: string
  title: string
  description: string
  outline: string[]
}

/** The catalog of living documents the team can synthesise from the knowledge base. */
export const DOCS: DocDef[] = [
  {
    id: 'architecture',
    title: 'Solution Architecture',
    description:
      'High-level design of the spend-cube solution — sources, pipeline, classification, the cube, and outputs.',
    outline: [
      'Overview — what the solution does and for whom, in a few sentences.',
      'Data Sources — the source systems and the data they provide.',
      'Data Flow / Pipeline — how data moves from source through to the cube.',
      'Classification Approach — how spend is categorised (rules, branches, edge cases).',
      'Cube / Data Model — the dimensions, measures, and grain of the spend cube.',
      'Outputs — dashboards, reports, and deliverables produced.',
      'Open Questions & Risks — what is undecided or at risk.',
    ],
  },
  {
    id: 'data-model',
    title: 'Data Model',
    description: 'The entities, fields, relationships, and the cube’s dimensions & measures.',
    outline: [
      'Entities — the core objects and what each represents.',
      'Fields — the key attributes per entity.',
      'Relationships — how the entities relate to one another.',
      'Cube Dimensions & Measures — what you can slice by, and what is measured.',
    ],
  },
  {
    id: 'glossary',
    title: 'Glossary',
    description: 'Key terms, acronyms, and definitions used across the engagement.',
    outline: [
      'An alphabetical list of the terms and acronyms used across the engagement, each with a one- to two-sentence definition grounded in how the team actually uses it.',
    ],
  },
]

function docRelPath(def: DocDef): string {
  return `docs/${def.title}.md`
}

/** If the model wrapped the whole document in a ``` fence, peel it off. */
function stripFences(s: string): string {
  const t = s.trim()
  if (t.startsWith('```')) {
    return t
      .replace(/^```[a-zA-Z]*\n?/, '')
      .replace(/\n?```$/, '')
      .trim()
  }
  return t
}

function systemPrompt(def: DocDef): string {
  return [
    `You are generating a curated documentation page — the "${def.title}" — for the "Ventia Second Brain" knowledge base in the current working directory.`,
    'Work ONLY from the markdown knowledge base. Find what you need efficiently:',
    'read index.md first (the map), then open only the few pages relevant to this document; use Grep/Glob only if the index does not lead you to them.',
    '',
    `Produce a single, well-structured markdown document with these sections:`,
    ...def.outline.map((s, i) => `${i + 1}. ${s}`),
    '',
    'Rules:',
    '- Cite the source pages you draw from as [[wikilinks]] (inline where natural, and/or a short "Sources" line).',
    '- Where the knowledge base lacks the information for a section, write "_Not yet documented._" rather than inventing facts.',
    '- Use "##" for section headings. Do NOT include an H1 title or YAML frontmatter — those are added for you.',
    '- Write concisely, for a junior team member.',
    '- Output ONLY the markdown document body — no preamble, no surrounding code fences.',
  ].join('\n')
}

export type DocStatus = {
  id: string
  title: string
  description: string
  path: string
  exists: boolean
  updated?: string
}

/** List the doc catalog with whether each has been generated and when. */
export async function listDocs(): Promise<DocStatus[]> {
  const out: DocStatus[] = []
  for (const def of DOCS) {
    const rel = docRelPath(def)
    let updated: string | undefined
    try {
      const note = await readNote(rel)
      const u = note.frontmatter['date-updated']
      if (typeof u === 'string') updated = u.slice(0, 10)
      out.push({ id: def.id, title: def.title, description: def.description, path: rel, exists: true, updated })
    } catch {
      out.push({ id: def.id, title: def.title, description: def.description, path: rel, exists: false })
    }
  }
  return out
}

/**
 * Generate (or regenerate) a living document by id: run local Codex
 * READ-ONLY over the knowledge base, stream its output, then write the result
 * to content/docs/<Title>.md with frontmatter. The AI never writes files — the
 * server persists the result, keeping the read-only seam intact.
 */
export async function generateDoc(
  id: string,
  onEvent: (e: BrainEvent) => void,
): Promise<{ path: string; written: boolean }> {
  const def = DOCS.find((d) => d.id === id)
  if (!def) {
    onEvent({ type: 'error', text: `Unknown document "${id}".` })
    return { path: '', written: false }
  }
  const rel = docRelPath(def)
  const today = new Date().toISOString().slice(0, 10)

  // Preserve the original creation date when regenerating.
  let created = today
  try {
    const existing = await readNote(rel)
    const c = existing.frontmatter['date-created']
    if (typeof c === 'string' && c) created = c.slice(0, 10)
  } catch {
    /* first generation */
  }

  const prompt = [
    systemPrompt(def),
    '',
    `Generate the "${def.title}" document now, following your instructions.`,
  ].join('\n')
  const { text: body } = await runCodex(prompt, { sandbox: 'read-only', onEvent })
  if (body) onEvent({ type: 'result', text: body })

  if (!body) {
    onEvent({ type: 'error', text: 'No document was produced.' })
    return { path: rel, written: false }
  }

  const fm = `---\ntype: doc\ngenerated: true\ndate-created: ${created}\ndate-updated: ${today}\ntags: [doc]\n---\n\n`
  const abs = path.join(CONTENT_DIR, 'docs', `${def.title}.md`)
  await fs.mkdir(path.dirname(abs), { recursive: true })
  await fs.writeFile(abs, fm + stripFences(body) + '\n', 'utf8')
  onEvent({ type: 'status', text: `Saved ${rel}` })
  return { path: rel, written: true }
}
