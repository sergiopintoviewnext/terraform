resource "aws_s3_bucket" "my_bucket" {
  count = 5

  bucket = "bucket-${random_string.random[count.index].id}"

  tags = {
    Owner       = "SergioP"
    Environment = "Dev"
  }
}

resource "random_string" "random" {
  count = 5

  length  = 8
  special = false
  upper   = false
  numeric = false
}