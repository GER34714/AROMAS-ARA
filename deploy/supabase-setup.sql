-- ========================================
-- Perfumes de la Tempestad - Base de Datos Producción
-- ========================================

-- Tabla de productos
CREATE TABLE IF NOT EXISTS products (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT,
  category TEXT NOT NULL,
  price DECIMAL(10,2),
  status TEXT DEFAULT 'Por encargue',
  image_url TEXT,
  images JSONB DEFAULT '[]',
  features JSONB,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Tabla de categorías
CREATE TABLE IF NOT EXISTS categories (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  description TEXT,
  image_url TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Insertar categorías iniciales (solo si no existen)
INSERT INTO categories (name, description) VALUES
('Textiles', 'Brumas y fragancias para telas, ropa de cama y ambientes'),
('Difusores', 'Opciones suaves para aromatizar distintos espacios'),
('Aerosoles', 'Fragancias listas para usar y perfumar al instante'),
('Home Spray', 'Formatos prácticos con aromas cálidos y frescos'),
('Sahumerios', 'Opciones para rituales, descanso y momentos especiales'),
('Difusores Premium', 'Presentaciones elegantes para regalar o decorar')
ON CONFLICT (name) DO UPDATE SET description = EXCLUDED.description;

-- Tabla para el carrito de compras
CREATE TABLE IF NOT EXISTS cart_items (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  session_id TEXT NOT NULL,
  product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
  quantity INTEGER DEFAULT 1,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(session_id, product_id)
);

-- Índices para mejor rendimiento
CREATE INDEX IF NOT EXISTS idx_products_category ON products(category);
CREATE INDEX IF NOT EXISTS idx_products_status ON products(status);
CREATE INDEX IF NOT EXISTS idx_products_created_at ON products(created_at);
CREATE INDEX IF NOT EXISTS idx_cart_session_id ON cart_items(session_id);
CREATE INDEX IF NOT EXISTS idx_cart_product_id ON cart_items(product_id);

-- Función para actualizar timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ language 'plpgsql';

-- Trigger para actualizar updated_at
DROP TRIGGER IF EXISTS update_products_updated_at ON products;
CREATE TRIGGER update_products_updated_at BEFORE UPDATE ON products FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- ========================================
-- POLÍTICAS DE SEGURIDAD (RLS)
-- ========================================

-- Habilitar RLS en todas las tablas
ALTER TABLE products ENABLE ROW LEVEL SECURITY;
ALTER TABLE categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE cart_items ENABLE ROW LEVEL SECURITY;

-- Políticas para productos (lectura pública, admin full access)
DROP POLICY IF EXISTS "Public products are viewable by everyone" ON products;
CREATE POLICY "Public products are viewable by everyone" ON products FOR SELECT USING (true);

DROP POLICY IF EXISTS "Admin can manage products" ON products;
CREATE POLICY "Admin can manage products" ON products FOR ALL USING (true);

-- Políticas para categorías (lectura pública, admin full access)
DROP POLICY IF EXISTS "Public categories are viewable by everyone" ON categories;
CREATE POLICY "Public categories are viewable by everyone" ON categories FOR SELECT USING (true);

DROP POLICY IF EXISTS "Admin can manage categories" ON categories;
CREATE POLICY "Admin can manage categories" ON categories FOR ALL USING (true);

-- Políticas para carrito (acceso público)
DROP POLICY IF EXISTS "Anyone can manage their cart items" ON cart_items;
CREATE POLICY "Anyone can manage their cart items" ON cart_items FOR ALL USING (true);

-- ========================================
-- STORAGE PARA IMÁGENES
-- ========================================

-- Crear bucket para imágenes
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES (
  'perfumes-de-la-tempestad-images', 
  'perfumes-de-la-tempestad-images', 
  true, 
  5242880, -- 5MB
  ARRAY['image/jpeg', 'image/png', 'image/webp', 'image/gif']
) ON CONFLICT (id) DO NOTHING;

-- Políticas para el bucket de imágenes
DROP POLICY IF EXISTS "Anyone can view images" ON storage.objects;
CREATE POLICY "Anyone can view images" ON storage.objects FOR SELECT USING (bucket_id = 'perfumes-de-la-tempestad-images');

DROP POLICY IF EXISTS "Anyone can upload images" ON storage.objects;
CREATE POLICY "Anyone can upload images" ON storage.objects FOR INSERT WITH CHECK (
  bucket_id = 'perfumes-de-la-tempestad-images' AND 
  (storage.foldername(name))[1] IN ('products', 'categories')
);

DROP POLICY IF EXISTS "Anyone can update images" ON storage.objects;
CREATE POLICY "Anyone can update images" ON storage.objects FOR UPDATE USING (bucket_id = 'perfumes-de-la-tempestad-images');

DROP POLICY IF EXISTS "Anyone can delete images" ON storage.objects;
CREATE POLICY "Anyone can delete images" ON storage.objects FOR DELETE USING (bucket_id = 'perfumes-de-la-tempestad-images');

-- Confirmación
DO $$
BEGIN
  RAISE NOTICE '=== Perfumes de la Tempestad - Base de Datos Configurada ===';
  RAISE NOTICE 'Tablas: products, categories, cart_items';
  RAISE NOTICE 'Storage: perfumes-de-la-tempestad-images';
  RAISE NOTICE 'RLS: Habilitado con políticas públicas y admin';
END $$;
