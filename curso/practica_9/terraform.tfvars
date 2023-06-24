region_aws = "eu-west-3"

cidr = {
  vpc      = "10.0.0.0/16"
  subnet   = "10.0.0.0/24"
  internet = "0.0.0.0/0"
}

ami = {
  ubuntu = "ami-05b5a865c3579bbc4"
  debian = "ami-0eeeb6788f77d3616"
  rhel9  = "ami-0d767e966f3458eb5"
}

instance_type = "t2.micro"