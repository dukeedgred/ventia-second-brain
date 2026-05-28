import {
  createContext,
  useCallback,
  useContext,
  useEffect,
  useRef,
  useState,
} from 'react'
import type { ReactNode } from 'react'
import type { BrainEvent, GraphData, GraphNode } from '../types'
import { api, ingestNotes } from '../api'
import { useNotes } from './notes'

const VERB: Record<string, string> = {
  Write: 'Creating',
  Edit: 'Updating',
  MultiEdit: 'Updating',
  Read: 'Reading',
  Grep: 'Searching',
  Glob: 'Scanning',
  LS: 'Listing',
}

function toolLabel(tool: string, detail?: string) {
  const v = VERB[tool] ?? tool
  return detail ? `${v} ${detail}` : v
}

export type IngestStep = { tool?: string; text: string }

type IngestContextValue = {
  title: string
  setTitle: (s: string) => void
  content: string
  setContent: (s: string) => void
  running: boolean
  steps: IngestStep[]
  summary: string
  error: string
  rawPath: string
  done: boolean
  graph: GraphData | null
  newIds: Set<string>
  start: () => void
  stop: () => void
}

const IngestContext = createContext<IngestContextValue | null>(null)

/**
 * Holds ingest state ABOVE the router so an in-flight (or finished) ingest
 * survives tab switches, and keeps a live graph that refreshes while it runs.
 */
export function IngestProvider({ children }: { children: ReactNode }) {
  const notes = useNotes()
  const [title, setTitle] = useState('')
  const [content, setContent] = useState('')
  const [running, setRunning] = useState(false)
  const [steps, setSteps] = useState<IngestStep[]>([])
  const [summary, setSummary] = useState('')
  const [error, setError] = useState('')
  const [rawPath, setRawPath] = useState('')
  const [done, setDone] = useState(false)
  const [graph, setGraph] = useState<GraphData | null>(null)
  const [newIds, setNewIds] = useState<Set<string>>(new Set())

  const baselineRef = useRef<Set<string>>(new Set())
  const initializedRef = useRef(false)
  const sigRef = useRef<string>('')
  // Reuse node objects across refetches so force-graph keeps their positions
  // (only new nodes animate in).
  const cacheRef = useRef<Map<string, GraphNode>>(new Map())
  const pollRef = useRef<number | undefined>(undefined)
  const abortRef = useRef<AbortController | null>(null)

  const refetchGraph = useCallback(async () => {
    try {
      const g = await api.graph()
      // Skip the update if nothing changed. Otherwise every 2s poll hands the
      // force graph a fresh object, which reheats the simulation and makes it
      // "shake". We only re-render — and thus animate — when a node or link
      // actually changes (i.e. a new note got ingested).
      const sig =
        g.nodes
          .map((n) => n.id)
          .sort()
          .join('|') +
        '::' +
        g.links
          .map((l) => `${String(l.source)}>${String(l.target)}`)
          .sort()
          .join('|')
      if (sig === sigRef.current) return
      sigRef.current = sig

      const cache = cacheRef.current
      const nodes = g.nodes.map((n) => {
        const existing = cache.get(n.id)
        if (existing) {
          existing.name = n.name
          existing.type = n.type
          existing.group = n.group
          return existing
        }
        cache.set(n.id, n)
        return n
      })
      for (const id of Array.from(cache.keys())) {
        if (!g.nodes.some((n) => n.id === id)) cache.delete(id)
      }
      // First load establishes the baseline so nothing is falsely "new".
      if (!initializedRef.current) {
        baselineRef.current = new Set(g.nodes.map((n) => n.id))
        initializedRef.current = true
      }
      setGraph({ nodes, links: g.links })
      setNewIds(new Set(g.nodes.filter((n) => !baselineRef.current.has(n.id)).map((n) => n.id)))
    } catch {
      /* ignore transient fetch errors during restarts */
    }
  }, [])

  useEffect(() => {
    refetchGraph()
  }, [refetchGraph])

  const start = useCallback(async () => {
    if (running || !content.trim()) return
    setRunning(true)
    setSteps([])
    setSummary('')
    setError('')
    setRawPath('')
    setDone(false)
    setNewIds(new Set())

    try {
      const g = await api.graph()
      baselineRef.current = new Set(g.nodes.map((n) => n.id))
    } catch {
      baselineRef.current = new Set()
    }
    await refetchGraph()
    pollRef.current = window.setInterval(refetchGraph, 2000)

    const ctrl = new AbortController()
    abortRef.current = ctrl
    try {
      await ingestNotes(
        title,
        content,
        (e: BrainEvent) => {
          if (e.type === 'tool') setSteps((s) => [...s, { tool: e.tool, text: toolLabel(e.tool, e.detail) }])
          else if (e.type === 'status') {
            if (!e.text.startsWith('__')) setSteps((s) => [...s, { text: e.text }])
          } else if (e.type === 'meta') setRawPath(e.rawPath)
          else if (e.type === 'delta') setSummary((x) => x + e.text)
          else if (e.type === 'result') setSummary((x) => e.text || x)
          else if (e.type === 'error') setError(e.text)
          else if (e.type === 'done') setDone(true)
        },
        ctrl.signal,
      )
    } catch (err) {
      setError((err as Error).message)
    } finally {
      if (pollRef.current) window.clearInterval(pollRef.current)
      await refetchGraph()
      setRunning(false)
      abortRef.current = null
      notes.refresh()
    }
  }, [running, content, title, refetchGraph, notes])

  const stop = useCallback(() => {
    abortRef.current?.abort()
    if (pollRef.current) window.clearInterval(pollRef.current)
    setRunning(false)
  }, [])

  return (
    <IngestContext.Provider
      value={{
        title,
        setTitle,
        content,
        setContent,
        running,
        steps,
        summary,
        error,
        rawPath,
        done,
        graph,
        newIds,
        start,
        stop,
      }}
    >
      {children}
    </IngestContext.Provider>
  )
}

// eslint-disable-next-line react-refresh/only-export-components
export function useIngest() {
  const ctx = useContext(IngestContext)
  if (!ctx) throw new Error('useIngest must be used within IngestProvider')
  return ctx
}
