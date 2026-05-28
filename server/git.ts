import spawn from 'cross-spawn'
import path from 'node:path'
import { CONTENT_DIR } from './content'

// ---- config ---------------------------------------------------------------
// Local auto-commit is on by default; remote sync is OFF until explicitly
// enabled so merely running the server never pushes to the shared repo.
const COMMIT_ENABLED = !/^(0|false|off|no)$/i.test(process.env.BRAIN_AUTOCOMMIT ?? '')
const SYNC_ENABLED = /^(1|true|on|yes)$/i.test(process.env.BRAIN_GIT_SYNC ?? '')
const NET_TIMEOUT = Number(process.env.BRAIN_GIT_TIMEOUT_MS) || 20000

// ---- low-level git runner -------------------------------------------------
/** Run a git command non-interactively; resolves with {code, stdout, stderr}. Never rejects. */
function git(
  args: string[],
  cwd: string,
  opts: { timeout?: number } = {},
): Promise<{ code: number; stdout: string; stderr: string }> {
  return new Promise((resolve) => {
    // GIT_TERMINAL_PROMPT=0 => a missing credential fails fast instead of hanging the server.
    const child = spawn('git', args, {
      cwd,
      env: { ...process.env, GIT_TERMINAL_PROMPT: '0' },
    })
    let stdout = ''
    let stderr = ''
    let timer: ReturnType<typeof setTimeout> | undefined
    if (opts.timeout) {
      timer = setTimeout(() => {
        try {
          child.kill()
        } catch {
          /* ignore */
        }
        resolve({ code: -1, stdout, stderr: `${stderr}\n[timed out after ${opts.timeout}ms]` })
      }, opts.timeout)
    }
    child.stdout?.on('data', (d: Buffer) => (stdout += d.toString('utf8')))
    child.stderr?.on('data', (d: Buffer) => (stderr += d.toString('utf8')))
    child.on('error', (err: Error) => {
      if (timer) clearTimeout(timer)
      resolve({ code: -1, stdout, stderr: stderr || err.message })
    })
    child.on('close', (code: number | null) => {
      if (timer) clearTimeout(timer)
      resolve({ code: code ?? -1, stdout, stderr })
    })
  })
}

// ---- one-time repo discovery ----------------------------------------------
type Repo = { root: string; scope: string; remote?: string; branch?: string }
let initPromise: Promise<Repo | null> | null = null

function init(): Promise<Repo | null> {
  if (!initPromise) {
    initPromise = (async () => {
      if (!COMMIT_ENABLED) {
        console.log('[second-brain] git auto-commit disabled (BRAIN_AUTOCOMMIT)')
        return null
      }
      const top = await git(['rev-parse', '--show-toplevel'], CONTENT_DIR)
      if (top.code !== 0) {
        console.log('[second-brain] git auto-commit off: content dir is not in a git repo')
        return null
      }
      const root = top.stdout.trim()
      const scope = path.relative(root, CONTENT_DIR).replace(/\\/g, '/') || '.'
      if (scope.startsWith('..')) {
        console.log('[second-brain] git auto-commit off: content dir is outside the repo')
        return null
      }
      const repo: Repo = { root, scope }
      if (SYNC_ENABLED) {
        // Resolve the current branch's upstream (e.g. "origin/main").
        const up = await git(['rev-parse', '--abbrev-ref', '--symbolic-full-name', '@{u}'], root)
        if (up.code === 0 && up.stdout.trim().includes('/')) {
          const s = up.stdout.trim()
          const i = s.indexOf('/')
          repo.remote = s.slice(0, i)
          repo.branch = s.slice(i + 1)
          console.log(`[second-brain] git sync on (${repo.remote}/${repo.branch})`)
        } else {
          console.log('[second-brain] git sync requested but no upstream branch is set; sync off')
        }
      }
      console.log(`[second-brain] git auto-commit on (scope: ${scope})`)
      return repo
    })()
  }
  return initPromise
}

// ---- serial queue (commit/pull/push never interleave on the index) --------
let queue: Promise<unknown> = Promise.resolve()
function enqueue<T>(task: () => Promise<T>): Promise<T> {
  const next = queue.then(task, task)
  queue = next.catch(() => {})
  return next
}

// ---- sync status (surfaced to the UI) -------------------------------------
export type SyncState = 'disabled' | 'idle' | 'syncing' | 'ok' | 'offline' | 'conflict' | 'error'
export type SyncStatus = {
  enabled: boolean
  remote?: string
  branch?: string
  state: SyncState
  ahead: number
  behind: number
  lastSyncOk?: number
  message?: string
}
const status: SyncStatus = { enabled: false, state: 'disabled', ahead: 0, behind: 0 }

export function getSyncStatus(): SyncStatus {
  return { ...status }
}

async function updateCounts(repo: Repo) {
  if (!repo.remote || !repo.branch) return
  const r = await git(
    ['rev-list', '--left-right', '--count', `${repo.remote}/${repo.branch}...HEAD`],
    repo.root,
  )
  if (r.code === 0) {
    const [behind, ahead] = r.stdout.trim().split(/\s+/).map((n) => Number(n) || 0)
    status.behind = behind ?? 0
    status.ahead = ahead ?? 0
  }
}

// ---- commit ---------------------------------------------------------------
export type CommitResult = { committed: boolean; hash?: string; error?: string }

