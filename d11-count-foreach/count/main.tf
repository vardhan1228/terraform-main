 provider "aws" {
  
 }
#  resource "aws_instance" "vsv" {
#      ami = "ami-0440d3b780d96b29d"
#      instance_type = "t2.micro"
#      count = 2                       
#      key_name = "sri"
#      tags = {
#        Name = "vsv-${count.index}"
#      }
     # vsv-1,vsv-0 names of two instances created withput passing variable file
    #   aws_instance.vsv[0]: Creation complete after 36s [id=i-0181cb1ffae6438a3]
    # aws_instance.vsv[1]: Creation complete after 36s [id=i-038476d42b508306f]
    # Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
 #}

 resource "aws_instance" "vardhan" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_name
    count = length(var.tags)
    tags = {
      Name = var.tags[count.index]
    }
    # default = ["vardhan","koti","moji"]
    # aws_instance.vardhan[0]: Creation complete after 36s [id=i-0539687bb55751a87] # vardhan
    # aws_instance.vardhan[1]: Creation complete after 26s [id=i-08f5ac195327aeb48] # koti
    # aws_instance.vardhan[2]: Creation complete after 26s [id=i-01c7c355c9e1d12fe] # moji
    # Apply complete! Resources: 3 added, 0 changed, 0 destroyed
 }
# again Applyed with below variables configuration
#  default = ["koti","moji"]
#   iam removed vardhan in tags 
# aws_instance.vardhan[0]: Modifications complete after 4s [id=i-0539687bb55751a87] this actual name is vardhan but it is changrd into koti
# aws_instance.vardhan[1]: Modifications complete after 4s [id=i-08f5ac195327aeb48]this instance name is actually koti but changed into moji
# aws_instance.vardhan[2]: destroyed... [id=i-01c7c355c9e1d12fe] this actual name is moji but it is destroyd.i am removed in tags vardhan


