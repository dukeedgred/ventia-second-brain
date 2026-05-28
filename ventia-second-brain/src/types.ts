export type TreeNode = {
  name: string
  path: string
  type: 'dir' | 'file'
  children?: TreeNode[]
}

export type NoteListItem = {
  path: string
  name: string
  type: string | null
  topic: string | null
}

export type Note = {
  path: string
  name: string
  frontmatter: Record<string, unknown>
  content: string
  raw: string
}

export type GraphNode = {
  id: string
  name: string
  type: string
  group: string
}

export type GraphLink = {
  source: string | GraphNode
  target: string | GraphNode
}

export type GraphData = {
  nodes: GraphNode[]
  links: GraphLink[]
}

export type SearchResult = {
  path: string
  name: string
  snippet: string
  titleMatch: boolean
}

export type BrainEvent =
  | { type: 'status'; text: string }
  | { type: 'tool'; tool: string; detail?: string }
  | { type: 'delta'; text: string }
  | { type: 'result'; text: string; costUsd?: number; durationMs?: number }
  | { type: 'error'; text: string }
  | { type: 'meta'; rawPath: string }
  | { type: 'done' }

/** One prior turn of an Ask conversation, sent back as history for follow-ups. */
export type AskTurn = { role: 'user' | 'assistant'; content: string }

export type Ticket = {
  path: string
  title: string
  body: string
  status: string
  priority: string
  assignee: string
  sources?: string[]
  'date-created'?: string
  'date-archived'?: string
}

export type Decision = {
  path: string
  title: string
  body: string
  status: string
  date?: string
  deciders?: string[]
  sources?: string[]
}

export type ResourcesTable = {
  columns: string[]
  rows: string[][]
}

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

export type DocStatus = {
  id: string
  title: string
  description: string
  path: string
  exists: boolean
  updated?: string
}
