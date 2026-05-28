import type { BrainEvent } from './brain'
import { runCodex } from './codex'

const AUDIT = [
  'You are running a READ-ONLY lint / health check on the "Ventia Second Brain" markdown knowledge base in the current working directory.',
  'Do NOT modify any files. Inspect with your read tools, then report.',
  'Check for: orphan wiki pages (no inbound [[wikilinks]] from any page or index.md); broken wikilinks ([[Target]] with no matching file);',
  'pages missing from index.md, or index.md rows pointing to non-existent pages; likely duplicate or overlapping pages;',
  'concepts referenced repeatedly but lacking their own page; frontmatter problems (missing type / topic / date-created / date-updated / tags;',
  'an overview page missing the "overview" tag); stale pages; and any contradictions between pages.',
  'Output a concise markdown report grouped by issue type, naming the file(s) for each item, and finish with a short "Suggested fixes" list.',
  'If the base is healthy, say so plainly.',
].join(' ')

const FIX = (today: string) =>
  [
    'You are CLEANING UP the "Ventia Second Brain" markdown knowledge base in the current working directory.',
    'First audit it, then FIX what is safe: add missing pages to index.md and remove index rows for files that no longer exist;',
    'fix or remove broken [[wikilinks]]; add clearly-missing cross-references between closely related pages (do NOT over-link);',
    'repair frontmatter (ensure type, topic: Ventia, date-created, date-updated, tags; overview pages tagged "overview");',
    'and merge obvious duplicates — prefer updating over deleting, and only delete a file if it is a clear duplicate with no unique content.',
    'Be conservative: never remove unique content; when unsure, leave it and mention it.',
    `After making changes, append exactly ONE entry to log.md in the form "## [${today}] lint | <one-line summary>".`,
    'Finish with a 2-4 sentence summary of what you changed and anything left for a human to review.',
  ].join(' ')

/**
 * Run a lint pass with local Codex. `audit` is read-only and reports
 * issues; `fix` repairs the safe ones and logs what changed. Streams progress.
 */
export function lint(mode: 'audit' | 'fix', onEvent: (e: BrainEvent) => void): Promise<void> {
  return new Promise((resolve) => {
    const today = new Date().toISOString().slice(0, 10)
    const system = mode === 'fix' ? FIX(today) : AUDIT
    const prompt =
      mode === 'fix'
        ? 'Run the clean-up now, following your instructions.'
        : 'Run the health check now, following your instructions.'

    runCodex(`${system}\n\n${prompt}`, {
      sandbox: mode === 'fix' ? 'workspace-write' : 'read-only',
      onEvent,
    }).then(({ text }) => {
      if (text) onEvent({ type: 'result', text })
      resolve()
    })
  })
}
