import { useRef, useState } from 'react'
import { Link, useNavigate } from 'react-router-dom'
import { Button, Input, Spinner, Textarea } from '@heroui/react'
import { Markdown } from '../lib/markdown'
import { GraphView } from '../components/GraphView'
import { ExtractModal } from '../components/ExtractModal'
import { useIngest } from '../lib/ingest'
import { api } from '../api'

const TEXT_FILE_EXTENSIONS = new Set([
  'csv',
  'json',
  'log',
  'md',
  'markdown',
  'txt',
  'tsv',
  'xml',
  'yaml',
  'yml',
])

const EXTRACTABLE_FILE_EXTENSIONS = new Set(['docx', 'pdf', 'pptx'])

function fileExtension(file: File) {
  return file.name.split('.').pop()?.toLowerCase() || ''
}

function isTextFile(file: File) {
  if (file.type.startsWith('text/')) return true
  return TEXT_FILE_EXTENSIONS.has(fileExtension(file))
}

function isExtractableFile(file: File) {
  return EXTRACTABLE_FILE_EXTENSIONS.has(fileExtension(file))
}

function readFileAsBase64(file: File) {
  return new Promise<string>((resolve, reject) => {
    const reader = new FileReader()
    reader.onerror = () => reject(reader.error ?? new Error(`Could not read ${file.name}`))
    reader.onload = () => {
      const result = String(reader.result || '')
      resolve(result.includes(',') ? result.slice(result.indexOf(',') + 1) : result)
    }
    reader.readAsDataURL(file)
  })
}

