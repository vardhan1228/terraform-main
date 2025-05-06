ami="ami-00a929b66ed6e0de6"
type = "t2.micro"
bucket  = "dveprodtestve"


#note: if the name is defualt terraform.tfvars we can run regular process no need to mention 
#Note: if user can give custom .tfvars name like example dev.tfvars process follow below 
# terraform plan -var-file="dev.tfvars"
# terraform apply -var-file="dev.tfvars"