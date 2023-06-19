resource "local_file" "productos" {
  count = 5
  
  content = "Lista de productos"
  filename = "productos-${random_string.random[count.index].id}.txt"
  file_permission = "0644"
}

resource "random_string" "random" {
  count= 5

  length = 4
  special = false
  upper = false
  numeric = false
}