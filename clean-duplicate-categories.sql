-- Limpiar categorías duplicadas y mantener solo las originales

-- Primero, ver las categorías duplicadas
SELECT name, COUNT(*) as count 
FROM categories 
GROUP BY name 
HAVING COUNT(*) > 1;

-- Eliminar duplicados manteniendo solo el más antiguo (primer ID)
DELETE FROM categories 
WHERE id NOT IN (
  SELECT MIN(id) 
  FROM categories 
  GROUP BY name
);

-- Verificar categorías finales
SELECT * FROM categories ORDER BY sort_order, name;
