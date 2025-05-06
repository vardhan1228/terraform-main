#vpc-creation
provider "aws" {
  region = var.aws_region
  
}
variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "ap-south-1"
}
resource "aws_vpc" "dev_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true 
  tags = {
    Name = "dev_vpc"
  }
}

#IG
resource "aws_internet_gateway" "dev_ig" {
  vpc_id = aws_vpc.dev_vpc.id
  tags = {
    Name ="dev_ig"
  }

}

#subnet
resource "aws_subnet" "dev_public_subnet1" {
  cidr_block = "10.0.0.0/24"
  vpc_id = aws_vpc.dev_vpc.id
  availability_zone = "ap-south-1b"
  tags = {
    Name="dev_public_subnet1"
  }

}

resource "aws_subnet" "dev_public_subnet2" {
  cidr_block = "10.0.2.0/24"
  vpc_id = aws_vpc.dev_vpc.id
  availability_zone = "ap-south-1a"
  tags = {
    Name="dev_public_subnet2"
  }

}

#route table
resource "aws_route_table" "dev_public_route_table" {
    vpc_id = aws_vpc.dev_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.dev_ig.id
    }
    tags = {
      Name ="dev_public_rt"
    }
}

resource "aws_route_table_association" "dev_public_route_table_association" {
    subnet_id = aws_subnet.dev_public_subnet1.id
    route_table_id =  aws_route_table.dev_public_route_table.id
  
}

resource "aws_route_table_association" "dev_public_route_table_association2" {
    subnet_id = aws_subnet.dev_public_subnet2.id
    route_table_id =  aws_route_table.dev_public_route_table.id
  
}

#security group
resource "aws_security_group" "dev_sg" {
  vpc_id = aws_vpc.dev_vpc.id
  ingress{
    from_port = 22
    to_port = 22
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH"
  }
  ingress{
    from_port = 80
    to_port = 80
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP"
  }
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # restrict in production
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "dev_sg"
  }
}

resource "aws_key_pair" "dev_keypair" {
    key_name = "public"
    public_key = file("~/.ssh/id_ed25519.pub") 
  
}


#private server setup
# #elastic ip
# resource "aws_eip" "dev_eip" {
#   domain = "vpc"
# }

# #natgateway
# resource "aws_nat_gateway" "dev_nat" {
#   allocation_id = aws_eip.dev_eip.id
#   subnet_id     =aws_subnet.dev_public_subnet1.id

#   tags = {
#     Name = "dev_nat"
#   }
#   depends_on = [ aws_internet_gateway.dev_ig ]
# }

#private subnet
resource "aws_subnet" "dev_private_subnet1" {
  cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.dev_vpc.id
  availability_zone = "ap-south-1a"
  tags = {
    Name="dev_private_subnet1"
  }

}


resource "aws_subnet" "dev_private_subnet2" {
  cidr_block = "10.0.3.0/24"
  vpc_id = aws_vpc.dev_vpc.id
  availability_zone = "ap-south-1b"
  tags = {
    Name="dev_private_subnet2"
  }

}



#private route table
resource "aws_route_table" "dev_private_route_table" {
    vpc_id = aws_vpc.dev_vpc.id
    # route {
    #     cidr_block = "0.0.0.0/0"
    #     #gateway_id = aws_nat_gateway.dev_nat.id
    # }
    tags = {
      Name ="dev_private_rt"
    }
}

resource "aws_route_table_association" "dev_private_route_table_association1" {
    subnet_id = aws_subnet.dev_private_subnet1.id
    route_table_id =  aws_route_table.dev_private_route_table.id
  
}

resource "aws_route_table_association" "dev_private_route_table_association2" {
    subnet_id = aws_subnet.dev_private_subnet2.id
    route_table_id =  aws_route_table.dev_private_route_table.id
  
}


#private instance
# resource "aws_instance" "dev_private_instance" {
#     ami="ami-0f1dcc636b69a6438"
#     instance_type = "t2.micro"
#     subnet_id = aws_subnet.dev_private_subnet1.id
#     security_groups = [ aws_security_group.dev_sg.id ]
#     key_name = aws_key_pair.dev_keypair.key_name
#     tags = {
#       Name ="dev_private_server"
#     }
# }


