provider "aws" {
  
}
resource "aws_instance" "sri" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_name
    subnet_id = "subnet-079be1291a716bc9f"
    #security_groups = ["sg-0d138fe483dc8a05b"]
    for_each = toset(var.tags)
    tags = {
      Name = each.value
    }
  
}
# default = ["vardhan","koti","moji"]
# aws_instance.sri["vardhan"]: Creation complete after 36s [id=i-0f1dcc26f8725e176]
# aws_instance.sri["moji"]: Creation complete after 37s [id=i-0566bbc19a9d96543]
# aws_instance.sri["koti"]: Creation complete after 26s [id=i-0a57586be702f6b40]
#Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

######################now i am removeing one tag name 
# default = ["vardhan","moji"]
#aws_instance.sri["koti"]: destroyed[id=i-0a57586be702f6b40]
# Apply complete! Resources: 0 added, 0 changed, 1 destroyed.