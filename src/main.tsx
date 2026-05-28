import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import { BrowserRouter, useHref, useNavigate } from 'react-router-dom'
import { HeroUIProvider } from '@heroui/react'
import './index.css'
import App from './App'
import { NotesProvider } from './lib/notes'
import { IngestProvider } from './lib/ingest'

function Providers() {
  const navigate = useNavigate()
  return (
    <HeroUIProvider navigate={navigate} useHref={useHref}>
      <NotesProvider>
        <IngestProvider>
          <App />
        </IngestProvider>
      </NotesProvider>
    </HeroUIProvider>
  )
}

createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <BrowserRouter>
      <Providers />
    </BrowserRouter>
  </StrictMode>,
)
