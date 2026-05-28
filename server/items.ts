import { promises as fs } from 'node:fs'
import path from 'node:path'
import matter from 'gray-matter'
import { CONTENT_DIR } from './content'

function safe(rel: string): string {
  const clean = rel.replace(/\\/g, '/').replace(/^\/+/, '')
  const resolved = path.resolve(CONTENT_DIR, clean)
  if (resolved !== CONTENT_DIR && !resolved.startsWith(CONTENT_DIR + path.sep)) {
    throw new Error('Path escapes the content directory')
  }
  return resolved
}

/** A ticket or decision: a markdown file with structured frontmatter. */
export type Item = { path: string; title: string; body: string } & Record<string, unknown>

export async function listItems(folder: string): Promise<Item[]> {
  const abs = safe(folder)
  let files: string[]
  try {
    files = (await fs.readdir(abs)).filter((f) => f.toLowerCase().endsWith('.md'))
  } catch {
    return [] // folder doesn't exist yet
  }
  const items: Item[] = []
  for (const f of files) {
    const rel = `${folder}/${f}`
    const raw = await fs.readFile(safe(rel), 'utf8')
    const parsed = matter(raw)
    items.push({ path: rel, title: f.replace(/\.md$/i, ''), body: parsed.content, ...parsed.data })
  }
  return items
}

function sanitize(title: string): string {
  return (
    title
      .replace(/[<>:"/\\|?*\n\r]/g, ' ')
      .replace(/\s+/g, ' ')
      .trim()
      .slice(0, 120) || 'Untitled'
  )
}

export async function createItem(
  folder: string,
  title: string,
  data: Record<string, unknown>,
  body: string,
): Promise<Item> {
  const base = sanitize(title)
  let name = base
  let i = 2
  // avoid clobbering an existing file with the same title
  for (;;) {
    try {
      await fs.access(safe(`${folder}/${name}.md`))
      name = `${base} (${i++})`
    } catch {
      break
    }
  }
  const rel = `${folder}/${name}.md`
  const abs = safe(rel)
  const md = matter.stringify(`\n${body.trim()}\n`, data)
  await fs.mkdir(path.dirname(abs), { recursive: true })
  await fs.writeFile(abs, md, 'utf8')
  const parsed = matter(md)
  return { path: rel, title: name, body: parsed.content, ...parsed.data }
}

/** Merge frontmatter fields (e.g. change a ticket's status) and rewrite the file. */
export async function updateItem(rel: string, updates: Record<string, unknown>): Promise<Item> {
  const abs = safe(rel)
  const raw = await fs.readFile(abs, 'utf8')
  const parsed = matter(raw)
  const data = { ...parsed.data, ...updates }
  for (const [key, value] of Object.entries(data)) {
    if (value === null || value === undefined) delete data[key]
  }
  const md = matter.stringify(parsed.content, data)
  await fs.writeFile(abs, md, 'utf8')
  return {
    path: rel,
    title: path.basename(rel).replace(/\.md$/i, ''),
    body: parsed.content,
    ...data,
  }
}
