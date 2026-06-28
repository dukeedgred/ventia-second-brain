import { readNote } from './content'
import { runCodex } from './codex'

type Kind = 'tickets' | 'decisions'

const GUIDANCE: Record<Kind, string> = {
  tickets:
    'You extract concrete action items / tasks from a meeting note and turn them into tickets. ' +
    'Only include real, actionable items explicitly stated or clearly implied. If there are none, return an empty list. ' +
    'Return JSON of this exact shape: {"items":[{"title": "<short imperative title>", "description": "<1-2 sentences>", "priority": "low"|"medium"|"high", "assignee": "<person/role named, else Unassigned>"}]}',
  decisions:
    'You extract notable decisions — especially architecture/approach decisions — that the team committed to in a meeting note. ' +
    'Only include real decisions stated or clearly implied. If there are none, return an empty list. ' +
    'Return JSON of this exact shape: {"items":[{"title": "<short decision title>", "context": "<why it came up>", "decision": "<what was decided>", "consequences": "<implications/trade-offs>", "status": "proposed"|"accepted"}]}',
}

/** Strip code fences and isolate the JSON object, then parse the items array. */
function parseItems(text: string): unknown[] {
  let t = text.trim()
  t = t.replace(/^```(?:json)?/i, '').replace(/```$/g, '').trim()
  const start = t.indexOf('{')
  const end = t.lastIndexOf('}')
  if (start >= 0 && end > start) t = t.slice(start, end + 1)
  try {
    const obj = JSON.parse(t)
    if (Array.isArray(obj?.items)) return obj.items
    if (Array.isArray(obj)) return obj
    return []
  } catch {
    return []
  }
}

/**
 * Use local Codex (headless) to read a note and propose tickets or
 * decisions. The note content is embedded in the prompt, so no tools are needed.
 */
export async function extractFromNote(notePath: string, kind: Kind): Promise<{ items: unknown[] }> {
  const note = await readNote(notePath)
  const prompt =
    `${GUIDANCE[kind]}\n\nRespond with ONLY the JSON object — no prose, no code fences.\n\n` +
    `--- NOTE: ${note.name} ---\n${note.content}`

  const { text } = await runCodex(prompt, { sandbox: 'read-only' })
  return { items: parseItems(text) }
}

export async function extractTodosFromNotes(notePaths: string[]): Promise<{ items: unknown[] }> {
  const paths = Array.from(new Set(notePaths.map((p) => p.trim()).filter(Boolean))).slice(0, 12)
  if (paths.length < 2) throw new Error('Select at least two notes')

  const notes = await Promise.all(paths.map((p) => readNote(p)))
  const prompt = [
    'You extract and rank concrete to-dos across multiple meeting notes.',
    'Prioritise items that recur across notes, unblock other work, mention owners, mention dates, or are framed as risks/dependencies.',
    'Merge duplicates into one stronger to-do. Do not invent work that is not explicitly stated or clearly implied.',
    'Set relevance to "high" when the item appears in 2+ notes or is a blocker/risk/dependency; "medium" for a single clear owner/date/action; "low" for a useful but weaker follow-up.',
    'Return JSON of this exact shape:',
    '{"items":[{"title":"<short imperative title>","description":"<1-2 sentences, include why it matters>","priority":"low|medium|high","assignee":"<person/role named, else Unassigned>","relevance":"low|medium|high","evidence":"<short evidence summary, including recurrence if applicable>","sources":["<exact note path>", "..."]}]}',
    '',
    'Respond with ONLY the JSON object. No prose. No code fences.',
    '',
    ...notes.map((note) => `--- NOTE: ${note.path} ---\n${note.content}`),
  ].join('\n\n')

  const { text } = await runCodex(prompt, { sandbox: 'read-only' })
  return { items: parseItems(text) }
}
