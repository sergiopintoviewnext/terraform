variable "region_aws" {
  type = string
}

variable "cidr" {
  type = map(string)
}

variable "ami" {
  type = map(string)
}

variable "instance_type" {
  type = string
}
