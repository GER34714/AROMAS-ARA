# Perfumes de la Tempestad - Tienda Online

Tienda online para productos aromáticos con panel de administración auto-gestionable.

## Características

- 🛍️ **Catálogo de productos** con filtrado por categorías
- 🔐 **Panel de administración** con protección por contraseña
- ➕ **CRUD completo** para gestión de productos
- 📱 **Diseño responsive** para todos los dispositivos
- 🗄️ **Base de datos** con Supabase
- 🔍 **Búsqueda y filtros** de productos

## Estructura del Proyecto

```
PERFUMES-DE-LA-TEMPESTAD/
├── index.html              # Página principal de la tienda
├── admin.html              # Panel de administración
├── supabase.sql            # Esquema de la base de datos
├── config/
│   └── supabase-config.js  # Configuración de Supabase
├── js/
│   └── supabase-client.js  # Cliente de Supabase
└── README.md               # Este archivo
```

## Configuración

### 1. Configurar Supabase

1. Crea un nuevo proyecto en [Supabase](https://supabase.com)
2. Ejecuta el contenido del archivo `supabase.sql` en el editor SQL de tu proyecto
3. Copia tu URL y clave anónima desde Settings > API

### 2. Actualizar configuración

Edita el archivo `config/supabase-config.js`:

```javascript
const SUPABASE_CONFIG = {
  url: 'https://your-project-id.supabase.co',     // Reemplazar con tu URL
  anonKey: 'your-anon-key-here'                   // Reemplazar con tu clave
};
```

### 3. Contraseña de Administración

La contraseña por defecto del panel es: `admin123`

Para cambiarla, edita la línea en `admin.html`:

```javascript
const ADMIN_PASSWORD = 'tu-nueva-contraseña';
```

## Uso

### Para visitantes

- Navegar por el catálogo de productos
- Filtrar por categorías
- Buscar productos específicos
- Contactar por WhatsApp

### Para administradores

1. Hacer clic en "🔐 Admin" en el header
2. Ingresar la contraseña de administración
3. Gestionar productos:
   - Agregar nuevos productos
   - Editar productos existentes
   - Eliminar productos
   - Ver estadísticas del catálogo

## Base de Datos

### Tablas

- **products**: Almacena información de productos
- **categories**: Almacena las categorías disponibles

### Campos de Products

- `id`: UUID único
- `name`: Nombre del producto
- `description`: Descripción detallada
- `category`: Categoría del producto
- `price`: Precio (decimal)
- `status`: Estado (Por encargue, Disponible, Agotado)
- `image_url`: URL de la imagen
- `features`: Características en formato JSON
- `created_at`: Fecha de creación
- `updated_at`: Última actualización

## Seguridad

- **Row Level Security (RLS)** habilitado
- **Lectura pública** para productos y categorías
- **Escritura restringida** a usuarios autenticados
- **Protección por contraseña** para el panel admin

## Tecnologías

- **HTML5** semántico
- **CSS3** con variables personalizadas
- **JavaScript ES6+** con módulos
- **Supabase** como backend (Base de datos + Auth)
- **Diseño responsive** con CSS Grid y Flexbox

## Personalización

### Colores y Estilos

Los colores están definidos en variables CSS en `:root`:

```css
:root{
  --bg:#fbf8f5;              /* Fondo principal */
  --accent:#c8a891;          /* Color acento */
  --text:#5d4b43;            /* Color texto */
  /* ... más variables */
}
```

### Categorías

Para agregar nuevas categorías:

1. Agrégalas a la tabla `categories` en Supabase
2. Actualiza las opciones en el formulario de admin.html
3. Agrega los chips de filtro en index.html

## Despliegue

### Opción 1: GitHub Pages

1. Sube el proyecto a GitHub
2. Habilita GitHub Pages en el repositorio
3. Configura las variables de entorno si es necesario

### Opción 2: Netlify/Vercel

1. Conecta tu repositorio
2. Configura las variables de entorno para Supabase
3. Despliega automáticamente

## Soporte

Para soporte o consultas:

- 📧 Email: [tu-email@ejemplo.com]
- 💬 WhatsApp: +54 9 11 5389-9579

---

**Creado por Ciborg 347**
