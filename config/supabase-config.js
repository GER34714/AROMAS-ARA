// Configuración de Supabase
// Reemplaza estos valores con los de tu proyecto Supabase
const SUPABASE_CONFIG = {
  url: 'https://your-project-id.supabase.co',
  anonKey: 'your-anon-key-here'
};

// Para desarrollo local, puedes usar variables de entorno
const config = {
  url: import.meta.env?.VITE_SUPABASE_URL || SUPABASE_CONFIG.url,
  anonKey: import.meta.env?.VITE_SUPABASE_ANON_KEY || SUPABASE_CONFIG.anonKey
};

export default config;
