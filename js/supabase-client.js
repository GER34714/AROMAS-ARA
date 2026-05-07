// Cliente de Supabase para gestión de productos
const { createClient } = window.supabase;

const supabaseUrl = 'https://irgwupsgnjvnnatqoehyj.supabase.co';
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlyZ3d1cHNnam52bm5hdHFvZWh5aiIsInJvbGUiOiJhbm9uIiwiaWF0IjoxNzE1MzU0ODA4LCJleHAiOjIwMzA5MzA4MDh9.5J8o0wu5kL1l2C9JzP5p3NQq3q5q5q5q5q5q5q5q5q5q';

const supabaseClient = createClient(supabaseUrl, supabaseAnonKey);

// API para productos
const productsAPI = {
  // Obtener todos los productos
  async getAll() {
    try {
      const { data, error } = await supabaseClient
        .from('products')
        .select('*')
        .order('created_at', { ascending: false });
      
      if (error) throw error;
      return data;
    } catch (error) {
      console.error('Error fetching products:', error);
      return [];
    }
  },

  // Obtener producto por ID
  async getById(id) {
    try {
      const { data, error } = await supabaseClient
        .from('products')
        .select('*')
        .eq('id', id)
        .single();
      
      if (error) throw error;
      return data;
    } catch (error) {
      console.error('Error fetching product:', error);
      return null;
    }
  },

  // Crear nuevo producto
  async create(product) {
    try {
      const { data, error } = await supabaseClient
        .from('products')
        .insert([product])
        .select();
      
      if (error) throw error;
      return data[0];
    } catch (error) {
      console.error('Error creating product:', error);
      throw error;
    }
  },

  // Actualizar producto
  async update(id, updates) {
    try {
      const { data, error } = await supabaseClient
        .from('products')
        .update(updates)
        .eq('id', id)
        .select();
      
      if (error) throw error;
      return data[0];
    } catch (error) {
      console.error('Error updating product:', error);
      throw error;
    }
  },

  // Eliminar producto
  async delete(id) {
    try {
      const { error } = await supabaseClient
        .from('products')
        .delete()
        .eq('id', id);
      
      if (error) throw error;
      return true;
    } catch (error) {
      console.error('Error deleting product:', error);
      throw error;
    }
  },

  // Obtener productos por categoría
  async getByCategory(category) {
    try {
      const { data, error } = await supabaseClient
        .from('products')
        .select('*')
        .eq('category', category)
        .order('created_at', { ascending: false });
      
      if (error) throw error;
      return data;
    } catch (error) {
      console.error('Error fetching products by category:', error);
      return [];
    }
  }
};

// API para categorías
const categoriesAPI = {
  // Obtener todas las categorías
  async getAll() {
    try {
      const { data, error } = await supabaseClient
        .from('categories')
        .select('*')
        .order('name');
      
      if (error) throw error;
      return data;
    } catch (error) {
      console.error('Error fetching categories:', error);
      return [];
    }
  }
};

// API para storage de imágenes
const storageAPI = {
  // Subir imagen
  async uploadImage(file, folder = 'products', compress = true) {
    try {
      const timestamp = Date.now();
      const fileExt = file.name.split('.').pop();
      const fileName = `${timestamp}.${fileExt}`;
      const filePath = `${folder}/${fileName}`;

      // Para desarrollo, simplemente retornar una URL temporal
      if (window.location.hostname === 'localhost') {
        const reader = new FileReader();
        return new Promise((resolve) => {
          reader.onload = (e) => {
            resolve({
              url: e.target.result,
              path: filePath
            });
          };
          reader.readAsDataURL(file);
        });
      }

      // Para producción, subir a Supabase Storage
      const { data, error } = await supabaseClient.storage
        .from('aromas-ara-images')
        .upload(filePath, file);

      if (error) throw error;

      const { data: publicUrl } = supabaseClient.storage
        .from('aromas-ara-images')
        .getPublicUrl(filePath);

      return {
        url: publicUrl.publicUrl,
        path: filePath
      };
    } catch (error) {
      console.error('Error uploading image:', error);
      throw error;
    }
  }
};

// Make APIs globally available
window.supabaseClient = supabaseClient;
window.productsAPI = productsAPI;
window.categoriesAPI = categoriesAPI;
window.storageAPI = storageAPI;
