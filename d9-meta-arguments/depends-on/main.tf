resource "aws_instance" "sri" {
    ami = "ami-0440d3b780d96b29d"
    instance_type = "t2.micro"
    key_name = "sri"
  
}
resource "aws_s3_bucket" "sri" {
    bucket = "vardhan-121212"
    depends_on = [ aws_instance.sri ]
  
}