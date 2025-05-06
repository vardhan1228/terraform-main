
resource "aws_key_pair" "name" {
    key_name = "public"
    public_key = file("~/.ssh/id_rsa.pub") #here you need to define public key file path

  
}


# Launch server
resource "aws_instance" "name" {
    ami = "ami-00a929b66ed6e0de6"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.public.id
    associate_public_ip_address = true
    key_name               = aws_key_pair.name.key_name
    vpc_security_group_ids = [aws_security_group.allow_tls.id]

    
}

  
#Use taint when you want Terraform to handle recreation without touching .tf code. It’s useful for controlled replacements during debugging or incident response.
# terraform taint aws_instance.name 
# terraform untaint aws_instance.name
#terraform replace is the modern alternative to terraform taint starting from Terraform v1.1+.
#example command ""terraform plan -replace=aws_instance.name"""