provider "aws" {
  region = "us-east-1"
  shared_config_files      = ["/Users/su-directorio/.aws/conf"]
  shared_credentials_files = ["/Users/su-directorio/.aws/credentials"]
  profile                  = "su profile"
}

resource "aws_instance" "academia-vm" {
// funciona solo en us-east-1
ami = "ami-2757f631"
instance_type = "t2.micro"
tags = {
Name = "mi-server-tf-3-confg"
}
}

