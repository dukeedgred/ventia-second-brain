import { heroui } from '@heroui/react'

/** @type {import('tailwindcss').Config} */
export default {
  content: [
    './index.html',
    './src/**/*.{js,ts,jsx,tsx}',
    './node_modules/@heroui/theme/dist/**/*.{js,ts,jsx,tsx}',
  ],
  darkMode: 'class',
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter', 'ui-sans-serif', 'system-ui', 'sans-serif'],
      },
    },
  },
  plugins: [
    heroui({
      themes: {
        dark: {
          colors: {
            background: '#0d0d12',
            foreground: '#e7e7ee',
            content1: '#16161f',
            content2: '#1e1e29',
            content3: '#262633',
            focus: '#8b5cf6',
            primary: {
              50: '#f2ecff',
              100: '#e4d8ff',
              200: '#cbb5ff',
              300: '#b08bff',
              400: '#9a69ff',
              500: '#8b5cf6',
              600: '#7c4dff',
              700: '#6a3df0',
              800: '#5631c4',
              900: '#3d2491',
              DEFAULT: '#8b5cf6',
              foreground: '#ffffff',
            },
          },
        },
        // Ventia light theme.
        ventia: {
          extend: 'light',
          colors: {
            background: '#f7f6f2',
            foreground: '#0d0a15',
            content1: '#ffffff',
            content2: '#f2f2f2',
            content3: '#e8e7e0',
            divider: '#0000001f',
            focus: '#006dff',
            default: {
              50: '#faf9f6',
              100: '#e8e7e0',
              200: '#dad9d1',
              300: '#cfced0',
              400: '#9e9da1',
              500: '#6e6c73',
              600: '#53514a',
              700: '#3d3b44',
              800: '#26242c',
              900: '#0d0a15',
              DEFAULT: '#e8e7e0',
              foreground: '#0d0a15',
            },
            primary: {
              50: '#d0e8ff',
              100: '#97c7ff',
              200: '#6fb2ff',
              300: '#479cff',
              400: '#1f86ff',
              500: '#006dff',
              600: '#0057cc',
              700: '#004ba6',
              800: '#102661',
              900: '#0b1a45',
              DEFAULT: '#006dff',
              foreground: '#ffffff',
            },
            secondary: {
              DEFAULT: '#7957ff',
              foreground: '#ffffff',
            },
            danger: {
              DEFAULT: '#e6004a',
              foreground: '#ffffff',
            },
          },
        },
      },
    }),
  ],
}
