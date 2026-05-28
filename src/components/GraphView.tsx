import { useEffect, useRef, useState } from 'react'
import ForceGraph2D from 'react-force-graph-2d'
import { useNavigate } from 'react-router-dom'
import type { GraphData } from '../types'
import { useTheme } from '../lib/theme'

const GROUP_COLORS: Record<string, string> = {
  Ventia: '#8b5cf6',
  raw: '#f59e0b',
  root: '#64748b',
  tickets: '#22c55e',
  decisions: '#ec4899',
  docs: '#14b8a6',
}

function colorFor(group: string) {
  return GROUP_COLORS[group] ?? '#22d3ee'
}

export function GraphView({
  data,
  highlightIds,
}: {
  data: GraphData
  highlightIds?: Set<string>
}) {
  const navigate = useNavigate()
  const { theme } = useTheme()
  const light = theme === 'ventia'
  // Theme-aware colors for the canvas (which can't read CSS tokens directly).
  const labelColor = light ? '#3d3b44' : '#c7c7d4'
  const linkLine = light ? 'rgba(13,10,21,0.14)' : 'rgba(255,255,255,0.13)'
  const hotFill = light ? '#006dff' : '#ffffff'
  const hotStroke = light ? '#0b1a45' : '#ffffff'

  const wrap = useRef<HTMLDivElement>(null)
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  const fgRef = useRef<any>(null)
  const [size, setSize] = useState({ w: 800, h: 600 })

  useEffect(() => {
    const el = wrap.current
    if (!el) return
    const ro = new ResizeObserver(() => setSize({ w: el.clientWidth, h: el.clientHeight }))
    ro.observe(el)
    setSize({ w: el.clientWidth, h: el.clientHeight })
    return () => ro.disconnect()
  }, [])

  useEffect(() => {
    const fg = fgRef.current
    if (!fg) return
    // Spread nodes locally (strong repulsion) but CAP its range so separate
    // clusters don't push each other to the edges — the connecting links then
    // pull the clusters together. Keeps the open look while staying compact.
    const charge = fg.d3Force('charge')
    if (charge) charge.strength(-280).distanceMax(160)
    const link = fg.d3Force('link')
    if (link) link.distance(52)
    fg.d3ReheatSimulation?.()
  }, [data])

  // Repaint with the new palette when the theme changes.
  useEffect(() => {
    fgRef.current?.d3ReheatSimulation?.()
  }, [light])

  return (
    <div ref={wrap} className="h-full w-full bg-background">
      <ForceGraph2D
        ref={fgRef}
        width={size.w}
        height={size.h}
        graphData={data}
        backgroundColor="rgba(0,0,0,0)"
        nodeRelSize={5}
        cooldownTicks={120}
        onEngineStop={() => fgRef.current?.zoomToFit(400, 50)}
        linkColor={() => linkLine}
        linkWidth={1}
        onNodeClick={(node) =>
          navigate(`/note/${encodeURIComponent(String((node as { id: string }).id))}`)
        }
        nodeCanvasObjectMode={() => 'replace'}
        nodeCanvasObject={(node, ctx, globalScale) => {
          const n = node as unknown as {
            id: string
            x: number
            y: number
            name: string
            group: string
          }
          const hot = highlightIds?.has(n.id) ?? false
          const base = colorFor(n.group)
          const r = hot ? 7 : 5
          ctx.beginPath()
          ctx.arc(n.x, n.y, r, 0, 2 * Math.PI)
          ctx.fillStyle = hot ? hotFill : base
          ctx.shadowColor = hot ? hotFill : base
          ctx.shadowBlur = hot ? 20 : 8
          ctx.fill()
          ctx.shadowBlur = 0
          if (hot) {
            ctx.lineWidth = 2
            ctx.strokeStyle = hotStroke
            ctx.stroke()
          }
          if (globalScale > 0.7 || hot) {
            const fontSize = Math.max(11 / globalScale, 2.5)
            ctx.font = `${hot ? '600 ' : ''}${fontSize}px Inter, sans-serif`
            ctx.textAlign = 'center'
            ctx.textBaseline = 'top'
            ctx.fillStyle = hot ? hotFill : labelColor
            ctx.fillText(n.name, n.x, n.y + r + 1.5)
          }
        }}
      />
    </div>
  )
}
