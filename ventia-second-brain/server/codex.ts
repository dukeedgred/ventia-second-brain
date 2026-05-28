import spawn from 'cross-spawn'
import { promises as fs } from 'node:fs'
import os from 'node:os'
import path from 'node:path'
import { randomUUID } from 'node:crypto'
import { CONTENT_DIR } from './content'
import type { BrainEvent } from './brain'

type CodexSandbox = 'read-only' | 'workspace-write'

type CodexRunOptions = {
  sandbox: CodexSandbox
  onEvent?: (e: BrainEvent) => void
}

type CodexRunResult = {
  text: string
  durationMs?: number
}

function asRecord(v: unknown): Record<string, unknown> | undefined {
  return v && typeof v === 'object' && !Array.isArray(v) ? (v as Record<string, unknown>) : undefined
}

function getString(obj: Record<string, unknown>, keys: string[]): string | undefined {
  let cur: unknown = obj
  for (const key of keys) {
    const rec = asRecord(cur)
    if (!rec) return undefined
    cur = rec[key]
  }
  return typeof cur === 'string' ? cur : undefined
}

function toolName(obj: Record<string, unknown>): string | undefined {
  const item = asRecord(obj.item)
  const candidate =
    getString(obj, ['name']) ||
    getString(obj, ['tool']) ||
    getString(obj, ['call', 'name']) ||
    (item &&
      (getString(item, ['name']) ||
        getString(item, ['tool']) ||
        getString(item, ['type']) ||
        getString(item, ['command'])))
  return candidate && candidate !== 'agent_message' ? candidate : undefined
}

function messageText(obj: Record<string, unknown>): string | undefined {
  const item = asRecord(obj.item)
  return (
    getString(obj, ['delta']) ||
    getString(obj, ['text']) ||
    getString(obj, ['message', 'content']) ||
    getString(obj, ['message', 'text']) ||
    (item && (getString(item, ['text']) || getString(item, ['message', 'content'])))
  )
}

function isAgentMessage(obj: Record<string, unknown>): boolean {
  const type = getString(obj, ['type'])
  const itemType = getString(obj, ['item', 'type'])
  return (
    type === 'agent_message' ||
    type === 'agent_message_delta' ||
    itemType === 'agent_message' ||
    itemType === 'message'
  )
}

function isToolEvent(obj: Record<string, unknown>): boolean {
  const type = getString(obj, ['type']) || ''
  const itemType = getString(obj, ['item', 'type']) || ''
  return type.includes('tool') || type.includes('exec') || itemType.includes('tool') || itemType.includes('exec')
}

function modelArgs(): string[] {
  const args: string[] = []
  const model = process.env.BRAIN_CODEX_MODEL || process.env.BRAIN_MODEL
  const profile = process.env.BRAIN_CODEX_PROFILE
  if (model) args.push('--model', model)
  if (profile) args.push('--profile', profile)
  return args
}

/**
 * Run the local Codex CLI in non-interactive JSON mode. The prompt is sent on
 * stdin to avoid Windows command-line length limits for large notes.
 */
export function runCodex(prompt: string, options: CodexRunOptions): Promise<CodexRunResult> {
  return new Promise((resolve) => {
    const started = Date.now()
    const outputPath = path.join(os.tmpdir(), `second-brain-codex-${randomUUID()}.md`)
    const args = [
      '--ask-for-approval',
      'never',
      'exec',
      '--json',
      '--color',
      'never',
      '--sandbox',
      options.sandbox,
      '-C',
      CONTENT_DIR,
      '-o',
      outputPath,
      ...modelArgs(),
      '-',
    ]

    const child = spawn('codex', args, { cwd: CONTENT_DIR, env: process.env })
    child.stdin?.end(prompt)

    let buf = ''
    let streamedText = ''
    let finalText = ''
    let launchError = ''

    child.stdout?.on('data', (chunk: Buffer) => {
      buf += chunk.toString('utf8')
      let nl: number
      while ((nl = buf.indexOf('\n')) >= 0) {
        const line = buf.slice(0, nl).trim()
        buf = buf.slice(nl + 1)
        if (!line) continue
        let parsed: unknown
        try {
          parsed = JSON.parse(line)
        } catch {
          continue
        }
        const obj = asRecord(parsed)
        if (!obj) continue

        if (isToolEvent(obj)) {
          const name = toolName(obj)
          if (name) options.onEvent?.({ type: 'tool', tool: name })
        }

        if (isAgentMessage(obj)) {
          const text = messageText(obj)
          if (!text) continue
          if (getString(obj, ['type']) === 'agent_message_delta') {
            streamedText += text
            options.onEvent?.({ type: 'delta', text })
          } else {
            finalText = text
            if (!streamedText) {
              streamedText = text
              options.onEvent?.({ type: 'delta', text })
            }
          }
        }
      }
    })

    child.stderr?.on('data', (chunk: Buffer) => {
      const text = chunk.toString('utf8')
      if (/error|failed|not recognized|not found/i.test(text)) launchError += text
    })

    child.on('error', (err: Error) => {
      options.onEvent?.({
        type: 'error',
        text: `Failed to launch Codex CLI: ${err.message}. Is the 'codex' CLI installed and on PATH?`,
      })
      resolve({ text: '', durationMs: Date.now() - started })
    })

    child.on('close', async (code: number | null) => {
      try {
        const output = await fs.readFile(outputPath, 'utf8')
        if (output.trim()) finalText = output.trim()
      } catch {
        /* Codex may fail before writing the output file. */
      } finally {
        await fs.rm(outputPath, { force: true }).catch(() => {})
      }

      const text = (finalText || streamedText).trim()
      if (!text && launchError.trim()) {
        options.onEvent?.({ type: 'error', text: launchError.trim() })
      } else if (!text) {
        options.onEvent?.({
          type: 'error',
          text: `Codex CLI exited (code ${code ?? '?'}) without producing an answer.`,
        })
      }
      resolve({ text, durationMs: Date.now() - started })
    })
  })
}
