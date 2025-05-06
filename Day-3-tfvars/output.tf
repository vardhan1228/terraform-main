output "ip" {
    value = aws_instance.dev.public_ip
  
}

output "privateip" {
    value = aws_instance.dev.subnet_id
    sensitive = true
  
}
