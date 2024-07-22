resource "aws_instance" "vsv" {
    ami = var.ami
  key_name = var.key_name
  instance_type = var.instance_type
  tags = {
    Name = "terraform"
  }

}


resource "aws_s3_bucket" "example" {
  bucket = "vardhan121213212"
   
}