resource "local_file" "productos" {
  content         = "Lista de productos"
  filename        = "productos.txt"
  file_permission = "0644"
}
