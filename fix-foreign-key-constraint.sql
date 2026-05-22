-- Arreglar constraint de clave foránea para permitir eliminación en cascada
-- Esto resolverá el error al intentar eliminar productos

-- Paso 1: Eliminar el constraint existente
ALTER TABLE featured_products DROP CONSTRAINT IF EXISTS featured_products_product_id_fkey;

-- Paso 2: Volver a crear el constraint con ON DELETE CASCADE
ALTER TABLE featured_products 
ADD CONSTRAINT featured_products_product_id_fkey 
FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE;

-- Paso 3: Verificar que el constraint se creó correctamente
SELECT 
    tc.table_name, 
    kcu.column_name, 
    ccu.table_name AS foreign_table_name,
    ccu.column_name AS foreign_column_name,
    rc.delete_rule
FROM information_schema.table_constraints AS tc 
JOIN information_schema.key_column_usage AS kcu
    ON tc.constraint_name = kcu.constraint_name
    AND tc.table_schema = kcu.table_schema
JOIN information_schema.constraint_column_usage AS ccu
    ON ccu.constraint_name = tc.constraint_name
    AND ccu.table_schema = tc.table_schema
JOIN information_schema.referential_constraints AS rc
    ON tc.constraint_name = rc.constraint_name
    AND tc.table_schema = rc.constraint_schema
WHERE tc.constraint_type = 'FOREIGN KEY' 
    AND tc.table_name = 'featured_products';

-- Comentario:
-- Después de ejecutar este script, podrás eliminar productos sin problemas
-- Los registros relacionados en featured_products se eliminarán automáticamente
