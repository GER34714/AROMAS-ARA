-- Separar categorías del catálogo (con imágenes) de categorías de productos (solo nombres)

-- Nueva tabla para categorías del catálogo (visibles en frontend)
CREATE TABLE catalog_categories (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  description TEXT,
  image_url TEXT,
  display_order INTEGER DEFAULT 0,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Mantener tabla categories para categorías internas de productos
-- (ya existe, solo renombramos para claridad)
ALTER TABLE categories RENAME TO product_categories;

-- Insertar categorías del catálogo iniciales con imágenes
INSERT INTO catalog_categories (name, description, image_url, display_order) VALUES
('Textiles', 'Brumas y fragancias para telas, ropa de cama y ambientes', 'https://picsum.photos/400/300?random=textiles', 1),
('Difusores', 'Opciones suaves para aromatizar distintos espacios', 'https://picsum.photos/400/300?random=difusores', 2),
('Aerosoles', 'Fragancias listas para usar y perfumar al instante', 'https://picsum.photos/400/300?random=aerosoles', 3),
('Home Spray', 'Formatos prácticos con aromas cálidos y frescos', 'https://picsum.photos/400/300?random=homespray', 4),
('Sahumerios', 'Opciones para rituales, descanso y momentos especiales', 'https://picsum.photos/400/300?random=sahumerios', 5),
('Difusores Premium', 'Presentaciones elegantes para regalar o decorar', 'https://picsum.photos/400/300?random=premium', 6);

-- Políticas de seguridad para catalog_categories
ALTER TABLE catalog_categories ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public catalog categories are viewable by everyone" ON catalog_categories FOR SELECT USING (true);
CREATE POLICY "Authenticated users can manage catalog categories" ON catalog_categories FOR ALL USING (auth.role() = 'authenticated');

-- Actualizar políticas para product_categories (renombrado de categories)
DROP POLICY IF EXISTS "Public categories are viewable by everyone" ON product_categories;
DROP POLICY IF EXISTS "Authenticated users can insert categories" ON product_categories;
DROP POLICY IF EXISTS "Authenticated users can update categories" ON product_categories;
DROP POLICY IF EXISTS "Authenticated users can delete categories" ON product_categories;

CREATE POLICY "Public product categories are viewable by everyone" ON product_categories FOR SELECT USING (true);
CREATE POLICY "Authenticated users can manage product categories" ON product_categories FOR ALL USING (auth.role() = 'authenticated');

-- Índices para catalog_categories
CREATE INDEX idx_catalog_categories_order ON catalog_categories(display_order);
CREATE INDEX idx_catalog_categories_active ON catalog_categories(is_active);

-- Trigger para updated_at en catalog_categories
CREATE TRIGGER update_catalog_categories_updated_at BEFORE UPDATE ON catalog_categories FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
