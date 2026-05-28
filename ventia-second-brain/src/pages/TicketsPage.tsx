import { useEffect, useState } from 'react'
import { Link } from 'react-router-dom'
import {
  Button,
  Chip,
  Input,
  Modal,
  ModalBody,
  ModalContent,
  ModalFooter,
  ModalHeader,
  Select,
  SelectItem,
  Textarea,
  useDisclosure,
} from '@heroui/react'
import type { Ticket } from '../types'
import { api } from '../api'

const COLUMNS = [
  { key: 'todo', label: 'To Do' },
  { key: 'in-progress', label: 'In Progress' },
  { key: 'done', label: 'Done' },
]

const PRIORITY_COLOR: Record<string, 'danger' | 'warning' | 'default'> = {
  high: 'danger',
  medium: 'warning',
  low: 'default',
}

export default function TicketsPage() {
  const [tickets, setTickets] = useState<Ticket[]>([])
  const [dragOver, setDragOver] = useState<string | null>(null)
  const [showArchived, setShowArchived] = useState(false)
  const { isOpen, onOpen, onOpenChange, onClose } = useDisclosure()

  const refresh = () => api.tickets().then(setTickets).catch(() => {})
  useEffect(() => {
    refresh()
  }, [])

  const activeTickets = tickets.filter((t) => (t.status || 'todo') !== 'archived')
  const archivedTickets = tickets.filter((t) => (t.status || 'todo') === 'archived')

  const move = async (path: string, status: string) => {
    setTickets((ts) => ts.map((t) => (t.path === path ? { ...t, status } : t)))
    try {
      await api.updateItem(path, { status })
    } catch {
      refresh()
    }
  }

  const archive = async (path: string) => {
    const dateArchived = new Date().toISOString().slice(0, 10)
    setTickets((ts) =>
      ts.map((t) => (t.path === path ? { ...t, status: 'archived', 'date-archived': dateArchived } : t)),
    )
    try {
      await api.updateItem(path, { status: 'archived', 'date-archived': dateArchived })
    } catch {
      refresh()
    }
  }

  const restore = async (path: string) => {
    setTickets((ts) => ts.map((t) => (t.path === path ? { ...t, status: 'todo' } : t)))
    try {
      await api.updateItem(path, { status: 'todo', 'date-archived': null })
    } catch {
      refresh()
    }
  }

  return (
    <div className="flex h-full flex-col">
      <div className="flex items-center justify-between border-b border-default-100 px-8 py-4">
        <div>
          <h1 className="text-lg font-semibold text-foreground">Tickets</h1>
          <p className="text-sm text-default-400">
            Action items from meetings — drag a card between columns to change status.
          </p>
        </div>
        <div className="flex items-center gap-2">
          <Button variant="flat" onPress={() => setShowArchived((v) => !v)}>
            {showArchived ? 'Hide archive' : `Archive (${archivedTickets.length})`}
          </Button>
          <Button color="primary" onPress={onOpen}>
            New ticket
          </Button>
        </div>
      </div>

      <div className="flex flex-1 gap-4 overflow-x-auto p-6">
        {COLUMNS.map((col) => {
          const items = activeTickets.filter((t) => (t.status || 'todo') === col.key)
          return (
            <div
              key={col.key}
              onDragOver={(e) => {
                e.preventDefault()
                setDragOver(col.key)
              }}
              onDragLeave={() => setDragOver((d) => (d === col.key ? null : d))}
              onDrop={(e) => {
                e.preventDefault()
                const p = e.dataTransfer.getData('text/plain')
                setDragOver(null)
                if (p) move(p, col.key)
              }}
              className={`flex w-80 shrink-0 flex-col rounded-xl border p-3 transition-colors ${
                dragOver === col.key
                  ? 'border-primary/60 bg-primary/5'
                  : 'border-default-100 bg-content1/40'
              }`}
            >
              <div className="mb-3 flex items-center justify-between px-1">
                <span className="text-sm font-semibold text-default-600">{col.label}</span>
                <span className="rounded-full bg-content2 px-2 text-xs text-default-400">
                  {items.length}
                </span>
              </div>
              <div className="flex flex-col gap-2">
                {items.map((t) => (
                  <TicketCard key={t.path} t={t} onArchive={archive} />
                ))}
                {items.length === 0 && (
                  <div className="rounded-lg border border-dashed border-default-100 p-4 text-center text-xs text-default-400">
                    Drop here
                  </div>
                )}
              </div>
            </div>
          )
        })}
        {showArchived && (
          <div className="flex w-80 shrink-0 flex-col rounded-xl border border-default-100 bg-content1/30 p-3">
            <div className="mb-3 flex items-center justify-between px-1">
              <span className="text-sm font-semibold text-default-600">Archive</span>
              <span className="rounded-full bg-content2 px-2 text-xs text-default-400">
                {archivedTickets.length}
              </span>
            </div>
            <div className="flex flex-col gap-2">
              {archivedTickets.map((t) => (
                <TicketCard key={t.path} t={t} archived onRestore={restore} />
              ))}
              {archivedTickets.length === 0 && (
                <div className="rounded-lg border border-dashed border-default-100 p-4 text-center text-xs text-default-400">
                  No archived tickets
                </div>
              )}
            </div>
          </div>
        )}
      </div>

      <NewTicketModal
        isOpen={isOpen}
        onOpenChange={onOpenChange}
        onCreated={() => {
          onClose()
          refresh()
        }}
      />
    </div>
  )
}

