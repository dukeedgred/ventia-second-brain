import { useEffect, useState } from 'react'
import type { ReactNode } from 'react'
import { Link, useNavigate, useParams } from 'react-router-dom'
import { Button, Chip, Spinner, Textarea } from '@heroui/react'
import type { GraphData, Note } from '../types'
import { api } from '../api'
import { Markdown } from '../lib/markdown'
import { useNotes } from '../lib/notes'
import { ExtractModal } from '../components/ExtractModal'

export default function NotePage() {
  const { enc } = useParams()
  const path = enc ? decodeURIComponent(enc) : ''
  const navigate = useNavigate()
  const { refresh } = useNotes()

  const [note, setNote] = useState<Note | null>(null)
  const [error, setError] = useState('')
  const [editing, setEditing] = useState(false)
  const [draft, setDraft] = useState('')
  const [saving, setSaving] = useState(false)
  const [backlinks, setBacklinks] = useState<{ path: string; name: string }[]>([])
  const [extractKind, setExtractKind] = useState<'tickets' | 'decisions' | null>(null)

  useEffect(() => {
    setNote(null)
    setError('')
    setEditing(false)
    api
      .note(path)
      .then((n) => {
        setNote(n)
        setDraft(n.raw)
      })
      .catch((e) => setError(e.message))
  }, [path])

  useEffect(() => {
    api
      .graph()
      .then((g: GraphData) => {
        const names = new Map(g.nodes.map((n) => [n.id, n.name]))
        const seen = new Set<string>()
        const back = g.links
          .map((l) => ({
            source: typeof l.source === 'string' ? l.source : l.source.id,
            target: typeof l.target === 'string' ? l.target : l.target.id,
          }))
          .filter((l) => l.target === path && l.source !== path)
          .map((l) => ({ path: l.source, name: names.get(l.source) ?? l.source }))
          .filter((b) => (seen.has(b.path) ? false : (seen.add(b.path), true)))
        setBacklinks(back)
      })
      .catch(() => setBacklinks([]))
  }, [path])

  const fm = note?.frontmatter ?? {}
  const tags = Array.isArray(fm.tags) ? (fm.tags as string[]) : []

  const save = async () => {
    setSaving(true)
    try {
      const updated = await api.saveNote(path, draft)
      setNote(updated)
      setEditing(false)
      refresh()
    } catch (e) {
      setError((e as Error).message)
    } finally {
      setSaving(false)
    }
  }

  const del = async () => {
    if (!window.confirm(`Delete "${note?.name}"? This removes the markdown file.`)) return
    await api.deleteNote(path)
    refresh()
    navigate('/')
  }

  if (error) return <Centered><p className="text-danger">{error}</p></Centered>
  if (!note) return <Centered><Spinner /></Centered>

  const crumbs = path.split('/')

  return (
    <div className="mx-auto max-w-3xl px-8 py-10">
      <div className="mb-4 flex items-center justify-between gap-3">
        <div className="flex flex-wrap items-center gap-1 text-xs text-default-400">
          {crumbs.map((c, i) => (
            <span key={i}>
              {c.replace(/\.md$/, '')}
              {i < crumbs.length - 1 && <span className="mx-1 opacity-50">/</span>}
            </span>
          ))}
        </div>
        <div className="flex shrink-0 gap-2">
          {!editing && (
            <>
              <Button size="sm" variant="flat" onPress={() => setExtractKind('tickets')}>
                ✦ Extract tickets
              </Button>
              <Button size="sm" variant="flat" onPress={() => setExtractKind('decisions')}>
                ✦ Extract decisions
              </Button>
              <Button
                size="sm"
                variant="flat"
                onPress={() => {
                  setDraft(note.raw)
                  setEditing(true)
                }}
              >
                Edit
              </Button>
            </>
          )}
          {editing && (
            <>
              <Button size="sm" variant="light" onPress={() => setEditing(false)}>
                Cancel
              </Button>
              <Button size="sm" color="danger" variant="flat" onPress={del}>
                Delete
              </Button>
              <Button size="sm" color="primary" isLoading={saving} onPress={save}>
                Save
              </Button>
            </>
          )}
        </div>
      </div>

      <h1 className="mb-3 text-3xl font-semibold tracking-tight text-foreground">{note.name}</h1>

      {!editing && (
        <div className="mb-6 flex flex-wrap items-center gap-2">
          {typeof fm.type === 'string' && (
            <Chip size="sm" color="primary" variant="flat">
              {fm.type}
            </Chip>
          )}
          {typeof fm.topic === 'string' && (
            <Chip size="sm" variant="flat">
              {fm.topic}
            </Chip>
          )}
          {typeof fm['date-updated'] === 'string' && (
            <span className="text-xs text-default-400">updated {fmtDate(fm['date-updated'])}</span>
          )}
          {tags.map((t) => (
            <Chip key={t} size="sm" variant="dot" className="text-default-500">
              {t}
            </Chip>
          ))}
        </div>
      )}

      {editing ? (
        <Textarea
          value={draft}
          onValueChange={setDraft}
          minRows={24}
          variant="bordered"
          classNames={{ input: 'font-mono text-sm leading-relaxed' }}
        />
      ) : (
        <Markdown content={note.content} />
      )}

      {!editing && backlinks.length > 0 && (
        <div className="mt-12 border-t border-default-100 pt-5">
          <div className="mb-2 text-xs font-semibold uppercase tracking-wide text-default-400">
            Linked references
          </div>
          <div className="flex flex-wrap gap-2">
            {backlinks.map((b) => (
              <Link
                key={b.path}
                to={`/note/${encodeURIComponent(b.path)}`}
                className="rounded-md bg-content2 px-2.5 py-1 text-sm text-default-600 transition-colors hover:bg-content3 hover:text-foreground"
              >
                {b.name}
              </Link>
            ))}
          </div>
        </div>
      )}

      {extractKind && (
        <ExtractModal
          path={path}
          kind={extractKind}
          isOpen={!!extractKind}
          onOpenChange={(o) => {
            if (!o) setExtractKind(null)
          }}
          onDone={() => {
            const k = extractKind
            setExtractKind(null)
            if (k) navigate(`/${k}`)
          }}
        />
      )}
    </div>
  )
}

function Centered({ children }: { children: ReactNode }) {
  return <div className="grid h-full place-items-center">{children}</div>
}

/** YAML often parses dates into ISO strings; show just the date part. */
function fmtDate(v: unknown): string {
  const s = String(v)
  const m = s.match(/^\d{4}-\d{2}-\d{2}/)
  return m ? m[0] : s
}
