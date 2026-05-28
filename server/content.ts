import { promises as fs } from 'node:fs'
import path from 'node:path'
import matter from 'gray-matter'

export const CONTENT_DIR = path.resolve(
  process.env.CONTENT_DIR || path.join(process.cwd(), 'content'),
)

/** Resolve a request-relative path, refusing anything that escapes CONTENT_DIR. */
function safeResolve(relPath: string): string {
  const clean = relPath.replace(/\\/g, '/').replace(/^\/+/, '')
  const resolved = path.resolve(CONTENT_DIR, clean)
  if (resolved !== CONTENT_DIR && !resolved.startsWith(CONTENT_DIR + path.sep)) {
    throw new Error('Path escapes the content directory')
  }
  return resolved
}

const IGNORE = new Set(['node_modules', '.git', '.obsidian', '.DS_Store', 'CLAUDE.md'])

export type TreeNode = {
  name: string
  path: string
  type: 'dir' | 'file'
  children?: TreeNode[]
}

export async function buildTree(rel = ''): Promise<TreeNode[]> {
  const abs = safeResolve(rel || '.')
  const entries = await fs.readdir(abs, { withFileTypes: true })
  const nodes: TreeNode[] = []
  for (const e of entries) {
    if (IGNORE.has(e.name) || e.name.startsWith('.')) continue
    const childRel = rel ? `${rel}/${e.name}` : e.name
    if (e.isDirectory()) {
      nodes.push({
        name: e.name,
        path: childRel,
        type: 'dir',
        children: await buildTree(childRel),
      })
    } else if (e.isFile() && e.name.toLowerCase().endsWith('.md')) {
      nodes.push({ name: e.name.replace(/\.md$/i, ''), path: childRel, type: 'file' })
    }
  }
  nodes.sort((a, b) =>
    a.type !== b.type ? (a.type === 'dir' ? -1 : 1) : a.name.localeCompare(b.name),
  )
  return nodes
}

export type NoteMeta = {
  path: string
  name: string
  frontmatter: Record<string, unknown>
}

export async function listAllNotes(): Promise<NoteMeta[]> {
  const out: NoteMeta[] = []
  async function walk(rel: string) {
    const abs = safeResolve(rel || '.')
    const entries = await fs.readdir(abs, { withFileTypes: true })
    for (const e of entries) {
      if (IGNORE.has(e.name) || e.name.startsWith('.')) continue
      const childRel = rel ? `${rel}/${e.name}` : e.name
      if (e.isDirectory()) {
        await walk(childRel)
      } else if (e.isFile() && e.name.toLowerCase().endsWith('.md')) {
        const raw = await fs.readFile(safeResolve(childRel), 'utf8')
        const stat = await fs.stat(safeResolve(childRel))
        const parsed = matter(raw)
        out.push({
          path: childRel,
          name: e.name.replace(/\.md$/i, ''),
          frontmatter: parsed.data,
          modified: stat.mtimeMs,
        })
      }
    }
  }
  await walk('')
  return out
}

export async function readNote(relPath: string) {
  const raw = await fs.readFile(safeResolve(relPath), 'utf8')
  const parsed = matter(raw)
  return {
    path: relPath.replace(/\\/g, '/'),
    name: path.basename(relPath).replace(/\.md$/i, ''),
    frontmatter: parsed.data as Record<string, unknown>,
    content: parsed.content,
    raw,
  }
}

export async function writeNote(relPath: string, raw: string) {
  const abs = safeResolve(relPath)
  await fs.mkdir(path.dirname(abs), { recursive: true })
  await fs.writeFile(abs, raw, 'utf8')
}

export async function deleteNote(relPath: string) {
  await fs.unlink(safeResolve(relPath))
}
