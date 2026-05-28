import { dirname, resolve } from 'node:path'
import { fileURLToPath } from 'node:url'
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

const rootDir = dirname(fileURLToPath(import.meta.url))
const reactAriaExportsDir = resolve(rootDir, 'node_modules/react-aria/dist/exports').replace(
  /\\/g,
  '/',
)

// https://vite.dev/config/
export default defineConfig({
  plugins: [react()],
  resolve: {
    alias: [
      {
        find: /^react-aria\/(.+)$/,
        replacement: `${reactAriaExportsDir}/$1.js`,
      },
    ],
  },
  server: {
    port: 5280,
    proxy: {
      // Everything under /api is handled by the Express backend (see server/index.ts)
      '/api': {
        target: 'http://localhost:8787',
        changeOrigin: true,
      },
    },
  },
})
