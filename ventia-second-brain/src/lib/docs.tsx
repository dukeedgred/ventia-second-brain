import { createContext, useCallback, useContext, useEffect, useRef, useState } from 'react'
import type { ReactNode } from 'react'
import type { BrainEvent, DocStatus } from '../types'
import { api, generateDoc as apiGenerateDoc } from '../api'
import { useNotes } from './notes'

const VERB: Record<string, string> = { Read: 'Reading', Grep: 'Searching', Glob: 'Scanning' }
function toolLabel(tool: string, detail?: string) {
  const v = VERB[tool] ?? tool
  return detail ? `${v} ${detail}` : v
}

type DocsContextValue = {
  docs: DocStatus[]
  refresh: () => void
  activeId: string | null
  running: boolean
  steps: string[]
  body: string
  error: string
  done: boolean
  generate: (id: string) => void
  stop: () => void
}

const DocsContext = createContext<DocsContextValue | null>(null)

/**
 * Holds Docs state ABOVE the router so a synthesis run keeps streaming (and the
 * result stays) when you switch tabs, mirroring the Ask/Ingest providers.
 */
export function DocsProvider({ children }: { children: ReactNode }) {
  const notes = useNotes()
  const [docs, setDocs] = useState<DocStatus[]>([])
  const [activeId, setActiveId] = useState<string | null>(null)
  const [running, setRunning] = useState(false)
  const [steps, setSteps] = useState<string[]>([])
  const [body, setBody] = useState('')
  const [error, setError] = useState('')
  const [done, setDone] = useState(false)
  const abortRef = useRef<AbortController | null>(null)

  const refresh = useCallback(() => {
    api.docs().then(setDocs).catch(() => {})
  }, [])
  useEffect(() => {
    refresh()
  }, [refresh])

  const generate = useCallback(
    async (id: string) => {
      if (abortRef.current) return
      setActiveId(id)
      setRunning(true)
      setSteps([])
      setBody('')
      setError('')
      setDone(false)
      const ctrl = new AbortController()
      abortRef.current = ctrl
      try {
        await apiGenerateDoc(
          id,
          (e: BrainEvent) => {
            if (e.type === 'delta') setBody((b) => b + e.text)
            else if (e.type === 'result') setBody((b) => e.text || b)
            else if (e.type === 'tool') setSteps((s) => [...s, toolLabel(e.tool, e.detail)])
            else if (e.type === 'status') setSteps((s) => [...s, e.text])
            else if (e.type === 'error') setError(e.text)
            else if (e.type === 'done') setDone(true)
          },
          ctrl.signal,
        )
      } catch (err) {
        setError((err as Error).message)
      } finally {
        setRunning(false)
        abortRef.current = null
        refresh()
        notes.refresh()
      }
    },
    [refresh, notes],
  )

  const stop = useCallback(() => {
    abortRef.current?.abort()
    abortRef.current = null
    setRunning(false)
  }, [])

  return (
    <DocsContext.Provider
      value={{ docs, refresh, activeId, running, steps, body, error, done, generate, stop }}
    >
      {children}
    </DocsContext.Provider>
  )
}

// eslint-disable-next-line react-refresh/only-export-components
export function useDocs() {
  const ctx = useContext(DocsContext)
  if (!ctx) throw new Error('useDocs must be used within DocsProvider')
  return ctx
}
