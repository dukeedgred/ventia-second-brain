import ReactMarkdown from 'react-markdown'
import remarkGfm from 'remark-gfm'
import { Link } from 'react-router-dom'
import { useNotes } from './notes'

const WIKILINK = /\[\[([^\]]+)\]\]/g

/** Turn [[Target]] and [[Target|alias]] into links the renderer understands. */
function preprocess(src: string): string {
  return src.replace(WIKILINK, (_match, inner: string) => {
    const [targetRaw, aliasRaw] = inner.split('|')
    const target = targetRaw.trim()
    const alias = (aliasRaw ?? targetRaw).trim()
    return `[${alias}](wiki:${encodeURIComponent(target)})`
  })
}

export function Markdown({ content }: { content: string }) {
  const { resolve } = useNotes()
  const processed = preprocess(content)

  return (
    <div className="md">
      <ReactMarkdown
        remarkPlugins={[remarkGfm]}
        // Don't sanitize URLs — react-markdown's default strips our custom
        // `wiki:` protocol, which would break every wikilink. Content is local & trusted.
        urlTransform={(url) => url}
        components={{
          a: ({ href, children }) => {
            if (href && href.startsWith('wiki:')) {
              const name = decodeURIComponent(href.slice(5))
              const path = resolve(name)
              if (path) {
                return (
                  <Link className="wikilink" to={`/note/${encodeURIComponent(path)}`}>
                    {children}
                  </Link>
                )
              }
              return (
                <span className="wikilink-broken" title={`No note named "${name}"`}>
                  {children}
                </span>
              )
            }
            if (href && /^https?:/.test(href)) {
              return (
                <a href={href} target="_blank" rel="noreferrer">
                  {children}
                </a>
              )
            }
            return <a href={href}>{children}</a>
          },
        }}
      >
        {processed}
      </ReactMarkdown>
    </div>
  )
}
