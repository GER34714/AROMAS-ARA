-- Agregar columna sort_order a la tabla products
-- Ejecutar esto en el SQL Editor de Supabase

ALTER TABLE products
ADD COLUMN IF NOT EXISTS sort_order INTEGER DEFAULT 0;

-- Asignar valores consecutivos a productos existentes (ordenados por created_at ASC)
UPDATE products
SET sort_order = subquery.row_num
FROM (
  SELECT id, ROW_NUMBER() OVER (ORDER BY created_at ASC) AS row_num
  FROM products
) AS subquery
WHERE products.id = subquery.id;

-- Crear índice para ordenamiento rápido
CREATE INDEX IF NOT EXISTS idx_products_sort_order ON products(sort_order);

-- Verificar que la columna se agregó correctamente
SELECT column_name, data_type, column_default
FROM information_schema.columns
WHERE table_name = 'products' AND column_name = 'sort_order';
