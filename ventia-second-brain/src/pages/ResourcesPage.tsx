import { useEffect, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { Button, Chip } from '@heroui/react'
import type { ResourcesTable } from '../types'
import { api } from '../api'

const SOURCE_PATH = 'resources.md'

type ChipColor = 'primary' | 'secondary' | 'success' | 'warning' | 'default'
const TYPE_COLOR: Record<string, ChipColor> = {
  drive: 'primary',
  presentation: 'warning',
  spreadsheet: 'success',
  doc: 'secondary',
  document: 'secondary',
  dashboard: 'secondary',
}

function prettyUrl(u: string): string {
  try {
    return new URL(u).hostname.replace(/^www\./, '')
  } catch {
    return u
  }
}

function ExternalLink({ href, label }: { href: string; label: string }) {
  return (
    <a
      href={href}
      target="_blank"
      rel="noreferrer"
      className="inline-flex items-center gap-1 text-primary-300 hover:underline"
    >
      {label}
      <span className="text-[10px] opacity-70">↗</span>
    </a>
  )
}

/** Render one table cell: links become anchors, a Type column becomes a chip. */
function Cell({ value, column }: { value: string; column: string }) {
  const v = value.trim()
  if (!v || v === '—' || v === '-') return <span className="text-default-300">—</span>

  const md = v.match(/^\[([^\]]+)\]\((https?:\/\/[^)]+)\)$/)
  if (md) return <ExternalLink href={md[2]} label={md[1]} />
  if (/^https?:\/\/\S+$/.test(v)) return <ExternalLink href={v} label={prettyUrl(v)} />

  if (column.trim().toLowerCase() === 'type') {
    return (
      <Chip size="sm" variant="flat" color={TYPE_COLOR[v.toLowerCase()] ?? 'default'}>
        {v}
      </Chip>
    )
  }
  return <span className="text-default-600">{v}</span>
}

export default function ResourcesPage() {
  const navigate = useNavigate()
  const [data, setData] = useState<ResourcesTable>({ columns: [], rows: [] })
  const [loading, setLoading] = useState(true)

  const refresh = () => {
    setLoading(true)
    api
      .resources()
      .then(setData)
      .catch(() => setData({ columns: [], rows: [] }))
      .finally(() => setLoading(false))
  }
  useEffect(() => {
    refresh()
  }, [])

  const hasRows = data.columns.length > 0 && data.rows.length > 0

  return (
    <div className="mx-auto max-w-5xl px-8 py-10">
      <div className="mb-6 flex flex-wrap items-center justify-between gap-3">
        <div>
          <h1 className="text-2xl font-semibold text-foreground">Resources &amp; Links</h1>
          <p className="text-sm text-default-400">
            Drive folders, decks &amp; spreadsheets for the engagement — populated by Codex
            from <code className="text-default-500">content/resources.md</code>.
          </p>
        </div>
        <div className="flex items-center gap-2">
          <Button
            size="sm"
            variant="flat"
            onPress={() => navigate(`/note/${encodeURIComponent(SOURCE_PATH)}`)}
          >
            Edit source
          </Button>
          <Button size="sm" variant="flat" onPress={refresh} isLoading={loading}>
            Refresh
          </Button>
        </div>
      </div>

      {hasRows ? (
        <div className="overflow-x-auto rounded-xl border border-default-100 bg-content1">
          <table className="w-full text-sm">
            <thead>
              <tr className="border-b border-default-100 text-left text-xs uppercase tracking-wide text-default-400">
                {data.columns.map((c) => (
                  <th key={c} className="px-4 py-3 font-medium">
                    {c}
                  </th>
                ))}
              </tr>
            </thead>
            <tbody>
              {data.rows.map((row, i) => (
                <tr
                  key={i}
                  className="border-b border-default-100/60 transition-colors last:border-0 hover:bg-content2/50"
                >
                  {data.columns.map((col, j) => (
                    <td key={j} className="px-4 py-3 align-top">
                      <Cell value={row[j] ?? ''} column={col} />
                    </td>
                  ))}
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      ) : (
        <div className="rounded-xl border border-dashed border-default-200 bg-content1 p-12 text-center">
          <div className="text-3xl text-default-300">↗</div>
          <p className="mt-3 text-default-500">{loading ? 'Loading…' : 'No links yet.'}</p>
          {!loading && (
            <>
              <p className="mx-auto mt-1 max-w-md text-sm text-default-400">
                This table is populated from <code>content/resources.md</code>. Ask Codex to
                add Drive, presentation, or spreadsheet links — or edit the source directly.
              </p>
              <Button
                className="mt-4"
                color="primary"
                variant="flat"
                onPress={() => navigate(`/note/${encodeURIComponent(SOURCE_PATH)}`)}
              >
                Edit source
              </Button>
            </>
          )}
        </div>
      )}
    </div>
  )
}
