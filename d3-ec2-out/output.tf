output "publicip" {
    value = aws_instance.vsv.public_ip
    sensitive = false      # for comand to view ##terraform output privateip##
  
}
output "privateip" {
    value = aws_instance.vsv.private_ip
    sensitive = true
  
}