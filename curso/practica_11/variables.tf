variable "description" {
  type = map(string)
  default = {
    "ami"     = "ami-05b5a865c3579bbc4"
    "type"    = "t2.micro"
    "project" = "practica_11"
    "entorno" = "dev"
  }
}