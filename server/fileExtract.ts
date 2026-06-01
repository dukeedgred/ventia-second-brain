import { inflateRawSync, inflateSync } from 'node:zlib'

type ZipEntry = {
  name: string
  method: number
  compressedSize: number
  localHeaderOffset: number
}

export type ExtractedFileText = {
  text: string
  warnings: string[]
}

const SUPPORTED_EXTENSIONS = new Set(['docx', 'pdf', 'pptx'])

function extension(name: string) {
  return name.split('.').pop()?.toLowerCase() || ''
}

function decodeXmlEntities(text: string) {
  return text
    .replace(/&amp;/g, '&')
    .replace(/&lt;/g, '<')
    .replace(/&gt;/g, '>')
    .replace(/&quot;/g, '"')
    .replace(/&apos;/g, "'")
    .replace(/&#(\d+);/g, (_m, n: string) => String.fromCodePoint(Number(n)))
    .replace(/&#x([0-9a-f]+);/gi, (_m, n: string) => String.fromCodePoint(Number.parseInt(n, 16)))
}

function xmlToText(xml: string) {
  return decodeXmlEntities(
    xml
      .replace(/<[^>]*(?:br|tab)[^>]*\/>/gi, '\n')
      .replace(/<\/(?:w:)?p>/gi, '\n')
      .replace(/<\/(?:a:)?p>/gi, '\n')
      .replace(/<[^>]+>/g, ' ')
      .replace(/[ \t\r\f\v]+/g, ' ')
      .replace(/ *\n */g, '\n')
      .replace(/\n{3,}/g, '\n\n')
      .trim(),
  )
}

function findEndOfCentralDirectory(buf: Buffer) {
  const min = Math.max(0, buf.length - 66000)
  for (let i = buf.length - 22; i >= min; i -= 1) {
    if (buf.readUInt32LE(i) === 0x06054b50) return i
  }
  throw new Error('Could not find ZIP directory')
}

function readZipEntries(buf: Buffer): ZipEntry[] {
  const eocd = findEndOfCentralDirectory(buf)
  const entryCount = buf.readUInt16LE(eocd + 10)
  let offset = buf.readUInt32LE(eocd + 16)
  const entries: ZipEntry[] = []

  for (let i = 0; i < entryCount; i += 1) {
    if (buf.readUInt32LE(offset) !== 0x02014b50) throw new Error('Invalid ZIP central directory')
    const flags = buf.readUInt16LE(offset + 8)
    const method = buf.readUInt16LE(offset + 10)
    const compressedSize = buf.readUInt32LE(offset + 20)
    const nameLength = buf.readUInt16LE(offset + 28)
    const extraLength = buf.readUInt16LE(offset + 30)
    const commentLength = buf.readUInt16LE(offset + 32)
    const localHeaderOffset = buf.readUInt32LE(offset + 42)
    const name = buf.toString('utf8', offset + 46, offset + 46 + nameLength)
    if ((flags & 1) === 1) throw new Error('Encrypted Office files are not supported')
    entries.push({ name, method, compressedSize, localHeaderOffset })
    offset += 46 + nameLength + extraLength + commentLength
  }

  return entries
}

function readZipEntry(buf: Buffer, entry: ZipEntry) {
  const offset = entry.localHeaderOffset
  if (buf.readUInt32LE(offset) !== 0x04034b50) throw new Error(`Invalid ZIP entry: ${entry.name}`)
  const nameLength = buf.readUInt16LE(offset + 26)
  const extraLength = buf.readUInt16LE(offset + 28)
  const dataStart = offset + 30 + nameLength + extraLength
  const data = buf.subarray(dataStart, dataStart + entry.compressedSize)
  if (entry.method === 0) return data
  if (entry.method === 8) return inflateRawSync(data)
  throw new Error(`Unsupported ZIP compression method ${entry.method} in ${entry.name}`)
}

function extractZipXml(buf: Buffer, include: (name: string) => boolean) {
  const entries = readZipEntries(buf)
    .filter((entry) => include(entry.name))
    .sort((a, b) => a.name.localeCompare(b.name, undefined, { numeric: true }))

  return entries
    .map((entry) => xmlToText(readZipEntry(buf, entry).toString('utf8')))
    .filter(Boolean)
    .join('\n\n')
}

function extractDocx(buf: Buffer) {
  return extractZipXml(
    buf,
    (name) =>
      name === 'word/document.xml' ||
      /^word\/(?:header|footer|comments|footnotes|endnotes)\d*\.xml$/i.test(name),
  )
}

function extractPptx(buf: Buffer) {
  return extractZipXml(buf, (name) => /^ppt\/(?:slides|notesSlides)\/(?:slide|notesSlide)\d+\.xml$/i.test(name))
}

function decodePdfLiteral(raw: string) {
  return raw.replace(/\\([nrtbf()\\])/g, (_m, c: string) => {
    const escapes: Record<string, string> = {
      b: '\b',
      f: '\f',
      n: '\n',
      r: '\r',
      t: '\t',
      '(': '(',
      ')': ')',
      '\\': '\\',
    }
    return escapes[c] ?? c
  })
}

function decodePdfHex(raw: string) {
  const clean = raw.replace(/\s+/g, '')
  const even = clean.length % 2 === 0 ? clean : `${clean}0`
  return Buffer.from(even, 'hex').toString('latin1')
}

function extractPdfStrings(stream: string) {
  const parts: string[] = []
  const textOps = /(\((?:\\.|[^\\)])*\)|<[\da-fA-F\s]+>)\s*Tj|\[((?:.|\n)*?)\]\s*TJ/g
  let match: RegExpExecArray | null

  while ((match = textOps.exec(stream))) {
    if (match[1]) {
      const token = match[1]
      parts.push(token.startsWith('<') ? decodePdfHex(token.slice(1, -1)) : decodePdfLiteral(token.slice(1, -1)))
    } else if (match[2]) {
      const arrayText = match[2]
      const tokens = arrayText.match(/\((?:\\.|[^\\)])*\)|<[\da-fA-F\s]+>/g) ?? []
      parts.push(
        tokens
          .map((token) =>
            token.startsWith('<') ? decodePdfHex(token.slice(1, -1)) : decodePdfLiteral(token.slice(1, -1)),
          )
          .join(''),
      )
    }
  }

  return parts.join('\n')
}

