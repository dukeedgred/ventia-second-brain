import {
  createContext,
  useCallback,
  useContext,
  useEffect,
  useState,
} from 'react'
import type { ReactNode } from 'react'
import type { NoteListItem } from '../types'
import { api } from '../api'

type NotesContextValue = {
  notes: NoteListItem[]
  loading: boolean
  /** Resolve a wikilink target (basename, case-insensitive) to a note path. */
  resolve: (name: string) => string | null
  refresh: () => void
}

const NotesContext = createContext<NotesContextValue>({
  notes: [],
  loading: true,
  resolve: () => null,
  refresh: () => {},
})

export function NotesProvider({ children }: { children: ReactNode }) {
  const [notes, setNotes] = useState<NoteListItem[]>([])
  const [loading, setLoading] = useState(true)

  const refresh = useCallback(() => {
    setLoading(true)
    api
      .notes()
      .then(setNotes)
      .catch(() => {})
      .finally(() => setLoading(false))
  }, [])

  useEffect(() => {
    refresh()
  }, [refresh])

  const resolve = useCallback(
    (name: string) => {
      const target = name.trim().toLowerCase()
      const hit = notes.find((n) => n.name.toLowerCase() === target)
      return hit ? hit.path : null
    },
    [notes],
  )

  return (
    <NotesContext.Provider value={{ notes, loading, resolve, refresh }}>
      {children}
    </NotesContext.Provider>
  )
}

// eslint-disable-next-line react-refresh/only-export-components
export const useNotes = () => useContext(NotesContext)
