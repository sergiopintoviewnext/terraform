variable "region" {
    type = string
    default = "eu-west-3"
}

variable "instance_espects" {
    type = map(string)
    default = {
        ami = "ami-0d767e966f3458eb5"
        type = "t2.micro"
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