function extractPdf(buf: Buffer): ExtractedFileText {
  const latin = buf.toString('latin1')
  const chunks: string[] = []
  const streamRe = /stream\r?\n([\s\S]*?)\r?\nendstream/g
  let streamCount = 0
  let decodedStreamCount = 0
  let skippedCompressedStreams = 0
  let unsupportedFilteredStreams = 0
  let match: RegExpExecArray | null

  while ((match = streamRe.exec(latin))) {
    streamCount += 1
    const dictStart = Math.max(0, match.index - 1000)
    const dict = latin.slice(dictStart, match.index)
    const raw = Buffer.from(match[1], 'latin1')
    let data = raw
    if (/\/FlateDecode\b/.test(dict)) {
      try {
        data = inflateSync(raw)
        decodedStreamCount += 1
      } catch {
        skippedCompressedStreams += 1
        continue
      }
    } else if (/\/Filter\b/.test(dict)) {
      unsupportedFilteredStreams += 1
      continue
    }
    const text = extractPdfStrings(data.toString('latin1'))
    if (text.trim()) chunks.push(text)
  }

  const text = chunks
    .join('\n\n')
    .replace(/[ \t\r\f\v]+/g, ' ')
    .replace(/\n{3,}/g, '\n\n')
      .trim()

  const warnings = []
  if (text) {
    warnings.push(
      'PDF extraction may be incomplete or inaccurate. Review the source text before clicking Ingest.',
    )
  }
  if (text && !/\/ToUnicode\b/.test(latin)) {
    warnings.push('This PDF does not expose full Unicode maps, so some characters or ordering may be wrong.')
  }
  if (skippedCompressedStreams > 0) {
    warnings.push(`${skippedCompressedStreams} compressed PDF stream(s) could not be decoded.`)
  }
  if (unsupportedFilteredStreams > 0) {
    warnings.push(`${unsupportedFilteredStreams} PDF stream(s) used unsupported compression/filtering and were skipped.`)
  }
  if (/\/Subtype\s*\/Image\b/.test(latin)) {
    warnings.push('The PDF contains image content; scanned or image-only sections cannot be extracted without OCR.')
  }
  if (streamCount > 0 && decodedStreamCount + chunks.length === 0) {
    warnings.push('No readable text operators were found in the PDF streams.')
  }

  return {
    text,
    warnings,
  }
}

export function extractFileText(name: string, buf: Buffer): ExtractedFileText {
  const ext = extension(name)
  if (!SUPPORTED_EXTENSIONS.has(ext)) throw new Error('Only DOCX, PPTX, and PDF extraction is supported')

  if (ext === 'docx') return { text: extractDocx(buf), warnings: [] }
  if (ext === 'pptx') return { text: extractPptx(buf), warnings: [] }
  return extractPdf(buf)
}
