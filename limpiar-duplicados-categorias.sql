-- Eliminar duplicados de categorías dejando solo el registro más antiguo para cada nombre

-- Crear tabla temporal con los IDs a mantener
CREATE TEMPORARY TABLE categories_to_keep AS
SELECT MIN(id) as id
FROM categories
GROUP BY name;

-- Eliminar todos los registros que no están en la tabla temporal
DELETE FROM categories
WHERE id NOT IN (SELECT id FROM categories_to_keep);

-- Limpiar tabla temporal
DROP TABLE categories_to_keep;

-- Verificar resultado
SELECT * FROM categories ORDER BY name;
