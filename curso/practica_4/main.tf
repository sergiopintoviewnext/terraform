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
  region = "eu-west-3"
}


resource "aws_vpc" "vpc_paris" {
  cidr_block = "10.10.0.0/16"
  tags = {
    Name = "VPC_Paris"
  }
}