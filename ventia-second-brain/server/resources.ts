import { promises as fs } from 'node:fs'
import path from 'node:path'
import matter from 'gray-matter'
import { CONTENT_DIR } from './content'

/** The links registry, parsed from the GFM table in content/resources.md. */
export type ResourcesTable = {
  columns: string[]
  rows: string[][]
}

const FILE = 'resources.md'

// Split a GFM table row into trimmed cells, honouring escaped pipes (\|).
function splitRow(line: string): string[] {
  return line
    .trim()
    .replace(/^\|/, '')
    .replace(/\|$/, '')
    .split(/(?<!\\)\|/)
    .map((c) => c.trim().replace(/\\\|/g, '|'))
}

// A `|---|:--:|` style separator row — every cell is just dashes/colons.
const isSeparator = (cells: string[]) => cells.every((c) => /^:?-+:?$/.test(c))

/**
 * Parse the first GFM pipe-table out of content/resources.md into columns + rows.
 * Returns empty columns/rows if the file or table doesn't exist yet, so the page
 * can show a friendly empty state. Codex populates the table by editing
 * this markdown file (directly, or via Ask / Ingest).
 */
export async function readResources(): Promise<ResourcesTable> {
  let raw: string
  try {
    raw = await fs.readFile(path.join(CONTENT_DIR, FILE), 'utf8')
  } catch {
    return { columns: [], rows: [] }
  }
  const tableLines = matter(raw)
    .content.split('\n')
    .filter((l) => l.trim().startsWith('|'))
  if (tableLines.length < 2) return { columns: [], rows: [] }

  const columns = splitRow(tableLines[0])
  const rows = tableLines
    .slice(1)
    .map(splitRow)
    .filter((r) => !isSeparator(r) && r.some((c) => c !== ''))
  return { columns, rows }
}
