
#state file lock 
#store in s3 bucket

terraform {
  backend "s3" {
    bucket = "hgfhjhgcfgkbvbnm"
    key = "d4/terraform.tfstate"
    region = "us-east-1"
    
  }
}