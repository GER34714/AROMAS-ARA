-- Agregar campos para productos destacados y ofertas
ALTER TABLE products 
ADD COLUMN IF NOT EXISTS es_destacado BOOLEAN DEFAULT FALSE,
ADD COLUMN IF NOT EXISTS en_oferta BOOLEAN DEFAULT FALSE,
ADD COLUMN IF NOT EXISTS precio_oferta DECIMAL(10,2),
ADD COLUMN IF NOT EXISTS es_nuevo BOOLEAN DEFAULT FALSE,
ADD COLUMN IF NOT EXISTS proximo_lanzamiento BOOLEAN DEFAULT FALSE;

-- Crear tabla para productos destacados con orden
CREATE TABLE IF NOT EXISTS featured_products (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  product_id UUID REFERENCES products(id) ON DELETE CASCADE,
  priority INTEGER DEFAULT 1,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Políticas de seguridad para featured_products
ALTER TABLE featured_products ENABLE ROW LEVEL SECURITY;
CREATE POLICY IF NOT EXISTS "Public featured products are viewable by everyone" ON featured_products FOR SELECT USING (true);
CREATE POLICY IF NOT EXISTS "Authenticated users can manage featured products" ON featured_products FOR ALL USING (auth.role() = 'authenticated');

-- Índices para mejor rendimiento
CREATE INDEX IF NOT EXISTS idx_products_es_destacado ON products(es_destacado);
CREATE INDEX IF NOT EXISTS idx_products_en_oferta ON products(en_oferta);
CREATE INDEX IF NOT EXISTS idx_products_es_nuevo ON products(es_nuevo);
CREATE INDEX IF NOT EXISTS idx_featured_products_priority ON featured_products(priority);

-- Marcar algunos productos como destacados (ejemplo)
-- NOTA: Descomenta y ajusta los IDs según tus productos reales
/*
INSERT INTO featured_products (product_id, priority) 
SELECT id, 1 FROM products WHERE name LIKE '%Difusor%' LIMIT 3;
INSERT INTO featured_products (product_id, priority) 
SELECT id, 2 FROM products WHERE name LIKE '%Textil%' LIMIT 2;
INSERT INTO featured_products (product_id, priority) 
SELECT id, 3 FROM products WHERE name LIKE '%Aerosol%' LIMIT 2;
*/

-- Marcar algunos productos como en oferta (ejemplo)
-- UPDATE products SET en_oferta = TRUE, precio_oferta = price * 0.8 WHERE name LIKE '%Difusor%' LIMIT 2;
-- UPDATE products SET en_oferta = TRUE, precio_oferta = price * 0.7 WHERE name LIKE '%Textil%' LIMIT 1;

-- Marcar algunos productos como nuevos
-- UPDATE products SET es_nuevo = TRUE WHERE created_at > NOW() - INTERVAL '30 days';

-- Marcar algunos productos como próximos lanzamientos
-- UPDATE products SET proximo_lanzamiento = TRUE WHERE name LIKE '%Premium%' LIMIT 1;
