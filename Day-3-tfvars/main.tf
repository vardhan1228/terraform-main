resource "aws_instance" "dev" {
    ami = var.ami
    instance_type = var.type
    availability_zone = "us-east-1a"
  
}
# resource "aws_vpc" "name" {
#   cidr_block = ""
  
# }

# resource "aws_s3_bucket" "dev" {
#     bucket = var.bucket
  
# }



#terraform destroy -target=aws_s3_bucket.name if we want control particular resource use Target 