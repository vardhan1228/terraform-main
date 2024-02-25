
#state file lock 
#store in s3 bucket

terraform {
  backend "s3" {
    bucket = "vardhan121213212"
    key = "d7dblock/terraform.tfstate"
    region = "us-east-1"
    
  }
}