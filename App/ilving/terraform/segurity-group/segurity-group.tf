provider "aws" {
  region = "us-east-1"
  shared_config_files      = ["/Users/su-directorio/.aws/conf"]
  shared_credentials_files = ["/Users/su-directorio/.aws/credentials"]
  profile                  = "su profile"
}

resource "aws_security_group" "academia" {
  name        = "academia-security-group"
  description = "academia security group"

  vpc_id = "vpc-0eb25d59562f769e3"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
