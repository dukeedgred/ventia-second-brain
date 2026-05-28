import { listAllNotes, readNote } from './content'

// [[Target]] or [[Target|alias]] or [[Target#heading]]
const WIKILINK = /\[\[([^\]|#]+)(?:[#|][^\]]*)?\]\]/g

function topFolder(p: string): string {
  const parts = p.split('/')
  return parts.length > 1 ? parts[0] : 'root'
}

export async function buildGraph() {
  // resources.md is a links registry, not a knowledge note — it has no
  // [[wikilinks]], so it would float off as an orphan and wreck zoomToFit.
  const notes = (await listAllNotes()).filter((n) => n.path !== 'resources.md')

  const byName = new Map<string, string>()
  const paths = new Set<string>()
  for (const n of notes) {
    byName.set(n.name.toLowerCase(), n.path)
    paths.add(n.path)
  }

  const nodes = notes.map((n) => ({
    id: n.path,
    name: n.name,
    type: (n.frontmatter.type as string) ?? 'note',
    group: (n.frontmatter.topic as string) ?? topFolder(n.path),
  }))

  const links: { source: string; target: string }[] = []
  for (const n of notes) {
    const note = await readNote(n.path)
    const seen = new Set<string>()
    let m: RegExpExecArray | null
    WIKILINK.lastIndex = 0
    while ((m = WIKILINK.exec(note.raw)) !== null) {
      const targetPath = byName.get(m[1].trim().toLowerCase())
      if (targetPath && targetPath !== n.path && !seen.has(targetPath)) {
        seen.add(targetPath)
        links.push({ source: n.path, target: targetPath })
      }
    }
    // Provenance edges: a page → the raw source(s) it was built from.
    const srcs = n.frontmatter.sources
    if (Array.isArray(srcs)) {
      for (const s of srcs) {
        if (typeof s !== 'string') continue
        const sp = s.replace(/\\/g, '/').replace(/^\/+/, '')
        if (paths.has(sp) && sp !== n.path && !seen.has(sp)) {
          seen.add(sp)
          links.push({ source: n.path, target: sp })
        }
      }
    }
  }

  return { nodes, links }
}
