-- Agregar columna sort_order a tabla categories
ALTER TABLE categories ADD COLUMN IF NOT EXISTS sort_order INTEGER DEFAULT 0;

-- Asignar orden consecutivo 1, 2, 3... basado en el orden actual por nombre
UPDATE categories
SET sort_order = sub.row_num
FROM (
    SELECT id, ROW_NUMBER() OVER (ORDER BY name) as row_num
    FROM categories
) sub
WHERE categories.id = sub.id;
