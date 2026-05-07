-- Agregar campo sort_order a la tabla categories
ALTER TABLE categories ADD COLUMN IF NOT EXISTS sort_order INTEGER DEFAULT 0;

-- Actualizar valores existentes de sort_order basados en el orden de inserción
UPDATE categories 
SET sort_order = (
  SELECT row_number - 1 
  FROM (
    SELECT id, row_number() OVER (ORDER BY created_at) as row_number
    FROM categories
  ) ranked 
  WHERE ranked.id = categories.id
)
WHERE sort_order = 0;

-- Crear índice para sort_order
CREATE INDEX IF NOT EXISTS idx_categories_sort_order ON categories(sort_order);
