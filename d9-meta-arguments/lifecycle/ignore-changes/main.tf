provider "aws" {
  
}
resource "aws_instance" "vsv" {
    ami = "ami-0440d3b780d96b29d"
    instance_type = "t2.micro"
    key_name = "sri"
    tags = {
      Name = "1st-ec2"
    }
  lifecycle {
    ignore_changes = [ tags, ]
  }
  # iam changed tags manually Instance: i-09546834356a0369e (2nd-ec2)
  # then after i am apply manual changes will not be destroyed 
}