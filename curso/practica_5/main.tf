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
}


resource "aws_vpc" "vpc_paris" {
  cidr_block = var.cidr
  tags = {
    Name = "VPC_Paris"
  }
}