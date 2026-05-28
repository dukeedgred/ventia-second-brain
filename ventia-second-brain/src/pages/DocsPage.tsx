import { Link, useNavigate } from 'react-router-dom'
import { Button, Spinner } from '@heroui/react'
import { Markdown } from '../lib/markdown'
import { useDocs } from '../lib/docs'
import type { DocStatus } from '../types'

export default function DocsPage() {
  const { docs, activeId, running, steps, body, error, done, generate, stop } = useDocs()
  const navigate = useNavigate()

  return (
    <div className="mx-auto max-w-3xl px-8 py-10">
      <div className="mb-6">
        <h1 className="flex items-center gap-2 text-2xl font-semibold text-foreground">
          <span className="text-primary-400">▤</span> Docs
        </h1>
        <p className="text-sm text-default-400">
          Living documents synthesised from the knowledge base — generate one, regenerate it as the
          base grows. Each is a normal note you can open, edit, and trace.
        </p>
      </div>

      <div className="flex flex-col gap-4">
        {docs.length === 0 && <p className="text-sm text-default-400">Loading…</p>}
        {docs.map((d) => (
          <DocCard
            key={d.id}
            doc={d}
            active={activeId === d.id}
            running={running}
            steps={steps}
            body={body}
            error={error}
            done={done}
            onView={() => navigate(`/note/${encodeURIComponent(d.path)}`)}
            onGenerate={() => {
              if (
                d.exists &&
                !window.confirm(
                  `Regenerate "${d.title}"? This overwrites the current version (you can revert via git).`,
                )
              )
                return
              generate(d.id)
            }}
            onStop={stop}
          />
        ))}
      </div>
    </div>
  )
}

function DocCard({
  doc,
  active,
  running,
  steps,
  body,
  error,
  done,
  onView,
  onGenerate,
  onStop,
}: {
  doc: DocStatus
  active: boolean
  running: boolean
  steps: string[]
  body: string
  error: string
  done: boolean
  onView: () => void
  onGenerate: () => void
  onStop: () => void
}) {
  const isRunning = active && running
  return (
    <div className="rounded-xl border border-default-100 bg-content1 p-5">
      <div className="flex items-start justify-between gap-3">
        <div className="min-w-0">
          <div className="flex flex-wrap items-center gap-2">
            {doc.exists ? (
              <Link
                to={`/note/${encodeURIComponent(doc.path)}`}
                className="text-lg font-medium text-foreground hover:text-primary-300"
              >
                {doc.title}
              </Link>
            ) : (
              <span className="text-lg font-medium text-foreground">{doc.title}</span>
            )}
            {doc.exists && doc.updated && (
              <span className="text-xs text-default-400">updated {doc.updated}</span>
            )}
            {!doc.exists && <span className="text-xs text-default-400">not generated yet</span>}
          </div>
          <p className="mt-0.5 text-sm text-default-500">{doc.description}</p>
        </div>
        <div className="flex shrink-0 gap-2">
          {doc.exists && !isRunning && (
            <Button size="sm" variant="flat" onPress={onView}>
              View
            </Button>
          )}
          {isRunning ? (
            <Button size="sm" color="danger" variant="flat" onPress={onStop}>
              Stop
            </Button>
          ) : (
            <Button size="sm" color="primary" variant="flat" onPress={onGenerate}>
              {doc.exists ? 'Regenerate' : 'Generate'}
            </Button>
          )}
        </div>
      </div>

      {active && (steps.length > 0 || isRunning || body || error || done) && (
        <div className="mt-4 border-t border-default-100 pt-4">
          {steps.length > 0 && (
            <div className="mb-2 flex flex-col gap-1">
              {steps.map((s, i) => (
                <div key={i} className="flex items-center gap-2 text-sm text-default-500">
                  <span className="text-primary-400">⌕</span> {s}
                </div>
              ))}
            </div>
          )}
          {isRunning && !body && (
            <div className="flex items-center gap-2 text-sm text-default-400">
              <Spinner size="sm" /> Synthesising…
            </div>
          )}
          {body && (
            <div className="mt-2 max-h-[420px] overflow-y-auto rounded-lg bg-content2/40 px-4 py-3">
              <Markdown content={body} />
            </div>
          )}
          {error && <p className="mt-2 text-sm text-danger">{error}</p>}
          {done && !error && <p className="mt-2 text-sm text-success">✓ Saved.</p>}
        </div>
      )}
    </div>
  )
}
