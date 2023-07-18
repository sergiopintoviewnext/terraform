variable "region" {
  type    = string
  default = "eu-west-3"
}

variable "instance_espects" {
  type = map(string)
  default = {
    ami  = "ami-0ec294f49d26f821e"
    type = "t2.micro"
  }
}

variable "list_ports" {
  type = map(string)
  default = {
    ssh   = "22"
    http  = "80"
    rdp   = "3389"
    https = "443"
    winrm = "5985"
    winrm_https = "5986"
  }
}

variable "cidr" {
  type    = string
  default = "0.0.0.0/0"
}

variable "password" {
  type = string
  default = "password1234"
}