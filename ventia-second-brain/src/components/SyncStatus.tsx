import { useCallback, useEffect, useRef, useState } from 'react'
import type { SyncStatus as SyncStatusT, SyncState } from '../types'
import { api } from '../api'

const DOT: Record<SyncState, string> = {
  disabled: 'bg-default-300',
  idle: 'bg-default-400',
  syncing: 'bg-primary animate-pulse',
  ok: 'bg-success',
  offline: 'bg-warning',
  conflict: 'bg-danger',
  error: 'bg-danger',
}

const LABEL: Record<SyncState, string> = {
  disabled: 'Sync off',
  idle: 'Not synced',
  syncing: 'Syncing…',
  ok: 'Synced',
  offline: 'Offline',
  conflict: 'Conflict',
  error: 'Sync error',
}

/** Small footer indicator: shows git-sync state and a manual "Sync now". Hidden when sync is off. */
export function SyncStatus() {
  const [s, setS] = useState<SyncStatusT | null>(null)
  const busy = useRef(false)

  const poll = useCallback(async () => {
    try {
      setS(await api.sync())
    } catch {
      /* keep previous status */
    }
  }, [])

  useEffect(() => {
    poll()
    const id = window.setInterval(poll, 10000)
    return () => window.clearInterval(id)
  }, [poll])

  const syncNow = async () => {
    if (busy.current) return
    busy.current = true
    setS((prev) => (prev ? { ...prev, state: 'syncing' } : prev))
    try {
      setS(await api.syncNow())
    } catch {
      await poll()
    } finally {
      busy.current = false
    }
  }

  if (!s || !s.enabled) return null

  const counts = [s.ahead ? `${s.ahead}↑` : '', s.behind ? `${s.behind}↓` : ''].filter(Boolean).join(' ')

  return (
    <div className="mb-2 rounded-lg border border-default-100 bg-content2 px-3 py-2">
      <div className="flex items-center justify-between gap-2">
        <span className="flex min-w-0 items-center gap-2">
          <span className={`h-2 w-2 shrink-0 rounded-full ${DOT[s.state]}`} />
          <span className="truncate text-xs text-default-600">
            {LABEL[s.state]}
            {counts && <span className="text-default-400"> · {counts}</span>}
          </span>
        </span>
        <button
          onClick={syncNow}
          disabled={s.state === 'syncing'}
          className="shrink-0 text-[11px] text-primary-300 transition-colors hover:text-primary-200 disabled:opacity-50"
          title={`${s.remote}/${s.branch}`}
        >
          Sync now
        </button>
      </div>
      {(s.state === 'conflict' || s.state === 'error' || s.state === 'offline') && s.message && (
        <p className="mt-1 text-[11px] leading-snug text-danger">{s.message}</p>
      )}
    </div>
  )
}
