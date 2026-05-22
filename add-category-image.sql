-- Agregar campo de imagen a la tabla de categorías
ALTER TABLE categories 
ADD COLUMN image_url TEXT;

-- Crear índice para optimizar consultas
CREATE INDEX idx_categories_image_url ON categories(image_url) WHERE image_url IS NOT NULL;

-- Actualizar categorías existentes con imágenes predeterminadas (opcional)
UPDATE categories 
SET image_url = 'https://via.placeholder.com/300x200/3b82f6/ffffff?text=Sin+Imagen'
WHERE image_url IS NULL;
