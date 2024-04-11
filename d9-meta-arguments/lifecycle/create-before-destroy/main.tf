# resource "aws_instance" "vardhan" {
#     ami = "ami-0440d3b780d96b29d"
#     instance_type = "t2.micro"
#     key_name = "sri"
#     availability_zone = "us-east-1a"
#     tags = {
#       name = "vsv"
#     }
  
# }
 # comment means the script is applyed then iam re run the script with few modifications 
 # because create before destroy life cycle rule
 
  resource "aws_instance" "vardhan" {
    ami = "ami-0440d3b780d96b29d"
    instance_type = "t2.micro"
    key_name = "sri"
    availability_zone = "us-east-1b" # observe chnage iam changed az
    tags = {
      name = "vsv"
    }

    lifecycle {
      create_before_destroy = true
    }
  }

  # PS C:\terraform-main\d9-meta-arguments\lifecycle\create-before-destroy> terraform apply -auto-app
# rove


# Plan: 1 to add, 0 to change, 1 to destroy.
# aws_instance.vardhan: Creating...
# aws_instance.vardhan: Still creating... [10s elapsed]
# aws_instance.vardhan: Still creating... [20s elapsed]
# aws_instance.vardhan: Still creating... [30s elapsed]
# aws_instance.vardhan: Creation complete after 37s [id=i-01ef8dc7227b72bba]
# aws_instance.vardhan (deposed object 02fb91bb): Destroying... [id=i-09d11f2d20c2f4f3b]
# aws_instance.vardhan: Still destroying... [id=i-09d11f2d20c2f4f3b, 10s elapsed]
# aws_instance.vardhan: Still destroying... [id=i-09d11f2d20c2f4f3b, 20s elapsed]
# aws_instance.vardhan: Still destroying... [id=i-09d11f2d20c2f4f3b, 30s elapsed]
# aws_instance.vardhan: Destruction complete after 31s

# Apply complete! Resources: 1 added, 0 changed, 1 destroyed.