import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vite.dev/config/
export default defineConfig({
  plugins: [react()],
  server: {
    host: true,
    port: 3000,
    watch: {
      usePolling: true,
   },
   proxy: {
    '/api': {
      target: 'http://back:9090',
      changeOrigin: true,
    },
  },
},
})
