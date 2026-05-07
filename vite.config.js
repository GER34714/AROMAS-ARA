import { defineConfig } from 'vite'

export default defineConfig({
  build: {
    rollupOptions: {
      input: {
        main: 'index.html',
        admin: 'admin-simple.html'
      }
    },
    copyPublicDir: true,
    assetsDir: 'assets'
  },
  server: {
    port: 8000
  },
  publicDir: 'public'
})
