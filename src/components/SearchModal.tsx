import { useEffect, useRef, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import {
  Input,
  Modal,
  ModalBody,
  ModalContent,
  Spinner,
} from '@heroui/react'
import type { SearchResult } from '../types'
import { api } from '../api'

function SearchIcon() {
  return (
    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" className="text-default-400" aria-hidden>
      <circle cx="11" cy="11" r="7" stroke="currentColor" strokeWidth="2" />
      <path d="m20 20-3-3" stroke="currentColor" strokeWidth="2" strokeLinecap="round" />
    </svg>
  )
}

function folderHint(path: string) {
  const parts = path.split('/')
  return parts.length > 1 ? parts.slice(0, -1).join('/') : ''
}

export function SearchModal({ open, onClose }: { open: boolean; onClose: () => void }) {
  const [q, setQ] = useState('')
  const [results, setResults] = useState<SearchResult[]>([])
  const [loading, setLoading] = useState(false)
  const navigate = useNavigate()
  const timer = useRef<number | undefined>(undefined)

  useEffect(() => {
    if (!open) {
      setQ('')
      setResults([])
      setLoading(false)
    }
  }, [open])

  useEffect(() => {
    window.clearTimeout(timer.current)
    if (!q.trim()) {
      setResults([])
      setLoading(false)
      return
    }
    setLoading(true)
    timer.current = window.setTimeout(() => {
      api
        .search(q)
        .then(setResults)
        .catch(() => setResults([]))
        .finally(() => setLoading(false))
    }, 150)
    return () => window.clearTimeout(timer.current)
  }, [q])

  const go = (path: string) => {
    onClose()
    navigate(`/note/${encodeURIComponent(path)}`)
  }

  return (
    <Modal
      isOpen={open}
      onClose={onClose}
      placement="top"
      size="xl"
      backdrop="blur"
      hideCloseButton
    >
      <ModalContent>
        <ModalBody className="gap-3 p-4">
          <Input
            autoFocus
            value={q}
            onValueChange={setQ}
            placeholder="Search notes…"
            variant="bordered"
            size="lg"
            isClearable
            onClear={() => setQ('')}
            startContent={<SearchIcon />}
            endContent={loading ? <Spinner size="sm" /> : undefined}
            onKeyDown={(e) => {
              if (e.key === 'Enter' && results[0]) go(results[0].path)
            }}
          />

          {q.trim() && !loading && results.length === 0 && (
            <p className="px-1 py-6 text-center text-sm text-default-400">
              No matches for &ldquo;{q}&rdquo;.
            </p>
          )}

          {results.length > 0 && (
            <div
              role="listbox"
              aria-label="Search results"
              className="max-h-[55vh] overflow-y-auto p-0"
            >
              {results.map((r) => (
                <button
                  type="button"
                  role="option"
                  aria-selected="false"
                  key={r.path}
                  className="flex w-full items-start justify-between gap-3 rounded-medium px-3 py-2 text-left outline-none transition-colors hover:bg-default-100 focus-visible:bg-default-100"
                  onClick={() => go(r.path)}
                >
                  <span className="min-w-0">
                    <span className="block truncate text-sm text-foreground">{r.name}</span>
                    <span className="block truncate text-xs text-default-400">{r.snippet}</span>
                  </span>
                  {folderHint(r.path) && (
                    <span className="shrink-0 pt-0.5 text-[11px] text-default-300">
                      {folderHint(r.path)}
                    </span>
                  )}
                </button>
              ))}
            </div>
          )}
        </ModalBody>
      </ModalContent>
    </Modal>
  )
}
