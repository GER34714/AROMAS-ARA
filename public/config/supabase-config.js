// Configuración de Supabase
const SUPABASE_CONFIG = {
  url: 'https://irgwupsgnjvnnatqoehyj.supabase.co',
  anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlyZ3d1cHNnbmp2bmF0cW9laHlqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzgxMDc2NDcsImV4cCI6MjA5MzY4MzY0N30.ZA96YiJ7ZTt6EqnnLYGf0IHLLFd8POkZ1Z4HnmpxIl4'
};

// Para desarrollo local, puedes usar variables de entorno
const config = {
  url: import.meta.env?.VITE_SUPABASE_URL || SUPABASE_CONFIG.url,
  anonKey: import.meta.env?.VITE_SUPABASE_ANON_KEY || SUPABASE_CONFIG.anonKey
};

export default config;
