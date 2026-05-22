-- Agregar campo 'activo' a la tabla de productos
ALTER TABLE products 
ADD COLUMN IF NOT EXISTS activo BOOLEAN DEFAULT FALSE;

-- Crear índice para mejor rendimiento
CREATE INDEX IF NOT EXISTS idx_products_activo ON products(activo);

-- Actualizar todos los productos existentes para que estén INACTIVOS por defecto
UPDATE products 
SET activo = FALSE 
WHERE activo IS NULL;

-- Si quieres activar todos los productos existentes, ejecuta esta línea:
-- UPDATE products SET activo = TRUE;

-- Comentario: 
-- - TRUE: El producto se muestra en la tienda pública
-- - FALSE: El producto solo es visible en el panel admin (valor por defecto)
