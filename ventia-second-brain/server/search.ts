import { listAllNotes, readNote } from './content'

export type SearchResult = {
  path: string
  name: string
  snippet: string
  titleMatch: boolean
}

export async function search(q: string): Promise<SearchResult[]> {
  const query = q.trim().toLowerCase()
  if (!query) return []

  const notes = await listAllNotes()
  const results: SearchResult[] = []

  for (const n of notes) {
    const note = await readNote(n.path)
    const titleMatch = n.name.toLowerCase().includes(query)
    const bodyIdx = note.content.toLowerCase().indexOf(query)
    if (!titleMatch && bodyIdx < 0) continue

    let snippet: string
    if (bodyIdx >= 0) {
      const start = Math.max(0, bodyIdx - 50)
      const slice = note.content.slice(start, bodyIdx + 90).replace(/\s+/g, ' ').trim()
      snippet = `${start > 0 ? '…' : ''}${slice}…`
    } else {
      snippet = `${note.content.replace(/\s+/g, ' ').trim().slice(0, 120)}…`
    }

    results.push({ path: n.path, name: n.name, snippet, titleMatch })
  }

  results.sort(
    (a, b) => Number(b.titleMatch) - Number(a.titleMatch) || a.name.localeCompare(b.name),
  )
  return results.slice(0, 30)
}