#mysql db instance
#RDS subnet group
resource "aws_db_subnet_group" "rds_subnet_group" {
  subnet_ids = [aws_subnet.dev_public_subnet1.id, aws_subnet.dev_public_subnet2.id]
  name = "rds_subnet_group"
  tags = {
    Name = "rds_subnet_group"
  }
}

#RDS private subnet group
resource "aws_db_subnet_group" "rds_private_subnet_group" {
  subnet_ids = [aws_subnet.dev_private_subnet1.id, aws_subnet.dev_private_subnet2.id]
  name = "rds_private_subnet_group"
  tags = {
    Name = "rds_private_subnet_group"
  }
}


#Create a Secrets Manager secret
resource "aws_secretsmanager_secret" "db_secret" {
  name = "rds-db-secret2"
}

resource "aws_secretsmanager_secret_version" "db_secret_value" {
  secret_id     = aws_secretsmanager_secret.db_secret.id
  secret_string = jsonencode({
    username = "admin" #var.db_username
    password = "Adminpassword123" #var.db_password
  })
}


#Fetch the secret value

locals {
  db_credentials = jsondecode(aws_secretsmanager_secret_version.db_secret_value.secret_string)
}



#vpc_endpoint
resource "aws_vpc_endpoint" "secretsmanager" {
  vpc_id            = aws_vpc.dev_vpc.id
  service_name      = "com.amazonaws.${var.aws_region}.secretsmanager"
  vpc_endpoint_type = "Interface"
  subnet_ids        = aws_db_subnet_group.rds_private_subnet_group.subnet_ids
  security_group_ids = [aws_security_group.dev_sg.id]
  private_dns_enabled = true

  tags = {
    Name = "secretsmanager-endpoint"
  }
}
 

#RDS db instance
resource "aws_db_instance" "dev_mysql_db" {
  allocated_storage    = 20
  identifier           = "dev-mysql-db"
  db_name              = "dev"
  engine               = "mysql"
  engine_version       = "8.0.41"
  instance_class       = "db.t4g.micro"
  username             = local.db_credentials.username
  password             = local.db_credentials.password
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.rds_private_subnet_group.name
  publicly_accessible = false
  vpc_security_group_ids = [aws_security_group.dev_sg.id]
  tags = {
    Name = "dev_mysql_db"
  }
}



#public instance
resource "aws_instance" "dev_public_instance" {
    ami="ami-0f1dcc636b69a6438"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.dev_public_subnet1.id
    vpc_security_group_ids   = [ aws_security_group.dev_sg.id ]
    associate_public_ip_address = true
    key_name = aws_key_pair.dev_keypair.key_name
    iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
    tags = {
      Name ="dev_public_server"
    }  
  #  lifecycle {
  #   prevent_destroy = true
  #   # ignore_changes = [ tags ]
  #   # create_before_destroy = true
  # }
}

 output "db_endpoint" {
  value       ="mysql -h ${aws_db_instance.dev_mysql_db.address} -u ${local.db_credentials.username} -p${local.db_credentials.password}"
  description = "The endpoint to connect to the RDS instance"
   sensitive = true
}

# Deploy SQL remotely using null_resource + remote-exec
resource "null_resource" "remote_sql_exec" {
  depends_on = [aws_db_instance.dev_mysql_db, aws_instance.dev_public_instance, aws_vpc_endpoint.secretsmanager]

  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = file("~/.ssh/id_ed25519")
    host = aws_instance.dev_public_instance.public_ip
  }

  provisioner "file" {
    source      = "init.sql"
    destination = "/tmp/init.sql"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y mariadb105",
      "mysql -h ${aws_db_instance.dev_mysql_db.address} -u ${local.db_credentials.username} -p${local.db_credentials.password} < /tmp/init.sql"
    ]
  }

  triggers = {
    always_run = timestamp() #trigger every time apply 
  }
}

# 1. IAM Role with Admin Access
resource "aws_iam_role" "ec2_admin_role" {
  name = "ec2_admin_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

# 2. Attach AdministratorAccess policy
resource "aws_iam_role_policy_attachment" "admin_policy_attachment" {
  role       = aws_iam_role.ec2_admin_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# 3. Instance Profile
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_admin_instance_profile"
  role = aws_iam_role.ec2_admin_role.name
}