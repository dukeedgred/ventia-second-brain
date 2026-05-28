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
import type { Decision } from '../types'
import { api } from '../api'
import { Markdown } from '../lib/markdown'

const STATUS_COLOR: Record<string, 'success' | 'warning' | 'default'> = {
  accepted: 'success',
  proposed: 'warning',
  superseded: 'default',
}

export default function DecisionsPage() {
  const [decisions, setDecisions] = useState<Decision[]>([])
  const { isOpen, onOpen, onOpenChange, onClose } = useDisclosure()

  const refresh = () => api.decisions().then(setDecisions).catch(() => {})
  useEffect(() => {
    refresh()
  }, [])

  return (
    <div className="mx-auto max-w-3xl px-8 py-10">
      <div className="mb-6 flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-semibold text-foreground">Decisions</h1>
          <p className="text-sm text-default-400">
            Architecture &amp; approach calls the team has committed to.
          </p>
        </div>
        <Button color="primary" onPress={onOpen}>
          New decision
        </Button>
      </div>

      <div className="flex flex-col gap-4">
        {decisions.length === 0 && (
          <p className="text-sm text-default-400">No decisions recorded yet.</p>
        )}
        {decisions.map((d) => (
          <div key={d.path} className="rounded-xl border border-default-100 bg-content1 p-5">
            <div className="mb-2 flex flex-wrap items-center gap-3">
              <Link
                to={`/note/${encodeURIComponent(d.path)}`}
                className="text-lg font-medium text-foreground hover:text-primary-300"
              >
                {d.title}
              </Link>
              <Chip size="sm" color={STATUS_COLOR[d.status] ?? 'default'} variant="flat">
                {d.status}
              </Chip>
              {d.date && <span className="text-xs text-default-400">{String(d.date).slice(0, 10)}</span>}
            </div>
            <Markdown content={d.body} />
          </div>
        ))}
      </div>

      <NewDecisionModal
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

function NewDecisionModal({
  isOpen,
  onOpenChange,
  onCreated,
}: {
  isOpen: boolean
  onOpenChange: (open: boolean) => void
  onCreated: () => void
}) {
  const [title, setTitle] = useState('')
  const [context, setContext] = useState('')
  const [decision, setDecision] = useState('')
  const [consequences, setConsequences] = useState('')
  const [status, setStatus] = useState('accepted')
  const [busy, setBusy] = useState(false)

  const create = async () => {
    if (!title.trim()) return
    setBusy(true)
    try {
      await api.createDecision({ title, context, decision, consequences, status })
      setTitle('')
      setContext('')
      setDecision('')
      setConsequences('')
      setStatus('accepted')
      onCreated()
    } finally {
      setBusy(false)
    }
  }

  return (
    <Modal isOpen={isOpen} onOpenChange={onOpenChange} backdrop="blur" size="lg" scrollBehavior="inside">
      <ModalContent className="bg-content1">
        {(close) => (
          <>
            <ModalHeader>New decision</ModalHeader>
            <ModalBody>
              <Input label="Title" value={title} onValueChange={setTitle} variant="bordered" autoFocus />
              <Select
                label="Status"
                variant="bordered"
                selectedKeys={new Set([status])}
                onSelectionChange={(k) => {
                  const v = Array.from(k as Set<string>)[0]
                  if (v) setStatus(v)
                }}
              >
                <SelectItem key="proposed">proposed</SelectItem>
                <SelectItem key="accepted">accepted</SelectItem>
                <SelectItem key="superseded">superseded</SelectItem>
              </Select>
              <Textarea label="Context" value={context} onValueChange={setContext} variant="bordered" minRows={2} />
              <Textarea label="Decision" value={decision} onValueChange={setDecision} variant="bordered" minRows={2} />
              <Textarea
                label="Consequences"
                value={consequences}
                onValueChange={setConsequences}
                variant="bordered"
                minRows={2}
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
