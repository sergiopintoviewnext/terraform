variable "region" {
  type    = string
  default = "eu-west-3"
}

variable "instance_espects" {
  type = map(string)
  default = {
    ami  = "ami-01b305bdc62291ce1"
    type = "t2.micro"
    volume_size = "15"    
  }
}

variable "list_ports" {
  type = map(string)
  default = {
    ssh  = "22"
    http = "80"
  }
}

variable "cidr" {
  type    = string
  default = "0.0.0.0/0"
}