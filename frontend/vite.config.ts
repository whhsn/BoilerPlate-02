import { defineConfig, loadEnv } from 'vite';
import react from '@vitejs/plugin-react';

export default defineConfig(({ mode }) => {
  const env = loadEnv(mode, process.cwd(), '');
  const frontendPort = Number(env.VITE_PORT) || 3000;
  const backendUrl = env.VITE_API_URL || 'http://localhost:5000';

  return {
    plugins: [react()],
    server: {
      host: '0.0.0.0',     // Allow connections from all IPs
      port: frontendPort,
      strictPort: true,    // Fail if port is in use
      proxy: {
        '/api': {
          target: backendUrl,
          changeOrigin: true,
        },
      },
      watch: {
        usePolling: true,  // Better compatibility for Docker/WSL
      },
    },
  };
});
