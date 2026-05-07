-- Reset completo de categorías - versión corregida para PostgreSQL

-- 1. Eliminar todas las categorías existentes
DELETE FROM categories;

-- 2. Insertar categorías correctas sin duplicados
INSERT INTO categories (name, description, sort_order) VALUES
('Textiles', 'Brumas y fragancias para telas, ropa de cama y ambientes', 1),
('Difusores', 'Opciones suaves para aromatizar distintos espacios', 2),
('Aerosoles', 'Fragancias listas para usar y perfumar al instante', 3),
('Home Spray', 'Formatos prácticos con aromas cálidos y frescos', 4),
('Sahumerios', 'Opciones para rituales, descanso y momentos especiales', 5),
('Difusores Premium', 'Presentaciones elegantes para regalar o decorar', 6);

-- 3. Verificar resultado
SELECT * FROM categories ORDER BY sort_order;