async function doCommit(message: string): Promise<CommitResult> {
  const repo = await init()
  if (!repo) return { committed: false }
  try {
    const st = await git(['status', '--porcelain', '--', repo.scope], repo.root)
    if (st.code !== 0) return { committed: false, error: st.stderr.trim() }
    if (!st.stdout.trim()) return { committed: false }

    const add = await git(['add', '-A', '--', repo.scope], repo.root)
    if (add.code !== 0) return { committed: false, error: add.stderr.trim() }

    const commit = await git(['commit', '-m', message, '--', repo.scope], repo.root)
    if (commit.code !== 0) {
      console.warn(`[second-brain] git commit failed: ${commit.stderr.trim() || commit.stdout.trim()}`)
      return { committed: false, error: commit.stderr.trim() }
    }
    const rev = await git(['rev-parse', '--short', 'HEAD'], repo.root)
    const hash = rev.code === 0 ? rev.stdout.trim() : undefined
    console.log(`[second-brain] committed ${hash ?? '?'} — ${message}`)
    return { committed: true, hash }
  } catch (e) {
    console.warn(`[second-brain] git auto-commit error: ${(e as Error).message}`)
    return { committed: false, error: (e as Error).message }
  }
}

/**
 * Stage + commit changes under content/ as one commit (best-effort, never
 * throws, no-ops when nothing changed). When sync is on, also schedules a
 * coalesced background push so the save returns without waiting on the network.
 */
export function commitContent(message: string): Promise<CommitResult> {
  return enqueue(async () => {
    const r = await doCommit(message)
    if (r.committed) schedulePush()
    return r
  })
}

// ---- pull (fetch + rebase, conflict-safe) ---------------------------------
async function doPull(repo: Repo): Promise<void> {
  if (!repo.remote || !repo.branch) return
  status.state = 'syncing'
  const fetch = await git(['fetch', repo.remote, repo.branch], repo.root, { timeout: NET_TIMEOUT })
  if (fetch.code !== 0) {
    status.state = 'offline'
    status.message = `fetch failed: ${oneLine(fetch.stderr)}`
    return
  }
  // Replay local commits on top of the remote. --autostash guards a write that
  // landed on disk but isn't committed yet. The union driver auto-resolves the
  // append-heavy files; a genuine same-line conflict aborts cleanly.
  const rebase = await git(['rebase', '--autostash', `${repo.remote}/${repo.branch}`], repo.root, {
    timeout: NET_TIMEOUT,
  })
  if (rebase.code !== 0) {
    await git(['rebase', '--abort'], repo.root)
    status.state = 'conflict'
    status.message = 'Sync conflict on a note — needs manual merge (your local copy is intact).'
    console.warn('[second-brain] sync: rebase conflict, aborted (local tree left clean)')
    return
  }
  status.state = 'ok'
  status.lastSyncOk = Date.now()
  status.message = undefined
  await updateCounts(repo)
}

// ---- push (pull-rebase, then push; retry on lost race) --------------------
async function doPush(repo: Repo): Promise<void> {
  if (!repo.remote || !repo.branch) return
  for (let attempt = 0; attempt < 3; attempt++) {
    await doPull(repo)
    if (status.state === 'conflict' || status.state === 'offline') return // can't push over these
    const push = await git(['push', repo.remote, `HEAD:${repo.branch}`], repo.root, {
      timeout: NET_TIMEOUT,
    })
    if (push.code === 0) {
      status.state = 'ok'
      status.lastSyncOk = Date.now()
      status.message = undefined
      await updateCounts(repo)
      return
    }
    if (/rejected|non-fast-forward|fetch first|behind/i.test(push.stderr)) {
      continue // someone pushed between our fetch and push — loop and re-integrate
    }
    status.state = 'error'
    status.message = `push failed: ${oneLine(push.stderr)}`
    console.warn(`[second-brain] git push failed: ${oneLine(push.stderr)}`)
    return
  }
  status.state = 'error'
  status.message = 'push: exceeded retries (remote kept moving)'
}

// Coalesce pushes: one pending push covers every commit made before it runs.
let pushPending = false
function schedulePush() {
  if (!SYNC_ENABLED || pushPending) return
  pushPending = true
  enqueue(async () => {
    pushPending = false
    const repo = await init()
    if (repo?.remote) await doPush(repo)
  })
}

/** Fetch + rebase the latest from the team (best-effort). Used before each AI call. */
export function syncPullNow(): Promise<SyncStatus> {
  return enqueue(async () => {
    const repo = await init()
    if (repo?.remote) await doPull(repo)
    return getSyncStatus()
  })
}

/** Manual "Sync now": pull the latest, then push anything local. */
export function forceSync(): Promise<SyncStatus> {
  return enqueue(async () => {
    const repo = await init()
    if (repo?.remote) await doPush(repo)
    return getSyncStatus()
  })
}

/** Initialise sync state at startup (and do a first pull if enabled). */
export async function initSync(): Promise<void> {
  const repo = await init()
  if (repo?.remote && repo.branch) {
    status.enabled = true
    status.remote = repo.remote
    status.branch = repo.branch
    status.state = 'idle'
    await syncPullNow()
  }
}

function oneLine(s: string): string {
  return s.replace(/\s+/g, ' ').trim().slice(0, 200)
}
