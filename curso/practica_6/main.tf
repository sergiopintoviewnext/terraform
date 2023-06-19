terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">5.3.0"
    }
  }
  required_version = "~>1.4.0"
}

provider "aws" {
  region = var.region
  default_tags {
    tags = var.tags
  }
}


resource "aws_vpc" "vpc_paris" {
  cidr_block = var.vpc
  tags = {
    Name = "VPC_Paris"
  }
}

resource "aws_subnet" "subnet_privada" {
  vpc_id     = aws_vpc.vpc_paris.id
  cidr_block = var.cidr[0]
  tags = {
    Name = "Subnet privada"
  }
}


resource "aws_subnet" "subnet_public" {
  vpc_id                  = aws_vpc.vpc_paris.id
  cidr_block              = var.cidr[1]
  map_public_ip_on_launch = true
  tags = {
    Name = "Subnet publica"
  }
}


resource "aws_instance" "instancia" {
  ami           = "ami-05b5a865c3579bbc4"
  subnet_id     = aws_subnet.subnet_public.id
  instance_type = "t2.micro"
}
