resource "aws_instance" "example" {
  ami           = "ami-0261755bbcb8c4a84"
  instance_type = "t2.micro"
  tags = {
    Name = "null resource"
  }

  provisioner "local-exec" {
    command = "echo Instance public IP is ${self.private_ip} > instance_info.txt"
  }
}
