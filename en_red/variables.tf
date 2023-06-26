variable "region" {
  type    = string
  default = "eu-west-3"
}


variable "instance_type" {
  type    = string
  default = "t2.micro"
}


variable "instance_amis" {
  type = map(string)
  default = {
    ubuntu = "ami-05b5a865c3579bbc4"
    debian = "ami-0eeeb6788f77d3616"
    rhel9  = "ami-0d767e966f3458eb5"
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