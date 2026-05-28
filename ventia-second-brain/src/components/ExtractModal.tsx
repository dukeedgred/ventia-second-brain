import { useEffect, useState } from 'react'
import {
  Button,
  Checkbox,
  Modal,
  ModalBody,
  ModalContent,
  ModalFooter,
  ModalHeader,
  Spinner,
} from '@heroui/react'
import { api } from '../api'

type Kind = 'tickets' | 'decisions'

type Props = {
  path: string
  kind: Kind
  isOpen: boolean
  onOpenChange: (open: boolean) => void
  onDone: () => void
}

// eslint-disable-next-line @typescript-eslint/no-explicit-any
type Proposal = Record<string, any>

export function ExtractModal({ path, kind, isOpen, onOpenChange, onDone }: Props) {
  const [loading, setLoading] = useState(false)
  const [items, setItems] = useState<Proposal[]>([])
  const [picked, setPicked] = useState<Set<number>>(new Set())
  const [creating, setCreating] = useState(false)
  const [error, setError] = useState('')

  useEffect(() => {
    if (!isOpen) return
    setLoading(true)
    setItems([])
    setPicked(new Set())
    setError('')
    api
      .extract(path, kind)
      .then((r) => {
        const list = (r.items as Proposal[]) ?? []
        setItems(list)
        setPicked(new Set(list.map((_, i) => i)))
      })
      .catch((e) => setError(e.message))
      .finally(() => setLoading(false))
  }, [isOpen, path, kind])

  const toggle = (i: number) =>
    setPicked((s) => {
      const n = new Set(s)
      if (n.has(i)) n.delete(i)
      else n.add(i)
      return n
    })

  const create = async () => {
    setCreating(true)
    try {
      const chosen = items.filter((_, i) => picked.has(i))
      for (const it of chosen) {
        if (kind === 'tickets') await api.createTicket({ ...it, sources: [path] })
        else await api.createDecision({ ...it, sources: [path] })
      }
      onDone()
    } catch (e) {
      setError((e as Error).message)
    } finally {
      setCreating(false)
    }
  }

  const label = kind === 'tickets' ? 'tickets' : 'decisions'

  return (
    <Modal isOpen={isOpen} onOpenChange={onOpenChange} size="2xl" backdrop="blur" scrollBehavior="inside">
      <ModalContent className="bg-content1">
        {(close) => (
          <>
            <ModalHeader className="flex-col items-start gap-1">
              <span className="flex items-center gap-2">
                <span className="text-primary-400">✦</span> Extract {label}
              </span>
              <span className="text-xs font-normal text-default-400">
                Proposed by your local Codex from this note — pick the ones to create.
              </span>
            </ModalHeader>
            <ModalBody>
              {loading && (
                <div className="flex items-center gap-2 py-8 text-default-400">
                  <Spinner size="sm" /> Reading the note and drafting {label}…
                </div>
              )}
              {error && <p className="text-sm text-danger">{error}</p>}
              {!loading && !error && items.length === 0 && (
                <p className="py-6 text-center text-sm text-default-400">
                  No {label} found in this note.
                </p>
              )}
              <div className="flex flex-col gap-2">
                {items.map((it, i) => (
                  <button
                    key={i}
                    onClick={() => toggle(i)}
                    className={`rounded-lg border p-3 text-left transition-colors ${
                      picked.has(i)
                        ? 'border-primary/50 bg-primary/5'
                        : 'border-default-100 bg-content2/40 hover:bg-content2'
                    }`}
                  >
                    <div className="flex items-start gap-3">
                      <Checkbox isSelected={picked.has(i)} className="pointer-events-none mt-0.5" />
                      <div className="min-w-0">
                        <div className="text-sm font-medium text-foreground">{it.title}</div>
                        <div className="text-xs text-default-500">
                          {kind === 'tickets' ? it.description : it.decision}
                        </div>
                      </div>
                    </div>
                  </button>
                ))}
              </div>
            </ModalBody>
            <ModalFooter>
              <Button variant="light" onPress={close}>
                Cancel
              </Button>
              <Button
                color="primary"
                isLoading={creating}
                isDisabled={loading || picked.size === 0}
                onPress={create}
              >
                Create {picked.size > 0 ? picked.size : ''} {label}
              </Button>
            </ModalFooter>
          </>
        )}
      </ModalContent>
    </Modal>
  )
}
