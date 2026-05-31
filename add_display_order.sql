-- Agregar columna display_order a la tabla products
-- Ejecutar esto en el SQL Editor de Supabase (Dashboard > SQL Editor > New query)

ALTER TABLE products
ADD COLUMN IF NOT EXISTS display_order INTEGER DEFAULT 0;

-- Crear índice para ordenamiento rápido
CREATE INDEX IF NOT EXISTS idx_products_display_order ON products(display_order);

-- Actualizar productos existentes para que tengan un valor base
UPDATE products
SET display_order = 0
WHERE display_order IS NULL;

-- Verificar que la columna se agregó correctamente
SELECT column_name, data_type, column_default
FROM information_schema.columns
WHERE table_name = 'products' AND column_name = 'display_order';
