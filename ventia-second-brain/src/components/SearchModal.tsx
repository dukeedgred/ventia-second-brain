import { useEffect, useRef, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import {
  Input,
  Listbox,
  ListboxItem,
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
            <Listbox
              aria-label="Search results"
              variant="flat"
              className="max-h-[55vh] overflow-y-auto p-0"
              onAction={(key) => go(String(key))}
            >
              {results.map((r) => (
                <ListboxItem
                  key={r.path}
                  textValue={r.name}
                  description={r.snippet}
                  endContent={
                    folderHint(r.path) ? (
                      <span className="shrink-0 text-[11px] text-default-300">{folderHint(r.path)}</span>
                    ) : undefined
                  }
                  classNames={{ description: 'line-clamp-1 text-default-400' }}
                >
                  {r.name}
                </ListboxItem>
              ))}
            </Listbox>
          )}
        </ModalBody>
      </ModalContent>
    </Modal>
  )
}
