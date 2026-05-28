import { useMemo, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { Button, Card, CardBody, Input } from '@heroui/react'
import { useNotes } from '../lib/notes'

const SUGGESTED = [
  'What is the ResMed Spend Cube and why are we building it?',
  'Which source systems feed the cube?',
  'How does the rules → ML → LLM classification cascade work?',
  'What are the biggest data-quality risks?',
]

const OVERVIEW_PATH = 'wiki/ResMed/ResMed Overview.md'

export default function HomePage() {
  const { notes } = useNotes()
  const navigate = useNavigate()
  const [q, setQ] = useState('')

  const stats = useMemo(() => {
    const wiki = notes.filter((n) => n.path.startsWith('wiki/')).length
    const raw = notes.filter((n) => n.path.startsWith('raw/')).length
    const topics = new Set(notes.map((n) => n.topic).filter(Boolean)).size
    return { total: notes.length, wiki, raw, topics }
  }, [notes])

  const ask = (question: string) => navigate(`/ask?q=${encodeURIComponent(question)}`)

  return (
    <div className="mx-auto max-w-4xl px-8 py-12">
      <div className="mb-2 flex items-center gap-2 text-sm text-primary-300">
        <span>✦</span>
        <span>ResMed · Indirect Procurement</span>
      </div>
      <h1 className="text-4xl font-semibold tracking-tight text-foreground">Second Brain</h1>
      <p className="mt-3 max-w-2xl text-default-500">
        The team's living knowledge base for the Spend Cube engagement — meeting notes, curated wiki
        pages, and an assistant that answers from everything we know. New here? Start with{' '}
        <button
          className="text-primary-300 underline-offset-2 hover:underline"
          onClick={() => navigate(`/note/${encodeURIComponent(OVERVIEW_PATH)}`)}
        >
          the ResMed Overview
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
