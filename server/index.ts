import express from 'express'
import cors from 'cors'
import {
  CONTENT_DIR,
  buildTree,
  listAllNotes,
  readNote,
  writeNote,
  deleteNote,
} from './content'
import { buildGraph } from './graph'
import { search } from './search'
import { askBrainCli } from './brain'
import type { BrainEvent } from './brain'
import { listItems, createItem, updateItem } from './items'
import { extractFromNote, extractTodosFromNotes } from './extract'
import { ingest } from './ingest'
import { lint } from './lint'
import { readResources } from './resources'
import { commitContent, syncPullNow, forceSync, getSyncStatus, initSync } from './git'
import { listDocs, generateDoc } from './docs'

const app = express()
app.use(cors())
app.use(express.json({ limit: '4mb' }))

const PORT = Number(process.env.PORT) || 8787

app.get('/api/health', (_req, res) => {
  res.json({ ok: true, contentDir: CONTENT_DIR })
})

app.get('/api/tree', async (_req, res) => {
  try {
    res.json(await buildTree())
  } catch (e) {
    res.status(500).json({ error: (e as Error).message })
  }
})

app.get('/api/notes', async (_req, res) => {
  try {
    const notes = await listAllNotes()
    res.json(
      notes.map((n) => ({
        path: n.path,
        name: n.name,
        type: n.frontmatter?.type ?? null,
        topic: n.frontmatter?.topic ?? null,
        modified: n.modified,
      })),
    )
  } catch (e) {
    res.status(500).json({ error: (e as Error).message })
  }
})

app.get('/api/note', async (req, res) => {
  try {
    res.json(await readNote(String(req.query.path || '')))
  } catch (e) {
    res.status(404).json({ error: (e as Error).message })
  }
})

app.put('/api/note', async (req, res) => {
  try {
    const { path: p, raw } = req.body as { path?: string; raw?: string }
    if (!p) throw new Error('path required')
    await writeNote(p, raw ?? '')
    await commitContent(`note: update ${p}`)
    res.json(await readNote(p))
  } catch (e) {
    res.status(400).json({ error: (e as Error).message })
  }
})

app.post('/api/note', async (req, res) => {
  try {
    const { path: p, raw } = req.body as { path?: string; raw?: string }
    if (!p) throw new Error('path required')
    await writeNote(p, raw ?? '')
    await commitContent(`note: create ${p}`)
    res.json(await readNote(p))
  } catch (e) {
    res.status(400).json({ error: (e as Error).message })
  }
})

app.delete('/api/note', async (req, res) => {
  try {
    const p = String(req.query.path || '')
    await deleteNote(p)
    await commitContent(`note: delete ${p}`)
    res.json({ ok: true })
  } catch (e) {
    res.status(400).json({ error: (e as Error).message })
  }
})

app.get('/api/graph', async (_req, res) => {
  try {
    res.json(await buildGraph())
  } catch (e) {
    res.status(500).json({ error: (e as Error).message })
  }
})

app.get('/api/search', async (req, res) => {
  try {
    res.json(await search(String(req.query.q || '')))
  } catch (e) {
    res.status(500).json({ error: (e as Error).message })
  }
})

// Links registry — parsed from the GFM table in content/resources.md.
app.get('/api/resources', async (_req, res) => {
  try {
    res.json(await readResources())
  } catch (e) {
    res.status(500).json({ error: (e as Error).message })
  }
})

// ---- Tickets & Decisions (markdown-backed) ----

app.get('/api/tickets', async (_req, res) => {
  try {
    res.json(await listItems('tickets'))
  } catch (e) {
    res.status(500).json({ error: (e as Error).message })
  }
})

app.get('/api/decisions', async (_req, res) => {
  try {
    res.json(await listItems('decisions'))
  } catch (e) {
    res.status(500).json({ error: (e as Error).message })
  }
})

