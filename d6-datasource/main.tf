data "aws_subnet" "vsv" {
  id = var.subnet
}
data "aws_security_group" "vsv" {
    id = var.sg
  
}
data "aws_ami" "amzlinux" {
  most_recent = true
  owners = [ "amazon" ]
  filter {
    name = "name"
    values = [ "amzn2-ami-hvm-*-gp2" ]
  }
  filter {
    name = "root-device-type"
    values = [ "ebs" ]
  }
  filter {
    name = "virtualization-type"
    values = [ "hvm" ]
  }
  filter {
    name = "architecture"
    values = [ "x86_64" ]
  }
}


resource "aws_instance" "vsv" {
    ami = data.aws_ami.amzlinux.id
    instance_type = var.instance_type
    key_name = var.key_name
    subnet_id =data.aws_subnet.vsv.id
    security_groups = [ data.aws_security_group.vsv.id]
  
}