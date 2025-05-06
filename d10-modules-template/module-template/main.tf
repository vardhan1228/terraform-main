resource "aws_instance" "vsv" {
    ami = var.ami
  key_name = var.key_name
  
  instance_type = var.instance_type
  tags = {
    Name = "vsv"
  }

}
resource "aws_s3_bucket" "optional" {
  count  = var.s3 != "" ? 1 : 0
  bucket = var.s3
}