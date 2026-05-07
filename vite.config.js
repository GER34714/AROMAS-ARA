import { defineConfig } from 'vite'

export default defineConfig({
  build: {
    rollupOptions: {
      input: {
        main: 'index.html',
        admin: 'admin-simple.html'
      }
    }
  },
  server: {
    port: 8000
  }
})
