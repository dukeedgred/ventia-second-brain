import { useEffect, useState } from 'react'
import { Spinner } from '@heroui/react'
import type { Note } from '../types'
import { api } from '../api'
import { Markdown } from '../lib/markdown'

export default function LogPage() {
  const [note, setNote] = useState<Note | null>(null)

  useEffect(() => {
    api.note('log.md').then(setNote).catch(() => {})
  }, [])

  return (
    <div className="mx-auto max-w-3xl px-8 py-10">
      {note ? (
        <Markdown content={note.content} />
      ) : (
        <div className="grid place-items-center py-20">
          <Spinner />
        </div>
      )}
    </div>
  )
}
