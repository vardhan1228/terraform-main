module "vardhan" {
    source = "../d10-modules/module-template"
    ami = "ami-0440d3b780d96b29d"
    key_name = "sri"
    instance_type = "t2.micro"
}

