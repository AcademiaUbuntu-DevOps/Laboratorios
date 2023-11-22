provider "aws" {
  region = "us-east-1"
  shared_config_files      = ["/Users/su-directorio/.aws/conf"]
  shared_credentials_files = ["/Users/su-directorio/.aws/credentials"]
  profile                  = "su profile"
}
resource "aws_db_instance" "academia" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  identifier           = "academia-db"
  username             = "admin"
  password             = "password"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true

  vpc_security_group_ids = ["sg-03627557ea56a4f77"]
  db_subnet_group_name     = "cademia-db-subnet-group"
tags = {
Name = "mi-db-tf-3-confg"
}
}
