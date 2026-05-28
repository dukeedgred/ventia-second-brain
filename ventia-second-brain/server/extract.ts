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