function TicketCard({
  t,
  archived = false,
  onArchive,
  onRestore,
}: {
  t: Ticket
  archived?: boolean
  onArchive?: (path: string) => void
  onRestore?: (path: string) => void
}) {
  const src = t.sources?.[0]
  return (
    <div
      draggable={!archived}
      onDragStart={(e) => e.dataTransfer.setData('text/plain', t.path)}
      className={`rounded-lg border border-default-100 bg-content1 p-3 shadow-sm ${
        archived ? '' : 'cursor-grab active:cursor-grabbing'
      }`}
    >
      <div className="mb-2 flex items-start gap-2">
        <Link
          to={`/note/${encodeURIComponent(t.path)}`}
          className="min-w-0 flex-1 text-sm font-medium text-foreground hover:text-primary-300"
        >
          {t.title}
        </Link>
        {archived ? (
          <Button size="sm" variant="flat" onPress={() => onRestore?.(t.path)}>
            Restore
          </Button>
        ) : (
          <Button size="sm" variant="light" onPress={() => onArchive?.(t.path)}>
            Archive
          </Button>
        )}
      </div>
      {t.body && <p className="mb-2 line-clamp-2 text-xs text-default-500">{t.body}</p>}
      <div className="flex flex-wrap items-center gap-2">
        <Chip size="sm" color={PRIORITY_COLOR[t.priority] ?? 'default'} variant="flat">
          {t.priority}
        </Chip>
        <span className="text-xs text-default-400">{t.assignee}</span>
        {src && (
          <Link
            to={`/note/${encodeURIComponent(src)}`}
            className="ml-auto text-[11px] text-primary-300 hover:underline"
          >
            source
          </Link>
        )}
      </div>
    </div>
  )
}

function NewTicketModal({
  isOpen,
  onOpenChange,
  onCreated,
}: {
  isOpen: boolean
  onOpenChange: (open: boolean) => void
  onCreated: () => void
}) {
  const [title, setTitle] = useState('')
  const [description, setDescription] = useState('')
  const [priority, setPriority] = useState('medium')
  const [status, setStatus] = useState('todo')
  const [assignee, setAssignee] = useState('')
  const [busy, setBusy] = useState(false)

  const create = async () => {
    if (!title.trim()) return
    setBusy(true)
    try {
      await api.createTicket({ title, description, priority, status, assignee: assignee || 'Unassigned' })
      setTitle('')
      setDescription('')
      setAssignee('')
      setPriority('medium')
      setStatus('todo')
      onCreated()
    } finally {
      setBusy(false)
    }
  }

  return (
    <Modal isOpen={isOpen} onOpenChange={onOpenChange} backdrop="blur" size="lg">
      <ModalContent className="bg-content1">
        {(close) => (
          <>
            <ModalHeader>New ticket</ModalHeader>
            <ModalBody>
              <Input label="Title" value={title} onValueChange={setTitle} variant="bordered" autoFocus />
              <Textarea
                label="Description"
                value={description}
                onValueChange={setDescription}
                variant="bordered"
                minRows={3}
              />
              <div className="flex gap-3">
                <Select
                  label="Priority"
                  variant="bordered"
                  className="flex-1"
                  selectedKeys={new Set([priority])}
                  onSelectionChange={(k) => {
                    const v = Array.from(k as Set<string>)[0]
                    if (v) setPriority(v)
                  }}
                >
                  <SelectItem key="low">low</SelectItem>
                  <SelectItem key="medium">medium</SelectItem>
                  <SelectItem key="high">high</SelectItem>
                </Select>
                <Select
                  label="Status"
                  variant="bordered"
                  className="flex-1"
                  selectedKeys={new Set([status])}
                  onSelectionChange={(k) => {
                    const v = Array.from(k as Set<string>)[0]
                    if (v) setStatus(v)
                  }}
                >
                  <SelectItem key="todo">To Do</SelectItem>
                  <SelectItem key="in-progress">In Progress</SelectItem>
                  <SelectItem key="done">Done</SelectItem>
                </Select>
              </div>
              <Input
                label="Assignee"
                value={assignee}
                onValueChange={setAssignee}
                variant="bordered"
                placeholder="Unassigned"
              />
            </ModalBody>
            <ModalFooter>
              <Button variant="light" onPress={close}>
                Cancel
              </Button>
              <Button color="primary" isLoading={busy} isDisabled={!title.trim()} onPress={create}>
                Create
              </Button>
            </ModalFooter>
          </>
        )}
      </ModalContent>
    </Modal>
  )
}
