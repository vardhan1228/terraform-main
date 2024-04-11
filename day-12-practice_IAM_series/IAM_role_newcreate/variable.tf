variable "region_name" {
  description = "Region to create the resources"
  type        = string
  default = ""
}

variable "ec2_instance_type" {
  description = "Instance type to create the resources"
  type        = string
  default = ""
}

variable "image_id" {
  description = "Image AMI to create the resources"
  type        = string
  default = ""
}
