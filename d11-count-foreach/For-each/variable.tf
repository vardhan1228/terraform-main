variable "ami" {
description = "ami value"
type = string
default = "ami-0440d3b780d96b29d"
}

variable "instance_type" {
description = "instace type value"
type = string
default = "t2.micro"
}

variable "key_name" {
description = "keyname value"
type = string
default = "sri"
}
variable "tags" {
    type = list(string)
    default = ["vardhan","moji"]
  description = "passing tag names by using foreach"
}