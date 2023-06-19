variable "cidr" {
  description = "Variable para cidr block"
  type        = string

  default = "10.50.0.0/16"

}

variable "region" {
  description = "Variable para region aws"
  type        = string

  default = "eu-west-3"
}

