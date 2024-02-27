module "vsv" {
    source = "github.com/vardhan1228/terraform-main/d1-ec2"
    ami = "ami-0440d3b780d96b29d"
    key_name = "sri"
    instance_type = "t2.micro"

  
}
# Warning: Redundant empty provider block
# │
# │   on .terraform\modules\vsv\d1-ec2\provider.tf line 1:
# │    1: provider "aws" {
# │
# │ Earlier versions of Terraform used empty provider blocks ("proxy provider configurations") for 
# │ child modules to declare their need to be passed a provider configuration by their callers.    
# │ That approach was ambiguous and is now deprecated.
# │
# │ If you control this module, you can migrate to the new declaration syntax by removing all of   
# │ the empty provider "aws" blocks and then adding or updating an entry like the following to the 
# │ required_providers block of module.vsv:
# │     aws = {
# │       source = "hashicorp/aws"
# │     }
# ╵

# Do you want to perform these actions?
#   Terraform will perform the actions described above.
#   Only 'yes' will be accepted to approve.

#   Enter a value: yes

# module.vsv.aws_instance.vsv: Creating...
# module.vsv.aws_instance.vsv: Still creating... [10s elapsed]
# module.vsv.aws_instance.vsv: Still creating... [20s elapsed]
# module.vsv.aws_instance.vsv: Creation complete after 27s [id=i-0ba473f50d6027a4e]

# Apply complete! Resources: 1 added, 0 changed, 0 destroyed.