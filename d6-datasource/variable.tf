variable "subnet" {
    description = "passing datasource subnet value"
    type = string
    default = "subnet-07625a63d2b900811"
  
}
variable "sg" {
    description = "passing datasource sg value"
    type = string
    default = "sg-0d138fe483dc8a05b"
  
}
#variable "ami" {
 #   description = "ami value"
 #   type = string
  #  default = "ami-0440d3b780d96b29d"
  
    #}
variable "instance_type" {
    description = " instaancetype of resource instance"
    type = string
    default = "t2.micro"
  
}
variable "key_name" {
    description = "keyname of resource instance"
    type = string
    default = "sri"
  
}