import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import tsconfigPaths from 'vite-tsconfig-paths';
import dsv from '@rollup/plugin-dsv';

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react(), tsconfigPaths(), dsv()],
})
