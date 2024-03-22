provider "aws" {

  
}
resource "aws_dms_replication_instance" "dms_replication_instance" { 
  allocated_storage           = 10 
  engine_version = "3.5.2"
  apply_immediately           = true 
  auto_minor_version_upgrade  = true 
  replication_instance_class  = "dms.t3.medium" 
  replication_instance_id     = "my-dms-instance" 
  publicly_accessible         = true  # make sure you understand the security implications of making it publicly accessible 
}
 
resource "aws_dms_endpoint" "source_endpoint" { 
  endpoint_id     = "database-2" 
  database_name = "vardhan"
  endpoint_type   = "source" 
  engine_name     = "sqlserver"  // substitute here with the name of your source database engine 
  username        = "sa"  // substitute with your database username 
  password        = "sa"  // substitute with your database password 
  port            = "1433"
  server_name     = "ec2-3-91-38-10.compute-1.amazonaws.com"  // substitute with your source server name 
} 
 
resource "aws_dms_endpoint" "target_endpoint" { 
  endpoint_id     = "database-3taget"
  endpoint_type   = "target" 
  database_name = "DMSDemodb"
 port             = "1433"
  engine_name     = "sqlserver"  // substitute here with the name of your target database engine 
  username        = "admin"  // substitute with your database username 
  password        = "admin1211"  // substitute with your database password 
  server_name     = "database-1.chyljtisxani.us-east-1.rds.amazonaws.com"  // substitute with your target server name 
} 
 
resource "aws_dms_replication_task" "dms_replication_task" { 
  migration_type          = "full-load-and-cdc"  // for this example we are using full-load migration type 
  replication_task_id     = "my-task" 
  replication_task_settings = file("dms.json")
  replication_instance_arn = aws_dms_replication_instance.dms_replication_instance.replication_instance_arn 
  source_endpoint_arn     = aws_dms_endpoint.source_endpoint.endpoint_arn 
  target_endpoint_arn     = aws_dms_endpoint.target_endpoint.endpoint_arn 
  table_mappings          = file("table_mappings.json") #add your table mappings here 
}