app.post('/api/tickets', async (req, res) => {
  try {
    const b = req.body as Record<string, unknown>
    const today = new Date().toISOString().slice(0, 10)
    const data = {
      type: 'ticket',
      status: (b.status as string) || 'todo',
      priority: (b.priority as string) || 'medium',
      assignee: (b.assignee as string) || 'Unassigned',
      sources: Array.isArray(b.sources) ? b.sources : [],
      'date-created': today,
    }
    const item = await createItem('tickets', String(b.title || 'Untitled'), data, String(b.description || ''))
    await commitContent(`ticket: add ${item.title}`)
    res.json(item)
  } catch (e) {
    res.status(400).json({ error: (e as Error).message })
  }
})

app.post('/api/decisions', async (req, res) => {
  try {
    const b = req.body as Record<string, unknown>
    const today = new Date().toISOString().slice(0, 10)
    const data = {
      type: 'decision',
      status: (b.status as string) || 'accepted',
      date: today,
      deciders: Array.isArray(b.deciders) ? b.deciders : [],
      sources: Array.isArray(b.sources) ? b.sources : [],
    }
    const body =
      typeof b.body === 'string' && b.body.trim()
        ? b.body
        : `## Context\n${b.context || ''}\n\n## Decision\n${b.decision || ''}\n\n## Consequences\n${b.consequences || ''}\n`
    const item = await createItem('decisions', String(b.title || 'Untitled'), data, body)
    await commitContent(`decision: add ${item.title}`)
    res.json(item)
  } catch (e) {
    res.status(400).json({ error: (e as Error).message })
  }
})

app.patch('/api/item', async (req, res) => {
  try {
    const b = req.body as { path?: string; updates?: Record<string, unknown> }
    if (!b.path) throw new Error('path required')
    const item = await updateItem(b.path, b.updates || {})
    await commitContent(`item: update ${b.path}`)
    res.json(item)
  } catch (e) {
    res.status(400).json({ error: (e as Error).message })
  }
})

app.post('/api/extract', async (req, res) => {
  try {
    const b = req.body as { path?: string; kind?: string }
    if (!b.path) throw new Error('path required')
    const kind = b.kind === 'decisions' ? 'decisions' : 'tickets'
    res.json(await extractFromNote(b.path, kind))
  } catch (e) {
    res.status(500).json({ error: (e as Error).message })
  }
})

app.post('/api/extract-todos', async (req, res) => {
  try {
    const paths = (req.body as { paths?: unknown[] })?.paths
    if (!Array.isArray(paths)) throw new Error('paths required')
    res.json(await extractTodosFromNotes(paths.map((p) => String(p))))
  } catch (e) {
    res.status(500).json({ error: (e as Error).message })
  }
})

app.post('/api/ask', async (req, res) => {
  const body = req.body as {
    question?: string
    history?: { role?: string; content?: string }[]
  }
  const question = String(body?.question || '').trim()
  const history = Array.isArray(body?.history)
    ? body.history
        .filter(
          (h): h is { role: 'user' | 'assistant'; content: string } =>
            !!h && (h.role === 'user' || h.role === 'assistant') && typeof h.content === 'string',
        )
        .map((h) => ({ role: h.role, content: h.content }))
    : []
  if (!question) {
    res.status(400).json({ error: 'question required' })
    return
  }

  res.setHeader('Content-Type', 'text/event-stream')
  res.setHeader('Cache-Control', 'no-cache, no-transform')
  res.setHeader('Connection', 'keep-alive')
  res.flushHeaders?.()

  const send = (e: BrainEvent) => res.write(`data: ${JSON.stringify(e)}\n\n`)

  // Pull the latest from the team before the brain reads the knowledge base.
  if (getSyncStatus().enabled) send({ type: 'status', text: 'Syncing latest from the team…' })
  await syncPullNow().catch(() => {})

  const provider = process.env.BRAIN_PROVIDER || 'cli'
  try {
    if (provider === 'cli') {
      await askBrainCli(question, history, send)
    } else {
      send({
        type: 'error',
        text: `Brain provider "${provider}" is not wired yet. Set BRAIN_PROVIDER=cli to use local Codex.`,
      })
    }
  } catch (e) {
    send({ type: 'error', text: (e as Error).message })
  }

  send({ type: 'done' })
  res.end()
})

