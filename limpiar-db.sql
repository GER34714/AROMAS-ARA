-- Limpiar base de datos para dejar solo 2 productos de ejemplo

-- Eliminar todos los productos existentes
DELETE FROM products;

-- Insertar solo 2 productos de ejemplo
INSERT INTO products (name, category, description, price, status, image_url, features) VALUES
(
  'Aroma Floral Suave',
  'Textiles',
  'Fragancia delicada perfecta para telas y ambientes. Notas florales suaves que perduran.',
  15.99,
  'Disponible',
  'https://picsum.photos/400/400?random=floral1',
  '["Ideal para ropa de cama", "Larga duración", "No mancha"]'
),
(
  'Difusor de Lavanda',
  'Difusores',
  'Difusor con varillas de bambú y esencia de lavanda natural. Perfecto para dormitorios.',
  22.50,
  'Disponible',
  'https://picsum.photos/400/400?random=lavanda1',
  '["Relajante", "Duración 3 meses", "Envase elegante"]'
);

-- Limpiar categorías existentes
DELETE FROM categories;

-- Insertar solo las categorías que se usan en los productos
INSERT INTO categories (name) VALUES
('Textiles'),
('Difusores');
