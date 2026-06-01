import type {
  TreeNode,
  NoteListItem,
  Note,
  GraphData,
  SearchResult,
  BrainEvent,
  Ticket,
  Decision,
  ResourcesTable,
  SyncStatus,
  AskTurn,
  DocStatus,
} from './types'

async function json<T>(url: string, init?: RequestInit): Promise<T> {
  const res = await fetch(url, init)
  if (!res.ok) {
    const body = (await res.json().catch(() => ({}))) as { error?: string }
    throw new Error(body.error || `${res.status} ${res.statusText}`)
  }
  return (await res.json()) as T
}

export const api = {
  tree: () => json<TreeNode[]>('/api/tree'),
  notes: () => json<NoteListItem[]>('/api/notes'),
  note: (path: string) => json<Note>(`/api/note?path=${encodeURIComponent(path)}`),
  saveNote: (path: string, raw: string) =>
    json<Note>('/api/note', {
      method: 'PUT',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ path, raw }),
    }),
  createNote: (path: string, raw: string) =>
    json<Note>('/api/note', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ path, raw }),
    }),
  deleteNote: (path: string) =>
    json<{ ok: boolean }>(`/api/note?path=${encodeURIComponent(path)}`, {
      method: 'DELETE',
    }),
  graph: () => json<GraphData>('/api/graph'),
  search: (q: string) => json<SearchResult[]>(`/api/search?q=${encodeURIComponent(q)}`),
  resources: () => json<ResourcesTable>('/api/resources'),
  tickets: () => json<Ticket[]>('/api/tickets'),
  decisions: () => json<Decision[]>('/api/decisions'),
  createTicket: (t: Record<string, unknown>) =>
    json<Ticket>('/api/tickets', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(t),
    }),
  createDecision: (d: Record<string, unknown>) =>
    json<Decision>('/api/decisions', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(d),
    }),
  updateItem: (path: string, updates: Record<string, unknown>) =>
    json<Ticket>('/api/item', {
      method: 'PATCH',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ path, updates }),
    }),
  extract: (path: string, kind: 'tickets' | 'decisions') =>
    json<{ items: unknown[] }>('/api/extract', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ path, kind }),
    }),
  extractTodos: (paths: string[]) =>
    json<{ items: unknown[] }>('/api/extract-todos', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ paths }),
    }),
  extractFile: (name: string, data: string) =>
    json<{ text: string; warnings: string[] }>('/api/extract-file', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ name, data }),
    }),
  sync: () => json<SyncStatus>('/api/sync'),
  syncNow: () => json<SyncStatus>('/api/sync', { method: 'POST' }),
  docs: () => json<DocStatus[]>('/api/docs'),
}

/**
 * Stream an answer from the "brain". Parses the SSE-style response from
 * POST /api/ask and calls onEvent for each event as it arrives.
 */
/** Shared reader for our SSE-style POST endpoints (/api/ask, /api/ingest). */
async function streamSSE(
  url: string,
  body: unknown,
  onEvent: (e: BrainEvent) => void,
  signal?: AbortSignal,
): Promise<void> {
  const res = await fetch(url, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(body),
    signal,
  })
  if (!res.ok || !res.body) {
    const err = (await res.json().catch(() => ({}))) as { error?: string }
    throw new Error(err.error || `Request failed: ${res.status}`)
  }
  const reader = res.body.getReader()
  const decoder = new TextDecoder()
  let buf = ''
  for (;;) {
    const { done, value } = await reader.read()
    if (done) break
    buf += decoder.decode(value, { stream: true })
    let idx: number
    while ((idx = buf.indexOf('\n\n')) >= 0) {
      const chunk = buf.slice(0, idx)
      buf = buf.slice(idx + 2)
      let data = ''
      for (const line of chunk.split('\n')) {
        if (line.startsWith('data:')) data += line.slice(5).trimStart()
      }
      if (!data) continue
      try {
        onEvent(JSON.parse(data) as BrainEvent)
      } catch {
        /* ignore malformed event */
      }
    }
  }
}

export function askBrain(
  question: string,
  history: AskTurn[],
  onEvent: (e: BrainEvent) => void,
  signal?: AbortSignal,
): Promise<void> {
  return streamSSE('/api/ask', { question, history }, onEvent, signal)
}

export function ingestNotes(
  title: string,
  content: string,
  onEvent: (e: BrainEvent) => void,
  signal?: AbortSignal,
): Promise<void> {
  return streamSSE('/api/ingest', { title, content }, onEvent, signal)
}

export function lintRun(
  mode: 'audit' | 'fix',
  onEvent: (e: BrainEvent) => void,
  signal?: AbortSignal,
): Promise<void> {
  return streamSSE('/api/lint', { mode }, onEvent, signal)
}

export function generateDoc(
  id: string,
  onEvent: (e: BrainEvent) => void,
  signal?: AbortSignal,
): Promise<void> {
  return streamSSE('/api/docs/generate', { id }, onEvent, signal)
}
