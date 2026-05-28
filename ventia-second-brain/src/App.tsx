import { useEffect, useState } from 'react'
import { Navigate, Route, Routes } from 'react-router-dom'
import { Sidebar } from './components/Sidebar'
import { SearchModal } from './components/SearchModal'
import HomePage from './pages/HomePage'
import NotePage from './pages/NotePage'
import GraphPage from './pages/GraphPage'
import LogPage from './pages/LogPage'
import AskPage from './pages/AskPage'
import TicketsPage from './pages/TicketsPage'
import DecisionsPage from './pages/DecisionsPage'
import IngestPage from './pages/IngestPage'
import LintPage from './pages/LintPage'
import ResourcesPage from './pages/ResourcesPage'
import DocsPage from './pages/DocsPage'
import { AskProvider } from './lib/ask'
import { LintProvider } from './lib/lint'
import { DocsProvider } from './lib/docs'
import { ThemeProvider } from './lib/theme'

export default function App() {
  const [searchOpen, setSearchOpen] = useState(false)

  useEffect(() => {
    const onKey = (e: KeyboardEvent) => {
      if ((e.metaKey || e.ctrlKey) && e.key.toLowerCase() === 'k') {
        e.preventDefault()
        setSearchOpen(true)
      }
    }
    window.addEventListener('keydown', onKey)
    return () => window.removeEventListener('keydown', onKey)
  }, [])

  return (
    <ThemeProvider>
      <AskProvider>
        <LintProvider>
          <DocsProvider>
          <div className="flex h-screen overflow-hidden bg-background text-foreground">
            <Sidebar onSearch={() => setSearchOpen(true)} />
            <main className="min-w-0 flex-1 overflow-y-auto">
              <Routes>
                <Route path="/" element={<HomePage />} />
                <Route path="/note/:enc" element={<NotePage />} />
                <Route path="/graph" element={<GraphPage />} />
                <Route path="/log" element={<LogPage />} />
                <Route path="/ask" element={<AskPage />} />
                <Route path="/tickets" element={<TicketsPage />} />
                <Route path="/decisions" element={<DecisionsPage />} />
                <Route path="/docs" element={<DocsPage />} />
                <Route path="/resources" element={<ResourcesPage />} />
                <Route path="/ingest" element={<IngestPage />} />
                <Route path="/lint" element={<LintPage />} />
                <Route path="*" element={<Navigate to="/" replace />} />
              </Routes>
            </main>
            <SearchModal open={searchOpen} onClose={() => setSearchOpen(false)} />
          </div>
          </DocsProvider>
        </LintProvider>
      </AskProvider>
    </ThemeProvider>
  )
}