app.post('/api/ingest', async (req, res) => {
  const { title, content } = req.body as { title?: string; content?: string }
  if (!content || !content.trim()) {
    res.status(400).json({ error: 'content required' })
    return
  }
  res.setHeader('Content-Type', 'text/event-stream')
  res.setHeader('Cache-Control', 'no-cache, no-transform')
  res.setHeader('Connection', 'keep-alive')
  res.flushHeaders?.()
  const send = (e: BrainEvent) => res.write(`data: ${JSON.stringify(e)}\n\n`)
  if (getSyncStatus().enabled) send({ type: 'status', text: 'Syncing latest from the team…' })
  await syncPullNow().catch(() => {})
  try {
    const { rawPath } = await ingest(String(title || ''), String(content), send)
    const subject = String(title || '').trim() || rawPath.replace(/^raw\//, '').replace(/\.md$/i, '')
    const c = await commitContent(`ingest: ${subject}`)
    if (c.committed) send({ type: 'status', text: `Committed ${c.hash}` })
  } catch (e) {
    send({ type: 'error', text: (e as Error).message })
  }
  send({ type: 'done' })
  res.end()
})

app.post('/api/lint', async (req, res) => {
  const mode = (req.body as { mode?: string })?.mode === 'fix' ? 'fix' : 'audit'
  res.setHeader('Content-Type', 'text/event-stream')
  res.setHeader('Cache-Control', 'no-cache, no-transform')
  res.setHeader('Connection', 'keep-alive')
  res.flushHeaders?.()
  const send = (e: BrainEvent) => res.write(`data: ${JSON.stringify(e)}\n\n`)
  if (getSyncStatus().enabled) send({ type: 'status', text: 'Syncing latest from the team…' })
  await syncPullNow().catch(() => {})
  try {
    await lint(mode, send)
    if (mode === 'fix') {
      const c = await commitContent('lint: clean up knowledge base')
      if (c.committed) send({ type: 'status', text: `Committed ${c.hash}` })
    }
  } catch (e) {
    send({ type: 'error', text: (e as Error).message })
  }
  send({ type: 'done' })
  res.end()
})

// ---- Git sync status / manual trigger ----

app.get('/api/sync', (_req, res) => {
  res.json(getSyncStatus())
})

app.post('/api/sync', async (_req, res) => {
  try {
    res.json(await forceSync())
  } catch (e) {
    res.status(500).json({ error: (e as Error).message })
  }
})

// ---- Docs hub (AI-synthesized living documents) ----

app.get('/api/docs', async (_req, res) => {
  try {
    res.json(await listDocs())
  } catch (e) {
    res.status(500).json({ error: (e as Error).message })
  }
})

app.post('/api/docs/generate', async (req, res) => {
  const id = String((req.body as { id?: string })?.id || '').trim()
  if (!id) {
    res.status(400).json({ error: 'id required' })
    return
  }
  res.setHeader('Content-Type', 'text/event-stream')
  res.setHeader('Cache-Control', 'no-cache, no-transform')
  res.setHeader('Connection', 'keep-alive')
  res.flushHeaders?.()
  const send = (e: BrainEvent) => res.write(`data: ${JSON.stringify(e)}\n\n`)
  if (getSyncStatus().enabled) send({ type: 'status', text: 'Syncing latest from the team…' })
  await syncPullNow().catch(() => {})
  try {
    const { written, path: p } = await generateDoc(id, send)
    if (written) {
      const c = await commitContent(`docs: ${p.replace(/^docs\//, '').replace(/\.md$/i, '')}`)
      if (c.committed) send({ type: 'status', text: `Committed ${c.hash}` })
    }
  } catch (e) {
    send({ type: 'error', text: (e as Error).message })
  }
  send({ type: 'done' })
  res.end()
})

app.listen(PORT, () => {
  console.log(`[second-brain] API listening on http://localhost:${PORT}`)
  console.log(`[second-brain] content dir: ${CONTENT_DIR}`)
  void initSync()
})
