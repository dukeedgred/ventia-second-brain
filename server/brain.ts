import { runCodex } from './codex'

export type BrainEvent =
  | { type: 'status'; text: string }
  | { type: 'tool'; tool: string; detail?: string }
  | { type: 'delta'; text: string }
  | { type: 'result'; text: string; costUsd?: number; durationMs?: number }
  | { type: 'error'; text: string }
  | { type: 'meta'; rawPath: string }
  | { type: 'done' }

const SYSTEM_PROMPT = [
  'You are the "Ventia Second Brain", an assistant for a consulting team working on',
  "Ventia's Indirect Procurement — Spend Cube engagement.",
  '',
  'Answer using ONLY the markdown knowledge base in the current working directory.',
  'Find the answer with as few file reads as possible, in this order:',
  '1. ALWAYS read index.md first — it is the map of the knowledge base (every curated page with a one-line summary).',
  '2. From the index, pick the few pages most likely to hold the answer and open only those. Follow a [[wikilink]] to another page only when you actually need it.',
  '3. Use Grep/Glob to search more widely ONLY if the index does not lead you to the answer.',
  '4. Prefer curated wiki/ pages over raw/ notes; open a raw/ note only to confirm a source or when the wiki genuinely lacks the detail. For "what happened / when" questions, check log.md.',
  '',
  'Write concise, accurate answers aimed at a junior team member, formatted in markdown.',
  'End every answer with a "Sources:" line that links the notes you used as wikilinks, e.g. Sources: [[Source Systems]], [[Classification Approach]].',
  'If the knowledge base does not cover the question, say so plainly instead of inventing facts.',
].join('\n')

/**
 * Ask local Codex CLI (headless) a question about the knowledge base.
 * Runs Codex in a read-only sandbox inside CONTENT_DIR and streams token deltas,
 * tool notifications, and the final result back via onEvent.
 */
export type AskTurn = { role: 'user' | 'assistant'; content: string }

export function askBrainCli(
  question: string,
  history: AskTurn[],
  onEvent: (e: BrainEvent) => void,
): Promise<void> {
  return new Promise((resolve) => {
    const convo = history
      .filter((h) => h.content.trim())
      .slice(-6)
      .map((h) => `${h.role === 'user' ? 'User' : 'Assistant'}: ${h.content}`)
      .join('\n\n')
    const promptText = convo
      ? `Here is our conversation so far:\n\n${convo}\n\nContinue the conversation and answer this follow-up, using the knowledge base as instructed.\n\nUser: ${question}`
      : question
    const prompt = `${SYSTEM_PROMPT}\n\n${promptText}`
    runCodex(prompt, { sandbox: 'read-only', onEvent }).then(({ text, durationMs }) => {
      if (text) {
        onEvent({ type: 'result', text, durationMs })
      }
      resolve()
    })
  })
}
