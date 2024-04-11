#creating s3 bucket and dynamo DB for state backend storgae and applying the lock mechanisam for statefile

resource "aws_s3_bucket" "example" {
  bucket = "vardhan121213212"
   
}

resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name = "terraform-state-lock-dynamo"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20
 
  attribute {
    name = "LockID"
    type = "S"
  }
}