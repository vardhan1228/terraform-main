provider "aws" {
    profile = "dev"
    alias = "account1"
}

provider "aws" {
    profile = "test"
    alias = "account2"
    
  
}

resource "aws_s3_bucket" "name" {
    bucket = "mumbai-hyd-bucket-naresssh"
    provider = aws.account2
  
}
resource "aws_s3_bucket" "test" {
    bucket = "us-hyd-bucket-nareshhhh"
    provider = aws.account1
  
}