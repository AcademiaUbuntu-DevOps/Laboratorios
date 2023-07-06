provider "aws" {
  region = "us-east-1"
  shared_config_files      = ["/Users/su-directorio/.aws/conf"]
  shared_credentials_files = ["/Users/su-directorio/.aws/credentials"]
  profile                  = "su profile"
}

resource "aws_db_subnet_group" "academia" {
  name        = "academia-db-subnet-group"
  description = "Academia DB subnet group"

  subnet_ids = [
    "subnet-0056d2b74ac1a1136",
    "subnet-07470de8040607e4f",
    "subnet-05d838186c56b5170"
  ]
}
