import { Button, Spinner } from '@heroui/react'
import { Markdown } from '../lib/markdown'
import { useLint } from '../lib/lint'

export default function LintPage() {
  const { running, mode, steps, summary, error, done, start, stop } = useLint()

  return (
    <div className="mx-auto max-w-3xl px-8 py-10">
      <h1 className="flex items-center gap-2 text-2xl font-semibold text-foreground">
        <span className="text-primary-400">✓</span> Lint &amp; clean-up
      </h1>
      <p className="mt-1 text-sm text-default-400">
        Audit the knowledge base for orphans, broken wikilinks, stale index entries, duplicates and
        frontmatter gaps — or let Codex clean them up.
      </p>

      <div className="mt-6 flex flex-wrap gap-2">
        <Button color="primary" isDisabled={running} onPress={() => start('audit')}>
          {running && mode === 'audit' ? 'Checking…' : 'Run health check'}
        </Button>
        <Button color="warning" variant="flat" isDisabled={running} onPress={() => start('fix')}>
          {running && mode === 'fix' ? 'Cleaning up…' : 'Run clean-up'}
        </Button>
        {running && (
          <Button color="danger" variant="light" onPress={stop}>
            Stop
          </Button>
        )}
      </div>
      <p className="mt-2 text-xs text-default-400">
        Health check is read-only. Clean-up edits files (and logs what it changed) — it never deletes
        unique content.
      </p>

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

      {done && !error && mode === 'fix' && (
        <div className="mt-4 text-sm text-success">
          ✓ Clean-up complete — changes written and logged to log.md.
        </div>
      )}
    </div>
  )
}
