# 🚀 Deploy en Render - Aromas Ara

## 📋 Pasos para Deploy en Render

### 1. Preparar Repositorio
✅ **HECHO** - Los cambios ya están en GitHub: https://github.com/GER34714/AROMAS-ARA

### 2. Configurar Supabase (Base de Datos)
1. Ve a tu panel de Supabase
2. SQL Editor > New query
3. Copia y ejecuta el contenido de `deploy/supabase-setup.sql`
4. Verifica que las tablas se creen correctamente

### 3. Crear Cuenta Render
1. Ve a https://render.com
2. Regístrate con tu cuenta GitHub
3. Verifica tu email

### 4. Conectar Repositorio a Render
1. En Render dashboard: **"New +"** → **"Web Service"**
2. Conecta tu cuenta GitHub
3. Busca y selecciona: **`GER34714/AROMAS-ARA`**
4. Configura:

```
Name: aromas-ara
Branch: main
Root Directory: (dejar en blanco)
Runtime: Static Site
Build Command: npm run build
Publish Directory: dist
```

### 5. Configurar Variables de Entorno
En Render > Environment > Add Environment Variable:

```
VITE_SUPABASE_URL=https://irgwupsgnjvnnatqoehyj.supabase.co
VITE_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlyZ3d1cHNnbmp2bmF0cW9laHlqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzgxMDc2NDcsImV4cCI6MjA5MzY4MzY0N30.ZA96YiJ7ZTt6EqnnLYGf0IHLLFd8POkZ1Z4HnmpxIl4
VITE_ADMIN_PASSWORD=admin123
```

### 6. Deploy
1. Click **"Create Web Service"**
2. Espera a que termine el build
3. Render te dará una URL como: `https://aromas-ara.onrender.com`

## 🔧 Configuración Adicional

### Redirect para Admin Panel
Crea un archivo `render.yaml` en la raíz:

```yaml
services:
  - type: web
    name: aromas-ara
    env: static
    buildCommand: npm run build
    staticPublishPath: dist
    routes:
      - route: /admin
        path: ./admin-simple.html
      - route: /*
        path: ./index.html
```

### Custom Domain (Opcional)
1. En Render > Service > Custom Domains
2. Agrega tu dominio: `aromas-ara.com`
3. Configura DNS según instrucciones de Render

## ✅ Verificación

Una vez deployado, verifica:

1. **Tienda principal**: `https://aromas-ara.onrender.com`
2. **Panel admin**: `https://aromas-ara.onrender.com/admin-simple.html`
3. **Login**: contraseña `admin123`
4. **CRUD productos**: crear, editar, eliminar
5. **Upload imágenes**: funciona correctamente
6. **Categorías**: botón + Cat funciona

## 🚨 Troubleshooting

### Si falla el build:
- Revisa que `package.json` tenga `"build": "vite build"`
- Verifica que `vite.config.js` exista

### Si no carga Supabase:
- Verifica variables de entorno en Render
- Revisa URL y key de Supabase

### Si las imágenes no suben:
- Verifica bucket `aromas-ara-images` en Supabase
- Revisa políticas RLS para storage

## 🔄 Deploy Automático

Cada vez que hagas push a `main`, Render automáticamente:
1. Hará build del proyecto
2. Deployará los cambios
3. Actualizará la producción

---

**Tiempo estimado**: 15-20 minutos para configurar todo
**Costo**: Free tier de Render es suficiente para empezar
