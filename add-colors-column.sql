-- Agregar columna colors a la tabla products
ALTER TABLE products ADD COLUMN colors JSONB DEFAULT NULL;

-- Crear índice para mejor rendimiento (opcional)
CREATE INDEX idx_products_colors ON products USING GIN (colors);
