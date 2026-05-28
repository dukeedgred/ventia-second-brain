import { useCallback, useEffect, useState } from 'react'
import { NavLink, useNavigate } from 'react-router-dom'
import {
  Button,
  Input,
  Kbd,
  Modal,
  ModalBody,
  ModalContent,
  ModalFooter,
  ModalHeader,
  Select,
  SelectItem,
  useDisclosure,
} from '@heroui/react'
import type { TreeNode } from '../types'
import { api } from '../api'
import { useNotes } from '../lib/notes'
import { useTheme } from '../lib/theme'
import { SyncStatus } from './SyncStatus'

const NAV = [
  { to: '/', label: 'Home', glyph: '⌂', end: true },
  { to: '/graph', label: 'Graph', glyph: '◉', end: false },
  { to: '/ask', label: 'Ask the Brain', glyph: '✦', end: false },
  { to: '/ingest', label: 'Ingest', glyph: '⊕', end: false },
  { to: '/tickets', label: 'Action Items', glyph: '▦', end: false },
  { to: '/decisions', label: 'Decisions', glyph: '◈', end: false },
  { to: '/docs', label: 'Docs', glyph: '▤', end: false },
  { to: '/resources', label: 'Resources', glyph: '↗', end: false },
  { to: '/lint', label: 'Lint & Clean-up', glyph: '✓', end: false },
  { to: '/log', label: 'Activity Log', glyph: '☰', end: false },
]

export function Sidebar({ onSearch }: { onSearch: () => void }) {
  const [tree, setTree] = useState<TreeNode[]>([])
  const { notes, refresh } = useNotes()
  const { theme, setTheme } = useTheme()
  const navigate = useNavigate()
  const { isOpen, onOpen, onOpenChange, onClose } = useDisclosure()

  const refreshTree = useCallback(() => {
    api.tree().then(setTree).catch(() => {})
  }, [])
  useEffect(() => {
    refreshTree()
  }, [refreshTree])

  const folders = Array.from(
    new Set(notes.map((n) => n.path.split('/').slice(0, -1).join('/')).filter(Boolean)),
  ).sort()

  return (
    <aside className="sidebar flex h-screen w-72 flex-col border-r border-default-100 bg-[#0b0b10]">
      <div className="flex items-center gap-2.5 px-4 py-4">
        <img src="/brain.svg" alt="" className="h-7 w-7" />
        <div className="leading-tight">
          <div className="text-sm font-semibold text-foreground">Ventia Second Brain</div>
          <div className="text-[11px] text-default-400">Indirect Procurement</div>
        </div>
      </div>

      <div className="px-3">
        <button
          onClick={onSearch}
          className="flex w-full items-center justify-between rounded-lg border border-default-100 bg-content1 px-3 py-2 text-sm text-default-400 transition-colors hover:bg-content2"
        >
          <span className="flex items-center gap-2">
            <span>⌕</span> Search…
          </span>
          <Kbd className="text-[10px]">Ctrl K</Kbd>
        </button>
        <Button
          fullWidth
          color="primary"
          variant="flat"
          size="sm"
          className="mt-2 justify-start"
          onPress={() => navigate('/tickets?add=ticket')}
        >
          ＋ Add action item
        </Button>
      </div>

      <nav className="mt-3 flex flex-col gap-0.5 px-3">
        {NAV.map((n) => (
          <NavLink
            key={n.to}
            to={n.to}
            end={n.end}
            className={({ isActive }) =>
              `flex items-center gap-2.5 rounded-lg px-3 py-2 text-sm transition-colors ${
                isActive ? 'bg-primary/20 text-primary-200' : 'text-default-600 hover:bg-content2'
              }`
            }
          >
            <span className="w-4 text-center opacity-80">{n.glyph}</span>
            {n.label}
          </NavLink>
        ))}
      </nav>

      <div className="mb-1 mt-5 flex items-center justify-between px-5">
        <span className="text-[11px] font-semibold uppercase tracking-wider text-default-400">
          Notes
        </span>
        <button
          onClick={onOpen}
          className="text-base leading-none text-default-400 transition-colors hover:text-primary-300"
          title="New note"
        >
          ＋
        </button>
      </div>

      <div className="flex-1 overflow-y-auto px-2 pb-6">
        <TreeView nodes={tree} depth={0} />
      </div>

      <div className="border-t border-default-100 p-3">
        <SyncStatus />
        <div className="flex gap-1 rounded-lg bg-content2 p-1">
          {(['obsidian', 'ventia'] as const).map((t) => (
            <button
              key={t}
              onClick={() => setTheme(t)}
              className={`flex-1 rounded-md py-1 text-xs font-medium transition-colors ${
                theme === t
                  ? 'bg-content1 text-foreground shadow-sm'
                  : 'text-default-500 hover:text-foreground'
              }`}
            >
              {t === 'obsidian' ? 'Obsidian' : 'Ventia'}
            </button>
          ))}
        </div>
      </div>

      <NewNoteModal
        isOpen={isOpen}
        onOpenChange={onOpenChange}
        folders={folders}
        onCreated={(path) => {
          refreshTree()
          refresh()
          onClose()
          navigate(`/note/${encodeURIComponent(path)}`)
        }}
      />
    </aside>
  )
}

