-- Tabla para gestionar backgrounds del slideshow
CREATE TABLE IF NOT EXISTS backgrounds (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  image_url TEXT NOT NULL,
  sort_order INTEGER DEFAULT 0,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Tabla para configuración del slideshow
CREATE TABLE IF NOT EXISTS background_settings (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  interval_seconds INTEGER DEFAULT 6,
  overlay_opacity DECIMAL(3,2) DEFAULT 0.55,
  is_enabled BOOLEAN DEFAULT true,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Insertar configuración inicial si no existe
INSERT INTO background_settings (interval_seconds, overlay_opacity, is_enabled)
VALUES (6, 0.55, true)
ON CONFLICT DO NOTHING;

-- Insertar backgrounds iniciales
INSERT INTO backgrounds (image_url, sort_order, is_active)
VALUES 
  ('https://irgwupsgnjvnatqoehyj.supabase.co/storage/v1/object/public/aromas-ara-images/8c775188662f2e74bbdc529fe748e1d4.jpg', 1, true),
  ('https://irgwupsgnjvnatqoehyj.supabase.co/storage/v1/object/public/aromas-ara-images/8b33d92798d29785b397056769fd1f8f.jpg', 2, true)
ON CONFLICT DO NOTHING;

-- Crear índices para mejor rendimiento
CREATE INDEX IF NOT EXISTS idx_backgrounds_sort_order ON backgrounds(sort_order);
CREATE INDEX IF NOT EXISTS idx_backgrounds_is_active ON backgrounds(is_active);
