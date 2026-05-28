import { createContext, useCallback, useContext, useEffect, useRef, useState } from 'react'
import type { ReactNode } from 'react'
import type { BrainEvent } from '../types'
import { askBrain } from '../api'

export type AskMsg = {
  role: 'user' | 'assistant'
  content: string
  tools: string[]
  status: string
  error?: string
  cost?: number
  done?: boolean
}

function toolLabel(e: Extract<BrainEvent, { type: 'tool' }>): string {
  if (e.tool === 'Read') return `Reading ${e.detail ?? 'a note'}`
  if (e.tool === 'Grep') return `Searching ${e.detail ?? ''}`.trim()
  if (e.tool === 'Glob') return `Scanning ${e.detail ?? ''}`.trim()
  return e.tool
}

type AskContextValue = {
  messages: AskMsg[]
  input: string
  setInput: (s: string) => void
  streaming: boolean
  send: (question: string) => void
  stop: () => void
  clear: () => void
}

const AskContext = createContext<AskContextValue | null>(null)

/**
 * Holds the Ask conversation ABOVE the router, so an in-flight answer keeps
 * streaming (and the history stays) when you switch tabs.
 */
export function AskProvider({ children }: { children: ReactNode }) {
  const [messages, setMessages] = useState<AskMsg[]>([])
  const [input, setInput] = useState('')
  const [streaming, setStreaming] = useState(false)
  const abortRef = useRef<AbortController | null>(null)
  // Mirror messages into a ref so `send` can read the latest history without
  // changing identity on every streamed token.
  const messagesRef = useRef<AskMsg[]>([])
  useEffect(() => {
    messagesRef.current = messages
  }, [messages])

  const send = useCallback(async (question: string) => {
    const q = question.trim()
    if (!q || abortRef.current) return // ignore empty / concurrent sends
    const history = messagesRef.current
      .filter((m) => m.content.trim() && !m.error)
      .slice(-6)
      .map((m) => ({ role: m.role, content: m.content }))
    setInput('')
    setMessages((m) => [
      ...m,
      { role: 'user', content: q, tools: [], status: '' },
      { role: 'assistant', content: '', tools: [], status: 'Thinking…' },
    ])
    setStreaming(true)
    const ctrl = new AbortController()
    abortRef.current = ctrl

    const update = (fn: (a: AskMsg) => AskMsg) =>
      setMessages((m) => {
        const copy = m.slice()
        for (let i = copy.length - 1; i >= 0; i--) {
          if (copy[i].role === 'assistant') {
            copy[i] = fn(copy[i])
            break
          }
        }
        return copy
      })

    try {
      await askBrain(
        q,
        history,
        (e) => {
          if (e.type === 'delta') update((a) => ({ ...a, content: a.content + e.text, status: '' }))
          else if (e.type === 'tool') update((a) => ({ ...a, tools: [...a.tools, toolLabel(e)] }))
          else if (e.type === 'status') update((a) => ({ ...a, status: e.text }))
          else if (e.type === 'result')
            update((a) => ({ ...a, content: e.text || a.content, status: '', cost: e.costUsd, done: true }))
          else if (e.type === 'error') update((a) => ({ ...a, error: e.text, status: '' }))
          else if (e.type === 'done') update((a) => ({ ...a, status: '', done: true }))
        },
        ctrl.signal,
      )
    } catch (err) {
      update((a) => ({ ...a, error: (err as Error).message, status: '' }))
    } finally {
      setStreaming(false)
      abortRef.current = null
    }
  }, [])

  const stop = useCallback(() => {
    abortRef.current?.abort()
    abortRef.current = null
    setStreaming(false)
  }, [])

  const clear = useCallback(() => {
    if (abortRef.current) return
    setMessages([])
  }, [])

  return (
    <AskContext.Provider value={{ messages, input, setInput, streaming, send, stop, clear }}>
      {children}
    </AskContext.Provider>
  )
}

// eslint-disable-next-line react-refresh/only-export-components
export function useAsk() {
  const ctx = useContext(AskContext)
  if (!ctx) throw new Error('useAsk must be used within AskProvider')
  return ctx
}