function TreeView({ nodes, depth }: { nodes: TreeNode[]; depth: number }) {
  return (
    <ul>
      {nodes.map((n) => (
        <TreeItem key={n.path} node={n} depth={depth} />
      ))}
    </ul>
  )
}

function TreeItem({ node, depth }: { node: TreeNode; depth: number }) {
  const [open, setOpen] = useState(true)
  const pad = { paddingLeft: `${depth * 12 + 10}px` }

  if (node.type === 'dir') {
    return (
      <li>
        <button
          onClick={() => setOpen((o) => !o)}
          style={pad}
          className="flex w-full items-center gap-1.5 rounded-md py-1 pr-2 text-left text-sm font-medium text-default-500 hover:bg-content2"
        >
          <span className="text-[10px] opacity-70">{open ? '▾' : '▸'}</span>
          <span className="truncate">{node.name}</span>
        </button>
        {open && node.children && <TreeView nodes={node.children} depth={depth + 1} />}
      </li>
    )
  }

  return (
    <li>
      <NavLink
        to={`/note/${encodeURIComponent(node.path)}`}
        style={pad}
        className={({ isActive }) =>
          `flex items-center gap-1.5 rounded-md py-1 pr-2 text-sm transition-colors ${
            isActive ? 'bg-primary/20 text-primary-200' : 'text-default-600 hover:bg-content2'
          }`
        }
      >
        <span className="text-[10px] opacity-40">•</span>
        <span className="truncate">{node.name}</span>
      </NavLink>
    </li>
  )
}

function NewNoteModal({
  isOpen,
  onOpenChange,
  folders,
  onCreated,
}: {
  isOpen: boolean
  onOpenChange: (open: boolean) => void
  folders: string[]
  onCreated: (path: string) => void
}) {
  const [title, setTitle] = useState('')
  const [folder, setFolder] = useState('wiki/Ventia')
  const [busy, setBusy] = useState(false)
  const [err, setErr] = useState('')

  const options = folders.length ? folders : ['wiki/Ventia', 'raw']

  const create = async () => {
    const name = title.trim()
    if (!name) return
    setBusy(true)
    setErr('')
    const today = new Date().toISOString().slice(0, 10)
    const path = `${folder.replace(/\/+$/, '')}/${name}.md`
    const template = `---\ntype: concept\ntopic: Ventia\nsources: []\ndate-created: ${today}\ndate-updated: ${today}\ntags: []\n---\n\n# ${name}\n\n`
    try {
      await api.createNote(path, template)
      setTitle('')
      onCreated(path)
    } catch (e) {
      setErr((e as Error).message)
    } finally {
      setBusy(false)
    }
  }

  return (
    <Modal isOpen={isOpen} onOpenChange={onOpenChange} backdrop="blur">
      <ModalContent className="bg-content1">
        {(close) => (
          <>
            <ModalHeader>New note</ModalHeader>
            <ModalBody>
              <Select
                label="Folder"
                variant="bordered"
                selectedKeys={new Set([folder])}
                onSelectionChange={(keys) => {
                  const k = Array.from(keys as Set<string>)[0]
                  if (k) setFolder(k)
                }}
              >
                {options.map((f) => (
                  <SelectItem key={f}>{f}</SelectItem>
                ))}
              </Select>
              <Input
                label="Title"
                value={title}
                onValueChange={setTitle}
                variant="bordered"
                placeholder="e.g. Supplier Consolidation"
                autoFocus
                onKeyDown={(e) => {
                  if (e.key === 'Enter') create()
                }}
              />
              {err && <p className="text-sm text-danger">{err}</p>}
            </ModalBody>
            <ModalFooter>
              <Button variant="light" onPress={close}>
                Cancel
              </Button>
              <Button color="primary" isLoading={busy} isDisabled={!title.trim()} onPress={create}>
                Create
              </Button>
            </ModalFooter>
          </>
        )}
      </ModalContent>
    </Modal>
  )
}
