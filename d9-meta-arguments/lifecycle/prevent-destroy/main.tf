provider "aws" {

  
}
resource "aws_s3_bucket" "vsv" {
    bucket = "vardhan12vardhan"
#bucket created where we are applying terminate protection

lifecycle {
  prevent_destroy = false
}
}
# PS C:\terraform-main\d9-meta-arguments\lifecycle\prevent-destroy> terraform destroy -auto-approve

# aws_s3_bucket.vsv: Refreshing state... [id=vardhan12vardhan]
# ╷
# │ Error: Instance cannot be destroyed
# │
# │   on main.tf line 5:
# │    5: resource "aws_s3_bucket" "vsv" {
# │
# │ Resource aws_s3_bucket.vsv has lifecycle.prevent_destroy set, but the plan calls for this      
# │ resource to be destroyed. To avoid this error and continue with the plan, either disable       
# │ lifecycle.prevent_destroy or reduce the scope of the plan using the -target flag.
