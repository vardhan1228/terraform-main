resource "aws_instance" "dev" {
    ami = var.ami
    instance_type = "t2.micro"
     key_name = "sri"
    # subnet_id = aws_subnet.dev.id
    # security_groups = [aws_security_group.allow_tls.id]
    tags = {
      Name = "backend-dblock"
    }
}
