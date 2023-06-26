module "vpc" {
  source = "./modulos/vpc"
  cidr = {
    vpc      = "10.0.0.0/16"
    subnet   = "10.0.0.0/24"
    internet = "0.0.0.0/0"
  }
}

module "sg" {
  source = "./modulos/sg"
  cidr = {
    vpc      = "10.0.0.0/16"
    subnet   = "10.0.0.0/24"
    internet = "0.0.0.0/0"
  }
  list_ports = {
    ssh   = "22"
    http  = "80"
    https = "443"
  }
  vpc_id = module.vpc.vpc_id // output vpc_id del modulo vpc
}

module "instance" {
  source = "./modulos/instance"
  ami = {
    ubuntu = "ami-05b5a865c3579bbc4"
    debian = "ami-0eeeb6788f77d3616"
    rhel9  = "ami-0d767e966f3458eb5"
  }
  instance_type = "t2.micro"
  subnet_id     = module.vpc.subnet_id // output subnet_id del modulo vpc
  sg_id         = module.sg.sg_id      // output sg_id del modulo sg
}