import { useEffect, useState } from 'react'
import { Spinner } from '@heroui/react'
import type { GraphData } from '../types'
import { api } from '../api'
import { GraphView } from '../components/GraphView'

export default function GraphPage() {
  const [data, setData] = useState<GraphData | null>(null)

  useEffect(() => {
    api.graph().then(setData).catch(() => {})
  }, [])

  return (
    <div className="relative h-full w-full">
      <div className="pointer-events-none absolute left-6 top-5 z-10">
        <h1 className="text-lg font-semibold text-foreground">Knowledge Graph</h1>
        <p className="text-sm text-default-400">Click a node to open the note.</p>
        <div className="mt-3 flex flex-wrap gap-3 text-xs text-default-500">
          <Legend color="#8b5cf6" label="ResMed" />
          <Legend color="#f59e0b" label="Raw" />
          <Legend color="#22c55e" label="Tickets" />
          <Legend color="#ec4899" label="Decisions" />
          <Legend color="#64748b" label="System" />
        </div>
      </div>
      {data ? (
        <GraphView data={data} />
      ) : (
        <div className="grid h-full place-items-center">
          <Spinner />
        </div>
      )}
    </div>
  )
}

function Legend({ color, label }: { color: string; label: string }) {
  return (
    <span className="flex items-center gap-1.5">
      <span className="inline-block h-2.5 w-2.5 rounded-full" style={{ background: color }} />
      {label}
    </span>
  )
}
