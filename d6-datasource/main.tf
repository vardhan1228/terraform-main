data "aws_subnet" "vsv" {
  id = var.subnet
}
data "aws_security_group" "vsv" {
    id = var.sg
  
}

resource "aws_instance" "vsv" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_name
    subnet_id =data.aws_subnet.vsv.id
    security_groups = [ data.aws_security_group.vsv.id]
  
}