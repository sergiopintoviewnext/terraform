variable "region" {
  type    = string
  default = "eu-west-3"
}

variable "cidr_vpc" {
  type    = string
  default = "10.0.0.0/16"
}

variable "cidr_subnet" {
  type    = string
  default = "10.0.0.0/24"
}

variable "cidr_def" {
  type    = string
  default = "0.0.0.0/0"
}

variable "instance" {
  type = map(string)
  default = {
    ami           = "ami-05b5a865c3579bbc4"
    instance_type = "t2.micro"
    hostname      = "ubuntu-server-aws"
  }
}
