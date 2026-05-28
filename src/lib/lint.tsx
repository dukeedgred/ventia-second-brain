import { createContext, useCallback, useContext, useRef, useState } from 'react'
import type { ReactNode } from 'react'
import type { BrainEvent } from '../types'
import { lintRun } from '../api'
import { useNotes } from './notes'

const VERB: Record<string, string> = {
  Write: 'Updating',
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

export type LintStep = { tool?: string; text: string }
type LintMode = 'audit' | 'fix'

type LintContextValue = {
  running: boolean
  mode: LintMode | null
  steps: LintStep[]
  summary: string
  error: string
  done: boolean
  start: (mode: LintMode) => void
  stop: () => void
}

const LintContext = createContext<LintContextValue | null>(null)

/** Holds lint state above the router so a run survives tab switches. */
export function LintProvider({ children }: { children: ReactNode }) {
  const notes = useNotes()
  const [running, setRunning] = useState(false)
  const [mode, setMode] = useState<LintMode | null>(null)
  const [steps, setSteps] = useState<LintStep[]>([])
  const [summary, setSummary] = useState('')
  const [error, setError] = useState('')
  const [done, setDone] = useState(false)
  const abortRef = useRef<AbortController | null>(null)

  const start = useCallback(
    (m: LintMode) => {
      if (abortRef.current) return
      setRunning(true)
      setMode(m)
      setSteps([])
      setSummary('')
      setError('')
      setDone(false)
      const ctrl = new AbortController()
      abortRef.current = ctrl
      lintRun(
        m,
        (e: BrainEvent) => {
          if (e.type === 'tool') setSteps((s) => [...s, { tool: e.tool, text: toolLabel(e.tool, e.detail) }])
          else if (e.type === 'status') setSteps((s) => [...s, { text: e.text }])
          else if (e.type === 'delta') setSummary((x) => x + e.text)
          else if (e.type === 'result') setSummary((x) => e.text || x)
          else if (e.type === 'error') setError(e.text)
          else if (e.type === 'done') setDone(true)
        },
        ctrl.signal,
      )
        .catch((err) => setError((err as Error).message))
        .finally(() => {
          setRunning(false)
          abortRef.current = null
          if (m === 'fix') notes.refresh()
        })
    },
    [notes],
  )

  const stop = useCallback(() => {
    abortRef.current?.abort()
    abortRef.current = null
    setRunning(false)
  }, [])

  return (
    <LintContext.Provider value={{ running, mode, steps, summary, error, done, start, stop }}>
      {children}
    </LintContext.Provider>
  )
}

// eslint-disable-next-line react-refresh/only-export-components
export function useLint() {
  const ctx = useContext(LintContext)
  if (!ctx) throw new Error('useLint must be used within LintProvider')
  return ctx
}