export default function IngestPage() {
  const navigate = useNavigate()
  const fileInputRef = useRef<HTMLInputElement | null>(null)
  const [extractPath, setExtractPath] = useState('')
  const [dragging, setDragging] = useState(false)
  const [fileError, setFileError] = useState('')
  const {
    title,
    setTitle,
    content,
    setContent,
    running,
    steps,
    summary,
    error,
    rawPath,
    done,
    graph,
    newIds,
    start,
    stop,
  } = useIngest()

  const readFiles = async (files: File[]) => {
    if (running || files.length === 0) return
    setFileError('')

    const unsupported = files.filter((file) => !isTextFile(file) && !isExtractableFile(file))
    if (unsupported.length > 0) {
      setFileError(
        `Cannot read ${unsupported.map((file) => file.name).join(', ')} as source text. Use .txt, .md, .csv, .json, .log, .xml, .yaml, .docx, .pptx, or .pdf.`,
      )
      return
    }

    try {
      const extractedWarnings: string[] = []
      const texts = await Promise.all(
        files.map(async (file) => {
          if (isTextFile(file)) return file.text()
          const result = await api.extractFile(file.name, await readFileAsBase64(file))
          extractedWarnings.push(...result.warnings.map((warning) => `${file.name}: ${warning}`))
          return result.text
        }),
      )
      const nextContent = texts
        .map((text, i) => (files.length > 1 ? `# ${files[i].name}\n\n${text}` : text))
        .join('\n\n---\n\n')

      setContent(nextContent)
      if (extractedWarnings.length > 0) setFileError(extractedWarnings.join(' '))
      if (!title.trim() && files.length === 1) {
        setTitle(files[0].name.replace(/\.[^.]+$/, ''))
      }
    } catch (err) {
      setFileError(`Could not read file: ${(err as Error).message}`)
    }
  }

  const handleDrop = (e: React.DragEvent) => {
    e.preventDefault()
    setDragging(false)
    readFiles(Array.from(e.dataTransfer.files))
  }

  const handlePaste = (e: React.ClipboardEvent<HTMLElement>) => {
    const files = Array.from(e.clipboardData.files)
    if (!files.length) return
    e.preventDefault()
    readFiles(files)
  }

  const handleFilePick = (e: React.ChangeEvent<HTMLInputElement>) => {
    readFiles(Array.from(e.target.files ?? []))
    e.target.value = ''
  }

  return (
    <div className="flex h-full">
      {/* left: form + activity */}
      <div className="w-[44%] min-w-[380px] overflow-y-auto border-r border-default-100 px-7 py-8">
        <h1 className="flex items-center gap-2 text-2xl font-semibold text-foreground">
          <span className="text-primary-400">⊕</span> Ingest source material
        </h1>
        <p className="mt-1 text-sm text-default-400">
          Paste anything — meeting notes, a document, an article, a transcript — and local Codex
          distils it into wiki pages and updates the index &amp; log. Watch the graph grow on
          the right.
        </p>

        <div className="mt-6 flex flex-col gap-3">
          <Input
            label="Title (optional)"
            value={title}
            onValueChange={setTitle}
            variant="bordered"
            placeholder="e.g. Supplier Onboarding Workshop, Q2 Spend Report…"
            isDisabled={running}
          />
          <div
            onDragOver={(e) => {
              e.preventDefault()
              setDragging(true)
            }}
            onDragEnter={(e) => {
              e.preventDefault()
              setDragging(true)
            }}
            onDragLeave={() => setDragging(false)}
            onDrop={handleDrop}
            onPaste={handlePaste}
            className={dragging ? 'rounded-xl opacity-70 ring-2 ring-primary-400' : undefined}
          >
            <Textarea
              label="Source text"
              value={content}
              onValueChange={setContent}
              variant="bordered"
              minRows={8}
              placeholder="Paste notes, a document, an article, a transcript…"
              isDisabled={running}
            />
          </div>
          <input
            ref={fileInputRef}
            type="file"
            multiple
            accept=".csv,.docx,.json,.log,.md,.markdown,.pdf,.pptx,.txt,.tsv,.xml,.yaml,.yml,text/*"
            className="hidden"
            onChange={handleFilePick}
          />
          <div className="flex gap-2">
            {running ? (
              <Button color="danger" variant="flat" onPress={stop}>
                Stop
              </Button>
            ) : (
              <Button color="primary" isDisabled={!content.trim()} onPress={start}>
                Ingest
              </Button>
            )}
            <Button variant="flat" isDisabled={running} onPress={() => fileInputRef.current?.click()}>
              Add file
            </Button>
          </div>
          {fileError && (
            <div className="rounded-xl border border-warning/40 bg-warning/10 px-4 py-3 text-sm text-warning">
              {fileError}
            </div>
          )}
        </div>

        {(steps.length > 0 || running) && (
          <div className="mt-8">
            <div className="mb-2 text-xs font-semibold uppercase tracking-wide text-default-400">
              Activity
            </div>
            <div className="flex flex-col gap-1.5">
              {steps.map((s, i) => (
                <div key={i} className="flex items-center gap-2 text-sm text-default-500">
                  <span className="text-primary-400">{s.tool ? '⌕' : '•'}</span> {s.text}
                </div>
              ))}
              {running && (
                <div className="flex items-center gap-2 text-sm text-default-400">
                  <Spinner size="sm" /> Working…
                </div>
              )}
            </div>
          </div>
        )}

        {summary && (
          <div className="mt-6 rounded-2xl border border-default-100 bg-content1 px-5 py-3">
            <Markdown content={summary} />
          </div>
        )}

        {error && (
          <div className="mt-4 rounded-xl border border-danger/40 bg-danger/10 px-4 py-3 text-sm text-danger">
            {error}
          </div>
        )}

        {done && !error && (
          <div className="mt-6 flex flex-wrap items-center gap-3 rounded-xl border border-success/30 bg-success/10 px-4 py-3 text-sm">
            <span className="text-success">✓ Ingested.</span>
            {rawPath && (
              <Link to={`/note/${encodeURIComponent(rawPath)}`} className="text-primary-300 hover:underline">
                View source
              </Link>
            )}
            {rawPath && (
              <Button size="sm" color="primary" variant="flat" onPress={() => setExtractPath(rawPath)}>
                ✦ Summarise action items
              </Button>
            )}
            <Link to={`/note/${encodeURIComponent('index.md')}`} className="text-primary-300 hover:underline">
              View index
            </Link>
          </div>
        )}
      </div>

      {/* right: live graph */}
      <div className="relative flex-1">
        <div className="pointer-events-none absolute left-5 top-4 z-10">
          <div className="text-sm font-semibold text-foreground">
            Knowledge graph{' '}
            {running && <span className="text-primary-300">· updating live</span>}
          </div>
          <div className="text-xs text-default-400">
            {newIds.size > 0
              ? `${newIds.size} new / changed page${newIds.size > 1 ? 's' : ''} this ingest`
              : 'New pages light up as they appear'}
          </div>
        </div>
        {graph ? (
          <GraphView data={graph} highlightIds={newIds} />
        ) : (
          <div className="grid h-full place-items-center">
            <Spinner />
          </div>
        )}
      </div>
      {extractPath && (
        <ExtractModal
          path={extractPath}
          kind="tickets"
          isOpen={!!extractPath}
          onOpenChange={(open) => {
            if (!open) setExtractPath('')
          }}
          onDone={() => {
            setExtractPath('')
            navigate('/tickets')
          }}
        />
      )}
    </div>
  )
}
