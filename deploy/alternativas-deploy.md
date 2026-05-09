# 🚀 Alternativas de Deploy - Perfumes de la Tempestad

## ✅ Opción 1: Vercel (La más fácil)

### Pasos:
1. Ve a https://vercel.com
2. **"Sign up"** con GitHub
3. **"New Project"**
4. Importa: `GER34714/AROMAS-ARA`
5. **"Deploy"** (Vercel detecta automáticamente todo)

### Configuración automática:
- Build: `npm run build`
- Output: `dist/`
- Variables: las agregas después en Settings

---

## ✅ Opción 2: Netlify (Muy fácil)

### Pasos:
1. Ve a https://netlify.com
2. **"Sign up"** con GitHub  
3. **"Add new site"** → **"Import an existing project"**
4. Conecta GitHub
5. Selecciona `GER34714/AROMAS-ARA`
6. **"Deploy site"**

---

## ✅ Opción 3: GitHub Pages (Gratis y simple)

### Pasos:
1. En GitHub: ve a tu repo
2. **Settings** → **Pages**
3. **Source**: **GitHub Actions**
4. Crea archivo `.github/workflows/deploy.yml`

### Archivo deploy.yml:
```yaml
name: Deploy to GitHub Pages
on:
  push:
    branches: [ main ]
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: 18
      - run: npm install
      - run: npm run build
      - uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./dist
```

---

## 🎯 **Recomendación: Vercel**

### ¿Por qué Vercel?
- ✅ **Más fácil** - 3 clicks y listo
- ✅ **Gratis** para proyectos personales
- ✅ **HTTPS** automático
- ✅ **Deploy automático** con cada push
- ✅ **Preview** para cada PR

### Tiempo: 5 minutos máximo

---

## 🗄️ **Para la Base de Datos (Supabase)**

Si no pudiste ejecutar el SQL:

### Opción A: Ejecutar por partes
Copia y ejecuta estas queries por separado:

```sql
-- 1. Crear tablas
CREATE TABLE IF NOT EXISTS products (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT,
  category TEXT NOT NULL,
  price DECIMAL(10,2),
  status TEXT DEFAULT 'Por encargue',
  image_url TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS categories (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  description TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

```sql
-- 2. Insertar categorías
INSERT INTO categories (name, description) VALUES
('Textiles', 'Brumas y fragancias para telas'),
('Difusores', 'Opciones suaves para aromatizar'),
('Aerosoles', 'Fragancias listas para usar'),
('Home Spray', 'Formatos prácticos'),
('Sahumerios', 'Opciones para rituales'),
('Difusores Premium', 'Presentaciones elegantes');
```

### Opción B: Usar la interfaz gráfica
1. En Supabase: **Table Editor**
2. **Create a new table**
3. Crea las tablas una por una
4. Agrega los registros manualmente

---

## 🚀 **Plan de acción rápido**

### 1. Elije plataforma: **Vercel** ⭐
### 2. Deploy: **5 minutos**
### 3. Base de datos: **Ejecutar SQL por partes** o **interfaz gráfica**
### 4. Listo: **Tienda online funcionando**

---

## 📞 **Si necesitas ayuda**

- **Vercel**: Soporte 24/7
- **Netlify**: Documentación excelente
- **GitHub**: Issues y comunidad
- **Supabase**: Chat de soporte

---

**Tiempo total estimado: 10-15 minutos**
**Costo: $0** (todos tienen planes gratuitos)
