// Configuración de Supabase - Variables de entorno seguras
// Vite solo expone variables con prefijo VITE_ al frontend
const config = {
  url: import.meta.env.VITE_SUPABASE_URL,
  anonKey: import.meta.env.VITE_SUPABASE_ANON_KEY
};

// Validar que las variables existan
if (!config.url || !config.anonKey) {
  throw new Error('Faltan variables de entorno de Supabase. Revisa tu archivo .env.local');
}

export default config;
