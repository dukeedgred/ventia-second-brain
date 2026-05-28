import { createContext, useCallback, useContext, useEffect, useState } from 'react'
import type { ReactNode } from 'react'

export type Theme = 'obsidian' | 'resmed'

const STORAGE_KEY = 'sb-theme'
// Map our theme names to the HeroUI/Tailwind theme class on <html>.
const CLASS: Record<Theme, string> = { obsidian: 'dark', resmed: 'resmed' }

function applyTheme(theme: Theme) {
  const el = document.documentElement
  el.classList.remove('dark', 'resmed')
  el.classList.add(CLASS[theme])
}

type ThemeContextValue = {
  theme: Theme
  setTheme: (t: Theme) => void
  toggle: () => void
}

const ThemeContext = createContext<ThemeContextValue>({
  theme: 'obsidian',
  setTheme: () => {},
  toggle: () => {},
})

export function ThemeProvider({ children }: { children: ReactNode }) {
  const [theme, setThemeState] = useState<Theme>(() => {
    try {
      const saved = localStorage.getItem(STORAGE_KEY)
      if (saved === 'resmed' || saved === 'obsidian') return saved
    } catch {
      /* ignore */
    }
    return 'obsidian'
  })

  useEffect(() => {
    applyTheme(theme)
    try {
      localStorage.setItem(STORAGE_KEY, theme)
    } catch {
      /* ignore */
    }
  }, [theme])

  const setTheme = useCallback((t: Theme) => setThemeState(t), [])
  const toggle = useCallback(
    () => setThemeState((t) => (t === 'obsidian' ? 'resmed' : 'obsidian')),
    [],
  )

  return (
    <ThemeContext.Provider value={{ theme, setTheme, toggle }}>{children}</ThemeContext.Provider>
  )
}

// eslint-disable-next-line react-refresh/only-export-components
export function useTheme() {
  return useContext(ThemeContext)
}
