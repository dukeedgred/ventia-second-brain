import { Link } from 'react-router-dom'
import { Button, Input, Spinner, Textarea } from '@heroui/react'
import { Markdown } from '../lib/markdown'
import { GraphView } from '../components/GraphView'
import { useIngest } from '../lib/ingest'

export default function IngestPage() {
  const {
    title,
    setTitle,
    content,
    setContent,
    running,
    steps,
    summary,
    error,
    rawPath,
    done,
    graph,
    newIds,
    start,
    stop,
  } = useIngest()

  return (
    <div className="flex h-full">
      {/* left: form + activity */}
      <div className="w-[44%] min-w-[380px] overflow-y-auto border-r border-default-100 px-7 py-8">
        <h1 className="flex items-center gap-2 text-2xl font-semibold text-foreground">
          <span className="text-primary-400">⊕</span> Ingest source material
        </h1>
        <p className="mt-1 text-sm text-default-400">
          Paste anything — meeting notes, a document, an article, a transcript — and local Codex
          distils it into wiki pages and updates the index &amp; log. Watch the graph grow on
          the right.
        </p>

        <div className="mt-6 flex flex-col gap-3">
          <Input
            label="Title (optional)"
            value={title}
            onValueChange={setTitle}
            variant="bordered"
            placeholder="e.g. Supplier Onboarding Workshop, Q2 Spend Report…"
            isDisabled={running}
          />
          <Textarea
            label="Source text"
            value={content}
            onValueChange={setContent}
            variant="bordered"
            minRows={8}
            placeholder="Paste notes, a document, an article, a transcript…"
            isDisabled={running}
          />
          <div className="flex gap-2">
            {running ? (
              <Button color="danger" variant="flat" onPress={stop}>
                Stop
              </Button>
            ) : (
              <Button color="primary" isDisabled={!content.trim()} onPress={start}>
                Ingest
              </Button>
            )}
          </div>
        </div>

        {(steps.length > 0 || running) && (
          <div className="mt-8">
            <div className="mb-2 text-xs font-semibold uppercase tracking-wide text-default-400">
              Activity
            </div>
            <div className="flex flex-col gap-1.5">
              {steps.map((s, i) => (
                <div key={i} className="flex items-center gap-2 text-sm text-default-500">
                  <span className="text-primary-400">{s.tool ? '⌕' : '•'}</span> {s.text}
                </div>
              ))}
              {running && (
                <div className="flex items-center gap-2 text-sm text-default-400">
                  <Spinner size="sm" /> Working…
                </div>
              )}
            </div>
          </div>
        )}

        {summary && (
          <div className="mt-6 rounded-2xl border border-default-100 bg-content1 px-5 py-3">
            <Markdown content={summary} />
          </div>
        )}

        {error && (
          <div className="mt-4 rounded-xl border border-danger/40 bg-danger/10 px-4 py-3 text-sm text-danger">
            {error}
          </div>
        )}

        {done && !error && (
          <div className="mt-6 flex flex-wrap items-center gap-3 rounded-xl border border-success/30 bg-success/10 px-4 py-3 text-sm">
            <span className="text-success">✓ Ingested.</span>
            {rawPath && (
              <Link to={`/note/${encodeURIComponent(rawPath)}`} className="text-primary-300 hover:underline">
                View source
              </Link>
            )}
            <Link to={`/note/${encodeURIComponent('index.md')}`} className="text-primary-300 hover:underline">
              View index
            </Link>
          </div>
        )}
      </div>

      {/* right: live graph */}
      <div className="relative flex-1">
        <div className="pointer-events-none absolute left-5 top-4 z-10">
          <div className="text-sm font-semibold text-foreground">
            Knowledge graph{' '}
            {running && <span className="text-primary-300">· updating live</span>}
          </div>
          <div className="text-xs text-default-400">
            {newIds.size > 0
              ? `${newIds.size} new / changed page${newIds.size > 1 ? 's' : ''} this ingest`
              : 'New pages light up as they appear'}
          </div>
        </div>
        {graph ? (
          <GraphView data={graph} highlightIds={newIds} />
        ) : (
          <div className="grid h-full place-items-center">
            <Spinner />
          </div>
        )}
      </div>
    </div>
  )
}
