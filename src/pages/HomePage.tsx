import { useEffect, useMemo, useState } from 'react'
import { Link, useNavigate } from 'react-router-dom'
import { Button, Card, CardBody, Checkbox, Chip, Input } from '@heroui/react'
import { api } from '../api'
import { ExtractModal } from '../components/ExtractModal'
import { useNotes } from '../lib/notes'
import type { Ticket } from '../types'

const SUGGESTED = [
  'What is the Ventia Spend Cube and why are we building it?',
  'Which source systems feed the cube?',
  'How does the rules → ML → LLM classification cascade work?',
  'What are the biggest data-quality risks?',
]

const OVERVIEW_PATH = 'wiki/Ventia/Ventia Overview.md'

const PRIORITY_WEIGHT: Record<string, number> = {
  high: 0,
  medium: 1,
  low: 2,
}

const PRIORITY_COLOR: Record<string, 'danger' | 'warning' | 'default'> = {
  high: 'danger',
  medium: 'warning',
  low: 'default',
}

function noteLabel(path: string) {
  return path
    .split('/')
    .pop()
    ?.replace(/\.md$/i, '')
    .replace(/[-_]/g, ' ') || path
}

export default function HomePage() {
  const { notes } = useNotes()
  const navigate = useNavigate()
  const [q, setQ] = useState('')
  const [tickets, setTickets] = useState<Ticket[]>([])
  const [ticketError, setTicketError] = useState('')
  const [extractPath, setExtractPath] = useState('')
  const [extractPaths, setExtractPaths] = useState<string[]>([])
  const [selectedSources, setSelectedSources] = useState<Set<string>>(new Set())

  const stats = useMemo(() => {
    const wiki = notes.filter((n) => n.path.startsWith('wiki/')).length
    const raw = notes.filter((n) => n.path.startsWith('raw/')).length
    const topics = new Set(notes.map((n) => n.topic).filter(Boolean)).size
    return { total: notes.length, wiki, raw, topics }
  }, [notes])

  const openTodos = useMemo(
    () =>
      tickets
        .filter((t) => !['done', 'archived'].includes(t.status || 'todo'))
        .sort((a, b) => {
          const pa = PRIORITY_WEIGHT[a.priority] ?? 9
          const pb = PRIORITY_WEIGHT[b.priority] ?? 9
          if (pa !== pb) return pa - pb
          return a.title.localeCompare(b.title)
        })
        .slice(0, 5),
    [tickets],
  )

  const recentSources = useMemo(
    () =>
      notes
        .filter((n) => n.path.startsWith('raw/') || n.type === 'source')
        .sort((a, b) => (b.modified ?? 0) - (a.modified ?? 0))
        .slice(0, 4),
    [notes],
  )

  const refreshTickets = () =>
    api
      .tickets()
      .then((items) => {
        setTickets(items)
        setTicketError('')
      })
      .catch((err) => setTicketError((err as Error).message))

  useEffect(() => {
    refreshTickets()
  }, [])

  const ask = (question: string) => navigate(`/ask?q=${encodeURIComponent(question)}`)

  const toggleSource = (path: string) =>
    setSelectedSources((current) => {
      const next = new Set(current)
      if (next.has(path)) next.delete(path)
      else next.add(path)
      return next
    })

  return (
    <div className="mx-auto max-w-4xl px-8 py-12">
      <div className="mb-2 flex items-center gap-2 text-sm text-primary-300">
        <span>✦</span>
        <span>Ventia · Indirect Procurement</span>
      </div>
      <h1 className="text-4xl font-semibold tracking-tight text-foreground">Second Brain</h1>
      <p className="mt-3 max-w-2xl text-default-500">
        The team's living knowledge base for the Spend Cube engagement — meeting notes, curated wiki
        pages, and an assistant that answers from everything we know. New here? Start with{' '}
        <button
          className="text-primary-300 underline-offset-2 hover:underline"
          onClick={() => navigate(`/note/${encodeURIComponent(OVERVIEW_PATH)}`)}
        >
          the Ventia Overview
        </button>
        .
      </p>

      <Card className="mt-8 border border-default-100 bg-content1">
        <CardBody className="gap-3">
          <div className="flex items-center gap-2 text-sm font-medium text-default-600">
            <span className="text-primary-400">✦</span> Ask the Brain
          </div>
          <div className="flex gap-2">
            <Input
              value={q}
              onValueChange={setQ}
              placeholder="Ask anything about the engagement…"
              variant="bordered"
              onKeyDown={(e) => {
                if (e.key === 'Enter' && q.trim()) ask(q)
              }}
            />
            <Button color="primary" isDisabled={!q.trim()} onPress={() => ask(q)}>
              Ask
            </Button>
          </div>
          <div className="flex flex-wrap gap-2">
            {SUGGESTED.map((s) => (
              <Button
                key={s}
                size="sm"
                variant="flat"
                radius="full"
                className="bg-content2 text-default-500"
                onPress={() => ask(s)}
              >
                {s}
              </Button>
            ))}
          </div>
        </CardBody>
      </Card>

      <div className="mt-8 grid grid-cols-2 gap-4 sm:grid-cols-4">
        <StatCard label="Notes" value={stats.total} />
        <StatCard label="Wiki pages" value={stats.wiki} />
        <StatCard label="Raw sources" value={stats.raw} />
        <StatCard label="Topics" value={stats.topics} />
      </div>

      <Card className="mt-8 border border-default-100 bg-content1">
        <CardBody className="gap-4">
          <div className="flex flex-wrap items-center justify-between gap-3">
            <div>
              <div className="text-sm font-semibold text-foreground">Today&apos;s to-dos</div>
              <div className="text-xs text-default-400">
                Open action items and recent meeting notes ready for extraction.
              </div>
            </div>
            <Button size="sm" variant="flat" onPress={() => navigate('/tickets')}>
              Open board
            </Button>
          </div>

          {ticketError && <div className="text-sm text-danger">{ticketError}</div>}

          <div className="grid gap-4 md:grid-cols-[1.1fr_0.9fr]">
            <div className="min-w-0">
              <div className="mb-2 text-xs font-semibold uppercase tracking-wide text-default-400">
                Open tickets
              </div>
              <div className="flex flex-col gap-2">
                {openTodos.map((ticket) => (
                  <Link
                    key={ticket.path}
                    to="/tickets"
                    className="rounded-lg border border-default-100 bg-content2/40 px-3 py-2 hover:bg-content2"
                  >
                    <div className="flex items-start justify-between gap-3">
                      <div className="min-w-0">
                        <div className="truncate text-sm font-medium text-foreground">{ticket.title}</div>
                        <div className="mt-0.5 line-clamp-2 text-xs text-default-500">
                          {ticket.body.trim() || 'No description captured yet.'}
                        </div>
                      </div>
                      <Chip size="sm" color={PRIORITY_COLOR[ticket.priority] ?? 'default'} variant="flat">
                        {ticket.priority || 'medium'}
                      </Chip>
                    </div>
                  </Link>
                ))}
                {openTodos.length === 0 && (
                  <div className="rounded-lg border border-default-100 bg-content2/30 px-3 py-4 text-sm text-default-400">
                    No open tickets yet.
                  </div>
                )}
              </div>
            </div>

            <div className="min-w-0">
              <div className="mb-2 flex items-center justify-between gap-2">
                <div className="text-xs font-semibold uppercase tracking-wide text-default-400">
                  Recent sources
                </div>
                <Button
                  size="sm"
                  variant="flat"
                  isDisabled={selectedSources.size < 2}
                  onPress={() => setExtractPaths(Array.from(selectedSources))}
                >
                  Generate selected
                </Button>
              </div>
              <div className="flex flex-col gap-2">
                {recentSources.map((note) => (
                  <div
                    key={note.path}
                    className="flex items-center justify-between gap-3 rounded-lg border border-default-100 bg-content2/40 px-3 py-2"
                  >
                    <div className="flex min-w-0 items-center gap-2">
                      <Checkbox
                        size="sm"
                        isSelected={selectedSources.has(note.path)}
                        onValueChange={() => toggleSource(note.path)}
                      />
                      <button
                        className="min-w-0 truncate text-left text-sm text-foreground hover:text-primary-300"
                        onClick={() => navigate(`/note/${encodeURIComponent(note.path)}`)}
                      >
                        {noteLabel(note.path)}
                      </button>
                    </div>
                    <Button size="sm" variant="flat" onPress={() => setExtractPath(note.path)}>
                      Generate
                    </Button>
                  </div>
                ))}
                {recentSources.length === 0 && (
                  <div className="rounded-lg border border-default-100 bg-content2/30 px-3 py-4 text-sm text-default-400">
                    No meeting notes have been ingested yet.
                  </div>
                )}
              </div>
            </div>
          </div>
        </CardBody>
      </Card>

      <div className="mt-8 grid gap-4 sm:grid-cols-2">
        <NavCard
          title="Ingest meeting notes"
          desc="Paste raw notes → wiki pages, index & log."
          icon="⊕"
          onClick={() => navigate('/ingest')}
        />
        <NavCard
          title="Explore the graph"
          desc="See how every note connects."
          icon="◉"
          onClick={() => navigate('/graph')}
        />
        <NavCard
          title="Tickets"
          desc="Action items from meetings, on a board."
          icon="▦"
          onClick={() => navigate('/tickets')}
        />
        <NavCard
          title="Decisions"
          desc="Architecture & approach calls we've made."
          icon="◈"
          onClick={() => navigate('/decisions')}
        />
        <NavCard
          title="Resources & links"
          desc="Drive, decks & spreadsheets in one table."
          icon="↗"
          onClick={() => navigate('/resources')}
        />
        <NavCard
          title="Lint & clean-up"
          desc="Find orphans, broken links & stale entries."
          icon="✓"
          onClick={() => navigate('/lint')}
        />
        <NavCard
          title="Activity log"
          desc="What's been ingested and when."
          icon="☰"
          onClick={() => navigate('/log')}
        />
      </div>
      {extractPath && (
        <ExtractModal
          path={extractPath}
          kind="tickets"
          isOpen={!!extractPath}
          onOpenChange={(open) => {
            if (!open) setExtractPath('')
          }}
          onDone={() => {
            setExtractPath('')
            refreshTickets()
            navigate('/tickets')
          }}
        />
      )}
      {extractPaths.length > 0 && (
        <ExtractModal
          paths={extractPaths}
          kind="tickets"
          isOpen={extractPaths.length > 0}
          onOpenChange={(open) => {
            if (!open) setExtractPaths([])
          }}
          onDone={() => {
            setExtractPaths([])
            setSelectedSources(new Set())
            refreshTickets()
            navigate('/tickets')
          }}
        />
      )}
    </div>
  )
}

function StatCard({ label, value }: { label: string; value: number }) {
  return (
    <Card className="border border-default-100 bg-content1">
      <CardBody className="py-4">
        <div className="text-2xl font-semibold text-foreground">{value}</div>
        <div className="text-xs uppercase tracking-wide text-default-400">{label}</div>
      </CardBody>
    </Card>
  )
}

function NavCard({
  title,
  desc,
  icon,
  onClick,
}: {
  title: string
  desc: string
  icon: string
  onClick: () => void
}) {
  return (
    <Card isPressable onPress={onClick} className="border border-default-100 bg-content1 hover:bg-content2">
      <CardBody className="flex-row items-center gap-4 py-5">
        <div className="grid h-10 w-10 place-items-center rounded-lg bg-primary/15 text-primary-300">
          {icon}
        </div>
        <div>
          <div className="font-medium text-foreground">{title}</div>
          <div className="text-sm text-default-500">{desc}</div>
        </div>
      </CardBody>
    </Card>
  )
}
