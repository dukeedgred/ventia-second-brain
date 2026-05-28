import { useEffect, useRef, useState } from 'react'
import { useNavigate, useSearchParams } from 'react-router-dom'
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
  Spinner,
} from '@heroui/react'
import { Markdown } from '../lib/markdown'
import { useAsk } from '../lib/ask'
import type { AskMsg } from '../lib/ask'
import { useNotes } from '../lib/notes'
import { api } from '../api'

const SUGGESTED = [
  'Give me a 2-minute primer on this engagement.',
  'What makes classification hard here?',
  'Why do we branch on whether a line has a PO?',
  'Who are the key stakeholders and what do they care about?',
]

export default function AskPage() {
  const { messages, input, setInput, streaming, send, stop, clear } = useAsk()
  const [params, setParams] = useSearchParams()
  const bottomRef = useRef<HTMLDivElement>(null)
  const didAuto = useRef(false)
  const [saveSrc, setSaveSrc] = useState<{ content: string; title: string } | null>(null)

  useEffect(() => {
    bottomRef.current?.scrollIntoView({ behavior: 'smooth' })
  }, [messages])

  // Auto-ask when arriving via /ask?q=...
  useEffect(() => {
    const q = params.get('q')
    if (q && !didAuto.current) {
      didAuto.current = true
      setParams({}, { replace: true })
      void send(q)
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [])

  return (
    <div className="flex h-full flex-col">
      <div className="flex items-start justify-between gap-3 border-b border-default-100 px-8 py-4">
        <div>
          <h1 className="flex items-center gap-2 text-lg font-semibold text-foreground">
            <span className="text-primary-400">✦</span> Ask the Brain
          </h1>
          <p className="text-sm text-default-400">
            Answers come from your local Codex, grounded in the notes in this workspace.
          </p>
        </div>
        {messages.length > 0 && !streaming && (
          <Button size="sm" variant="light" onPress={clear}>
            New chat
          </Button>
        )}
      </div>

      <div className="flex-1 overflow-y-auto px-8 py-6">
        <div className="mx-auto max-w-3xl">
          {messages.length === 0 && (
            <div className="mt-6">
              <p className="mb-3 text-sm text-default-500">Try asking…</p>
              <div className="flex flex-col gap-2">
                {SUGGESTED.map((s) => (
                  <button
                    key={s}
                    onClick={() => send(s)}
                    className="rounded-xl border border-default-100 bg-content1 px-4 py-3 text-left text-sm text-default-600 transition-colors hover:border-primary/40 hover:bg-content2"
                  >
                    {s}
                  </button>
                ))}
              </div>
            </div>
          )}

          <div className="flex flex-col gap-6">
            {messages.map((m, i) => (
              <MessageBubble
                key={i}
                msg={m}
                question={
                  m.role === 'assistant' && i > 0 && messages[i - 1].role === 'user'
                    ? messages[i - 1].content
                    : ''
                }
                onSave={(content, title) => setSaveSrc({ content, title })}
              />
            ))}
          </div>
          <div ref={bottomRef} />
        </div>
      </div>

      <div className="border-t border-default-100 px-8 py-4">
        <div className="mx-auto flex max-w-3xl gap-2">
          <Input
            value={input}
            onValueChange={setInput}
            placeholder={messages.length ? 'Ask a follow-up…' : 'Ask a question…'}
            variant="bordered"
            onKeyDown={(e) => {
              if (e.key === 'Enter' && !e.shiftKey) {
                e.preventDefault()
                void send(input)
              }
            }}
          />
          {streaming ? (
            <Button color="danger" variant="flat" onPress={stop}>
              Stop
            </Button>
          ) : (
            <Button color="primary" isDisabled={!input.trim()} onPress={() => send(input)}>
              Send
            </Button>
          )}
        </div>
      </div>

      {saveSrc && (
        <SaveAnswerModal src={saveSrc} isOpen={!!saveSrc} onClose={() => setSaveSrc(null)} />
      )}
    </div>
  )
}

function MessageBubble({
  msg,
  question,
  onSave,
}: {
  msg: AskMsg
  question: string
  onSave: (content: string, title: string) => void
}) {
  if (msg.role === 'user') {
    return (
      <div className="flex justify-end">
        <div className="max-w-[85%] rounded-2xl rounded-br-sm bg-primary/20 px-4 py-2.5 text-foreground">
          {msg.content}
        </div>
      </div>
    )
  }
  return (
    <div className="flex flex-col gap-2">
      {msg.tools.length > 0 && (
        <div className="flex flex-wrap gap-1.5">
          {msg.tools.map((t, i) => (
            <Chip
              key={i}
              size="sm"
              variant="flat"
              className="bg-content2 text-default-500"
              startContent={<span className="px-0.5 text-primary-400">⌕</span>}
            >
              {t}
            </Chip>
          ))}
        </div>
      )}
      {msg.status && (
        <div className="flex items-center gap-2 text-sm text-default-400">
          <Spinner size="sm" /> {msg.status}
        </div>
      )}
      {msg.content && (
        <div className="rounded-2xl rounded-bl-sm border border-default-100 bg-content1 px-5 py-3">
          <Markdown content={msg.content} />
          <div className="mt-2 flex items-center justify-between gap-2">
            {typeof msg.cost === 'number' ? (
              <span className="text-[11px] text-default-300">~${msg.cost.toFixed(4)}</span>
            ) : (
              <span />
            )}
            {msg.done && !msg.error && (
              <Button
                size="sm"
                variant="light"
                className="text-default-400 hover:text-foreground"
                onPress={() => onSave(msg.content, question)}
              >
                ＋ Save as note
              </Button>
            )}
          </div>
        </div>
      )}
      {msg.error && (
        <div className="rounded-xl border border-danger/40 bg-danger/10 px-4 py-3 text-sm text-danger">
          {msg.error}
        </div>
      )}
    </div>
  )
}

function SaveAnswerModal({
  src,
  isOpen,
  onClose,
}: {
  src: { content: string; title: string }
  isOpen: boolean
  onClose: () => void
}) {
  const { notes, refresh } = useNotes()
  const navigate = useNavigate()
  const [title, setTitle] = useState(() => cleanTitle(src.title))
  const [folder, setFolder] = useState('wiki/ResMed')
  const [busy, setBusy] = useState(false)
  const [err, setErr] = useState('')

  const folders = Array.from(
    new Set(notes.map((n) => n.path.split('/').slice(0, -1).join('/')).filter(Boolean)),
  ).sort()
  const options = folders.length ? folders : ['wiki/ResMed', 'raw']

  const save = async () => {
    const name = title.trim()
    if (!name) return
    setBusy(true)
    setErr('')
    const today = new Date().toISOString().slice(0, 10)
    const path = `${folder.replace(/\/+$/, '')}/${name}.md`
    const body = `---\ntype: concept\ntopic: ResMed\nsources: []\ndate-created: ${today}\ndate-updated: ${today}\ntags: [ask]\n---\n\n# ${name}\n\n${src.content.trim()}\n`
    try {
      await api.createNote(path, body)
      refresh()
      onClose()
      navigate(`/note/${encodeURIComponent(path)}`)
    } catch (e) {
      setErr((e as Error).message)
    } finally {
      setBusy(false)
    }
  }

  return (
    <Modal isOpen={isOpen} onOpenChange={(o) => !o && onClose()} backdrop="blur">
      <ModalContent className="bg-content1">
        <ModalHeader>Save answer as note</ModalHeader>
        <ModalBody>
          <Select
            label="Folder"
            variant="bordered"
            selectedKeys={new Set([folder])}
            onSelectionChange={(keys) => {
              const k = Array.from(keys as Set<string>)[0]
              if (k) setFolder(k)
            }}
          >
            {options.map((f) => (
              <SelectItem key={f}>{f}</SelectItem>
            ))}
          </Select>
          <Input
            label="Title"
            value={title}
            onValueChange={setTitle}
            variant="bordered"
            placeholder="e.g. Classification Approach"
            autoFocus
            onKeyDown={(e) => {
              if (e.key === 'Enter') save()
            }}
          />
          {err && <p className="text-sm text-danger">{err}</p>}
        </ModalBody>
        <ModalFooter>
          <Button variant="light" onPress={onClose}>
            Cancel
          </Button>
          <Button color="primary" isLoading={busy} isDisabled={!title.trim()} onPress={save}>
            Save note
          </Button>
        </ModalFooter>
      </ModalContent>
    </Modal>
  )
}

/** Turn a question into a reasonable, filename-safe note title. */
function cleanTitle(q: string): string {
  return q
    .replace(/[<>:"/\\|?*]/g, ' ')
    .replace(/\s+/g, ' ')
    .replace(/[?.!]+$/, '')
    .trim()
    .slice(0, 80)
}
