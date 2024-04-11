provider "aws" {
  
}
# first write empty resource block then give import command
#   this is command # terraform import aws_instance.vsv <instance id>    
#we can migrate existing remote resource into terraform control
resource "aws_instance" "vsv" {
 # if we want destroy the migrated server must mention two attributes
 ami = "ami-0440d3b780d96b29d" 
 instance_type = "t2.micro"

}