resource "aws_instance" "vsv" {
ami = "ami-0440d3b780d96b29d"
instance_type = "t2.micro"
  
}
resource "aws_s3_bucket" "vsv" {
    bucket = "asdfghjksdfghj"
    provider = aws.mumbai
  
}
resource "aws_s3_bucket" "sri" {
    bucket = "qwaszxcvdfer"
    provider = aws.america
  
}

# Plan: 3 to add, 0 to change, 0 to destroy.
# aws_s3_bucket.vsv: Creating...
# aws_s3_bucket.sri: Creating...
# aws_instance.vsv: Creating...
# aws_s3_bucket.vsv: Creation complete after 2s [id=asdfghjksdfghj]
# aws_s3_bucket.sri: Creation complete after 6s [id=qwaszxcvdfer]
# aws_instance.vsv: Still creating... [10s elapsed]
# aws_instance.vsv: Still creating... [20s elapsed]
# aws_instance.vsv: Creation complete after 26s [id=i-0c2f6fcdbe7334d6c]

# Apply complete! Resources: 3 added, 0 changed, 0 destroyed.