module "vardhan" {
    source = "github.com/yashvin77/practiseday3/Day-8-modules-ec2-template"
    ami_id1 = "ami-0440d3b780d96b29d"
    key_name_instance1 = "sri"
    instance_type1 = "t2.micro"
}

