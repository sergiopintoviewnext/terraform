module "vpc" {
  source = "./modulos/vpc"
  cidr = {
    vpc      = "10.0.0.0/16"
    subnet   = "10.0.0.0/24"
    internet = "0.0.0.0/0"
  }
  numero_practica = var.numero_practica
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
  vpc_id          = module.vpc.vpc_id // output vpc_id del modulo vpc
  numero_practica = var.numero_practica
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

module "terraform_state_backend" {
  source      = "cloudposse/tfstate-backend/aws"
  version     = "1.1.1"
  namespace   = "ejemplo"
  stage       = "dev"
  environment = var.region_aws
  name        = "terraform"
  attributes  = ["state"]

  terraform_backend_config_file_path = "."
  terraform_backend_config_file_name = "backend.tf"
  force_destroy                      = false
}