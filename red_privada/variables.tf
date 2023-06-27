variable "region" {
  type    = string
  default = "eu-west-3"
}

variable "espects" {
  type = map(string)
  default = {
    ami  = "ami-05b5a865c3579bbc4"
    type = "t2.micro"
  }
}

variable "list_ports" {
  type = map(string)
  default = {
    ssh = "22"
  }
}

variable "cidr_internet" {
  type    = string
  default = "0.0.0.0/0"
}

variable "cidr_subnet" {
  type    = string
  default = "192.168.0.0/24"
}

variable "user" {
  type = string
}

variable "password" {
  type = string
}
