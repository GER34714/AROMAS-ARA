-- Actualizar TODOS los productos existentes a INACTIVOS
-- Ejecutar este script para que todos los productos aparezcan como inactivos en el panel admin

UPDATE products 
SET activo = FALSE;

-- Verificar el resultado
SELECT 
    COUNT(*) as total_productos,
    COUNT(CASE WHEN activo = TRUE THEN 1 END) as productos_activos,
    COUNT(CASE WHEN activo = FALSE THEN 1 END) as productos_inactivos
FROM products;

-- Comentario:
-- Después de ejecutar este script, todos los productos estarán inactivos
-- y no se mostrarán en la tienda pública hasta que los actives manualmente
