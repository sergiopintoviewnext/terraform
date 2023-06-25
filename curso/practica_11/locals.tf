resource "random_string" "random_sufix" {
  length  = 4
  upper   = false
  special = false
}

locals {
  sufijo = "${var.description.entorno}-${random_string.random_sufix.id}"
}