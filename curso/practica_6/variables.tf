variable "vpc" {
  description = "Variable para cidr vpc"
  type        = string
  default     = "10.0.0.0/16"
}

variable "cidr" {
  description = "Variable para cidr block"
  type        = list(string)

  default = ["10.0.50.0/24", "10.0.10.0/24"]

}

variable "region" {
  description = "Variable para region aws"
  type        = string

  default = "eu-west-3"
}

variable "tags" {
  type        = map(string)
  description = "map para tags"
  default = {
    "Owner"       = "SergioP"
    "cloud"       = "AWS"
    "env"         = "dev"
    "IAC"         = "Terraform"
    "IAC_version" = "1.4.6"
  }
}